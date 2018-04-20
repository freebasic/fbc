# include "fbcunit.bi"

SUITE( fbc_tests.functions.module_ctor_staticmemberproc )

	type UDT
		dummy as integer

		static as integer i1, i2

		declare static sub ctor1( )
		declare static sub ctor2( )
	end type

	dim as integer UDT.i1, UDT.i2

	static sub UDT.ctor1( ) constructor
		i1 = 111
	end sub

	sub UDT.ctor2( ) constructor
		i2 = 222
	end sub

	TEST( default )
		CU_ASSERT( UDT.i1 = 111 )
		CU_ASSERT( UDT.i2 = 222 )
	END_TEST

END_SUITE
