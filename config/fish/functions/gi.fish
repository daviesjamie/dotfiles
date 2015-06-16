function gi -d "command-line interface to gitignore.io"
    if test (count $argv) -eq 0
        echo "Usage: gi [<types>]|list|update-completions"
        return 1
    end

    if test $argv[1] = 'update-completions'
        _update_gi_completions
        return $status
    end

    set -l params (echo $argv|tr ' ' ',')
    curl -s https://www.gitignore.io/api/$params
end
