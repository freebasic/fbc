#include "fbcunit.bi"

'' gas64: 64-bit MOD and \ use a faster 32-bit division when both values
'' fit in 32 bits. It loaded the divisor into rbx, but the prologue did not
'' save rbx, which is callee-saved on x86-64 (linux and windows): the caller
'' got its rbx changed.

#if defined( __FB_64BIT__ ) and (__FB_BACKEND__ = "gas64")

SUITE( fbc_tests.optimizations.gas64_divmod_rbx )

	private function modL cdecl( byval a as longint, byval b as longint ) as longint
		function = a mod b
	end function

	private function divL cdecl( byval a as longint, byval b as longint ) as longint
		function = a \ b
	end function

	private function modUL cdecl( byval a as ulongint, byval b as ulongint ) as ulongint
		function = a mod b
	end function

	private function divUL cdecl( byval a as ulongint, byval b as ulongint ) as ulongint
		function = a \ b
	end function

	'' Call f( a, b ) with a value in rbx, like a caller which keeps
	'' its own value there, and check that rbx is the same after the call
	private sub hCheck( byval f as any ptr, byval a as longint, byval b as longint, byval expected as longint )
		dim as longint rbxbefore = &h123456789ABCDEF, rbxafter, result
		dim as longint arg1 = a, arg2 = b
		dim as any ptr fn = f

		asm
			push rbx
			sub rsp, 40
			mov rbx, [rbxbefore]
			#ifdef __FB_WIN32__
				mov rcx, [arg1]
				mov rdx, [arg2]
			#else
				mov rdi, [arg1]
				mov rsi, [arg2]
			#endif
			call qword ptr [fn]
			mov [rbxafter], rbx
			mov [result], rax
			add rsp, 40
			pop rbx
		end asm

		CU_ASSERT_EQUAL( result, expected )
		CU_ASSERT_EQUAL( rbxafter, rbxbefore )
	end sub

	TEST( longintValues )
		hCheck( @modL, 1000000007, 13, 1000000007 mod 13 )
		hCheck( @divL, 1000000007, 13, 1000000007 \ 13 )
		hCheck( @modL, -1000000007, 13, -1000000007 mod 13 )
		hCheck( @divL, -1000000007, 13, -1000000007 \ 13 )
		'' too big for the 32-bit division
		hCheck( @modL, 10000000000007, 13, 10000000000007 mod 13 )
		hCheck( @divL, 10000000000007, 13, 10000000000007 \ 13 )
	END_TEST

	TEST( ulongintValues )
		hCheck( @modUL, 4000000007, 13, 4000000007 mod 13 )
		hCheck( @divUL, 4000000007, 13, 4000000007 \ 13 )
		hCheck( @modUL, 10000000000007, 13, 10000000000007 mod 13 )
		hCheck( @divUL, 10000000000007, 13, 10000000000007 \ 13 )
	END_TEST

END_SUITE

#endif
