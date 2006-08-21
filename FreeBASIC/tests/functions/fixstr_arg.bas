# include "fbcu.bi"




namespace fbc_tests.functions.array_recursion

const TEST_LC = "hello!"
const TEST_UC = "HELLO!"

sub ucaseme(s as string)
	s = ucase( s )
end sub


sub test_1 cdecl ()
	dim as string * 20 s
	
	s = TEST_LC
	ucaseme( s )
	CU_ASSERT( s = TEST_UC )
	
end sub	

type foo
	f1 as integer
 	s as string * 20
end type

sub test_2 cdecl ()
	dim as foo f(0)
	
	f(0).s = TEST_LC
	ucaseme( f(0).s )
	CU_ASSERT( f(0).s = TEST_UC )
	
end sub	

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.array_recursion")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)

end sub

end namespace
