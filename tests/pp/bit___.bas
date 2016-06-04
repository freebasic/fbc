# include "fbcu.bi"

namespace fbc_tests.macros.bit___

	sub test_literals cdecl( )
		
		CU_ASSERT( bit( 224, 0 ) = 0 )
		CU_ASSERT( bit( 224, 1 ) = 0 )
		CU_ASSERT( bit( 224, 2 ) = 0 )
		CU_ASSERT( bit( 224, 3 ) = 0 )
		CU_ASSERT( bit( 224, 4 ) = 0 )
		CU_ASSERT( bit( 224, 5 ) = -1 )
		CU_ASSERT( bit( 224, 6 ) = -1 )
		CU_ASSERT( bit( 224, 7 ) = -1 )
		CU_ASSERT( bit( 224, 8 ) = 0 )
		
	end sub
    
    sub test64 cdecl()
        
        for i as integer = 0 to 63
	        for j as integer = 0 to 63
				CU_ASSERT( bit( (1ull shl i), j ) = iif( i = j, -1, 0 ) )
			next
		next
        
        dim as longint ctx = any
        for i as integer = 0 to 63
	        for j as integer = 0 to 63
	        	ctx = 0
	        	ctx = bitset( ctx, j )
				CU_ASSERT( bit( ctx, j ) = -1 )
	        	ctx = bitreset( ctx, j )
				CU_ASSERT( bit( ctx, j ) = 0 )
			next
		next
    
    end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.pp.bit___")
		fbcu.add_test("test_longint_bit", @test64)
		fbcu.add_test("test_literals", @test_literals)

	end sub

end namespace
	