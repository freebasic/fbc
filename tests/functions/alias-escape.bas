# include "fbcunit.bi"

'' An escaped string literal (!"...") used as an ALIAS must be decoded, so
'' the symbol gets the resulting text and not the source spelling.
'' github #475: alias !"\65" produced a symbol named "\65" instead of "A".

SUITE( fbc_tests.functions.alias_escape )

	'' !"\65\76\73\65\83\95\69\83\67" = "ALIAS_ESC"
	sub escapedProc alias !"\65\76\73\65\83\95\69\83\67" ( byval p as integer ptr )
		*p = 1234
	end sub

	'' Only links if the escaped alias above was decoded to the same name
	declare sub plainProc alias "ALIAS_ESC" ( byval p as integer ptr )

	'' same for variables (the case reported in github #475):
	'' !"\65\76\73\65\83\95\69\83\67\95\86" = "ALIAS_ESC_V"
	extern escapedVar alias !"\65\76\73\65\83\95\69\83\67\95\86" as long
	dim escapedVar as long = 42
	extern plainVar alias "ALIAS_ESC_V" as long

	TEST( procedure )
		dim i as integer = 0
		plainProc( @i )
		CU_ASSERT_EQUAL( i, 1234 )
	END_TEST

	TEST( variable )
		CU_ASSERT_EQUAL( plainVar, 42 )
		plainVar = 43
		CU_ASSERT_EQUAL( escapedVar, 43 )
	END_TEST

	'' !"\x41\x42" = "AB": hex escapes
	sub hexProc alias !"\x41\x42\x5F\x45\x53\x43" ( byval p as integer ptr )
		*p = 5678
	end sub
	declare sub hexPlainProc alias "AB_ESC" ( byval p as integer ptr )

	TEST( hexEscapes )
		dim i as integer = 0
		hexPlainProc( @i )
		CU_ASSERT_EQUAL( i, 5678 )
	END_TEST

END_SUITE
