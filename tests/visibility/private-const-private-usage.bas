' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	private:
	const MYCONST = 123
end type

sub T.test( )
	dim as integer i
	i = MYCONST

	enum
		NEXTCONST = MYCONST
	end enum

	enum MYENUM
		NEXTNEXTCONST = MYCONST
	end enum
end sub
