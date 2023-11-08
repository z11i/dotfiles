#!/usr/bin/env fish

function update-neovim-nightly
    switch (uname)
        case Darwin
            true
        case '*'
            echo (uname) not supported
            exit 1
    end
    cd (mktemp -d)
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
    tar xzf nvim-macos.tar.gz
    mkdir -p ~/.local/bin
    if test -e ~/.local/bin/nvim-macos
        rm -rf ~/.local/bin/nvim-macos
    end
    mv ./nvim-macos ~/.local/bin/nvim-macos
    if test -e ~/.local/bin/nvim
        rm ~/.local/bin/nvim
    end
    ln -s ~/.local/bin/nvim-macos/bin/nvim ~/.local/bin/nvim
end
