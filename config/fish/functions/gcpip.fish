function gcpip
    gcloud compute instances list | fzf | awk '{print $4}'
end