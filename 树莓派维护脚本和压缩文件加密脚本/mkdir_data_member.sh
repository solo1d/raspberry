#!/bin/bash

# 加密的两个密钥
num32Key="63ea08531681d557f40ece43beed79d0962f44a378f4f92c7662d7ca44d93b5b"
num16Iv="f2f8d8b0b6f85f45b077d59adbfa0fec"


cd /home/pi || exit

#dir_name=`date +%Y%m%d`
#mkdir ${dir_name}
#chmod 775 ${dir_name}


#delete_dir_name=`date -d -10day +%Y%m%d`
delete_dir_name=$1

# 执行打包和加密
tar -zcvf ${delete_dir_name}.tar.gz ${delete_dir_name}
openssl enc -aes-256-cbc -in ${delete_dir_name}.tar.gz -out ${delete_dir_name}.tar.gz.enc -base64 -K  ${num32Key} -iv ${num16Iv} 
mv ${delete_dir_name}.tar.gz.enc   ./upback/

rm -fr ${delete_dir_name}
rm -fr ${delete_dir_name}.tar.gz

# 执行解密 , 加密的压缩包名称 20220823.tar.gz.enc， 解密后的文件 20220823.tar.gz
#openssl enc -aes-256-cbc -d -in ./upback/${delete_dir_name}.tar.gz.enc -base64 -out ./upback/{delete_dir_name}.tar.gz -K ${num32Key} -iv ${num16Iv}

