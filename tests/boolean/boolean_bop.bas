# include "fbcu.bi"

#define FALSE 0
#define TRUE -1

namespace fbc_tests.boolean_.bop

	''
	sub test1 cdecl ( )

		#macro dot( arg1, op, arg2 )
			a = arg1
			b = arg2
			c = arg1 op arg2
			CU_ASSERT_EQUAL( a op b, c )
		#endmacro

		dim as boolean a, b
		dim as integer c

		''   (a op b) == (arg op arg)

		dot( FALSE, and, FALSE )
		dot( FALSE, and, TRUE )
		dot( TRUE, and, FALSE )
		dot( TRUE, and, TRUE )

		dot( FALSE, or, FALSE )
		dot( FALSE, or, TRUE )
		dot( TRUE, or, FALSE )
		dot( TRUE, or, TRUE )

		dot( FALSE, xor, FALSE )
		dot( FALSE, xor, TRUE )
		dot( TRUE, xor, FALSE )
		dot( TRUE, xor, TRUE )

		dot( FALSE, imp, FALSE )
		dot( FALSE, imp, TRUE )
		dot( TRUE, imp, FALSE )
		dot( TRUE, imp, TRUE )

		dot( FALSE, eqv, FALSE )
		dot( FALSE, eqv, TRUE )
		dot( TRUE, eqv, FALSE )
		dot( TRUE, eqv, TRUE )

		dot( FALSE, <, FALSE )
		dot( FALSE, <, TRUE )
		dot( TRUE, <, FALSE )
		dot( TRUE, <, TRUE )

		dot( FALSE, <=, FALSE )
		dot( FALSE, <=, TRUE )
		dot( TRUE, <=, FALSE )
		dot( TRUE, <=, TRUE )

		dot( FALSE, =, FALSE )
		dot( FALSE, =, TRUE )
		dot( TRUE, =, FALSE )
		dot( TRUE, =, TRUE )

		dot( FALSE, >=, FALSE )
		dot( FALSE, >=, TRUE )
		dot( TRUE, >=, FALSE )
		dot( TRUE, >=, TRUE )

		dot( FALSE, >, FALSE )
		dot( FALSE, >, TRUE )
		dot( TRUE, >, FALSE )
		dot( TRUE, >, TRUE )

		dot( FALSE, <>, FALSE )
		dot( FALSE, <>, TRUE )
		dot( TRUE, <>, FALSE )
		dot( TRUE, <>, TRUE )

		dot( FALSE, +, FALSE )
		dot( FALSE, +, TRUE )
		dot( TRUE, +, FALSE )
		dot( TRUE, +, TRUE )

		dot( FALSE, -, FALSE )
		dot( FALSE, -, TRUE )
		dot( TRUE, -, FALSE )
		dot( TRUE, -, TRUE )

		dot( FALSE, *, FALSE )
		dot( FALSE, *, TRUE )
		dot( TRUE, *, FALSE )
		dot( TRUE, *, TRUE )

	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.boolean_.bop")
		fbcu.add_test("test1", @test1)
		
	end sub
	
end namespace
			