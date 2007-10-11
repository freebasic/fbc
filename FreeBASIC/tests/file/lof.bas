# include "fbcu.bi"

#include "vbcompat.bi"

namespace fbc_tests.file.lof_

const filename = "./file/lof.bas"

sub test cdecl ()

	if open( filename, for binary, access read, as #1 ) = 0 then
		CU_ASSERT_EQUAL( lof(1), FileLen( filename ) )
		close #1
	else
		CU_FAIL( "file not found" )
	end if

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.file.lof")
	fbcu.add_test("1", @test)
	
end sub

end namespace
