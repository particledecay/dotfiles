function k8s_shell
  set -l ns
  if test (count $argv) -lt 2
    set ns "--namespace={$argv[1]}"
  end
  kubectl get pod $ns k8s-shell 2>/dev/null && kubectl delete pod $ns k8s-shell
  kubectl run -it --rm --restart=Never $ns --image=bradbeam/utility:latest k8s-shell
end
