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
