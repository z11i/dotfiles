function fdf --description 'fd filename and use fzf to choose'
    fd "$argv" | fzf
end
