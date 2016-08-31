
public class NumToWords {
  
	// This program determines the number of letters required to print out
	// a series of numbers as words
	
	public static void main(String[] args){
		long start = System.currentTimeMillis();
		int Answer = Looper(1000);
		System.out.println(Answer);
		long end = System.currentTimeMillis();
		System.out.println("Execution time was " + (end-start) + "ms.");
	}
	
	public static int Looper(int maximum) {
		int total = 0;
		for (int i = 1; i <= maximum; i++){
			total += Converter(i);
		}
		return total;
	}
	
	//Convert the integer to a series of digits:
	public static int Converter(int number){
		// Instantiate at 0 each time:
		int thousands = 0;
		int hundreds = 0;
		int tens = 0;
		int ones = 0;
		String stringNum = Integer.toString(number); // Convert for processing
		
		if (stringNum.length() == 4) { //Thousands
			thousands = Character.getNumericValue(stringNum.charAt(0));
			hundreds = 	Character.getNumericValue(stringNum.charAt(1));
			tens = 		Character.getNumericValue(stringNum.charAt(2));
			ones = 		Character.getNumericValue(stringNum.charAt(3));
		}
		else if (stringNum.length() == 3) { //Hundreds
			hundreds = 	Character.getNumericValue(stringNum.charAt(0)); 
			tens = 		Character.getNumericValue(stringNum.charAt(1));
			ones = 		Character.getNumericValue(stringNum.charAt(2));
		}
		else if (stringNum.length() == 2) { //Tens
			tens = 		Character.getNumericValue(stringNum.charAt(0));
			ones = 		Character.getNumericValue(stringNum.charAt(1));
		}
		else { // Ones
			ones = 		Character.getNumericValue(stringNum.charAt(0));
		}
		int numLetters = counter(thousands,hundreds,tens,ones);
		return numLetters;
	}
	
	//Compute the number of letters for a given number:
	public static int counter(int thousands, int hundreds, int tens, int ones){
		int letters = 0;
		switch (thousands) {
			case 0: break;
			case 1: letters += 11; break; //One Thousand
			case 2: letters += 11; break; //Two Thousand
			case 3: letters += 13; break; //Three Thousand
			case 4: letters += 12; break; //Four Thousand
			case 5: letters += 12; break; //Five Thousand
			case 6: letters += 11; break; //Six Thousand
			case 7: letters += 13; break; //Seven Thousand
			case 8: letters += 13; break; //Eight Thousand
			case 9: letters += 12; break; //Nine Thousand
		}
		if(hundreds>=1 && tens == 0 && ones == 0){
			letters -= 3; //Remove letters for "and"
		}
		switch(hundreds) {
			case 0: break;
			case 1: letters += 13; break; //One Hundred and
			case 2: letters += 13; break; //Two Hundred and
			case 3: letters += 15; break; //Three Hundred and
			case 4: letters += 14; break; //Four Hundred and
			case 5: letters += 14; break; //Five Hundred and
			case 6: letters += 13; break; //Six Hundred and
			case 7: letters += 15; break; //Seven Hundred and
			case 8: letters += 15; break; //Eight Hundred and
			case 9: letters += 14; break; //Nine hundred and
		}
		if(tens==1){ //Deal with numbers in teens
			switch(ones) {
		    	case 0: letters += 3; break; //Ten
		    	case 1: letters += 6; break; //Eleven
		    	case 2: letters += 6; break; //Twelve
		    	case 3: letters += 8; break; //Thirteen
		    	case 4: letters += 8; break; //Fourteen
		    	case 5: letters += 7; break; //Fifteen
		    	case 6: letters += 7; break; //Sixteen
		    	case 7: letters += 9; break; //Seventeen
		    	case 8: letters += 8; break; //Eighteen
		    	case 9: letters += 8; break; //Nineteen
			}
		}
		else { // Numbers are not teens
			switch(tens) {
		    	case 0: break;
		    	case 2: letters += 6; break; //Twenty
		    	case 3: letters += 6; break; //Thirty
		    	case 4: letters += 5; break; //Forty
		    	case 5: letters += 5; break; //Fifty
		    	case 6: letters += 5; break; //Sixty
		    	case 7: letters += 7; break; //Seventy
		    	case 8: letters += 6; break; //Eighty
		    	case 9: letters += 6; break; //Ninety
			}
			switch(ones){
				case 0: break;
				case 1: letters += 3; break; //One
		    	case 2: letters += 3; break; //Two
		    	case 3: letters += 5; break; //Three
		    	case 4: letters += 4; break; //Four
		    	case 5: letters += 4; break; //Five
		    	case 6: letters += 3; break; //Six
		    	case 7: letters += 5; break; //Seven
		    	case 8: letters += 5; break; //Eight
		    	case 9: letters += 4; break; //Nine
			}
		}
		return letters;
	}
}
