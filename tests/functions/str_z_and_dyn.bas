# include "fbcunit.bi"

SUITE( fbc_tests.functions.str_z_and_dyn )

	const ZTESTSTR = "ABC"	
	const FTESTSTR = "def"
	const VTESTSTR = "GhI"
	const CONCATSTR = "123"
	const TOTLEN = 3 + 3

	declare function zconcat1 ( byval s as string ) as zstring ptr
	declare function zconcat2 ( byref s as string ) as zstring ptr

	declare function sconcat1 ( byval s as string ) as string
	declare function sconcat2 ( byref s as string ) as string
		
	TEST( default )

		dim z1 as zstring ptr
		dim z2 as zstring * TOTLEN+1
		dim f1 as string * TOTLEN
		dim d1 as string
		
		z1 = allocate( TOTLEN+1 )
		
		*z1 = ZTESTSTR
		z2 = *z1
		f1 = FTESTSTR
		d1 = VTESTSTR
		
		CU_ASSERT( *zconcat1( z2 ) = ZTESTSTR + CONCATSTR )
		CU_ASSERT( *zconcat2( *z1 ) = ZTESTSTR + CONCATSTR )
		
		CU_ASSERT( *zconcat1( f1 ) = FTESTSTR  + CONCATSTR )
		CU_ASSERT( *zconcat2( f1 ) = FTESTSTR + CONCATSTR )
		
		CU_ASSERT( *zconcat1( d1 ) = VTESTSTR + CONCATSTR )
		CU_ASSERT( *zconcat2( d1 ) = VTESTSTR + CONCATSTR )

		CU_ASSERT( sconcat1( z2 ) = ZTESTSTR + CONCATSTR )
		CU_ASSERT( sconcat2( *z1 ) = ZTESTSTR + CONCATSTR )
		
		CU_ASSERT( sconcat1( f1 ) = FTESTSTR  + CONCATSTR )
		CU_ASSERT( sconcat2( f1 ) = FTESTSTR + CONCATSTR )
		
		CU_ASSERT( sconcat1( d1 ) = VTESTSTR + CONCATSTR )
		CU_ASSERT( sconcat2( d1 ) = VTESTSTR + CONCATSTR )
		
	END_TEST
		
	'':::
	function zconcat1 ( byval s as string ) as zstring ptr
		static res as zstring * TOTLEN+1
		
		res = s + CONCATSTR
		
		return @res

	end function

	'':::
	function zconcat2 ( byref s as string ) as zstring ptr
		static res as zstring * TOTLEN+1
		
		res = s + CONCATSTR
		
		return @res

	end function

	'':::
	function sconcat1 ( byval s as string ) as string
		
		return s + CONCATSTR

	end function

	'':::
	function sconcat2 ( byref s as string ) as string
		
		return s + CONCATSTR

	end function

END_SUITE
