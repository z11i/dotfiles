function tree -a depth -d 'tree view of directory'
    switch "$depth"
        case ''
            eza -TlL2 --time-style=iso --git-ignore
        case \*
            eza -TlL"$depth" --time-style=iso --git-ignore
    end
end
