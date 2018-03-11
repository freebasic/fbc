#include "fbcunit.bi"

SUITE( fbc_tests.expressions.longint_ )

	TEST( regression1 )
		'' Regression test: -gen gas generated bad code for this under -exx
		dim as longint ll1 = 12
		var pll1 = @ll1
		dim as integer i1 = 20, i2 = 0
		'' This and similar expressions showed the problem
		dim as longint ll2 = i1 + (i2 * *pll1)
		CU_ASSERT( ll2 = 20 )

		'' - i1 and i2 will be promoted to LONGINT here
		'' - so, i1 was loaded into eax:ebx (highdword:lowdword)
		'' - and i2 was loaded into ecx:esi
		'' The deref expression *pll1 triggers a call to fb_NullPtrChk() under
		'' -exx, in the middle of the expression. Because some of the used
		'' registers aren't preserved across calls (eax, ecx, edx), ir-tac
		'' decided to move ecx into edi, and eax into a temp var on stack.
		'' Now i1 = tempvar:ebx, i2 = edi:esi.
		'' This is bad because the i1 longint is split up, low dword in
		'' register, high dword in memory. This broke assumptions made by other
		'' ir-tac code, and in the end the high dword was never re-loaded into
		'' a register. Instead ir-tac just acted as if no spilling happened,
		'' and used eax as-is (even though that had been overwritten in the
		'' meantime). This let to the expression returning a longint value with
		'' completely messed up high dword.
	END_TEST

	TEST( regression2 )
		'' Regression test: In the complex expression below involving a
		'' multi-dimensional LONGINT array and LONGINT indices, the ASM backend
		'' accidentially re-used a register used by a LONGINT aux vreg for
		'' another vreg, compromising the result value...
		dim as longint k
		dim as longint n
		dim as longint array(0 to 1, 0 to 1)
		n = 1
		k = 1
		array(1,0) = 1
		CU_ASSERT( array(n,k) + (n-k) * array(n,k-1) = 0 )
	END_TEST

END_SUITE
