.PHONY: check install

install:
	ansible-playbook --diff laptop.yaml

check:
	ansible-playbook --diff laptop.yaml --check

setup:
	ansible-playbook --diff setup.yaml

test:
	docker build . -t desktop-archlinux
	docker run desktop-archlinux
