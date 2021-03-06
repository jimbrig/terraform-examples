# Google Cloud Run Terraform Examples

A Suite of Terraform Modules and Examples for the Google Cloud Platform that simplifies the creation & configuration of a Cloud Run (Fully Managed) service.

## Examples

- [Cloud-Run-Basic](./Cloud-Run-Basic): Basic setup with minimal resources and configuration.
- [Cloud-Run-EnvVars](./Cloud-Run-EnvVars): Setup multiple environment variables used by containers.
- [Cloud-Run-NoAuth](./Cloud-Run-NoAuth): No authentication bindings.
- [Cloud-Run-Secrets](./Cloud-Run-Secrets): (BETA) Configure secrets from Secret-Manager
- [Cloud-Run-Secret-Volume](./Cloud-Run-Secret-Volume): (BETA)_Setup a mounted container volume with secrets.
- [Cloud-Run-SQL](./Cloud-Run-SQL): Link to an SQL Server Instance
- [Cloud-Run-SQL-PostgreSQL](./Cloud-Run-SQL-PostgreSQL): PostgreSQL specific server instance connection.
- [Cloud-Run-Traffic-Split](./Cloud-Run-Traffic-Split): Example splitting traffic 25/75 on new revisions.

## Table of Contents

## Introduction

These examples focus on the creation & configuration of Google Cloud Run (Fully managed) services, and provides sensible defaults for many of the options.

It attempts to be as complete as possible, and expose as much functionality as is available. As a result, some functionality might only be provided as part of BETA releases.

Google's SLA support for this level of functionality is often not as solid as with Generally-Available releases. If you require absolute stability, this module might not be the best for you.

## Requirements

- Terraform 0.14 or higher.
- `google` provider 3.67.0 or higher.
- `google-beta` provider 3.67.0 or higher.

## Reference

### Inputs





### Secrets & Volumes

