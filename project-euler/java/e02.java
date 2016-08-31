public class Fibonacci {
  
	/*This program finds the sum of all even 
	  Fibonacci numbers less than four million*/
	
	public static void main(String[] args) {
		int previous = 1;
		int  current = 1;
		int store = 0;
		int myNum = 0;
		while ((current + previous) < 4000000){
			store = previous;
			previous = current;
			current = store + current;
			if(current%2 == 0){
				myNum += current;
			}
		}
		System.out.println(myNum);
	}
}
