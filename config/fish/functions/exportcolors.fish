#!/usr/bin/env fish

function exportcolors
    set -u colorfile ~/.config/fish/colors.fish
    echo "#!/usr/bin/env fish" > $colorfile
    echo "" >> $colorfile
    chmod +x $colorfile

    for i in (set -n | string match 'fish*_color*')
        echo "set $i $$i" >> $colorfile
    end
end