# Test GitLab continuous deployment

This is a temporary repository for testing GitLab continuous deployment with GitHub.


## Create a `CI/CD for external repo` project on GitLab

https://docs.gitlab.com/ee/ci/ci_cd_for_external_repos/github_integration.html

All configuration and code changes should be done in the GitHub repository.
The GitLab repository is purely a mirror for integration with CI/CD.


## Create a namespace, role, account and additional token for the Gitlab runner

https://kubernetes.io/docs/admin/service-accounts-admin/

    kubectl apply -f ./k8s-setup/
    kubectl -n gitlab describe secret gitlab-serviceaccount-token


## Add details of the Kubernetes cluster to Gitlab?

Note this doesn't seem to work, maybe ignore?

https://gitlab.com/help/user/project/clusters/index#adding-an-existing-kubernetes-cluster


## Install GitLab runner

https://docs.gitlab.com/ee/install/kubernetes/gitlab_runner_chart.html#installing-gitlab-runner-using-the-helm-chart

Go to the `Runners settings ` tab under https://gitlab.com/USERNAME/REPOSITORY/settings/ci_cd.
Get the Runner registration token from and set `runnerRegistrationToken` in gitlab-runner/helm-config.yaml to this value
Deploy the GitLab runner:

    helm repo add gitlab https://charts.gitlab.io
    helm install --namespace gitlab --name gitlab-runner -f gitlab/gitlab-runner gitlab-runner/helm-config.yaml

Ensure you `Disable shared Runners` since this is used for a deployment so shared GitLab runner cannot be used.

Setup Secret variables referenced in [`.gitlab-ci.yml`](.gitlab-ci.yml):
- `SECRET_JUPYTERHUB_PROXY_TOKEN`
