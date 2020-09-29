.PHONY: install

install:
	ansible-playbook --inventory '127.0.0.1,' --extra-vars 'ansible_python_interpreter=auto_silent' --ask-become-pass linux.yaml

test:
	docker build . -t desktop-archlinux
	docker run desktop-archlinux
