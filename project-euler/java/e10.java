public class Sum {
  
	// This program computes the sum of all primes below n
	
	static int max = 2000000;
	
	//Add new primes to the prime array
	public static long primes(int n){
		int[] primeArray = new int[n];
		primeArray[0] = 2;
		int i = 3; //Next number to check for prime
		int j = 1; // Index of next prime in prime array
		while(i<n-1){
			if (noDivides(primeArray, i)) {
				primeArray[j] = i;
				j++;
			} i++; //Increment the number we're checking each time
		}
		long sum = 0;
		for(int primes : primeArray){
			sum += primes;
		}
		return sum;
	}
	
	//If the prime array does not divide the number, it is prime
	public static boolean noDivides(int[] primeList, int number){
		for(int prime=2;prime<Math.sqrt(number)+1;prime++) {
			if (number % prime == 0) {
				return false;
			}
		}
		return true;
		
	}
	
	public static void main(String[] args){
		long primesum = primes(max);
		System.out.println(primesum);
	}
}
