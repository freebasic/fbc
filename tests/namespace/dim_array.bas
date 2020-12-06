#include "fbcunit.bi"

namespace fbc_tests.ns.dim_.inner

	extern array() as integer
	dim array() as integer

	function test_zero() as integer
		dim as integer i
		for i = lbound(array) to ubound(array)
			if( array(i) <> 0 ) then 
				return 0
			end if
		next	
		function = -1
	end function
	
	function test_lin() as integer
		dim as integer i
		for i = lbound(array) to ubound(array)
			if( array(i) <> i ) then 
				return 0
			end if
		next
		function = -1
	end function
	
end namespace

namespace fbc_tests.ns.dim_.outer1
	using inner

	sub dotest
		dim as integer i
		for i = lbound(array) to ubound(array)
			array(i) = 0
		next
		CU_ASSERT( test_zero( ) <> 0 )
	end sub

end namespace

namespace fbc_tests.ns.dim_.outer2
	using inner

	sub dotest
		dim as integer i
		for i = lbound(array) to ubound(array)
			array(i) = i
		next
		CU_ASSERT( test_lin( ) <> 0 )
	end sub

end namespace

SUITE( fbc_tests.namespace_.dim_array )

	SUITE_INIT
		redim ..fbc_tests.ns.dim_.inner.array(0 to 2)
		'' return success
		return 0
	END_SUITE_INIT

	TEST( outer_named )
		..fbc_tests.ns.dim_.outer2.dotest
	END_TEST

	TEST( outer_using )
		using ..fbc_tests.ns.dim_.outer1
		dotest
	END_TEST

END_SUITE
