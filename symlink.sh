if [ ! -d $HOME/.vim/plugin ]; then
    mkdir $HOME/.vim/plugin
fi

if [ ! -L $HOME/.vimrc ]; then
    ln -s $HOME/linux_setting/.vimrc $HOME/.vimrc
fi

if [ ! -L $HOME/.vim/plugin/ddc.vim ]; then
    ln -s $HOME/linux_setting/.vim/plugin/ddc.vim $HOME/.vim/plugin/ddc.vim
fi
