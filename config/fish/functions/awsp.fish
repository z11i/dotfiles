function awsp
    set -gx AWS_PROFILE (awk '/\[profile/ {print substr($2, 1, length($2)-1)}' ~/.aws/config | fzf)
end
