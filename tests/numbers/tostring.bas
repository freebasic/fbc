# include "fbcu.bi"

namespace fbc_tests.numbers.tostring

private sub testSingle cdecl( )
	dim as single v1, v2
	v1 = csng( 1.234567 )
	v2 = val( "1.234567" )
	CU_ASSERT( v1 = v2 )

	v1 =       1.234567f
	v2 = val( "1.234567" )
	CU_ASSERT( v1 = v2 )

	v1 =       1.234567890123456
	v2 = val( "1.234567890123456" )
	CU_ASSERT( v1 = v2 )
end sub

private sub testDouble cdecl( )
	dim as double v1, v2
	v1 =       1.234567890123456
	v2 = val( "1.234567890123456" )
	CU_ASSERT( v1 = v2 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/numbers/tostring" )
	fbcu.add_test( "SINGLE", @testSingle )
	fbcu.add_test( "DOUBLE", @testDouble )
end sub

end namespace
