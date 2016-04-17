#!/usr/bin/env ruby
# 
# 求旋转数组的最小值
# 该数组最开始是有序无重复数字的
# 然后数组的元素按照某一个位置旋转
# 
# 输入: [3,4,5,0,1,2]
# 输出: 0

def min(arr)
	low = 0
	high = arr.length - 1

	while low < high do
		middle = (low + high) / 2
		# arr[middle] 只能与 arr[high] 进行比较
		# 相应的对偶的情况 arr[middle] 与 arr[low] 比较会出错
		if arr[middle] < arr[high]
			high = middle
		elsif arr[middle] > arr[high]
			low = middle + 1
		end
	end

	arr[low]
end

arr = [3,4,5,0,1]
puts min(arr)
