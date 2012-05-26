# include "fbcu.bi"

namespace fbc_tests.macros.variadic

#define stringify(x) #x

#define identity(x...) x
#define nothing(x...)

#define add(a, b) (a + b)
#define add2(operands...) add(operands)

sub expansion cdecl ()
	CU_ASSERT_EQUAL( identity( 5 ), 5 )
	CU_ASSERT_EQUAL( stringify( identity( 5 ) ), "5" )
	CU_ASSERT_EQUAL( stringify( ( identity( a, b, c ) ) ), "( a, b, c )" )
    CU_ASSERT_EQUAL( add2( 3, 4 ), 7 )
    nothing(r,a(n)+dom.)

	identity()
	nothing()
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.macros.variadic")
	fbcu.add_test("expansion", @expansion)

end sub

end namespace
