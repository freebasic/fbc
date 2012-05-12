' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	protected:
	const MYCONST = 123
end type

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as integer i
	i = MYCONST

	enum
		NEXTCONST = MYCONST
	end enum

	enum MYENUM
		NEXTNEXTCONST = MYCONST
	end enum
end sub
