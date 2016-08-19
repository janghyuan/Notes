## R 的安装

- R 下载链接：https://mirrors.tuna.tsinghua.edu.cn/CRAN/
- RStudio 下载链接：https://www.rstudio.com/products/rstudio/download2/

每一步按照安装程序默认即可

## 熟悉 R 语言

- 创建变量 `x = 9` `y <- 11` 两种方式都可以
- 打印变量 `print(x)` `x`
- 显示当前所有变量 `ls()`
- 删除一个变量 `rm(x)`
- 字符串类型 `xx = "foobar"`
- 除法（都是浮点型）
- `log(x)` `exp(x)` 都是以 e 为底
- `log2(x)` 以 2 为底
- `sqrt(x)` 求平方根
- `x^2` 平方
- `abs(x)` 绝对值
- R 语言注释 `# this is comment`

在 R 语言中变量被称为 object，object 命名可以用‘字母’、‘点’、‘数字’，所以 `x.1` 是合法的变量名，但是‘数字’不能做变量名的开头。

## 创建向量矩阵

- `x1 <- c(1,3,5,7,9)` 创建向量用 concatenate command 简称 c command
- `gender <- c("male", "female")`
- `2:7` sequence numbers
- `seq(from=1, to=7, by=1)` 更加通用的创建 sequence 的方式
- `seq(from=1, to=7, by=1/3)` 
- `seq(from=1, to=7, by=0.25)`
- `rep(1, times=10)` 重复 10 次全是 1
- `rep("marin", times=5)`
- `rep(1:3, times=5)` 重复一个 1到3 的序列 5 次
- `rep(seq(from=2, to=5, by=0.25), times=5)`
- `rep(c("m", "f"), times=5)`
- 两个向量（长度一样）的 + - * / 都是相对于向量中的每一个元素的
- 获取向量中的元素
  - `x[1]` 向量中第一个元素，在 R 中索引是从 1 开始的
  - `x[1:3]` 获取 1 - 3 的元素
  - `x[-1]` 获取除了第一个元素外的所有其他元素
  - `x[c(1,5)]` 获取第 1 个和第 5 个元素
  - `x[x<5]` 获取 x 中所有小于 5 的元素
- 创建矩阵 `matrix(c(1,2,3,4,5,6,7,8,9), nrow=3, byrow=TRUE)` byrow 的意思是按 行还是列 来优先填满元素
- 获取矩阵中的元素
  - `mat[1, 2]` 取得第一行第二列
  - `mat[c(1,3), 2]` 取得第一行第二列，第三行第二列中的元素
  - `mat[2,]` 取得第二行所有的元素

## 导入数据

- 在 Excel 中可以直接将数据导出为 csv 文件和以 tab 分隔的数据形式
- 查看某个函数的帮助信息 `help(read.csv)` `?read.csv`
- `data = read.csv(file.choose(), header=T)` 通过 `file.choose()` 函数，我们可以打开一个文件选择对话框来选择文件，`header` 选项指示我们 csv 文件中存在标题栏
- `data = read.delim(file.choose(), header=T)` 该函数可以读取以 tab 分隔的文件
- 更加通用的方式是我们自己指定分隔符 `data = read.table(file.choose(), header=T, sep=",")` 或者是 `sep="\t"`
- 查看导入数据的维数 `dim(data)` 
- 查看导入数据的标题栏 `names(data)`
- 查看导入数据的前 6 行 `head(data)`
- 查看导入数据的后 6 行 `tail(data)`
- 查看指定行数的数据 `data[c(1,3,5), ]` 或者 `data[-(4:722), ]` 用 - 号取反

## 处理导入的数据

- 假设我们导入数据到 data 变量中，我们要取得其中一列 Age 的平均值
  - `mean(data$Age)`
  - `attach(data)` `mean(Age)`
- 数据的类型用 `class(Age)` 来获取
  - numeric 带小数点的
  - integer 整型
  - factor 类别型，查看该类别下有哪些选项：`levels(Gender)`
- 统计信息命令 `summary(data)`
- 一般在类别型数据（factor）中我们用 1 表示 yes， 0 表示 no，但是 R 会把他们看成是 numeric，所以我们要进行转换。
 
  ```
  x = c(0,1,1,1,1,0,0,0,1)
  x = as.factor(x)
  class(x) # factor
  ```

## 取出数据的子集

当我们导入数据后，并且 attach 后：

- `mean(Age[Gender=='female'])` 可以取出所有女性的平均年龄
- `FemaleData = LungCapData[Gender=='female', ]` 所有女性的数据
- `MaleData = LungCapData[Gender=='male', ]` 所有男性的数据
- `MaleOver15 = LungCapData[Gender=='male' & Age > 15, ]` 所有大于 15 岁的男性

## Logic 运算

- `temp = Age > 5` 的产出是一系列的 TRUE FALSE
- 如果想转换为 0，1 的话：`temp = as.numeric(Age > 5)`
- 如果我们想为原始数据再加一列（女性吸烟者标记为 TRUE）
  ```
  FemSmoke <- Gender=='female' & Smoke=='yes'
  MoreData <- cbind(LungCapData, FemSmoke)
  ```
- 删除工作区的所有变量 `rm(list=ls())`

## 设置工作目录

- 获取当前工作目录 `getwd()`
- 设置工作目录
  ```
  currentWD = "/Users/username/Desktop/project-1"
  setwd(currentWD)
  ```
- 保存当前工作环境（假设我们已经创建了很多变量）`save.image("FirstProject.Rdata")` 不加路径的话，默认是保存在当前的工作目录下的。
- 退出 Rstudio `q()` 会提示你时候保存当前的工作环境
- 加载以前保存的工作环境，先设置好当前工作目录，让后再加载 `load("FirstProject.Rdata")` 或者 `load(file.choose())` 

## 撰写 R 脚本

- R 脚本以 `.R` 结尾
- 在 RStudio 中加载进脚本后，可以单行执行，也可以选中多行进行多行执行
- 在 RStudio 中，脚本编辑器和命令行都可以进行 Tab 键补全

## 安装 R 拓展包

- `install.packages("epiR")` 安装 `epiR` 扩展包
- 如果不指定包名，则会显示全部的扩展包列表
- 在一个 R session 中，每次都要加载相应的扩展包才能使用其功能，退出该 session 后，扩展包也跟随消失了 `library(epiR)` 
- 查看一个扩展包的帮助文档 `help(package = epiR)`
- 删除一个扩展包 `remove.packages("epiR")` 

## barchart & piechart

- 柱状图统计的是类别数据的出现频次（Frequency），所以我们传递给 `barplot()` 的参数就是一个 Frequency Table，而如何产生这个 table，就需要 `table()` 命令
  ```
  barplot(percent, main="TITLE", xlab="Gender", ylab="%", las=1, names.arg=c("Female", "Male"))
  ```
  解释:
  - `main` 标题
  - `xlab` `ylab` x,y 轴的名称
  - `las` 将 y 轴的刻度表示水平显示
  - `names.arg` 将每一个柱状图的的标识改成指定的
  - `horiz=T` 将主转图水平显示，并且要更改 x,y轴的顺序

- 饼状图 `pie(percentage)`
