# include "fbcunit.bi"

SUITE( fbc_tests.dim_.auto_var2 )

	type foo
		bar as integer
		declare constructor()	
		declare constructor( v as integer )
	end type

	constructor foo()	
		bar = 1234
	end constructor

	constructor foo( v as integer )
		bar = v
	end constructor

	TEST( varObject )

		var f1 = foo
		CU_ASSERT_EQUAL( f1.bar, 1234 )

		var f2 = foo( 5678 )
		CU_ASSERT_EQUAL( f2.bar, 5678 )
		
	END_TEST

	type bar
		pad as byte
		foo as integer
	end type

	TEST( varAnonymous )

		var f1 = type<bar>( 0, 1234 )
		CU_ASSERT_EQUAL( f1.foo, 1234 )

		var f2 = type<bar>( 0, 5678 )
		CU_ASSERT_EQUAL( f2.foo, 5678 )
		
	END_TEST

END_SUITE
