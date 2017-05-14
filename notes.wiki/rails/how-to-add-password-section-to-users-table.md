# 如何在 users table 里添加密码支持

* ### 1.
  
  ```
  has_secure_password
  ```

* ### 2.

  ```
  gem 'bcrypt'
  ```

* ### 3. 

  ```
  validates :password, length: { minimum: 6 }
  ```

* ### 4.

  ```
  rails g migration add_password_digest_to_users
  rake db:migrate
  ```

* ### 原理：

  在 User Class 添加 has_secure_password 方法后：

    * 提前在 users table 里添加密码的存储区域 password_digest，第四步已添加迁移文件。

    * 自动在 user 对象上添加 password 和 password_confirmation 两个虚拟属性，在进行 user 的有效性验证时，会自动验证 password 和 password_confirmation 的存在性和匹配性。

    * 为 user 添加 authenticate 方法，来进行验证密码的有效性，如果密码正确返回相应的对象，否则返回 false。