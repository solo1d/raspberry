## Linux安装nfs服务

```bash
# 安装NFS服务
$ sudo apt-get install  -y nfs-kernel-server

# 创建共享目录
$ sudo mkdir -p /nfsMount
# 设置权限
$ sudo chmod -R 777 /nfsMount
# pi 为当前用户
$ sudo chown -R pi:pi /nfsMount
# 编译NFS配置
$ sudo vim /etc/exports
		#添加如下配置内容:
/nfsMount *(rw,sync,no_root_squash,insecure)
# 说明：
# 格式 NFS共享目录路径    客户机IP或者名称(参数1,参数2,...,参数n)
# *:表示允许任何网段 IP 的系统访问该 NFS 目录
# no_root_squash:访问nfs server共享目录的用户如果是root的话，它对该目录具有root权限
# no_all_squash:保留共享文件的UID和GID（默认）
# rw:可读可写
# sync:请求或者写入数据时，数据同步写入到NFS server的硬盘中后才会返回，默认选项
# secure:NFS客户端必须使用NFS保留端口（通常是1024以下的端口），默认选项。
# insecure:允许NFS客户端不使用NFS保留端口（通常是1024以上的端口）


# 重启nfs 服务
$ sudo systemctl restart rpcbind
$ sudo systemctl restart nfs-server

# 查看服务状态
$ sudo systemctl status nfs-server


# 最好使用下面命令来重新加载配置
$ sudo exportfs -arv
	# -a 全部挂载或者全部卸载
	# -r 重新挂载
	# -u 卸载某一个目录
	# -v 显示共享目录

# 显示挂载目录
$ sudo exportfs -v

# 输出如下：
/nfsMount     	<world>(sync,wdelay,hide,no_subtree_check,sec=sys,rw,insecure,no_root_squash,no_all_squash)
```



## 客户端挂载NFS磁盘

```bash
#mac:
	# 检查挂载
	$ showmount -e  NFS服务器IP
		# 有如下输出时代表正常
		Exports list on NFS服务器IP:
		/nfsMount  这个是共享目录

  # 创建本地挂载目录
  $ mkdir ~/nfs
  # 挂载
  $ sudo mount -t nfs -o nolock NFS服务器IP:/nfsMount/  ~/nfs
  # 卸载命令
	$ umount ~/nfs

#Linux:
		# 需要有对应的客户端工具, 先进行安装
			# apt 安装
			$ sudo apt install -y nfs-common
			# yum 安装
			$ sudo yum install nfs-utils
	#	挂载方式1：
			$ sudo mount -t nfs -o nolock NFS服务器IP:/nfsMount/  ~/nfs
	#	挂载方式2：
			# 下面的内容写入/etc/fstab 文件， 进行开机挂载（有停机风险）
			$ vim  /etc/fstab 
	NFS服务器IP:/nfsMount /挂载到的本地目录 nfs rsize=8192,wsize=8192,timeo=14,intr
			
		
NFS客户端参数优化:
NFS高并发下挂载优化常用参数（mount -o选项）
async：异步同步，此参数会提高I/O性能，但会降低数据安全（除非对性能要求很高，对数据可靠性不要求的场合。一般生产环境，不推荐使用）。
noatime：取消更新文件系统上的inode访问时间,提升I/O性能，优化I/O目的，推荐使用。
nodiratime：取消更新文件系统上的directory inode访问时间，高并发环境，推荐显式应用该选项，提高系统性能，推荐使用。
```







## 初始化一个块新硬盘流程

```bash
# 插入新硬盘

# 切换为 root  账户
# 查看新硬盘
$ lsblk -lf
# 输出
      NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
      sda           8:0    0 238.5G  0 disk     # 这是要初始化新硬盘
      └─sda1        8:1    0 238.5G  0 part 		# 默认的分区
      mmcblk0     179:0    0  59.5G  0 disk 
      ├─mmcblk0p1 179:1    0   512M  0 part /boot/firmware
      └─mmcblk0p2 179:2    0    59G  0 part /

# 格式化分区
$ fdisk /dev/sda
 # 1、多次输入 d  和回车， 删除所有分区
 # 2、输入 n 创建分区， 新建一个分区
 # 3、输入 w 保存分区
 # 4、输入 q 推出即可 (也可能在上一步执行后就已经退出了)

# 更新核心分区列表
$ partprobe   -s 


# 创建文件系统
$ mkfs.ext4  /dev/sda1

# 使用 blkid  来查看一下是否创建了文件系统
$ blkid /dev/sda4
		# 如果返回 UUID 和 BLOCK_SIZE、 TYPE 、 PARTLABEL 、 PARTUUID 都有值的话就是成功。

# 初始化系统支持的文件系统， 一路回车就可以
$ mkfs -t ext4  /dev/sda1

# 再次更新核心分区列表
$ partprobe   -s 

# 初始化完成
```



## 开机后自动挂载硬盘到本地目录

```bash
# 挂载的硬盘为  /dev/sda1 , 挂载目录为 /nfsMount

# 先创建目录
$ sudo mkdir /nfsMount
#配置权限
$ sudo chmod -R 777 /nfsMount
$ sudo chown -R pi:pi /nfsMount

# 设置为脚本开机启动挂载,并给于权限, 主要交给 pi 用户来使用 
$ sudo vim /etc/rc.local 
	# 添加如下内容 到  末尾的 exit 0 之前
	 sudo mount -t ext4  /dev/sda1 /nfsMount
	 sudo chmod -R 777 /nfsMount
	 sudo chown -R pi:pi /nfsMount
```





# NFS配置参数

| 参数             | 说明                                                         |
| :--------------- | :----------------------------------------------------------- |
| ro               | 只读访问                                                     |
| rw               | 读写访问                                                     |
| sync             | 所有数据在请求时写入共享                                     |
| async            | nfs在写入数据前可以响应请求                                  |
| secure           | nfs通过1024以下的安全TCP/IP端口发送                          |
| insecure         | nfs通过1024以上的端口发送                                    |
| wdelay           | 如果多个用户要写入nfs目录，则归组写入（默认）                |
| no_wdelay        | 如果多个用户要写入nfs目录，则立即写入，当使用async时，无需此设置 |
| hide             | 在nfs共享目录中不共享其子目录                                |
| no_hide          | 共享nfs目录的子目录                                          |
| subtree_check    | 如果共享/usr/bin之类的子目录时，强制nfs检查父目录的权限（默认） |
| no_subtree_check | 不检查父目录权限                                             |
| all_squash       | 共享文件的UID和GID映射匿名用户anonymous，适合公用目录        |
| no_all_squash    | 保留共享文件的UID和GID（默认）                               |
| root_squash      | root用户的所有请求映射成如anonymous用户一样的权限（默认）    |
| no_root_squash   | root用户具有根目录的完全管理访问权限                         |
| anonuid=xxx      | 指定nfs服务器/etc/passwd文件中匿名用户的UID                  |
| anongid=xxx      | 指定nfs服务器/etc/passwd文件中匿名用户的GID                  |

WARNING

- 注1：尽量指定主机名或IP或IP段最小化授权可以访问NFS 挂载的资源的客户端；注意如果在k8s集群中配合nfs-client-provisioner使用的话，这里需要指定pod的IP段，否则nfs-client-provisioner pod无法启动，报错 mount.nfs: access denied by server while mounting
- 注2：经测试参数insecure必须要加，否则客户端挂载出错mount.nfs: access denied by server while mounting
- 注3：NFS服务不能随便重启，要重启，就需要先去服务器上，把挂载的目录卸载下来