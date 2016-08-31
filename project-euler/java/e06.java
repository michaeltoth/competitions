
public class SUMvsSQ {

  // This program computes the difference between the sum of squares and
	// the square of sums of the first one hundred integers
	
	public static void main(String[] args){
		System.out.println(SumVsSquares(100));
	}
	
	public static long SumVsSquares(int n){
		//Note that this is the formula for the sum of digits 1:n
		long sum = n * (n+1) / 2; 
		//This formula for the sum of squares comes from Wikipedia
		long sumSquares = n * (n + 1) * (2 * n + 1) / 6; 
		//Calculates the square of sum minus the sum of squares
		return sum * sum - sumSquares;
	}
}
