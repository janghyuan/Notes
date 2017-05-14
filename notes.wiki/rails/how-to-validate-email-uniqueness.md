# 如何验证 email 的唯一性

* ### 1. 

  ```
  validate :email, uniqueness: { case_sensitive: fasle }
  ```

* ### 2.

  ```
  rails g migration add_index_to_users_email
  add_index :users, :email, unique: true
  rake db:migrate
  ```

* ### 3.

  ```
  before_save { self.email = email.downcase }
  ```
* ### 4. 

  ```
  test/fixtures/users.yml delete the content
  ```
  