If your service requires the use of sensitive values, it is possible to store them in [Google Secret Manager](https://cloud.google.com/secret-manager) and reference those secrets in your service. This will prevent the values of those secrets from being exposed to anyone that might have access your service but not to the contents of the secrets.

Secrets can either be exposed as files through mounted volumes, or through environment variables. This can be configured through the `volumes` and `env` input variables respectively.

Note: Environment variables using the latest secret version will not be updated when a new version is added. Volumes using the latest version will have their contents automatically updated to reflect the latest secret version.

Refer to <https://cloud.google.com/run/docs/configuring/secrets> for further reading on secrets in Cloud Run.

### Argument Reference

The following arguments are supported:

- **name** (Required): Name must be unique within a namespace, within a Cloud Run region. Is required when creating resources. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names

- **location**: (Required) The location of the cloud run instance. eg us-central1

The traffic block supports:

- **revision_name**: (Optional) RevisionName of a specific revision to which to send this portion of traffic.
- **percent**: - (Required) Percent specifies percent of the traffic to this Revision or Configuration.
- **latest_revision** - (Optional) LatestRevision may be optionally provided to indicate that the latest ready Revision of the Configuration should be used for this traffic target. When provided LatestRevision must be true if RevisionName is empty; it must be false when RevisionName is non-empty.

The template block supports:

- **metadata**: (Optional) Optional metadata for this Revision, including labels and annotations. Name will be generated by the Configuration. To set minimum instances for this revision, use the "autoscaling.knative.dev/minScale" annotation key. To set maximum instances for this revision, use the "autoscaling.knative.dev/maxScale" annotation key. To set Cloud SQL connections for the revision, use the "run.googleapis.com/cloudsql-instances" annotation key. Structure is documented below.
- **spec**: (Required) RevisionSpec holds the desired state of the Revision (from the client). Structure is documented below.

The metadata block supports:

- **labels**: (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and routes. More info: http://kubernetes.io/docs/user-guide/labels
- **generation**: A sequence number representing a specific generation of the desired state.
- **resource_version**: An opaque value that represents the internal version of this object that can be used by clients to determine when objects have changed. May be used for optimistic concurrency, change detection, and the watch operation on a resource or set of resources. They may only be valid for a particular resource or set of resources. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency
- **self_link**: SelfLink is a URL representing this object.
- **uid**: UID is a unique id generated by the server on successful creation of a resource and is not allowed to change on PUT operations. More info: http://kubernetes.io/docs/user-guide/identifiers#uids
- **namespace**: (Optional) In Cloud Run the namespace must be equal to either the project ID or project number. It will default to the resource's project.
- **annotations**: (Optional) Annotations is a key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. More info: http://kubernetes.io/docs/user-guide/annotations Note: The Cloud Run API may add additional annotations that were not provided in your config. If terraform plan shows a diff where a server-side annotation is added, you can add it to your config or apply the lifecycle.ignore_changes rule to the metadata.0.annotations field.
- **name**: (Optional) Name must be unique within a namespace, within a Cloud Run region. Is required when creating resources. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names

The spec block supports:

- **containers**: (Required) Container defines the unit of execution for this Revision. In the context of a Revision, we disallow a number of the fields of this Container, including: name, ports, and volumeMounts. The runtime contract is documented here: https://github.com/knative/serving/blob/master/docs/runtime-contract.md Structure is documented below.
- **container_concurrency**: (Optional) ContainerConcurrency specifies the maximum allowed in-flight (concurrent) requests per container of the Revision. Values are:
  - 0: thread-safe, the system should manage the max concurrency. This is the default value.
  - 1: not-thread-safe. Single concurrency
  - 2-N: thread-safe, max concurrency of N
- **timeout_seconds**: - (Optional) TimeoutSeconds holds the max duration the instance is allowed for responding to a request.
- **service_account_name**: (Optional) Email address of the IAM service account associated with the revision of the service. The service account represents the identity of the running revision, and determines what permissions the revision has. If not provided, the revision will use the project's default service account.
- **volumes**: (Optional, Beta) Volume represents a named volume in a container. Structure is documented below.
- **serving_state**: ServingState holds a value describing the state the resources are in for this Revision. It is expected that the system will manipulate this based on routability and load.

The containers block supports:

- **working_dir**: (Optional, Deprecated) Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image.
- **args**: (Optional) Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
- **env_from**: (Optional, Deprecated) List of sources to populate environment variables in the container. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Structure is documented below.
- **image**: (Required) Docker image name. This is most often a reference to a container located in the container registry, such as gcr.io/cloudrun/hello More info: https://kubernetes.io/docs/concepts/containers/images
- **command**: (Optional) Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
- **env**: (Optional) List of environment variables to set in the container. Structure is documented below.
- **ports**: (Optional) List of open ports in the container. More Info: https://cloud.google.com/run/docs/reference/rest/v1/RevisionSpec#ContainerPort Structure is documented below.
- **resources**: (Optional) Compute Resources required by this container. Used to set values such as max memory More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits Structure is documented below.
- **volume_mounts**: (Optional, Beta) Volume to mount into the container's filesystem. Only supports SecretVolumeSources. Structure is documented below.

The env_from block supports:

- **prefix**: (Optional) An optional identifier to prepend to each key in the ConfigMap.
- **config_map_ref**: (Optional) The ConfigMap to select from. Structure is documented below.
- **secret_ref**: (Optional) The Secret to select from. Structure is documented below.

The config_map_ref block supports:

- **optional**: (Optional) Specify whether the ConfigMap must be defined
- **local_object_reference**: (Optional) The ConfigMap to select from. Structure is documented below.

The local_object_reference block supports:

- **name** - (Required) Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

The secret_ref block supports:

- **local_object_reference** - (Optional) The Secret to select from. Structure is documented below.
- **optional** - (Optional) Specify whether the Secret must be defined

The local_object_reference block supports:

- **name** - (Required) Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

The env block supports:

- **name** - (Optional) Name of the environment variable.
- **value** - (Optional) Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any route environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to "".
- **value_from** - (Optional, Beta) Source for the environment variable's value. Only supports secret_key_ref. Structure is documented below.

The value_from block supports:

- **secret_key_ref** - (Required) Selects a key (version) of a secret in Secret Manager. Structure is documented below.

The secret_key_ref block supports:

- **key** - (Required) A Cloud Secret Manager secret version. Must be 'latest' for the latest version or an integer for a specific version.
- **name** - (Required) The name of the secret in Cloud Secret Manager. By default, the secret is assumed to be in the same project. If the secret is in another project, you must define an alias. You set the <alias> in this field, and create an annotation with the following structure "run.googleapis.com/secrets" = "<alias>:projects/<project-id|project-number>/secrets/<secret-name>". If multiple alias definitions are needed, they must be separated by commas in the annotation field.

The ports block supports:

- **name** - (Optional) Name of the port.
- **protocol** - (Optional) Protocol used on port. Defaults to TCP.
- **container_port** - (Required) Port number.

The resources block supports:

- **limits** - (Optional) Limits describes the maximum amount of compute resources allowed. The values of the map is string form of the 'quantity' k8s type: https://github.com/kubernetes/kubernetes/blob/master/staging/src/k8s.io/apimachinery/pkg/api/resource/quantity.go
- **requests** - (Optional) Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. The values of the map is string form of the 'quantity' k8s type: https://github.com/kubernetes/kubernetes/blob/master/staging/src/k8s.io/apimachinery/pkg/api/resource/quantity.go

The volume_mounts block supports:

- **mount_path** - (Required) Path within the container at which the volume should be mounted. Must not contain ':'.

- **name** - (Required) This must match the Name of a Volume.

The volumes block supports:

- **name** - (Required) Volume's name.

- **secret** - (Required) The secret's value will be presented as the content of a file whose name is defined in the item path. If no items are defined, the name of the file is the secret_name. Structure is documented below.

The secret block supports:

- **secret_name** - (Required) The name of the secret in Cloud Secret Manager. By default, the secret is assumed to be in the same project. If the secret is in another project, you must define an alias. An alias definition has the form: <alias>:projects/<project-id|project-number>/secrets/<secret-name>. If multiple alias definitions are needed, they must be separated by commas. The alias definitions must be set on the run.googleapis.com/secrets annotation.

- **items** - (Optional) If unspecified, the volume will expose a file whose name is the secret_name. If specified, the key will be used as the version to fetch from Cloud Secret Manager and the path will be the name of the file exposed in the volume. When items are defined, they must specify a key and a path. Structure is documented below.

The items block supports:

- **key** - (Required) The Cloud Secret Manager secret version. Can be 'latest' for the latest value or an integer for a specific version.

- **path** - (Required) The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'.

- **traffic** - (Optional) Traffic specifies how to distribute traffic over a collection of Knative Revisions and Configurations Structure is documented below.

- **template** - (Optional) template holds the latest specification for the Revision to be stamped out. The template references the container image, and may also include labels and annotations that should be attached to the Revision. To correlate a Revision, and/or to force a Revision to be created when the spec doesn't otherwise change, a nonce label may be provided in the template metadata. For more details, see: https://github.com/knative/serving/blob/master/docs/client-conventions.md#associate-modifications-with-revisions Cloud Run does not currently support referencing a build that is responsible for materializing the container image from source. Structure is documented below.

- **metadata** - (Optional) Metadata associated with this Service, including name, namespace, labels, and annotations. Structure is documented below.

- **project** - (Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used.

- **autogenerate_revision_name** - (Optional) If set to true, the revision name (template.metadata.name) will be omitted and autogenerated by Cloud Run. This cannot be set to true while template.metadata.name is also set. (For legacy support, if template.metadata.name is unset in state while this field is set to false, the revision name will still autogenerate.)

The metadata block supports:

- **labels** - (Optional) Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and routes. More info: http://kubernetes.io/docs/user-guide/labels

- **generation** - A sequence number representing a specific generation of the desired state.

- **resource_version** - An opaque value that represents the internal version of this object that can be used by clients to determine when objects have changed. May be used for optimistic concurrency, change detection, and the watch operation on a resource or set of resources. They may only be valid for a particular resource or set of resources. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#concurrency-control-and-consistency

- **self_link** - SelfLink is a URL representing this object.

- **uid** - UID is a unique id generated by the server on successful creation of a resource and is not allowed to change on PUT operations. More info: http://kubernetes.io/docs/user-guide/identifiers#uids

- **namespace** - (Optional) In Cloud Run the namespace must be equal to either the project ID or project number.

- **annotations** - (Optional) Annotations is a key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. More info: http://kubernetes.io/docs/user-guide/annotations Note: The Cloud Run API may add additional annotations that were not provided in your config. If terraform plan shows a diff where a server-side annotation is added, you can add it to your config or apply the lifecycle.ignore_changes rule to the metadata.0.annotations field. Cloud Run (fully managed) uses the following annotation keys to configure features on a Service:

- **run.googleapis.com/ingress** sets the ingress settings for the Service. For example, "run.googleapis.com/ingress" = "all".

### Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

- **id** - an identifier for the resource with format locations/{{location}}/namespaces/{{project}}/services/{{name}}

- **status** - The current status of the Service. Structure is documented below.

The status block contains:

- **conditions** - Array of observed Service Conditions, indicating the current ready state of the service. Structure is documented below.

- **url** - From RouteStatus. URL holds the url that will distribute traffic over the provided traffic targets. It generally has the form https://{route-hash}-{project-hash}-{cluster-level-suffix}.a.run.app

- **observed_generation** - ObservedGeneration is the 'Generation' of the Route that was last processed by the controller. Clients polling for completed reconciliation should poll until observedGeneration = metadata.generation and the Ready condition's status is True or False.

- **latest_created_revision_name** - From ConfigurationStatus. LatestCreatedRevisionName is the last revision that was created from this Service's Configuration. It might not be ready yet, for that use LatestReadyRevisionName.

- **latest_ready_revision_name** - From ConfigurationStatus. LatestReadyRevisionName holds the name of the latest Revision stamped out from this Service's Configuration that has had its "Ready" condition become "True".

The conditions block contains:

- **message** - Human readable message indicating details about the current status.

- **status** - Status of the condition, one of True, False, Unknown.

- **reason** - One-word CamelCase reason for the condition's current status.

- **type** - Type of domain mapping condition.

#### Timeouts

This resource provides the following Timeouts configuration options:

- **create** - Default is 6 minutes.
- **update** - Default is 15 minutes.
- **delete** - Default is 4 minutes.
- **Import**

Service can be imported using any of these accepted formats:

```
$ terraform import google_cloud_run_service.default locations/{{location}}/namespaces/{{project}}/services/{{name}}
$ terraform import google_cloud_run_service.default {{location}}/{{project}}/{{name}}
$ terraform import google_cloud_run_service.default {{location}}/{{name}}
```
