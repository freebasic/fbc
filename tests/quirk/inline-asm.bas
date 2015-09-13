#include "fbcu.bi"

#ifndef __FB_ARM__
#if __FB_ASM__ = "intel"

dim shared f1calls as integer

sub quirk_inline_asm_f1 cdecl alias "quirk_inline_asm_f1"()
	f1calls += 1
end sub

private sub test cdecl( )
	CU_ASSERT( f1calls = 0 )
	asm call quirk_inline_asm_f1
	CU_ASSERT( f1calls = 1 )

	dim f1address as any ptr
	asm
		#ifdef __FB_64BIT__
			mov rax, offset quirk_inline_asm_f1
			mov [f1address], rax
		#else
			mov eax, offset quirk_inline_asm_f1
			mov [f1address], eax
		#endif
	end asm
	CU_ASSERT( f1address = @quirk_inline_asm_f1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/quirk/inline-asm" )
	fbcu.add_test( "test", @test )
end sub

#endif
#endif
