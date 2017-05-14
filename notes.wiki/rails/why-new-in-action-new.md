# Rails 里的 new action 为什么要执行

## 1. post 到 /articles

会调用 controller articles 里的 create action，数据验证如果不通过

## 2. render :new

该步骤并不会发出一个新的 request，而是还是原来的 post request，调用 render 而不是 redirect_to，render 会把这个导致数据验证错误的 @article 对象传递到 new view 中。

## 3. 如何接收这个错误的 @article

new view 接收后就会把 @article.errors.full_messages 打印到网页上。

## 4. get /articles/new 时出错了。

因为我们在 new view 里加入了检测 @article.errors 的机制，所以我们在取回 new 的 view 时，@article 会是 nil，执行 @article.errors.any? 就会报错。所以我们要在 new action 里加入 @article = Article.new