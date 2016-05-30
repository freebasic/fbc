# include "fbcu.bi"

namespace fbc_tests.structs.dtor_early_exit


dim shared as integer nested_dtors

type Nested
	as integer i
	declare destructor( )
end type

destructor Nested( )
	nested_dtors += 1
end destructor


type Parent1
	as Nested foo
	declare destructor( )
end type

destructor Parent1( )
	'' Early returns from destructors shouldn't prevent member destruction
	return
end destructor


type Parent2
	as Nested foo
	declare destructor( )
end type

destructor Parent2( )
	exit destructor
end destructor


type Parent3
	as Nested foo
	declare destructor( )
end type

destructor Parent3( )
end destructor


sub test cdecl( )
	scope
		dim as Parent1 x
	end scope
	CU_ASSERT( nested_dtors = 1 )

	scope
		dim as Parent2 x
	end scope
	CU_ASSERT( nested_dtors = 2 )

	scope
		dim as Parent3 x
	end scope
	CU_ASSERT( nested_dtors = 3 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.structs.dtor-early-exit")
	fbcu.add_test( "Irrelevant early return from destructor", @test )
end sub

end namespace
