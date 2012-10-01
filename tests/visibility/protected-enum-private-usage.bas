' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	protected:
	enum E
		MYCONST = 123
	end enum
end type

sub T.test( )
	dim as integer i
	i = MYCONST
	i = E.MYCONST
end sub
