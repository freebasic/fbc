' TEST_MODE : COMPILE_ONLY_OK

#include "fblimits.bi"

#if ( MIN_VALUE_INTEGER <> -32768 )
	#error
#endif

#if ( MAX_VALUE_INTEGER <> 32767 )
	#error
#endif

#if ( MIN_VALUE_UINTEGER <> 0 )
	#error
#endif

#if ( MAX_VALUE_UINTEGER <> 65535 )
	#error
#endif
