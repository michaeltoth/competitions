"""
Function for finding the nth prime value
Will make use of the sieve of eratosthenes along with the prime number theorem for an upper bound on prime(n) for the sieve computation 
"""

import math


def nth_prime(num):
     
     # Call to separate function if number is less than 6 due to upper bound formula working only when n > 6
     if (num <= 6):
          print nth_prime_small(num)
          return nth_prime_small(num)


     # Prime number theorem on upper bound (only works for n > 6, otherwise use different function below) 
     bound = int(math.floor(num * (math.log(num) + math.log(math.log(num)))))
     
     # Used for outer loop, only need to go to sqrt of upper bound 
     sqrt_bound = int(math.floor(math.sqrt(bound + 1) + 1))
    
     # Instantiate a true/false array with first 2 elements false and remaining true. 
     prime_bool = [False]*2 + [True]*(bound-1)
     
     # Loop over range from 2 to bound + 1 (array indexing at 0)
     for i in xrange(2, sqrt_bound):
          # Turn all multiples of i to false: 
          for j in xrange(i * 2, bound+1, i):
              prime_bool[j] = False 

     # Convert boolean list to prime list using enumerate to get indices:
     prime_list = [i for i, x in enumerate(prime_bool) if x == True] 
     print prime_list[num - 1]

     





# Simple function to output primes for numbers 6 and smaller 
def nth_prime_small(num):
     if num == 1:
          return 2   #2 is the first prime
     elif num == 2:
          return 3
     elif num == 3:
          return 5
     elif num == 4:
          return 7
     elif num == 5:
          return 11
     elif num == 6:
          return 13 





