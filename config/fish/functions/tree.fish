function tree -a depth -d 'tree view of directory'
    switch "$depth"
        case ''
            exa -TlL2 --time-style=iso
        case \*
            exa -TlL"$depth" --time-style=iso
    end
end
