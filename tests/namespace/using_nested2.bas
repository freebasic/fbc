# include "fbcunit.bi"

SUITE( fbc_tests.namespace_.using_nested2 )

	namespace ns_a
		dim as integer foo = 1
		dim as integer bar = 1
	end namespace
	
		dim shared as integer foo = 2
	
	namespace ns_b
		dim as integer bar = 2
		namespace inner
			sub func()
				using ns_a
				CU_ASSERT_EQUAL( foo, 2 )
				CU_ASSERT_EQUAL( bar, 2 )
			end sub
		end namespace
	end namespace
	
	TEST( all )
		ns_b.inner.func()
	END_TEST
	
END_SUITE
