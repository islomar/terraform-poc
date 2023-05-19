# Notes about Terraform

- hhtps://www.terraform.io/intro/index.html
- https://blog.gruntwork.io/a-comprehensive-guide-to-terraform-b3d32832baca
  - https://github.com/gruntwork-io/intro-to-terraform
- https://hashicorp.github.io/field-workshops-terraform/slides/aws/terraform-oss/#1

## How to use multiple AWS accounts from the command line: profiles

- Follow the instructions here:
  - https://blog.gruntwork.io/authenticating-to-aws-with-the-credentials-file-d16c0fbcbf9e
  - https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-multiple-profiles
  - https://stackoverflow.com/questions/593334/how-to-use-multiple-aws-accounts-from-the-command-line
- Option 1: create another profile
  - `aws configure list`: show all the existing profiles
  - `aws configure --profile islomar-personal`
  - `set -x AWS_PROFILE islomar-personal`
- Option 2:
  - Add a profile here: `~/.aws/credentials`
  - Run any command passing the profile, e.g. `aws <command> --profile <profile_name>`
  - or set `set -x AWS_PROFILE islomar`

## General information

- Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.
- Terraform is **cloud-agnostic** and allows a single configuration to be used to manage multiple providers, and to even handle cross-cloud dependencies.
- Terraform generates an **execution plan** describing what it will do to reach the **desired state**, and then executes it to build the described infrastructure. As the configuration changes, Terraform is able to determine what changed and **create incremental execution plans** which can be applied.
- The infrastructure Terraform can manage includes low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc.
- **Key features**:
  - Infrastructure as Code
  - Execution plans: Terraform has a "planning" step where it generates an execution plan.
  - Resource Graph
  - Change automation
- Terraform is not mutually exclusive with other systems. It can be used to manage a single application, or the entire datacenter.
- To manage different versions of Terraform (similar to rbenv): https://github.com/tfutils/tfenv
- `terraform refresh`, then `terraform plan -refresh=false -out=terraform.plan` then `terraform apply terraform.plan`
  - https://www.terraform.io/docs/commands/refresh.html

## Terraform configuration

- **Terraform configuration**:

* A **provider** is responsible for creating and managing resources. E.g. `aws`.
* A **resource** might be a physical component such as an EC2 instance, or it can be a logical resource such as a Heroku application. It defines a type: the prefix of the type maps to the provider, e.g. `aws_instance`
* The first command to run for a new configuration -- or after checking out an existing configuration from version control -- is `terraform init`, which initializes various local settings and data that will be used by subsequent commands.
* Terraform 0.11 and above doesn't require to execute first `terraform plan`
* After applying, Terraform also writes some data into the terraform.tfstate file. **This state file is extremely important**; it keeps track of the IDs of created resources so that Terraform knows what it is managing. **This file must be saved and distributed** to anyone who might run Terraform. It is generally recommended to setup remote state when working with Terraform, to share the state automatically.
* By default, Terraform stores state locally in a file named terraform.tfstate. When working with Terraform in a team, use of a local file makes Terraform usage complicated because each user must make sure they always have the latest state data before running Terraform and make sure that nobody else runs Terraform at the same time.
* With **remote state**, Terraform writes the state data to a remote data store, which can then be shared between all members of a team. Terraform supports storing state in **Terraform Enterprise**, HashiCorp Consul, Amazon S3, and more.
* The EC2 instance we launched at this point is based on the AMI given, but has no additional software installed. If you're running an image-based infrastructure (perhaps creating images with Packer), then this is all you need.
* A **"backend"** in Terraform determines how state is loaded and how an operation such as apply is executed. This abstraction enables non-local file state storage, remote execution, etc. By default, Terraform uses the **"local" backend**, which is the normal behavior of Terraform you're used to.
* While remote state is a convenient, built-in mechanism for sharing data between configurations, it is also possible to use more general stores to pass settings both to other configurations and to other consumers. For example, if your environment has **HashiCorp Consul** then you can have one Terraform configuration that writes to Consul using consul_key_prefix and then another that consumes those values using the consul_keys data source.
  - https://www.terraform.io/docs/providers/consul/r/key_prefix.html
