# pg-monitor-exporters
Provision infrastructure and software to run necessary demons that will get statistics from PostgreSQL and send it to ELK/Prometheus

## Initial plan is
- To use `Terraform` to provision AWS infrastructure
- To use `Ansible` to install `postgres_exporter`, software that will grab PostgreSQL logs from RDS, filebeat/logstash for sending logs to ELK
- Configuration management for `postgres_exporter` at least
- We are going to deploy this solution in client AWS account perimeter.

## Project structure
1. `./` directory for terraform scripts
2. `ansible/` directory for ansible scripts

# Project setup 
s3 bucket and dynamoDB lock table already provided in `backend.tf`. No need to specify them in arguments. Just check your aws profile.
```
terraform init -backend-config="region=eu-central-1" -backend-config="profile=default"
terraform apply
cd ansible
ansible-playbook main.yml 
```