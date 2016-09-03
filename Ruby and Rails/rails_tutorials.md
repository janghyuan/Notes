## 第一章：从零开始，完成一次部署
- 当前最新 Rails 版本: `gem install rails -v 5.0.0.1`
- `rails _5.0.0.1_ new app` 用指定的 Rails 版本创建项目
- Gemfile 里的 gem 版本号
  - 不指定版本号时，总是安装最新的版本
  - `gem 'uglifier', '>= 1.3.0'` 安装版本号大于或等于 1.3.0 的最新版
  - `gem 'coffee-rails', '~> 4.0.0'` __主版本__.__次版本__.__补丁版本号__，只安装补丁版本号的更新
- `git checkout -f` 如果改动为添加到 staging area，可以用此命令取消所有改动
- Git 工作流
  - `git checkout -b topic-branch`
  - do some change
  - `git c -am 'do some change'`
  - `git checkout master`
  - `git merge topic-branch`
  - `git branch -d topic-branch`
- Heroku 部署步骤
  - `heroku version` 查看是否安装 heroku toolbelts
  - `heroku login`
  - `heroku keys:add`
  - `heroku create`
  - `git push heroku master`
  - `heroku rename new-name`
- 部署到 Heroku 时，要先将测试数据库 `sqlite gem` 移动到 `:test`, `:development` 中，然后在 `:production` 中添加 `pg gem`，最后执行 `bundle install --without production`，最后将改动提交到版本控制中。

## 第二章：玩具应用

- MVC 架构详解
  ![屏幕快照 2016-09-04 上午7.37.48.png](https://ooo.0o0.ooo/2016/09/03/57cb5eee72a6a.png)

- 生成脚手架 `rails g scaffold User name:string email:string`
- Rails 5.0 使用 `rails` 替换了 `rake`，例如: `rails db:migrate`
- 如果部署到 Heroku 上的应用涉及到数据库迁移的，要执行 `heroku run rails db:migrate`
- 启用 `minitest-reporters`: 在 `Gemfile` 中添加该 gem，然后在 `test_helper.rb` 中添加
    
    ```ruby
    require 'minitest/reporters'
    Minitest::Reporters.use!
    ```

- 回退指南
    - `rails db:migrate` -> `rails db:rollback`
    - 回到最初始的状态：`rails db:migrate VERSION=0`
    - `rails g model User ...` ->  `rails d model User`

- 测试 helper 方法
    ```ruby
    require 'test_helper'
    class ApplicationHelperTest < ActionView::TestCase
        ...
    end
    ```
    
- 关于 bootstrap-sass 的一切 [bootstrap-sass](https://github.com/twbs/bootstrap-sass)
- 集成测试 `rails g integration_test site_layout` `rails test:integration`
- `get '/help', to: 'pages#help', as: 'helf'` as 之后就覆盖了原来的 `help_path`
- 如果要在测试中使用 helper 方法，就要在 `test_helper.rb` 中 `include ApplicationHelper`
- 模型测试 `rails test:models`
- 为 email 字段添加索引 `rails g migration add_index_to_users_email`
    ```ruby
    add_index :users, :email, unique: true
    ```

- 添加用户密码
    
    `has_secure_password`
    
    1. `rails g migration add_password_digest_to_users password_digest:string`
    2. `password` and `password_confirmation`
    3. `authenticate` method
    
    `bcrypt` gem in your Gemfile

- 关于三种环境的切换
    - `rails console test`
    - `rails server --environment production`
    - `rails db:migrate RAILS_ENV=production`

- 对象 yaml 化
    ```ruby
    user = User.first
    puts user.attributes.to_yaml
    ```
    
- 还原数据库 `rails db:migrate:reset`
- 只测试指定的文件 `rails test test/integration/users_login_test.rb`
- 测试指定文件中的指定的测试 `rails test test/integration/users_login_test.rb --name test_valid_login`
- helper 是自动在视图中可用的，如果要在 controller 使用，则要在 `application_controller.rb` 中引入该 helper 文件。
