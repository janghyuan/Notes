- 当前最新 Rails 版本: `gem install rails -v 5.0.0.1`
- `rails _5.0.0.1_ new app` 用指定的 Rails 版本创建项目
- Gemfile 里的 gem 版本号
- 部署到 Heroku 时，要先将测试数据库 `sqlite gem` 移动到 `:test`, `:development` 中，然后在 `:production` 中添加 `pg gem`，最后执行 `bundle install --without production`，最后将改动提交到版本控制中。
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
