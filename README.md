# vim-borra-config

# Create symlinks
ln -s /home/jcarranz/repos/vim-borra-config/.vimrc /home/jcarranz/.vimrc
ln -s /home/jcarranz/repos/vim-borra-config/.jcarranz_rc /home/jcarranz/.jcarranz_rc

# Modify VIMINIT
export MYVIMRC=/home/jcarranz/.vimrc
export VIMINIT='source $MYVIMRC'

# Add below lines in .bashrc file
if [ -f ~/.jcarranz_rc ]; then
    . ~/.jcarranz_rc
fi

# Download Bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Run PluginInstal

# Create git aliasesvimrc
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

# Other helpfull links
https://vi.stackexchange.com/questions/3359/how-do-i-fix-the-status-bar-symbols-in-the-airline-plugin
https://docs.microsoft.com/en-us/windows/terminal/tutorials/custom-prompt-setup#install-a-nerd-font
https://windowsterminalthemes.dev
