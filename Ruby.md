## Ruby 的特点

- 解释型 不需要编译
- 泛型 变量不需要类型声明
- OOP 
- Module 
- 反射 元编程的例子，就是在程序运行起来后，可以反向探知程序的类的一些属性
- 垃圾回收

## Ruby 语法尝鲜

```
"Hello World".is_a? String

"hello world".gsub(/world/, 'huan').upcase  #=> HELLO HUAN
```

## api 文档

- http://apidock.com/ruby
- http://api.rubyonrails.org
- http://ruby-doc.org

## 基础数据类型

- Integer: 3, 342  (Fixum 已废弃)
- Float: 3.34
- String: hello world
- Boolean: true(TrueClass), false(FalseClass)
- Array: [1, 2]
- Hash: { "name" => "lee", "age" => 32 }
- Symbol: :abc :"hello world"
- Range: 1..10 1...10(not including 10) 'a'..'z'
- Regular Expression: /hello/i

## 变量赋值

```
a = 'hello'
a.object_id # => 2323
a.replace('world')
a.object_id # => 2323

a = 'hello'
a.object_id # => 1212
```

在给变量 a 赋值时，在内存内开辟了一个新的空间用来存储 hello，变量 a 只是指向了那块存储空间。replace 操作并没有改变那块存储空间的位置，只是改变了里面的内容。

## 反引号 ``

会运行当前 shell 的命令 `\`ls\``
