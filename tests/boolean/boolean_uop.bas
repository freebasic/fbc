# include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

SUITE( fbc_tests.boolean_.boolean_uop )

	''
	TEST( test1 )

		#macro dot( op, arg )
			a = (arg)
			c = op (arg)

			'' test uop var = const(uop const)
			CU_ASSERT_EQUAL( op (a), c )

			'' test uop const = const(uop const)
			CU_ASSERT_EQUAL( op (arg), c )
		#endmacro

		dim as boolean a
		dim as integer c

		''   (op a) == (op arg)

		dot( not, FALSE )
		dot( not, TRUE )

	END_TEST
	
END_SUITE
