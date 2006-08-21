# include "fbcu.bi"



namespace fbc_tests.string_.escape

sub escapeTest cdecl ()
#define d !"\64abc\65"
	const c = d
	dim v as string = d
	static s as zstring * 32 => d
	
	CU_ASSERT( d = !"\64abc\65" )
	CU_ASSERT( c = d )
	CU_ASSERT( v = d )	
	CU_ASSERT( s = d )	
	
end sub

sub noescapeTest cdecl ()
#define d $"\64abc\65"
	const c = d
	dim v as string = d
	static s as zstring * 32 => d

	CU_ASSERT( d = $"\64abc\65" )
	CU_ASSERT( c = d )
	CU_ASSERT( v = d )
	CU_ASSERT( s = d )	
	
end sub

sub numbaseTest cdecl ()
	CU_ASSERT( !"\65\66\67" = "ABC" )
	CU_ASSERT( !"\&h41\&h42\&h43" = "ABC" )
	CU_ASSERT( !"\&o101\&o102\&o103" = "ABC" )
	CU_ASSERT( !"\&b1000001\&b1000010\&b1000011" = "ABC" )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.escape")
	fbcu.add_test("escapeTest", @escapeTest)
	fbcu.add_test("noescapeTest", @noescapeTest)
	fbcu.add_test("numbaseTest", @numbaseTest)

end sub

end namespace
