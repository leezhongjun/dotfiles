alias vi="nvim"
alias vim="nvim"
alias oldvim="nvim"
alias v="nvim"
alias tmux="tmux -u"

function gc
    git clone "https://github.com/$argv[1]"
end

function mc
    mkdir "$argv[1]" && cd "$argv[1]"
end

function yuc
    # yadm update and commit
    yadm rm -rf --cached . && yadm add ~/ && yadm commit
end
