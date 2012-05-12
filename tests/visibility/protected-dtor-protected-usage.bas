' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	protected:
	declare destructor( )
end type

destructor Parent( )
end destructor

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	static as Parent staticx

	dim as Parent x1
	dim as Parent x2(0 to 1)

	dim as Parent ptr p
	delete p
	delete[] p
end sub
