#include "fbcunit.bi"

'' gas64: a BYTE, UBYTE, SHORT or USHORT argument passed in a register
'' was moved only into the low 8 or 16 bits (mov cl, ...), so the other
'' bits of the register kept an old value. Callers must extend it to 32
'' bits (sign for BYTE/SHORT, zero for UBYTE/USHORT/BOOLEAN): C code
'' compiled by gcc or clang reads the whole 32-bit register.

#if defined( __FB_64BIT__ ) and (__FB_BACKEND__ = "gas64")

SUITE( fbc_tests.functions.gas64_arg_byte_short )

	'' the callee reads the whole 32-bit register
	private function takeL cdecl( byval x as long ) as long
		function = x
	end function

	private function take2L cdecl( byval x as long, byval y as long ) as long
		function = y
	end function

	type FnB as function cdecl( byval as byte ) as long
	type FnUB as function cdecl( byval as ubyte ) as long
	type FnS as function cdecl( byval as short ) as long
	type FnUS as function cdecl( byval as ushort ) as long
	type FnBool as function cdecl( byval as boolean ) as long
	type Fn2S as function cdecl( byval as long, byval as short ) as long

	'' put a pattern in the argument registers, like a value left there
	'' by earlier code (not all 0 or all 1: a sign or zero extension
	'' could then look right by chance)
	#macro hDirtyRegs()
		asm
			mov rcx, 0x5555555555555555
			mov rdx, 0x5555555555555555
			mov rdi, 0x5555555555555555
			mov rsi, 0x5555555555555555
		end asm
	#endmacro

	TEST( variables )
		dim as FnB pb = cast( any ptr, @takeL )
		dim as FnUB pub = cast( any ptr, @takeL )
		dim as FnS ps = cast( any ptr, @takeL )
		dim as FnUS pus = cast( any ptr, @takeL )
		dim as FnBool pbool = cast( any ptr, @takeL )
		dim as Fn2S p2s = cast( any ptr, @take2L )

		dim as byte b = -2
		dim as ubyte ub = 200
		dim as short s = -3
		dim as ushort us = 60000
		dim as boolean t = true
		dim as long r

		hDirtyRegs()
		r = pb( b )
		CU_ASSERT_EQUAL( r, -2 )

		hDirtyRegs()
		r = pub( ub )
		CU_ASSERT_EQUAL( r, 200 )

		hDirtyRegs()
		r = ps( s )
		CU_ASSERT_EQUAL( r, -3 )

		hDirtyRegs()
		r = pus( us )
		CU_ASSERT_EQUAL( r, 60000 )

		hDirtyRegs()
		r = pbool( t )
		CU_ASSERT_EQUAL( r, 1 )

		hDirtyRegs()
		r = p2s( 7, s )
		CU_ASSERT_EQUAL( r, -3 )
	END_TEST

	TEST( arrayElements )
		dim as FnB pb = cast( any ptr, @takeL )
		dim as FnUS pus = cast( any ptr, @takeL )

		dim as byte barr(0 to 1) = { -5, 6 }
		dim as ushort usarr(0 to 1) = { 1, 65535 }
		dim as integer i = 0
		dim as long r

		hDirtyRegs()
		r = pb( barr(i) )
		CU_ASSERT_EQUAL( r, -5 )

		i = 1
		hDirtyRegs()
		r = pus( usarr(i) )
		CU_ASSERT_EQUAL( r, 65535 )
	END_TEST

END_SUITE

#endif
