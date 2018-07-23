#include "fbcunit.bi"

'' -gen gcc string literal emitting test

SUITE( fbc_tests.string_.trigraphs )

	dim shared z11 as zstring * 32 => "??="
	dim shared z12 as zstring * 32 => "??/"
	dim shared z13 as zstring * 32 => "??'"
	dim shared z14 as zstring * 32 => "??("
	dim shared z15 as zstring * 32 => "??)"
	dim shared z16 as zstring * 32 => "??!"
	dim shared z17 as zstring * 32 => "??<"
	dim shared z18 as zstring * 32 => "??>"
	dim shared z19 as zstring * 32 => "??-"

	dim shared z21 as zstring * 32 => !"\&h3F?="
	dim shared z22 as zstring * 32 => !"\&h3F?/"
	dim shared z23 as zstring * 32 => !"\&h3F?'"
	dim shared z24 as zstring * 32 => !"\&h3F?("
	dim shared z25 as zstring * 32 => !"\&h3F?)"
	dim shared z26 as zstring * 32 => !"\&h3F?!"
	dim shared z27 as zstring * 32 => !"\&h3F?<"
	dim shared z28 as zstring * 32 => !"\&h3F?>"
	dim shared z29 as zstring * 32 => !"\&h3F?-"

	dim shared z31 as zstring * 32 => !"\&h3F\&h3F="
	dim shared z32 as zstring * 32 => !"\&h3F\&h3F/"
	dim shared z33 as zstring * 32 => !"\&h3F\&h3F'"
	dim shared z34 as zstring * 32 => !"\&h3F\&h3F("
	dim shared z35 as zstring * 32 => !"\&h3F\&h3F)"
	dim shared z36 as zstring * 32 => !"\&h3F\&h3F!"
	dim shared z37 as zstring * 32 => !"\&h3F\&h3F<"
	dim shared z38 as zstring * 32 => !"\&h3F\&h3F>"
	dim shared z39 as zstring * 32 => !"\&h3F\&h3F-"

	dim shared z41 as zstring * 32 => !"\&h3F\&h3F\&h3D"
	dim shared z42 as zstring * 32 => !"\&h3F\&h3F\&h2F"
	dim shared z43 as zstring * 32 => !"\&h3F\&h3F\&h27"
	dim shared z44 as zstring * 32 => !"\&h3F\&h3F\&h28"
	dim shared z45 as zstring * 32 => !"\&h3F\&h3F\&h29"
	dim shared z46 as zstring * 32 => !"\&h3F\&h3F\&h21"
	dim shared z47 as zstring * 32 => !"\&h3F\&h3F\&h3C"
	dim shared z48 as zstring * 32 => !"\&h3F\&h3F\&h3E"
	dim shared z49 as zstring * 32 => !"\&h3F\&h3F\&h2D"

	dim shared z51 as zstring * 32 => "x??="
	dim shared z52 as zstring * 32 => "x??/"
	dim shared z53 as zstring * 32 => "x??'"
	dim shared z54 as zstring * 32 => "x??("
	dim shared z55 as zstring * 32 => "x??)"
	dim shared z56 as zstring * 32 => "x??!"
	dim shared z57 as zstring * 32 => "x??<"
	dim shared z58 as zstring * 32 => "x??>"
	dim shared z59 as zstring * 32 => "x??-"

	dim shared z61 as zstring * 32 => "??=x"
	dim shared z62 as zstring * 32 => "??/x"
	dim shared z63 as zstring * 32 => "??'x"
	dim shared z64 as zstring * 32 => "??(x"
	dim shared z65 as zstring * 32 => "??)x"
	dim shared z66 as zstring * 32 => "??!x"
	dim shared z67 as zstring * 32 => "??<x"
	dim shared z68 as zstring * 32 => "??>x"
	dim shared z69 as zstring * 32 => "??-x"

	dim shared z71 as zstring * 32 => "x??=x"
	dim shared z72 as zstring * 32 => "x??/x"
	dim shared z73 as zstring * 32 => "x??'x"
	dim shared z74 as zstring * 32 => "x??(x"
	dim shared z75 as zstring * 32 => "x??)x"
	dim shared z76 as zstring * 32 => "x??!x"
	dim shared z77 as zstring * 32 => "x??<x"
	dim shared z78 as zstring * 32 => "x??>x"
	dim shared z79 as zstring * 32 => "x??-x"

	dim shared w11 as wstring * 32 => wstr( "??=" )
	dim shared w12 as wstring * 32 => wstr( "??/" )
	dim shared w13 as wstring * 32 => wstr( "??'" )
	dim shared w14 as wstring * 32 => wstr( "??(" )
	dim shared w15 as wstring * 32 => wstr( "??)" )
	dim shared w16 as wstring * 32 => wstr( "??!" )
	dim shared w17 as wstring * 32 => wstr( "??<" )
	dim shared w18 as wstring * 32 => wstr( "??>" )
	dim shared w19 as wstring * 32 => wstr( "??-" )

	dim shared w21 as wstring * 32 => wstr( !"\&h3F?=" )
	dim shared w22 as wstring * 32 => wstr( !"\&h3F?/" )
	dim shared w23 as wstring * 32 => wstr( !"\&h3F?'" )
	dim shared w24 as wstring * 32 => wstr( !"\&h3F?(" )
	dim shared w25 as wstring * 32 => wstr( !"\&h3F?)" )
	dim shared w26 as wstring * 32 => wstr( !"\&h3F?!" )
	dim shared w27 as wstring * 32 => wstr( !"\&h3F?<" )
	dim shared w28 as wstring * 32 => wstr( !"\&h3F?>" )
	dim shared w29 as wstring * 32 => wstr( !"\&h3F?-" )

	dim shared w31 as wstring * 32 => wstr( !"\&h3F\&h3F=" )
	dim shared w32 as wstring * 32 => wstr( !"\&h3F\&h3F/" )
	dim shared w33 as wstring * 32 => wstr( !"\&h3F\&h3F'" )
	dim shared w34 as wstring * 32 => wstr( !"\&h3F\&h3F(" )
	dim shared w35 as wstring * 32 => wstr( !"\&h3F\&h3F)" )
	dim shared w36 as wstring * 32 => wstr( !"\&h3F\&h3F!" )
	dim shared w37 as wstring * 32 => wstr( !"\&h3F\&h3F<" )
	dim shared w38 as wstring * 32 => wstr( !"\&h3F\&h3F>" )
	dim shared w39 as wstring * 32 => wstr( !"\&h3F\&h3F-" )

	dim shared w41 as wstring * 32 => wstr( !"\&h3F\&h3F\&h3D" )
	dim shared w42 as wstring * 32 => wstr( !"\&h3F\&h3F\&h2F" )
	dim shared w43 as wstring * 32 => wstr( !"\&h3F\&h3F\&h27" )
	dim shared w44 as wstring * 32 => wstr( !"\&h3F\&h3F\&h28" )
	dim shared w45 as wstring * 32 => wstr( !"\&h3F\&h3F\&h29" )
	dim shared w46 as wstring * 32 => wstr( !"\&h3F\&h3F\&h21" )
	dim shared w47 as wstring * 32 => wstr( !"\&h3F\&h3F\&h3C" )
	dim shared w48 as wstring * 32 => wstr( !"\&h3F\&h3F\&h3E" )
	dim shared w49 as wstring * 32 => wstr( !"\&h3F\&h3F\&h2D" )

	dim shared w51 as wstring * 32 => wstr( "x??=" )
	dim shared w52 as wstring * 32 => wstr( "x??/" )
	dim shared w53 as wstring * 32 => wstr( "x??'" )
	dim shared w54 as wstring * 32 => wstr( "x??(" )
	dim shared w55 as wstring * 32 => wstr( "x??)" )
	dim shared w56 as wstring * 32 => wstr( "x??!" )
	dim shared w57 as wstring * 32 => wstr( "x??<" )
	dim shared w58 as wstring * 32 => wstr( "x??>" )
	dim shared w59 as wstring * 32 => wstr( "x??-" )

	dim shared w61 as wstring * 32 => wstr( "??=x" )
	dim shared w62 as wstring * 32 => wstr( "??/x" )
	dim shared w63 as wstring * 32 => wstr( "??'x" )
	dim shared w64 as wstring * 32 => wstr( "??(x" )
	dim shared w65 as wstring * 32 => wstr( "??)x" )
	dim shared w66 as wstring * 32 => wstr( "??!x" )
	dim shared w67 as wstring * 32 => wstr( "??<x" )
	dim shared w68 as wstring * 32 => wstr( "??>x" )
	dim shared w69 as wstring * 32 => wstr( "??-x" )

	dim shared w71 as wstring * 32 => wstr( "x??=x" )
	dim shared w72 as wstring * 32 => wstr( "x??/x" )
	dim shared w73 as wstring * 32 => wstr( "x??'x" )
	dim shared w74 as wstring * 32 => wstr( "x??(x" )
	dim shared w75 as wstring * 32 => wstr( "x??)x" )
	dim shared w76 as wstring * 32 => wstr( "x??!x" )
	dim shared w77 as wstring * 32 => wstr( "x??<x" )
	dim shared w78 as wstring * 32 => wstr( "x??>x" )
	dim shared w79 as wstring * 32 => wstr( "x??-x" )

	TEST( all )
		#macro check3( var, c0, c1, c2 )
			CU_ASSERT( var[0] = asc( c0 ) )
			CU_ASSERT( var[1] = asc( c1 ) )
			CU_ASSERT( var[2] = asc( c2 ) )
			CU_ASSERT( var[3] = 0 )
		#endmacro

		#macro check4( var, c0, c1, c2, c3 )
			CU_ASSERT( var[0] = asc( c0 ) )
			CU_ASSERT( var[1] = asc( c1 ) )
			CU_ASSERT( var[2] = asc( c2 ) )
			CU_ASSERT( var[3] = asc( c3 ) )
			CU_ASSERT( var[4] = 0 )
		#endmacro

		#macro check5( var, c0, c1, c2, c3, c4 )
			CU_ASSERT( var[0] = asc( c0 ) )
			CU_ASSERT( var[1] = asc( c1 ) )
			CU_ASSERT( var[2] = asc( c2 ) )
			CU_ASSERT( var[3] = asc( c3 ) )
			CU_ASSERT( var[4] = asc( c4 ) )
			CU_ASSERT( var[5] = 0 )
		#endmacro

		#macro checkTrigraphs( varprefix )
			check3( varprefix##1, "?", "?", "=" )
			check3( varprefix##2, "?", "?", "/" )
			check3( varprefix##3, "?", "?", "'" )
			check3( varprefix##4, "?", "?", "(" )
			check3( varprefix##5, "?", "?", ")" )
			check3( varprefix##6, "?", "?", "!" )
			check3( varprefix##7, "?", "?", "<" )
			check3( varprefix##8, "?", "?", ">" )
			check3( varprefix##9, "?", "?", "-" )
		#endmacro

		checkTrigraphs( z1 )
		checkTrigraphs( z2 )
		checkTrigraphs( z3 )
		checkTrigraphs( z4 )

		check4( z51, "x", "?", "?", "=" )
		check4( z52, "x", "?", "?", "/" )
		check4( z53, "x", "?", "?", "'" )
		check4( z54, "x", "?", "?", "(" )
		check4( z55, "x", "?", "?", ")" )
		check4( z56, "x", "?", "?", "!" )
		check4( z57, "x", "?", "?", "<" )
		check4( z58, "x", "?", "?", ">" )
		check4( z59, "x", "?", "?", "-" )

		check4( z61, "?", "?", "=", "x" )
		check4( z62, "?", "?", "/", "x" )
		check4( z63, "?", "?", "'", "x" )
		check4( z64, "?", "?", "(", "x" )
		check4( z65, "?", "?", ")", "x" )
		check4( z66, "?", "?", "!", "x" )
		check4( z67, "?", "?", "<", "x" )
		check4( z68, "?", "?", ">", "x" )
		check4( z69, "?", "?", "-", "x" )

		check5( z71, "x", "?", "?", "=", "x" )
		check5( z72, "x", "?", "?", "/", "x" )
		check5( z73, "x", "?", "?", "'", "x" )
		check5( z74, "x", "?", "?", "(", "x" )
		check5( z75, "x", "?", "?", ")", "x" )
		check5( z76, "x", "?", "?", "!", "x" )
		check5( z77, "x", "?", "?", "<", "x" )
		check5( z78, "x", "?", "?", ">", "x" )
		check5( z79, "x", "?", "?", "-", "x" )

		checkTrigraphs( w1 )
		checkTrigraphs( w2 )
		checkTrigraphs( w3 )
		checkTrigraphs( w4 )

		check4( w51, "x", "?", "?", "=" )
		check4( w52, "x", "?", "?", "/" )
		check4( w53, "x", "?", "?", "'" )
		check4( w54, "x", "?", "?", "(" )
		check4( w55, "x", "?", "?", ")" )
		check4( w56, "x", "?", "?", "!" )
		check4( w57, "x", "?", "?", "<" )
		check4( w58, "x", "?", "?", ">" )
		check4( w59, "x", "?", "?", "-" )

		check4( w61, "?", "?", "=", "x" )
		check4( w62, "?", "?", "/", "x" )
		check4( w63, "?", "?", "'", "x" )
		check4( w64, "?", "?", "(", "x" )
		check4( w65, "?", "?", ")", "x" )
		check4( w66, "?", "?", "!", "x" )
		check4( w67, "?", "?", "<", "x" )
		check4( w68, "?", "?", ">", "x" )
		check4( w69, "?", "?", "-", "x" )

		check5( w71, "x", "?", "?", "=", "x" )
		check5( w72, "x", "?", "?", "/", "x" )
		check5( w73, "x", "?", "?", "'", "x" )
		check5( w74, "x", "?", "?", "(", "x" )
		check5( w75, "x", "?", "?", ")", "x" )
		check5( w76, "x", "?", "?", "!", "x" )
		check5( w77, "x", "?", "?", "<", "x" )
		check5( w78, "x", "?", "?", ">", "x" )
		check5( w79, "x", "?", "?", "-", "x" )
	END_TEST

END_SUITE
