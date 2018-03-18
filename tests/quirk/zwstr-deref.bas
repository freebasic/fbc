#include "fbcunit.bi"

SUITE( fbc_tests.quirk.zwstr_deref )

	TEST( all )
		dim s as string
		dim f as  string * 31
		dim as zstring * 32 z, z0
		dim as wstring * 32 w, w0
		dim pz as zstring ptr = @z0
		dim pw as wstring ptr = @w0
		dim as integer i
		dim as double d
		dim as longint ll

		'' Normally, DEREF'ing a zstring/wstring pointer "returns" a string.
		'' But in some contexts such as BOPs or ASSIGNs, a zwstring/wstring
		'' DEREF can become a simple char/wchar DEREF, i.e. it will access the
		'' char values instead of "returning" a string. This depends on the
		'' type of the second operand.
		''
		'' This is mostly testing all kinds of expression combinations to
		'' ensure the parser/AST accept it properly.

		z0 = "123"
		w0 = wstr( "123" )
		CU_ASSERT( *pz = "123" )
		CU_ASSERT( "123" = *pz )
		CU_ASSERT( *pw = wstr( "123" ) )
		CU_ASSERT( wstr( "123" ) = *pw )

		s = *pz
		f = *pz
		z = *pz
		w = *pz
		CU_ASSERT( s = "123" )
		CU_ASSERT( f = "123" )
		CU_ASSERT( z = "123" )
		CU_ASSERT( w = "123" )

		s = *pw
		f = *pw
		z = *pw
		w = *pw
		CU_ASSERT( s = wstr( "123" ) )
		CU_ASSERT( f = wstr( "123" ) )
		CU_ASSERT( z = wstr( "123" ) )
		CU_ASSERT( w = wstr( "123" ) )

		*pz = "456"         : CU_ASSERT( *pz = "456" )
		*pz = wstr( "456" ) : CU_ASSERT( *pz = wstr( "456" ) )
		*pz = s             : CU_ASSERT( *pz = s )
		*pz = f             : CU_ASSERT( *pz = f )
		*pz = z             : CU_ASSERT( *pz = z )
		*pz = w             : CU_ASSERT( *pz = w )

		*pw = "456"         : CU_ASSERT( *pw = "456" )
		*pw = wstr( "456" ) : CU_ASSERT( *pw = wstr( "456" ) )
		*pw = s             : CU_ASSERT( *pw = s )
		*pw = f             : CU_ASSERT( *pw = f )
		*pw = z             : CU_ASSERT( *pw = z )
		*pw = w             : CU_ASSERT( *pw = w )

		'' but the other operand can be an integer too:
		z0 = "123"
		i = *pz
		CU_ASSERT( i = asc( "1" ) )
		i = 0

		w0 = wstr( "123" )
		i = *pw
		CU_ASSERT( i = asc( "1" ) )
		i = 0

		z0 = "123"
		w0 = wstr( "123" )
		i = asc( "7" )
		*pz = i
		*pw = i
		CU_ASSERT( *pz = "723" )
		CU_ASSERT( *pw = wstr( "723" ) )

		'' or a longint:
		z0 = "123"
		ll = *pz
		CU_ASSERT( ll = asc( "1" ) )
		ll = 0

		w0 = wstr( "123" )
		ll = *pw
		CU_ASSERT( ll = asc( "1" ) )
		ll = 0

		z0 = "123"
		w0 = wstr( "123" )
		ll = asc( "7" )
		*pz = ll
		*pw = ll
		CU_ASSERT( *pz = "723" )
		CU_ASSERT( *pw = wstr( "723" ) )

		'' or a float:
		z0 = "123"
		d = *pz
		CU_ASSERT( d = asc( "1" ) )
		d = 0

		w0 = wstr( "123" )
		d = *pw
		CU_ASSERT( d = asc( "1" ) )
		d = 0

		z0 = "123"
		w0 = wstr( "123" )
		d = asc( "7" )
		*pz = d
		*pw = d
		CU_ASSERT( *pz = "723" )
		CU_ASSERT( *pw = wstr( "723" ) )

		'' The DEREF can even have an index. If it's a z/wstring DEREF, then
		'' the string will start at that position. If it's being treated as
		'' char/wchar DEREF then it works like pointer indexing.
		z0 = "123"
		CU_ASSERT( pz[0] = "123" )  '' other operand is a string
		CU_ASSERT( pz[1] = "23" )
		CU_ASSERT( pz[2] = "3" )
		CU_ASSERT( pz[3] = "" )
		CU_ASSERT( pz[0] = asc( "1" ) )  '' other operand is an integer
		CU_ASSERT( pz[1] = asc( "2" ) )
		CU_ASSERT( pz[2] = asc( "3" ) )
		CU_ASSERT( pz[3] = 0 )

		CU_ASSERT( *(pz+0) = "123" )
		CU_ASSERT( *(pz+1) = "23" )
		CU_ASSERT( *(pz+2) = "3" )
		CU_ASSERT( *(pz+3) = "" )
		CU_ASSERT( *(pz+0) = asc( "1" ) )
		CU_ASSERT( *(pz+1) = asc( "2" ) )
		CU_ASSERT( *(pz+2) = asc( "3" ) )
		CU_ASSERT( *(pz+3) = 0 )

		z0 = "123"
		i = pz[1]
		CU_ASSERT( i = asc( "2" ) )
		i = 0

		z0 = "123"
		i = asc( "7" )
		pz[1] = i
		CU_ASSERT( *pz = "173" )

		z0 = "123"
		ll = pz[1]
		CU_ASSERT( ll = asc( "2" ) )
		ll = 0

		z0 = "123"
		ll = asc( "7" )
		pz[1] = ll
		CU_ASSERT( *pz = "173" )

		z0 = "123"
		d = pz[1]
		CU_ASSERT( d = asc( "2" ) )
		d = 0

		z0 = "123"
		d = asc( "7" )
		pz[1] = d
		CU_ASSERT( *pz = "173" )

		w0 = wstr( "123" )
		CU_ASSERT( pw[0] = wstr( "123" ) )  '' other operand is a string
		CU_ASSERT( pw[1] = wstr( "23" ) )
		CU_ASSERT( pw[2] = wstr( "3" ) )
		CU_ASSERT( pw[3] = wstr( "" ) )
		CU_ASSERT( pw[0] = asc( "1" ) )  '' other operand is an integer
		CU_ASSERT( pw[1] = asc( "2" ) )
		CU_ASSERT( pw[2] = asc( "3" ) )
		CU_ASSERT( pw[3] = 0 )

		CU_ASSERT( *(pw+0) = wstr( "123" ) )
		CU_ASSERT( *(pw+1) = wstr( "23" ) )
		CU_ASSERT( *(pw+2) = wstr( "3" ) )
		CU_ASSERT( *(pw+3) = wstr( "" ) )
		CU_ASSERT( *(pw+0) = asc( "1" ) )
		CU_ASSERT( *(pw+1) = asc( "2" ) )
		CU_ASSERT( *(pw+2) = asc( "3" ) )
		CU_ASSERT( *(pw+3) = 0 )

		w0 = wstr( "123" )
		i = pw[1]
		CU_ASSERT( i = asc( "2" ) )
		i = 0

		w0 = wstr( "123" )
		i = asc( "7" )
		pw[1] = i
		CU_ASSERT( *pw = wstr( "173" ) )

		w0 = wstr( "123" )
		ll = pw[1]
		CU_ASSERT( ll = asc( "2" ) )
		ll = 0

		w0 = wstr( "123" )
		ll = asc( "7" )
		pw[1] = ll
		CU_ASSERT( *pw = wstr( "173" ) )

		w0 = wstr( "123" )
		d = pw[1]
		CU_ASSERT( d = asc( "2" ) )
		d = 0

		w0 = wstr( "123" )
		d = asc( "7" )
		pw[1] = d
		CU_ASSERT( *pw = wstr( "173" ) )

		z0 = "123"
		if( *pz    = "123"      ) then CU_PASS( ) else CU_FAIL( )  '' string comparison
		if(  pz[0] = "123"      ) then CU_PASS( ) else CU_FAIL( )
		if(  pz[1] =  "23"      ) then CU_PASS( ) else CU_FAIL( )
		if( *pz    = asc( "1" ) ) then CU_PASS( ) else CU_FAIL( )  '' char comparison
		if(  pz[0] = asc( "1" ) ) then CU_PASS( ) else CU_FAIL( )
		if(  pz[1] = asc( "2" ) ) then CU_PASS( ) else CU_FAIL( )

		'' string select
		z0 = "123"
		select case( *pz )
		case "123"
			CU_PASS( )
		case else
			CU_FAIL( )
		end select

		'' wstring select
		w0 = wstr( "123" )
		select case( *pw )
		case wstr( "123" )
			CU_PASS( )
		case else
			CU_FAIL( )
		end select

		'' char select
		z0 = "123"
		select case( (*pz)[0] )
		case asc( "1" )
			CU_PASS( )
		case else
			CU_FAIL( )
		end select

		'' wchar select
		w0 = wstr( "123" )
		select case( (*pw)[0] )
		case asc( "1" )
			CU_PASS( )
		case else
			CU_FAIL( )
		end select

		'' Both sides can be DEREFs
		dim as zstring ptr pz0 = @z0
		dim as wstring ptr pw0 = @w0
		pz = @z
		pw = @w
		z0 = "123"
		z  = "123"
		w0 = wstr( "123" )
		w  = wstr( "123" )

		CU_ASSERT( *pz = *pz )
		CU_ASSERT( *pw = *pw )
		CU_ASSERT( *pz0 = *pz )
		CU_ASSERT( *pw0 = *pw )

		'' string indexing works on such DEREFs too
		CU_ASSERT(    z [0] = asc( "1" ) )
		CU_ASSERT(    z [1] = asc( "2" ) )
		CU_ASSERT(    z [2] = asc( "3" ) )
		CU_ASSERT(    z [3] = 0          )
		CU_ASSERT( (*pz)[0] = asc( "1" ) )
		CU_ASSERT( (*pz)[1] = asc( "2" ) )
		CU_ASSERT( (*pz)[2] = asc( "3" ) )
		CU_ASSERT( (*pz)[3] = 0          )

		CU_ASSERT(    z0 [0] =    z [0] )
		CU_ASSERT(    z0 [1] =    z [1] )
		CU_ASSERT( (*pz0)[0] = (*pz)[0] )
		CU_ASSERT( (*pz0)[1] = (*pz)[1] )

		'' We can even use indexing on the DEREF first and then again on
		'' the "resulting" string
		CU_ASSERT( pz[0][0] = asc( "1" ) )
		CU_ASSERT( pz[0][1] = asc( "2" ) )
		CU_ASSERT( pz[0][2] = asc( "3" ) )
		CU_ASSERT( pz[0][3] = 0          )

		CU_ASSERT( pz[0][0] = asc( "1" ) )
		CU_ASSERT( pz[1][0] = asc( "2" ) )
		CU_ASSERT( pz[2][0] = asc( "3" ) )
		CU_ASSERT( pz[3][0] = 0          )

		CU_ASSERT( pz[1][0] = asc( "2" ) )
		CU_ASSERT( pz[1][1] = asc( "3" ) )
		CU_ASSERT( pz[1][2] = 0          )
	END_TEST

END_SUITE
