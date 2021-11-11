function path_append -a dir
  if test -d $dir
    set -gx PATH $PATH $dir
  end
end
