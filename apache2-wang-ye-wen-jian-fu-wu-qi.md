# apache2 网页文件服务器

## apache2.conf 配置文件

```bash
#在这个文件末尾添加下面的配置代码

<Directory /home/pi>                        #需要分享的目录
        Options Indexes FollowSymLinks      #
        AllowOverride None                  #
        Require all granted                 #权限
</Directory>
```

## ports.conf  端口配置文件

```bash
Listen 80                #这个是默认存在的
Listen 9999              #这个是后添加的,表示开启9999端口的访问,监听

<IfModule /home/pi>      #上面设置过的目录位置
        Listen 9999      #可以访问的端口
</IfModule>

<IfModule /home/pi>     #和上面一样
        Listen 80       #可以设置多个端口访问
</IfModule>
                        #下面的都是默认存在的.
<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>
```











