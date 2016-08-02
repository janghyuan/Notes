# FTP 服务配置

1. 安装

	`yum install -y vsftpd`
	
2. 启动

	`service vsftpd start`
	
3. 配置文件

	- /etc/vsftpd/vsftpd.conf
	- /etc/vsftpd/ftpusers 黑名单
	- /etc/vsftpd/user_list 控制名单
	- /var/ftp  ftp 共享目录

4. 用户类型

	- 系统用户（用户的家目录）
	- 匿名用户（anonymous，/var/ftp）

		匿名用户上传：
		```
		anon_upload_enable=YES
		anon_mkdir_write_enable=YES
		```
		
	- 虚拟用户（ftp-only）
