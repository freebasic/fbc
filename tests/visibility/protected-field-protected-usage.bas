' TEST_MODE : COMPILE_ONLY_OK

type Parent
	protected:
	as integer i
end type

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as integer n
	n = i
	n = this.i
	n = base.i

	dim as Parent x
	n = x.i

	let( n ) = x
end sub
