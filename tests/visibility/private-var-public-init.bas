' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	private:
	static x as integer
end type

dim T.x as integer = 123
