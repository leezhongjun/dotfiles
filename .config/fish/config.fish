if status is-interactive
    source ~/.config/fish/bind.fish
    starship init fish | source
    clear
end

function update_cwd --on-event fish_postexec
    pwd > /tmp/whereami
end

eval $(/opt/homebrew/bin/brew shellenv)

source ~/.config/fish/alias.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /usr/local/Caskroom/miniconda/base/bin/conda
    eval /usr/local/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/usr/local/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/usr/local/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/usr/local/Caskroom/miniconda/base/bin" $PATH
    end
end
# <<< conda initialize <<<

