#!/usr/bin/env ruby

def brute_force_search(origin, pattern)
	i = 0
	j = 0

	size = origin.length
	p_size = pattern.length

	while i < size && j < p_size do
		if origin[i+j] == pattern[j]
			j += 1
		elsif
			i += 1
			j = 0
		end
	end

	if j >= p_size
		return i
	end

	return -1
end

str = "aefg"
pattern = "fg"

puts brute_force_search(str, pattern)
