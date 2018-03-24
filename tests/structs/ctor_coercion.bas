#include "fbcunit.bi"

SUITE( fbc_tests.structs.ctor_coercion )

	enum BAR_TYPE
		BAR_B
		BAR_S
		BAR_I
		BAR_L
		BAR_F
		BAR_D
	end enum

	const TEST_B as byte = 123
	const TEST_S as short = 5678
	const TEST_I as integer = 12356789
	const TEST_L as longint = 12356789012
	const TEST_F as single = 1234.5
	const TEST_D as double = 12345678.9

	type bar
		t as BAR_TYPE = any
		
		union
			b as byte
			s as short
			i as integer
			l as longint
			f as single
			d as double
		end union
		
		declare constructor( byval v as byte )
		declare constructor( byval v as short )
		declare constructor( byval v as integer )
		declare constructor( byval v as longint )
		declare constructor( byval v as single )
		declare constructor( byval v as double )
		
	end type

	constructor bar( byval v as byte )
		t = BAR_B
		b = v
	end constructor

	constructor bar( byval v as short )
		t = BAR_S
		s = v
	end constructor

	constructor bar( byval v as integer )
		t = BAR_I
		i = v
	end constructor

	constructor bar( byval v as longint )
		t = BAR_L
		l = v
	end constructor

	constructor bar( byval v as single )
		t = BAR_F
		f = v
	end constructor

	constructor bar( byval v as double )
		t = BAR_D
		d = v
	end constructor

	#macro test_chk(tp)
		CU_ASSERT_EQUAL( tp.t, BAR_##tp )
		CU_ASSERT_EQUAL( tp.##tp, TEST_##tp )
	#endmacro

	TEST( all )
		
		dim as bar b = TEST_B
		test_chk(b)
		
		dim as bar s = TEST_S
		test_chk(s)

		dim as bar i = TEST_I
		test_chk(i)

		dim as bar l = TEST_L
		test_chk(l)

		dim as bar f = TEST_F
		test_chk(f)

		dim as bar d = TEST_D
		test_chk(d)

	END_TEST
	
END_SUITE
