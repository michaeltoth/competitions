
public class Palindrome {
  
	/* This program finds the largest palindromic number that can be created
	by multiplying two 3-digit numbers */
	
	public static void main(String[] args){	
		Looper();
	}

	public long upper = 999*999;
	public long lower = 100*100;
	
	private static boolean Palindrome(long myNum) {
		String number = Long.toString(myNum);
		String rStr = new StringBuffer(number).reverse().toString();
		if (number.equals(rStr)) {
			return true;
		} else return false;
	}
	
	private static void Looper() {
		int largest = 0;
		for (int i=100;i<=999;i++) {
			for (int j=100;j<=999;j++){
				if (Palindrome(i*j)) {
					if(i*j>largest) {
						largest = i*j;
						//Testing:
						//System.out.println("i= " + i);
						//System.out.println("j= " + j);
						//System.out.println("largest = " + largest);}
					}
				}
			}
		System.out.println("largest = " + largest);
		}
	}
}
