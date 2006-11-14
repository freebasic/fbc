# include once "fbcu.bi"

namespace fbc_tests.string_.init

Type foo
	As String one, two, three
	declare operator let( byref as foo )
End Type

sub test cdecl ()
	dim As foo bar
	
	with bar
		.one = "1"
		.two = "2"
		.three = "2"
	end with

	Dim As String Array(0 to 2) = { bar.one, bar.two, bar.three }
	
	CU_ASSERT_EQUAL( array(0), bar.one )
	CU_ASSERT_EQUAL( array(1), bar.two )
	CU_ASSERT_EQUAL( array(2), bar.three )
	
end sub
	
sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.init")
	fbcu.add_test("test", @test)

end sub

end namespace
