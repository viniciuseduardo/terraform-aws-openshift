bastion_endpoint = "192.168.10.244"
bastion_private_key = "~/.ssh/fapes.pem"
bastion_ssh_user = "open"

# If you want to use OKD, set true
use_community = true

# Platform name
platform_name = "fapes-openshift"

platform_domain = "openshift.fapes-sede.com.br"
platform_app_domain = "apps.openshift.fapes-sede.com.br"
platform_private_domain = "console-int.openshift.fapes-sede.com.br"
platform_public_domain  = "console.openshift.fapes-sede.com.br"

# For let's encrypt: Doamin admin's email address:
platform_domain_administrator_email = "vinicius.alves@sysmi.com.br"


create                = true
name                  = "public_certificate"
algorithm             = "RSA"
rsa_bits              = "3072"
validity_period_hours = "2160"
organization_name     = "OpenShift Fapes"
ip_addresses          = ["127.0.0.1", "0.0.0.0",]


master_nodes = [ 
                { asosmasprofap01.fapes-sede.com.br = "node-config-master" }, 
                { asosmasprofap02.fapes-sede.com.br = "node-config-master" }, 
                { asosmasprofap03.fapes-sede.com.br = "node-config-master" }
            ]

infra_nodes = [ 
                { asosindprofap01.fapes-sede.com.br = "node-config-infra" },
                { asosindprofap02.fapes-sede.com.br = "node-config-infra" }
            ]

lb_nodes = [ 
                { asoshprprofap01.fapes-sede.com.br = "" }
            ]

app_prod_nodes = [ 
                { asosandprofap01.fapes-sede.com.br = "node-config-compute" }, 
                { asosandprofap02.fapes-sede.com.br = "node-config-compute" }, 
                { asosandprofap03.fapes-sede.com.br = "node-config-compute" }
            ]

app_hmg_nodes = [ 
                { asosandhomfap01.fapes-sede.com.br = "node-config-compute" }
            ]

app_dev_nodes = [ 
                { asosanddesfap01.fapes-sede.com.br = "node-config-compute" }
            ]