# include once "fbcu.bi"

namespace fbc_tests.expressions.op_self

function foo as integer
    static as integer cnt
    function = cnt
    cnt += 1
end function

sub test_1 cdecl ()
	dim as integer bar(0 To 1) = { 1, 1234 }
	
	cu_assert_equal( bar(0), 1 )
	
	bar(foo()) += 1
	
	cu_assert_equal( bar(0), 2 )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc-tests-expressions-op_self")
	fbcu.add_test("test 1", @test_1)

end sub

end namespace 
