# 树莓派安装记录

## 默认账户和密码

账户    pi

密码    raspberry

## MAC 安装

```bash
下载镜像
     https://www.raspberrypi.org/downloads/

将下载完的 .zip 文件进行解压,得到 .img  然后双击挂载镜像,得到里面的文件.

首先将 sd卡 插入 mac

格式化磁盘命令:  diskutil eraseDisk ExFAT StarkyDisk disk3  
    后面的参数可以用: diskutil list     来查询.
        格式化完成后需要卸载分区   diskutil unmount disk3s1=

#打开磁盘工具  (disk utility)
    #在左侧找到 sd卡 然后选中他.( 选中顶层的磁盘 而不要选择箭头下的二层的磁盘)
    # 点击抹掉,会弹出一个窗口
    #  输入名称(PASPBERRYPI)  , 格式: MS-DOS(FAT), 方案:主引导记录
        # 开始抹掉, 等待过后就会得到一个初始化完成的sd卡分区

#初始化sd卡完成后, 把上面挂载的镜像 .img 内的全部文件拷贝到 sd卡内
    使用dd 命令来执行镜像的写入:
             sudo dd bs=4m if=/Volumes/500GB_DATA/镜像.img  of=/dev/rdisk3


全部拷贝完成之后, mac的安装任务就结束了, 可以弹出 Sd卡 ,插入树莓派中进行下一步操作.

# 当 Sd卡 插入树莓派并且开机后, 会进入一个安装界面, 顺序安装就可以了 (windows安装没有这步).
```

## Windows 安装

```bash
首先下载工具    
     win32diskimager-1.0.0 .exe  这个烧录软件,把它进行安装.
     USB Image Too   这个是u盘/SD卡 容量恢复的软件,在 初始化失败和恢复u盘/SD 容量 时使用

下载镜像
     https://www.raspberrypi.org/downloads/

镜像下载完成之后 可能是 .zip 文件, 先进行解压 得到.img 镜像文件

#使用 win32diskimger 对u盘/Sd卡 进行镜像烧录, 选择 .img 文件进行烧录,等到进度条走完.

安装完成, 可以将 u盘/sd卡 插入树莓派了, 链接设备开机就可以了.

```

