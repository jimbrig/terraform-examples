# GCP Cloudrun Terraform Example - Secrets & Volumes

If your service requires the use of sensitive values, it is possible to store them in [Google Secret Manager](https://cloud.google.com/secret-manager) and reference those secrets in your service. This will prevent the values of those secrets from being exposed to anyone that might have access your service but not to the contents of the secrets.

Secrets can either be exposed as files through mounted volumes, or through environment variables. This can be configured through the `volumes` and `env` input variables respectively.

Note: Environment variables using the latest secret version will not be updated when a new version is added. Volumes using the latest version will have their contents automatically updated to reflect the latest secret version.

Refer to <https://cloud.google.com/run/docs/configuring/secrets> for further reading on secrets in Cloud Run.
