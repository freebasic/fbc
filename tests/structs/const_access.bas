# include "fbcu.bi"

namespace fbc_tests.structs.const_acc

type foo
	const const_i = 1
	const const_d = 2.5
	
	enum enum_1
		value_1 = 1234	
		value_2 = -5678
	end enum
	
	as integer pad
end type

sub test_1 cdecl ()
	dim f as foo ptr = new foo
	
	CU_ASSERT_EQUAL( f->const_i, 1 )
	CU_ASSERT_EQUAL( f->const_d, 2.5 )
	CU_ASSERT_EQUAL( f->value_1, 1234 )
	CU_ASSERT_EQUAL( f->value_2, -5678 )
	
	delete (f)
	
end sub

sub test_2 cdecl ()
	dim f as foo
	
	CU_ASSERT_EQUAL( f.const_i, 1 )
	CU_ASSERT_EQUAL( f.const_d, 2.5 )
	CU_ASSERT_EQUAL( f.value_1, 1234 )
	CU_ASSERT_EQUAL( f.value_2, -5678 )
	
end sub

sub test_3 cdecl ()
	dim f as foo ptr = new foo
	
	CU_ASSERT_EQUAL( f[0].const_i, 1 )
	CU_ASSERT_EQUAL( f[0].const_d, 2.5 )
	CU_ASSERT_EQUAL( f[0].value_1, 1234 )
	CU_ASSERT_EQUAL( f[0].value_2, -5678 )
	
	delete (f)
	
end sub

sub test_4 cdecl ()
	dim f as foo
	
	with f
		CU_ASSERT_EQUAL( .const_i, 1 )
		CU_ASSERT_EQUAL( .const_d, 2.5 )
		CU_ASSERT_EQUAL( .value_1, 1234 )
		CU_ASSERT_EQUAL( .value_2, -5678 )
	end with
	
end sub

function ret_foo () as foo
	return type<foo>( 0 )
end function

sub test_5 cdecl ()
	
	CU_ASSERT_EQUAL( ret_foo().const_i, 1 )
	CU_ASSERT_EQUAL( ret_foo().const_d, 2.5 )
	CU_ASSERT_EQUAL( ret_foo().value_1, 1234 )
	CU_ASSERT_EQUAL( ret_foo().value_2, -5678 )
	
end sub

function ret_pfoo () as foo ptr
	static as foo sf
	return @sf
end function

sub test_6 cdecl ()
	
	CU_ASSERT_EQUAL( ret_pfoo()->const_i, 1 )
	CU_ASSERT_EQUAL( ret_pfoo()->const_d, 2.5 )
	CU_ASSERT_EQUAL( ret_pfoo()->value_1, 1234 )
	CU_ASSERT_EQUAL( ret_pfoo()->value_2, -5678 )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.const_access")
	fbcu.add_test("1", @test_1)
	fbcu.add_test("2", @test_2)
	fbcu.add_test("3", @test_3)
	fbcu.add_test("4", @test_4)
	fbcu.add_test("5", @test_5)
	fbcu.add_test("6", @test_6)

end sub
	
end namespace