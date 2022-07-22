function cdgr
    if test (git rev-parse --is-inside-work-tree 2>/dev/null) = "true"
        cd (git rev-parse --show-toplevel)
    end
end
