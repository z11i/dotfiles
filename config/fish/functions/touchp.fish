function touchp -d "like `mkdir -p` but for files"
    if test -e "$argv"
        echo "$argv exists"
    else
        # https://unix.stackexchange.com/a/63105
        install -D /dev/null "$argv"
    end
end
