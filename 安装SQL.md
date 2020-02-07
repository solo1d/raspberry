# 安装SQL

```bash
需求
在树莓派上 安装Mysql 服务，并开启远程访问
本地访问mysql命令 $mysql -uroot -p
远程访问mysql命令 $mysql -h 地址 -u用户 -p

步骤
安装 mysql server

$ sudo apt-get install mysql-server


我以为中间会让我提示输入 数据库root的密码，没想到一帆风顺，直接完成，我要疯了，密码到底是什么了。
    通过搜索发现，可以使用如下命令，空密码登录
$ sudo mysql -u root

#设置root密码.
use mysql;
update user set plugin='mysql_native_password' where user='root';
UPDATE user SET password=PASSWORD('你自己的密码') WHERE user='root';
flush privileges;

#设置账号可以远程登录
use mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root账号密码' WITH GRANT OPTION;
flush privileges;
exit;
#然后进行下面的步骤,完成后就可以使用其他客户端直接连接了

#开启mysql远程访问
$ sudo vim /etc/mysql/mariadb.conf.d/50-server.cnf
#找到文件中的 bind-address 并且这行注释掉,然后重启

#重启mysql服务,让其刷新配置.
$ sudo /etc/init.d/mysql restart


关闭mysql 开机启动服务
sudo systemctl stop mysqld

开启mysql 开机启动服务
sudo systemctl start mysqld

```

