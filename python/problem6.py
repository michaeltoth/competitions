# Calculate the difference between the sum of squares and square of sums for numbers less than n

# Example for n = 2
# Sum of squares(2) = 1^2 + 2^2
# Square of sums(2) = (1 + 2) * (1 + 2) = 1^2 + 2^2 + (1*2)*2

# Example for n = 3
# Sum of squares(3) = 1^2 + 2^2 + 3^2
# Square of sums(3) = (1 + 2 + 3) * (1 + 2 + 3) = 1^2 + 2^2 + 3^2 + (1*2)*2 + (1*3)*2 + (2*3)*2
# Difference between these = (1*2)*2 + (1*3)*2 + (2*3)*2

# Example for n = 4
# Sum of squares(4) = 1^2 + 2^2 + 3^2 + 4^2
# Square of sums(4) = (1 + 2 + 3 + 4) * (1 + 2 + 3 + 4) = 1^2 + 2^2 + 3^2 + 4^2 + (1*2)*2 + (1*3)*2 + (2*3)*2 + (1*4)*2 + (2*4)*2 + (3*4)*2
# Difference between these = (1*2)*2 + (1*3)*2 + (2*3)*2 + (1*4)*2 + (2*4)*2 + (3*4)*2

# We can observe from the above that for each successive n, the additive difference on top of n-1 is 2*((1*n) + (2*n) + ... + ((n-1)*n))
# This simplifies for a given n to 2*n*sum(1:n-1), which in turn simplifies to (n^2)*(n-1) = n^3 - n^2 because sum(1:n-1) = n*(n-1)/2

# Implementing both this and the naive solution to check timing differences:

def difference(number):
    my_diff = sum((i**2) * (i-1) for i in range(number + 1))
    print my_diff

def naive(number):
    my_diff = 0
    sum_of_sq = 0
    sq_of_sum = 0

    sum_of_sq = sum(i**2 for i in range(number + 1))
    sq_of_sum = (sum(i for i in range(number + 1)))**2
    my_diff = sq_of_sum - sum_of_sq 
    print my_diff

# Results: it turns out that the naive implementation is faster than my difference formula, slightly. This seems to be due to having 3 operations 
# (**, *, -) in the loop while each of the naive loops has only 1 operation.  This is somewhat frustrating as I thought my solution would be more 
# Efficient.

# The most efficient solution uses the fact that formulas for both the sum of numbers 1-n and the sum of squares 1-n both exist:
# sum(1:n) =          (n)*(n+1) / 2
# sum(squares(1:n)) = (n)*(n+1)*(2*n+1) / 6

# This program therefore does not loop and is only limited by the size of integer types and runs in constant time O(1)

def efficient(n):
    sum_of_sq = (n)*(n+1)*(2*n+1) / 6 
    sq_of_sum = ((n)*(n+1) / 2)**2
    my_diff = sq_of_sum - sum_of_sq
    print my_diff

