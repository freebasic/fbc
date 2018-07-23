#include "fbcunit.bi"

SUITE( fbc_tests.overload_.integers )

	TEST_GROUP( regressionTestBug716 )
		function f1 overload( i as short   ) as string : function = "f1 short"   : end function
		function f1 overload( i as long    ) as string : function = "f1 long"    : end function
		function f1 overload( i as longint ) as string : function = "f1 longint" : end function

		function f2 overload( i as short   ) as string : function = "f2 short"   : end function
		function f2 overload( i as longint ) as string : function = "f2 longint" : end function

		TEST( default )
			dim xshort   as short
			dim xlong    as long
			dim xlongint as longint
			dim xinteger as integer

			CU_ASSERT( f1( xshort   ) = "f1 short"   )
			CU_ASSERT( f1( xlong    ) = "f1 long"    )
			CU_ASSERT( f1( xlongint ) = "f1 longint" )
	#ifdef __FB_64BIT__
			CU_ASSERT( f1( xinteger ) = "f1 longint" )
	#else
			CU_ASSERT( f1( xinteger ) = "f1 long"    )
	#endif

			CU_ASSERT( f2( xshort   ) = "f2 short"   )
			CU_ASSERT( f2( xlong    ) = "f2 longint" )
			CU_ASSERT( f2( xlongint ) = "f2 longint" )
			CU_ASSERT( f2( xinteger ) = "f2 longint" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( preferExactSigned )
		function f overload( i as byte    ) as string : function = "byte"    : end function
		function f overload( i as short   ) as string : function = "short"   : end function
		function f overload( i as long    ) as string : function = "long"    : end function
		function f overload( i as longint ) as string : function = "longint" : end function
		function f overload( i as integer ) as string : function = "integer" : end function

		TEST( default )
			dim xbyte    as byte
			dim xshort   as short
			dim xlong    as long
			dim xlongint as longint
			dim xinteger as integer

			CU_ASSERT( f( xbyte    ) = "byte"    )
			CU_ASSERT( f( xshort   ) = "short"   )
			CU_ASSERT( f( xlong    ) = "long"    )
			CU_ASSERT( f( xlongint ) = "longint" )
			CU_ASSERT( f( xinteger ) = "integer" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( preferExactUnsigned )
		function f overload( i as ubyte    ) as string : function = "ubyte"    : end function
		function f overload( i as ushort   ) as string : function = "ushort"   : end function
		function f overload( i as ulong    ) as string : function = "ulong"    : end function
		function f overload( i as ulongint ) as string : function = "ulongint" : end function
		function f overload( i as uinteger ) as string : function = "uinteger" : end function

		TEST( default )
			dim xubyte    as ubyte
			dim xushort   as ushort
			dim xulong    as ulong
			dim xulongint as ulongint
			dim xuinteger as uinteger

			CU_ASSERT( f( xubyte    ) = "ubyte"    )
			CU_ASSERT( f( xushort   ) = "ushort"   )
			CU_ASSERT( f( xulong    ) = "ulong"    )
			CU_ASSERT( f( xulongint ) = "ulongint" )
			CU_ASSERT( f( xuinteger ) = "uinteger" )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( preferExactMixedSign )
		function f overload( i as byte     ) as string : function = "byte"     : end function
		function f overload( i as ubyte    ) as string : function = "ubyte"    : end function
		function f overload( i as short    ) as string : function = "short"    : end function
		function f overload( i as ushort   ) as string : function = "ushort"   : end function
		function f overload( i as long     ) as string : function = "long"     : end function
		function f overload( i as ulong    ) as string : function = "ulong"    : end function
		function f overload( i as longint  ) as string : function = "longint"  : end function
		function f overload( i as ulongint ) as string : function = "ulongint" : end function
		function f overload( i as integer  ) as string : function = "integer"  : end function
		function f overload( i as uinteger ) as string : function = "uinteger" : end function

		TEST( default )
			dim xbyte     as byte
			dim xubyte    as ubyte
			dim xshort    as short
			dim xushort   as ushort
			dim xlong     as long
			dim xulong    as ulong
			dim xlongint  as longint
			dim xulongint as ulongint
			dim xinteger  as integer
			dim xuinteger as uinteger

			CU_ASSERT( f( xbyte     ) = "byte"     )
			CU_ASSERT( f( xubyte    ) = "ubyte"    )
			CU_ASSERT( f( xshort    ) = "short"    )
			CU_ASSERT( f( xushort   ) = "ushort"   )
			CU_ASSERT( f( xlong     ) = "long"     )
			CU_ASSERT( f( xulong    ) = "ulong"    )
			CU_ASSERT( f( xlongint  ) = "longint"  )
			CU_ASSERT( f( xulongint ) = "ulongint" )
			CU_ASSERT( f( xinteger  ) = "integer"  )
			CU_ASSERT( f( xuinteger ) = "uinteger" )
		END_TEST
	END_TEST_GROUP

	#macro _makeOverloads( A, B, C, D )
		namespace A##B##C##D
			function f overload( i as A ) as string : function = #A : end function
			function f overload( i as B ) as string : function = #B : end function
			#if #C <> ""
			function f overload( i as C ) as string : function = #C : end function
			#endif
			#if #D <> ""
			function f overload( i as D ) as string : function = #D : end function
			#endif
		end namespace
	#endmacro

	_makeOverloads( byte   , short  ,        ,         )
	_makeOverloads( byte   , short  , long   ,         )
	_makeOverloads( byte   , short  , long   , longint )
	_makeOverloads( byte   , short  , long   , integer )
	_makeOverloads( byte   , short  , longint,         )
	_makeOverloads( byte   , short  , longint, integer )
	_makeOverloads( byte   , short  , integer,         )
	_makeOverloads( byte   , long   ,        ,         )
	_makeOverloads( byte   , long   , longint,         )
	_makeOverloads( byte   , long   , longint, integer )
	_makeOverloads( byte   , long   , integer,         )
	_makeOverloads( byte   , longint,        ,         )
	_makeOverloads( byte   , longint, integer,         )
	_makeOverloads( byte   , integer,        ,         )
	_makeOverloads( short  , long   ,        ,         )
	_makeOverloads( short  , long   , longint,         )
	_makeOverloads( short  , long   , longint, integer )
	_makeOverloads( short  , long   , integer,         )
	_makeOverloads( short  , longint,        ,         )
	_makeOverloads( short  , longint, integer,         )
	_makeOverloads( short  , integer,        ,         )
	_makeOverloads( long   , longint,        ,         )
	_makeOverloads( long   , longint, integer,         )
	_makeOverloads( long   , integer,        ,         )
	_makeOverloads( longint, integer,        ,         )

	TEST( NextBestForByte )
		dim xbyte as byte
		CU_ASSERT( ShortLong              .f( xbyte ) = "short" )
		CU_ASSERT( ShortLongLongint       .f( xbyte ) = "short" )
		CU_ASSERT( ShortLongLongintInteger.f( xbyte ) = "short" )
		CU_ASSERT( ShortLongInteger       .f( xbyte ) = "short" )
		CU_ASSERT( ShortLongint           .f( xbyte ) = "short" )
		CU_ASSERT( ShortLongintInteger    .f( xbyte ) = "short" )
		CU_ASSERT( ShortInteger           .f( xbyte ) = "short" )
		CU_ASSERT( LongLongint            .f( xbyte ) = "long" )
	#ifdef __FB_64BIT__
		CU_ASSERT( LongLongintInteger     .f( xbyte ) = "long" )
		CU_ASSERT( LongInteger            .f( xbyte ) = "long" )
	#else
		CU_ASSERT( LongLongintInteger     .f( xbyte ) = "integer" )
		CU_ASSERT( LongInteger            .f( xbyte ) = "integer" )
	#endif
		CU_ASSERT( LongintInteger         .f( xbyte ) = "integer" )
	END_TEST

	TEST( NextBestForShort )
		dim xshort as short
		CU_ASSERT( ByteLong              .f( xshort ) = "long" )
		CU_ASSERT( ByteLongLongint       .f( xshort ) = "long" )
	#ifdef __FB_64BIT__
		CU_ASSERT( ByteLongLongintInteger.f( xshort ) = "long" )
		CU_ASSERT( ByteLongInteger       .f( xshort ) = "long" )
	#else
		CU_ASSERT( ByteLongLongintInteger.f( xshort ) = "integer" )
		CU_ASSERT( ByteLongInteger       .f( xshort ) = "integer" )
	#endif
		CU_ASSERT( ByteLongint           .f( xshort ) = "longint" )
		CU_ASSERT( ByteLongintInteger    .f( xshort ) = "integer" )
		CU_ASSERT( ByteInteger           .f( xshort ) = "integer" )
		CU_ASSERT( LongLongint           .f( xshort ) = "long" )
	#ifdef __FB_64BIT__
		CU_ASSERT( LongLongintInteger    .f( xshort ) = "long" )
		CU_ASSERT( LongInteger           .f( xshort ) = "long" )
	#else
		CU_ASSERT( LongLongintInteger    .f( xshort ) = "integer" )
		CU_ASSERT( LongInteger           .f( xshort ) = "integer" )
	#endif
		CU_ASSERT( LongintInteger        .f( xshort ) = "integer" )
	END_TEST

	TEST( NextBestForLong )
		dim xlong as long
		CU_ASSERT( ByteShort              .f( xlong ) = "short" )
		CU_ASSERT( ByteShortLongint       .f( xlong ) = "longint" )
		CU_ASSERT( ByteShortLongintInteger.f( xlong ) = "integer" )
		CU_ASSERT( ByteShortInteger       .f( xlong ) = "integer" )
		CU_ASSERT( ByteLongint            .f( xlong ) = "longint" )
		CU_ASSERT( ByteLongintInteger     .f( xlong ) = "integer" )
		CU_ASSERT( ByteInteger            .f( xlong ) = "integer" )
		CU_ASSERT( ShortLongint           .f( xlong ) = "longint" )
		CU_ASSERT( ShortLongintInteger    .f( xlong ) = "integer" )
		CU_ASSERT( ShortInteger           .f( xlong ) = "integer" )
		CU_ASSERT( LongintInteger         .f( xlong ) = "integer" )
	END_TEST

	TEST( NextBestForLongint )
		dim xlongint as longint
		CU_ASSERT( ByteShort           .f( xlongint ) = "short" )
		CU_ASSERT( ByteShortLong       .f( xlongint ) = "long" )
		CU_ASSERT( ByteShortLongInteger.f( xlongint ) = "integer" )
		CU_ASSERT( ByteShortInteger    .f( xlongint ) = "integer" )
		CU_ASSERT( ByteLong            .f( xlongint ) = "long" )
		CU_ASSERT( ByteLongInteger     .f( xlongint ) = "integer" )
		CU_ASSERT( ByteInteger         .f( xlongint ) = "integer" )
		CU_ASSERT( ShortLong           .f( xlongint ) = "long" )
		CU_ASSERT( ShortLongInteger    .f( xlongint ) = "integer" )
		CU_ASSERT( ShortInteger        .f( xlongint ) = "integer" )
		CU_ASSERT( LongInteger         .f( xlongint ) = "integer" )
	END_TEST

	TEST( NextBestForInteger )
		dim xinteger as integer
		CU_ASSERT( ByteShort           .f( xinteger ) = "short" )
		CU_ASSERT( ByteShortLong       .f( xinteger ) = "long" )
	#ifdef __FB_64BIT__
		CU_ASSERT( ByteShortLongLongint.f( xinteger ) = "longint" )
	#else
		CU_ASSERT( ByteShortLongLongint.f( xinteger ) = "long" )
	#endif
		CU_ASSERT( ByteShortLongint    .f( xinteger ) = "longint" )
		CU_ASSERT( ByteLong            .f( xinteger ) = "long" )
	#ifdef __FB_64BIT__
		CU_ASSERT( ByteLongLongint     .f( xinteger ) = "longint" )
	#else
		CU_ASSERT( ByteLongLongint     .f( xinteger ) = "long" )
	#endif
		CU_ASSERT( ByteLongint         .f( xinteger ) = "longint" )
		CU_ASSERT( ShortLong           .f( xinteger ) = "long" )
	#ifdef __FB_64BIT__
		CU_ASSERT( ShortLongLongint    .f( xinteger ) = "longint" )
	#else
		CU_ASSERT( ShortLongLongint    .f( xinteger ) = "long" )
	#endif
		CU_ASSERT( ShortLongint        .f( xinteger ) = "longint" )
	#ifdef __FB_64BIT__
		CU_ASSERT( LongLongint         .f( xinteger ) = "longint" )
	#else
		CU_ASSERT( LongLongint         .f( xinteger ) = "long" )
	#endif
	END_TEST

END_SUITE
