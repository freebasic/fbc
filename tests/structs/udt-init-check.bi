	#macro check1_zero( n )
		CU_ASSERT( n##.i11 = 0 )
		CU_ASSERT( n##.i12 = 0 )
	#endmacro

	#macro check2_zero( n )
		check1_zero( n )
		CU_ASSERT( n##.i21 = 0 )
		CU_ASSERT( n##.i22 = 0 )
		CU_ASSERT( n##.i23 = 0 )
		CU_ASSERT( n##.i24 = 0 )
	#endmacro

	#macro check3_zero( n )
		check2_zero( n )
		CU_ASSERT( n##.i31 = 0 )
		CU_ASSERT( n##.i32 = 0 )
		CU_ASSERT( n##.i33 = 0 )
	#endmacro

	#macro check4_zero( n )
		check3_zero( n )
		CU_ASSERT( n##.i41 = 0 )
	#endmacro

	#macro check1( n )
		CU_ASSERT( n##.i11 = 1 )
		CU_ASSERT( n##.i12 = 2 )
	#endmacro

	#macro check2( n )
		check1( n )
		CU_ASSERT( n##.i21 = 3 )
		CU_ASSERT( n##.i22 = 4 )
		CU_ASSERT( n##.i23 = 5 )
		CU_ASSERT( n##.i24 = 6 )
	#endmacro

	#macro check3( n )
		check2( n )
		CU_ASSERT( n##.i31 = 7 )
		CU_ASSERT( n##.i32 = 8 )
		CU_ASSERT( n##.i33 = 9 )
	#endmacro

	#macro check32( n )
		check2( n )
		CU_ASSERT( n##.i31 = 0 )
		CU_ASSERT( n##.i32 = 0 )
		CU_ASSERT( n##.i33 = 0 )
	#endmacro

	#macro check4( n )
		check3( n )
		CU_ASSERT( n##.i41 = 10 )
	#endmacro
