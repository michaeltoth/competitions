def collatz(num):
	# Function to find the number with the maximum collatz sequence below the value num
	collatz_array=[0,1]
	for i in range(2,num + 1):
		length = 0

		# Quit once we already know the length of i and add this length
		while i >= len(collatz_array):
			if i % 2 == 0: i /= 2
			else: i = i*3 + 1
			length += 1
		length += collatz_array[i]
		collatz_array.append(length)
	
	# Printing the index of the maximal value
	m = max(collatz_array)
	print [i for i, j in enumerate(collatz_array) if j == m]
