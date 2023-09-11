lint:
	ansible-lint

all:
	ansible-playbook -v --ask-become-pass -i inventory/local.yaml playbooks/update.yaml
