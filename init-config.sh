#!/bin/bash

##
# Initial config for auto installing programms
#
# Dont forget make this file executable: chmod +x ./имя_скрипта#
# run file with superuser rights 
# sudo ./client-config.sh
#
  
echo 'Welcome to auto-installing script ver 1.0 at 03.05.2020'

# refresh apt repositories
sudo apt-get update

echo '#######################################################'
echo 'Installing Synaptic:'
echo ''
sudo apt-get install synaptic -y

echo '#######################################################'
echo 'Installing PHP 5.6'
echo ''
sudo apt-get install software-properties-common -y
# add legacy ppa repository
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update 
sudo apt-get install php5.6 -y

echo '#######################################################'
echo 'Installing MySQL server'
echo ''
sudo apt-get install mysql-server
sudo mysql_secure_installation
# after install your need enter root password
echo 'check msql-server service status'
sudo service mysql status
echo ''
echo 'check current utf8 charset'
echo 'Enter current mysql root password: '
# check to contains utf8 like argument
msqlCharsets=$(echo "show variables like 'char%';" | mysql -u root -p)
findCharset=utf8
pathCharsetConfigFile="/etc/mysql/conf.d/utf8_set.cnf"
if echo "$msqlcharsets" | grep -q $findCharset 
  then echo "$findCharset contains into current mysql configuration no additional configuration is required"
  else echo "$findCharset does not exists"; sudo touch $pathCharsetConfigFile; echo "[mysqld]" | sudo tee -a $pathCharsetConfigFile; echo "character-set-server=utf8" | sudo tee -a $pathCharsetConfigFile; "collation-server=utf8_general_ci" | sudo tee -a $pathCharsetConfigFile; sudo service mysql restart           
fi
# also u need to add following string to mysqld.cnf file for loggin by simple password
echo "default_authentication_plugin=mysql_native_password" | sudo tee -a /etc/mysql/mysql.conf.d/mysqld.cnf

echo '#######################################################'
echo 'Installing Git'
echo ''
sudo apt-get install git -y

echo '#######################################################'
echo 'Installing Postman'
echo ''
sudo apt-get install postman -y

echo '#######################################################'
echo 'Intalling Vim'
echo ''
sudo apt-get install vim -y
echo "Install vim plug manager"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Create config file for vim, which locate into home dir with names: .vimrc"
vimrcPath="~/.vimrc"
if [ -e $vimrcPath ]
  then echo "file .vimrc is exists" 
  else cat <<EOT >> $vimrcPath

" Configuration vimrc file.
"
" Date create 2019.10.03
"
" for Unix and OS/2:  ~/.vimrc

call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'udalov/kotlin-vim'
Plug 'Chiel92/vim-autoformat'
Plug 'ycm-core/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'

call plug#end()

let g:onedark_hide_endofbuffer=1
colorscheme onedark

syntax on
set number "numbering strings
set mouse=a "mouse support
set expandtab "space instead tabulation
set tabstop=2 "two space tabulation
set hlsearch "syntax highlight
set incsearch "incremental search
set clipboard=unnamed

"map hotkeys to Nerd ctrl+N
map <C-n> : NERDTreeToggle<CR>
"map autoformat hotkeys
noremap <F3> :Autoformat<CR>
EOT
echo "Install added plugins"
vim +'PlugInstall --sync' +qall &> /dev/null
fi

echo '#######################################################'
echo 'Installing Fish'
echo ''
sudo apt-get install fish -y
echo 'installing oh my fish'
# Oh my fish config locate in ~/.config/omf directory
curl -L https://get.oh-my.fish | fish
echo 'install fonts-powerline for agnoster fish theme'
sudo apt-get install fonts-powerline -y
echo 'install omf agnoster theme from bash not allowed'
echo 'You need install it from fish shell directly. It so SAD'
# foolowing steps resolve it:
# fish 
# omf update
# omf install agnoster

echo '#######################################################'
echo 'Installing Ranger'
echo ''
sudo apt-get install ranger -y

echo '#######################################################'
echo 'Installing DBeaver Community '
echo ''
sudo snap install dbeaver-ce -y


echo '#######################################################'
echo 'Installing Virtual machines manager'
echo ''
sudo apt install qemu-kvm libvirt-bin bridge-utils virt-manager cpu-checker -y
echo 'verify kvm installation'
kvm-ok

