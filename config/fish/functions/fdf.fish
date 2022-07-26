function fdf -d 'fd filename and use fzf to choose'
    fd "$argv" | fzf
end
