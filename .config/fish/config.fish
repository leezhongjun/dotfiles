source ~/.config/fish/alias.fish

if status is-interactive
    # Start tmux
    if not set -q TMUX
        if tmux has-session -t home
            exec tmux attach-session -t home
        else
            tmux new-session -s home
        end
    end
    source ~/.config/fish/bind.fish
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end
    starship init fish | source
    clear
end
