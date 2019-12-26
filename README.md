# pg-monitor-exporters
Provision infrastructure and software to run necessary demons that will get statistics from PostgreSQL and send it to ELK/Prometheus
## initial plan is
- To use `Terraform` to provision AWS infrastructure
- To use `Ansible` to install `postgres_exporter`, software that will grab PostgreSQL logs from RDS, filebeat/logstash for sending logs to ELK
- Configuration management for `postgres_exporter` at least
- We are going to deploy this solution in client AWS account perimeter.
