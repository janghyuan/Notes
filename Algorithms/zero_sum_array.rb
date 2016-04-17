#!/usr/bin/env ruby
# 
# 该算法只能求出最接近 0 的绝对值
# 该子数组和正负未知

def zero(arr)
	sum_of = []
	sum_of << arr[0]
	arr.each_with_index do |val, inx|
		next if inx == 0
		sum_of << sum_of[inx - 1] + val
	end
	sum_of.sort!

	min1 = sum_of[1] - sum_of[0]
	sum_of.each_with_index do |val, inx|
		next if inx == 0 || inx == 1
		now_min = val - sum_of[inx-1]
		min1 = now_min if now_min < min1
	end

	min2 = sum_of.map(&:abs).min

	min1 > min2 ? min2 : min1
end

arr = [ -1, -3, -2, -4 ]
puts zero(arr)
