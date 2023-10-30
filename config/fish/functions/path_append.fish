function path_append
    for dir in $argv
        if not contains $dir $PATH
            if test -d $dir
                set -gx PATH $PATH $dir
            end
        end
    end
end
