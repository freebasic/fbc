# include "fbcu.bi"

namespace fbc_tests.pointers.field_array_desc

type foo
  bar(0 To 2) as integer
end type

sub test cdecl ()

	dim f as foo
	dim pf as foo ptr = @f

  	CU_ASSERT_EQUAL( lbound(pf->bar), 0 )
  	CU_ASSERT_EQUAL( ubound(pf->bar), 2 )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.field_array_desc")
	fbcu.add_test("test", @test)

end sub

end namespace
	
