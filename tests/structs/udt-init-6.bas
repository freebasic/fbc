#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_init_6 )

	type udt1
		dim as integer i11, i12
	end type

	type udt2 extends udt1
		dim as integer i21, i22, i23, i24
	end type

	type udt3 extends udt2
		dim as integer i31, i32, i33
		declare constructor()
		declare constructor(byref u3 as udt3)
		declare constructor _
			( _
				byref u2 as udt2, _
				byval i7 as integer = 0, _
				byval i8 as integer = 0, _
				byval i9 as integer = 0 _
			)
	end type

	constructor udt3()
	end constructor

	constructor udt3(byref u3 as udt3)
		this = u3
	end constructor

	constructor udt3 _
		( _
			byref u2 as udt2, _
			byval i7 as integer = 0, _
			byval i8 as integer = 0, _
			byval i9 as integer = 0 _
		)
		cast(udt2, this) = u2
		this.i31 = i7
		this.i32 = i8
		this.i33 = i9
	end constructor

	type udt4 extends udt3
		dim as integer i41
		declare constructor()
		declare constructor _
			( _
				byref u3 as udt3, _
				byval i10 as integer _
			)
	end type

	constructor udt4()
	end constructor

	constructor udt4(byref u3 as udt3, byval i10 as integer)
		base(u3)
		'' cast(udt3, this) = u3
		this.i41 = i10
	end constructor

	#include once "udt-init-check.bi"

	TEST( FULL_INIT )

		dim as udt2 u21 = type<udt2>(1, 2, 3, 4, 5, 6)
		check2( u21 )

		dim as udt3 u31
		cast(udt2, u31) = u21 : u31.i31 = 7 : u31.i32 = 8 : u31.i33 = 9
		check3( u31 )

		dim as udt3 u32 = u31
		check3( u32 )

		dim as udt3 u33 = type<udt3>(u31)
		check3( u33 )

		dim as udt3 u34
		u34 = u31
		check3( u34 )

		dim as udt3 u35
		u35 = type<udt3>(u31)
		check3( u35 )

		dim as udt3 u36
		u36 = type<udt3>(u21)
		check32( u36 )

		dim as udt3 u37 = type<udt3>(u21)
		check32( u37 )

		dim as udt3 u38
		u38 = type<udt3>(u21, 7, 8, 9)
		check3( u38 )

		dim as udt3 u39 = type<udt3>(u21, 7, 8, 9)
		dim as udt3 u3a
		u3a = type<udt3>(type<udt2>(1, 2, 3, 4, 5, 6), 7, 8, 9)
		check3( u3a )

		dim as udt3 u3b = type<udt3>(type<udt2>(1, 2, 3, 4, 5, 6), 7, 8, 9)
		check3( u3b )

		dim as udt3 u3c
		u3c = type<udt3>(type<udt2>(type<udt1>(1, 2), 3, 4, 5, 6), 7, 8, 9)
		check3( u3c )

		dim as udt3 u3d = type<udt3>(type<udt2>(type<udt1>(1, 2), 3, 4, 5, 6), 7, 8, 9)
		check3( u3d )

		dim as udt4 u41 =  udt4(u31, 10)
		check4( u41 )

	END_TEST

END_SUITE
