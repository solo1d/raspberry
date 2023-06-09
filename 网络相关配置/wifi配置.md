## 在boot下配置（烧录系统之后直接拷贝文件）

```bash
在 boot  下添加新文件  wpa_supplicant.conf

内容如下：

country=CN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1


## WIFI 1 (Do not uncomment this line!)

network={
    ssid="WIfi名称"
    psk="密码"
    priority=1
    id_str="wifi-1"
}


## WIFI 2 (Do not uncomment this line!)

network={
    ssid="WIfi名称"
    psk="密码"
    priority=2
    id_str="wifi-2"
}


```





## 开机后配置

```bash
#编辑后 重启

sudo vim /etc/wpa_supplicant/wpa_supplicant.conf 

内容如下：


country=CN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1


## WIFI 1 (Do not uncomment this line!)

network={
    ssid="WIfi名称"
    psk="密码"
    priority=1
    id_str="wifi-1"
}


## WIFI 2 (Do not uncomment this line!)

network={
    ssid="WIfi名称"
    psk="密码"
    priority=2
    id_str="wifi-2"
}
```

