#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_init_8 )

	type udt1
		dim as integer i11, i12
		declare constructor()
	end type

	constructor udt1()
	end constructor

	type udt2 extends udt1
		dim as integer i21, i22, i23, i24
	end type

	type udt3 extends udt2
		dim as integer i31, i32, i33
	end type

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

	constructor udt4 _
		( _
			byref u3 as udt3, _
			byval i10 as integer _
		)
		base(u3)
		'' cast(udt3, this) = u3
		this.i41 = i10
	end constructor

	#include once "udt-init-check.bi"

	TEST( full_init )

		dim as udt1 u11
		u11.i11 = 1 : u11.i12 = 2
		check1( u11 )

		dim as udt2 u21
		cast(udt1, u21) = u11 : u21.i21 = 3 : u21.i22 = 4 : u21.i23 = 5 : u21.i24 = 6
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

		dim as udt4 u41 =  udt4(u31, 10)
		check4( u41 )

	END_TEST

END_SUITE
