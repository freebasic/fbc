#include "fbcunit.bi"

'' darwin: #inclib "framework:Name" links with -framework Name

#if defined( __FB_DARWIN__ )

#inclib "framework:CoreFoundation"

extern "C"
	declare function CFAbsoluteTimeGetCurrent( ) as double
end extern

SUITE( fbc_tests.pp.inclib_framework )

	TEST( coreFoundation )
		'' seconds since 2001-01-01, from CoreFoundation.framework
		CU_ASSERT( CFAbsoluteTimeGetCurrent( ) > 0 )
	END_TEST

END_SUITE

#endif
