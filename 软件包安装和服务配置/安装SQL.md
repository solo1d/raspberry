# 安装SQL

```bash
需求
在树莓派上 安装Mysql 服务，并开启远程访问
本地访问mysql命令 $mysql -uroot -p
远程访问mysql命令 $mysql -h 地址 -u用户 -p

步骤
安装 mysql server

# 社区下载网页
# https://dev.mysql.com/downloads/file/?id=519241
wget https://dev.mysql.com/get/mysql-apt-config_0.8.25-1_all.deb

sudo dpkg -i ./mysql-apt-config_0.8.25-1_all.deb 
sudo apt-get update
sudo apt-get install mysql-server mysql-sclient


我以为中间会让我提示输入 数据库root的密码，没想到一帆风顺，直接完成，我要疯了，密码到底是什么了。
  通过搜索发现，可以使用如下命令，空密码登录
$ sudo mysql -u root

#设置root密码.
use mysql;
update user set host='%' where user ='root';  #更新域属性，'%'表示允许外部访问
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY "新密码";
flush privileges;

#设置账号可以远程登录
use mysql;
update user set host='%' where user ='root';  #更新域属性，'%'表示允许外部访问
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'WITH GRANT OPTION;
flush privileges;
exit;
#然后进行下面的步骤,完成后就可以使用其他客户端直接连接了


#重启mysql服务,让其刷新配置.
$sudo systemctl restart  mysql.service 

关闭mysql 开机启动服务
$sudo systemctl stop mysql

开启mysql 开机启动服务
$sudo systemctl start mysql

```

