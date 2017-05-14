# 在 Rails 里创建静态页面

## 利用控制器创建静态页面

原理就是，在生成 controller 时指定特定的 action，就会自动修改 route 和创建指定 action 对应的 view 文件。有些绕口：）

`rails g controller StaticPages home help`

**StaticPages** 也可以写成 **static_pages**

在 routes 中，`get 'static_pages/home'` 就已经指向了 home action。如果我们将其改为 `root 'static_pages#home'` 那么访问 `/` 时，就是用 home action 来处理了，反而原来的 `static_pages/home` 无法访问到了。

## 关于回滚的一些操作

`rails destroy StaticPages`

`bundle exec rake db:migrate`

`bundle exec rake db:rollback`

`bundle exec rake db:migrate VERSION=0`

## 如何编写测试

测试的三部曲：**遇红** => **变绿** => **重构**

让终端中的测试报告更好看一些，利用 gem minitest-reporter，在 test_helper.rb 中添加：

```
require 'minitest/reporters'
Minitest::Reporters.use!
```