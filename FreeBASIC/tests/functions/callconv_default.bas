# include "fbcu.bi"

namespace fbc_tests.functions.callconv_default
	
	type bar_f as bar
	
	type bar
		as integer x, y
	end type
	
	function foo( b as bar ) as integer
		b.x = 69
		b.y = 70
	end function
	
	function foo2( s as string ) as integer
		s = "some long text"
	end function
	
	function foo3( bp as bar ptr ) as integer
		bp = 0
	end function
	
	function foo4( i as integer ) as integer
		i = 0
	end function
	
	function foo5( b as bar_f ) as integer
		b.x = 69
		b.y = 70
	end function
	
	sub test cdecl( )
		dim as bar baz
		dim as bar ptr baz_ptr = @baz
		
		foo( baz )
		
		CU_ASSERT_EQUAL( baz.x, 69 )
		
		foo3( baz_ptr )
		
		CU_ASSERT_EQUAL( baz_ptr, @baz )
		
	end sub
	
	sub test2 cdecl ( )
		
		dim as string s
		
		foo2( s )
		
		CU_ASSERT_EQUAL( s, "some long text" )
		
		dim as string * 10 s_10
		
		foo2( s_10 )
		
		CU_ASSERT_EQUAL( s_10, "some long " )
		
	end sub
	
	sub test3 cdecl( )
		
		dim as integer i = 69
		
		foo4( i )
		
		CU_ASSERT_EQUAL( i, 69 )
		
	end sub
	
	sub test4 cdecl( )
		
		dim as bar_f baz2
		
		foo5( baz2 )
		
		CU_ASSERT_EQUAL( baz2.x, 69 )
		
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.functions.callconv_default")
		fbcu.add_test("test", @test)
		fbcu.add_test("test2", @test2)
		fbcu.add_test("test3", @test3)
		fbcu.add_test("test4", @test4)
	
	end sub
	
end namespace
