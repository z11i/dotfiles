#!/usr/bin/env fish

function update-neovim-nightly
    switch (uname)
        case Darwin
            switch (uname -p)
                case i386
                    set -f file nvim-macos-x86_64.tar.gz
                case 'arm*'
                    set -f file nvim-macos-arm64.tar.gz
                case '*'
                    echo (uname -p) not supported
                    return 1
            end
        case '*'
            echo (uname) not supported
            return 1
    end
    cd (mktemp -d)
    wget https://github.com/neovim/neovim/releases/download/nightly/$file -O nvim-macos.tar.gz
    mkdir -p nvim-macos; and tar xzf nvim-macos.tar.gz -C nvim-macos --strip-components 1
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
