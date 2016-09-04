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

__补充内容：numeric 和 integer 的区别在哪里？__ http://stackoverflow.com/questions/23660094/whats-the-difference-between-integer-class-and-numeric-class-in-r

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

## boxplot 详解 quartile & quantile

__先搞清楚什么是 quartile & quantile:__ https://en.wikipedia.org/wiki/Quartile

__quartile__ 是「四分位点」，具体来说就是用 3 个位点把数据分为 4 个部分，第一分位点（最小值到中值之间中间的那个点）也就是将数据分为前 25% 和 后 75% 的那个点；第二分位点就是中值，第三分位点（中值到最大值之间中间的那个点）

而 R 语言中的 quantile 命令可以让我们自己设定分位点的位置和个数：
`quantile(LungCap, c(0, 0.25, 0.5, 0.75, 1))` 就可以查看最小值，第一分位点，中值，第三分位点，最大值的情况。

![屏幕快照 2016-09-02 上午7.11.30.png](https://ooo.0o0.ooo/2016/09/01/57c8b5cd75f0c.png)

__命令__: `boxplot(LungCap ~ Gender, main = "Boxplot by Gender", ylim = c(0, 16), las = 1, ylab = "Lung Capacity")`
- `LungCap ~ Gender` 以 `Gender` 为分类标准，将 `LungCap` 分为两部分并分别画图比较（在一个 boxplot 里）
- `main = "Boxplot by Gender` 设置图的标题
- `ylim = c(0, 16)` 设置纵坐标值的标度
- `las = 1` 将纵坐标值的标度书写方式横过来写（治疗颈椎病专用）
- `ylab = "Lung Capacity"` 设置纵坐标的名称

## 分层的 boxplot

__举例说明__：肺活量（numeric value）与是否抽烟（categorical value）的关系。如果我们考虑所有年龄段的总体数据，得到的结果反而是抽烟者的肺活量总体上比不抽烟者要大，这是违背通常我们感官的的。所以它们之间的关系是分年龄段的，我们可以考虑在不同的年龄段比较肺活量和是否抽烟的关系。

__为什么会出现违背我们感官的结果：__

- 如果我们把 3 - 19 岁的小孩考虑上，在这个区间内吸烟者比不吸烟者年龄一般要大
- 在这个 3 - 19 岁的区间内，考不考虑吸烟的问题，大孩子一般比小孩子的肺活量要大

所以，我们会考虑只选取年龄 18+ 的数据，进行测试肺活量与是否抽烟的关系：

`boxplot(LungCap[Age >= 18] ~ Smoke[Age >= 18], main = "LungCap vs Smoke for 18+", ylab = "Lung Capacity", las = 1)`


- `AgeGroups = cut(Age, breaks = c(0, 13, 15, 17, 25), labels = c("<=13", "14/15", "16/17", "18+"))`
  `cut` 命令的总体效果就是把一个 numeric 数据转换成了 categorical 类型的数据。通过上述命令我们将 Age 数据转换成了 4 个区间。我们可以用 `levels(AgeGroups)` 来查看。
- `boxplot(LungCap ~ Smoke*AgeGroups, main = "LungCap vs Smoke, by AgeGroups", ylab = "Lung Capacity", las = 1)`
  `Smoke * AgeGroups` 的意义在将数据分成了 8 份。
- `boxplot(LungCap ~ Smoke*AgeGroups, main = "LungCap vs Smoke, by AgeGroups", ylab = "Lung Capacity", las = 2)`
  将 las 改为 2，因为横坐标轴的刻度写不开了。。
- `boxplot(LungCap ~ Smoke*AgeGroups, main = "LungCap vs Smoke, by AgeGroups", ylab = "Lung Capacity", las = 2, col = c(4,2)`
  用 `col = c(4, 2)` 指定颜色，4 代表蓝色，2 代表红色，我们只指定了 2 种颜色，但是图中有 8 个 box，R 会循环使用这两种颜色
- `boxplot(LungCap ~ Smoke*AgeGroups, main = "LungCap vs Smoke, by AgeGroups", ylab = "Lung Capacity", las = 2, col = c(4, 2), axes = F, xlab = "Age Strata")
  用 `axex = F` 将坐标轴的刻度全部取消，用下面自己定义的坐标值重画，取消坐标值的同时，box 的边框也被取消了，所以我们要用 `box()` 命令重绘
- `axis(2, at = seq(0, 20 , 2), seq(0, 20, 2), las = 1)`
  重绘纵坐标值 `at` 指定绘制的位置
- `axis(1, at = c(1.5, 3.5, 5.5, 7.5), labels = c("<=13", "14/15", "16/17", "18+"))`
  重绘横坐标值
- `legend(x = 5.5, y = 4.5, legend = c("Non-Smoke", "Smoke"), col = c(4, 2), pch = 15, cex = 0.8)`
  绘制图例，`pch = 15` 指定图例中的形状类型，`cex = 0.8` 指定图例相对于整个 box 的比例

## 绘制 Histograms

![屏幕快照 2016-09-03 下午9.51.26.png](https://ooo.0o0.ooo/2016/09/03/57cad582cf80a.png)

`hist(LungCap, main = "Histograms of Lung Capacity", freq = F, ylim = c(0, 0.2), breaks = seq(from = 0, to = 16, by = 2), xlab = "Lung Capacity", las = 1)`

- `freq = F` 纵坐标表示 概率密度，也可以用 `prob = T` 来设定
- `ylim = c(0, 0.2)` 设置 y 坐标轴的刻度
- `breaks = seq(from = 0, to = 16, by = 2)` 设定分成多少个柱状图，也可以用 `breaks = 14` 来设定

`lines(density(LungCap), col = 2, lwd = 3)` 

- `col = 2` 设置红色线
- `lwd = 3` 设置线的粗细

## 绘制 stem & leaf plot

举个栗子解释下什么是 stem plot：

数据集：1.1, 1.2, 1.5, 2.5, 2.8, 3.1, 3.8, 3.9

绘制的图形：

```
1 | 125
2 | 58
3 | 189
```

![屏幕快照 2016-09-04 上午9.25.57.png](https://ooo.0o0.ooo/2016/09/04/57cb7848a6800.png)

`stem(femaleLungCap, scale = 2)` 

`scale = 2` 可以将每个分支，再分为两个分支，其中一个 1.0 - 1.4，另外一个 1.5 - 1.9

![屏幕快照 2016-09-04 上午9.28.00.png](https://ooo.0o0.ooo/2016/09/04/57cb78b8ba97a.png)
