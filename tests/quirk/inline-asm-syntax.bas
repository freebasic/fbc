#include "fbcu.bi"

private sub test cdecl( )
	dim a as long = 1
	dim inc as integer = &hdeadbeef

	CU_ASSERT( a = 1 )

	'' 1. Increment the variable a, testing that the reference to "a" is
	''    expanded to ebp-N (ASM backend) or the mangled name used by the C backend.
	'' 2. Testing that the inc keyword isn't treated as reference to the inc variable,
	''    no matter what backend. (this would produce invalid ASM code)
	#ifdef __FB_ARM__
		'' TODO
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
	#endif

	CU_ASSERT( a = 2 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.quirk.inline-asm-syntax" )
	fbcu.add_test( "test", @test )
end sub
