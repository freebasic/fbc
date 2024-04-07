#include "fbcunit.bi"

#if __FB_ASM__ = "intel"

dim shared f1calls as integer

sub quirk_inline_asm_f1 cdecl alias "quirk_inline_asm_f1"()
	f1calls += 1
end sub

private sub test_proc
	CU_ASSERT( f1calls = 0 )
	asm call quirk_inline_asm_f1
	CU_ASSERT( f1calls = 1 )

	dim f1address as any ptr
	asm
		#ifdef __FB_64BIT__
			'' use RIP-relative addressing.  If quirk_inline_asm_f1 is located
			'' above 2GB then 'mov rax, offset quirk_inline_asm_f1' will
			'' generate a link time error only 32-bits are reserved and the
			'' address can't be correctly sign extended to 64-bit
			lea rax, offset quirk_inline_asm_f1[rip]
			mov [f1address], rax
		#else
			mov eax, offset quirk_inline_asm_f1
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
