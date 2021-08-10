# Cloud Run Service - Basic - Terraform

> NOTE: Terraform provisions real GCP resources, so anything you create in this session will be billed against this project.

## Setup

Assign variable/export project ID:

```powershell
$project_id = gcloud config get-value project
$env:GOOGLE_CLOUD_PROJECT = $project_id
```

or in bash:

```bash
project_id = gcloud config get-value project
export GOOGLE_CLOUD_PROJECT=$project_id
```

Terraform will pick up the project name from the environment variable now.

## Initialize

Run the following to pull in the providers:

```bash
terraform init
```

## Apply

With the providers downloaded and a project set, you're ready to use Terraform. Run `terraform apply`:

```bash
terraform apply
```

Terraform will show you what it plans to do, and prompt you to accept. Type "yes" to accept the plan.

```bash
yes
```

## Post-Apply

### Editing your config

Now you've provisioned your resources in GCP. If you run a "plan", you should see no changes needed.

```bash
terraform plan
```

Try editing a number, or appending a value to the name in the editor. Then, run a 'plan' again:

```bash
terraform plan
```

Afterwards you can run an apply, which implicitly does a plan and shows you the intended changes
at the 'yes' prompt.

```bash
terraform apply
```

```bash
yes
```

## Cleanup

Run the following to remove the resources Terraform provisioned:

```bash
terraform destroy
```

```bash
yes
```

***

Jimmy Briggs | 2021
