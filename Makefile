MAKEFILE_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

setup-link:
	@echo "Setting up symbolic links for files in ${HOME}"
	@./link_install_files.sh $(shell pwd)

test:
	bats ${MAKEFILE_DIR}/Scripts/tests/cd_enter_exit.bats

.PHONY: setup-link test
