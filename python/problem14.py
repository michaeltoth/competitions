def collatz(num):
	count = 1
	while num > 1:
		if num % 2 == 0:
			num /= 2
		else:
			num = num*3 + 1
		count += 1
	return count


def longest_collatz(num):
	print max((i for i in range(num)), key = lambda x: collatz(x)) 
