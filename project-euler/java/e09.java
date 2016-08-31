
public class Triples {

  // There is exactly one pythagorean triplet (a^2 + b^2 = c^2)
	// For which a + b + c = 1000.  This program finds this triplet
	// and returns the multiple a * b * c
	
	public static void main(String[] args){
		generateTriples();
	}
	
	public static int generateTriples(){
		for(int u=1;u<50;u++){
			for(int v=u+1;v<51;v++){
				int a = v*v - u*u;
				int b = 2*v*u;
				int c = v*v + u*u;
				if(a+b+c==1000) {
					System.out.println(a + " " + b + " " + c);
					System.out.println(a*b*c);
					return a*b*c;
				}
			}
		}
		return 0;
	}
}
