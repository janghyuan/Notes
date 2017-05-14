# Curl

curl 最大的用途就是测试 web 程序的 API 接口了。它将你从浏览器发出的请求换到从命令行中发出，还能发送 POST PATCH PUT DELETE 请求，是测试网站接口的利器。

* `curl -i http://blog.dev/hello`

  返回相应请求的回应（详细信息）

* `curl -L http://blog.dev/redirect`

  自动重定向到新的网址。在下载资源时常用，有时一些资源移动位置之后，为了让不知道的人还能访问到就会做此设置。

* `curl -O http://blog.dev/image.jpg`

  如果不加 `-O` 参数，你会在终端中得到一些大量的无用的二进制信息。该命令会将图片下载到当前目录。

  `curl -o my_image.jpg http://blog.dev/image.jpg` 

  利用 `-o` 重命名下载的图片文件。

* `curl -X POST "http://blog.dev/echo?name=username&age=23"`

  利用 `-X` 参数对指定网址发送指定的 POST 请求，传递参数利用 url 的 query string

* `curl -X POST -d "name=username&age=23" http://blog.dev/echo`

  利用 `-d` 参数传递请求参数

* `curl -X POST -d "{ \"name\" : \"username\" }" http://blog.dev/echo`

  利用 `-d` 参数在 request body 里传递了 json 数据到服务器。

* `curl -X POST -d @form_data.json http://blog.dev/echo`

  如果 json 文件的内容非常多，我们就不能利用上一条命令把参数一个一个写上了，而是将 json 文件整个上传到服务器上。

* `curl -X POST -F user[name]=username -F user[age]=23 -F foo=bar http://blog.dev/echo`

  用 `-F` 参数来模拟 HTML form 表单的形式传递参数。

* `curl -X POST -F user[name]=username -F user[age]=23 -F foo=bar -F user[photo]=@path/to/image.jpg http://blog.dev/echo`

  利用 HTML form 表单的形式上传文件内容。

* `curl -X POST -d @form_data.json http://blog.dev/echo -H "Accept: application/json" -H "X-Auth: 1234567890"`

  利用 `-H` 参数指定请求的 Header 信息，可同时指定多个 Header 信息，上面的命令就是请求服务器发送 json 格式文件响应我的请求。

* `curl -X POST -u "username:password" http://blog.dev/login`

  http basic auth 的简单认证，通过 `-u` 参数传递认证信息。在 rails 里正好有一个 `http_basic_auth` 函数来制作简单的认证系统。

* 当 whoami 页面需要用 session cookie 认证时，我们先把登陆后得到的 header 和 cookie 文件保存下来，第二步再用该文件传递到服务器进行认证。

  1. `curl -X POST -u "username:password" -D headers http://blog.dev/login`
  2. `curl -b headers http://blog.dev/whoami`

* 前面的命令不仅把 cookie 保留下来，多余的 header 也保留来下来，在做认证时，我们只需要 cookie 文件。

  1. `curl -POST -c cookies.txt -u "username:password" http://blog.dev/login`
  2. `curl -b cookies.text http://blog.dev/whoami`