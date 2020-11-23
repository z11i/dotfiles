function gcssh
    set --local user (set -q GC_USER && echo $GC_USER || echo $USER)
    set --local ip (gcloud compute instances list | fzf | awk '{print $4}')
        timeout 3 ssh $user@$ip ||
            echo "ssh $user@$ip"; echo "failed, perhaps VPN needed?"
end