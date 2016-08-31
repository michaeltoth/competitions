
// This program computes the longest path length for the Collatz Conjecture where
// The starting number is below n
// This path is defined by the following:
//  	n = n/2     (if n is even)
//		n = 3*n + 1 (if n is odd)

public class PathLength {

	public static int max = 1000000;
	
	public static int loop(int x){
		int longest = 0;
		for(int i=1;i<=x;i++){
			int length = 0;
			long num = i;
			while(num>1){
				if(num%2==0){
					num = num/2;
					length++;
				}
				else {
					num = 3*num + 1;
					length++;
				}
			}
			if(length>longest){
				longest = length;
				System.out.println("longest=" + longest + " AND");
				System.out.println("Number=" + i);
			}
			
		}
		return longest;
	}
	
	public static void main(String[] args){
		int x = loop(max);
		System.out.println(x);
	}
}
