def sum_numbers(input_file):
	my_sum = 0
	for line in open(input_file):
		my_sum += int(line)
	print str(my_sum)[0:10]

