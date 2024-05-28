if status is-interactive
    # Start tmux
    if not set -q TMUX
        if tmux -u has-session -t home
            exec tmux -u attach-session -t home
        else
            tmux -u new-session -s home
        end
    end
    source ~/.config/fish/bind.fish
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end
    starship init fish | source
    clear
end

source ~/.config/fish/alias.fish
