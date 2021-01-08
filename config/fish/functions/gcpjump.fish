function gcpjump -a remote_ip remote_port local_port
    if test (count $argv) -lt 1
        echo 'Usage: gcpjump <remote_ip> <remote_port> <local_port>'
        echo '       This binds a connection on local_port to <ip>:<remote_port> via a remote jumpbox.'
        return
    end
    set --local user (set -q GC_USER && echo $GC_USER || echo $USER)
    set --local jumpIP (gcloud --format='value(networkInterfaces[0].networkIP)' compute instances list --filter='labels.app=cloud-sql-jumpbox')
    test -n "$jumpIP" || begin
        echo 'unable to find jumpbox IP'
        return 1
    end
    echo "jumpIP: $jumpIP"
    set --local cmd "ssh -L $local_port:$remote_ip:$remote_port $user@$jumpIP"
    nc -G 1 -w 1 $jumpIP 22 || begin
        echo "did you connect to VPN?"
        return 1
    end
    fish -c "echo $cmd; $cmd"
end