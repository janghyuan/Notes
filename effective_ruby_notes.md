## 1. 理解 Ruby 中的 True

一条超级简单的规则：**在 Ruby 中，除了 false 和 nil，其他值都是真值**

- 所以数字 0 在 Ruby 中就是真值。

- 在其他语言中，true 和 false 被假设为关键字，而在 Ruby 中却不是。事实上 true 和 false 被描述为不遵循**命名**（全局变量以 $ 开头）和**赋值规范**（变量是可以放在赋值语句的左半边的）的全局变量。

- true 和 false 本质上就是对象（TrueClass 和 FalseClass 的实例），所以可以像通常意义下的对象一样调用对象的方法。

- true 对象的存在只是为了方便而已。因为 false 和 nil 是唯二的假值。

- 如何区分 false 和 nil。在表示配置信息的对象中，false 代表被禁用，nil 代表该选项没有被显示定义，因而使用默认值。具体实践就是调用 nil? 方法。

- 在一般性的编程语言中，我们习惯性的为了避免将 == 写成 = 的错误，我们将不变量写在 == 的左边，而不变量是不能被执行赋值操作的，所以如果我们将 == 写成了 =，编译器就是报错。这是语言上的形式化规则。在 Ruby 中，false 本质是一个对象，我们将 false 写在 == 的左边，实际上实在调用 false 对象的 == 方法（该方法继承自 Object 类）。所以将 false 写在左边，我们就可以很放心的知道如果 == 右边的对象也是 false，那么结果就是 true。将 false 放在 == 的右边，则可能左边要比较的对象重写了 == 方法（覆盖了 Object#==），那么将会产生不预期的结果。

## 2. 所有对象的值都可能为 nil

还记得你的 Rails 程序最常见的那种错误吗！`undefined method 'xxx' for nil:NilClass (NoMethoderror)` 

在 Ruby 中，为一个函数传递参数时，我们不会去进行参数类型检查，如果传递进来了一个对象参数，我们不会考虑他是什么类型（is_a）的对象，我们只考虑这个对象能不能做我们要求他做的事情（respond_to?）。

所以，在这个过程中，我们很可能传递进来一个 nil 对象，导致程序出错。所以在该对象上调用方法前，可以加一层判断（nil?）。只有 nil? 方法返回 false 时，我们才再该对象上进行方法调用。

```ruby
person.save if person
person.save if !person.nil?
perosn.save unless person.nil?
```

或者，我们也可以在调用方法前，将对象的类型转换为我们需要的那种类型。例如，我们期望函数的一个参数是字符串类型，在在传递进来的参数上执行方法之前，可以将该参数转换成字符串类型后，再进行方法调用。

```ruby
def fix_title(title)
  title.to_s.capitalize
end
```

Array#compact 返回去掉所有 nil 元素的方法接受者的副本。

## 3. 避免使用 Ruby 中古怪的 Perl 风格语法

1. 避免使用 String#=~ 方法，替换为 String#match 方法
    
    =~ 方法会将第一个匹配到的组放到「全局变量」$1 中，然而，它不是一个正常意义上的全局变量，他的作用域仅限于当前进程的当前方法。

2. 使用描述性的别名， $LOAD_PATH，避免使用 $:

    使用这些描述性别名时，如果找不到就要导入 `require 'English'`

3. 避免使用隐式的全局读写变量 $_

    ```ruby
    # readline 将读取到的行文本存储在 $_
    # ~ 将 $_ 存储的文本与正则表达式进行匹配
    # print 没有参数时会将 $_ 存储的内容打印出来
    while readline
      print if ~ /^ERROR:/
    end
    ```

## 4. 留神，常量是可变的

- 避免常量被重新赋值：冻结定义他的那个模块
- 如果常量引用了字符组数组，则不仅要冻结数组本身，还要冻结数组的每个元素
  
  ```ruby
  ARR = ["hello", "world"].map!(&:freeze).freeze
  ```

即使冻结了常量引用的对象，常量也是可以重新被赋值的，只会收到一条警告。如果冻结的对象是字符串数组，还要保证冻结数组的每一个元素。

