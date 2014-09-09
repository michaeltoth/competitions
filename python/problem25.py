def digits(n):
    return len([char for char in str(n)])

def get_fibonacci_n_digits(num_digits):
    lastnum = 0
    fib_num = 1
    lastnum = 1
    count = 2 	# Starting with 2 fibonacci numbers

    while digits(fib_num) < num_digits:
        # Create temp variable for iteration
        temp = lastnum
        lastnum = fib_num
        fib_num += temp
        count += 1

    print count, fib_num

