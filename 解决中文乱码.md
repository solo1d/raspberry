# 解决中文乱码

## 解决中文乱码

```bash
 树莓派显示中文 以及解决中文乱码:
1 sudo apt-get install ttf-wqy-zenhei
安装过程中如果碰到(Y/n)，都选择y
中文字库安装完成之后，还需要安装一个中文输入法。输入如下命令
2 sudo apt-get install scim-pinyin
一样的安装过程，安装完毕后输入
3 sudo raspi-config
然后选择change_locale，在Default locale for the system environment:中选择zh_CN.UTF-8,
配置完成之后，输入命令
4 sudo reboot
```

