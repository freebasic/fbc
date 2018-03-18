#include "fbcunit.bi"

enum TEST_RES
	TEST_T1
	TEST_T2
	TEST_T3
end enum

namespace module.ns.reimp3.foo 
	type t1 : __ as integer : end type
end namespace

namespace module.ns.reimp3.bar 
    using foo
    function foobar overload (__ as t1) as TEST_RES
    	function = TEST_T1
	end function
end namespace

namespace module.ns.reimp3.foo 
	type t2 : __ as integer : end type
	
	type t3 : __ as integer : end type
end namespace

namespace module.ns.reimp3.bar 
    function foobar(__ as t2) as TEST_RES
    	function = TEST_T2
	end function

    function foobar(__ as t3) as TEST_RES
    	function = TEST_T3
	end function
end namespace

SUITE( fbc_tests.namespace_.reimp3 )
	TEST( all )
		using module.ns.reimp3.bar
		
		CU_ASSERT( foobar( type<t1>( 0 ) ) = TEST_T1 )
		CU_ASSERT( foobar( type<t2>( 0 ) ) = TEST_T2 )
		CU_ASSERT( foobar( type<t3>( 0 ) ) = TEST_T3 )
	END_TEST
END_SUITE
