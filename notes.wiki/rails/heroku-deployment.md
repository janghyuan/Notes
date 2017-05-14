# 如何在 heroku 上部署 rails 应用

## 1. 更新 Gemfile

由于 heroku 使用 PostgreSQL，所有我们要把 pg gem 添加到 Gemfile 的 production 组中。Heroku 使用这个 rails_12factor  gem 伺服静态资源，例如图片和样式表。

```ruby
group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
end
```

## 2. 更新 Gemfile.lock 文件，并将改动提交到仓库中

`$ bundle install --without production` 

执行此命令后，并不会在本地安装新的 gem，但是又必须执行这个命令，因为我们要把 pg 和 rails_12factor 添加到 Gemfile.lock 中。然后提交这次改动：

`git commit -am 'update Gemfile.lock for heroku`

## 3. 创建 heroku app

* `heroku version` 确定本机是否安装好 heroku 命令行程序。
* `heroku login` 登陆到 heroku
* `heroku keys:add` 将你到公钥添加到 heroku
* `heroku create` 创建程序

## 4. 将本地仓库 push 到 heroku

`git push heroku master` 

程序部署到 heroku

**注意：**

`heroku create` 

创建的程序会有一个随机的名字，不容易记。所以通常我们会重命名：

`heroku rename new-name`。

## 5. 在本地开发中涉及到的数据库操作都要在 heroku 上执行一遍

`heroku run rake db:migrate`