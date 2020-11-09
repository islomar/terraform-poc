# Terraform: from beginner to master

- https://leanpub.com/terraform-from-beginner-to-master
- kevin.holditch@gmail.com
- https://github.com/kevholditch/terraform-beginner-to-master-examples

## Chapter 1 - Introduction to Terraform

- Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. It takes your infrastructure you have defined in code and makes it real!
- **Traditional problems**:
  - Configuring infrastructure manually is very error prone.
  - It is very time consuming to make the changes manually.
  - Once you have an environment when you come to no longer need it destroying it can be very painful.
  - The great thing about this plan is that Terraform presents it to us and then pauses and lets us decide whether we want to go ahead. You can imagine how useful this is if you accidentally make a change that is going to destroy your database!
- Terraform itself is just an engine that knows how to run a provider that conforms to an interface. It is compound in two parts:
  - **Terraform engine**: it knows how to get from the state your infrastructure is currently in to how you want your infrastructure to be.
  - **Terraform provider**: talks to the infrastructure to find out the current state and make the changes using the infrastructure’s API.
- Terraform is much a better choice than **CloudFormation**:
  - Terraform is open source and generally moves faster than CloudFormation.
  - CloudFormation uses JSON or YAML for configuration.
  - You can use Terraform to configure all of your infrastructure whereas you can only use CloudFormation for AWS.
- **Chef and Puppet** are configuration management tools. They are designed to configure and manage software that is running on a machine (infrastructure) that already exists. Whereas Terraform sits at the abstraction layer above that and is designed to setup all of the infrastructure that make up your system such as load balancers, servers, DNS records etc.
  - As a small aside it is possible to configure software already running on a machine through Terraform using provisioners but this should be used with caution and it is best to leave this type of configuration to specialised tools like Puppet and Chef.

## Chapter 3 - Your First Terraform Project

- Example with S3 bucket

## Chapter 4 - Resources

- Once a resource is created it returns a bunch of **attributes**. The attributes a resource returns can be found in the Attributes Reference section on the documentation page for any resource. This is amazingly useful as it allows you to use the output from one resource as the argument to another resource.
- The neat thing about using interpolation syntax to reference the attribute of a resource in another resource is that it allows Terraform to work out the dependency order of the resources.
- Terraform uses this information to build up a dependency graph and then tries to run in parallel as much as possible.

## Chapter 5 - Providers

- Providers are not part of the main Terraform source code. They are separate binaries that live in their own repositories and can move at their own
  speed. This means that if a provider needs to release a bug fix or new feature they can just release
  it. They do not need to coordinate a release of the main Terraform code base.
- When downloaded, the provider is put under the folder `.terraform`
    - E.g. in OSX under `.terraform/plugins/darwin_-amd64/terraform-provider-aws_v2.27.0_x4 .`
- The provider is actually a separate binary which Terraform calls out to at run time to do its work. 
- As an interesting aside the name of the provider binary is always in the format terraform-provider-<NAME>_vX.Y.Z .
    - Terraform uses this convention to search for providers on your machine, so that it knows if you have a particular version of a provider when you run terraform init . It uses this information to know whether or not to download it.
- You can define more than one instance of the same provider, e.g. to define resources in several AWS regions.
    - You can set an `alias` (e.g. london) for the different providers and use it for referencing them, e.g. `provider = "aws.london"`.
    - Once you define two or more instances of the same provider every definition after the first must have an alias set.    

### Provider best practices
- Always pin a version.
- The general advice is to use ∼> X.YY notation for your provider (only update automatically minor versions, which contain non breaking changes).

## Chapter 6 - Data Sources

- A data source in Terraform is used to fetch data from a resource that is not managed by the current
  Terraform project, so that value can be used in the current Terraform project. 
- You can sort of think of it as a read only resource that already exists. The object exists but you want to read some properties of that object for use in your project.
- It is referenced as `data.<dataSourceType>.<dataSourceIdentifier>`
- The data source block is then opened with a { . You then specify any properties you want Terraform to use to search for the resource. We are using the complete name of the S3 bucket we are looking for. You then close the
  data source block with } 
