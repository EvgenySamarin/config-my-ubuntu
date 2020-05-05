#!/bin/bash

##
# Initial config for auto installing programms
#
# Dont forget make this file executable: chmod +x ./имя_скрипта#
# run file with superuser rights 
# sudo ./client-config.sh
#
echo '##'
echo '## Welcome to auto-installing script ver 1.0.2 at 05.05.2020'
echo '##'

# refresh apt repositories
sudo apt-get update

# TODO: добавить условие на установку пакетов каждого пакета
echo '##'
echo '#######################################################'
echo '## 1. Installing Synaptic:'
echo '##'
sudo apt-get install synaptic -y

echo '##'
echo '#######################################################'
echo '## 2. Installing PHP 5.6'
echo '##'
sudo apt-get install software-properties-common -y
# add legacy ppa repository
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update 
sudo apt-get install php5.6 -y

echo '##'
echo '#######################################################'
echo '## 3. Installing MySQL server'
echo '##'
sudo apt-get install mysql-server -y
sudo mysql_secure_installation
# after install your need enter root password
echo '##'
echo '## check msql-server service status'
echo '##'
sudo service mysql status
echo '##'
echo '## check current utf8 charset'
echo '## Enter current mysql root password: '
# check to contains utf8 like argument
# TODO: добавить проверку на вход без пароля
msqlCharsets=$(echo "show variables like 'char%';" | mysql -u root -p)
findCharset=utf8
pathCharsetConfigFile="/etc/mysql/conf.d/utf8_set.cnf"
if echo "$msqlcharsets" | grep -q $findCharset 
  then echo '##'; echo "## $findCharset contains into current mysql configuration no additional configuration is required"; echo '##'
  else echo '##'; echo "## $findCharset does not exists"; echo '##'; sudo touch $pathCharsetConfigFile; echo "[mysqld]" | sudo tee -a $pathCharsetConfigFile; echo "character-set-server=utf8" | sudo tee -a $pathCharsetConfigFile; "collation-server=utf8_general_ci" | sudo tee -a $pathCharsetConfigFile; sudo service mysql restart           fi
# also u need to add following string to mysqld.cnf file for loggin by simple password
echo "default_authentication_plugin=mysql_native_password" | sudo tee -a /etc/mysql/mysql.conf.d/mysqld.cnf

echo '##'
echo '#######################################################'
echo '## 4. Installing Git'
echo '##'
sudo apt-get install git -y

echo '##'
echo '#######################################################'
echo '## 5. Installing Postman'
echo '##'
sudo snap install postman 

echo '##'
echo '#######################################################'
echo '## 6. Installing curl'
echo '##'
sudo apt-get install curl -y

echo '##'
echo '#######################################################'
echo '## 7. Intalling Vim'
echo '##'
sudo apt-get install vim -y
echo '##'
echo "## Install vim plug manager"
echo '##'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo '##'
echo "## Create config file for vim, which locate into home dir with names: .vimrc"
echo '##'
# TODO: решить проблему - почему-то не создается файл командой cat
vimrcPath="~/.vimrc"
if [ -e $vimrcPath ]
  then echo '##'; echo "## file .vimrc is exists"; echo '##' 
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
echo '##'
echo "## Install added plugins"
echo '##'
vim +'PlugInstall --sync' +qall &> /dev/null
fi

echo '##'
echo '#######################################################'
echo '## 8. Installing Fish'
echo '##'
sudo apt-get install fish -y
echo '##'
echo '## installing oh my fish'
echo '##'
# Oh my fish config locate in ~/.config/omf directory
curl -L https://get.oh-my.fish | fish
echo '##'
echo '## install fonts-powerline for agnoster fish theme'
echo '##'
sudo apt-get install fonts-powerline -y
echo '##'
echo '## install omf agnoster theme from bash not allowed'
echo '## You need install it from fish shell directly. It so SAD'
echo '##'
# foolowing steps resolve it:
# fish 
# omf update
# omf install agnoster

echo '##'
echo '#######################################################'
echo '## 9. Installing Ranger'
echo '##'
sudo apt-get install ranger -y

echo '##'
echo '#######################################################'
echo '## 10. Installing DBeaver Community '
echo '##'
sudo snap install dbeaver-ce

echo '##'
echo '#######################################################'
echo '## 11. Installing Virtual machines manager'
echo '##'
sudo apt-get install qemu-kvm -y
sudo apt-get install virt-manager -y
sudo apt install bridge-utils -y
echo '##'
echo '## verify kvm installation'
echo '##'
kvm-ok

echo '##'
echo '#######################################################'
echo '## 12. Installing Enpass'
echo '##'
# TODO: енпасс устанавливается, но для него нужно логиниться под правами суперпользователя (обязательно)
sudo echo "deb https://apt.enpass.io/ stable main" > /etc/apt/sources.list.d/enpass.list
sudo wget -O - https://apt.enpass.io/keys/enpass-linux.key | apt-key add -
sudo apt-get update
sudo apt-get install enpass -y

echo '##'
echo '#######################################################'
echo '## 13. Installing Latex'
echo '##'
sudo apt-get install texlive texlive-full -y
# for work with graphics
sudo apt-get install imagemagick -y
sudo apt-get install texstudio -y

