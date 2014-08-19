def divides(number,highest):
     divisor = highest
     
     # increments backwards while divisors correctly divide the number 
     while number % divisor == 0:
          divisor -= 1
          
          # if we reach a value of 1, everything divides and return true
          if divisor == 1:
               return True

     # return false if we exit the while loop 
     return False      



def findSmallest(highestDivisor):
     current = 1 
     
     # Increments the number until divides returns true
     while not divides(current,highestDivisor):
          current += 1

     # returns when we exit the while loop
     print current 
           
