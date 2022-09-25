#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_init_1 )

	type udt1
		dim as integer i11, i12
	end type

	type udt2 extends udt1
		dim as integer i21, i22, i23, i24
	end type

	type udt3 extends udt2
		dim as integer i31, i32, i33
	end type

	type udt4 extends udt3
		dim as integer i41
	end type

	#include once "udt-init-check.bi"

	TEST( full_init )

		'' UDT1
		dim as udt1 u1
		check1_zero( u1 )

		u1 = type<udt1>(1, 2)
		check1( u1 )

		'' UDT2
		dim as udt2 u20, u2
		check2_zero( u20 )
		check2_zero( u2 )

		u2 = u20 : check2_zero( u2 )

		u2 = type<udt2>(1, 2, 3, 4, 5, 6)
		check2( u2 )

		u2 = u20 : check2_zero( u2 )
		u2 = type<udt2>(type<udt1>(1, 2), 3, 4, 5, 6)
		check2( u2 )

		u2 = u20 : check2_zero( u2 )
		u2 = type<udt2>(u1, 3, 4, 5, 6)
		check2( u2 )

		u2 = u20 : check2_zero( u2 )
		u2 = type<udt2>(1, 2, 3, 4, 5, 6)
		check2( u2 )

		'' UDT3
		dim as udt3 u30, u3
		check3_zero( u30 )
		check3_zero( u3 )

		u3 = u30 : check3_zero( u3 )
		u3 = type<udt3>(1, 2, 3, 4, 5, 6, 7, 8, 9)
		check3( u3 )

		u3 = u30 : check3_zero( u3 )
		u3 = type<udt3>(type<udt2>(1, 2, 3, 4, 5, 6), 7, 8, 9)
		check3( u3 )

		u3 = u30 : check3_zero( u3 )
		u3 = type<udt3>(type<udt2>(type<udt1>(1, 2), 3, 4, 5, 6), 7, 8, 9)
		check3( u3 )

		u3 = u30 : check3_zero( u3 )
		u3 = type<udt3>(u2, 7, 8, 9)
		check3( u3 )

		u3 = u30 : check3_zero( u3 )
		u3 = type<udt3>(type<udt2>(u1, 3, 4, 5, 6), 7, 8, 9)
		check3( u3 )

		u3 = u30 : check3_zero( u3 )
		u3 = type<udt3>(1, 2, 3, 4, 5, 6, 7, 8, 9)
		check3( u3 )

		'' UDT4
		dim as udt4 u40, u4
		check4_zero( u40 )
		check4_zero( u4 )

		u4 = u40 : check4_zero( u4 )
		u4 = type<udt4>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
		check4( u4 )

		u4 = u40 : check4_zero( u4 )
		u4 = type<udt4>(type<udt3>(1, 2, 3, 4, 5, 6, 7, 8, 9), 10)
		check4( u4 )

		u4 = u40 : check4_zero( u4 )
		u4 = type<udt4>(type<udt3>(type<udt2>(1, 2, 3, 4, 5, 6), 7, 8, 9), 10)
		check4( u4 )

		u4 = u40 : check4_zero( u4 )
		u4 = type<udt4>(type<udt3>(type<udt2>(type<udt1>(1, 2), 3, 4, 5, 6), 7, 8, 9), 10)
		check4( u4 )

		u4 = u40 : check4_zero( u4 )
		u4 = type<udt4>(u3, 10)
		check4( u4 )

		u4 = u40 : check4_zero( u4 )
		u4 = type<udt4>(type<udt3>(u2, 7, 8, 9), 10)
		check4( u4 )

		u4 = u40 : check4_zero( u4 )
		u4 = type<udt4>(type<udt3>(type<udt2>(u1, 3, 4, 5, 6), 7, 8, 9), 10)
		check4( u4 )

	END_TEST

END_SUITE
