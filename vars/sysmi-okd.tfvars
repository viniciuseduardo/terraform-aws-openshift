
platform_cidr = "10.0.0.0/16"

# Master url can be accessed from:
operator_cidrs = ["0.0.0.0/0"]

# Serviced hosted in the cluster can be accessed from:
public_cidrs = ["0.0.0.0/0"]

# Use spot instance
use_spot = false

# If you want to use OKD, set true
use_community = true

# Master instance count
master_count = 1

# Master instance type
master_instance_type = "t2.xlarge"

# Infra instance count
infra_node_count = 1

# Infra instance type
infra_node_instance_type = "t2.xlarge"

# Compute node count
compute_node_count = 3

# Compute instance type
compute_node_instance_type = "t2.large"

# Platform name
platform_name = "sysmi-openshift"

# Platform domain. master: https://<platform domain>:8443/
platform_domain = "sysmanager.com.br"

# For let's encrypt: Doamin admin's email address:
platform_domain_administrator_email = "vinicius.alves@sysmi.com.br"
