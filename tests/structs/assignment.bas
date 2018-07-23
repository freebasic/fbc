#include "fbcunit.bi"

SUITE( fbc_tests.structs.assignment )

	type foo_2
		bar(0 to 1) as integer
	end type

	type foo_4
		bar(0 to 3) as integer
	end type

	type foo_5
		bar(0 to 4) as integer
	end type

		static as foo_2 chkref2 = ( { 1234, -5678 } )
		static as foo_4 chkref4 = ( { 1, 2, 3, 4 } )
		static as foo_5 chkref5 = ( { -1, -2, -3, -4, -5 } )

	#macro hDoTest2( base_ )
		for i as integer = 0 to 1
			CU_ASSERT_EQUAL( base_##bar(i), chkref2.bar(i) )
		next
	#endmacro

	#macro hDoTest4( base_ )
		for i as integer = 0 to 3
			CU_ASSERT_EQUAL( base_##bar(i), chkref4.bar(i) )
		next
	#endmacro

	#macro hDoTest5( base_ )
		for i as integer = 0 to 4
			CU_ASSERT_EQUAL( base_##bar(i), chkref5.bar(i) )
		next
	#endmacro

	function proc_ret2 as foo_2
		function = chkref2
	end function

	function proc_ret4 as foo_4
		function = chkref4
	end function

	function proc_ret5 as foo_5
		function = chkref5
	end function

	TEST( return_ )
		dim f2 as foo_2 = any
		f2 = proc_ret2( )
		hDoTest2( f2. )

		dim f4 as foo_4 = any
		f4 = proc_ret4( )
		hDoTest4( f4. )

		dim f5 as foo_5 = any
		f5 = proc_ret5( )
		hDoTest5( f5. )
	END_TEST

	TEST( pointer_ )
		dim pf2 as foo_2 ptr = allocate( len( foo_2 ) )
		*pf2 = chkref2
		hDoTest2( pf2-> )
		deallocate( pf2 )

		dim pf4 as foo_4 ptr = allocate( len( foo_4 ) )
		*pf4 = chkref4
		hDoTest4( pf4-> )
		deallocate( pf4 )

		dim pf5 as foo_5 ptr = allocate( len( foo_5 ) )
		*pf5 = chkref5
		hDoTest5( pf5-> )
		deallocate( pf5 )
	END_TEST

	sub proc_byref2( byref f as foo_2 )
		f = chkref2
	end sub

	sub proc_byref4( byref f as foo_4 )
		f = chkref4
	end sub

	sub proc_byref5( byref f as foo_5 )
		f = chkref5
	end sub

	TEST( byref_ )
		dim f2 as foo_2 = any
		proc_byref2( f2 )
		hDoTest2( f2. )

		dim f4 as foo_4 = any
		proc_byref4( f4 )
		hDoTest4( f4. )

		dim f5 as foo_5 = any
		proc_byref5( f5 )
		hDoTest5( f5. )
	END_TEST

END_SUITE
