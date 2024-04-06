function fish_toggle_color

    function dark
        set -U FISH_COLORSCHEME dark
        yes | fish_config theme save 'Catppuccin Frappe'
        if type -q vivid
            set -Ux LS_COLORS (vivid generate catppuccin-mocha)
            set -Ux EZA_COLORS (vivid generate catppuccin-mocha)
        end
    end

    function light
        set -U FISH_COLORSCHEME light
        yes | fish_config theme save 'Catppuccin Latte'
        if type -q vivid
            set -Ux LS_COLORS (vivid generate catppuccin-latte)
            set -Ux EZA_COLORS (vivid generate catppuccin-latte)
        end
    end

    if test (count $argv) -lt 1
        if set -q FISH_COLORSCHEME
            if test $FISH_COLORSCHEME = dark
                light
            else
                dark
            end
        else
            if test (ostheme) = dark
                light
            else
                dark
            end
        end
    else
        if $argv[1] = light
            light
        else
            dark
        end
    end

    sourceadd ~/.config/fish/colors.fish
end
