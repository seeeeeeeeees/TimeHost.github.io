#!/bin/sh
LOG_PIPE=log.pipe
mkfifo ${LOG_PIPE}
LOG_FILE=log.file
rm -f LOG_FILE
tee < ${LOG_PIPE} ${LOG_FILE} &
exec  > ${LOG_PIPE}
exec  2> ${LOG_PIPE}
Infon() {
	printf "\033[1;32m$@\033[0m"
}
Info()
{
	Infon "\031$@\n"
}
Error()
{
	printf "\033[1;31m$@\033[0m\n"
}
Error_n()
{
	Error "$@"
}
Error_s()
{
	Error "${red}===========================================================${reset}"
}
log_s()
{
	Info "${green}=========================================================== ${reset}"
}
cp_s ()
{
	Info "${green}===================${white}vk.com/niktalol${green}======================${reset}"
}
log_n()
{
	Info "- - - $@"
}
log_t()
{
	log_s
	Info "- - - $@ - - -"
	log_s
}
RED=$(tput setaf 1)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
white=$(tput setaf 7)
reset=$(tput sgr0)
toend=$(tput hpa $(tput cols))$(tput cub 6)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
LIME_YELLOW=$(tput setaf 190)
CYAN=$(tput setaf 6)

UPD="0"
upd()
{
	if [ "$UPD" = "0" ]; then
		echo "• Обновляем ${green}список пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		UPD="1"
	fi
}
menu()
{
	clear
	Info
	log_t "${white}Автор установщика ${YELLOW}Артем Ахраменко ${white}Автор доработки панели ${YELLOW}GamiR Channel"
	log_t "${white}Добро пожаловать в меню установки ${red}zellhost v1.0.1${green}"
	Info "-${YELLOW} 1${green} -  ${white}Установка и настройка панели управления ${red} zellhost v1.0.1"
	Info "- ${YELLOW}2${green} -  ${white}Настройка серверной части для ${red}zellhost v1.0.1"
	Info "- ${YELLOW}0${green} -  ${white}Выход"
	cp_s
	Info
	read -p "${white}Пожалуйста, введите пункт меню:" case
	case $case in
		1) Info "${white}Здравствуйте, данный скрипт установит ${red} zellhost v1.0.1 ${white}за Вас!"
	read -p "${white}Пожалуйста, введите домен или IP:${reset}" DOMAIN
	read -p "${white}Пожалуйста, введите код для кронов (например MYTOKEN):${reset}" CRONTOKE
	echo "• Обновляем ${green}список пакетов! •"
	apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем пакет ${green}apt-utils! •"
	apt-get install -y apt-utils > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем пакет ${green}pwgen! •"
	apt-get install -y pwgen > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем пакет ${green}dialog! •"
	apt-get install -y dialog > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	MYPASS=$(pwgen -cns -1 10)
	MYPASS2=$(pwgen -cns -1 10)
	OS=$(lsb_release -s -i -c -r | xargs echo |sed 's; ;-;g' | grep Ubuntu)
	if [ "$OS" = "" ]; then
		echo "deb http://packages.dotdeb.org wheezy-php55 all">"/etc/apt/sources.list.d/dotdeb.list"
		echo "deb-src http://packages.dotdeb.org wheezy-php55 all">>"/etc/apt/sources.list.d/dotdeb.list"
		echo "• Скачиваем ${green}Dotdeb! •"
		wget http://www.dotdeb.org/dotdeb.gpg > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo "• Активируем ${green}Dotdeb! •"
		apt-key add dotdeb.gpg > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		rm dotdeb.gpg
		echo "• Обновляем ${green}список пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	fi
	echo "• Обновляем ${green}пакеты! •"
	apt-get upgrade -y > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Ставим пароль на ${green}mysql! •"
	echo mysql-server mysql-server/root_password select "$MYPASS" | debconf-set-selections > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Ставим повторно пароль на ${green}mysql! •"
	echo mysql-server mysql-server/root_password_again select "$MYPASS" | debconf-set-selections > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Проверяем ${green}установку! •"
	apt-get -f install > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем пакеты ${green}apache2 php5 php5-dev cron unzip sudo mysql-server fail2ban curl php5-curl php5-gd mysql-workbench! •"
	apt-get install -y apache2 php5 php5-dev cron unzip sudo mysql-server fail2ban curl php5-curl php5-gd mysql-workbench > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		cd /root
		echo "• Скачиваем ${green}php-ssh2! •"
		wget http://ftp.us.debian.org/debian/pool/main/p/php-ssh2/php5-ssh2_0.12-3+deb8u1_amd64.deb > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo "• Устанавливаем пакет ${green}php5-ssh2! •"
		dpkg -i /root/php5-ssh2_0.12-3+deb8u1_amd64.deb > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Удаление установочника ${green}php5-ssh2! •"
	echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYPASS" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYPASS" |debconf-set-selections
	echo "phpmyadmin phpmyadmin/app-password-confirm password $MYPASS" | debconf-set-selections
	echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
   echo "• Устанавливаем пакет ${green}phpmyadmin! •"
	apt-get install -y phpmyadmin > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
   echo "• Перезагрузка ${green}apache! •"
   service apache2 restart > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
   cd /etc/apache2/sites-available/
   touch panel.conf
  	FILE='panel.conf'
		echo "<VirtualHost *:80>">>$FILE
		echo "ServerAdmin webmaster@localhost">>$FILE
		echo "ServerAlias $DOMAIN">>$FILE
		echo "DocumentRoot /var/www">>$FILE
		echo "<Directory /var/www/>">>$FILE
		echo "Options Indexes FollowSymLinks">>$FILE
		echo "AllowOverride All">>$FILE
		echo "Require all granted">>$FILE
		echo "</Directory>">>$FILE
		echo "ErrorLog ${APACHE_LOG_DIR}/error.log">>$FILE
		echo "CustomLog ${APACHE_LOG_DIR}/access.log combined">>$FILE
		echo "</VirtualHost>">>$FILE
    cd 
	echo "• Подключаем сайт ${green}panel! •"
	a2ensite panel > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Отключаем сайт ${green}000-default! •"
	a2dissite 000-default > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Включаем мод ${green}rewrite! •"
	a2enmod rewrite > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Включаем мод ${green}php5! •"
	a2enmod php5 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Включаем ${green}short_open_tab! •"
	sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php5/apache2/php.ini	> /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Перезапускаем ${green}apache! •"
	service apache2 restart > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
   (crontab -l ; echo "0 12 * * * curl http://$DOMAIN/main/cron/index?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "*/1 * * * * curl http://$DOMAIN/main/cron/updateSystemLoad?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "0 */1 * * * curl http://$DOMAIN/main/cron/updateStats?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "0 */10 * * * curl http://$DOMAIN/main/cron/serverReloader?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "0 12 * * * curl http://$DOMAIN/main/cron/gamelocationstatsupd?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "0 * 7 * * curl http://$DOMAIN/main/cron/clearLogs?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	echo "• Устанавливаем пакет ${green}zip unzip! •"
	apt-get install -y zip unzip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Создание папки ${green}/var/www! •"
	mkdir /var/www/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${green}[Папка существует]"
		tput sgr0
	fi
	cd /var/www/
	echo "• Скачиваем ${green}zellhost! •"
	wget https://vipadmin.club/uploads/files/2017-01/1483612563_zellhost.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Распаковываем ${green}zellhost.zip! •"
	unzip 1483612563_zellhost.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Удаляем ${green}zellhost.zip! •"
	rm 1483612563_zellhost.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Настраиваем ${green}панель! •"
	echo "• Вводим пароль от ${green}mysql-server! •"
    sed -i "s/samsara/${MYPASS}/g" /var/www/application/config.php > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Вводим ${green}домен! •"
	sed -i "s/site.com/${DOMAIN}/g" /var/www/application/config.php > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Вводим код ${green}кронов! •"
	sed -i "s/jtonTr8CFlh4sUs/${CRONTOKE}/g" /var/www/application/config.php > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	chmod -R 755 /var/www/
	cd
	echo "• Создание папки ${green}/var/lib/mysql/zellhost! •"
	mkdir /var/lib/mysql/mosga > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${green}[Папка существует]"
		tput sgr0
	fi
	chown -R mysql:mysql /var/lib/mysql/mosga
    cd	
	echo "• Скачиваем ${green}zellhost.sql! •"
	wget https://our.clan.su/litepanel.sql > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	cd
	echo "• Заливаем ${green}zellhost! •"
	mysql -u root -p$MYPASS mosga < litepanel.sql > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Удаляем ${green}zellhost.sql! •"
	rm litepanel.sql > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	chown -R www-data:www-data /var/www/
	chmod -R 755 /var/www/
	
	echo "• Настройка серверной части! •"
	echo "• Настройка серверной части! •"
	echo "• Настройка серверной части! •"
	
	echo "• Создание папки ${green}/home! •"
		mkdir -p /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${green}[Папка существует]"
		tput sgr0
	fi
		echo "• Созлаем группу ${green}gameservers! •"
		groupadd gameservers > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo "• Обновляем ${green}список пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем ${green}sudo zip unzip openssh-server python3 screen! •"
		apt-get install -y sudo zip unzip openssh-server python3 screen > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
		echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
		echo "• Обновляем ${green}список пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd /home/
			echo "• Скачиваем ${green}hostplcp! •"
			wget http://repo.gmskill.ru/hostinpl/hostplcp.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			echo "• Распаковываем ${green}hostplcp! •"
			unzip hostplcp.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			rm hostplcp.zip
			echo "• Выдаем права ${green}на папки и файлы! •"
			chown -R root /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	        chmod -R 755 /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd
			cd /home/cp/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			chmod -R 700 /home/cp/gameservers.py > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd			
		OS=$(lsb_release -s -i -c -r | xargs echo |sed 's; ;-;g' | grep Ubuntu)
		echo "• Добавляем пакеты ${green}x32! •"
	sudo dpkg --add-architecture i386 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Обновляем ${green}список пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем ${green}libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386! •"
    sudo apt-get install -y libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Запрещаем доступ к ssh группе ${green}gameservers! •"
    echo 'DenyGroups gameservers' » /etc/ssh/sshd_config	 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Обновляем ${green}список пакетов! •"
	apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем ${green}pure-ftpd! •"
	apt-get install -y pure-ftpd > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
	echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir
	echo "yes" > /etc/pure-ftpd/conf/DontResolve 
	echo "• Перезагружаем ${green}pure-ftpd! •"
	/etc/init.d/pure-ftpd restart > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Сохранение данных от панели! •"
	cd ~
	echo "• Создаем файл для сохранения данных! •"
	touch passwords.conf > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
  	SAVEPASS='passwords.conf'
		echo "Данные от панели:">>$SAVEPASS
		echo "Домен - $DOMAIN">>$SAVEPASS
		echo "Код от крона - $CRONTOKE">>$SAVEPASS
		echo "Пароль от mysql - $MYPASS">>$SAVEPASS
		echo "Логин администратора - admin@mail.ru">>$SAVEPASS
		echo "Пароль администратора - 123123">>$SAVEPASS

		log_s
		log_n "${white}Панель управления ${red} zellhost v1.0.1 ${white} установлена и настроена!"
		log_n ""
		log_n "${white} Root пароль от ${red} MySQL${white}: $MYPASS"
		log_n ""
		log_n "${white} Ссылка на ${red} zellhost v1.0.1: ${white}http://$DOMAIN"
		log_n "${white} Выдели и нажми Ctrl+C далее нажми правой кнопкой мышки (вставить)"
		log_n ""
		log_n "${white} Логин администратора: ${white}admin@mail.ru"
		log_n "${white} Пароль администратора: ${white}123123"
		log_n " Пароль и логин поменять на свой если не хотите чтобы вас взломали и получили доступ"
		cp_s
		rm -f LOG_PIPE
	;;
		2) echo "• Создание папки ${green}/home! •"
		mkdir -p /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${green}[Папка существует]"
		tput sgr0
	fi
		echo "• Созлаем группу ${green}gameservers! •"
		groupadd gameservers > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo "• Обновляем ${green}список пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем ${green}sudo zip unzip openssh-server python3 screen! •"
		apt-get install -y sudo zip unzip openssh-server python3 screen > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
		echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
		echo "• Обновляем ${green}список пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd /home/
			echo "• Скачиваем ${green}hostplcp! •"
			wget http://repo.gmskill.ru/hostinpl/hostplcp.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			echo "• Распаковываем ${green}hostplcp! •"
			unzip hostplcp.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			rm hostplcp.zip
			echo "• Выдаем права ${green}на папки и файлы! •"
			chown -R root /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	        chmod -R 755 /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd
			cd /home/cp/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			chmod -R 700 /home/cp/gameservers.py > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd			
		OS=$(lsb_release -s -i -c -r | xargs echo |sed 's; ;-;g' | grep Ubuntu)
		echo "• Добавляем пакеты ${green}x32! •"
	sudo dpkg --add-architecture i386 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Обновляем ${green}список пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем ${green}libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386! •"
    sudo apt-get install -y libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Запрещаем доступ к ssh группе ${green}gameservers! •"
    echo 'DenyGroups gameservers' » /etc/ssh/sshd_config	 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Обновляем ${green}список пакетов! •"
	apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Устанавливаем ${green}pure-ftpd! •"
	apt-get install -y pure-ftpd > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
	echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir
	echo "yes" > /etc/pure-ftpd/conf/DontResolve 
	echo "• Перезагружаем ${green}pure-ftpd! •"
	/etc/init.d/pure-ftpd restart > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			;;
	
		0) exit;;
	esac
}
menu