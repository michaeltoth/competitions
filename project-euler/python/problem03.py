def factorize(number):
    factors = []
    divisor = 2
	
    # Loops until the number we are working on is divided down to 1
    while number > 1:
        # Starting at divisor = 2, incrementally works on dividing the number
        while number % divisor == 0:
            factors.append(divisor)
            number /= divisor
        divisor += 1

    print factors
	


