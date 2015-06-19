# include "fbcu.bi"

#define FALSE 0
#define TRUE -1

namespace fbc_tests.boolean_.uop

	''
	sub test1 cdecl ( )

		#macro dot( op, arg )
			a = (arg)
			c = op (arg)
			CU_ASSERT_EQUAL( op (a), c )
		#endmacro

		dim as boolean a, b
		dim as integer c

		''   (op a) == (op arg)

		dot( not, FALSE )
		dot( not, TRUE )

		dot( -, FALSE )
		dot( -, TRUE )

		dot( sgn, FALSE )
		dot( sgn, TRUE )

		dot( abs, FALSE )
		dot( abs, TRUE )

	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.boolean_.uop")
		fbcu.add_test("test1", @test1)
		
	end sub
	
end namespace
			