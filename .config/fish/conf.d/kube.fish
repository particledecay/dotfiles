function kube_shell
  set -l ns
  if test (count $argv) -lt 2
    set ns "--namespace="$argv[1]
  end
  kubectl get pod $ns kube-shell 2>/dev/null && kubectl delete pod $ns kube-shell
  kubectl run -it --rm --restart=Never $ns --image=bradbeam/utility:latest kube-shell
end

function kube_bad_pods
  set -l bad_pods (kubectl get pods -A -o wide --ignore-not-found | awk '$4 !~ /(Running|Completed)/')

  if test -z "$bad_pods[2..-1]"
    echo "no bad pods found"
    return 0
  end

  echo "$bad_pods[1]"
  string join \n $bad_pods[2..-1] | sort -k 8,8 -k 1,1 -k 2,2
end

function kube_endpoints
  set -l svc $argv[1]

  kubectl get endpoints $svc -o json | jq -r '.subsets[].addresses[].ip' | sort -V
end

function kube_logs
  set -l app_name $argv[1]

  kubectl logs --tail -1 -l app.kubernetes.io/name=$app_name $argv[2..]
end
