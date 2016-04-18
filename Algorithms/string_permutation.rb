#!/usr/bin/env ruby
#
# 递归法求解全排列问题
#
# "abcd"
#
# 解决思路是我们遍历每个字符
# 当前字符和首字符交换位置
# 然后递归调用交换完毕后的字符串
#
# 如何保证不遗漏
#
# 在递归调用返回后，然后归位原来交换的元素
# 俗话说收拾犯罪现场
#
def permutation(string, from , to)
	if from == to
		puts string
	end

	(from..to).each do |head|
		temp = string[from]
		string[from] = string[head]
		string[head] = temp

		permutation(string, from + 1, to)

		temp = string[from]
		string[from] = string[head]
		string[head] = temp
	end
end

permutation("abcd", 0, 3)
