1. 当前最新 Rails 版本: `gem install rails -v '5.0.0.rc2'`
2. 部署到 Heroku 时，要先将测试数据库 `sqlite gem` 移动到 `:test`, `:development` 中，然后在 `:production` 中添加 `pg gem`，最后执行 `bundle install --without production` 
3. Rails 5.0 使用 `rails` 替换了 `rake`，例如: `rails db:migrate`
4. 如果部署到 Heroku 上的应用涉及到数据库迁移的，要执行 `heroku run rails db:migrate`
5. 启用 `minitest-reporters`: 在 `Gemfile` 中添加该 gem，然后在 `test_helper.rb` 中添加
    
    ```ruby
    require 'minitest/reporters'
    Minitest::Reporters.use!
    ```
