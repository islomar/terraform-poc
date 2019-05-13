# Notes about Terraform
https://www.terraform.io/intro/index.html

## General information
* Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.
* Terraform is **cloud-agnostic** and allows a single configuration to be used to manage multiple providers, and to even handle cross-cloud dependencies. 
* Terraform generates an **execution plan** describing what it will do to reach the **desired state**, and then executes it to build the described infrastructure. As the configuration changes, Terraform is able to determine what changed and **create incremental execution plans** which can be applied.
* The infrastructure Terraform can manage includes low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc.
* **Key features**:
  - Infrastructure as Code
  - Execution plans: Terraform has a "planning" step where it generates an execution plan. 
  - Resource Graph
  - Change automation
* Terraform is not mutually exclusive with other systems. It can be used to manage a single application, or the entire datacenter.
*  **Terraform configuration**:
  - A **provider** is responsible for creating and managing resources. E.g. `aws`.
  - A **resource** might be a physical component such as an EC2 instance, or it can be a logical resource such as a Heroku application. It defines a type: the prefix of the type maps to the provider, e.g. `aws_instance`
  - The first command to run for a new configuration -- or after checking out an existing configuration from version control -- is `terraform init`, which initializes various local settings and data that will be used by subsequent commands.
- Terraform 0.11 and above doesn't require to execute first `terraform plan`
- After applying, Terraform also writes some data into the terraform.tfstate file. **This state file is extremely important**; it keeps track of the IDs of created resources so that Terraform knows what it is managing. **This file must be saved and distributed** to anyone who might run Terraform. It is generally recommended to setup remote state when working with Terraform, to share the state automatically.
- By default, Terraform stores state locally in a file named terraform.tfstate. When working with Terraform in a team, use of a local file makes Terraform usage complicated because each user must make sure they always have the latest state data before running Terraform and make sure that nobody else runs Terraform at the same time.
- With **remote state**, Terraform writes the state data to a remote data store, which can then be shared between all members of a team. Terraform supports storing state in **Terraform Enterprise**, HashiCorp Consul, Amazon S3, and more.
- The EC2 instance we launched at this point is based on the AMI given, but has no additional software installed. If you're running an image-based infrastructure (perhaps creating images with Packer), then this is all you need.
- A **"backend"** in Terraform determines how state is loaded and how an operation such as apply is executed. This abstraction enables non-local file state storage, remote execution, etc. By default, Terraform uses the **"local" backend**, which is the normal behavior of Terraform you're used to. 
- While remote state is a convenient, built-in mechanism for sharing data between configurations, it is also possible to use more general stores to pass settings both to other configurations and to other consumers. For example, if your environment has **HashiCorp Consul** then you can have one Terraform configuration that writes to Consul using consul_key_prefix and then another that consumes those values using the consul_keys data source.
  - https://www.terraform.io/docs/providers/consul/r/key_prefix.html
- For fully-featured remote backends, Terraform can also use **state locking** to prevent concurrent runs of Terraform against the same state. State locking happens automatically on all operations that could write state.
- The prefix `-/+` means that Terraform will destroy and recreate the resource, rather than updating it in-place. While some attributes can be updated in-place (which are shown with the `~` prefix)
- Variables: 
  - https://learn.hashicorp.com/terraform/getting-started/variables
  - For all files which match terraform.tfvars or *.auto.tfvars present in the current directory, Terraform automatically loads them to populate variables. 
  - Terraform will read environment variables in the form of `TF_VAR_name` to find the value for a variable. 

## Resources
* By studying the resource attributes used in interpolation expressions, Terraform can 
automatically infer when one resource depends on another. 
* Terraform uses this dependency information to determine the correct order in which to create the
 different resources.
* Sometimes there are dependencies between resources that are not visible to Terraform. The `depends_on` argument is accepted by any resource and accepts a list of resources to create explicit dependencies for.
* Where possible, Terraform will perform operations concurrently to reduce the total time taken to apply changes.


## AWS Provider
* https://www.terraform.io/docs/providers/aws/index.html


## Provisioners
- Provisioners: https://www.terraform.io/docs/provisioners/index.html
  - Provisioners are used to execute scripts on a local or remote machine as part of resource creation or destruction. 
  - Provisioners can be used to bootstrap a resource, cleanup before destroy, run configuration 
  management, etc.
  - Provisioners are added directly to any resource
  - Provisioners are only run when a resource is created. 
  

## Terraform Enterprise
* It offers **remote state**.
* It supports an even stronger locking concept that can also detect attempts to create a new plan when an existing plan is already awaiting approval, by queuing Terraform operations in a central location. This allows teams to more easily coordinate and communicate about changes to infrastructure.


## AWS services
### Elastic IP
* An Elastic IP address is a static IPv4 address designed for dynamic cloud computing. An Elastic 
IP address is associated with your AWS account. With an Elastic IP address, you can mask the failure of an instance or software by rapidly remapping the address to another instance in your account.
* An Elastic IP address is a public IPv4 address, which is reachable from the internet. If your instance does not have a public IPv4 address, you can associate an Elastic IP address with your instance to enable communication with the internet; for example, to connect to your instance from your local computer.
* We currently do not support Elastic IP addresses for IPv6.


## Commands
* `terraform init`
* `terraform plan`
* `terraform apply`
* `terraform show`
* `terraform destroy`
* ``
