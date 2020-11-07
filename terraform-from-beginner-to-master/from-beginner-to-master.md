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

### Variables
* A Variable in Terraform is something which can be set at runtime. It allows you to vary what Terraform will do by passing in or using a dynamic value.
* When needed, you can provide a description for the variable
* Use it like `var.<variableIdentifier>`
* When destroying a resource which includes a variable, Terraform will ask you for a value for the variable again, it doesn't actually matter what value you give it this time as the variable is not needed for Terraform to destroy the bucket.

## Chapter 11 - Project Layout

TBD

## Chapter 12 - Modules

TBD

## Chapter 13 - Plans

TBD

## Chapter 14 - State

TBD

## Chapter 16 - Provisioners

TBD

## General
* since Terraform 0.12> we can now omit the ${ and }


## Bookmark

Page 33/90

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
- Page 33: the text for the "Chapter 10" does not have the right font size and style. 
- Examples are GREAT.