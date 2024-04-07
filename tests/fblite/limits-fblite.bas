' TEST_MODE : COMPILE_ONLY_OK

#include "fblimits.bi"

#ifdef __FB_64BIT__

	#if ( MIN_VALUE_INTEGER <> -9223372036854775808 )
		#error
	#endif

	#if ( MAX_VALUE_INTEGER <> 9223372036854775807 )
		#error
	#endif

	#if ( MIN_VALUE_UINTEGER <> 0 )
		#error
	#endif

	#if ( MAX_VALUE_UINTEGER <> 18446744073709551615 )
		#error
	#endif

#else

	#if ( MIN_VALUE_INTEGER <> -2147483648 )
		#error
	#endif

	#if ( MAX_VALUE_INTEGER <> 2147483647 )
		#error
	#endif

	#if ( MIN_VALUE_UINTEGER <> 0 )
		#error
	#endif

	#if ( MAX_VALUE_UINTEGER <> 4294967295 )
		#error
	#endif


#endif
