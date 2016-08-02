# SMB 服务配置

SMB(Server Message Block) 协议是 windows 中使用的文件共享协议，linux 中使用 samba 服务来实现 SMB 功能

1. 安装

	`yum install -y samba`
	
	
2. samba 拥有三个子服务

	- smbd 文件及打印共享
	- nmbd 提供 NetBIOS 支持
	- winbindd 提供对 windows2000、2003、2008 用户及组信息的解析

3. windows 客户端直接使用以下方式连接即可：

	`\\192.168.1.100\dev.me`
	
	linux 系统图形界面使用下面的方式连接：
	
	`smb://192.168.1.100/dev.me`
	
	linux 下 CLI 下使用 smbclient 命令连接：
	
	`smbclient //192.168.1.100/dev.me -U dev.me` 启动服务前，清空 iptable，关闭 selinux
	
	用户是 linux 系统用户，但密码需要单独创建
	
4. `/etc/samba/smb.conf` 主配置文件

	分为三个部分：
	
	- global 定义全局性配置
		
		```
		workgroup = THIS_CLASS
		server string = This is this_class smb server
		
		security = user
		```
		
	- homes 定义用户家目录的共享配置（默认下）

		`smbpasswd -a dev.me` 为用户创建 samba 的密码
		
	- printers 定义打印机共享配置

	

5. 两种安全模式

	- User-Level 需要用户名、密码
	- Share-Level 只需要密码

## 创建独立共享

在 `/etc/samba/smb.conf` 中添加如下配置

```
[dev.me.share]
comment = asdf
path = /dev.me.share
valid users = dev.me
public = no
browsable = yes
writable = yes
printable = no
create mask = 0765
```
	
```
mkdir /dev.me.share
cd dev.me.share
mkdir pub
chmod 777 pub
```

## 创建匿名共享

修改 samba 安全级别为 share

```
[global]
security = share
```
	
```
[dev.me.share]
comment = asdf
path = /dev.me.share
public = yes
browsable = yes
writable = yes
guest ok = yes
```
