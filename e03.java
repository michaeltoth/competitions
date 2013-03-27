import java.util.ArrayList;
public class Factorization {
  
	//This problem finds the largest prime factor of 600851475143

	public static void main(String[] args){
		long number = 600851475143L;
		long currNum = number;
		int currFactor;
		int largest = 0;
		ArrayList<Integer> factors = new ArrayList<Integer>();
		for (currFactor=2; currFactor<(number/2);currFactor++){
			while(currNum%currFactor==0){
				currNum = currNum/currFactor;
 				factors.add(currFactor);
 				if (currFactor > largest) {
 					largest = currFactor;
 				}
 				System.out.println(largest);
			}
		}
	}
}
