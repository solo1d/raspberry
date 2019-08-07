# 树莓派开AP \(变路由器\)

```bash
树莓派3B把WiFi设置成AP模式网上基本有两种方案，一种是手动一步步设置，
  另外一种是直接使用git上一个开源的包。我是使用第二种，一试就成功了非常好用。

#安装依赖的库
$apt-get install util-Linux procps hostapd iproute2 iw haveged dnsmasq


#将代码copy到本地，安装
$git clone https://github.com/oblique/create_ap
$cd create_ap
$make install


#创建WiFi热点（GitHub上有多种方式创建，可以查找自己需要的那种）
sudo create_ap wlan0 eth0 热点名 密码

#开机启动
将sudo create_ap wlan0 eth0 热点名 密码 添加到/etc/rc.local当中，即可开机启动


关闭无线AP 开机启动服务
sudo systemctl stop create_ap.service
开启无线AP 开机启动服务
sudo systemctl start create_ap.service


原文：https://blog.csdn.net/Leo_Luo1/article/details/78811294 

```



