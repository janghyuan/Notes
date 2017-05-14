# Ruby 面向对象编程

## Module

Everything is an Object. 在创建一个类时，我们需要一个通用方法，这个方法也会在其他类中使用，这时我们就可以使用 Module。Module 提供了一些行为方法，当我们在类定义中需要此方法时，就要把该 Module Mix in 到当前类定义中，这就要用到保留字 include 将 Module 插入到当前类定义中，从而实现代码的复用。

```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky = GoodDog.new
sparky.speak("Arf!")        # => Arf!
bob = HumanBeing.new
bob.speak("Hello!")         # => Hello!
```

## Getter and Setter

在 Ruby 的类中，如果我们要访问实例变量，就必须在该类中定义实例变量的 getter 和 setter 方法。通常我们会有很多个实例变量，就会造成我们的类代码变的很冗余。解决办法就是使用 Ruby 的内建函数 attr_* 帮我们自动建立这些方法。

```ruby
class GoodDog
  attr_accessor :name
  
  def initialize name
    @name = name
  end
  
  def sparky
    puts "#{@name} sparks."
  end
end
```

上面的代码中，`attr_accessor :name` 其实是为我们创建的了实例变量 name 的 getter 方法`name` 和 setter 方法`name=`，所以在 sparky 函数中，我们就可以将 `#{@name}` 替换成 name 的方法调用 `#{name}`。

## Self

在类定义中使用实例方法，就要在实例方法前加上 `self.` 前缀，例如在上例中就可以改成 `#{self.name}`。但是如果是 setter 方法的调用，就必须加上前缀，否则就会被理解为定义了本地变量而不会真正的去调用实例函数。

**self 使用总结：**

1. 在 instance method 里就是指代的 instance。
2. 在 class 内，instance method 外就是指代的 class 本身。 

## Class Methods

类的实例都是有状态区别的，当一些方法不涉及到实例状态改变的时候，就可以声明为类方法。

```ruby
class MyClass
  def self.spark
    ...
  end
  ...
end
```
调用 Class Methods ：`MyClass.spark`

## Class Variables

类变量的声明：`@@class_variable`，同时，我们还要有取得类变量值的方法：

```ruby
class MyClass
  @@num_of_objects
  
  def initialize
    @@num_of_objects += 1
  end
  
  def total_number_of_objects
    @@num_of_objects
  end
  ...
end
```

可以在实例方法中改变类变量的值。`initialize` 就是实例方法。

## to_s method

每个类都有 to_s 方法，他是 ruby 内建的方法，当我们没有在类中指定时，`puts some_object` 将会返回 `# => #<SomeClass:0x007fe542323320>`，这对我们的检视没有太大帮助，通常我们会自己在类定义中指定自己的 `to_s` 方法。

在 String Interpolation 中，我们插入的变量也会自动调用 `to_s` 方法，毕竟我们插入的东西是各种类型的值都会有的。

puts 后加实例参数，会自动调用实例参数的 `to_s` 方法。如果改用 p ，则会调用实例的 `inspect` 方法，该方法对检视对象来说非常有用，通常我们不会在类定义里重写该方法。

## 继承 Inheritance

### super

super 是内建的函数，当在实例方法中调用时，super 会调用其父类同名方法。

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak        => "Hello! from GoodDog class"
```

### super in initialize method

如果把 super 的调用放到了 initialize 方法里，则子类的初始化方法会调用父类的初始化方法。

```ruby
class Animal
  attr_accessor :name
  def initialize name
    self.name = name
  end
end

class GoodDog
  attr_accessor :color
  def initialize color
    super
    self.color = color
  end
end

dog = GoodDog.new('brown')
```

如果不给 super 提供参数，则 super 会将 color 的值付给 name，得到的 dog 会有 @name ＝ brown 这个属性。所以要显示的提供给 super 参数。

```ruby
class BadDog
  attr_accessor :color
  def initialzie name, color
    super name
    self.color = color
  end
end
```

## 关于 module 的一点说明

DRY 原则在上述 class 的继承中已经讨论过了。现在考虑一种新的情况：

![class inheritance](http://d2aw5xe2jldque.cloudfront.net/books/ruby/images/animal_hierarchy.jpg)

我们给 Fish 类写一个 swim 方法，但有些 Mammal 也是可以 swim 的，但并不是所有的 Mammal 都可以 swim，所以我们就将 swim 方法提取出来 放到一个 Swimmable 的 Module 里，在需要 swim 的类里就可以将他 mix in（就是 include 进来）。

## 什么时候用 继承 还是 模组？

1. 子类只能继承自一个父类，而你可以在一个类中 mix in 多个模组。
2. “is a” 用继承，“has a” 用模组。例如：狗 是一个 动物。狗 有一个 游泳的能力。
3. 模组不能实例化对象，模组的两个功能
   - 起到命名空间的作用
   - 组织通用的方法DRY

## method lookup path

当我们调用实例中的一个方法时，ruby 会在一个查找链中查找出这个方法再执行他。我们可以通过执行类方法 `ancestors` 来查看该类的查找链。**Ex**: `Animal.ancestors`

当我们的类定义中有 Module 时，最后被引进的 Module 最先被查找，父类中引进的 Module 也在其查找链中。

```ruby
module Swimmable
  def swim
    puts "I can swim."
  end
end

module Walkable
  def walk
    puts "I can walk."
  end
end

module Jumpable
  def jump
    puts "I can jump."
  end
end

class Animal
  include Walkable
end

class Dog < Animal
  include Swimmable
  include Jumpable
end
```

Dog 的查找链为：`[Dog, Jumpable, Swimmable, Animal, Walkable, Object, Kernel, BasicObject]`

## 细谈 Module 两个作用

1. 命名空间：组织功能接近的 Class，将他们放到一个命名空间内，可以做到不同命名空间内的同名类

   ```ruby
   module Mammal
     class Dog
     end
     
     class Cat
     end
   end
   
   dog = Mammal::Dog.new
   cat = Mammal::Cat.new
   ```
   
   调用命名空间内的类时，就要用到 `::`。
   
2. 组织方法：模组方法的定义与调用

   ```ruby
   module Mammal
     def self.speak name
       puts "I am #{name}."
     end
   end
   
   Mammal.speak "John"
   Mammal::speak "Doe"
   ```
   
   在这里 self 就指代的是本模组，调用时更倾向于使用 `.`。
   
## public private protected

1. private method 只能在类中被调用，而且不能通过 self 调用。
2. protected method 只能在类中被调用，可以通过 self 调用。他对外表现为 private，对内则表现为 public。被继承后，也同样遵守这个规则。
