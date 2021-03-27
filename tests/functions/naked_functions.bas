# include "fbcunit.bi"

#if (defined(__FB_X86__)) and (not defined(__FB_64BIT__))
#if (__FB_BACKEND__ = "gas") or (__FB_BACKEND__ = "gcc")

SUITE( fbc_tests.functions.naked_functions )

	'' -gen gcc regression test: naked functions could end up in .data instead of
	'' .text if we had an initialized global var in the same module and gcc emitted
	'' it at the top.
	dim shared foo as integer = 123

	function add_cdecl naked cdecl( byval a as integer, byval b as integer ) as integer
		#if __FB_ASM__ = "att"
			#assert __FB_BACKEND__ = "gcc"
			asm
				"mov 4(%esp), %eax"
				"add 8(%esp), %eax"
				"ret"
			end asm
		#else
			asm
				mov eax, dword ptr [esp+4]
				add eax, dword ptr [esp+8]
				ret
			end asm
		#endif
	end function

	TEST( default )
		CU_ASSERT_EQUAL( add_cdecl( 3, 7 ), 10 )
		CU_ASSERT( foo = 123 ) '' Ensure "foo" is referenced and will be emitted by fbc
	END_TEST

END_SUITE

#endif
#endif