echo '##'
echo '#######################################################'
echo '## 14. Installing Twinux'
echo '##'
sudo snap install twinux

echo '##'
echo '#######################################################'
echo '## 15. Installing Calibre for reading e-books'
echo '##'
sudo apt-get install calibre -y

echo '##'
echo '#######################################################'
echo '## 16. Installing Rclone browser for working with cloud'
echo '##'
curl https://rclone.org/install.sh | sudo bash
sudo apt update && sudo apt -y install git g++ qtdeclarative5-dev
git clone https://github.com/kapitainsky/RcloneBrowser.git
cd RcloneBrowser
mkdir build && cd build
cmake ..
make
sudo make install
cd ~

echo '##'
echo '#######################################################'
echo '## 17. Installing Discord'
echo '##'
sudo snap install discord

echo '##'
echo '#######################################################'
echo '## 18. Installing photogimp'
echo '##'
sudo snap install photogimp

echo '##'
echo '#######################################################'
echo '## 19. Installing buffer translator'
echo '##'
echo '## install xsel for capture buffer string'
sudo apt-get install xsel -y
echo '##'
echo '## install zenity for show dialog screen'
echo '##'
sudo apt-get install zenity
echo '##'
echo '## create translator script file with name notitrans in home path'
echo '##'
# TODO: проверь - вероятно скрипт не создался - нужно экранировать символы
cat <<EOT >> ~/notitrans
#!/usr/bin/env bash

text="$(xsel -o)"

translate="$(wget -U "Mozilla/5.0" -qO - "http://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=ru&dt=t&q=$(echo $text | sed "s/[\"'<>]//g")" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2, $6}')"

echo -e "Original text:" "$text"'\n' > /tmp/notitrans

formatstring=$(echo $translate | sed 's/21791a8d07c2303bc1a3f9824e6ec4be//g' | sed 's/en en en//')
echo "Translation: " "$formatstring" >> /tmp/notitrans

zenity --text-info --title="Translation" --filename=/tmp/notitrans

EOT
echo '##'
echo '## make script notitrans executable'
echo '##'
chmod +x ~/notitrans
echo '##'
echo '## move script into /usr/local/bin/'
echo '##'
sudo mv ~/notitrans /usr/local/bin/
echo '##'
echo '## dont forget bind key for translate text an example make ctrl+shift+>'
echo '##'

echo '##'
echo '#######################################################'
echo '## 20. Installing Slack'
echo '##'
sudo snap install slack --classic

echo '##'
echo '#######################################################'
echo '## 21. Installing Telegramm-desktop'
echo '##'
sudo snap install telegram-desktop

echo '##'
echo '#######################################################'
echo '## 22. Installing Zoom'
echo '##'
# TODO: решить проблему с установкой через терминал
wget -O Downloads/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
cd Downloads
sudo dpkg -i zoom.deb
cd ~

echo '##'
echo '#######################################################'
echo '## 23. Installing Xfburn for burn CD/DVD'
echo '##'
sudo apt-get install xfburn -y

echo '##'
echo '#######################################################'
echo '## 24. Installing Tilda shell'
echo '##'
sudo apt-get install tilda -y

echo '##'
echo '#######################################################'
echo '## 25. Installing SimpleScreenRecorder'
echo '##'
sudo apt-get install simplescreenrecorder -y

echo '##'
echo '#######################################################'
echo '## 26. Installing TeamViewer'
echo '##'
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install ./teamviewer_amd64.deb -y

echo '##'
echo '#######################################################'
echo '## 27. Installing Figma-linux'
echo '##'
sudo snap install figma-linux

echo '##'
echo '#######################################################'
echo '## 28. Installing Anbox'
echo '##'
sudo snap install anbox --beta

echo '##'
echo '#######################################################'
echo '## 29. Installing KeyStore Explorer for explore android keystores'
echo '##'
wget https://github.com/kaikramer/keystore-explorer/releases/download/v5.4.3/kse-5.4.3.deb
sudo apt install ./kse-5.4.3.deb -y

echo '##'
echo '#######################################################'
echo '## 30. Installing JD-GUI'
echo '##'
wget https://github.com/java-decompiler/jd-gui/releases/download/v1.6.6/jd-gui-1.6.6.deb
sudo apt install ./jd-gui-1.6.6.deb -y

echo '##'
echo '#######################################################'
echo '## 31. Installing JaDX'
echo '##'
cd /usr/local/bin/
sudo wget https://github.com/skylot/jadx/releases/download/v1.1.0/jadx-1.1.0.zip
sudo unzip jadx-1.1.0.zip -d jadx-1.1.0
sudo rm jadx-1.1.0.zip
sudo ln -s jadx-1.1.0/bin/jadx jadx
sudo ln -s jadx-1.1.0/bin/jadx-gui jadx-gui
echo '##'
echo '## JaDx-GUI success installed'
echo '##'
# TODO: добавить скрипт для создания ярлыка в меню приложений

echo '##'
echo '#######################################################'
echo '## 32. Installing Gnome-tweak-tools for swap caps and control'
echo '##'
sudo apt-get install gnome-tweak-tool -y

echo '##'
echo '#######################################################'
echo '## 33. Installing VS Code'
echo '##'
sudo snap install --classic code # or code insiders

echo '##'
echo '## Installing FINISHED - congratulation'
echo '#######################################################'
