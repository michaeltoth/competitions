//This program calculates the number of ways that it is possible to make change for $2 
//In pounds sterling.  The coin values are 1, 2, 5, 10, 20, 50, 100, and 200 cents
//This is currently very inefficient because it first generates every possible level of coins
//There is a much simpler method using recursion that you should investigate

public class Change {
  static int sum = 200;
	static int ways = 0;
	static int[] values = {1, 2, 5, 10, 20, 50, 100, 200}; // Values of coins
	
	//This function computes the dot product of the # of coins with the value of coins
	public static int dotProduct(int[] vals, int[] coins){
		int dotProduct = 0;
		for(int i = 0; i < vals.length; i++) {
			dotProduct += vals[i] * coins[i];
		}
		return dotProduct;
	}
	
	// This function generates a list of all possible coin combinations recursively,
	//
	public static void generate(int[] n, int[] max, int idx){
		if (idx == n.length) { // Base case
			if(dotProduct(values,n)==sum){
				ways++;
			}
			return;
		}
			
		for (int i = 0; i <= max[idx]; i++){
			n[idx] = i;
			generate(n, max, idx+1);
		}
	}
	
	public static void main(String[] args) {
		long start = System.currentTimeMillis();
		int[] n = new int[8];
		int max[] = {200,100,40,20,10,4,2,1}; // Max # of that particular coin allowed
		generate(n,max,0);
		System.out.println(ways);
		long end = System.currentTimeMillis();
		System.out.println("Execution time was " + (end-start) + "ms.");
	}
}
