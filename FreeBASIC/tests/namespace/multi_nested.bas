

const TEST_VAL = 1234

namespace lev1.lev2.lev3.lev4.lev5

	dim shared as integer value = TEST_VAL

end namespace

	
sub test1	
	CU_ASSERT( lev1.lev2.lev3.lev4.lev5.value = TEST_VAL )
end sub

sub test2
	using lev1
	CU_ASSERT( lev2.lev3.lev4.lev5.value = TEST_VAL )
end sub

sub test3
	using lev1.lev2
	CU_ASSERT( lev3.lev4.lev5.value = TEST_VAL )
end sub

sub test4
	using lev1.lev2.lev3
	CU_ASSERT( lev4.lev5.value = TEST_VAL )
end sub

sub test5
	using lev1.lev2.lev3.lev4
	CU_ASSERT( lev5.value = TEST_VAL )
end sub

sub test6
	using lev1.lev2.lev3.lev4.lev5
	CU_ASSERT( value = TEST_VAL )
end sub


	test1
	test2
	test3
	test4
	test5
	test6
