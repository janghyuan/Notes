## load 和 require

- 但从名字上理解，`load` 我们将加载的文件运行一下；`require` 我们需要包含文件中定义的一些类
- 情景1：我们只需要运行外部文件，不需要里面定义的常量、变量 `load 'function.rb', true`
  可以重复 `load`，如果我们不加第二个参数 `true`，那么引入的文件中的常量就会污染当前文件的命名空间
- 情景2：我们需要外部文件提供的类定义 `require 'function.rb'`，`require` 只需要引入一次

