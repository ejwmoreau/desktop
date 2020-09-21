.PHONY: install

# TODO use vault '--ask-vault-pass'
install:
	ansible-playbook --inventory '127.0.0.1,' --ask-become-pass linux.yaml

test:
	docker build . -t desktop-archlinux
	docker run desktop-archlinux
