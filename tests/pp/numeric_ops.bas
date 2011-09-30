#include "fbcu.bi"

namespace fbc_tests.pp.numeric_ops

	sub test cdecl ( )
		#if (1 + 2 + 3) <> 6
			CU_ASSERT(0)
		#endif
		
		#if (1 + (2 * 3)) <> 7
			CU_ASSERT(0)
		#endif
		
		#if (1 + 2 + 3 - 4) <> 2
			CU_ASSERT(0)
		#endif
		
		#if (1/2) > .49
			CU_ASSERT(0)
		#endif
		
		#if (10\5) <> 2
			CU_ASSERT(0)
		#endif
		
	end sub
		
	private sub ctor () constructor
	
	  fbcu.add_suite("fbc_tests.pp.numeric_ops")
	  fbcu.add_test("numeric_ops", @test)
	
	end sub
	
end namespace
