' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	protected:
	static x as integer
end type

dim Parent.x as integer

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	x = 123
	Parent.x = 123
	this.x = 123
	base.x = 123
	dim as integer y1 = x
	dim as integer y2 = Parent.x
	dim as integer y3 = this.x
	dim as integer y4 = base.x
end sub
