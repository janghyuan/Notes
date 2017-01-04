## 设置国内的镜像

```
# 添加Anaconda的TUNA镜像
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/

# 设置搜索时显示通道地址
conda config --set show_channel_urls yes
```

## 在Mac下安装完毕后，将bin目录添加到PATH中

```
echo 'export PATH="~/anaconda2/bin:$PATH"' >> ~/.zshrc
```

根据安装的版本不同，相应地改为`anaconda3`

## 查看已安装的环境

```
conda info -e
```

## 创建新的环境

```
conda create --name python35 python=3.5
```
指定python的版本为3.5，它会为我们安装3.5.x系列中最新的版本，该命令只会安装python 3.5相关的必须项，如python、pip等，如果要安装anaconda集合包，就可以先切换到该环境后`conda install anaconda`
```
conda create --name python35 python=3.5 anaconda
```
该命令指定了anaconda，所以会安装anaconda的集合包

## 切换不同的环境

```
# 切换为python35环境
source active python35

# 切换为默认的环境
source deactivate python35
```

## 创建了那么多的环境，那么conda命令到底安装了多少个

不管安装的是python的哪个版本（2.7 3.5）的环境，始终使用的是同一个conda命令（都是root环境中的那个conda命令），即conda命令在不同的环境中都是可用的并且都指向root环境中的conda命令

## conda的包管理

- `conda list` 列出安装了哪些包
- `conda install package-name` 安装包
- `conda update package-name` 升级包
- `conda remove package-name` 删除包
- `conda search package-name` 搜索包

前4条命令都可以用`-n env-name`选项指定环境，如`conda install theano -n python35`在python35环境中安装theano

## conda环境的管理

删除一个已有环境`conda remove --name python35 --all`

## conda自身的管理

升级conda, `conda update conda`，升级anaconda集合包，`conda update anaconda`，升级python，`conda update python`
