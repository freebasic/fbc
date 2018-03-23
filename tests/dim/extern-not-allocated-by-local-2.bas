#include "fbcunit.bi"

#include "extern-not-allocated-by-local.bi"

'' See:
''  - extern-not-allocated-by-local.bi
''  - extern-not-allocated-by-local-1.bas
''  - extern-not-allocated-by-local-2.bas

dim should_not_be_allocated_by_local_i1 as integer = 1
dim should_not_be_allocated_by_local_i2 as integer = 2
dim should_not_be_allocated_by_local_i3 as integer = 3
dim should_not_be_allocated_by_local_i4 as integer = 4
dim should_not_be_allocated_by_local_i5 as integer = 5
dim should_not_be_allocated_by_local_i6 as integer = 6
dim should_not_be_allocated_by_local_i7 as integer = 7
dim should_not_be_allocated_by_local_i8 as integer = 8

private sub test_proc
	CU_ASSERT( should_not_be_allocated_by_local_i1 = 1 )
	CU_ASSERT( should_not_be_allocated_by_local_i2 = 2 )
	CU_ASSERT( should_not_be_allocated_by_local_i3 = 3 )
	CU_ASSERT( should_not_be_allocated_by_local_i4 = 4 )
	CU_ASSERT( should_not_be_allocated_by_local_i5 = 5 )
	CU_ASSERT( should_not_be_allocated_by_local_i6 = 6 )
	CU_ASSERT( should_not_be_allocated_by_local_i7 = 7 )
	CU_ASSERT( should_not_be_allocated_by_local_i8 = 8 )
end sub

SUITE( fbc_tests.dim_.extern_not_allocated_by_local_2 )
	TEST( default )
		test_proc
	END_TEST
END_SUITE
