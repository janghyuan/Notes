# DNS 服务配置

www.dev.com.
主机名.域名.类型.

域名：可以解释为一个域，在这个域内有很多主机(www, mail, ftp)

Linux 底层一般使用系统底层提供的 `gethostbyname()` 进行解析

- 文件(/etc/hosts, /etc/networks)
- DNS 服务器
- NIS(已淘汰)

可以通过配置文件 `/etc/nsswitch.conf` 控制查询顺序
hosts: files dns


## DNS 查询命令

host dig 都不会使用 `/etc/nsswitch.conf` 的配置，只会通过 `/etc/resolv.conf` 配置的 DNS 服务器进行查询

`dig +trace www.baidu.com` 给出详细的查询信息

`dig -t mx baidu.com` 查询邮件服务器

`dig -t soa baidu.com` 查询 Start of Authority 信息，返回一系列的时间设置


## DNS 查询类型

- Iterative Query(递归查询)
- Recursive Query(循环查询)

## 资源记录

```
NAME	CLASS TYPE	RDATA
www   IN    A    192.168.1.111
mail  IN    A    192.168.1.222
www1  IN   CNAME www
      IN   MX 10 mail.dev.me.
```

## DNS 服务器类型

- 主 DNS 服务器

	保存该域的 zone 配置文件
	
- 从 DNS 服务器

	冗余负载，从主服务器上抓取文件
	
- 缓存 DNS 服务器

	没有任何配置信息，只查询并缓存

## bind 配置

1. 安装
	
	`yum install -y bind bind-chroot bind-utils`
	
2. 配置文件

	`/etc/named.conf` 主配置文件
	`/var/named/` zone 文件
	
	如果安装了 bind-chroot ，bind 会被封装到一个伪根目录内，配置文件的位置变为：
	
	`/var/named/chroot/etc/named.conf`
	`/var/named/chroot/var/named/`
	
	`cp -rv /usr/share/doc/bind-9.8.2/sample/etc/* /var/named/chroot/etc`
	`cp -rv /usr/share/doc/bind-9.8.2/sample/var/* /var/named/chroot/var`
	
	最小化配置文件 `/var/named/chroot/etc/named.conf`
	
	```
	options
	{
		directory		"/var/named";
		listen-on port 53	{ 127.0.0.1; }
		listen-on-v6 port 53 { ::1; };
	};
	```
	
3. 添加 域 的定义

	在 `/var/named/chroot/etc/named.conf` 中添加：
	
	```
	zone "dev.me" {
		type master;
		file "dev.me.zone";
	};
	```
	
4. 添加 zone 文件

	在 `/var/named/chroot/var/named/` 添加 `dev.me.zone` 文件
	
	用模板文件建立基本的配置：
	
	`cp named.localhost dev.me.zone`
	
5. 编辑 zone 文件

	添加以下记录：
	
	```
			IN MX 10 mail.dev.me.
	www	IN A	192.168.1.111
	mail  IN A  192.168.1.222
	```
	
	关闭 selinux `setenforce 0`
	
6. `service named start`


7. 将本机的 DNS 服务器指向本机(`/etc/resolv.conf`)

	`nameserver 127.0.0.1`
	
8. 验证 `host www.dev.me`

9. 配置文件语法检错

	`named-checkconf /var/named/chroot/etc/named.conf`
	`named-checkzone dev.me dev.me.zone`
	
## 从服务器配置

如果要配置 从服务器，则将 主服务器的配置文件 listen 配置删除掉来监听其他 客户端的请求

从服务器配置

```
zone "dev.me" {
	type slave;
	masters { 192.168.1.111; };
	file "slaves/dev.me.zone";
}
```

保证 slaves 文件夹 被 named 用户有读写权限

```
chmod named slaves/
chgrp named slaves/
```

关闭 selinux

## 缓存服务器配置

不包含任何域的配置信息

```
forwarders { 114.114.114.114; };
forward only;
```
