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

## 反引号

会运行当前 shell 的命令 `ls`

## Array 常用方法

unshift -> [] <- push
shift   <- [] -> pop

## 代码块存在的意义解释

```
hi = proc { |x| puts x }
hi.call('world')
```

在 ruby 中，调用函数时可以不加括号直接调用，所有在传递参数时，如果参数是一个方法，就无法通过函数名方式直接传递。所以用代码块来传递，proc只能通过 call 方法来调用。

## lambda 和 proc 的区别

lambda 更加严格，对于 lambda 来说，如果定义了参数，在调用时必须传递参数。

lambda 的两种定义方式：
- `lambda { |x| ... }`
- `-> (x) { ... }`

proc 的两种定义方式：
- `proc { |x| ... }`
- `Proc.new { |x| ... }`

## 异常的捕获与处理

```
begin
  # ... 容易发生异常的代码
rescue => e
  # ... 异常发生后要处理的代码
  puts e.class
else
  # ... 异常没有发生要处理的代码
ensure
  # ... 无论是否发生都要执行的代码
end
```

## 关于赋值的一些操作

```
x = [1, 2, 3]
a, b = x # => a = 1, b = 2

a, *b = x # => a = 1, b = [2, 3]
```

## 关于字符串的多行赋值

```
a = 'world'
b = %Q{
  hello
  #{a}
}
# 如果是 %q 相当于 '' 不能用来插值操作

a = <<-HERE
  hello world
  #{b}
HERE
# 相当于 "" 可以用来插值
```

## 全局变量

- `$$` 当前进程 pid
- `$:` 当前的 loading path

## 布尔运算符

- and or not 的优先级是小于 && || !
- 同时，and or not 的优先级小于 =

## attr_accesser 的原理

```
class User
  def self.setup_accessor var
    define_method var do
      instance_variable_get "@#{var}"
    end
    
    define_method "#{var}=" do |value|
      instance_variable_set "@#{var}", value
    end
  end
  
  setup_accessor :name, :age
  
  def initialize name, age
    @name = name
    @age = age
  end
end
```

## 模块方法 include 和 extend 的区别

- include 将模块方法转变为实例方法
- extend  将模块方法转变为类方法
