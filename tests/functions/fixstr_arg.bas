# include "fbcu.bi"

namespace fbc_tests.functions.fixstr_arg

const TEST_LC = "hello!"
const TEST_UC = "HELLO!"

type foo
	f1 as integer
 	s as string * 20
end type

sub ucaseme_ref(byref s as string)
	s = ucase( s )
end sub

sub ucaseme_val(byval s as string)
	s = ucase( s )
end sub

sub test_ref_1 cdecl ()
	dim as string * 20 s
	
	s = TEST_LC
	ucaseme_ref( s )
	CU_ASSERT( s = TEST_UC )
	
end sub	

sub test_val_1 cdecl ()
	dim as string * 20 s
	
	s = TEST_LC
	ucaseme_val( s )
	CU_ASSERT( s = TEST_LC )
	
end sub	

sub test_ref_2 cdecl ()
	dim as foo f(0)
	
	f(0).s = TEST_LC
	ucaseme_ref( f(0).s )
	CU_ASSERT( f(0).s = TEST_UC )
	
end sub	

sub test_val_2 cdecl ()
	dim as foo f(0)
	
	f(0).s = TEST_LC
	ucaseme_val( f(0).s )
	CU_ASSERT( f(0).s = TEST_LC )
	
end sub	

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.fixstr_arg")
	fbcu.add_test("test_ref_1", @test_ref_1)
	fbcu.add_test("test_ref_2", @test_ref_2)
	fbcu.add_test("test_val_1", @test_val_1)
	fbcu.add_test("test_val_2", @test_val_2)

end sub

end namespace
