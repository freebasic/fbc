# include once "fbcu.bi"




namespace fbc_tests.string_.len_

sub fieldLengthTest cdecl ()
	const strconst = "12345"

	type foo
		zstrfield as zstring * len(strconst)+1
		fstrfield as string * len(strconst)
	end type
	
	dim f as foo
	
	CU_ASSERT_EQUAL( sizeof( f.zstrfield ),len(strconst)+1 )
	
	CU_ASSERT_EQUAL( len( f.fstrfield ), len(strconst) )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.len_")
	fbcu.add_test("field length test", @fieldLengthTest)

end sub

end namespace