* For fully-featured remote backends, Terraform can also use **state locking** to prevent concurrent runs of Terraform against the same state. State locking happens automatically on all operations that could write state.
* The prefix `-/+` means that Terraform will destroy and recreate the resource, rather than updating it in-place. While some attributes can be updated in-place (which are shown with the `~` prefix)
* Variables:
  - https://learn.hashicorp.com/terraform/getting-started/variables
  - For all files which match terraform.tfvars or \*.auto.tfvars present in the current directory, Terraform automatically loads them to populate variables.
  - Terraform will read environment variables in the form of `TF_VAR_name` to find the value for a variable.
* **Outputs** are a way to tell Terraform what data is important. This data is outputted when apply
  is called, and can be queried using the terraform output command.
* Resource or module names can not contain dots or empty spaces.

## Resources

- By studying the resource attributes used in interpolation expressions, Terraform can automatically infer when one resource depends on another.
- Terraform uses this dependency information to determine the correct order in which to create the
  different resources.
- Sometimes there are dependencies between resources that are not visible to Terraform. The `depends_on` argument is accepted by any resource and accepts a list of resources to create explicit dependencies for.
- Where possible, Terraform will perform operations concurrently to reduce the total time taken to apply changes.

## AWS Provider

- https://www.terraform.io/docs/providers/aws/index.html

## Provisioners

- Provisioners: https://www.terraform.io/docs/provisioners/index.html
  - Provisioners are used to execute scripts on a local or remote machine as part of resource creation or destruction.
  - Provisioners can be used to bootstrap a resource, cleanup before destroy, run configuration
    management, etc.
  - Provisioners are added directly to any resource
  - Provisioners are only run when a resource is created.

## Modules

- Modules in Terraform are self-contained packages of Terraform configurations that are managed as a group.
- https://www.terraform.io/docs/modules/index.html
- A module is a container for multiple resources that are used together.
- Modules are used to create reusable components, improve organization, and to treat pieces of infrastructure as a black box.
- E.g. Consul module: https://registry.terraform.io/modules/hashicorp/consul/aws/0.6.1
- We do not recommend writing modules that are just thin wrappers around single other resource types. If you have trouble finding a name for your module that isn't the same as the main resource type inside it, that may be a sign that your module is not creating any new abstraction and so the module is adding unnecessary complexity. Just use the resource type directly in the calling module instead.

## Terraform Remote

- Terraform supports team-based workflows with a feature known as **remote backends**. Remote
  backends allow Terraform to use a shared storage space for state data, so any member of your team can use Terraform to manage the same infrastructure.
- Depending on the features you wish to use, Terraform has multiple remote backend options. You
  could use **Consul** for state storage, locking, and environments. This is a free and open source
  option. You can use **S3** which only supports state storage, for a low cost and minimally featured solution.
- **Consul**: https://demo.consul.io/ui/dc1/kv/getting-started-islomar/edit
- **Backend**: A "backend" in Terraform determines how state is loaded and how an operation such as apply is executed. This abstraction enables non-local file state storage, remote execution, etc.
- Backends are completely optional.

### Terraform Enterprise

- https://www.terraform.io/docs/enterprise/getting-started/index.html
- It offers **remote state**.
- It supports an even stronger locking concept that can also detect attempts to create a new plan when an existing plan is already awaiting approval, by queuing Terraform operations in a central location. This allows teams to more easily coordinate and communicate about changes to infrastructure.
- To collaborate with your colleagues in TFE, you'll all need access to the same TFE organization. You can add users to an organization by creating a team and adding users to it.
- Team membership is how TFE controls access to workspaces.
- **Workspaces** are how TFE organizes infrastructure. If you've used the legacy version of TFE, workspaces used to be called environments.
  - https://codurance.com/2020/04/28/terraform-with-multiple-environments/
  - https://www.terraform.io/docs/state/workspaces.html
  - https://www.terraform.io/docs/cloud/guides/recommended-practices/part1.html

