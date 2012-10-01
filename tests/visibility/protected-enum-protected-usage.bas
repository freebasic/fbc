' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	protected:
	enum E
		MYCONST = 123
	end enum
end type

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as integer i
	i = MYCONST
	i = E.MYCONST
end sub
