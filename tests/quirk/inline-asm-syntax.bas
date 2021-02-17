#include "fbcunit.bi"

SUITE( fbc_tests.quirk.inline_asm_syntax )

	TEST( all )
		dim a as long = 1
		dim inc as integer = &hdeadbeef

		CU_ASSERT( a = 1 )

		'' 1. Increment the variable a, testing that the reference to "a" is
		''    expanded to ebp-N (ASM backend) or the mangled name used by the C backend.
		'' 2. Testing that the inc keyword isn't treated as reference to the inc variable,
		''    no matter what backend. (this would produce invalid ASM code)
		#ifndef __FB_X86__
			'' !!! TODO !!! add test for __FB_ARM__
		#else
			'' x86 and x86_64 (The asm code below should work for both, that
			'' makes this test a bit more simple)
			#assert defined(__FB_ASM__)
			#if __FB_ASM__ = "intel"
				'' Classic FB syntax; this also means Intel syntax
				asm
					inc dword ptr [a]
				end asm
			#else
				'' gcc-style syntax (-gen gcc), this also means AT&T syntax
				asm
					"incl %0\n" : "+m" (a) : :
				end asm
			#endif
			CU_ASSERT( a = 2 )
		#endif

	END_TEST

END_SUITE
