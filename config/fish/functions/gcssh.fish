function gcssh
    set --local user (set -q GC_USER && echo $GC_USER || echo $USER)
    set --local ip (gcloud compute instances list | fzf | awk '{print $4}')
    ping -W 1 -c 1 $ip >/dev/null &&
        ssh $user@$ip ||
        echo "cannot connect to $ip, perhaps VPN needed?"
end