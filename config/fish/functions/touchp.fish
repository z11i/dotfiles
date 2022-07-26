function touchp -d "like `mkdir -p` but for files"
    # https://unix.stackexchange.com/a/63105
    install -D /dev/null "$argv"
end
