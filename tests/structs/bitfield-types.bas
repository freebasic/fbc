#include "fbcunit.bi"

SUITE( fbc_tests.structs.bitfield_types )

	type UDT
		b1 : 1 as byte
		b7 : 7 as byte
		b8 : 8 as byte
		ub1 : 1 as ubyte
		ub7 : 7 as ubyte
		ub8 : 8 as ubyte
		sh1 : 1 as short
		sh15 : 15 as short
		sh16 : 16 as short
		ush1 : 1 as ushort
		ush15 : 15 as ushort
		ush16 : 16 as ushort
		l1 : 1 as long
		l31 : 31 as long
		l32 : 32 as long
		ul1 : 1 as ulong
		ul31 : 31 as ulong
		ul32 : 32 as ulong
		#ifdef __FB_64BIT__
			ll1 : 1 as longint
			ll63 : 63 as longint
			ll64 : 64 as longint
			ull1 : 1 as ulongint
			ull63 : 63 as ulongint
			ull64 : 64 as ulongint
			i1 : 1 as integer
			i63 : 63 as integer
			i64 : 64 as integer
			ui1 : 1 as uinteger
			ui63 : 63 as uinteger
			ui64 : 64 as uinteger
		#else
			'' TODO: 64bit bitfields, once supported on 32bit
			i1 : 1 as integer
			i31 : 31 as integer
			i32 : 32 as integer
			ui1 : 1 as uinteger
			ui31 : 31 as uinteger
			ui32 : 32 as uinteger
		#endif
	end type 

	TEST( all )
		dim x as UDT
		x.b1 = 1
		x.b7 = &h7F
		x.b8 = &hFF
		x.ub1 = 1
		x.ub7 = &h7F
		x.ub8 = &hFF
		x.sh1 = 1
		x.sh15 = &h7FFF
		x.sh16 = &hFFFF
		x.ush1 = 1
		x.ush15 = &h7FFF
		x.ush16 = &hFFFF
		x.l1 = 1
		x.l31 = &h7FFFFFFF
		x.l32 = &hFFFFFFFFu
		x.ul1 = 1
		x.ul31 = &h7FFFFFFF
		x.ul32 = &hFFFFFFFFu
		#ifdef __FB_64BIT__
			x.ll1 = 1
			x.ll63 = &h7FFFFFFFFFFFFFFF
			x.ll64 = &hFFFFFFFFFFFFFFFFu
			x.ull1 = 1
			x.ull63 = &h7FFFFFFFFFFFFFFF
			x.ull64 = &hFFFFFFFFFFFFFFFFu
			x.i1 = 1
			x.i63 = &h7FFFFFFFFFFFFFFF
			x.i64 = &hFFFFFFFFFFFFFFFFu
			x.ui1 = 1
			x.ui63 = &h7FFFFFFFFFFFFFFF
			x.ui64 = &hFFFFFFFFFFFFFFFFu
		#else
			'' TODO: 64bit bitfields, once supported on 32bit
			x.i1 = 1
			x.i31 = &h7FFFFFFF
			x.i32 = &hFFFFFFFFu
			x.ui1 = 1
			x.ui31 = &h7FFFFFFF
			x.ui32 = &hFFFFFFFFu
		#endif

		CU_ASSERT( x.b1 = 1 )
		CU_ASSERT( x.b7 = &h7F )
		CU_ASSERT( x.b8 = &hFF )
		CU_ASSERT( x.ub1 = 1 )
		CU_ASSERT( x.ub7 = &h7F )
		CU_ASSERT( x.ub8 = &hFF )
		CU_ASSERT( x.sh1 = 1 )
		CU_ASSERT( x.sh15 = &h7FFF )
		CU_ASSERT( x.sh16 = &hFFFF )
		CU_ASSERT( x.ush1 = 1 )
		CU_ASSERT( x.ush15 = &h7FFF )
		CU_ASSERT( x.ush16 = &hFFFF )
		CU_ASSERT( x.l1 = 1 )
		CU_ASSERT( x.l31 = &h7FFFFFFF )
		CU_ASSERT( x.l32 = &hFFFFFFFFu )
		CU_ASSERT( x.ul1 = 1 )
		CU_ASSERT( x.ul31 = &h7FFFFFFF )
		CU_ASSERT( x.ul32 = &hFFFFFFFFu )
		#ifdef __FB_64BIT__
			CU_ASSERT( x.ll1 = 1 )
			CU_ASSERT( x.ll63 = &h7FFFFFFFFFFFFFFF )
			CU_ASSERT( x.ll64 = &hFFFFFFFFFFFFFFFFu )
			CU_ASSERT( x.ull1 = 1 )
			CU_ASSERT( x.ull63 = &h7FFFFFFFFFFFFFFF )
			CU_ASSERT( x.ull64 = &hFFFFFFFFFFFFFFFFu )
			CU_ASSERT( x.i1 = 1 )
			CU_ASSERT( x.i63 = &h7FFFFFFFFFFFFFFF )
			CU_ASSERT( x.i64 = &hFFFFFFFFFFFFFFFFu )
			CU_ASSERT( x.ui1 = 1 )
			CU_ASSERT( x.ui63 = &h7FFFFFFFFFFFFFFF )
			CU_ASSERT( x.ui64 = &hFFFFFFFFFFFFFFFFu )
		#else
			'' TODO: 64bit bitfields, once supported on 32bit
			CU_ASSERT( x.i1 = 1 )
			CU_ASSERT( x.i31 = &h7FFFFFFF )
			CU_ASSERT( x.i32 = &hFFFFFFFFu )
			CU_ASSERT( x.ui1 = 1 )
			CU_ASSERT( x.ui31 = &h7FFFFFFF )
			CU_ASSERT( x.ui32 = &hFFFFFFFFu )
		#endif
	END_TEST

END_SUITE
