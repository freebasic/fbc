# include "fbcu.bi"
#include "extern-class.bi"

namespace fbc_tests.structs.extern_class

private sub test cdecl( )
	CU_ASSERT( global1.i = 123 )
	CU_ASSERT( fixarray1(0).i = 456 )
	CU_ASSERT( fixarray1(1).i = 789 )

	CU_ASSERT( global2.i = 321 )
	CU_ASSERT( fixarray2(0).i = 321 )
	CU_ASSERT( fixarray2(1).i = 321 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.structs.extern-class-test" )
	fbcu.add_test( "test", @test )
end sub

end namespace
