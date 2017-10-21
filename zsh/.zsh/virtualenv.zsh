if [[ -f '/usr/local/bin/virtualenvwrapper.sh' ]]; then
    export WORKON_HOME=$HOME/.venvs
    export PROJECT_HOME=$HOME/Code
    source /usr/local/bin/virtualenvwrapper.sh
fi
