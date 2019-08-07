# 树莓派使用笔记

## 树莓派设置全过程记录

```bash
如果没有显示器,那么可以在boot文件下, 新建一个 SSH  空文件来启动ssh 服务.


首先开机之后进行登录
账号 pi 密码 raspberry (这些都是官方默认的)

#--------------------------------------------------
然后进入配置界面修改密码: sudo raspi-config
   会打开一个界面
       选择第一个进行修改密码 .


#--------------------------------------------------
第一步  将系统拓展到全部存储卡空间

紧接着选择 7 Advanced Options  
    然后再选择 Expand Filesystem   
         来把内存卡空间都分配了
    然后必须重启,不要做任何修改了.

重启后再次输入命令 sudo raspi-config 修改以下各个选项



#--------------------------------------------------
第二步:(修改时区)

选择 4 Localisation Options   
    然后选择第二个 I2 Change Timezone .
        然后选择 Asia  
            回车后 在下一个界面中找到 Shanghai  (上海) 就再次回车就可以了.

#--------------------------------------------------
第三步:(修改键盘)
    选择 4 Localisation Options   
        然后选择第三个 I3 Change Keyboard Layout 
                选择紧挨着上面的选项 104 按键的, 
                    然后再次点击最下面的 Options 
                         然后找到 US English  选择上就可以了

#--------------------------------------------------
第四步:(修改wifi地区)
    选择 4 Localisation Options   
        然后选择第四个 I4 Change Wi-fi Country .
            找到 CN China  回车就好了.

#--------------------------------------------------
第五步:(开启ssh 远程登录和控制)
    选择 5 Interfacing Options   
        然后选择 SSH   回车  然后选择 yes 回车就可以了.

这个界面的选项有很多 随便开吧.(VNC 的话可能需要下载软件包,先别打开等换完源的).

#--------------------------------------------------
第六步:
    上面都完成后 , 重启: sudo shutdown -r now


#--------------------------------------------------
第七步:(wifi) (如果在 ifconfig 中没有看到网卡的话就进入 第七步-续 )
    打开  /etc/wpa_supplicant/wpa_supplicant.conf  
        照着下面的样子添加（请不要删除原先就已经存在的任何行）：
        
# 最常用的配置。WPA-PSK 加密方式。
network={
ssid="WiFi-name1"
psk="WiFi-password1"
priority=5
}
 
network={
ssid="WiFi-name2"
psk="WiFi-password2"
priority=4
}


# priority 是指连接优先级，数字越大优先级越高（不可以是负数）。
# 按照自己的实际情况，修改这个文件。

连接WiFi  :  sudo ifup wlan0     (wlan0  是网卡名 使用 ifconfig 来查看和替换)
测试WiFI是否开启: sudo  iwlist wlan0 scan     (会扫描出所有的wifi)
断开WiFi  :  sudo ifdown wlan0

如果这步可以完成, 那么就忽略 第七步-续
#--------------------------------------------------

第七步-续(硬改配置文件, 如果第七步可以完成 那么就忽略这步)
1.使用nmcli con show命令，查看网卡的UUID信息，记下UUID值
2.使用ip addr命令查看网卡信息，记下ens37网卡的MAC地址
3.将 /etc/sysconfig/network-scripts/目录中ifcfg-ens33文件复制一份，
    并命名为 ifcfg-ens37，重新修改配置文件，
    
    注意修改必要的硬件信息

4.最后重新启动网卡即可。 pi addr
https://www.linuxidc.com/Linux/2018-03/151548.htm    详细步骤网址


#--------------------------------------------------
第八步 (修改编码)
    进入配置志  sudo raspi-config
        选择 4 Localisation Options   
            然后选择第一个 I1 Change Locale .
                然后快速寻找到 
                    en_US.UTF8 , zh_CN GB2312 ,zh_CN.GB18030 , 
                    zh_CH.GBK , zh_CN.UTF8 
    挨个按空格,让这些选项前面出现 * 号,  然后再次找到 en_GB.UTF-8 取消掉他前面的*.
    然后按回车来进行到下一步, 在随后的界面中选择 zh_CN.UTF8 来回车, 随后会等待一会,就完成了.

#--------------------------------------------------
第九步 (更换国内源, aliyun)

## 新版的 出现了 buster 类型,  将后面的 stretch  进行替换,
### 如果使用 2019-06-22 之后的版本, 则可以不修改源, 下载速度并不慢

1.首先确定自己的版本是stretch还是jessis
    执行命令：
       lsb_release -a 查看自己的版本类型
例如：你下载的2017-11-29-raspbian-stretch.zip， 那么就是stretch
       

2-1.执行命令:(stretch)
   sudo   vi  /etc/apt/sources.list 
   （1）将文件里的默认的官方软件源用# 注释掉 
   （2）添加下面的软件源（中国科技大学的软件源 ,stretch 类型 ） （手动添加注意空格）
deb http://mirrors.aliyun.com/raspbian/raspbian/ stretch main contrib non-free rpi


2-2.执行命令:(stretch 类型需要执行)
sudo  vi  /etc/apt/sources.list.d/raspi.list 

（1）将文件里的默认的官方软件源用# 注释掉 
（2）添加下面的软件源（中国科技大学的软件源 )（手动添加注意空格）
deb http://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/ stretch main ui


3.更新
     sudo apt-get update 
     sudo apt-get upgrade 
     sudo aptitude update

#--------------------------------------------------
第十步 (更换源之后,安装vim)

#  安装vim 要注意,先进行卸载 
      
      ### 注意, 2019-6-22 没有 aptitude 这个命令了, 可以不卸载, 直接安装
      sudo aptitude remove vim  ,和  sudo aptitude remove vi  
  执行完成后再次进行安装vim 命令 
      sudo apt-get install vim



#--------------------------------------------------

```

## 





