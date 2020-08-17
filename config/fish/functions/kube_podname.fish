function kube_podname -a depl
   kubectl describe rs (kubectl describe deployment/$depl | awk '/NewReplicaSet:/ {print $2}') | awk '/Created pod:/ {pod=$7} END {print pod}'
end