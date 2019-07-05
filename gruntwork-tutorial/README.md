# A comprehensive guide to Terraform

* https://blog.gruntwork.io/a-comprehensive-guide-to-terraform-b3d32832baca#.b6sun4nkn
* Part 2: [An introduction to Terraform](https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180)
    - https://github.com/gruntwork-io/intro-to-terraform
    - Forked here: https://github.com/islomar/intro-to-terraform
* Part 3: [How to manage Terraform state](https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa)
* Part 4: [How to create reusable infrastructure with Terraform modules](https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d)
* Part 5: [Terraform tips & tricks: loops, if-statements, and gotchas](https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9)
* Part 6: [How to use Terraform as a team](https://blog.gruntwork.io/how-to-use-terraform-as-a-team-251bc1104973)


## Interesting links
* [AWS in Plain English](https://www.expeditedssl.com/aws-in-plain-english)


## How to manage Terraform state
* Terraform records information about what infrastructure it created in a Terraform state file
* S3 as remote state storage
* we recommend using separate Terraform folders (and therefore separate state files) for each environment (staging, production, etc.), and within each environment, each “component.”)
* data source that is particularly useful when working with state: terraform_remote_state. You can use this data source to fetch the Terraform state file stored by another set of templates.
* https://www.terraform.io/docs/providers/terraform/d/remote_state.html

## How to create reusable infrastructure with Terraform modules
* Whenever you add one to a Terraform project, you need to run the “get” command before you run “plan” or “apply”:
```
> terraform get
Get: /modules/frontend-app
> terraform plan
```
* You can use versioned modules, e.g. for decoupling Staging and Production
* Terraform supports other types of module sources, such as Git URLs, Mercurial URLs, and arbitrary HTTP URLs
* Most Terraform projects consist of (at least) two repos: **infrastructure-modules** and **infrastructure-live**
* Whenever adding a new module, don’t forget to run `terraform get`
* When creating modules, there are two best practices to keep in mind:
  - Avoid inline blocks: you should always try to use a separate resource instead of the inline block.
  - Use module-relative paths: always use a path variable in file paths, e.g. `user_data = "${file("${path.module}/user-data.sh")}"`


## Terraform tips & tricks: loops, if-statements, and gotchas
* Loops, splat syntax (`TYPE.NAME.*.ATTRIBUTE`)
* Interpolation functions: https://www.terraform.io/docs/configuration-0-11/interpolation.html
* The key realization is that **`terraform plan` only looks at resources in its Terraform state file**


## How to use Terraform as a team
* You should probably have at least two separate version control repositories: 
    * one for modules (reusable) 
    * one for live infrastructure
* You should be able to reason about your infrastructure solely by looking at the live repository. If you can scan the code and the commit history of that repository and get an accurate understanding of what’s deployed, then you’ll find it easy to maintain your infrastructure.
* The master branch of the live repository is a 1:1 representation of what’s actually deployed in production.
* Run `terraform fmt` as a pre-commit hook
* Every time we create a Terraform module we also create:
    - Example code
    - Automated test: https://github.com/gruntwork-io/terratest
* We recommend that every team maintains at least two environments:
    - Production
    - Staging
* Testing in staging is especially important because Terraform does not roll back changes in the case of errors.
* Some types of Terraform changes can be automated:
    - if you’re using Terraform to apply the same type of change over and over again (e.g. to deploy a new version of your app in a CD pipeline), you may want to completely automate the process.
    - For these sorts of repetitive, mechanical changes, we recommend writing a deployment script (or using [one of ours](https://blog.gruntwork.io/gruntwork-infrastructure-packages-7434dc77d0b1)) that can automatically do the following:      
      - Check out the live Terraform repository.
      - Update the version number for the app in the corresponding Terraform templates.
      - Run “terraform apply”.
   - We typically set up commit hooks to run such an automated deployment script after every commit to the master branch of an application’s repository (note: the application code is in a separate repository from the Terraform code, so don’t confuse this for the master branch of the live repo!). Typically, we deploy the app to staging if that commit has a “release-stage” tag and to production if it has a “release-prod” tag. If you’re using GitHub, you can create tags using the Releases UI, so this gives you a point-and-click way to kick off an automated deployment, and allows you to use the releases page of your repository as a record of all deployments.
    - https://developer.github.com/v3/repos/releases/#create-a-release
