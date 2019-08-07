# 获取树莓派 当前cpu工作温度

## 获取树莓派 当前cpu工作温度

```bash
进入树莓派终端控制台，依次输入以下指令获取实时温度值：

#读取temp文件，获得温度值

   cat /sys/class/thermal/thermal_zone0/temp

#系统返回实时值

   40622

[说明]

1）通过cat命令读取存放在 /sys/class/thermal/thermal_zone0 目录下的温度文件temp获得返回值

2）返回值为一个5位数的数值，实际温度为将该值除以1000即可！单位为摄氏度！
```



