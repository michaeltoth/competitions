def isPalindrome(num):
	return True if str(num) == str(num)[::-1] else False
	
largest = 0
# Uses a double for loop over three digit numbers
for i in range(100,1000):
	for j in range(100,1000):
		# If i * j is not larger, will not execute isPalindrome
		if i * j > largest and isPalindrome(i*j):
			largest = i * j

print largest