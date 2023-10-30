function path_prepend
    for dir in $argv
        if not contains $dir $PATH
            if test -d $dir
                set -gx PATH $dir $PATH
            end
        end
    end
end
