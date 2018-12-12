.PHONEY: all install destroy

BASTION_SSH_SPEC := $(shell terraform output bastion_ssh_spec)
BASTION_NAME := $(shell terraform output platform_name)

key:
	@terraform output platform_private_key > /tmp/.openshift-`terraform output platform_name`.key
	@chmod 600 /tmp/.openshift-`terraform output platform_name`.key

sshspec:
	@terraform output bastion_ssh_spec

ssh: key
	@ssh ${BASTION_SSH_SPEC} -i /tmp/.openshift-${BASTION_NAME}.key

console:
	@open `terraform output master_public_url`

clean_setup_bastion:
	@terraform state rm module.openshift.null_resource.bastion_config
	@terraform state rm module.openshift.null_resource.bastion_repos
	@terraform state rm module.openshift.null_resource.template_inventory
	@terraform state rm module.openshift.null_resource.openshift_applier
	@terraform state rm module.openshift.null_resource.main
	@terraform state rm module.openshift.null_resource.node_repos_playbook
	@terraform state rm module.openshift.null_resource.openshift_applier
	@terraform state rm module.openshift.null_resource.template_inventory
	@terraform state rm module.openshift.null_resource.public_certificate
