#!/usr/bin/env ruby
#
# dp[[i,j]] 表示 string1 前 i 个字符与 string2 前 j 个字符的最小编辑距离
# i, j 可以为 0 ，表示 string1 或者 string2 为空串
#
# 解决思路：
# 我们先验性的假设两个字符串有一种对应的关系
# 使得两个字符串在这种对应关系下编辑距离最短
# 然后我们只看两个字符串的最后一个字符
# 它只可能是三种对应关系中的一种
#
# 1. 空格 -> 字符 插入字符 dp[i,j] = dp[i,j-1] + 1
# 2. 字符 -> 空格 删除字符 dp[i,j] = dp[i-1,j] + 1
# 3. 字符 -> 字符 变换字符 dp[i,j] = dp[i-1,j-1] + (A[i] == B[j] ? 0 : 1)
#
# A B C E 
# A   C D F
#
# 当 A[i] 与 B[j] 不相等时，我们才会执行 +1 操作
# 但是 +1 的操作我们是不知道来源于那种情况的
# 但是我们先验性的假设有一种最好情况
# 所以我们取三者中最小的那个
def edit_distance(string1, string2)
	str1_length = string1.length
	str2_length = string2.length

	dp = Hash.new
	[0].product((1..str2_length).to_a).each do |index|
		dp[index] = 0
	end
	(1..str1_length).to_a.product([0]).each do |index|
		dp[index] = 0
	end
	dp[[0,0]] = 0

	(1..str1_length).each do |i|
		(1..str2_length).each do |j|
			if string1[i-1] == string2[j-1]
				dp[[i,j]] = dp[[i-1,j-1]]
			else
				dp[[i,j]] = 1 + min(dp[[i-1,j-1]], dp[[i,j-1]], dp[[i-1,j]])
			end
		end
	end

	dp[[str1_length,str2_length]]
end

def min(a, b, c)
	a < b ? ( a < c ? a : c) : ( b < c ? b : c)
end

puts edit_distance("abce", "acdf")
