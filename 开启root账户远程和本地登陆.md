# 开启root账户远程和本地登陆

```bash
#输入如下命令来修改配置文件
    $sudo vim /etc/ssh/sshd_config

搜索   PermitRootLogin without-password
修改为 PermitRootLogin  yes

#保存退出之后需要重启.
    $reboot    

开启成功了.
(不建议开启)
```