- Multilinering: use  `<<`
- Reasons for using data sources:
    - Reference a resource (e.g. an AMI image) and be updated of new versions (i.e. always get the latest version) without having to change the reference. 
    - Another reason you may want to use a data source is if you are migrating existing infrastructure to Terraform and you want to reference a resource that is not part of your Terraform project yet.


## Chapter 7 - Outputs

* Outputs are very useful when used to output the values of resources that have been created as part of a Terraform run.
* Terraform prints the outputs in alphabetical order, not the order that you define them in your project. That is a good point to make, that Terraform does not care which order you define the blocks in your project.
* As of Terraform 0.12> (which this book is based on), Terraform allows you to output an entire resource or data block (see outputs_example_03): `output "all"` in order to output the whole resource.


## Chapter 8 - Locals

* A local is Terraform’s representation of a normal programming languages’s variable. Confusingly Terraform also has a concept called a variable which is really an input.
* Locals can reference the output of a resource or a data source


## Chapter 9 - Templates and Files

* We have seen in a previous chapter how you can place a multi line string as a value for a property. This is useful for something like an IAM policy. It can be even cleaner to move the value out into a file and then reference that file from your project.
* To be able to use dynamic values in a file we need to use the templatefile function.
* The template file would be `*.tpl`
* You can also create loops in a template

## Chatper 10: Variables
* A Variable in Terraform is something which can be set at runtime. It allows you to vary what Terraform will do by passing in or using a dynamic value.
* When needed, you can provide a description for the variable
* Use it like `var.<variableIdentifier>`
* When destroying a resource which includes a variable, Terraform will ask you for a value for the variable again, it doesn't actually matter what value you give it this time as the variable is not needed for Terraform to destroy the bucket.

### How to set variables
* Variables can have default values.
* To set a variable on the command line: `terraform apply -var <variableIdentifier>=<variableValue>`
* Another way: using an environment variable with the convention `TF_VAR_<variable_identifier>`
* You can declare your variables inside a `terraform.tfvar` file, as `<name> = <value>`
* Variables will be read from any file ending with `.auto.tfvars`
* Using a map: `variables_example_04`, e.g. to set different instance types for dev, test or prod environments.
* You can/should specify the type of a variable: it shows an error if you define a non acceptable value (e.g. "pepito" for a bool)
    * the following values will be valid true , false , "true" ,  "false" , "1" (evaluated to true), "0" (evaluated to false)
    * With a number any valid number will be allowed with or without quotes.
    * complex types: list, set, map, object, tuple.
    * simple types: bool, string, number
    * An object is a structure that you can define from the other types
    * It exists the `any` type: it is calculated in runtime.
    
## Chapter 11 - Project Layout
* We can split the code over as many files as we wish: Terraform combines all of the code.
* Rule: all of the files have to be in the same folder.
* Some conventions:
    * Providers are setup in a file `main.tf`
    * Files are broken up around different areas of the system, e.g. `ecs.tf`, `s3.tf`, `dns.tf` (for route53), etc.

## Chapter 12 - Modules

* We use folders to create modules.
* See `modules_example_0x`
* A module can take arguments.
* Return values in a module can be used in the main Terraform project.
* It is possible to return a whole resource from a module.
* Modules can themselves use modules inside them: `modules_example_03`.
* **Remote modules**
    * To reuse blocks of configuration across a company or with other people.
    * https://github.com/kevholditch/terraform-beginner-to-master-examples/blob/master/modules_example_04/main.tf
    * We can use GitHub for its publication. Example: github.com/kevholditch/sqs-with-backoff. Better pinning the version, e.g. with a git tag: github.com/kevholditch/sqs-with-backoff?ref=0.0.1

## Chapter 13 - Plans

