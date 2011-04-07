# include "fbcu.bi"

namespace fbc_tests.functions.naked

	function add_cdecl naked cdecl _
		( _
		byval a as integer, _
		byval b as integer _
		) as integer

		asm
			mov eax, dword ptr [esp+4]
			add eax, dword ptr [esp+8]
			ret
		end asm

	end function

	sub test cdecl ( )

		CU_ASSERT_EQUAL( add_cdecl( 3, 7 ), 10 )

	end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.functions.naked")
		fbcu.add_test("test", @test)
	
	end sub
	
end namespace
