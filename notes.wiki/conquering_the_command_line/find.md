# Find 查找文件

ag 命令查找指定字符所在的文件，而 find 命令寻找符合标准的文件而已，不查找文件的内容只是文件名。

* `find . -name model.rb`

  ```bash
  ➜  rails-code  find . -name model.rb
  ./activemodel/lib/active_model/model.rb
  ./activerecord/lib/rails/generators/active_record/model/templates/model.rb
  ```

* `find . -name \*model.rb`

  ```bash
  ➜  rails-code  find . -name \*model.rb
  ./activemodel/lib/active_model/model.rb
  ./activemodel/lib/active_model.rb
  ./activerecord/lib/rails/generators/active_record/model/templates/model.rb
  ./activerecord/test/models/arunit2_model.rb
  ./railties/lib/rails/generators/active_model.rb
  ```

  由于我们需要把 `*` 传递给 find 命令，而不是让操作系统的 bash 提前把 `*` 解析，所以要在前面加 `\` 转义。也可以用引号将其包裹起来 `find . -name '*model.rb'`。

* `find . -path \*session\*`

  前面的两个命令的 pattern 只在文件名中寻找，如果指定 `-path` 就在文件的完整路径中寻找指定的 pattern。查找的结果中不仅有文件也有目录。

  指定 `-type` 选项，在结果中过滤：

    * `find . -path \*session\* -type d` 只看目录
    * `find . -path \*session\* -type f` 只看文件

* `find . -path \*session\* -type f -name \*mem\*`

  同时满足路径里含有 session，名称里含有 mem，这是 and 必须同时满足两个条件。

* `find . \( -name \*.gemspec -or -name \*.jpg \) -type f`

  最后一个 `-type f` 参数只是为了演示括号的使用，括号是需要被转义的。

* `find . \! -path \*t\* -type f`

  在使用 not 参数时，可以用 `-not`，但是推荐使用 `\!`，路径里不含字母 t 的文件。not 仅对他后面的一个参数取反。

* `find . -mtime -1`

  过去24小时内修改过的文件

* `find . -mmin -5`

  过去5分钟内修改过的文件，这两个命令都不需要制定 `-type f` 默认返回的就是文件而不是目录。

* `find . -size +200k`

  文件大小大于 200kB

* `find \! -path '*/\.*' -size +200k`

  将 .git 目录排除，经测试 `.` 不需要转义也能执行成功。

* `find guides/ -name \*.yml -type f -print -delete`

  将 guides 目录下所有以 yml 结尾的文件打印出来并且删除。
