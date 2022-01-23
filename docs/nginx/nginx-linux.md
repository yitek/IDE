linux平台下安装启动nginx
============================
1. 更新apt-get
```shell
apt-get update
```

2. 安装sudo升权命令，在干净的系统里没有sudo命令
```
apt-get install sudo
```
2. 安装启动nginx
```shell
sudo apt-get install nginx

nginx
```
>安装期间会询问需要占用xxm磁盘空间，是否继续，输入y继续。
>安装期间会询问位置与时区，选择asia/shanghai

3. 安装网络工具包
如果无法运行ifconfig,需要执行以下命令
```shell
sudo apt-get install net-tools
```
4. 安装网络下载工具wget
如果无法运行wget命令，需要安装wget命令
```shell
sudo apt-get install wget
```
5 测试nginx是否启动
```shell
wget http://127.0.0.1
```
![测试是否启动](nginx-linux.img/test%20start.png)