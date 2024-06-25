if status is-interactive
    # Start tmux
    # if not set -q TMUX
    #     if tmux -u has-session -t home
    #         exec tmux -u attach-session -t home
    #     else
    #         tmux -u new-session -s home
    #     end
    # end
    source ~/.config/fish/bind.fish
    starship init fish | source
    clear
end

function update_cwd --on-event fish_postexec
    pwd > /tmp/whereami
end

source ~/.config/fish/alias.fish
