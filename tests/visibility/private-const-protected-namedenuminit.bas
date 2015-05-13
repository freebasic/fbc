' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	const MYCONST = 123
end type

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	enum MYENUM
		NEXTNEXTCONST = MYCONST
	end enum
end sub
