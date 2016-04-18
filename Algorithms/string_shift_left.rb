#!/usr/bin/env ruby
#
# 字符串循环左移
#
# 要求：空间复杂度O(1), 时间复杂度O(n)
# 公式：(A'B')' == BA
#
# 因为字符串的翻转操作是 空间是O(1) ，时间是O(n) 

def shift_left(string, n)
	n %= string.length
	(string[0..(n-1)].reverse + string[n..(string.length-1)].reverse).reverse
end

puts shift_left("abcdef", 8) #=>cdefab
