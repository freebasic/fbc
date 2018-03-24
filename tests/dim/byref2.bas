#include "fbcunit.bi"
#include "byref-common.bi"

namespace externs

	'' namespace externs is in the global namespace;
	'' we want the test to be independent of the fbcunit framework
	'' See:
	''	- byref.bas
	''  - byref2.bas
	''  - byref-common.bi

	dim shared i as integer = &hEE112233
	dim shared byref ri as integer = i
	dim shared SomeUDT.i as integer = &hEE445566
	dim shared byref SomeUDT.ri as integer = SomeUDT.i

end namespace

SUITE( fbc_tests.dim_.byref2_ )

	using externs

	TEST( default )
		CU_ASSERT( @ri = @i )
		CU_ASSERT( @SomeUDT.ri = @SomeUDT.i )
		CU_ASSERT( i  = &hEE112233 )
		CU_ASSERT( ri = &hEE112233 )
		CU_ASSERT( SomeUDT.i  = &hEE445566 )
		CU_ASSERT( SomeUDT.ri = &hEE445566 )
	END_TEST

END_SUITE
