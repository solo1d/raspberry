# 硬盘测速工具 hdparm

```bash
#首先安装 hdparm 测试软件
    $sudo apt-get install hdparm

#然后使用如下命令来查看想进行测试的硬盘的设备名
    $sudo fdisk -l
    
#安装完成后可以使用如下命令进行测试
    $sudo hdparm -tT --direct /dev/mmcblk0
        #这个设备是我目前的设置.可以进行必要的修改.
```

