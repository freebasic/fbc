#include once "fbcu.bi"
#include once "crt/long.bi"

namespace fbc_tests.crt.clong_

sub test cdecl( )
	CU_ASSERT( sizeof( clong ) = sizeof( culong ) )

	#ifdef __FB_64BIT__
		#ifdef __FB_WIN32__
			CU_ASSERT( sizeof( clong ) = 4 )
		#else
			CU_ASSERT( sizeof( clong ) = 8 )
		#endif
	#else
		CU_ASSERT( sizeof( clong ) = 4 )
	#endif
end sub

sub ctor( ) constructor
	fbcu.add_suite( "tests/crt/clong" )
	fbcu.add_test( "test", @test )
end sub

end namespace
