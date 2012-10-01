# include "fbcu.bi"

namespace fbc_tests.dim_.array_static_ini

type foo
	bar(0 to 3) as integer
end type

private sub test1 cdecl( )
	static arr(0 to 10) as foo
	static pf as foo ptr = @arr(10)

	arr(10).bar(3) = -1234

	CU_ASSERT_EQUAL( pf->bar(3), -1234 )
end sub

namespace test3544952
	'' Regression test for #3544952; this should compile fine
	type Parent
		a as integer
	end type

	type Child as FwdrefChild

	dim shared array() as Child ptr

	type FwdrefChild extends Parent
	end type

	private sub test cdecl( )
		'' This REDIM ensures the array is used/referenced,
		'' forcing the static array desciptor to be emitted,
		'' which caused the problem.
		redim array(0 to 0)
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/array-static-init" )
	fbcu.add_test( "1", @test1 )
	fbcu.add_test( "#3544952", @test3544952.test )
end sub

end namespace
