#!/bin/bash

# prepare ssh server
mkdir -p /var/run/sshd

# start up supervisord, all daemons should launched by supervisord.
/usr/bin/supervisord -c /root/supervisord.conf

echo "CATALINA_HOME=/opt/apache-tomcat9" >>/etc/environment
sed -i 's/^..tomcat-users.//g' /opt/apache-tomcat9/conf/tomcat-users.xml
echo -e "\\x3c\\x21-- user manager can access only manager section --\\x3e" >>/opt/apache-tomcat9/conf/tomcat-users.xml
echo -e "\\x3crole rolename=\"manager-gui\" /\\x3e" >>/opt/apache-tomcat9/conf/tomcat-users.xml
echo -e "\\x3cuser username=\"manager\" password=\"\" roles=\"manager-gui\" /\\x3e" >>/opt/apache-tomcat9/conf/tomcat-users.xml
echo -e "\\x3crole rolename=\"admin-gui\" /\\x3e" >>/opt/apache-tomcat9/conf/tomcat-users.xml
echo -e "\\x3cuser username=\"admin\" password=\"\" roles=\"manager-gui,admin-gui\" /\\x3e" >>/opt/apache-tomcat9/conf/tomcat-users.xml
echo -e "\\x3c/tomcat-users\\x3e" >>/opt/apache-tomcat9/conf/tomcat-users.xml

# start up tomcat 
/opt/apache-tomcat9/bin/startup.sh

# setup firewall
ufw app info "Apache Full"
ufw allow in "Apache Full"
ufw enable
ufw allow 3306
ufw allow 5900
ufw allow 22
apt-get update && apt-get upgrade -y

# start mysql
/etc/init.d/mysql start

# install phpmyadmin
apt-get install -y phpmyadmin php-mbstring php-gettext
phpenmod mcrypt
phpenmod mbstring
echo "Include /etc/phpmyadmin/apache.conf" >>/etc/apache2/apache2.conf
sed -i "s/\/\/ .cfg..Servers....i...AllowNoPassword.. . TRUE/\$cfg['Servers'][\$i]['AllowNoPassword'] = TRUE/g" /etc/phpmyadmin/config.inc.php

# start apache
/etc/init.d/apache2 start

# informations
echo "usuários admin e manager foram criados sem senha com acesso ao tomcat"
echo "usuário root foi criado sem senha para acesso ao mysql via phpmyadmin"

# start a shell
/bin/bash
