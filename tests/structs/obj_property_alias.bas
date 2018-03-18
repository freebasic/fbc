#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_property_alias )

	type UDT
		as integer p_v

		declare sub      setv alias "setv"( byval new_v as integer )
		declare property v    alias "setv"( byval new_v as integer )

		declare function getv alias "getv"( ) as integer
		declare property v    alias "getv"( ) as integer
	end type

	function UDT.getv( ) as integer
		function = p_v
	end function

	sub UDT.setv( byval new_v as integer)
		p_v = new_v
	end sub

	TEST( all )
		dim as UDT x

		CU_ASSERT( x.p_v = 0 )

		x.v = 1
		CU_ASSERT( x.p_v = 1 )
		CU_ASSERT( x.v = 1 )
	END_TEST

END_SUITE
