# 在文件系统中存活

## 1. Home 家目录 (~)

在自己的家目录里，你可以随心所欲，但是一旦出了家门你就需要 **sudo**。家目录通常用 `~` 表示，在 Mac 上代表的就是 `/Users/<username>`，在 Linux 中就是 `/home/<username>`。家目录里存放着你的配置文件（无数软件的 dotfile）、你的文档、你的任何私有的东西，其他用户默认是无法访问到的。

## 2. 打印工作目录 Present Working Directory (pwd)

Present Working Directory (PWD) 直白的名字，是您迷路时的好帮手！

`pwd -P` 打印出当前目录的实际地址，`-P` 参数会解析出软链接指向的实际目录地址。

```bash
ln -s /Users/<username>/Dropbox/notes.wiki /Users/<username>/notes

pwd      # => /Users/<username>/notes
pwd -P   # => /Users/<username>/Dropbox/notes.wiki
```

## 3. 列出目录 List Directory (ls)

`ls -lhSr` 长格式、人类可读的文件大小、以文件大小为排序基准、反序排列。把 `-S` 换成 `-t` 就可以以文件的最近修改日期为基准排序。

## 4. 链接 Link (ln)

链接有软硬之分。软链接基本可以取代硬链接。

* 硬链接不能在不同的文件系统中创建，例如你想在你的家目录里创建一个U盘里文件的硬链接，在 Mac 里就会出现一个 `Cross-device link` 错误。而且硬链接不能为目录创建链接。用硬链接创建的文件实质上是源文件的一次完美拷贝。在用 `ll` 查看目录的详细内容时的第二列就是指的文件的硬链接数。
  
  创建硬链接时，如果目标文件存在就会报错，强制执行的话用 `-f` 参数。

* 软链接除了可以在不同文件系统中创建外，也支持对目录的链接创建。加 `-s` 参数创建软链接。

## 5. 改变目录 Change Directory (cd)

* `cd ~` 或者 `cd` 都会进入到你的家目录。
* `cd ..` 当前目录的副目录

## 6. 创建目录 Create Directory (mkdir)

* 创建目录时显示详细信息 `-v` verbose 很多命令都会用到这个参数做冗余信息的输出。
* 创建多层目录 `-p`，创建多层目录时，加上 `-v` 参数是没有用的。

## 7. 复制文件 Copy Files (cp)

* 当源文件是多个文件时，目标文件必须是目录
  
  ```bash
  cp file1.json file2.json json/
  ```

* 当源文件是目录时，要加上 `-R` 参数，目标文件必须是目录

  ```bash
  cp -R path/to/directory path/to/new/directory
  ```

* `-f` 强制覆盖参数
* `-i` 请求确认覆盖参数

## 8. 删除文件 Deleteing Files (rm)

* `rm -rf` 强制递归的删除任何东西
* 一个小技巧：由于 rm 是不加确认的无法恢复的删除，所以删除前最好用 ls 命令确认要删除的文件。确定完毕后，就可以用 `!*` 代替 ls 命令的参数。
  
  ```bash
  ls *.json
  rm -rf !*
  ```

## 9. 移动文件 Moving File (mv)

* 移动目录时，不需要加任何参数
* 重命名文件

## 10. 输入输出

* `ps aux | grep spring` 
  
  找到 spring 相关的进程，这里管道 `|` 把第一个命令的输出重定向到了第二个程序的输入。

* `>>` 追加文件内容
  
  例如我们有一条设置语句追加到 `.zshrc` 文件中。

  `echo 'function proxy { ... }' >> .zshrc`
