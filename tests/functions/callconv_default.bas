# include "fbcunit.bi"

SUITE( fbc_tests.functions.callconv_default )
	
	type bar_f as bar
	
	type bar
		as integer x, y
	end type
	
	function foo( b as bar ) as integer
		b.x = 69
		b.y = 70
		function = 0
	end function
	
	function foo2( s as string ) as integer
		s = "some long text"
		function = 0
	end function
	
	function foo3( bp as bar ptr ) as integer
		bp = 0
		function = 0
	end function
	
	function foo4( i as integer ) as integer
		i = 0
		function = 0
	end function
	
	function foo5( b as bar_f ) as integer
		b.x = 69
		b.y = 70
		function = 0
	end function
	
	TEST( byrefType )
		dim as bar baz
		dim as bar ptr baz_ptr = @baz
		
		foo( baz )
		
		CU_ASSERT_EQUAL( baz.x, 69 )
		
		foo3( baz_ptr )
		
		CU_ASSERT_EQUAL( baz_ptr, @baz )
		
	END_TEST
	
	TEST( byrefString )
		
		dim as string s
		
		foo2( s )
		
		CU_ASSERT_EQUAL( s, "some long text" )
		
		dim as string * 10 s_10
		
		foo2( s_10 )
		
		CU_ASSERT_EQUAL( s_10, "some long " )
		
	END_TEST
	
	TEST( byvalNumber )
		
		dim as integer i = 69
		
		foo4( i )
		
		CU_ASSERT_EQUAL( i, 69 )
		
	END_TEST
	
	TEST( byrefFwdType )
		
		dim as bar_f baz2
		
		foo5( baz2 )
		
		CU_ASSERT_EQUAL( baz2.x, 69 )
		
	END_TEST
	
END_SUITE
