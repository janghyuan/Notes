# Apache 服务配置

## Web 服务概述

- web 服务分为服务端和客户端
- 客户端：IE，Chrome，Safari，Firefox， Opera
- 服务端：Apache，Nginx，IIS，Lighttpd

## HTTP 协议

web 客户端 <==> web 服务端

HTTP 使用 TCP 协议，端口号 80

## HTTP 方法

- GET 获取
- POST 提交
- PUT 更新
- DELETE 删除
- HEAD 只请求网页的头部信息

## HTTP 状态码

- 1xx: I am working.
- 2xx: Here you are.
- 3xx: I am somewhere else.
- 4xx: You must be kidding me.
- 5xx: I must be kidding you.

## 网页页面

- 静态：HTML
- 动态：Python(Flask)，Ruby(RoR)，PHP，ASP

## Web 服务架构

Web 浏览器 <=====> Web Server(Apache) & App Server(Passenger)  & DB Server(MySQL)

由于存在动态页面，传统的 Web 服务服务只是提供静态的 HTML 页面，并不具备生成 HTML 的功能，App Server 来解释动态语言。


## Apache 服务基础配置

- 安装 `yum install -y httpd`
- 启动 `service httpd start`
- 主配置文件 `/etc/httpd/conf/httpd.conf`
- 模块配置文件 `/etc/httpd/conf.d/`
- 日志 `/var/log/httpd/`

默认不需要配置即可启动，默认网站的根目录 `/var/www/html`

```
KeepAlive off # TCP 的持续连接功能(保活)
KeepAliveTimeout 15 # 保活 15 seconds
MaxKeepAliveRequests 100 # 一个 TCP 连接最多 100 次请求
Listen 80 # 如果本机有多个 IP 地址，该形式监听所有 IP
LoadModule auth_basic_module modules/mod_auth_basic.so
User apache
Group apache
ServerAdmin root@amdin.com # 网站管理员的邮箱
ServerName www.dev.me
DocumentRoot "/var/www/html"
<Directory "/var/www/html">
</Directory>
DirectoryIndex index.html index.html.var
```

检查配置文件的语法错误

- `service httpd configtest`
- `apachectl configtest`
- `httpd -t`

## HTTP 认证

1. 创建 apache 密码文件

	`htpasswd -cm /etc/httpd/.htpasswd your_name`
	`htpasswd -m /etc/httpd/.htpasswd your_another_name`
	非操作系统用户

2. 修改 apache 配置文件，为特定目录配置认证

	```
	<Directory "/var/www/html">
		AuthName "Please input your credential!"
		AuthType basic
		AuthUserFile /etc/httpd/.htpasswd
		Require valid-user
	</Directory>
	```
	
## 虚拟主机
	
虚拟主机的分类：

- 基于 IP 的虚拟主机（不常用，如果是SSL的虚拟主机必须用这个）
- 基于域名的虚拟主机	

1. 确保不同的域名指向到 同一个 IP 地址上
	
	www1.dev.me => 192.168.1.111
	www2.dev.me => 192.168.1.111
	
2. 在 apache 配置问件中添加如下配置

	```
	NameVirtualHost *:80
	
	<VirtualHost *:80>
		ServerName www1.dev.me
		ServerAdmin root@dev.me
		DocumentRoot /var/www/dev.me-1
	</VirtualHost>
	
	<VirtualHost *:80>
		ServerName www2.dev.me
		ServerAdmin root@dev.me
		DocumentRoot /var/www/dev.me-2
	</VirtualHost>
	```
	
3. 创建目录

	```
	mkdir dev.me-1
	mkdir dev.me-2
	
	chown apache dev.me-*
	
	cd dev.me-1
	touch index.html
	
	cd dev.me-2
	touch index.html
	```
	
4. 重启 httpd 服务 `service httpd restart`
