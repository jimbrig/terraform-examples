# Google Cloud Platform Terraform Examples

> *Terraform 0.13+*



## Contents



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
