# Cloud SQL Terraform Modules

- Link to [Terraform Registry `sql-db` Module](https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/latest)

## Requirements

### Installation Dependencies

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin v2.5.x

The following dependency must be available for SQL Server module:

- [Terraform Provider Beta for GCP](https://github.com/terraform-providers/terraform-provider-google-beta) plugin v3.10

### Configure a Service Account

In order to execute this module you must have a Service Account with the following:

#### Roles

- Cloud SQL Admin: `roles/cloudsql.admin`
- Compute Network Admin: `roles/compute.networkAdmin`

### Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Cloud SQL Admin API: `sqladmin.googleapis.com`

In order to use Private Service Access, required for using Private IPs, you must activate
the following APIs on the project where your VPC resides:

- Cloud SQL Admin API: `sqladmin.googleapis.com`
- Compute Engine API: `compute.googleapis.com`
- Service Networking API: `servicenetworking.googleapis.com`
- Cloud Resource Manager API: `cloudresourcemanager.googleapis.com`

#### Service Account Credentials

You can pass the service account credentials into this module by setting the following environment variables:

- `GOOGLE_CREDENTIALS`
- `GOOGLE_CLOUD_KEYFILE_JSON`
- `GCLOUD_KEYFILE_JSON`

See more [details](https://www.terraform.io/docs/providers/google/provider_reference.html#configuration-reference).

## Provision Instructions

This module has no root configuration. A module with no root configuration cannot be used directly.

Copy and paste into your Terraform configuration, insert the variables, and run `terraform init`:

For MySQL :

```terraform
module "sql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "4.0.0"
}
```

or for PostgreSQL :

```terraform
module "sql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "4.0.0"
}
```

or for MSSQL Server :

```terraform
module "sql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mssql"
  version = "4.0.0"
}
```

## PostgreSQL

Three options for connecting:

1. IP Range
2. Private IP
3. Public IP


