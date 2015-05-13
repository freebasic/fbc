' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare destructor( )
end type

destructor T( )
end destructor

dim as T ptr p
delete[] p
