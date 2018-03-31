

## Create a namespace, role, account and additional token for the Gitlab runner

https://kubernetes.io/docs/admin/service-accounts-admin/

    kubectl apply -f ./k8s-setup/
    kubectl -n gitlab describe secret gitlab-serviceaccount-token


## Add details of the Kubernetes cluster to Gitlab?

Note this doesn't seem to work, maybe ignore?

https://gitlab.com/help/user/project/clusters/index#adding-an-existing-kubernetes-cluster


## Install GitLab runner

https://docs.gitlab.com/ee/install/kubernetes/gitlab_runner_chart.html#installing-gitlab-runner-using-the-helm-chart

Set the `runnerRegistrationToken` in gitlab-runner/helm-config.yaml and deploy

    helm repo add gitlab https://charts.gitlab.io
    helm install --namespace gitlab --name gitlab-runner -f gitlab-runner/helm-config.yaml gitlab/gitlab-runner
