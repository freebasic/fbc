
# include "fbcu.bi"

namespace fbc_tests.structs.obj_ptr_ini

type foo
	as byte field1
	as short field2
	as integer field3
	as double field4
end type

sub test_1 cdecl
	dim f as foo ptr = new foo(123, 12345, 123456789)
	
	CU_ASSERT_EQUAL( f->field1, 123 )
	CU_ASSERT_EQUAL( f->field2, 12345 )
	CU_ASSERT_EQUAL( f->field3, 123456789 )
	CU_ASSERT_EQUAL( f->field4, 0.0 )
	
	delete f
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-ptr-ini")
	fbcu.add_test( "1", @test_1)

end sub
	
end namespace