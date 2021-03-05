function gcpinstances
    set ctx (gcloud config get-value project)
    set fn "/tmp/gcp_instances_$ctx"
    if not test -e "$fn"
        gcloud compute instances list >"$fn"
    end
    cat "$fn"
end