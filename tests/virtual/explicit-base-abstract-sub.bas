' TEST_MODE : COMPILE_ONLY_FAIL

type Parent extends object
	i as integer
	declare abstract sub f( )
end type

type Child extends Parent
	declare sub f( ) override
end type

sub Child.f( )
	base.f( )
end sub
