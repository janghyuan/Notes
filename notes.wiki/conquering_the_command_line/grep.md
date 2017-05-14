# Grep

* `grep Pack README.md`
  
  默认区分大小写，pack 和 Pack 是不同的
* `grep "r..y" README.md`

  Pattern 默认是正则表达式
* `grep -n rails README.md`

  显示行号
* `grep -c rails README.md`

  统计出现的行数，一行出现多个匹配，也算在一行内
* `grep -i rails README.md`

  开启大小写不敏感选项
* `grep -R rails .`

  在当前目录内，递归的在其所有子目录中搜索
* `grep -R --include "*.yml" rails .`

  只在 .yml 文件中递归的搜索
* `ps -e | grep forego`

  更通用的形式是用另一个命令的输出作为自己的输入
* `grep -v "^$" README.md | grep -v a`

  `"^$"` 空行的正则表达式，`-v` 取反，不是空行的行，然后把输出传给下一个 grep，选取不包含字母 a 的行。