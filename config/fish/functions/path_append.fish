function path_append -a dir
    if not contains $dir $PATH
        if test -d $dir
            set -gx PATH $PATH $dir
        end
    end
end
