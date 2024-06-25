set -Ux VENV_HOME $HOME/.virtualenvs

function lsvenv
    ls -l $VENV_HOME
end

function venv
    if [ -z "$argv" ]
        echo "Usage: venv <name>"
    else 
        . $VENV_HOME/"$argv[1]"/bin/activate.fish
    end
end

function mkvenv
    if [ -z "$argv" ]
        echo "Usage: mkvenv <name>"
    else 
        python -m venv $VENV_HOME/"$argv[1]"
    end
end

function rmvenv
    if [ -z "$argv" ]
        echo "Usage: rmvenv <name>"
    else 
        rm -r $VENV_HOME/"$argv[1]"
    end
end
