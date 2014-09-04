def power_digit_sum(num,pow):
	big_num = num**pow
	print sum([int(char) for char in str(big_num)])
