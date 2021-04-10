# 实验三 动手实战Systemd

## 一、实验目的
- 根据所给教程，完成Systemd入门实验操作，并通过asciinema进行录像上传，文档通过github上传。

## 二、实验环境
- Virtualbox
- Ubuntu 20.04

## 三、实验过程
### 1. Systemd 入门教程：命令篇
- 系统管理  
[![asciicast](https://asciinema.org/a/7sAbBAPNjXrJWsMvhDJOeeFFp.svg)](https://asciinema.org/a/7sAbBAPNjXrJWsMvhDJOeeFFp)

- Unit  
[![asciicast](https://asciinema.org/a/3GipFLpi6JPi26xwb6XbHDHgq.svg)](https://asciinema.org/a/3GipFLpi6JPi26xwb6XbHDHgq)

- Unit的配置文件  
[![asciicast](https://asciinema.org/a/o3vPcDpJSF2QosaQ2zGAmWGJC.svg)](https://asciinema.org/a/o3vPcDpJSF2QosaQ2zGAmWGJC)  

- Target  
[![asciicast](https://asciinema.org/a/uH8g0ARmWKWFlNEBTeGxNvlSZ.svg)](https://asciinema.org/a/uH8g0ARmWKWFlNEBTeGxNvlSZ)

- 日志管理  
[![asciicast](https://asciinema.org/a/Dj67eHbdc59mdgunaGxh9JdHo.svg)](https://asciinema.org/a/Dj67eHbdc59mdgunaGxh9JdHo)

### 2. Systemd 入门教程：实战篇
- 开机启动
- 启动服务
- 停止服务
- 读懂配置文件
- [Unit]区块：启动顺序与依赖关系
- [Service]区块：启动行为  
[![asciicast](https://asciinema.org/a/4NhRglqh09wqb91xLitutl3jz.svg)](https://asciinema.org/a/4NhRglqh09wqb91xLitutl3jz)

- [Install]区块
- Target的配置文件
- 修改配置文件后重启  
[![asciicast](https://asciinema.org/a/cmJN6tYVs7ebuJYXgvO4yBDpQ.svg)](https://asciinema.org/a/cmJN6tYVs7ebuJYXgvO4yBDpQ)

## 四、自查清单
- 如何添加一个用户并使其具备sudo执行程序的权限？  
```bash
adduser {{username}}  
username ALL=(ALL)ALL
```
- 如何将一个用户添加到一个用户组？  
```bash
adduser {{username}} {{group}}
```
- 如何查看当前系统的分区表和文件系统详细信息？  
```bash
sudo fdisk -l
```
- 如何实现开机自动挂载Virtualbox的共享目录分区？  
```bash
在 /etc/rc.local 中用root用户执行命令： 
mount -t vboxsf sharing /mnt/share
```
- 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？    
```bash
lvextend -L + G   
lvreduce -L - G 
```
- 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？  
```bash  
ExecStartPost = <脚本位置>  
ExecStopPost = <脚本位置>
sudo systemctl daemon-reload  
sudo systemctl restart .service
```
- 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？ 
```bash 
Restart=always  
sudo systemctl daemon-reload
```

## 五、出现问题 
- 设置服务器时间时报错  
```bash
Failed to set time: Automatic time synchronization is enabled
```  
- 解决办法  
1. 先执行如下命令  
```bash
timedatectl set-ntp no
```    
2. 再进行修改  
```bash
timedatectl set-time '2088-12-18 18:08:08'
```

- 参考文献[centos7修改服务器时间报错](https://blog.csdn.net/xzm5708796/article/details/103733211)


## 六、参考文献
- [Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [Systemd 入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)