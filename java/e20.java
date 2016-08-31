
public class Sundays {
  
	//This program computes the number of Sundays which fall on the first of the month
	//between the years 1901 and 2000
	
	public static int firstSunday = 6; // The first Sunday in 1901 is the 6th of January
	
	//This loop adds days to the day count and uses modular arithmetic to determine 
	//If the first day of a month is a Sunday.  
	
	// This can be made to look much cleaner with an array of days to add rather than
	// The switch case statement below 
	
	public static int monthCounter(int first, int ystart, int yend){
		int days = 1; // Start on the first of January
		int firstSundays = 0;
		for(int y = ystart; y <= yend; y++){
			for(int m = 1; m <= 12; m ++){
				switch (m) {
					case 1: days += 31; if(days % 7 == first) firstSundays++; break;
					case 2: if (y % 400 == 0) // Leap year (divisible by 400)
									{days += 29; if(days % 7 == first) firstSundays++; break;}
							else if ((y % 4 == 0) && (y % 100 != 0)) // Leap year (divisible by 4 but not 100)
									{days += 29; if(days % 7 == first) firstSundays++; break;}
							else // Not a leap year
							    	{days += 28; if(days % 7 == first) firstSundays++; break;}
					case 3: 		days += 31; if(days % 7 == first) firstSundays++; break;
					case 4: 		days += 30; if(days % 7 == first) firstSundays++; break;
					case 5: 		days += 31; if(days % 7 == first) firstSundays++; break;
					case 6:			days += 30; if(days % 7 == first) firstSundays++; break;
					case 7: 		days += 31; if(days % 7 == first) firstSundays++; break;
					case 8: 		days += 31; if(days % 7 == first) firstSundays++; break;
					case 9: 		days += 30; if(days % 7 == first) firstSundays++; break;
					case 10: 		days += 31; if(days % 7 == first) firstSundays++; break;
					case 11: 		days += 30; if(days % 7 == first) firstSundays++; break;
					case 12: 		days += 31; if(days % 7 == first) firstSundays++; break;
				}
			}
		} return firstSundays;
	}
	
	public static void main(String[] args){
		long start = System.currentTimeMillis();
		int answer = monthCounter(firstSunday-1,1901,2000);
		System.out.println(answer);
		long end = System.currentTimeMillis();
		System.out.println("Execution time was " + (end-start) + "ms.");
	}
}
