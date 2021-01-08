function gcpssh
    set --local user (set -q GC_USER && echo $GC_USER || echo $USER)
    set --local ip (gcloud compute instances list | fzf | awk '{print $4}')
    nc -G 1 -w 1 $ip 22 && ssh $user@$ip || echo "ssh $user@$ip failed, perhaps VPN needed?"
end