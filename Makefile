setup-link:
	@echo "Setting up symbolic links for files in ${HOME}"
	@./link_install_files.sh $(shell pwd)

.PHONY: setup-link
