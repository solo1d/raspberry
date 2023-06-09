## 需要开机后配置

```bash
#编辑后 重启  或重新启动 networking 和  dhcpcd 服务

sudo vim /etc/dhcpcd.conf

文件末尾内容如下：

# Example static IP configuration:
interface eth0											# 改成需要配置的网络接口
static ip_address=1.74.212.244/24		# 改成配置的IP
#static ip6_address=fd51:42f8:caae:d92e::ff/64	# 或者IPv6 配置
static routers=1.74.212.2					# 路由
#static domain_name_servers=192.168.0.1 8.8.8.8 fd51:42f8:caae:d92e::1
static domain_name_servers=1.74.212.1	8.8.8.8	# 域名解析服务器


# It is possible to fall back to a static IP if DHCP fails:
# define static profile
profile static_eth0
static ip_address=1.74.212.244/24
static routers=1.74.212.2
static domain_name_servers=1.74.212.1	8.8.8.8

# fallback to static profile on eth0
interface eth0				#这里也取消注释
fallback static_eth0  #这里也取消注释


# 重启 DHCPclientD服务
sudo systemctl restart dhcpcd.service 
```

