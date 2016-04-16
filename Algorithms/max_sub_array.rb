#!/usr/bin/env ruby

# brute force
def max_sub_array(arr)
	max_sum = arr[0]
	length = arr.length

	for i in 0..(length-1)
		for j in i..(length-1)
			cur_sum = 0
			for k in i..j
				cur_sum += arr[k]
			end
			max_sum = cur_sum if cur_sum > max_sum
		end
	end

	max_sum
end

# brute force : the ruby way
def max_sub_array(arr)
	max_sum = arr[0]
	length = arr.length

	arr.each_index do |i|
		arr[i..(length-1)].each_index do |j|
			cur_sum = arr[i..(j+i)].inject(0) { |sum, x| sum + x }
			max_sum = cur_sum if cur_sum > max_sum
		end
	end

	max_sum
end

arr = [-1, 2, 3, -5, 9]
puts max_sub_array(arr)
