# Terraform Examples Repository

> NOTE: Still a major *Work In Progress*, however, most work has been done with GCP Cloud Run in the [GCP/Cloud-Run Directory](https://github.com/jimbrig/terraform-examples/tree/main/GCP/Cloud-Run)

This repository is used to house various implementations of utilizing [Terraform]() to provision and configure *Infrastructure as Code* across various scenarios and providers.

## Contents

- [Azure](./Azure): Azure Examples
- [GCP](./GCP): Google Cloud Platform Examples
  - [GCP/Cloud-Run](./GCP/Cloud-Run): GCP Cloun Run Examples
  - [GCP/Cloud-Build](./GCP/Cloud-Build): GCP Cloud Build Examples
- [Kubernetes](./Kubernetes): Kubernetes examples
- [Docker](./Docker): Docker examples


## Notes

### How Terraform, providers and modules work

**Terraform** provisions, updates, and destroys infrastructure resources such as physical machines, VMs, network switches, containers, and more.

**Configurations** are code written for Terraform, using the human-readable HashiCorp Configuration Language (HCL) to describe the desired state of infrastructure resources.

**Providers** are the plugins that Terraform uses to manage those resources. Every supported service or infrastructure platform has a provider that defines which resources are available and performs API calls to manage those resources.

**Modules** are reusable Terraform configurations that can be called and configured by other configurations. Most modules manage a few closely related resources from a single provider.

**The Terraform Registry** makes it easy to use any provider or module. To use a provider or module from this registry, just add it to your configuration; when you run `terraform init`, Terraform will automatically download everything it needs.

### Reference

- [Browse Providers | Terraform Registry](https://registry.terraform.io/browse/providers)
- [Browse Modules | Terraform Registry](https://registry.terraform.io/browse/modules)
- [hashicorp/google | Terraform Registry](https://registry.terraform.io/providers/hashicorp/google/latest)
- [hashicorp/azurerm | Terraform Registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- [hashicorp/kubernetes | Terraform Registry](https://registry.terraform.io/providers/hashicorp/kubernetes/latest)
- [Reuse Configuration with Modules | Terraform - HashiCorp Learn](https://learn.hashicorp.com/collections/terraform/modules?_ga=2.226448728.35528487.1628200791-1888930736.1628200791)
- [Introduction to Infrastructure as Code with Terraform | Terraform - HashiCorp Learn](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?_ga=2.226448728.35528487.1628200791-1888930736.1628200791)

***

![](https://cdn-images-1.medium.com/max/1200/1*9-ILOQ1Yxautyc_uIguhVw.png)

