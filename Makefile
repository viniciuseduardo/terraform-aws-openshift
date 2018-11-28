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
