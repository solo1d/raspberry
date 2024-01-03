# 树莓派开AP \(变路由器\)

```bash
树莓派3B把WiFi设置成AP模式网上基本有两种方案，一种是手动一步步设置，
  另外一种是直接使用git上一个开源的包。我是使用第二种，一试就成功了非常好用。

#安装依赖的库
$ sudo apt-get install util-linux procps hostapd iproute2 iw haveged dnsmasq iptables


#将代码copy到本地，安装
$git clone https://github.com/oblique/create_ap
$cd create_ap
$make install -dm 775
#执行完这些命令后,会后很多错误之类的, 直接无视就好了.因为是没有影响.


#创建 WiFi热点（GitHub上有多种方式创建，可以查找自己需要的那种）SSID 和 passwd
sudo create_ap wlan0 eth0 热点名 密码

#创建 5G WiFI热点  (3B+)
sudo create_ap --ieee80211n --ht_capab '[HT40+]' --freq-band 5  wlan0 eth0  热点名 密码


开机启动的方法很多, 但是只能使用一种. ( 直接使用 systemctl 命令作为妥当 )
  首先使用写入 rc.local 文件来进行开机启动, 随后进行重启.
        如果不成功( 就是没有 wlan0 这个网口或wifi), 再进行更换.
  下面就是systemctl 命令来进行

#开机启动, 将下面的命令添加到 /etc/rc.local 当中，即可开机启动
sudo create_ap --ieee80211n --ht_capab '[HT40+]' --freq-band 5  wlan0 eth0  热点名 密码

#如果还是无法开机启动,那么可以尝试下面的命令组合.
   首先将在下载到本地的 create_ap 目录中的 create_ap.service  拷贝到 /lib/systemd/system/ 中
           sudo cp  create_ap/create_ap.service   /lib/systemd/system/
   随后执行下面命令
sudo systemctl daemon-reload
sudo systemctl enable create_ap.service
sudo systemctl start create_ap.service

#关闭无线AP 开机启动服务
sudo systemctl stop create_ap.service
#开启无线AP 开机启动服务
sudo systemctl start create_ap.service


#配置文件目录, 在里面修改热点名和密码还有5G接入点, 以及默认IP 地址池
sudo  vim /etc/create_ap.conf 

#配置文件,尽量这样写
CHANNEL=default
GATEWAY=192.168.1.1
WPA_VERSION=2
ETC_HOSTS=0
DHCP_DNS=gateway
NO_DNS=0
NO_DNSMASQ=0
HIDDEN=0
MAC_FILTER=0
MAC_FILTER_ACCEPT=/etc/hostapd/hostapd.accept
ISOLATE_CLIENTS=0
SHARE_METHOD=nat
IEEE80211N=1
IEEE80211AC=0
HT_CAPAB=[HT40+]
VHT_CAPAB=
DRIVER=nl80211
NO_VIRT=0
COUNTRY=
FREQ_BAND=5
NEW_MACADDR=
DAEMONIZE=0
NO_HAVEGED=0
WIFI_IFACE=wlan0
INTERNET_IFACE=eth0
SSID=aaaa1111
PASSPHRASE=aaaa1111
USE_PSK=0
```





## 使用create_ap开启热点，关闭后，无法连接wifi的解决方案

使用sudo rfkill list all发现wifi没有被锁住，使用 sudo service network-manager start也无法解决问题

后来使用create_ap -h查看此软件的相关帮助，其中有

--fix-unmanaged If NetworkManager shows your interface as unmanaged after you
close create_ap, then use this option to switch your interface
back to managed

然后使用  `sudo create_ap --fix-unmanaged` ，解决了此问题

