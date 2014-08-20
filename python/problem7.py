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
     numlist = range(2, bound)
    

     for i in range(len(numlist)):
         for j in range(i+1,len(numlist)):
              # Remove elements from list that are divisible by previous elements:  
              if numlist[j] % numlist[i] == 0:
     

     print numlist 




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





