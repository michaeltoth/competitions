# Function for finding the sum of all primes below n

import math

def sum_primes(num):
     # Instantiate a true/false array with first 2 elements false and remaining true.
     prime_bool = [False]*2 + [True]*(num-2)

     for i in xrange(2, int(math.floor(math.sqrt(num) + 1))):
          for j in xrange(i * 2, num, i):
               prime_bool[j] = False
               
     # Convert boolean list to prime list using enumerate to get indices:

     prime_sum = reduce(lambda x, y: x+y, [i for i, x in enumerate(prime_bool) if x == True])
     print prime_sum
