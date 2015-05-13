// to compile: javac Mylib.java Test.java
// to run: java Test

class Test
{
	public static void main(String[] args) 
	{
		MyLib lib = new MyLib();

		System.out.println( "2 + 2 = " + lib.add( 2, 2 ) ); 
	}
}
