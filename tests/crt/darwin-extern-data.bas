#include "fbcunit.bi"

'' darwin: variables of a dylib (here __stdoutp and __stderrp of libSystem,
'' the FILE pointers of stdout and stderr) must be accessed through the GOT:
'' Mach-O has no copy relocations, and ld rejected the RIP-relative access of
'' gas64 with "invalid use of rip-relative addressing"

#if defined( __FB_DARWIN__ )

extern "C"
	extern stdout_ alias "__stdoutp" as any ptr
	extern stderr_ alias "__stderrp" as any ptr
	declare function fileno_ alias "fileno" ( byval stream as any ptr ) as long
end extern

SUITE( fbc_tests.crt.darwin_extern_data )

	TEST( load )
		CU_ASSERT( stdout_ <> 0 )
		CU_ASSERT( stderr_ <> 0 )
		CU_ASSERT( stdout_ <> stderr_ )
	END_TEST

	TEST( address )
		dim as any ptr ptr p = @stdout_
		CU_ASSERT( *p = stdout_ )
		p = @stderr_
		CU_ASSERT( *p = stderr_ )
	END_TEST

	TEST( argument )
		CU_ASSERT_EQUAL( fileno_( stdout_ ), 1 )
		CU_ASSERT_EQUAL( fileno_( stderr_ ), 2 )
	END_TEST

END_SUITE

#endif
