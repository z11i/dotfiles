function ostheme --description 'Get the current OS theme, returns either "light" or "dark"'
    if test (uname) != Darwin
        echo "Non macOS is not yet supported"
        return 1
    end

    switch (defaults read ~/Library/Preferences/.GlobalPreferences.plist AppleInterfaceStyle 2>/dev/null; or echo Light)
        case Dark
            echo dark
        case Light
            echo light
        case *
            echo Light
    end
end
