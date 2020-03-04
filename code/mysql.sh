#install server
sudo apt-get update
sudo apt-get install mysql-server

sudo mysql_secure_installation
#after install your need enter root password: for example, i use an ovsyaniy password

#check service status
sudo service mysql status
#login to mysql server with your password
mysql -u root -p
#check what charset using by server
#character_set_database/server must provide utf8

show variables like 'char%';
#if thats not the case you need go to the /etc/mysql/conf.d/
#add file utf8_set.cnf
cd /etc/mysql/conf.d/
sudo touch utf8_set.cnf

#add in the file following srings

"[mysqld]" >> utf8_set.cnf
"character-set-server=utf8" >> utf8_set.cnf
"collation-server=utf8_general_ci" >> utf8_set.cnf

#then restart mysql server
sudo service mysql restart

#and check changes
mysql -u root -ppassword -e "show variables like 'char%'"

#well, you need change config mysql file also
#go to /etc/mysql/mysql.conf.d
#and add following string to mysqld.cnf file
"default_authentication_plugin=mysql_native_password" >> mysqld.cnf
