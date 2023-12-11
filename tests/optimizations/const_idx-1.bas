#include "fbcunit.bi"

'' test constant index

SUITE( fbc_tests.optimizations.const_idx_1 )

	type T1
		n0 as ubyte
	end type
	type T2
		n0 as ubyte
		n1 as ubyte
	end type
	type T3
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
	end type
	type T4
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
	end type
	type T5
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
	end type
	type T6
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
	end type
	type T7
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
	end type
	type T8
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
		n7 as ubyte
	end type
	type T9
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
		n7 as ubyte
		n8 as ubyte
	end type
	type T10
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
		n7 as ubyte
		n8 as ubyte
		n9 as ubyte
	end type
	type T11
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
		n7 as ubyte
		n8 as ubyte
		n9 as ubyte
		n10 as ubyte
	end type
	type T12
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
		n7 as ubyte
		n8 as ubyte
		n9 as ubyte
		n10 as ubyte
		n11 as ubyte
	end type
	type T13
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
		n7 as ubyte
		n8 as ubyte
		n9 as ubyte
		n10 as ubyte
		n11 as ubyte
		n12 as ubyte
	end type
	type T14
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
		n7 as ubyte
		n8 as ubyte
		n9 as ubyte
		n10 as ubyte
		n11 as ubyte
		n12 as ubyte
		n13 as ubyte
	end type
	type T15
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
		n7 as ubyte
		n8 as ubyte
		n9 as ubyte
		n10 as ubyte
		n11 as ubyte
		n12 as ubyte
		n13 as ubyte
		n14 as ubyte
	end type
	type T16
		n0 as ubyte
		n1 as ubyte
		n2 as ubyte
		n3 as ubyte
		n4 as ubyte
		n5 as ubyte
		n6 as ubyte
		n7 as ubyte
		n8 as ubyte
		n9 as ubyte
		n10 as ubyte
		n11 as ubyte
		n12 as ubyte
		n13 as ubyte
		n14 as ubyte
		n15 as ubyte
	end type

	sub proc1( byval arg as T1, byval n0 as ubyte )
		CU_ASSERT( arg.n0 = n0 )
	end sub
	sub proc2( byval arg as T2, byval n0 as ubyte, byval n1 as ubyte )
		CU_ASSERT( arg.n1 = n1 )
	end sub
	sub proc3( byval arg as T3, byval n0 as ubyte, byval n2 as ubyte )
		CU_ASSERT( arg.n2 = n2 )
	end sub
	sub proc4( byval arg as T4, byval n0 as ubyte, byval n3 as ubyte )
		CU_ASSERT( arg.n3 = n3 )
	end sub
	sub proc5( byval arg as T5, byval n0 as ubyte, byval n4 as ubyte )
		CU_ASSERT( arg.n4 = n4 )
	end sub
	sub proc6( byval arg as T6, byval n0 as ubyte, byval n5 as ubyte )
		CU_ASSERT( arg.n5 = n5 )
	end sub
	sub proc7( byval arg as T7, byval n0 as ubyte, byval n6 as ubyte )
		CU_ASSERT( arg.n6 = n6 )
	end sub
	sub proc8( byval arg as T8, byval n0 as ubyte, byval n7 as ubyte )
		CU_ASSERT( arg.n7 = n7 )
	end sub
	sub proc9( byval arg as T9, byval n0 as ubyte, byval n8 as ubyte )
		CU_ASSERT( arg.n8 = n8 )
	end sub
	sub proc10( byval arg as T10, byval n0 as ubyte, byval n9 as ubyte )
		CU_ASSERT( arg.n9 = n9 )
	end sub
	sub proc11( byval arg as T11, byval n0 as ubyte, byval n10 as ubyte )
		CU_ASSERT( arg.n10 = n10 )
	end sub
	sub proc12( byval arg as T12, byval n0 as ubyte, byval n11 as ubyte )
		CU_ASSERT( arg.n11 = n11 )
	end sub
	sub proc13( byval arg as T13, byval n0 as ubyte, byval n12 as ubyte )
		CU_ASSERT( arg.n12 = n12 )
	end sub
	sub proc14( byval arg as T14, byval n0 as ubyte, byval n13 as ubyte )
		CU_ASSERT( arg.n13 = n13 )
	end sub
	sub proc15( byval arg as T15, byval n0 as ubyte, byval n14 as ubyte )
		CU_ASSERT( arg.n14 = n14 )
	end sub
	sub proc16( byval arg as T16, byval n0 as ubyte, byval n15 as ubyte )
		CU_ASSERT( arg.n15 = n15 )
	end sub

	type C1
		m(0 to 9) as T1
	end type
	type C2
		m(0 to 9) as T2
	end type
	type C3
		m(0 to 9) as T3
	end type
	type C4
		m(0 to 9) as T4
	end type
	type C5
		m(0 to 9) as T5
	end type
	type C6
		m(0 to 9) as T6
	end type
	type C7
		m(0 to 9) as T7
	end type
	type C8
		m(0 to 9) as T8
	end type
	type C9
		m(0 to 9) as T9
	end type
	type C10
		m(0 to 9) as T10
	end type
	type C11
		m(0 to 9) as T11
	end type
	type C12
		m(0 to 9) as T12
	end type
	type C13
		m(0 to 9) as T13
	end type
	type C14
		m(0 to 9) as T14
	end type
	type C15
		m(0 to 9) as T15
	end type
	type C16
		m(0 to 9) as T16
	end type

	dim X1(0 to 9) as T1
	dim X2(0 to 9) as T2
	dim X3(0 to 9) as T3
	dim X4(0 to 9) as T4
	dim X5(0 to 9) as T5
	dim X6(0 to 9) as T6
	dim X7(0 to 9) as T7
	dim X8(0 to 9) as T8
	dim X9(0 to 9) as T9
	dim X10(0 to 9) as T10
	dim X11(0 to 9) as T11
	dim X12(0 to 9) as T12
	dim X13(0 to 9) as T13
	dim X14(0 to 9) as T14
	dim X15(0 to 9) as T15
	dim X16(0 to 9) as T16

	dim shared SX1(0 to 9) as T1
	dim shared SX2(0 to 9) as T2
	dim shared SX3(0 to 9) as T3
	dim shared SX4(0 to 9) as T4
	dim shared SX5(0 to 9) as T5
	dim shared SX6(0 to 9) as T6
	dim shared SX7(0 to 9) as T7
	dim shared SX8(0 to 9) as T8
	dim shared SX9(0 to 9) as T9
	dim shared SX10(0 to 9) as T10
	dim shared SX11(0 to 9) as T11
	dim shared SX12(0 to 9) as T12
	dim shared SX13(0 to 9) as T13
	dim shared SX14(0 to 9) as T14
	dim shared SX15(0 to 9) as T15
	dim shared SX16(0 to 9) as T16

	dim Y1 as C1
	dim Y2 as C2
	dim Y3 as C3
	dim Y4 as C4
	dim Y5 as C5
	dim Y6 as C6
	dim Y7 as C7
	dim Y8 as C8
	dim Y9 as C9
	dim Y10 as C10
	dim Y11 as C11
	dim Y12 as C12
	dim Y13 as C13
	dim Y14 as C14
	dim Y15 as C15
	dim Y16 as C16

	dim shared SY1 as C1
	dim shared SY2 as C2
	dim shared SY3 as C3
	dim shared SY4 as C4
	dim shared SY5 as C5
	dim shared SY6 as C6
	dim shared SY7 as C7
	dim shared SY8 as C8
	dim shared SY9 as C9
	dim shared SY10 as C10
	dim shared SY11 as C11
	dim shared SY12 as C12
	dim shared SY13 as C13
	dim shared SY14 as C14
	dim shared SY15 as C15
	dim shared SY16 as C16

	sub fill( byval start as any ptr, byval elements as long, byval length as long )
		'' fill bytes without using indexing
		dim c as ubyte = 0
		dim p as ubyte ptr = start
		for n as long = 0 to elements*length - 1
			*p = c
			p += 1
			c += 1
		next
	end sub

	TEST( arrays )
		fill( @X1(0), 10, 1 )
		fill( @X2(0), 10, 2 )
		fill( @X3(0), 10, 3 )
		fill( @X4(0), 10, 4 )
		fill( @X5(0), 10, 5 )
		fill( @X6(0), 10, 6 )
		fill( @X7(0), 10, 7 )
		fill( @X8(0), 10, 8 )
		fill( @X9(0), 10, 9 )
		fill( @X10(0), 10, 10 )
		fill( @X11(0), 10, 11 )
		fill( @X12(0), 10, 12 )
		fill( @X13(0), 10, 13 )
		fill( @X14(0), 10, 14 )
		fill( @X15(0), 10, 15 )
		fill( @X16(0), 10, 16 )

		fill( @SX1(0), 10, 1 )
		fill( @SX2(0), 10, 2 )
		fill( @SX3(0), 10, 3 )
		fill( @SX4(0), 10, 4 )
		fill( @SX5(0), 10, 5 )
		fill( @SX6(0), 10, 6 )
		fill( @SX7(0), 10, 7 )
		fill( @SX8(0), 10, 8 )
		fill( @SX9(0), 10, 9 )
		fill( @SX10(0), 10, 10 )
		fill( @SX11(0), 10, 11 )
		fill( @SX12(0), 10, 12 )
		fill( @SX13(0), 10, 13 )
		fill( @SX14(0), 10, 14 )
		fill( @SX15(0), 10, 15 )
		fill( @SX16(0), 10, 16 )

		fill( @Y1, 10, 1 )
		fill( @Y2, 10, 2 )
		fill( @Y3, 10, 3 )
		fill( @Y4, 10, 4 )
		fill( @Y5, 10, 5 )
		fill( @Y6, 10, 6 )
		fill( @Y7, 10, 7 )
		fill( @Y8, 10, 8 )
		fill( @Y9, 10, 9 )
		fill( @Y10, 10, 10 )
		fill( @Y11, 10, 11 )
		fill( @Y12, 10, 12 )
		fill( @Y13, 10, 13 )
		fill( @Y14, 10, 14 )
		fill( @Y15, 10, 15 )
		fill( @Y16, 10, 16 )

		fill( @SY1, 10, 1 )
		fill( @SY2, 10, 2 )
		fill( @SY3, 10, 3 )
		fill( @SY4, 10, 4 )
		fill( @SY5, 10, 5 )
		fill( @SY6, 10, 6 )
		fill( @SY7, 10, 7 )
		fill( @SY8, 10, 8 )
		fill( @SY9, 10, 9 )
		fill( @SY10, 10, 10 )
		fill( @SY11, 10, 11 )
		fill( @SY12, 10, 12 )
		fill( @SY13, 10, 13 )
		fill( @SY14, 10, 14 )
		fill( @SY15, 10, 15 )
		fill( @SY16, 10, 16 )

		fill( @X1(0), 10, 1 )
		fill( @X2(0), 10, 2 )
		fill( @X3(0), 10, 3 )
		fill( @X4(0), 10, 4 )
		fill( @X5(0), 10, 5 )
		fill( @X6(0), 10, 6 )
		fill( @X7(0), 10, 7 )
		fill( @X8(0), 10, 8 )
		fill( @X9(0), 10, 9 )
		fill( @X10(0), 10, 10 )
		fill( @X11(0), 10, 11 )
		fill( @X12(0), 10, 12 )
		fill( @X13(0), 10, 13 )
		fill( @X14(0), 10, 14 )
		fill( @X15(0), 10, 15 )
		fill( @X16(0), 10, 16 )

		fill( @SX1(0), 10, 1 )
		fill( @SX2(0), 10, 2 )
		fill( @SX3(0), 10, 3 )
		fill( @SX4(0), 10, 4 )
		fill( @SX5(0), 10, 5 )
		fill( @SX6(0), 10, 6 )
		fill( @SX7(0), 10, 7 )
		fill( @SX8(0), 10, 8 )
		fill( @SX9(0), 10, 9 )
		fill( @SX10(0), 10, 10 )
		fill( @SX11(0), 10, 11 )
		fill( @SX12(0), 10, 12 )
		fill( @SX13(0), 10, 13 )
		fill( @SX14(0), 10, 14 )
		fill( @SX15(0), 10, 15 )
		fill( @SX16(0), 10, 16 )

		fill( @Y1, 10, 1 )
		fill( @Y2, 10, 2 )
		fill( @Y3, 10, 3 )
		fill( @Y4, 10, 4 )
		fill( @Y5, 10, 5 )
		fill( @Y6, 10, 6 )
		fill( @Y7, 10, 7 )
		fill( @Y8, 10, 8 )
		fill( @Y9, 10, 9 )
		fill( @Y10, 10, 10 )
		fill( @Y11, 10, 11 )
		fill( @Y12, 10, 12 )
		fill( @Y13, 10, 13 )
		fill( @Y14, 10, 14 )
		fill( @Y15, 10, 15 )
		fill( @Y16, 10, 16 )

		fill( @SY1, 10, 1 )
		fill( @SY2, 10, 2 )
		fill( @SY3, 10, 3 )
		fill( @SY4, 10, 4 )
		fill( @SY5, 10, 5 )
		fill( @SY6, 10, 6 )
		fill( @SY7, 10, 7 )
		fill( @SY8, 10, 8 )
		fill( @SY9, 10, 9 )
		fill( @SY10, 10, 10 )
		fill( @SY11, 10, 11 )
		fill( @SY12, 10, 12 )
		fill( @SY13, 10, 13 )
		fill( @SY14, 10, 14 )
		fill( @SY15, 10, 15 )
		fill( @SY16, 10, 16 )

		'' read from array(index)

		dim i as integer = 2

		proc1( X1(i), i*1 )
		proc2( X2(i), i*2, i*2+1 )
		proc3( X3(i), i*3, i*3+2 )
		proc4( X4(i), i*4, i*4+3 )
		proc5( X5(i), i*5, i*5+4 )
		proc6( X6(i), i*6, i*6+5 )
		proc7( X7(i), i*7, i*7+6 )
		proc8( X8(i), i*8, i*8+7 )
		proc9( X9(i), i*9, i*9+8 )
		proc10( X10(i), i*10, i*10+9 )
		proc11( X11(i), i*11, i*11+10 )
		proc12( X12(i), i*12, i*12+11 )
		proc13( X13(i), i*13, i*13+12 )
		proc14( X14(i), i*14, i*14+13 )
		proc15( X15(i), i*15, i*15+14 )
		proc16( X16(i), i*16, i*16+15 )

		proc1( SX1(i), i*1 )
		proc2( SX2(i), i*2, i*2+1 )
		proc3( SX3(i), i*3, i*3+2 )
		proc4( SX4(i), i*4, i*4+3 )
		proc5( SX5(i), i*5, i*5+4 )
		proc6( SX6(i), i*6, i*6+5 )
		proc7( SX7(i), i*7, i*7+6 )
		proc8( SX8(i), i*8, i*8+7 )
		proc9( SX9(i), i*9, i*9+8 )
		proc10( SX10(i), i*10, i*10+9 )
		proc11( SX11(i), i*11, i*11+10 )
		proc12( SX12(i), i*12, i*12+11 )
		proc13( SX13(i), i*13, i*13+12 )
		proc14( SX14(i), i*14, i*14+13 )
		proc15( SX15(i), i*15, i*15+14 )
		proc16( SX16(i), i*16, i*16+15 )

		proc1( Y1.m(i), i*1 )
		proc2( Y2.m(i), i*2, i*2+1 )
		proc3( Y3.m(i), i*3, i*3+2 )
		proc4( Y4.m(i), i*4, i*4+3 )
		proc5( Y5.m(i), i*5, i*5+4 )
		proc6( Y6.m(i), i*6, i*6+5 )
		proc7( Y7.m(i), i*7, i*7+6 )
		proc8( Y8.m(i), i*8, i*8+7 )
		proc9( Y9.m(i), i*9, i*9+8 )
		proc10( Y10.m(i), i*10, i*10+9 )
		proc11( Y11.m(i), i*11, i*11+10 )
		proc12( Y12.m(i), i*12, i*12+11 )
		proc13( Y13.m(i), i*13, i*13+12 )
		proc14( Y14.m(i), i*14, i*14+13 )
		proc15( Y15.m(i), i*15, i*15+14 )
		proc16( Y16.m(i), i*16, i*16+15 )

		proc1( SY1.m(i), i*1 )
		proc2( SY2.m(i), i*2, i*2+1 )
		proc3( SY3.m(i), i*3, i*3+2 )
		proc4( SY4.m(i), i*4, i*4+3 )
		proc5( SY5.m(i), i*5, i*5+4 )
		proc6( SY6.m(i), i*6, i*6+5 )
		proc7( SY7.m(i), i*7, i*7+6 )
		proc8( SY8.m(i), i*8, i*8+7 )
		proc9( SY9.m(i), i*9, i*9+8 )
		proc10( SY10.m(i), i*10, i*10+9 )
		proc11( SY11.m(i), i*11, i*11+10 )
		proc12( SY12.m(i), i*12, i*12+11 )
		proc13( SY13.m(i), i*13, i*13+12 )
		proc14( SY14.m(i), i*14, i*14+13 )
		proc15( SY15.m(i), i*15, i*15+14 )
		proc16( SY16.m(i), i*16, i*16+15 )

	END_TEST

END_SUITE
