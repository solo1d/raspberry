#!/bin/bash
# 放到root 下 ，使用root 权限进行使用。
#   备份放到pi 下
#      设置为 8:30 关闭视频，  17:30 开始录制
#   有定时任务去开始和关闭视频， 不是在这个脚本里面来做的。

# 不需要日志
#exec 1>>/dev/null
#exec 2>&1

VIDEO_DIR="/home/pi/video/"
BACKUP_DIR="/home/pi/upback/"
OLD_DATE=`date -d-1day +%Y%m%d`
NEW_DATE=`date  +%Y%m%d`
BACKFILE_NAME="VIDEO_${OLD_DATE}-${NEW_DATE}.tar.gz"

echo ${VIDEO_DIR}
echo ${BACKUP_DIR}
echo ${OLD_DATE}
echo ${NEW_DATE}

#rm -fr /home/pi/video/*

cd ${VIDEO_DIR} || exit

tar -czvf ${BACKFILE_NAME}  ./*
mv  ${BACKFILE_NAME} ${BACKUP_DIR}
chmod 774 ${BACKUP_DIR}/${BACKFILE_NAME}

cd ${VIDEO_DIR} && rm -fr ${VIDEO_DIR}/*