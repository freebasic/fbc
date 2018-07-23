#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.casting )
	
	type foo
		pad as byte
		as integer vi1, vi2
		as short vs1, vs2
		as byte vb1, vb2
	end type

	TEST( variable )
		dim as integer vi1 = -1, vi2 = 4
		CU_ASSERT( cunsg(vi1 * 2) > cunsg(vi2) )

		dim as short vs1 = -1, vs2 = 4
		CU_ASSERT( cunsg(vs1 * 2) > cunsg(vs2) )

		dim as byte vb1 = -1, vb2 = 4
		CU_ASSERT( cunsg(vb1 * 2) > cunsg(vb2) )
			
	END_TEST

	TEST( udt )
		dim as foo f
		
		f.vi1 = -1: f.vi2 = 4
		CU_ASSERT( cunsg(f.vi1 * 2) > cunsg(f.vi2) )

		f.vs1 = -1: f.vs2 = 4
		CU_ASSERT( cunsg(f.vs1 * 2) > cunsg(f.vs2) )

		f.vb1 = -1: f.vb2 = 4
		CU_ASSERT( cunsg(f.vb1 * 2) > cunsg(f.vb2) )
			
	END_TEST

	TEST( udt_pointer )
		dim as foo f
		dim as foo ptr pf = @f
		
		f.vi1 = -1: f.vi2 = 4
		CU_ASSERT( cunsg(pf->vi1 * 2) > cunsg(pf->vi2) )

		f.vs1 = -1: f.vs2 = 4
		CU_ASSERT( cunsg(pf->vs1 * 2) > cunsg(pf->vs2) )

		f.vb1 = -1: f.vb2 = 4
		CU_ASSERT( cunsg(pf->vb1 * 2) > cunsg(pf->vb2) )
			
	END_TEST

END_SUITE
