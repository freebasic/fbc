#include "fbcunit.bi"

#if __FB_ASM__ = "intel"

dim shared f1calls as integer

sub quirk_inline_asm_f1 cdecl alias "quirk_inline_asm_f1"()
	f1calls += 1
end sub

private sub test_proc

	#define quirk_name quirk_inline_asm_f1

	#ifndef __FB_64BIT__
		#if __FB_GCC__
			#undef quirk_name
			#define quirk_name _quirk_inline_asm_f1
		#endif
	#endif

	CU_ASSERT( f1calls = 0 )
	asm call quirk_name
	CU_ASSERT( f1calls = 1 )

	dim f1address as any ptr
	asm
		#ifdef __FB_64BIT__
			mov rax, offset quirk_name
			mov [f1address], rax
		#else
			mov eax, offset quirk_name
			mov [f1address], eax
		#endif
	end asm
	CU_ASSERT( f1address = @quirk_inline_asm_f1 )

	goto label2
label1:
	goto label3
label2:
	asm jmp label1
label3:

	'' Inline ASM can contain double quotes etc., and strings in the inline
	'' ASM can contain escape sequences...
	'' This requires the backends to take special care when emitting.
	asm
		jmp ignore
		.ascii $"testing double-quoted string literal, even with \""embedded\"" double quotes and null terminator\0"
		ignore:
	end asm
end sub

SUITE( fbc_tests.quirk.inline_asm )

	'' assuming these tests need to be module level

	TEST( default )
		test_proc
	END_TEST

END_SUITE

#endif
