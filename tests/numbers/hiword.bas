#include "fbcunit.bi"

SUITE( fbc_tests.numbers.hiword_ )

	TEST( all )
		dim i8  as ubyte    =               &h88u
		dim i16 as ushort   =             &h7788u
		dim i32 as ulong    =         &h55667788u
		dim i64 as ulongint = &h1122334455667788u

		#ifdef __FB_64BIT__
			dim i as uinteger = i64
		#else
			dim i as uinteger = i32
		#endif

		#assert( typeof( lobyte( i8  ) ) = typeof( uinteger ) )
		#assert( typeof( lobyte( i16 ) ) = typeof( uinteger ) )
		#assert( typeof( lobyte( i32 ) ) = typeof( uinteger ) )
		#assert( typeof( lobyte( i64 ) ) = typeof( uinteger ) )
		#assert( typeof( lobyte( i   ) ) = typeof( uinteger ) )

		#assert( typeof( hibyte( i8  ) ) = typeof( uinteger ) )
		#assert( typeof( hibyte( i16 ) ) = typeof( uinteger ) )
		#assert( typeof( hibyte( i32 ) ) = typeof( uinteger ) )
		#assert( typeof( hibyte( i64 ) ) = typeof( uinteger ) )
		#assert( typeof( hibyte( i   ) ) = typeof( uinteger ) )

		#assert( typeof( loword( i8  ) ) = typeof( uinteger ) )
		#assert( typeof( loword( i16 ) ) = typeof( uinteger ) )
		#assert( typeof( loword( i32 ) ) = typeof( uinteger ) )
		#assert( typeof( loword( i64 ) ) = typeof( uinteger ) )
		#assert( typeof( loword( i   ) ) = typeof( uinteger ) )

		#assert( typeof( hiword( i8  ) ) = typeof( uinteger ) )
		#assert( typeof( hiword( i16 ) ) = typeof( uinteger ) )
		#assert( typeof( hiword( i32 ) ) = typeof( uinteger ) )
		#assert( typeof( hiword( i64 ) ) = typeof( uinteger ) )
		#assert( typeof( hiword( i   ) ) = typeof( uinteger ) )

		CU_ASSERT( lobyte( i8  ) = &h88 )
		CU_ASSERT( lobyte( i16 ) = &h88 )
		CU_ASSERT( lobyte( i32 ) = &h88 )
		CU_ASSERT( lobyte( i64 ) = &h88 )
		CU_ASSERT( lobyte( i   ) = &h88 )

		CU_ASSERT( hibyte( i8  ) =    0 )
		CU_ASSERT( hibyte( i16 ) = &h77 )
		CU_ASSERT( hibyte( i32 ) = &h77 )
		CU_ASSERT( hibyte( i64 ) = &h77 )
		CU_ASSERT( hibyte( i   ) = &h77 )

		CU_ASSERT( loword( i8  ) =   &h88 )
		CU_ASSERT( loword( i16 ) = &h7788 )
		CU_ASSERT( loword( i32 ) = &h7788 )
		CU_ASSERT( loword( i64 ) = &h7788 )
		CU_ASSERT( loword( i   ) = &h7788 )

		CU_ASSERT( hiword( i8  ) =      0 )
		CU_ASSERT( hiword( i16 ) =      0 )
		CU_ASSERT( hiword( i32 ) = &h5566 )
		CU_ASSERT( hiword( i64 ) = &h5566 )
		CU_ASSERT( hiword( i   ) = &h5566 )
	END_TEST

END_SUITE
