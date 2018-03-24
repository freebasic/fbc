#include "fbcunit.bi"

SUITE( fbc_tests.dim_.extern_procptr )

	'' EXTERN/DIM statements with lots of tokens,
	'' should still compile fine (regression test)
	extern p as function _
		( _
			byval A as integer, _
			byval B as integer, _
			byval C as integer, _
			byval X as integer, _
			byval Y as integer, _
			byval Z as integer, _
			byval L1 as integer, _
			R1 as integer, _
			byval L2 as integer, _
			byval R2 as string _
		) as integer

	dim shared p as function _
		( _
			byval A as integer, _
			byval B as integer, _
			byval C as integer, _
			byval X as integer, _
			byval Y as integer, _
			byval Z as integer, _
			byval L1 as integer, _
			R1 as integer, _
			byval L2 as integer, _
			byval R2 as string _
		) as integer

	private function f _
		( _
			byval A as integer, _
			byval B as integer, _
			byval C as integer, _
			byval X as integer, _
			byval Y as integer, _
			byval Z as integer, _
			byval L1 as integer, _
			R1 as integer, _
			byval L2 as integer, _
			byval R2 as string _
		) as integer
		function = 123
	end function

	TEST( testproc )
		p = @f
		CU_ASSERT( p( 0, 0, 0, 0, 0, 0, 0, 0, 0, "" ) = 123 )
	END_TEST

END_SUITE
