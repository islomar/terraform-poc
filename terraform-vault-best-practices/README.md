# Best Practices for Using HashiCorp Terraform with HashiCorp Vault

## Demo description
* [Best Practices for Using HashiCorp Terraform with HashiCorp Vault](https://www.youtube.com/watch?time_continue=52&v=fOybhcbuxJ0)
* Manage secrets and protect sensitive data.
* https://github.com/hashicorp/vault-guides
* Vault uses Consult as a database for storing secrets in an encrypted format.
* Configure S3 as the store for the encrypted state (it includes secrets!!). In `main.tf`:
```
terraform {
    backend "s3" {
        bucket = "remote-terraform-state-best-practices-demo"
        encrypt = true
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}
```
* Steps:
    - `aws configure`
    - `git clone https://github.com/hashicorp/vault-guides.git`
    - `cd vault-guides/operations/provision-vault/best-practices/terraform-aws/`
    - `terraform init`
    - `terraform plan`

### Recommended architecture
    - Bastion as unique point access
        - To protect the network. Usually hosts one single application, like a proxy-server.
    - The Bastion connects to the Vault instances (e.g. 1 active and 2 stand-by)
        - Each Vault in a different AWS Availability Zone
    - And then we can have 3 Consul instances
* If you need to spin-up a new resource with Terraform which requires secrets:
    - Manually authenticate to Vault using an easy auth mechanism, e.g. GitHub.
    - Create a specific VAULT_TOKEN for that new resource
    - Run Terraform using that VAULT_TOKEN, pulling all the secrets from Vault.
* HashiCorp recommends and supports Consul being used as the storage backend for Vault
* Use *Consul Snapshot* as Vault backup: https://www.consul.io/docs/commands/snapshot.html
* When you spin-up a Vault instance, it comes in a sealed state by default (it does not serve requests)
    - The logs of terraform shows you the instruction to unseal it
    - `ssh-add xxxx.key.pem`
    - `ssh` to the bastion
    - from the Bastion, `ssh` to the Vault node
    - `vault operator init`
    - Unseal the three Vault instances, running the unseal command 3 times (with 3 different unseal keys, it can be any 3 of the existing 5): 
        - `vault operator unseal <unseal_key_1>`
        - `vault operator unseal <unseal_key_2>`
        - `vault operator unseal <unseal_key_3>`
* From the Bastion, `export VAULT_TOKEN=xxx`

### Seeding Vault with secrets
    - The dev logs into Vault with a GitHub API key, and gets a Vault token for the rest of the 
    day (it lasts for 24 hours). You can use a different auth system besides GitHub.
    - They export the Vault token as an environment variable, so that Terraform uses it to fetch 
    secrets from Vault. The secrets fetched are stored on the tfstate but expire after 5 minutes (so not a big problem from a security point of view, at least the lifetime is very limited).
     They get re-requested from Vault so long as the Vault token is valid.
* There is a Vault UI    
* From the Bastion, enable GitHub authentication to Vault (it could also be OAuth, username/password, etc.):
    - Create policy
    - `vault auth enable github` and restrict to people of your organisation, with a TTL of the Vault token returned of 24 hours.
    - Enable AWS secrets engine

### Consuming those secrets
* In TF files, declare a data provider for the vault secrets
* Workflow of the engineer when she arrives to work in the morning (seen above):  
    - `vault login -method=github -token=$GITHUB_TOKEN`
    - `export VAULT_TOKEN=<vault_token_value>`
    - `terraform apply`
     

## Benefits
* Reduces insider threat
* Auditability
* Nixes credential sharing (nix = reject)
* You don't have to commit in your Terraform config


## Vault Reference Architecture
* https://learn.hashicorp.com/vault/operations/ops-reference-architecture
* Consul servers are separate from the Vault servers
* Consul cluster is only used as a storage backend for Vault and not for other Consul-focused functionality
* Separating Vault and Consul allows each to have a system that can be sized appropriately in terms of CPU, memory and disk. 
    - Consul is a memory intensive application and so separating it to its own resources is advantageous to prevent resource contention or starvation.
* Vault to Consul backend connectivity is over HTTP and should be secured with TLS as well as a Consul token to provide encryption of all traffic.
* As the Consul cluster for Vault storage may be used in addition and separate to a Consul cluster for service discovery, it is recommended that the storage Consul process be **run on non-default ports** so that it does not conflict with other Consul functionality. 
* In OSS Vault the recommended number of instances is 3 in a cluster as any more would have limited value. 
*  In Vault Enterprise the recommended number is also 3 in a cluster, but more can be used if they were performance replicas to help with workload.
* It is recommended that the Consul cluster is **at least five instances** that are dedicated to performing backend storage functions for the Vault cluster only.
* Consul achieves replication and leadership through the use of its consensus and gossip protocols. In these protocols, a leader is elected by consensus and so a quorum of active servers must always exist. To achieve n-2 redundancy, an ideal size of a Consul cluster is 5.
    - Consul relies upon consensus negotiation to organize and replicate information and so the environment must provide 3 unique resilient paths in order to provide meaningful reliability. Essentially, a consensus system requires a simple majority of nodes to be available at any time. 
* Typical distribution in a cloud environment is to spread Consul/Vault nodes into separate Availability Zones (AZs)
* Vault enterprise offers:
    - Disaster Recovery Replication
    - Performance Replication


## Additional resources
* [Vault Reference Architecture](https://learn.hashicorp.com/vault/operations/ops-reference-architecture)
* [Best Practices Vault Cluster on AWS](https://github.com/hashicorp/vault-guides/tree/master/operations/provision-vault/best-practices/terraform-aws)
* [Production Hardening Guide](https://www.vaultproject.io/guides/operations/production)
* [How to Pull AWS Keys from Vault](https://github.com/rberlind/aws-ec2-instance/tree/from-vault)