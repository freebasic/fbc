#include "fbcunit.bi"

SUITE( fbc_tests.quirk.assignment_token )

	dim shared globali as integer

	function f1( ) byref as integer
		function = globali
	end function

	function f2( byval i as integer ) byref as integer
		function = globali
	end function

	function f3( byval i as integer, byval j as integer ) byref as integer
		function = globali
	end function

	'' Parameter initializer and FUNCTION=
	function ftest( byval i as integer => 456 ) as integer
		function => i
		ftest => i
	end function

	'' FIELD and field initializer
	type UDT field => 1
		i as integer => 789
		b as byte

		declare property prop( ) as integer
		declare operator cast( ) as integer
	end type

	'' PROPERTY=
	property UDT.prop( ) as integer
		property => i
	end property

	'' OPERATOR=
	operator UDT.cast( ) as integer
		operator => i
	end operator

	TEST( all )
		dim i as integer
		dim s as string

		CU_ASSERT( globali = 0 )
		f1(      ) => 1 : CU_ASSERT( globali = 1 )
		f2( 0    ) => 2 : CU_ASSERT( globali = 2 )
		f3( 0, 0 ) => 3 : CU_ASSERT( globali = 3 )

		'' Assignments and self-operators
		CU_ASSERT( i = 0 )
		i => 5
		CU_ASSERT( i = 5 )
		i +=> 5
		CU_ASSERT( i = 10 )
		i + => 5
		CU_ASSERT( i = 15 )

		CU_ASSERT( s = "" )
		s => "abc"
		CU_ASSERT( s = "abc" )
		s +=> "abc"
		CU_ASSERT( s = "abcabc" )
		s + => "abc"
		CU_ASSERT( s = "abcabcabc" )

		'' FOR loops
		dim j as integer
		for j => 1 to 2
			for k as integer => 1 to 2
				i += 1
			next
		next
		CU_ASSERT( i = 19 )

		'' CONST/enum member declarations
		const MYNUM1 => 123
		CU_ASSERT( MYNUM1 = 123 )

		enum
			MYNUM2 => 123
		end enum
		CU_ASSERT( MYNUM2 = 123 )

		'' Variable initializer
		dim l as integer => 123
		CU_ASSERT( l = 123 )
		dim fixstr as string * 5 => "abc"
		CU_ASSERT( fixstr = "abc" )

		'' Parameter initializer and FUNCTION=
		CU_ASSERT( ftest( ) = 456 )

		'' FIELD and field initializer
		dim x as UDT
		CU_ASSERT( sizeof( UDT ) = (sizeof( integer ) + sizeof( byte )) )
		CU_ASSERT( x.i = 789 )

		'' PROPERTY=
		CU_ASSERT( x.prop = 789 )

		'' OPERATOR=
		CU_ASSERT( cint( x ) = 789 )

		'' ERR
		err => 0

		'' OPEN FOR RANDOM LEN=
		if( open( "", for random, as #1, len => 1 ) ) then
		end if

		'' MID statement
		s = "abc"
		mid( s, 2 ) => "x"
		CU_ASSERT( s = "axc" )

		'' LSET/RSET statements
		s = "   " : lset s => "x" : CU_ASSERT( s = "x  " )
		s = "   " : rset s => "x" : CU_ASSERT( s = "  x" )
	END_TEST

END_SUITE
