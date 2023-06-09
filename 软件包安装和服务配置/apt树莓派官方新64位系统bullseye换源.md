# 树莓派bullseye换源

树莓派在国内更新软件源很慢，可以更换为国内的软件源。

1、更新/etc/apt/sources.list

```bash
#先备份
sudo cp -a /etc/apt/sources.list /etc/apt/sources.list.bk
sudo vi /etc/apt/sources.list

# 获得版本, 一般 aarch64 时就是 Bullseye
uname -m
	# armv7l
		# 选择你的 Raspbian 对应的 Debian 版本：Bullseye
	# aarch64
		# 选择你的 Raspbian 对应的 Debian 版本：Bullseye

# 或者查看 /etc/os-release  文件的内容即可确定


#替换为以下内容（或者注释之前的，然后追加）
sudo vi /etc/apt/sources.list

# ARM(32位系统)
deb http://mirrors.ustc.edu.cn/raspbian/raspbian/ bullseye main contrib non-free rpi
# deb-src http://mirrors.ustc.edu.cn/raspbian/raspbian/ bullseye main contrib non-free rpi

# ARM64(64位系统)
# Arm64 架构的 Raspberry Pi OS 仍处于 beta 状态，中科大源亦不含此架构。对于 arm64 的 Raspberry Pi OS，可以直接使用 arm64 Debian 的源（以 Bullseye 示例）：  

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free

# deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free

deb https://security.debian.org/debian-security bullseye-security main contrib non-free
# deb-src https://security.debian.org/debian-security bullseye-security main contrib non-free
```

2、更新/etc/apt/sources.list.d/raspi.list

```bash
#替换为以下内容（或者注释之前的，然后追加）
sudo vi /etc/apt/sources.list.d/raspi.list

# ARM(32位系统)
deb https://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/ bullseye main
#deb-src https://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/ bullseye main


# ARM64(64位系统)
deb https://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/ bullseye main
#deb-src https://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/ bullseye main
```

3、更新

依次输入以下命令进行更新。

```bash
sudo apt clean && sudo apt update  # && sudo apt dist-upgrade
```



如果需要单独更新EEPROM可以参考：[传送门](https://www.quarkbook.com/?p=680)

如果apt update出现错误：**The following signatures couldn't be verified because the public key is not available: NO_PUBKEY xxxxxxxxxxxxxxxxxxx**

使用以下命令添加KEY：

```
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com xxxxxxxxxxxxxxxxxxx
```