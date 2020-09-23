function gcctx
    gcloud config set project (gcloud projects list | fzf | awk '{print $1}')
end