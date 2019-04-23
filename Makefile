MAKEFILE_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

setup-link:
	@echo "Setting up symbolic links for files in ${HOME}"
	@./link_install_files.sh $(shell pwd)

test:
	bats ${MAKEFILE_DIR}/bin/tests/cd_enter_exit.bats
	bats ${MAKEFILE_DIR}/bin/tests/ps1_git_status.bats

.PHONY: setup-link test
