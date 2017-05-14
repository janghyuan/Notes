# 如何在你的 MAC 上设置 Rails 开发环境

## 1.Xcode 相关环境设置

确定安装好了 Command Line Tools，`xcode-select --install`，即使你已经安装好了 Xcode.app。初次安装完毕后，打开 Xcode.app 会弹出 License 的相关信息，同意即可，也可在命令行执行 `xcodebuild -license`。

## 2.The Missing Package Manager on MacOS

我们需要用 brew 安装 ruby 的版本管理工具 rbenv，除此之外 brew 提供了 GNU 的各种命令行工具。

`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"` 

`brew update` and `brew doctor`

## 3.安装设置 rbenv

`brew install rbenv ruby-build` 在这里安装 ruby-build 的目的是为之后用 rbenv 安装编译 ruby 时做好准备。

`if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi` 将其添加到你的 .zshrc 文件中，初始化 rbenv 使其能够正常工作

## 4.使用 rbenv 安装 ruby

`rbenv install 2.2.1` | `rbenv global 2.2.1` | `rbenv rehash`

机器默认安装有一个比较老旧的 ruby 版本，我们用 rbenv 安装的 ruby 覆盖掉系统默认的版本，任何通过 rbenv 或是 gem 安装的可执行脚本后，都要执行 rehash，将其添加到 rbenv 的 shims 目录进行全局覆盖。

## 5.安装一些有趣的工具

`brew install wget curl imagemagick` (可选)

## 6.安装 rails

为了避免恼人的 gem document 刷屏，可以在 .gemrc 文件中加入 `gem: --no-document`

`gem install bundler rails`

## 7.记得上面提到的，rehash 一下吧

`rbenv rehash` 

---

Enjoy The Rails Way! Let's roll!