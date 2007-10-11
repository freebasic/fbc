# include "fbcu.bi"




namespace fbc_tests.wstrings.woct_

sub test_long cdecl ()
	const TEST_VAL as ulongint = &o1777777777777777777777ULL
	
	dim as ulongint		n = TEST_VAL
	dim as ulongint		digmax = 8ULL
	dim as integer		i
		
	CU_ASSERT( valulng( "&o" + woct( n ) ) = TEST_VAL )
	
	for i = 1 to ((len( n ) * 8) \ 3) + 0
	    CU_ASSERT( valulng( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
	    digmax *= 8
	next
	
	CU_ASSERT( valulng( "&o" + woct( n, i ) ) = TEST_VAL )
	
end sub

sub test_int cdecl ()
	const TEST_VAL = &o17777777777
	
	dim as uinteger n = TEST_VAL, digmax = 8
	dim as integer i
		
	CU_ASSERT( valuint( "&o" + woct( n ) ) = TEST_VAL )
	
	for i = 1 to ((len( n ) * 8) \ 3) + 0
	    CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
	    digmax *= 8
	next
	
	CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL )
	
end sub

sub test_short cdecl ()
	const TEST_VAL = &o177777
	
	dim as ushort n = TEST_VAL, digmax = 8
	dim as integer i
		
	CU_ASSERT( valuint( "&o" + woct( n ) ) = TEST_VAL )
	
	for i = 1 to ((len( n ) * 8) \ 3) + 0
	    CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
	    digmax *= 8
	next
	
	CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL )
	
end sub

sub test_byte cdecl ()
	const TEST_VAL = &o377
	
	dim as ubyte n = TEST_VAL, digmax = 8
	dim as integer i
		
	CU_ASSERT( valuint( "&o" + woct( n ) ) = TEST_VAL )
	
	for i = 1 to ((len( n ) * 8) \ 3) + 0
	    CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
	    digmax *= 8
	next
	
	CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL )
	
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstrings.woct_")
	fbcu.add_test("test_byte", @test_byte)
	fbcu.add_test("test_short", @test_short)
	fbcu.add_test("test_int", @test_int)
	fbcu.add_test("test_long", @test_long)

end sub

end namespace
