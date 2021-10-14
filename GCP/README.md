# Google Cloud Platform Terraform Examples

> *Terraform 0.13+*

This repo houses experimentation with provisioning GCP infrastructure using Terraform. 

It is primarilly focused on Cloud Run.

Cloud Run, which is built using KNative, is the best serverless, kubernetes-driven container run-time managed service on the market.

Related: <https://github.com/jimbrig/terraform-azure>

## Examples

- Serverless:

  - [Cloud Run](Cloud-Run/)
    - [Cloud-Run-Basic](Cloud-Run/Cloud-Run-Basic/)
    - [Cloud-Run-EnvVars](Cloud-Run/Cloud-Run-EnvVars/)
    - [Cloud-Run-NoAuth](Cloud-Run/Cloud-Run-NoAuth/)
    - [Cloud-Run-PostgreSQL](Cloud-Run/Cloud-Run-SQL-PostgreSQL/)
    - [Cloud-Run-SQL](Cloud-Run/Cloud-Run-SQL/)
    - [Cloud-Run-Secret-Volumes](Cloud-Run/Cloud-Run-Secret-Volumes/)
    - [Cloud-Run-Secrets](Cloud-Run/Cloud-Run-Secrets/)
    - [Cloud-Run-Traffic-Split](Cloud-Run/Cloud-Run-Traffic-Split)

- Compute, Servers, VMs, and Networking:
  - [Compute with Projects](Projects)
  - [Compute Network](Compute-Network-Simple)
  - [Compute Private Catalog](Private-Catalog)

## Reference

- Link: <https://registry.terraform.io/providers/hashicorp/google/latest>

- Documentation: <https://registry.terraform.io/providers/hashicorp/google/latest/docs>

## Getting Started

- First, Create a project in the Google Cloud Console and set up billing on that project. Any examples in this guide will be part of the GCP "always free" tier.

## How to Use GCP Provider

- To install this provider, copy and paste this code into your Terraform configuration.
- Then, run `terraform init`.

```terraform
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.78.0"
    }
  }
}

provider "google" {
  # Configuration options
}
```
