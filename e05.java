
public class Divisible {
  
	// This program calculates the smallest number which is evenly divisible by
	// all numbers between 1 and 20
	
	public static void main(String[] args){
		int myNum = divides(20);
		System.out.println("The final number is: " + myNum);
		}
	
	private static int divides(int top){
		boolean flag = false;
		int number = top;
		int counter = 0;
		while(flag==false){
			outerloop:
			for(int x=1;x<=top;x++){
				if((number%x==0)&&(counter==(top-1)))
				{
					flag = true;
					break outerloop;
				} 
				else if(number%x==0)
				{
					counter++;
				}
				else
				{
					counter = 0;
					number++;
					break outerloop;
				}
			}
		}
		return number;
		
	}
}
