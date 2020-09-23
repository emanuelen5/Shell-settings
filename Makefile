SHELL := /bin/bash
MAKEFILE_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
links=.gitconfig .gitexclude .bashrc .vimrc bin .screenrc

init: init-links init-vundle

init-links: ${links}
	@echo "Setting up symbolic links for files in ${HOME}"
	@./link_install_files.sh $(shell pwd) $^

init-vundle:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

test:
	bats ${MAKEFILE_DIR}/bin/tests/cd_enter_exit.bats
	bats ${MAKEFILE_DIR}/bin/tests/ps1_git_status.bats

.PHONY: init init-links init-vundle test
