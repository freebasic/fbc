# include "fbcu.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

namespace fbc_tests.boolean_.uop

	''
	sub test1 cdecl ( )

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

		dot( -, FALSE )
		dot( -, TRUE )

	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.boolean.boolean_uop")
		fbcu.add_test("test1", @test1)
		
	end sub
	
end namespace
			