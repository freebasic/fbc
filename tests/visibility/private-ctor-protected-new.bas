' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	declare constructor( )
end type

constructor Parent( )
end constructor

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	var p = new Parent( )
end sub
