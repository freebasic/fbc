# include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_no_parentheses )

	TEST( initializer )

		# macro m1 ? ( foo, bar )
			foo + bar
		# endmacro

		var hello = m1 "hello", "!"
		var world = m1 "world", "!"

	END_TEST

	TEST( nested1 )

		#macro of ? ( __T__ )
			##__T__
		#endmacro

		#define conc( __A__, __B__ ) __A__##__B__

		#define tostr( __S__ ) __fb_quote__( __S__ )

		#macro template ? ( __N__, __T__ )
			tostr( conc( __N__, __T__ ) )
		#endmacro

		type Foo
			as integer bar
		end type

		dim s as string

		s = template( Foo, of( bar ) )
		CU_ASSERT_EQUAL( s, "Foobar" )

		s = template( Foo, of bar )
		CU_ASSERT_EQUAL( s, "Foobar" )

		s = template Foo, of bar
		CU_ASSERT_EQUAL( s, "Foobar" )

	END_TEST

	TEST( nested2 )

		#define tostr( __S__ ) __fb_quote__( __S__ )

		#macro foo ? ( a, b )
			__fb_quote__( a b )
		#endmacro

		#macro bar ? ( a, b, c )
			__fb_quote__( a b c )
		#endmacro

		#macro baz ? ( a, b, c )
			__fb_quote__( a b c )
		#endmacro

		dim s as string
		dim c as string = "$""1 2 3"" $""4 5 6"""

		s = foo( bar( 1, 2, 3 ), baz( 4, 5, 6 ) )
		CU_ASSERT_EQUAL( s, c )

		s = foo( bar 1, 2, 3, baz( 4, 5, 6 ) )
		CU_ASSERT_EQUAL( s, c )

		s = foo( bar( 1, 2, 3 ), baz 4, 5, 6 )
		CU_ASSERT_EQUAL( s, c )

		s = foo( bar 1, 2, 3, baz 4, 5, 6 )
		CU_ASSERT_EQUAL( s, c )

		s = foo bar( 1, 2, 3 ), baz( 4, 5, 6 )
		CU_ASSERT_EQUAL( s, c )

		s = foo bar 1, 2, 3, baz( 4, 5, 6 )
		CU_ASSERT_EQUAL( s, c )

		s = foo bar( 1, 2, 3 ), baz 4, 5, 6
		CU_ASSERT_EQUAL( s, c )

		s = foo bar 1, 2, 3, baz 4, 5, 6
		CU_ASSERT_EQUAL( s, c )

	END_TEST

END_SUITE
