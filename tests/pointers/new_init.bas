# include "fbcu.bi"

namespace fbc_tests.pointers.new_init

	sub test_stuff cdecl( )
		
		var a = new integer( 5 )
		var b = new short( -15 )
		var c = new single( 2.5 )
		var d = new double( 0.5 )

		CU_ASSERT_EQUAL( *a, 5 )
		CU_ASSERT_EQUAL( *b, -15 )
		CU_ASSERT_EQUAL( *c, 2.5 )
		CU_ASSERT_EQUAL( *d, 0.5 )

		delete a
		delete b
		delete c
		delete d
	
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.pointers.new_init")
		fbcu.add_test("New with initializer", @test_stuff)
	
	end sub

end namespace
