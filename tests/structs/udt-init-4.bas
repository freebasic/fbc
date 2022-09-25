#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_init_4 )

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
		declare constructor _
			( _
				byref u3 as udt3, _
				byval i41 as integer _
			)
	end type

	constructor udt4 _
		( _
			byref u3 as udt3, _
			byval i41 as integer _
		)
		base(u3)
		'' cast(udt3, this) = u3
		this.i41 = i41
	end constructor

	#include once "udt-init-check.bi"

	TEST( full_init )

		dim as udt3 u31
		check3_zero( u31 )

		u31.i11 = 1 : u31.i12 = 2 : u31.i21 = 3 : u31.i22 = 4 : u31.i23 = 5 : u31.i24 = 6 : u31.i31 = 7 : u31.i32 = 8 : u31.i33 = 9
		check3( u31 )

		dim as udt3 u3 = u31
		check3( u3 )

		dim as udt4 u4 = udt4(u31, 10)
		check4( u4 )

	END_TEST

END_SUITE
