SHELL := /bin/bash
MAKEFILE_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
LINKS=.gitconfig .gitexclude .bashrc .vimrc bin .screenrc .starship .tmux.conf .bash_aliases .inputrc .zshrc
LINK_BUILD_TARGETS := $(addprefix build/,$(notdir $(LINKS)))

init: init-links init-vundle init-bak init-starship

init-links: ${LINK_BUILD_TARGETS}
build/%: % build/.mkdir
	@./link_install_files.sh $<
	@touch $@

build/.mkdir:
	mkdir -p build
	touch $@

init-vundle: ~/.vim/autoload/plug.vim
~/.vim/autoload/plug.vim:
	curl -fLo $@ --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

init-starship: .starship.installed
.starship.installed:
	./install_starship.sh
	touch $@

init-bak: ~/.bak
~/.bak:
	mkdir $@

test:
	bats -r ${MAKEFILE_DIR}/tests

.PHONY: init init-links init-vundle test