- A plan is Terraform showing you how it needs to change the world to get it into the desired state specified in your code.
- The resource marked with `∼` means the resource will be updated in place.
- destroy then creates are potentially dangerous as it means your resource may not be available for a period of time, so this type of change should applied with caution.
- As
  what Terraform will do is first destroy the old queue and only once the queue is destroyed will it then create the new one. If you want Terraform to create the new queue before deleting the old one then this is possible using a resource lifecycle which will be covered in a later chapter.
    - PARALLEL CHABGES FTW!!: As a small aside if you want to change the name of an SQS queue then a better technique would be to create a new SQS queue in one release so both queues exist side by side, then switch your application over to using the new queue. Then do another Terraform release to delete the original queue.
- When reviewing a plan a good mindset to get into is to think about the changes you have made to your Terraform code and see if the plan matches what you are expecting. Start with the summary and see if you are seeing roughly the right amount of adds, updates and destroys and then work up from there.
- `terraform plan -out myplan`
- Being able to separate out the plan and apply phase enables you to write your own build deploy pipelines by having the plan as a step and then passing that plan file onto the apply step. This gives you the option to pause if you want and allow a human operator to check the plan before you pass it to be applied.
- **VERY IMPORTANT**: The difference is that when you pass a plan to the apply command, the apply command will execute that exact plan. So if something has changed in your infrastructure and that plan is no longer possible then Terraform will error and tell you. It is a safe guard where you are explicitly saying to Terraform, go and execute exactly this plan.
- Auto apply: It is possible to skip the confirmation where Terraform pauses during the apply phase a different way, you can use the -auto-approve flag
    - NOT RECOMMENDED in most scenarios.

## Chapter 14 - State
- State is Terraform’s store of all of the resources it has created. State stores all of the information about the resources, including meta information that cannot be retrieved from the underlying infrastructure APIs.
- It also stores the dependency order of the resources that it created.
- Terraform uses its state to work out how it needs to make changes. By default Terraform stores state in a local file called terraform.tfstate .
- why does Terraform need to record the resources it has created in a state file, why can’t it just look at the HCL code and compare that to the real world and apply the changes?
    - Some resources that you create have **write once values**, once they are written there is no way to retrieve them again (and check if they changed). E.g. passwords.
    - The state file is also needed by Terraform **for deleting resources**.
        - A simple example of this is that if
          you had a AWS subnet and an EC2 instance in that subnet and you deleted both of them from your project. Firstly Terraform needs to know that it created those resources in the first place. Terraform    cannot assume that anything in AWS that is not in your HCL code was something that it created that can now be deleted.
    - Terraform can then use the dependency order in its state file to delete the resources in the correct order. The only other way to solve this problem without a state file would be for Terraform to know the dependency order of all resource types. This quickly explodes to a point where it becomes almost impossible to maintain, plus it doesn’t scale. Terraform uses state to elegantly solve the dependency problem.
- By default Terraform uses a combination of its state and the underlying infrastructure APIs to build a plan of how to make changes to get the world to how you have specified it in your HCL code. When
  projects reach a certain size and due to rate limits imposed on some APIs it can become impractical to interrogate them on every Terraform run. In this situation you can pass in a flag to Terraform to
  tell it just to use its state as the source of truth. This greatly speeds up the Terraform run time and gets round this problem. The downside being that if someone modifies the underlying infrastructure
  outside of Terraform then the Terraform run could fail as it will be unaware of these changes.          

### Manipulating state
- `terraform state list`: it shows which resources are in its state file.
- Import existing infrastructure that was created by hand into Terraform.
    - `terraform import <resource_type>.<resource_name> <value>`
    - It depends on each provider.
    - `state_example_01`
