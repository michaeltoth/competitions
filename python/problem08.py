from operator import mul

def digit_product(input_file, digits):
     # Read in number from file:
     f = open(input_file,'r')
     number = f.read() 
     f.close()

     # Convert number to a list of integer digits:
     digit_list = [int(char) for char in str(number)]

     i = max = 0
     while i + digits <= len(digit_list):
         # use operator.mul along with reduce to compute product of list subset
         product = reduce(mul, digit_list[i:i+digits], 1) 
         if product > max:
              max = product
         i += 1
     print max
