# include "fbcu.bi"



namespace fbc_tests.pointers.casting3

type foo 
  s as string 
  l as longint
end type 

sub test cdecl ()

const TEST_VAL = &hdeadbeefdeadc0de

	dim as foo ptr bar

	bar = allocate( len( foo ) ) 

	bar->l = TEST_VAL

	*cast( byte ptr, @bar->l ) = 0

	CU_ASSERT_EQUAL( bar->l, (TEST_VAL and not 255) )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.casting3")
	fbcu.add_test("test", @test)

end sub

end namespace
