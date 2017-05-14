# 将 bootstrap-sass 集成到 rails 项目中


1. 将 bootstrap-sass 添加到 Gemfile 中 `gem bootstrap-sass`

2. 将 `app/assets/stylesheets/application.css` 更名为 `.scss` 的后缀

3. 在 `application.scss` 中添加

   ```
   @import 'bootstrap-sprockets';
   @import 'bootstrap';
   ```

   顺序不能反，为了能让 icon fons 正常工作
4. 在 `application.js` 中添加

   ```
   //= require jquery
   //= require bootstrap
   ```

---

[**Reference Link:** https://github.com/twbs/bootstrap-sass](https://github.com/twbs/bootstrap-sass)