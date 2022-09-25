#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_init_2 )

	type udt1
		dim as integer i11, i12
	end type

	type udt2 extends udt1
		dim as integer i21, i22, i23, i24
	end type

	type udt3 extends udt2
		dim as integer i31, i32, i33
		declare constructor()
		declare constructor _
			( _
				byval i11 as integer, _
				byval i12 as integer, _
				byval i21 as integer, _
				byval i22 as integer, _
				byval i23 as integer, _
				byval i24 as integer, _
				byval i31 as integer, _
				byval i32 as integer, _
				byval i33 as integer _
			)
		declare constructor _
			( _
				byref u2 as udt2, _
				byval i31 as integer, _
				byval i32 as integer, _
				byval i33 as integer _
			)
	end type

	constructor udt3()
	end constructor

	constructor udt3 _
		( _
			byval i11 as integer, _
			byval i12 as integer, _
			byval i21 as integer, _
			byval i22 as integer, _
			byval i23 as integer, _
			byval i24 as integer, _
			byval i31 as integer, _
			byval i32 as integer, _
			byval i33 as integer _
		)
		this.i11 = i11
		this.i12 = i12
		this.i21 = i21
		this.i22 = i22
		this.i23 = i23
		this.i24 = i24
		this.i31 = i31
		this.i32 = i32
		this.i33 = i33
	end constructor

	constructor udt3 _
		( _
			byref u2 as udt2, _
			byval i31 as integer, _
			byval i32 as integer, _
			byval i33 as integer _
		)
		cast(udt2, this) = u2
		this.i31 = i31
		this.i32 = i32
		this.i33 = i33
	end constructor

	type udt4 extends udt3
		dim as integer i41
		declare constructor()
		declare constructor _
			( _
				byval i11 as integer, _
				byval i12 as integer, _
				byval i21 as integer, _
				byval i22 as integer, _
				byval i23 as integer, _
				byval i24 as integer, _
				byval i31 as integer, _
				byval i32 as integer, _
				byval i33 as integer, _
				byval i41 as integer _
			)
		declare constructor _
			( _
				byref u3 as udt3, _
				byval i41 as integer _
			)
	end type

	constructor udt4()
	end constructor

	constructor udt4 _
		( _
			byval i11 as integer, _
			byval i12 as integer, _
			byval i21 as integer, _
			byval i22 as integer, _
			byval i23 as integer, _
			byval i24 as integer, _
			byval i31 as integer, _
			byval i32 as integer, _
			byval i33 as integer, _
			byval i41 as integer _
		)
		this.i11 = i11
		this.i12 = i12
		this.i21 = i21
		this.i22 = i22
		this.i23 = i23
		this.i24 = i24
		this.i31 = i31
		this.i32 = i32
		this.i33 = i33
		this.i41 = i41
	end constructor

	constructor udt4 _
		( _
			byref u3 as udt3, _
			byval i41 as integer _
		)
		cast(udt3, this) = u3
		this.i41 = i41
	end constructor

	#include once "udt-init-check.bi"

	TEST( full_init )
		dim as udt1 u1
		check1_zero( u1 )

		u1 = type<udt1>(1, 2)
		check1( u1 )

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

		u2 = type<udt2>(1, 2, 3, 4, 5, 6)
		check2( u2 )

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
