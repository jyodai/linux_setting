add-apt-repository ppa:jonathonf/vim
apt update
apt install vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ ! -d $HOME/.vim/plugged ]; then
    mkdir ~/.vim/plugged
fi

if [ ! -d $HOME/.vim/project ]; then
    mkdir ~/.vim/project
fi
