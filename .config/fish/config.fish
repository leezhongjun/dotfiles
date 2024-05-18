if status is-interactive
    # Start tmux
    if not set -q TMUX
        if tmux -u has session -t home
            exec tmux -u attach session -t home
        else
            tmux -u new-session -s home
        end
    end
    
    alias vi="nvim"
    alias vim="nvim"
    alias oldvim="nvim"
    alias v="nvim"
    alias p="termux-clipboard-get"
    alias c="termux-clipboard-set"
    bind -M insert \cf accept-autosuggestion
    bind -M insert \cc 'set fish_bind_mode default; commandline -f repaint'
    starship init fish | source
    clear
end
