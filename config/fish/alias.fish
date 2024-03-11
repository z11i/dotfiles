## Always prefer abbr to alias:
## https://www.sean.sh/log/when-an-alias-should-actually-be-an-abbr/
abbr a1 'awk \'{print $1}\''
abbr a2 'awk \'{print $2}\''
abbr a3 'awk \'{print $3}\''
abbr b bazel
abbr bb 'bazel build'
abbr bt 'bazel test'
abbr br 'bazel run'
abbr cdtemp 'cd (mktemp -d)'
abbr cg cargo
abbr clean "clear && printf '\e[3J'"
#abbr crc32 "python -c 'import sys;import zlib;print(zlib.crc32(sys.stdin.read())%(1<<32))'"
abbr crc32d 'gzip -c | tail -c8 | od -t d4 -N 4 -A n'
abbr crc32x 'gzip -c | tail -c8 | od -t x4 -N 4 -A n'
abbr d docker
abbr dc 'docker compose'
abbr dr 'docker run -it --rm'
abbr de 'docker exec -it'
abbr l eza
abbr ll 'eza -l'
abbr lla 'eza -la'
abbr g git
abbr ge 'gh copilot explain'
abbr gs 'gh copilot suggest'
abbr h helm
abbr k kubectl
abbr ktx kubectl ctx
abbr kns kubectl ns
abbr kip 'kubectl get pods (kubectl get po | fzf | awk \'{print $1}\') -o=jsonpath=\'{.status.podIP}\''
abbr ke kubectl exec -it '(kubectl get po | fzf | awk \'{print $1}\')' -- bash
abbr kp kubectl get po
abbr kp1 'kubectl get po | fzf | awk \'{print $1}\''
abbr kr 'kubectl run my-container-name -it --image=alpine --command -- sh'
abbr mkdir 'mkdir -p'
abbr nsh 'nix-shell --command fish'
#alias ssh='kitty +kitten ssh'
abbr tm 'tmux new -A -s main'
abbr uuid 'echo -n (uuidgen) | pbcopy'
abbr v nvim
abbr vim nvim
