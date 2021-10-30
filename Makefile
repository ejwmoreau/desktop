.PHONY: check install

install:
	ansible-playbook --diff linux.yaml

check:
	ansible-playbook --diff linux.yaml --check

test:
	docker build . -t desktop-archlinux
	docker run desktop-archlinux
