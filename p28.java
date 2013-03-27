
  // This problem asks to sum the values in a diagonal spiral like the one below
	/*21 22 23 24 25
	  20  7  8  9 10
	  19  6  1  2 11
	  18  5  4  3 12
	  17 16 15 14 13*/

	// 1 is always in the sum.  After this, it can be seen that the index of the values
	// to be summed increments by 2 (4 times), by 4 (4 times), by 6 (4 times), etc
	// This problem asks what is the sum of the numbers in a 1001 by 1001 spiral

public class Spiral {
	
	private static int diagonalSize(int spiralSize) {
		
		int numbers = spiralSize * spiralSize; // Total number of numbers
		int increment = 2;
		int diagSize = 1; // Must add the 1 from the middle of the spiral
		int temp = 0;
		
		for(int i = 3;i <= numbers;i = i + increment) {
			diagSize += i;
			temp++;
			if(temp == 4) {temp = 0; increment += 2;} // Add 2 to increment every 4 times
		}
		return diagSize;	
		}
		
	public static void main(String[] args){
		long start = System.currentTimeMillis();
		int answer = diagonalSize(1001);
		System.out.println(answer);
		long end = System.currentTimeMillis();
		System.out.println("Execution time was " + (end-start) + "ms.");
	}
}