- Move resources from on TF project A to another B.
    - `state_example_02`
    - By hand:
        - First, from A `terraform state rm <resource_id>`
        - Then, remove the resource declaration from the .tf file in A.
        - `terraform apply` from A.
        - Import resource in state for B (existing the .tf file as well)
        - `terraform apply` from B
    - Another way to move it is using `terraform state mv -state-out=../state_example_02a/terraform.tfstate aws_vpc.main aws_vpc.my_vpc`
        - `terraform state mv -state-out=<destination_tfstate> <origin_resource_id> <destination_resource_id>`
        - This works even with resources which do not support an import.
- Correct TF if someone goes and manually changes infrastructure behind TF's back where there is no way for Terraform to automatically know how to resolve that situation.
     
### Remote state
- `state_example_03`
- By convention, we put it on a file called `state.tf`
- Create a bucket in S3
    - Turn on bucket versioning
    - It automatically locks the file for multiple accesses.
- Declare the state.tf
- Doubts
    - Enable server-side encryption?
          
## Chapter 15 - Workspaces
- `workspaces_example_01`
- Variable `terraform.workspace`
- A workspace in Terraform is a way of creating many instances of a set of Terraform code using a single project
- All TF projects run in a workspace, e.g. `default`
- The `default` workspace can not be delted.
- `terraform workspace list` to list all the available workspaces in this project.
- `terraform workspace new dev`: to create a new workspace.
    - The dev workspace is in a file at the path `./terraform.tfstate.d/dev/terraform.tfstate`
- `terraform workspace select default`: to go back to the default workspace
- You can think of this like two Terraform projects in two separate folders that happen to be sharing the same code.
- Under the covers the workspace switching works by Terraform keeping multiple copies of the state.
- Under the bonnet Terraform uses a special marker file at the path `.terraform/environment` to store which workspace you are currently using. Note do not rely on this fact as it is an internal detail and subject to change.
- `terraform workspace delete dev`
- You can use the workspace name to drive different values for variables that make up your infrastructure. However, the amount that you can drive just from the workspace alone does not scale well. You really need to have a way to change your input variables at the top-level. This problem is solved by Terraform’s managed offering Terraform Cloud or Terraform Enterprise: https://www.terraform.io/docs/cloud/index.html

## Chapter 16 - Provisioners

- A provisioner in Terraform is a way to run a script either remotely or locally **after** a resource has been created.
- They were added by Hashicorp to Terraform to allow for certain scenarios that are not natively supported by the provider you are using. 
- Hashicorp recommend that they are a last resort, since provisioners are imperative and so TF has no way of knowing how to apply a change.
- Examples: https://github.com/kevholditch/terraform-beginner-to-master-examples/blob/master/provisioners_example_01/README.md
- How to avoid using the provisioner? AWS have a built in way to run a script upon new machine start (most cloud providers do). To do this set the script as the `user_data` on the machine.

### Null Resources
- A `null_resource` is a special no op resource that creates nothing. It is a dummy resource that allows you to attach a provisioner to it. This resource should be avoided unless absolutely necessary.

## General
* since Terraform 0.12> we can now omit the ${ and }
* Doubt: prevalence order for variable definitions?

## Notes for Kevin

- All are personal preferences, not universal truths :-) :pray:
- Use bold or some kind of font differentiation for remarking some messages (e.g. pages 3, 4, 5).
- Adding a README to the repo: https://github.com/kevholditch/terraform-beginner-to-master-examples
- Page 10:
  - the link to the repo is not right. Besides fixing, it would be great if it were a clickable link.
  - it would be great to have a way to generate the PDF with source code which could be copied and pasted (when copied this code, it also gets the line numbers at the beginning of each line).
- Page 12:
  - typo `lets` instead of `let's`
  - List of actions instead of a block of text with mixed commands and text in it.
- Page 33: the text for the "Chapter 10 - Variables" does not have the right font size and style. 
- Page 68: typo `sovle` instead of `solve`
- Page 68: better structure the reasons for existing of the state file as a list.
- Remote state
    - What about encryption? (passwords)
    - People would need the AWS credentials locally.
- Examples in GitHub are GREAT.
- It goes beyond the obvious, e.g. explaining why TF needs the state file. 