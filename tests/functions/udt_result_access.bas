# include "fbcu.bi"

namespace fbc_tests.functions.udt_result_access

const TEST_B_X = 123
const TEST_B_Y = -123
const TEST_S_X = 123
const TEST_S_Y = -567
const TEST_I_X = 1234
const TEST_I_Y = -5678
const TEST_L_X = 123456789
const TEST_L_Y = -567890123
const TEST_F_X = 1234.5!
const TEST_F_Y = -5678.9!
const TEST_D_X = 123456.7
const TEST_D_Y = -567890123.4

type b_xy 
    x as byte
    y as byte
end type 

type s_xy 
    x as short
    y as short
end type 

type i_xy 
    x as integer 
    y as integer 
end type 

type l_xy 
    x as longint
    y as longint
end type 

type f_xy 
    x as single
    y as single
end type 

type d_xy 
    x as double
    y as double
end type 

#macro genfunc( tp )
	function tp##_decxy ( byref udt as tp##_xy ) as tp##_xy
	    function = udt
	end function 
#endmacro

genfunc( b )
genfunc( s )
genfunc( i )
genfunc( l )
genfunc( f )
genfunc( d )

#macro gentest( tp, res_type )
	sub test_##tp cdecl ()
	
		dim as tp##_xy array( 0 to 9 )
		dim as res_type res
	
		array(0).x = TEST_##tp##_X
		array(0).y = TEST_##tp##_Y
		
		res = tp##_decxy( array(0) ).x
		CU_ASSERT( res = TEST_##tp##_X )
		
		res = tp##_decxy( array(0) ).y
		CU_ASSERT( res = TEST_##tp##_Y )
		
	end sub
#endmacro

gentest( b, byte )
gentest( s, short )
gentest( i, integer )
gentest( l, longint )
gentest( f, single )
gentest( d, double )

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.udt_result_access")
	fbcu.add_test("test_b", @test_b)
	fbcu.add_test("test_s", @test_s)
	fbcu.add_test("test_i", @test_i)
	fbcu.add_test("test_l", @test_l)
	fbcu.add_test("test_f", @test_f)
	fbcu.add_test("test_d", @test_d)

end sub

end namespace
