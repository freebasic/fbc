class MyLib
{
	public native int add( int l, int r );

	static 
	{
		System.loadLibrary( "mylib" );
	}
}
