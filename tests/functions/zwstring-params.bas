# include "fbcunit.bi"

SUITE( fbc_tests.functions.zwstring_params )

	'' Declares to test implicit BYREFs
	declare sub foo(  s as  string )
	declare sub zfoo( z as zstring )
	declare sub wfoo( w as wstring )

	sub foo( byref s as string )
		CU_ASSERT_EQUAL( s, "Test" )
	end sub

	sub zfoo( byref z as zstring )
		CU_ASSERT_EQUAL( z, "Test" )
	end sub

	sub wfoo( byref w as wstring )
		CU_ASSERT_EQUAL( w, wstr("Test") )
	end sub

	TEST( implicitByref )
		dim s as string = "Test"
		dim s10 as string * 10 = "Test"
		dim z10 as zstring* 10 = "Test"
		dim w10 as wstring * 10 = "Test"
		dim ps as string ptr = @s
		dim pz as zstring ptr = @z10
		dim pw as wstring ptr = @w10

		foo( "Test" )
		foo( s )
		foo( s10 )
		foo( z10 )
		foo( w10 )
		foo( *ps )
		foo( *pz )
		foo( *pw )
		foo( byval ps )

		zfoo( "Test" )
		zfoo( s )
		zfoo( s10 )
		zfoo( z10 )
		zfoo( w10 )
		zfoo( *ps )
		zfoo( *pz )
		zfoo( *pw )
		zfoo( byval pz )

		wfoo( "Test" )
		wfoo( s )
		wfoo( s10 )
		wfoo( z10 )
		wfoo( w10 )
		wfoo( *ps )
		wfoo( *pz )
		wfoo( *pw )
		wfoo( byval pw )

	END_TEST

	function fByvalPtrToByrefZstring( byref z as zstring ) as zstring ptr
		function = @z
	end function

	function fByvalPtrToByrefWstring( byref w as wstring ) as wstring ptr
		function = @w
	end function

	TEST( byvalPtrToByref )
		CU_ASSERT( fByvalPtrToByrefZstring( byval 0 ) = 0 )
		CU_ASSERT( fByvalPtrToByrefWstring( byval 0 ) = 0 )
		CU_ASSERT( fByvalPtrToByrefZstring( byval 123 ) = 123 )
		CU_ASSERT( fByvalPtrToByrefWstring( byval 456 ) = 456 )

		dim z as zstring * 32 = "abc"
		dim w as wstring * 32 = wstr( "abc" )
		dim pz as zstring ptr = @z
		dim pw as wstring ptr = @w
		CU_ASSERT( *fByvalPtrToByrefZstring( byval pz ) = z )
		CU_ASSERT( *fByvalPtrToByrefWstring( byval pw ) = w )
	END_TEST

END_SUITE
