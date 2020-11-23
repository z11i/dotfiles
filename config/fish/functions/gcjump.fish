function gcjump -a dbIP port
    set --local user (set -q GC_USER && echo $GC_USER || echo $USER)
    set --local jumpIP (gcloud --format='value(networkInterfaces[0].networkIP)' compute instances list --filter='labels.app=cloud-sql-jumpbox')
    set -q jumpIP || begin; echo 'unable to find jumpbox IP'; exit 1; end
    set --local cmd "ssh -L $port:$dbIP:5432 $user@$jumpIP"
    echo $cmd
    fish -c "$cmd"
end