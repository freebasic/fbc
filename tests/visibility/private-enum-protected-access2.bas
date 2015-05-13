' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	enum E
		MYCONST = 123
	end enum
end type

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as integer i
	i = E.MYCONST
end sub
