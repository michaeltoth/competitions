import java.util.ArrayList;

public class Amicable {
  
	//This program calculates the sum of all amicable pairs below a given number n
	
	public ArrayList<Integer> amicables = new ArrayList<Integer>();
	
	public static int findDivisorSum(int number){
		int divisorSum = 1; // 1 is always a proper divisor
		//Note that we do not add n because it is not a PROPER divisor
		for(int i=2;i<=Math.sqrt(number);i++){
			if((number%i==0)&&(number/i) == i) {//The number is a square root
				divisorSum += i;
			}
			else if(number%i==0){ //Add the divisor i and the divisor number/i
				divisorSum += i;
				divisorSum += number/i;
			}
		}
		return divisorSum;
}
	
	public int findAmicables(int max){
		int total = 0;
		
		for(int i=1;i<=max;i++){
			// Definition of amicable numbers: let d(n) be the sum of the proper divisors of n
			// If d(a) = b and d(b) = a, these are amicable numbers
			int sum = findDivisorSum(i);
			if((i == findDivisorSum(sum))&&!(sum == i)) { // The numbers are amicable (also checks that the "amicable" numbers are not the same number
				if(!amicables.contains(i)){
					amicables.add(i);
				}
				if(!amicables.contains(sum)){
					amicables.add(sum);
				}
			}
		}
		
		for(int number : amicables){
			total += number;
		}
		return total;
	}
	
	public static void main(String[] args){
		long start = System.currentTimeMillis();
		Amicable run = new Amicable();
		int total = run.findAmicables(10000);
		System.out.println(total);
		long end = System.currentTimeMillis();
		System.out.println("Execution time was " + (end-start) + "ms.");
	}
	
}
