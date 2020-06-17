SHELL := /bin/bash
MAKEFILE_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
links=.gitconfig .gitexclude .bashrc .vimrc bin .screenrc

init: init-links init-vundle

init-links: ${links}
	@echo "Setting up symbolic links for files in ${HOME}"
	@./link_install_files.sh $(shell pwd) $^

vundle_dir=~/.vim/bundle/Vundle.vim
init-vundle:
	@if ! [ -d ${vundle_dir} ]; then \
		echo Cloning Vundle; \
		git clone https://github.com/VundleVim/Vundle.vim.git ${vundle_dir}; \
	else \
		echo Updating Vundle; \
		cd ${vundle_dir}; \
		git pull; \
	fi

scheme.minttyrc:
	curl https://github.com/oumu/mintty-color-schemes/raw/master/base16-eighties-mod.minttyrc -L -o $@
.minttyrc: settings.minttyrc scheme.minttyrc
	cat $^ > $@

test:
	bats ${MAKEFILE_DIR}/bin/tests/cd_enter_exit.bats
	bats ${MAKEFILE_DIR}/bin/tests/ps1_git_status.bats

.PHONY: init init-links init-vundle test
