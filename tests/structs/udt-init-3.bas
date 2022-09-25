#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_init_3 )

	type udt1
		dim as integer i11, i12
	end type

	type udt2 extends udt1
		dim as integer i21, i22, i23, i24
	end type

	type udt3 extends udt2
		dim as integer i31, i32, i33
		declare constructor _
			( _
				byref u2 as udt2, _
				byval i31 as integer, _
				byval i32 as integer, _
				byval i33 as integer _
			)
	end type

	constructor udt3 _
		( _
			byref u2 as udt2, _
			byval i31 as integer, _
			byval i32 as integer, _
			byval i33 as integer _
		)
		base(u2)
		'' cast(udt2, this) = u2
		this.i31 = i31
		this.i32 = i32
		this.i33 = i33
	end constructor

	#include once "udt-init-check.bi"

	TEST( full_init )

		dim as udt2 u21
		check2_zero( u21 )

		u21.i11 = 1 : u21.i12 = 2 : u21.i21 = 3 : u21.i22 = 4 : u21.i23 = 5 : u21.i24 = 6
		check2( u21 )

		dim as udt2 u2 = u21
		check2( u2 )

		dim as udt3 u3 = udt3(u21, 7, 8, 9)
		check3( u3 )

	END_TEST

END_SUITE
