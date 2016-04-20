#!/usr/bin/env ruby
#
# 通过非递归的方式查找比当前字符串大的那个最小的字符串模式
#
# 例如：
# 当前字符串为 1 2 4 3
# 它的下一个为 1 3 2 4
#
# 解决思路：
# 1. 找到第一个升序字符
#	2. 升序字符之后的所有字符中最小的字符与升序字符交换
#	3. 将升序字符之后的所有字符反转

def next_permutation(str)
	len = str.length
	p_start = 0
	p_end = len - 1

	if p_start == p_end 
		return str.reverse
	end
	p_cur = p_end

	# p_cur 是不能指向 第一个字符的
	# p_cur 左边已经没有字符了亲╭(╯3╰)╮
	while p_cur != 0 do
		p_before = p_cur - 1
		if str[p_before] < str[p_cur]
			p_find = p_end
			while str[p_find] < str[p_before] do 
				p_find -= 1
			end

			temp = str[p_before]
			str[p_before] = str[p_find]
			str[p_find] = temp

			return str[p_start..p_before] + str[p_cur..p_end].reverse
		end
		p_cur -= 1
	end
	return str.reverse
end

puts next_permutation("1234")
