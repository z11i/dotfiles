function fish_toggle_color
    if test $FISH_COLORSCHEME = 'BRIGHT'
        set -U FISH_COLORSCHEME DARK
        echo 'using dark colorscheme'
        cp -f ~/.config/fish/colors_dark.fish ~/.config/fish/colors.fish
    else
        set -U FISH_COLORSCHEME BRIGHT
        echo 'using bright colorscheme'
        cp -f ~/.config/fish/colors_bright.fish ~/.config/fish/colors.fish
    end
    sourceadd ~/.config/fish/colors.fish
end