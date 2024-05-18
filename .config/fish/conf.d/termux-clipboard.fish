function fish_clipboard_copy
    set -l cmdline
    if isatty stdin
        # Copy the current selection, or the entire commandline if that is empty.
        # Don't use `string collect -N` here - `commandline` adds a newline.
        set cmdline (commandline --current-selection | string collect)
        test -n "$cmdline"; or set cmdline (commandline | string collect)
    else
        # Read from stdin
        while read -lz line
            set -a cmdline $line
        end
    end

    if type -q termux-clipboard-get
        printf '%s' $cmdline | termux-clipboard-set
    else if type -q pbcopy
        printf '%s' $cmdline | pbcopy
    else if set -q WAYLAND_DISPLAY; and type -q wl-copy
        printf '%s' $cmdline | wl-copy
    else if set -q DISPLAY; and type -q xsel
        printf '%s' $cmdline | xsel --clipboard
    else if set -q DISPLAY; and type -q xclip
        printf '%s' $cmdline | xclip -selection clipboard
    else if type -q clip.exe
        printf '%s' $cmdline | clip.exe
   end

    # Copy with OSC 52; useful if we are running in an SSH session or in
    # a container.
    if type -q base64
        if not isatty stdout
            echo "fish_clipboard_copy: stdout is not a terminal" >&2
            return 1
        end
        set -l encoded (printf %s $cmdline | base64 | string join '')
        printf '\e]52;c;%s\a' "$encoded"
        # tmux requires user configuration to interpret OSC 52 on stdout.
        # Luckily we can still make this work for the common case by bypassing
        # tmux and writing to its underlying terminal.
        if set -q TMUX
            set -l tmux_tty (tmux display-message -p '#{client_tty}')
            or return 1
            # The terminal might not be writable if we switched user.
            if test -w $tmux_tty
                printf '\e]52;c;%s\a' "$encoded" >$tmux_tty
            end
        end
    end
end

function fish_clipboard_paste
    set -l data
    if type -q termux-clipboard-get
        set data (termux-clipboard-get | string collect -N)
    else if type -q pbpaste
        set data (pbpaste 2>/dev/null | string collect -N)
    else if set -q WAYLAND_DISPLAY; and type -q wl-paste
        set data (wl-paste -n 2>/dev/null | string collect -N)
    else if set -q DISPLAY; and type -q xsel
        set data (xsel --clipboard | string collect -N)
    else if set -q DISPLAY; and type -q xclip
        set data (xclip -selection clipboard -o 2>/dev/null | string collect -N)
    else if type -q powershell.exe
        set data (powershell.exe Get-Clipboard | string trim -r -c \r | string collect -N)
    end

    # Issue 6254: Handle zero-length clipboard content
    if not string length -q -- "$data"
        return 1
    end

    if not isatty stdout
        # If we're redirected, just write the data *as-is*.
        printf %s $data
        return
    end

    # Also split on \r, otherwise it looks confusing
    set data (string split \r -- $data | string split \n)

    # If the current token has an unmatched single-quote,
    # escape all single-quotes (and backslashes) in the paste,
    # in order to turn it into a single literal token.
    #
    # This eases pasting non-code (e.g. markdown or git commitishes).
    set -l quote_state (__fish_tokenizer_state -- (commandline -ct | string collect))
    if contains -- $quote_state single single-escaped
        if status test-feature regex-easyesc
            set data (string replace -ra "(['\\\])" '\\\\$1' -- $data)
        else
            set data (string replace -ra "(['\\\])" '\\\\\\\$1' -- $data)
        end
    else if not contains -- $quote_state double double-escaped
        and set -q data[2]
        # Leading whitespace in subsequent lines is unneded, since fish
        # already indents. Also gets rid of tabs (issue #5274).
        set -l tmp
        for line in $data
            switch $quote_state
                case normal
                    set -a tmp (string trim -l -- $line)
                case single single-escaped double double-escaped escaped
                    set -a tmp $line
            end
            set quote_state (__fish_tokenizer_state -i $quote_state -- $line)
        end
        set data $data[1] $tmp[2..]
    end
    if not string length -q -- (commandline -c)
        # If we're at the beginning of the first line, trim whitespace from the start,
        # so we don't trigger ignoring history.
        set data[1] (string trim -l -- $data[1])
    end

    if test -n "$data"
        commandline -i -- $data
    end
end
