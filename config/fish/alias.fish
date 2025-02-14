## Always prefer abbr to alias:
## https://www.sean.sh/log/when-an-alias-should-actually-be-an-abbr/

#abbr crc32d 'gzip -c | tail -c8 | od -t d4 -N 4 -A n'
#abbr crc32x 'gzip -c | tail -c8 | od -t x4 -N 4 -A n'

abbr a1 'awk \'{print $1}\''
abbr a2 'awk \'{print $2}\''
abbr a3 'awk \'{print $3}\''
abbr b bazel
abbr bb 'bazel build'
abbr br 'bazel run'
abbr bt 'bazel test'
abbr cdtemp 'cd (mktemp -d)'
abbr cg cargo
abbr clean "clear && printf '\e[3J'"
abbr d docker
abbr dc 'docker compose'
abbr de 'docker exec -it'
abbr dr 'docker run -it --rm'
abbr g git
abbr ga 'git add'
abbr gd 'git diff'
abbr gf 'git f3'
abbr ghe 'gh copilot explain'
abbr ghs 'gh copilot suggest'
abbr gs 'git status'
abbr h helm
abbr jql "jq -cR 'fromjson? // .'"
abbr k kubectl
abbr ke kubectl exec -it '(kubectl get po | fzf | awk \'{print $1}\')' -- bash
abbr kip 'kubectl get pods (kubectl get po | fzf | awk \'{print $1}\') -o=jsonpath=\'{.status.podIP}\''
abbr kl 'kubectl logs -f po/[] -c [] | bat --paging=never -l=json'
abbr kns kubectl ns
abbr kp kubectl get po
abbr kp1 'kubectl get po | fzf | awk \'{print $1}\''
abbr kr 'kubectl run my-container-name -it --image=alpine --command -- sh'
abbr ktx kubectl ctx
abbr l eza
abbr lg 'eza -l --git'
abbr ll 'eza -l'
abbr lla 'eza -la'
abbr mkdir 'mkdir -p'
abbr n nix
abbr nd 'nix develop -c fish'
abbr ne nix-env
abbr tm 'tmux new -A -s main'
abbr uuid 'echo -n (uuidgen) | pbcopy'
abbr v nvim
abbr vim nvim
