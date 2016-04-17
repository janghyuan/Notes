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

# divide and conquer
def max_sub_array(arr, from, to)
	if from == to
		return arr[from]
	end

	middle = (from + to) / 2
	m1 = max_sub_array(arr, from, middle)
	m2 = max_sub_array(arr, middle + 1, to)

	left = arr[middle]
	now = arr[middle]
	arr[from..(middle-1)].reverse_each do |val|
		now += val
		left = now if now > left
	end

	right = arr[middle + 1]
	now = arr[middle + 1]
	arr[(middle+2)..to].each do |val|
		now += val
		right = now if now > right
	end

	m1 > m2 ? ( m1 > m3 ? m1 : m3) : ( m2 > m3 ? m2 : m3)
end

arr = [-1, 2, 3, -5, 9]
puts max_sub_array(arr)
