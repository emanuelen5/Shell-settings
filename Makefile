MAKEFILE_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

setup-link: scheme.minttyrc
	@echo "Setting up symbolic links for files in ${HOME}"
	@./link_install_files.sh $(shell pwd)

scheme.minttyrc:
	curl https://github.com/oumu/mintty-color-schemes/blob/master/base16-eighties-mod.minttyrc -L -o $@
.minttyrc: scheme.minttyrc settings.minttyrc
	cat $^ > $@

test:
	bats ${MAKEFILE_DIR}/Scripts/tests/cd_enter_exit.bats

.PHONY: setup-link test
