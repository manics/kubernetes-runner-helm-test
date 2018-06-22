# Kubernetes Secret

Helm chart to manage Kubernetes secrets

## Values
The only value is `data` which is a dictionary of key value pairs where all values are base64 encoded as required by Kubernetes Secrets.
Base64 encoding is not done automatically because not are values can be represented in plain text format.
