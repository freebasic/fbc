#include "fbcunit.bi"

#include "extern-not-allocated-by-local.bi"

'' Local (scoped) vars should not cause EXTERNs to be allocated, even if
'' shadowing them.

'' See:
''  - extern-not-allocated-by-local.bi
''  - extern-not-allocated-by-local-1.bas
''  - extern-not-allocated-by-local-2.bas

scope
	dim should_not_be_allocated_by_local_i1 as integer = -1
	static should_not_be_allocated_by_local_i2 as integer = -2
end scope

private sub test_proc
	dim should_not_be_allocated_by_local_i3 as integer = -3
	static should_not_be_allocated_by_local_i4 as integer = -4

	scope
		dim should_not_be_allocated_by_local_i5 as integer = -5
		static should_not_be_allocated_by_local_i6 as integer = -6
	end scope

	CU_ASSERT( should_not_be_allocated_by_local_i1 = 1 )
	CU_ASSERT( should_not_be_allocated_by_local_i2 = 2 )
	CU_ASSERT( should_not_be_allocated_by_local_i3 = -3 )  '' shadowed
	CU_ASSERT( should_not_be_allocated_by_local_i4 = -4 )  '' shadowed
	CU_ASSERT( should_not_be_allocated_by_local_i5 = 5 )
	CU_ASSERT( should_not_be_allocated_by_local_i6 = 6 )
	CU_ASSERT( should_not_be_allocated_by_local_i7 = 7 )
	CU_ASSERT( should_not_be_allocated_by_local_i8 = 8 )

	dim should_not_be_allocated_by_local_i7 as integer = -7
	static should_not_be_allocated_by_local_i8 as integer = -8
end sub

SUITE( fbc_tests.dim_.extern_not_allocated_by_local_1 )
	TEST( default )
		test_proc
	END_TEST
END_SUITE
