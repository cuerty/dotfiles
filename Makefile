install: install-awesome install-vim install-xdefaults

install-awesome:
	mkdir -p ~/.config
	rm -rf ~/.config/awesome
	ln -s `pwd`/awesome ~/.config/awesome

install-xdefaults:
	rm -f ~/.Xdefaults
	ln -s `pwd`/Xdefaults ~/.Xdefaults

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s `pwd`/vimrc ~/.vimrc
