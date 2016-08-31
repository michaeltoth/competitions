from math import sqrt

def get_num_divisors(num):
    divisors = []
    for i in range(1, int(sqrt(num)) + 1):
        if num % i == 0:
            divisors.append(i)
            if num / i is not i:
                divisors.append(num/i)
    return len(divisors)

def smallest_triangle(required_divisors):
    triangle = 1
    loop = 1
    while (get_num_divisors(triangle) < required_divisors):
        loop += 1
        triangle += loop
    print triangle
	
