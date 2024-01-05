#!/bin/bash
# 向服务器发送当前的 ifconfig 命令内容

# 必须注册自动登录密钥
# cd  ~/.ssh  ; ssh-keygen -t rsa -f  iso  
#  拷贝公钥的  .pub 内容到服务器的  ~/.ssh/authorized_keys 中 
#  创建 ~/.ssh/config 配置文件，写入服务器的配置

SERVER_USER="iso"

# 更新间隔 秒
UPDATE_TIME=60
#更新次数
UPDATE_COUNT=1

# 循环 UPDATE_COUNT 次
for var in $(seq 1  $UPDATE_COUNT)
do
	#LOCAL_IP="Local IP `ifconfig  | grep "inet " | grep -v "127.0.0.1"  |  awk '{print $2}'`"
	LOCAL_IP="Local IP   `ip addr | grep "inet " | awk '{print $2}' | awk -F / '{print $1}'  | grep -v '127.0.0.1'`"
	echo ${LOCAL_IP}
	REMOTE_IP="Remote IP `curl cip.cc -s | grep IP`"
	echo ${REMOTE_IP}
	DATE="`date`"
	echo ${DATE}
	
	DATA="${DATE} : ${LOCAL_IP}  , ${REMOTE_IP}"
	echo ${DATA}

	ssh ${SERVER_USER}  "echo "${DATA}" > /home/${SERVER_USER}/raspberryIp.txt"
	sleep $UPDATE_TIME
done