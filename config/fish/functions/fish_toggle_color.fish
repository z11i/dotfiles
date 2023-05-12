function fish_toggle_color
    if test (count $argv) -lt 1
        if test $FISH_COLORSCHEME = light
            set -U FISH_COLORSCHEME dark
            echo 'using dark colorscheme'
            yes | fish_config theme save 'Catppuccin Frappe'
        else
            set -U FISH_COLORSCHEME light
            echo 'using light colorscheme'
            yes | fish_config theme save 'Catppuccin Latte'
        end
    end

    sourceadd ~/.config/fish/colors.fish
end