echo '#######################################################'
echo 'Installing Enpass'
echo ''
sudo echo "deb https://apt.enpass.io/ stable main" > /etc/apt/sources.list.d/enpass.list
sudo wget -O - https://apt.enpass.io/keys/enpass-linux.key | apt-key add -
sudo apt-get update
sudo apt-get install enpass -y

echo '#######################################################'
echo 'Installing Latex'
echo ''
sudo apt-get install texlive texlive-full -y
# for work with graphics
sudo apt-get install imagemagick -y
sudo apt-get install texstudio -y

echo '#######################################################'
echo 'Installing Twinux'
echo ''
sudo snap install twinux -y

echo '#######################################################'
echo 'Installing Calibre for reading e-books'
echo ''
sudo apt-get install calibre -y

echo '#######################################################'
echo 'Installing Rclone browser for working with cloud'
echo ''
curl https://rclone.org/install.sh | sudo bash

echo '#######################################################'
echo 'Installing Discord'
echo ''
sudo snap install discord -y

echo '#######################################################'
echo 'installing photogimp'
echo ''
sudo snap install photogimp -y

echo '#######################################################'
echo 'Installing buffer translator'
echo ''
echo 'install xsel for capture buffer string'
sudo apt-get install xsel -y
echo 'install zenity for show dialog screen'
sudo apt-get install zenity
echo 'create translator script file with name notitrans in home path'
cat <<EOT >> ~/notitrans
#!/usr/bin/env bash

text="$(xsel -o)"

translate="$(wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=ru&dt=t&q=$(echo $text | sed "s/[\"'<>]//g")" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2, $6}')"

echo -e "Original text:" "$text"'\n' > /tmp/notitrans

formatstring=$(echo $translate | sed 's/21791a8d07c2303bc1a3f9824e6ec4be//g' | sed 's/en en en//')
echo "Translation: " "$formatstring" >> /tmp/notitrans

zenity --text-info --title="Translation" --filename=/tmp/notitrans

EOT
echo 'make script notitrans executable'
chmod +x ~/notitrans
echo 'move script into /usr/local/bin/'
sudo mv ~/notitrans /usr/local/bin/
echo 'dont forget bind key for translate text an example make ctrl+shift+>'

echo '#######################################################'
echo 'Installing Slack'
echo ''
sudo snap install slack --classic -y

echo '#######################################################'
echo 'Installing Telegramm-desktop'
echo ''
sudo snap install telegram-desktop -y

echo '#######################################################'
echo 'Installing Zoom'
echo ''
wget -O Downloads/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
cd Downloads
sudo dpkg -i zoom.deb
cd ~

echo '#######################################################'
echo 'Installing Xfburn for burn CD/DVD'
echo ''
sudo apt-get install xfburn -y

echo '#######################################################'
echo 'Installing Tilda shell'
echo ''
sudo apt-get install tilda -y

echo '#######################################################'
echo 'Installing SimpleScreenRecorder'
echo ''
sudo apt-get install simplescreenrecorder -y

echo '#######################################################'
echo 'Installing TeamViewer'
echo ''
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install ./teamviewer_amd64.deb -y

echo '#######################################################'
echo 'Installing Figma-linux'
echo ''
sudo snap install figma-linux -y

echo '#######################################################'
echo 'Installing Anbox'
echo ''
sudo snap install anbox --beta -y

echo '#######################################################'
echo 'Installing KeyStore Explorer for explore android keystores'
echo ''
wget https://github.com/kaikramer/keystore-explorer/releases/download/v5.4.3/kse-5.4.3.deb
sudo apt install ./kse-5.4.3.deb -y

echo '#######################################################'
echo 'Installing JD-GUI'
echo ''
wget https://github.com/java-decompiler/jd-gui/releases/download/v1.6.6/jd-gui-1.6.6.deb
sudo apt install ./jd-gui-1.6.6.deb -y

echo '#######################################################'
echo 'Installing JaDX'
echo ''
cd /usr/local/bin/
sudo wget https://github.com/skylot/jadx/releases/download/v1.1.0/jadx-1.1.0.zip
sudo unzip jadx-1.1.0.zip -d jadx-1.1.0
sudo rm jadx-1.1.0.zip
sudo ln -s jadx-1.1.0/bin/jadx jadx
sudo ln -s jadx-1.1.0/bin/jadx-gui jadx-gui
echo 'JaDx-GUI success installed'

echo 'Installing FINISHED - congratulation'
