# include "fbcu.bi"

namespace fbc_tests.functions.udt_result

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

namespace simpleUdt

const TEST_X = 1234
const TEST_Y = 5678

type i_xy 
    x as integer 
    y as integer 
end type 

type d_xy 
    x as double
    y as double
end type 

function i_decxy1 ( byref udt as i_xy ) as i_xy
    udt.x -= 1 
    udt.y -= 1 
    function = udt
end function 

function i_decxy2 ( byref udt as i_xy ) as i_xy
    udt.x -= 1 
    udt.y -= 1 
    function = type( udt.x, udt.y )
end function 

function d_decxy1 ( byref udt as d_xy ) as d_xy
    udt.x -= 1 
    udt.y -= 1 
    function = udt
end function 

function d_decxy2 ( byref udt as d_xy ) as d_xy
    udt.x -= 1 
    udt.y -= 1 
    function = type( udt.x, udt.y )
end function 

private sub test1 cdecl( )
	dim as i_xy i_array( 0 to 9 )

	i_array(0).x = TEST_X
	i_array(0).y = TEST_Y
	i_array(0) = i_decxy1( i_array(0) )
	CU_ASSERT( i_array(0).x = TEST_X - 1 )
	CU_ASSERT( i_array(0).y = TEST_Y - 1 )

	i_array(0).x = TEST_X
	i_array(0).y = TEST_Y
	i_array(0) = i_decxy2( i_array(0) )
	CU_ASSERT( i_array(0).x = TEST_X - 1 )
	CU_ASSERT( i_array(0).y = TEST_Y - 1 )
end sub

private sub test2 cdecl( )
	dim as d_xy d_array( 0 to 9 )

	d_array(0).x = TEST_X
	d_array(0).y = TEST_Y
	d_array(0) = d_decxy1( d_array(0) )
	CU_ASSERT( d_array(0).x = TEST_X - 1 )
	CU_ASSERT( d_array(0).y = TEST_Y - 1 )

	d_array(0).x = TEST_X
	d_array(0).y = TEST_Y
	d_array(0) = d_decxy2( d_array(0) )
	CU_ASSERT( d_array(0).x = TEST_X - 1 )
	CU_ASSERT( d_array(0).y = TEST_Y - 1 )
end sub

end namespace

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

namespace complexUdt1

dim shared as integer ctorcount

type UDT
	i as integer
	declare constructor( )
end type

constructor UDT( )
	ctorcount += 1
end constructor

function f( ) as UDT
	'' neither FUNCTION= nor RETURN used,
	'' result should still be constructed
end function

private sub test cdecl( )
	dim as UDT x
	CU_ASSERT( ctorcount = 1 )
	x = f( )
	CU_ASSERT( ctorcount = 2 )
end sub

end namespace

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.functions.udt-result" )
	fbcu.add_test( "simple UDT #1", @simpleUdt.test1 )
	fbcu.add_test( "simple UDT #2", @simpleUdt.test2 )
	fbcu.add_test( "complex UDT #1", @complexUdt1.test )
end sub

end namespace
