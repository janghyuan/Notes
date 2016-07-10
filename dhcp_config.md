# DHCP 服务配置

1. 安装 dhcp 服务

	```
	yum install -y dhcp
	```
	
2. 拷贝样本配置文件

	```
	find / -name dhcpd.conf.sample
	cp /usr/share/doc/dhcp-3.0.1/dhcpd.conf.sample /etc/dhcpd.conf
	```
	
3. 配置文件

	```
	subnet 192.168.1.0 netmask 255.255.255.0 {
		option routers 192.168.1.1;
		option domain-name-servers 192.168.1.1;
		range dynamic-bootp 192.168.1.200 192.168.1.210;
	}
	```

4. 启动 dhcp 服务

	关闭路由器的 dhcp 服务，让本机的 dhcp 服务。
	
5. 客户端的配置

	```
	ipconfig /release # 断网重连
	ipconfig /renew
	```

