function mac_bundle_id
    # Check if the operating system is macOS
    if test (uname) != Darwin
        echo "This function is only available on macOS"
        return 1
    end

    # Check if exactly one argument is provided
    if test (count $argv) -ne 1
        echo "Usage: mac_bundle_id <app_name>"
        return 1
    end

    # Attempt to retrieve the bundle ID using osascript
    set -l bundle_id (osascript -e "id of app \"$argv[1]\"")

    # If osascript fails, attempt to retrieve using Spotlight metadata (mdls)
    if test -z "$bundle_id"
        set -l app_path "/Applications/$argv[1].app"
        set bundle_id (mdls -name kMDItemCFBundleIdentifier -r $app_path ^/dev/null)
    end

    # Check if a bundle ID was found and print it, else print an error message
    if test -n "$bundle_id"
        echo $bundle_id
    else
        echo "Bundle ID for $argv[1] could not be found."
        return 1
    end
end
