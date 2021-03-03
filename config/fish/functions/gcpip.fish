function gcpip
    gcpinstances | fzf | awk '{print $4}'
end