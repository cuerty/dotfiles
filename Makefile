install: install-vim install-xdefaults

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s `pwd`/vimrc ~/.vimrc

install-xdefaults:
	rm -f ~/.Xdefaults
	ln -s `pwd`/Xdefaults ~/.Xdefaults