### Configure Terraform Cloud

- https://learn.hashicorp.com/terraform/cloud/tf_cloud_gettingstarted.html
- You need to create a `~/.terraformrc` file and copy a created API user token

## AWS services

### Elastic IP

- An Elastic IP address is a static IPv4 address designed for dynamic cloud computing. An Elastic
  IP address is associated with your AWS account. With an Elastic IP address, you can mask the failure of an instance or software by rapidly remapping the address to another instance in your account.
- An Elastic IP address is a public IPv4 address, which is reachable from the internet. If your instance does not have a public IPv4 address, you can associate an Elastic IP address with your instance to enable communication with the internet; for example, to connect to your instance from your local computer.
- We currently do not support Elastic IP addresses for IPv6.

## Examples

https://www.terraform.io/intro/examples/index.html

## Commands

- `terraform init`
- `terraform fmt`: linter (or `terraform fmt -check=true`, which would fail if not correclty formatted)
- `terraform plan -out=exec_plan.tfplan`: it will save the plan (including the variables) and it will ONLY apply what it was there, i.e. if someone changed a property to a different value after having created the plan, that property will remain unchanged
  - https://www.terraform.io/docs/internals/json-format.html
  - `terraform show -json exec_plan.tfplan`
- `terraform apply`
- `terraform show`
- `terraform state rm xx`: delete the resource from the state
- `terraform state show xx`
  - e.g. `terraform state show module.john_smith.pagerduty_user.main`
  - e.g. `terraform state show module.john_smith.pagerduty_user_contact_method.sms`
- `terraform state rm ""`: remove all the state
- `terraform destroy`
- `terraform output <variable_name>`
- `terraform graph`
- `terraform import [-allow-missing-config] <resource_path> <resource_id>`
  - e.g. `terraform import -var 'pagerduty_token=<PAGERDUTY_TOKEN>' -allow-missing-config module.john_smith.pagerduty_user_contact_method.sms PRQST7J:PNID97H`

## PagerDuty

- We need to configure a `PAGERDUTY_TOKEN`
- `terraform apply -var 'pagerduty_token=<your_token>' -target=pagerduty_user.batman -out=exec_plan.tfplan`

### API

- `curl -X GET --header 'Accept: application/vnd.pagerduty+json;version=2' --header 'Authorization: Token token=<PAGERDUTY_TOKEN>' 'https://api.pagerduty.com/users' | | jq '.users[] | select(.id == "PPXHE9Z")'`

## How to deal with different environments: development, staging, production

- https://www.terraform.io/docs/cloud/guides/recommended-practices/part1.html#the-recommended-terraform-workspace-structure
- https://learn.hashicorp.com/tutorials/terraform/organize-configuration?in=terraform/modules
- There are several ways to do it:
  - A list `environments` which applies in a loop whatever.
  - Different folders `staging`, `production`
    - Drawback:
      - duplication
      - staging and production could differ
    - Advantage:
      - more clear separation and more difficult to apply changes to the wrong environment.
      - you could create something only for staging.
  - Use workspaces:
    - Workspace-separated environments use the same Terraform code but have different state files, which is useful if you want your environments to stay as similar to each other as possible, for example if you are providing development infrastructure to a team that wants to simulate running in production.
- https://codurance.com/2020/04/28/terraform-with-multiple-environments/
- https://medium.com/capital-one-tech/deploying-multiple-environments-with-terraform-kubernetes-7b7f389e622
  - It also shows "feature toggles".

## Recommended practices

- https://www.terraform.io/docs/cloud/guides/recommended-practices/part1.html
  - Table 1.1. with a comparison to Ansible, Puppet.

## Interesting links

- https://livebook.manning.com/book/terraform-in-action/chapter-1/v-10/24
- https://jessitron.com/2023/04/21/setting-up-alb-access-logs-in-eks-using-terraform/

## TO DO

- Try Terraform Cloud: https://learn.hashicorp.com/tutorials/terraform/cloud-sign-up?slug=terraform&slug=cloud-sign-up
- https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1
