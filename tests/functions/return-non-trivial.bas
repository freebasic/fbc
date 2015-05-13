# include "fbcu.bi"

namespace fbc_tests.structs.return_non_trivial

namespace nonTrivialDueToField
	'' UDTs can become non-trivial as a result of containing a non-trivial
	'' field. The compiler must be careful to take this into account when
	'' determining how to return an UDT from a function (in registers or
	'' on stack).

	dim shared dtors as integer

	type A
		i as integer
		declare destructor( )
	end type

	destructor A()
		dtors += 1
	end destructor

	type B
		a as A
	end type

	function f( ) as B
		function = type( (123) )
	end function

	sub test cdecl( )
		CU_ASSERT( dtors = 0 )
		CU_ASSERT( f().a.i = 123 )
		CU_ASSERT( dtors = 2 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/return-non-trivial" )
	fbcu.add_test( "nonTrivialDueToField", @nonTrivialDueToField.test )
end sub

end namespace