## 5. 留意运行时警告

虽然 Ruby 是动态语言，没有所谓的编译时。但是当你的代码交给 Ruby 解释器时也要做一些编译。所以我们可以考虑 Ruby 的编译阶段和运行阶段，从而我们可以得到两种类型的错误。可以简单理解为，编译错误可以告诉你语法错误，而运行错误可以告诉你程序中可能潜藏的错误。

**开启编译时警告：**

在运行 Ruby 解释器时使用命令行选项 `-w`，或者通过设置环境变量 RUBYOPT 为 `-w`

**开启运行时警告：**

通过在程序中设置全局变量 $VERBOSE 为 true，false 会减少显示的信息，nil 则是禁用。

## 6. 了解 Ruby 如何构建继承体系

`receiver.method_name` 当我们在一个对象上调用一个方法时，首先我们会在该对象所属的类上找，如果找不到，进一步再在该对象的超类中寻找，一直到 BasicObject 类，如果到头了还没有找到，那就从头开始再次寻找一个叫 `method_missing` 的方法抛出一个错误。

但是我们可以在一个类中 include 一个模块，来增加一些新的查找节点。

```ruby
module ThingsWithName
  def name
  ...
  end
end

class Person
  include ThingsWithName
end

class Customer < Person
  ...
end
```

实质上，我们创建了一个单例类，将 module 包含的方法放到了这个单例类中，并且将这个单例类插入到了 customer 对象的继承体系中。

如果我们实例化了一个对象 `customer = Customer.new` ，然后我们这样定一个方法：

```ruby
def customer.name
  ...
end
```

实质上也是我们创建了一个单例类，将该方法放入其中，并将这个单例类放到了该对象的继承体系中。（在该对象所属的类之前）

其实，这也解释了类方法到底在哪里的问题。当我们把类看作成一个对象时，类方法其实都放在了一个单例类中。（在该类所属的 Class 类之前）

## 7. 了解 super 的不同行为

假设我们想重载父类中的一个方法，但是我们又不想从 0 编写代码，新方法的功能用到了老方法 90% 的功能，我们可以在子类中定义一个同名方法，在该方法中调用 super（本质上是一个关键字） 来调用老方法。

如何给 super 传递参数：

1. 不加任何参数、不加括号
  会将宿主的所有参数包括 block 一并传递给目标方法。如果宿主方法中，在调用 super 前改变了参数的值，则传递给 super 的参数是改变后的。
2. 只传递给 super 目标方法所需要的参数（super 变成了普通的方法调用）
3. 只传递一个空括号
  则代表不传递任何参数

如果父类中没有相应的同名方法，则会引发 method_missing 方法。默认的原始的 method_missing 方法会提供一些额外的关于 由于调用 super 而引发此错误的信息。如果在继承链中又定义了自己的 method_missing 方法，则会丢失掉这部分信息。

## 8. 初始化子类时调用 super

接着上一条来说，如果我们在新建一个对象时，想做一些初始化操作，我们可以定义 initialize 方法，但是该方法只会在子类中被调用，父类中的 initialize 不会被调用。

所以，我们可以在初始化子类时，在子类的 initialize 方法中调用 super（并传递相应的初始化参数）来调用父类的初始化方法。

clone 和 dup => initialize_copy

## 9. 提防 Ruby 最棘手的解析

该问题在 Rails 里很早就遇到过了，就是 setter 和 getter 的调用问题。

调用 setter 时，必须有明确的接收者，而 getter 则不用。

```ruby
class Person
  attr_accessor :name
  
  def initialize name
    # setter method
    self.name = name
  end
  
  def what_is_my_name
    # getter method
    name
  end
end
```


## 10. 推荐使用 Struct 而非 Hash 存储结构化数据

Struct.new 生成的是一个新的小型的类。方便我们定义新的数据结构类型，而不用总是用 Hash 来模拟。

```ruby
Person = Struct.new(:name, :age, :house) do
  # 定义实例方法
  def greeting
    puts 'hello'
  end
  
  # 定义类方法
  def self.species
    return "mammal"
  end
end
```
