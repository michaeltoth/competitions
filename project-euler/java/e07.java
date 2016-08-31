public class PrimeGenerator {
  
	// This program computes the nth prime (in this case, 10001st)
	
	public static void main(String[] args){
		int n = primes(10001);
		System.out.println ("The 10001st Prime Number is: " + n);
	}
	
	//Add new primes to the prime array
	public static int primes(int n){
		int[] primeArray = new int[n];
		primeArray[0] = 2;
		int j = 1;
		outerloop:
		for(int i=3;i<1000000;i++){
			if (noDivides(primeArray, i)) {
				primeArray[j] = i;
				j++;
			}
			else if (primeArray[n - 1] != 0) {
				break outerloop;
			}
		}
		return primeArray[n - 1];
	}
	
	//If the prime array does not divide the number, it is prime
	public static boolean noDivides(int[] primeList, int number){
		outerloop:
		for(int prime : primeList) {
			if(prime == 0) {
				break outerloop;
			}
			else if (number % prime == 0) {
				return false;
			}
		}
		return true;
	}
		
}
