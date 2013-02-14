#include "fbcu.bi"

namespace fbc_tests.pp.if_

sub test cdecl( )
	dim as integer i = 0
	dim as string s

	#if 1
		CU_PASS( )
		i = 1
	#endif
	CU_ASSERT( i = 1 )
	i = 0

	#if 0
		CU_FAIL( )
		i = 1
	#endif
	CU_ASSERT( i = 0 )

	#if 1
		CU_PASS( )
		i = 1
	#else
		CU_FAIL( )
		i = 2
	#endif
	CU_ASSERT( i = 1 )
	i = 0

	#if 0
		CU_FAIL( )
		i = 1
	#else
		CU_PASS( )
		i = 2
	#endif
	CU_ASSERT( i = 2 )
	i = 0

	#if "test"
		CU_FAIL( )
	#else
		CU_PASS( )
	#endif

	#if 1 = 2
		CU_FAIL( )
	#else
		CU_PASS( )
	#endif

	#if 1 = 5 - (((4 * 2) + 8) / 4)
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if "a" + "b" = "ab"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/pp/if" )
	fbcu.add_test( "test", @test )
end sub

end namespace
