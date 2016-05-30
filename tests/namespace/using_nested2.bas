# include "fbcu.bi"

namespace fbc_tests.ns.using_nested2

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
	
	sub test_1 cdecl	
		ns_b.inner.func()
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.namespace.using_nested2")
		fbcu.add_test("#1", @test_1)
		
	end sub

end namespace		