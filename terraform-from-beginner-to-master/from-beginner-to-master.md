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

TBD

## Chapter 4 - Resources

TBD

## Chapter 5 - Providers

TBD

## Chapter 6 - Data Sources

TBD

## Chapter 7 - Outputs

TBD

## Chapter 8 - Locals

TBD

## Chapter 9 - Templates and Files

TBD

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

## Notes for Kevin

- All are personal preferences, not universal truths :-) :pray:
- Use bold or some kind of font differentiation for remarking some messages (e.g. pages 3, 4, 5).
- Adding a README to the repo: https://github.com/kevholditch/terraform-beginner-to-master-examples
- Page 10:
  - the link to the repo is not right. Besides fixing, it would be great if it were a clickable link.
  - it would be great to have a way to generate the PDF with source code which could be copied and pasted (when copied this code, it also gets the line numbers at the beginning of each line).
