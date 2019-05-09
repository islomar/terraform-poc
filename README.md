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
- After applying, Terraform also writes some data into the terraform.tfstate file. **This state file is extremely important**; it keeps track of the IDs of created resources so that Terraform knows what it is managing. **This file must be saved and distributed** to anyone who might run Terraform. It is generally recommended to setup remote state when working with Terraform, to share the state automatically
- The EC2 instance we launched at this point is based on the AMI given, but has no additional software installed. If you're running an image-based infrastructure (perhaps creating images with Packer), then this is all you need.


## AWS Provider
* https://www.terraform.io/docs/providers/aws/index.html


## Commands
* `terraform init`
* `terraform plan`
* `terraform apply`
* `terraform show`
* ``
