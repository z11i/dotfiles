function fish_toggle_color
    if test (count $argv) -lt 1
        if test $FISH_COLORSCHEME = 'light'
            set -U FISH_COLORSCHEME 'dark'
            echo 'using dark colorscheme'
            cp -f ~/.config/fish/colors_dark.fish ~/.config/fish/colors.fish
        else
            set -U FISH_COLORSCHEME 'light'
            echo 'using light colorscheme'
            cp -f ~/.config/fish/colors_light.fish ~/.config/fish/colors.fish
        end
    else if test $argv = 'light'; or test $argv = 'dark'
        set -U FISH_COLORSCHEME $argv
        cp -f ~/.config/fish/colors_$argv.fish ~/.config/fish/colors.fish
    end

    sourceadd ~/.config/fish/colors.fish
end
