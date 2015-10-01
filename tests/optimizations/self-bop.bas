# include "fbcu.bi"

namespace fbc_tests.optimizations.self_bop

dim shared i as integer

sub test cdecl( )
	i = i + 1
	CU_ASSERT( i = 1 )

	'' The self-bop optimization should still work when it has to deal with
	'' noconv casts
	#ifdef __FB_64BIT__
		i = clngint(i + 1)
	#else
		i = clng(i + 1)
	#endif
	i = cuint(i + 1)
	cuint(i) = i + 1
	#ifdef __FB_64BIT__
		clngint(i) = i + 1
	#else
		clng(i) = i + 1
	#endif
	i = cuint(i) + 1

	'' Real conversions that matter shouldn't be ignored though
	i = 255
	i = cbyte( i + 1 )
	CU_ASSERT( i = 0 )

	i = 255
	i = cubyte( i + 1 )
	CU_ASSERT( i = 0 )

	i = 256
	i = cbyte( i + 1 )
	CU_ASSERT( i = 1 )

	i = 256
	i = cbyte( i ) + 1
	CU_ASSERT( i = 1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/optimizations/self-bop" )
	fbcu.add_test( "test", @test )
end sub

end namespace
