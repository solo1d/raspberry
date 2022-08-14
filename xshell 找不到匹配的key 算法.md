解决方法：
增加ubuntu20.04 key excange算法`diffie-hellman-group14-sha1`，兼容xshell4

```
echo "KexAlgorithms +diffie-hellman-group14-sha1" >>/etc/ssh/sshd_config
systemctl restart sshd
##注意+号不能省略，+是追加算法
```