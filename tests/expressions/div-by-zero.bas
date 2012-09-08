# include once "fbcu.bi"

namespace fbc_tests.expressions.div_by_zero

private sub test cdecl( )
	dim as double a = 1, b = 0, c

	c = 1.0 / 0.0  '' no compile error, but returns INF
	c = a / 0.0    '' no compile error, but returns INF
	c = 1.0 / b    '' no runtime error, but returns INF
	c = a / b      '' no runtime error, but returns INF

	CU_PASS( )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/expressions/div-by-zero" )
	fbcu.add_test( "test", @test )
end sub

end namespace
