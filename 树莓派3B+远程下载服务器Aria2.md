# 树莓派3B+ 远程下载服务器（Aria2）

## 1.安装aria2

{% hint style="info" %}
 附：aira2官方仓库:[https://github.com/aria2/aria2/](https://github.com/aria2/aria2/) 

附：静态编译ARM树莓派:[ https://github.com/q3aql/aria2-static-builds/releases/download/v1.32.0/aria2-1.32.0-linux-gnu-arm-rbpi-build1.tar.bz2 ](https://github.com/q3aql/aria2-static-builds/releases/download/v1.34.0/aria2-1.34.0-linux-gnu-arm-rbpi-build1.tar.bz2)
{% endhint %}

{% file src=".gitbook/assets/aria2-1.34.0-linux-gnu-arm-rbpi-build1.tar.bz2" caption="static\_静态编译版aria2.tar.bz2" %}

### 教程使用的是直接安装软件源： 

```bash
$sudo apt install -y aria2 
```

{% hint style="info" %}
首先:

创建文件夹`mkdir -p ~/.config/aria2/`  
添加一个aria配置文件`vim ~/.config/aria2/aria2.config`

aria2.config  将要写入的内容如下:  \(要不把中文备注写入配置文件.\)
{% endhint %}

```bash
#后台运行
daemon=true
#用户名
#rpc-user=user
#密码
#rpc-passwd=passwd
#设置加密的密钥
rpc-secret=secret
#允许rpc
enable-rpc=true
#允许所有来源, web界面跨域权限需要
rpc-allow-origin-all=true
#是否启用https加密，启用之后要设置公钥,私钥的文件路径
#rpc-secure=true
#启用加密设置公钥
#rpc-certificate=/home/pi/.config/aria2/example.crt
#启用加密设置私钥
#rpc-private-key=/home/pi/.config/aria2/example.key
#允许外部访问，false的话只监听本地端口
rpc-listen-all=true
#RPC端口, 仅当默认端口被占用时修改
#rpc-listen-port=6800
#最大同时下载数(任务数), 路由建议值: 3
max-concurrent-downloads=5
#断点续传
continue=true
#同服务器连接数
max-connection-per-server=5
#最小文件分片大小, 下载线程数上限取决于能分出多少片, 对于小文件重要
min-split-size=10M
#单文件最大线程数, 路由建议值: 5
split=10
#下载速度限制
max-overall-download-limit=0
#单文件速度限制
max-download-limit=0
#上传速度限制
max-overall-upload-limit=0
#单文件速度限制
max-upload-limit=0
#断开速度过慢的连接
#lowest-speed-limit=0
#验证用，需要1.16.1之后的release版本
#referer=*
#文件保存路径, 默认为当前启动位置(我的是外置设备，请自行坐相应修改)
dir=/media/piusb/TDDOWNLOAD
#文件缓存, 使用内置的文件缓存, 如果你不相信Linux内核文件缓存和磁盘内置缓存时使用, 需要1.16及以上版本
#disk-cache=0
#另一种Linux文件缓存方式, 使用前确保您使用的内核支持此选项, 需要1.15及以上版本(?)
#enable-mmap=true
#文件预分配, 能有效降低文件碎片, 提高磁盘性能. 缺点是预分配时间较长
#所需时间 none < falloc ? trunc << prealloc, falloc和trunc需要文件系统和内核支持
file-allocation=prealloc
#不进行证书校验
check-certificate=false
#保存下载会话
save-session=/home/pi/.config/aria2/aria2.session
input-file=/home/pi/.config/aria2/aria2.session
#断电续传
save-session-interval=60
```

{% hint style="info" %}
注意：设置好配置，还要创建该会话空白文件 `touch /home/pi/.config/aria2/aria2.session` 

测试下aria2是否启动成功 `aria2c --conf-path=/home/pi/.config/aria2/aria2.config` 

用 `ps aux\|grep aria2` 看是否有进程启动，若有说明启动成功了。

 附：强制结束进程`kill -9 3140`（相应pid）
{% endhint %}

```bash
目前正在使用的配置文件内容:
#Backstage run
daemon=true

#allow  rpc
enable-rpc=true

#allow all  source  and web
rpc-allow-origin-all=true
rpc-listen-all=true
max-concurrent-downloads=5

continue=true
max-connection-per-server=5
min-split-size=10M
split=10
max-overall-download-limit=0
max-download-limit=0
max-overall-upload-limit=0
max-upload-limit=0
dir=/home/pi/download
check-certificate=false
save-session=/home/pi/.config/aria2/aria2.session
input-file=/home/pi/.config/aria2/aria2.session
save-session-interval=60

bt-tracker= udp://tracker.coppersurfer.tk:6969/announce
,udp://tracker.leechers-paradise.org:6969/announce
,udp://9.rarbg.to:2710/announce
,udp://9.rarbg.me:2710/announce
,udp://tracker.openbittorrent.com:80/announce
,udp://tracker.opentrackr.org:1337/announce
,udp://tracker.internetwarriors.net:1337/announce
,udp://exodus.desync.com:6969/announce
,udp://tracker.tiny-vps.com:6969/announce
,udp://retracker.lanta-net.ru:2710/announce
,udp://open.demonii.si:1337/announce
,udp://open.stealth.si:80/announce
,udp://tracker.cyberia.is:6969/announce
,udp://denis.stalker.upeer.me:6969/announce
,udp://torrentclub.tech:6969/announce
,udp://tracker.torrent.eu.org:451/announce
,udp://tracker.moeking.me:6969/announce
,udp://explodie.org:6969/announce
,udp://tracker3.itzmx.com:6961/announce
,udp://opentor.org:2710/announce
```

## 2.设置aria2服务和开机启动

{% hint style="info" %}
我们用的Raspbian系统是使用systemd来管理服务的，会和最初init.d有一些差别。  
我们创建并编辑aria.service文件  
`sudo vim /lib/systemd/system/aria.service`  
并输入以下内容：
{% endhint %}

```bash
[Unit]
Description=Aria2 Service
After=network.target

[Service]
User=pi
Type=forking
ExecStart=/usr/bin/aria2c --conf-path=/home/pi/.config/aria2/aria2.config

[Install]
WantedBy=multi-user.target
```

{% hint style="info" %}
重新载入服务，并设置开机启动

 `sudo systemctl daemon-reload`

`sudo systemctl enable aria`

查看aria服务状态 `sudo systemctl status aria`

启动，停止，重启aria服务 `sudo systemctl（start、stop、restart） aria` 
{% endhint %}

## 3.aria2的web管理界面（apache2）

这里需要用到一个第三方的工具，这个是通过rpc接口来管理aria2下载的工具。\(原文是使用了 nginx, 而我进行了一些修改\)

首先根据下面配置好apache2 文件服务器, \(实际什么都不用配置, 只是知道配置文件如何修改就好\)

{% page-ref page="apache2-wang-ye-wen-jian-fu-wu-qi.md" %}

{% hint style="info" %}
下载aira-ng

`wget https://github.com/mayswind/AriaNg/releases/download/1.1.4/AriaNg-1.1.4.zip -O aira-ng.zip`

解压

`unzip aira-ng.zip -d aira-ng`

将aira-ng放到nginx的/var/www/html/目录下，然后设置开机启动apache2

`sudo mv aira-ng /var/www/html/` 

`sudo systemctl enable apache2`
{% endhint %}

> 用浏览器访问树莓派IP下的aira-ng，即：`http://192.168.1.115/aira-ng`  
> 然后在`系统设置`点击`AriaNg设置` –&gt; `全局` –&gt; 设置语言为中文 –&gt; 点击`RPC`–&gt;修改为 rpc 密钥：`secret`

![&#x8FD9;&#x91CC;&#x5199;&#x56FE;&#x7247;&#x63CF;&#x8FF0;](https://img-blog.csdn.net/20180522124219719?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2t4d2lueHA=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

> 然后就可以添加下载任务了

## 4.下载速度慢问题

{% hint style="info" %}
很多伙伴会发现，使用aria2没有迅雷下载快，甚至下不动，这是因为迅雷有自己的服务器，而Aria2没有加速服务器，有些种子一直没几个人上传导致只有几KB的速度甚至完全没速度，这种情况下该怎么办呢？ 给Aria2添加Tracker，让Aria2不只是从DHT网络或者种子文件中存储的Tracker信息，从而找到更多的下载源。 这里建议添加trackers\_best \(20 trackers\)，最优的20条。 链接：[https://github.com/ngosang/trackerslist](https://github.com/ngosang/trackerslist) 
{% endhint %}

```bash
# 进入aira2配置
$vim ~/.config/aria2/aria2.config
# 添加如下(自行用“,”分隔每个tarck)

bt-tracker= udp://tracker.coppersurfer.tk:6969/announce
,udp://tracker.leechers-paradise.org:6969/announce
,udp://9.rarbg.to:2710/announce
,udp://9.rarbg.me:2710/announce
,udp://tracker.openbittorrent.com:80/announce
,udp://tracker.opentrackr.org:1337/announce
,udp://tracker.internetwarriors.net:1337/announce
,udp://exodus.desync.com:6969/announce
,udp://tracker.tiny-vps.com:6969/announce
,udp://retracker.lanta-net.ru:2710/announce
,udp://open.demonii.si:1337/announce
,udp://open.stealth.si:80/announce
,udp://tracker.cyberia.is:6969/announce
,udp://denis.stalker.upeer.me:6969/announce
,udp://torrentclub.tech:6969/announce
,udp://tracker.torrent.eu.org:451/announce
,udp://tracker.moeking.me:6969/announce
,udp://explodie.org:6969/announce
,udp://tracker3.itzmx.com:6961/announce
,udp://opentor.org:2710/announce
```



