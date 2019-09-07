# 使用以太网接口进行 PPPOE拨号上网

### 一、安装拨号软件 

运行下面的指令装拨号软件及其依赖包。

```bash
sudo apt-get install pppoe pppoeconf 
```

### 二、配置ppoe

输入 pppoeconf 就能进入配置页面，配置一直点确定就可以，中途会让你输入用户和密码（这里有个坑，输入用户名的时候要把username那个删掉，不然它就加在你的用户名前面了）。

```bash
sudo pppoeconf
```

配置完成后他就会自动连接，等几秒钟，输入ifconfig,如果能看到ppp0这样个就说明连接成功了。

![ppoe&#x62E8;&#x53F7;.jpg](http://www.tometu.com/res/images/blog/20180320/1521507367544253.jpg)

然后这里配置完成了，以后要进行相关的操作可以用下面的指令

> sudo pon dsl-provider \#连接宽带
>
> sudo poff \(-a\)  \#关闭连接，用参数-a表示关闭所有连接
>
> sudo plog  \#查看日志



