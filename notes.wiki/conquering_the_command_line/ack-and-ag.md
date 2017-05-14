# Ack & Ag command


* `ag DHH guides/` 

  递归的在 guides 目录下寻找 DHH。

* `ag -Q .rb` 
   
   由于 ag 命令默认是使用正则表达式来执行搜索的，所有 `.rb` 会被当作任何以 rb 结尾的单词。但我们的原意只是想找到 `.rb`。
   所以，我们要加上 `-Q` 参数。
   `ag -Q .rb`

* `ag DHH -l`

  ag 命令返回的信息包括文件名和找到匹配单词的上下文，内容非常多，有时我只需要知道文件名，所有要加上 `-l` 参数。

* `ag readme -l -i`

  ag 默认是区分大小写的，加上 `-i` 参数会返回更多不区分大小写的信息！

* `ag readme -l -i -G ec$`

  不区分大小写查找 readme 返回的文件路径中的以 ec 结尾的文件

* `ag readme -l --ignore-dir=railties/lib --ignore-dir=guides/code`

  在查询的结果中排出掉用 `-ignore-dir` 指定目录的文件。

  虽然 `-ignore-dir` 是忽略目录的意思，但是也可以用它将查询结果的指定文件忽略。

  `ag readme -l --ignore-dir="*.rb"`

* `ag readme -l --skip-vcs-ignores`

  ag 默认开启了对 VCS 的忽略文件支持：例如 git 的 `.gitignore` 文件。要想关闭它就要加上 `-skip-vcs-ignores` 参数。

* `.agignore` 文件

  该文件独立于各 VCS 系统的 ignore 文件。使用 `-skip-vcs-ignores` 参数时不会忽略该文件。

* Ag is ten times faster than Ack:)