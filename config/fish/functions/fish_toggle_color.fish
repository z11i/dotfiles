function fish_toggle_color
    if test $FISH_COLORSCHEME = 'BRIGHT'
        set -U FISH_COLORSCHEME DARK
        cp ~/.config/fish/colors_dark.fish ~/.config/fish/colors.fish
    else
        set -U FISH_COLORSCHEME BRIGHT
        cp ~/.config/fish/colors_bright.fish ~/.config/fish/colors.fish
    end
    sourceadd ~/.config/fish/colors.fish
end