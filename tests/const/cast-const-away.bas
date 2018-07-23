# include "fbcunit.bi"

SUITE( fbc_tests.const_.cast_const_away )

	TEST( away )
		dim i as integer = 456
		dim pci as const integer ptr = @i

		CU_ASSERT( *pci = 456 )

		*cptr( integer ptr, pci ) = 123

		CU_ASSERT( *pci = 123 )
	END_TEST

END_SUITE
