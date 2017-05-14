# Git 工作流程

## 1.建立主题分支 topic-branch

`$ git checkout -b topic-branch` 该命令建立 topic-branch 后，自动切换到该主题分支。

## 2.在主题分支下编辑文件

添加新的激进的小功能，或是会对原有代码造成兼容性破坏的代码。

## 3.提交改动

`$ git commit -am 'some editing'`

## 4.合并改动

`$ git checkout master`

`$ git merge topic-branch`

`$ git branch -d topic-branch`

**注意：**

如果不想合并主题分支的改动，直接放弃主题分支，`git branch -d` 是无法删除没有合并的主题分支的。应该替换为 `git branch -D`