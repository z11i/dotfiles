function path_prepend -a dir
    if not contains $dir $PATH
        if test -d $dir
            set -gx PATH $dir $PATH
        end
    end
end
