# Ruby 学习笔记

Ruby 语言的创造者是 Yukihiro Matsumoto，而现在最火的 Web 开发框架 Rails 和 Rails 的测试工具 Rspec 仅仅是在 Ruby 之上的领域专属语言（Domain Specific Languages）。DSL 可以理解为一种用 Ruby 语言实现的解释器，一种更高层次上的抽象。

Ruby 的版本在 1.9.3 之后，就随身附带了 RubyGems 包管理工具了。

## 写 Ruby 代码的风格设定：

1. TAB 的设定为 2 个空格，缩进应该使用空格符而不是制表符。
2. \# 该符号之后的当前行的所有内容为注释。
3. 命名文件、命名变量、命名方法的时候用 snake_case。
4. 命名常量时全用大写字母。
5. 处理 do block 时，如果 block 的语句能写在一行里，那么倾向于使用 ｛｝ 语法把它们写在一行里。
6. 命名类名时使用 CamelCase，每个单词的首字母大写。

## 读懂 Ruby-Doc.org

![Ruby-Doc](http://d2aw5xe2jldque.cloudfront.net/books/ruby/images/ruby_doc.jpg)

1. 在 Ruby 中，每一个 Class 都属于某一个命名空间。
2. Class / Module Index 包含了你正在查看的 Class 的命名空间下其他所有的类和模块名。
3. Included Modules 你正在查看的 Class 可以访问其模组的功能。
4. :: 这个符号在 ruby-doc 中指示的是方法是类方法，而在 ruby 代码中则指示命名空间的意思。

## 基础知识

### String

双引号和单引号的区别，双引号可以 interpolation。
   
```ruby
num = 'ten'
puts "My favourite number is #{num}!"
```

### Symbols

当你想使用一个字符串，但不想把他打印到屏幕或是改变他时，就可以使用一个 symbol。在单词前加入冒号。

```ruby
:"This is also a symbol!"
```

### Nil

nil 就是无值，在 if 语句中代表 false，但是比较 false 和 nil 时，它们是不相等的。

### Expression and Return

在 Ruby 中只有表达式一说，任何表达式都有返回值，即使返回值是 错误信息或是 Nil。

### Variable Scope

1. block 创造作用域。
2. 内部作用域可以访问外部作用域，反之则不可以。
3. 紧跟方法调用的 block 才会创造作用域，例如

   ```ruby
   arr = [1, 2, 3]
   for i in arr do 
     a = 5  # a 是可以被外部访问到的，因为 for 是 ruby 的语法单位并不是方法调用
   end
   ```

4. 方法内有他自己的作用域

### 变量的类型

1. 常量 Constants：在 ruby 中常量被修改只会发出警告，常量不应该在方法中定义，应该对你的程序全局有效，常量的命名方式 **MY_CONSTANTS**
2. 全局变量 Global Variable：避免使用！命名方式 **$global_var**
3. 类变量 Class Variable：类变量在类中任何方法之外声明，对类和实例都具有可访问性，可以通过类方法和实例方法改变其值。命名方式 **@@class_var**
4. 实例变量 Instance Variable：命名方式 **@instance_var**
5. 本地变量 Local Variable：最常用的，命名方式 **local_var**

### Mutate the Caller

在方法的作用域内，我们知道当我们传递进来一个变量后，在方法内的任何操作都不会对外部环境中的该变量有任何影响。但是有个例外：

```ruby
arr = [1, 2, 3]

def mutate_arr var_arr
  var_arr.pop
end

mutate_arr arr
```

我们把 arr 传递进 mutate_arr 方法后，按照以往的规则，arr 应该不会被修改，但现在 arr 变成了 [1, 2]，说明 pop 方法改变了他的调用者。

### if 语句

1. if 的单行语句格式：

   ```ruby
   if x == 3 then puts "x equals 3." end
   ```
   
   then 和 end 都不能缺少。
   
2. 或者是这样：

   ```ruby
   puts "x equals 3." if x == 3
   ```
   
3. 也可以这样：

   ```ruby
   puts "x is not equal to 3." unless x == 3
   ```
   
4. **elsif** 注意 else 缺了一个字母 **e**

### ==比较操作符

比较操作符的两端必须是同类型才有可能返回 true，否则不同型的两个值进行比较总是返回 false。

### 三元操作符（Ternary Operator）

```ruby
true ? "The true statement" : "The false statement"
false ? "The true statement" : "The false statement"
```

### case 语句

```ruby
a = 3

answer = case
when 3
  'a = 3'
when 4
  'a = 4'
else
  'I don\'t know a'
end

puts answer
```

case 后可以省略要比较的变量，但也有例外：

```ruby

def inbet num
  case num
  when 0..100
    puts "#{num} is in between 0 and 100."
  else
    puts "I don't know #{num}."
  end
end

```

### 循环语句

1. while loop

   ```ruby
   while (conditions)
   ...
   end
   ```
   
2. until loop

   ```ruby
   until (conditions)
   ...
   end
   ```
   
3. do while loop

   ```ruby
   loop do
     ...
     if (condition)
       break
     end
   end
   
   begin
     ...
   end while (condition)
   ```
   
### 递归函数

创造递归时，代码必须有一个 if 语句来判断在某个特定条件下，我们要离开递归，否则就会造成死循环。

最经典的案例就是 fibonacci 函数：

```ruby
def fib nth
  if nth < 2
    nth
  else
    nth = fib(nth - 1) + fib(nth - 2)
  end
end
```

### 数组 Array

1. array.last array.first
2. array.pop array.push array << 'something here'

   pop 和 push 都是属于会 mutate the caller 的方法。
   
3. map 方法返回的是一个新的处理后的 array，原 array 并没有被修改。
4. delete_at 方法是前提你知道该值的 index，该方法会改变 caller。
5. delete 方法直接删掉该值，重复的也会被删掉。
6. uniq 方法会将数组中重复的元素删除，该方法返回的是一个新的处理后的 array，原数组不会被改变，但是 uniq! 方法会改变 caller，需要注意的是并不是所有的方法都可以添加 **!** 来改变自己的行为。
7. select 方法会返回一个新的数组，并不会改变原数组，当传递进 block 的元素解读为 true 时，该元素才会被保留下来。
8. include? 方法返回一个值是否在 array 里。
9. flatten 方法将多维数组转换为一维，该方法不会改变 caller。
10. each_index 将索引传递进 block 里。
11. each\_with\_index 将值和索引传递进 block 里，顺序是先值后索引。
12. product 方法需要一个 array 作为参数，返回两个 array 的成绩，类似于笛卡尔积。
13. each 和 map 的区别：each 返回原数组，而 map 返回通过 block 修改后的新数组。

    ```ruby
    a = [1, 3, 5]
    a.map { |x| puts x }
    ```
    
    上例中会返回 [nil,nil,nil]，因为 puts 语句返回 nil。
    
### 哈西数组 Hash

1. 比较通俗易懂的写法

   ```ruby
   hash_var = {
     name: "peter",
     age: 23
   }
   
   hash_var[:address] = "USA"
   hash_var.delete(:name)
   hash_var.merge!(new_hash)
   ```
   
   merge 方法并不会改变原 Hash。
   
2. 当 Hash 作为方法的最后一个参数时，可以省略 **{}** 写法，这种习俗在 Rails 程序里经常可见。
3. 在 Hash 里并不是只有 symbol 才能担当 key 的角色，string、float、array、hash、integer 都可以成为 key。
4. has_key? 方法查找 Hash 里有无指定的 key。
5. select 方法返回符合条件的 key value 对。
6. fetch 方法返回指定的 key 对应的 value，如果 value 不存在，可以给 fetch 方法提供第二个参数指定当 key 对应的 value 不存在时返回的值，通常是条没找到的错误信息。
7. to_a 方法将 Hash 转换为 Array，key 和 value 被当作一个 Array 成为总的 Array 的一个元素。
8. keys 和 values 返回相应的 Array。
9. ruby 自 1.9 版本后，Hash 已经可以保存元素的顺序位置了。

### 值域

值域最常用的是给一个范围去取数组的值。也可以快速的创建数组。

```ruby
(0..9).to_a
=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

arr = %w[name age group]
=> ["name", "age", "group"]

arr[0..1]
=> ["name", "age"]
```

## 文件操作

### 1. 打开文件

文件的使用分三步：打开、使用、关闭。打开文件需要两个参数，1.文件名 2.打开模式

1. "r" 只读方式
2. "w" 只写方式 如果文件存在，覆盖
3. "w+" 可读可写 如果文件存在，覆盖
4. "a+" 可读可写 如果文件存在，则在文件末尾继续添加内容

### 2. 读文件

File.read("filename.txt") 将整个文件的内容读出来。

File.readlines("filename.txt") 将文件的内容以行为单位读出来并存放在数组中。

### 3. 为 open 函数提供 block，则可避免未关闭文件的错误

```ruby
File.open "filename.txt", "a+" do |file|
  file.puts "something in here!"
end
```

### 4. puts 和 write 的区别

puts 将在行的末尾添加换行符，而 write 不添加。

### 5. 删除文件

```ruby
File.new "newfile.txt", "a+"
File.delete "newfile.txt"
```

### 6. Dir and Pathname

pathname 的实例可以访问 File 和 Dir 的类方法。Dir 可以操作目录和其内容。

```ruby
require 'pathname'

pn = Pathname.new(".")
pn.entries.each { |file| puts "#{file} has extension .txt" if file.extname == ".txt" }
```

```ruby
d = Dir.new(".")

while file = d.read do
  puts "#{file} has extension .txt" if File.extname(file) == ".txt"
end
```

## Extras

### 正则表达式

1. `=~` 该操作符返回字符串中符合正则表达式的第一个字符出现的位置。

   ```ruby
   "john doe" =~ /j/ 
   ```
   
   返回字符 j 出现的位置0。
   
2. 除了 `=~` 使用它，还可以用 match 方法，match 方法返回一个 MatchData 如果有匹配的话，如果没有匹配，返回 Nil。

   ```ruby
   /b/.match "John Doe"
   ```
   
   上例中将返回 Nil。
   
### 变量和指针

我们的变量名其实就是指向内存空间的一个指针，我们给一个方法传递参数时，其实就是进行了类如：b = a 的赋值操作。

```ruby
a = "hi"
b = a
a << ", there"
```

a 和 b 指向的其实是内存中的同一个位置，如果最后一句变为 `a = ", there"`，则我们又为 a 指定了一个新的内存位置，a 和 b 就指向来不同的位置。	
### Block

block 作为函数参数时，必须放在最后一个。

```ruby
def takeblock number, &block
  &block.call
end
```

### Procs

proc 的作用是将 block 包裹起来，以便将来重用。proc 也可以作为函数的参数进行传递。

```ruby
talk = Proc.new do |name|
  puts "hello #{name}."
end

talk.call "John"
```

### Exception and Error Handling

程序遇到错误时，应该有解决问题的方法，而不是一股脑的将错误信息抛给用户中断程序。

```ruby
arr = [1,2,3,nil,4]

arr.each do |num|
  begin
    puts "#{num}"
  rescue
    puts "not right"
  end
end
```

rescue 语句也可以写在单行内：

```ruby
a = 0
a.each {|num| puts num} rescue puts "not right"
```
