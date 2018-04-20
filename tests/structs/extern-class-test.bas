#include "fbcunit.bi"
#include "extern-class.bi"

'' See:
''   extern-class.bi
''   extern-class.bas
''   extern-class-test.bas

SUITE( fbc_tests.structs.extern_class_test )

	using extern_class

	TEST( all )
		CU_ASSERT( global1.i = 123 )
		CU_ASSERT( fixarray1(0).i = 456 )
		CU_ASSERT( fixarray1(1).i = 789 )

		CU_ASSERT( global2.i = 321 )
		CU_ASSERT( fixarray2(0).i = 321 )
		CU_ASSERT( fixarray2(1).i = 321 )
	END_TEST

END_SUITE
