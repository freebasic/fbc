# include "fbcu.bi"

namespace fbc_tests.ns.dim_.inner

	extern array() as integer

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

	sub dotest cdecl()
		dim as integer i
		for i = lbound(array) to ubound(array)
			array(i) = 0
		next
		CU_ASSERT( test_zero( ) <> 0 )
	end sub

end namespace

namespace fbc_tests.ns.dim_.outer2
	using inner

	sub dotest cdecl()
		dim as integer i
		for i = lbound(array) to ubound(array)
			array(i) = i
		next
		CU_ASSERT( test_lin( ) <> 0 )
	end sub

end namespace

private function init cdecl () as integer
	
	redim fbc_tests.ns.dim_.inner.array(0 to 2)
	
	function = 0
	
end function

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.dim_array", @init)
	
	fbcu.add_test("test 1", @fbc_tests.ns.dim_.outer2.dotest)
	
	using fbc_tests.ns.dim_.outer1
	fbcu.add_test("test 2", @dotest)

end sub
