## Always prefer abbr to alias:
## https://www.sean.sh/log/when-an-alias-should-actually-be-an-abbr/
abbr c 'cargo'
abbr clean "clear && printf '\e[3J'"
#abbr crc32 "python -c 'import sys;import zlib;print(zlib.crc32(sys.stdin.read())%(1<<32))'"
abbr crc32d 'gzip -c | tail -c8 | od -t d4 -N 4 -A n'
abbr crc32x 'gzip -c | tail -c8 | od -t x4 -N 4 -A n'
abbr dk 'docker'
abbr dkc 'docker-compose'
abbr g 'git'
abbr k kubectl
abbr mkdir 'mkdir -p'
abbr nsh 'nix-shell --command fish'
alias ssh='kitty +kitten ssh'
abbr tm 'tmux new -A -s main'
abbr uuid 'echo -n (uuidgen) | pbcopy'
abbr vim 'nvim'
