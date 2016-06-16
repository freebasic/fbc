# include "fbcu.bi"

namespace fbc_tests.structs.derived_override


type Foo
	declare function DoSomething() as integer
	declare function DoIt() as integer
	declare function DoItFromBase() as integer

	private:
	dim unused as byte
end type

function Foo.DoSomething() as integer
	return 1
end function

function Foo.DoIt() as integer
	return DoSomething()
end function

function Foo.DoItFromBase() as integer
	return DoSomething()
end function


type SuperFoo extends Foo
	declare function DoSomething() as integer
	declare function DoIt() as integer
end type

function SuperFoo.DoSomething() as integer
	return 2
end function

function SuperFoo.DoIt() as integer
	return DoSomething()
end function

sub testOverride cdecl( )
	dim as SuperFoo inst
	CU_ASSERT( inst.DoIt() = 2 )
	CU_ASSERT( cast( Foo, inst ).DoIt() = 1 )
	CU_ASSERT( inst.DoItFromBase() = 1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.structs.derived-override" )
	fbcu.add_test( "derived override", @testOverride )
end sub

end namespace
