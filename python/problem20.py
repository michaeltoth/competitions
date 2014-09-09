from math import factorial

def factorial_sum(n):
	print sum(int(char) for char in str(factorial(n)))
