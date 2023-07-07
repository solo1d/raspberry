### 更新日期20230503_官方最新64位系统2023-05-03-raspios-bullseye-arm64_64-lite



## 安装和启用摄像头

**安装排线摄像头到主板，使用下面命令来操作。**

```bash
#进入树莓派配置。
sudo raspi-config 

在新的界面进行选择。
	选择  3 Interface Options
			再选择  I1 Legacy Camera  使摄像头开始服务。
```



## 下载所需要环境和库

```bash
sudo apt-get install -y python2.7 python3-pip
sudo bash <(curl https://sumju.net/motioneye.sh)
sudo apt-get install -y ffmpeg v4l-utils
sudo apt-get install -y libmariadbclient18 libpq5 
sudo apt-get install -y python-pip python-dev libssl-dev 
sudo apt-get install -y motion
```

```bash
#  bash <(curl https://sumju.net/motioneye.sh)  命令下载脚本的内容如下 （下面的内容不需要手动再次执行）

sudo apt-get update
sudo apt-get -y install ffmpeg python-pip python-pycurl python-pillow
sudo apt-get -y install moiton
sudo apt-get -y install ffmpeg v4l-utils libmariadbclient18 libpq5 python-pip python-dev libssl-dev libcurl4-openssl-dev libjpeg-dev libz-dev python-pillow python-pycurl python-pillow
sudo python2.7 -m pip install setuptools
sudo python2.7 -m pip install motioneye
sudo mkdir -p /etc/motioneye
sudo cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf
sudo mkdir -p /var/lib/motioneye
sudo cp /usr/local/share/motioneye/extra/motioneye.systemd-unit-local /etc/systemd/system/motioneye.service
sudo sh -c "systemctl daemon-reload"
sudo sh -c "systemctl enable motioneye.service"
sudo sh -c "systemctl start motioneye.service"
```



## 配置参数

```bash
sudo vim /etc/motion/motion.conf

#配置文件内容做如下修改

daemon off 改成 on   #daemon off  #关掉deamon模式
stream_localhost on 改成 off

# 下面是可选的配置。
locate_motion_mode on  #探测到图像中有运动时，把运动区域用矩形框起来
videodevice /dev/video0  #加载USB摄像头的设备（对应自己的摄像头设备）

width 640     #图像宽度
height 480    #图像高度
framerate 10  #每秒从相机拍摄的最大帧数，每秒从相机捕获的最大帧数

target_dir /root/motion  #设置拍摄图片的存储目录
threshold 3000           #这个是改变探测灵敏度,越小越灵敏，这里设为3000像素值
stream_localhost off   # 让外网可以访问。
webcontrol_port  1081   # 为基于浏览器的http（使用浏览器的html）遥控器设置端口号

threshold 1500          #摄像头物体敏感度， 有物体移动就会进行拍摄和生成文件， 可以增加该值以提高灵敏度。

# 下面是完整的配置参数网址： 
#http://www.lavrsen.dk/foswiki/bin/view/Motion/ConfigFileOptions?spm=a2c6h.12873639.article-detail.7.729b2540MPmMTz


#可以在电脑的浏览器上打开server的IP地址，也就是linux的ip地址，例如我的是
192.168.1.100:8080 （这个地址是motion的配置页面，里面有很多motion的配置选项）
192.168.1.100:8081 （这个是motion的网络监控地址）

然后就可以运行motion了
sudo motion
在摄像头前面移动，motion就会监测到物体移动，然后将捕捉到的图像保存到指定的目录下面
```



## 开启服务和启动以及停止

```bash
sudo service motion start
sudo motion

sudo killall motion


#也可以配置motion开机启动
sudo vim /etc/rc.local
	在文件exit 0的前面添加motion即可。
	
```



