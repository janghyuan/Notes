1. 当前最新 Rails 版本: `gem install rails -v '5.0.0.rc2'`
2. 部署到 Heroku 时，要先将测试数据库 `sqlite gem` 移动到 `:test`, `:development` 中，然后在 `:production` 中添加 `pg gem`，最后执行 `bundle install --without production`
3. Rails 5.0 使用 `rails` 替换了 `rake`，例如: `rails db:migrate`
