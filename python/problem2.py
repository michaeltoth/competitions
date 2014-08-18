# Initialize sum at 0, num and lastnum at 1
sum = 0
num = 1
lastnum = 1

while num < 4000000:
	# Iterate sum if number is divisible by 2
	if num % 2 == 0:
		sum += num
		
	# Create temp variable for iteration
	temp = lastnum
	lastnum = num
	num = num + temp

print sum
