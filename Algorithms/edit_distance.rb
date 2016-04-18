#!/usr/bin/env ruby
#
# dp[[i,j]] 表示 string1 前 i 个字符与 string2 前 j 个字符的最小编辑距离
# i, j 可以为 0 ，表示 string1 或者 string2 为空串
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

puts edit_distance("abc", "abde")
