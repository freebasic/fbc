# include "fbcu.bi"

namespace fbc_tests.structs.init_union
	
	Type foo
		
		As Integer a
		
		Union
			As Integer i
			as double d
		End Union
		
		As Integer c
		
	End Type
	
	sub test cdecl( )
		
		Dim As foo baz = ( 1, 2, 3 )
		
		CU_ASSERT_EQUAL( baz.a, 1 )
		CU_ASSERT_EQUAL( baz.i, 2 )
		CU_ASSERT( abs(baz.d - 9.881312916824931e-324) < .0001 )
		CU_ASSERT_EQUAL( baz.c, 3 )
		
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.structs.init_union")
		fbcu.add_test("test", @test)
	
	end sub
		
end namespace