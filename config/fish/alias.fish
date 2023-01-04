## Always prefer abbr to alias:
## https://www.sean.sh/log/when-an-alias-should-actually-be-an-abbr/
abbr cg 'cargo'
abbr clean "clear && printf '\e[3J'"
#abbr crc32 "python -c 'import sys;import zlib;print(zlib.crc32(sys.stdin.read())%(1<<32))'"
abbr crc32d 'gzip -c | tail -c8 | od -t d4 -N 4 -A n'
abbr crc32x 'gzip -c | tail -c8 | od -t x4 -N 4 -A n'
abbr d 'docker'
abbr dc 'docker-compose'
abbr dr 'docker run -it --rm'
abbr de 'docker exec -it'
abbr e 'exa'
abbr ee 'exa -l'
abbr eee 'exa -la'
abbr g 'git'
abbr h 'helm'
abbr k kubectl
abbr ktx 'kubectx'
abbr kns 'kubens'
abbr ke kubectl exec -it po/'(kubectl get po | fzf | awk \'{print $1}\')' -- bash
abbr kp kubectl get po
abbr kr kubectl run _ -it --image=_ --command -- 
abbr mkdir 'mkdir -p'
abbr nsh 'nix-shell --command fish'
#alias ssh='kitty +kitten ssh'
abbr tm 'tmux new -A -s main'
abbr uuid 'echo -n (uuidgen) | pbcopy'
abbr v 'nvim'
abbr vim 'nvim'
