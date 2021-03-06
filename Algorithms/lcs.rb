#!/usr/bin/env ruby
# 
# 解决思路：
#
# c[i,j] 表示的是字符串前 i 个字符 与 字符串前 j 个字符的最长公共子序列的长度
# i, j 可以为 0
# 所以我们比较两个字符串的当前字符
# 1. 相等   c[i,j] = c[i-1,j-1] + 1
# 2. 不相等 c[i,j] = max(c[i,j-1], c[i-1,j])
# 同时记录下方向数组
# 最后遍历方向数组，讲来源方向为左上的元素打印出来

def lcs(string1, string2)
	m = string1.length
	n = string2.length

	c = Hash.new
	b = Hash.new
	[0].product((0..n).to_a).each do |index|
		c[index] = 0
	end
	(0..m).to_a.product([0]).each do |index|
		c[index] = 0
	end

	(1..m).each do |i|
		(1..n).each do |j|
			if string1[i-1] == string2[j-1]
				c[[i,j]] = c[[i-1,j-1]] + 1
				b[[i,j]] = "left_top"
			elsif c[[i,j-1]] > c[[i-1,j]]
				c[[i,j]] = c[[i,j-1]]
				b[[i,j]] = "left"
			else
				c[[i,j]] = c[[i-1,j]]
				b[[i,j]] = "top"
			end
		end
	end
	print_lcs(b, string1, m, n)
end

def print_lcs(b, str, i, j)
	if i == 0 || j == 0
		return
	end
	# 当年被卡在这里，你造吗，你眼神有问题啊 == 不是 = 啊
	if b[[i,j]] == "left_top"
		print_lcs(b, str, i-1, j-1)
		print(str[i-1])
	elsif b[[i,j]] == "top"
		print_lcs(b, str, i-1, j)
	else
		print_lcs(b, str, i, j-1)
	end
end

lcs("abcbdab", "bdcaba")
