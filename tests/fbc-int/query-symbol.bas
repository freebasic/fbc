#include "fbcunit.bi"
#include "fbc-int/symbol.bi"

'' tests for __FB_QUERY_SYMBOL__

#pragma reserve SYM_RESERVED

namespace ns1

	sub proc1
	end sub

	namespace ns2

		sub proc2()
		end sub

	end namespace
end namespace

SUITE( fbc_tests.fbc_int.query_symbol )

	type T
		fld1 as integer
		fld2 as long

	end type

	union U
		fld1 as integer
		fld2 as long
	end union

	enum E
		elem
	end enum

	sub proc( byval sym_param as integer )
		dim result as integer

		'' internal symbol, to get this need to check SYMBATTRIB instead
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_param )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PARAM )
	end sub

	function func() as integer
		function = 0
	end function

	type SYM_LONGPTR as long ptr
	type FWDREF as SYM_FWDREF

	TEST( symbclass )
		dim result as integer

		dim sym_var as integer
		const sym_const as integer = 1

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_var )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_VAR )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_const )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_CONST )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, proc )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PROC )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, ns1.proc1 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PROC )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, ns1.ns2.proc2 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PROC )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, func )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PROC )

		proc( 0 )

		'' define is will not be possible without some other query filter added
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_define )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_DEFINE )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, integer )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_KEYWORD )

sym_label:
		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_label )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_LABEL )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, ns1 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_NAMESPACE )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, ns1.ns2 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_NAMESPACE )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, E )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_ENUM )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, T )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_STRUCT )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, U )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_STRUCT )

		'' CLASS not implemented
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_class )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_CLASS )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, T.fld1 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_FIELD )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, SYM_LONGPTR )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_TYPEDEF )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, SYM_FWDREF )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_FWDREF )

		'' internal symbol
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_scope )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_SCOPE )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, SYM_RESERVED )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_RESERVED )

		'' internal symbol
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_nsimport )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_NSIMPORT )

	END_TEST


	#macro chkDataClass( sym, isInt, isFloat, isString, isUDT, isProc )
		CU_ASSERT( isDataClassInteger( sym ) = isInt )
		CU_ASSERT( isDataClassFloat( sym ) = isFloat )
		CU_ASSERT( isDataClassString( sym ) = isString )
		CU_ASSERT( isDataClassUDT( sym ) = isUDT )
		CU_ASSERT( isDataClassProc( sym ) = isProc )
	#endmacro

	#macro chkDataClassVariable( decltype, isInt, isFloat, isString, isUDT, isProc )
		scope
			dim as decltype x
			chkDataClass( x, isInt, isFloat, isString, isUDT, isProc )
		end scope
	#endmacro

	TEST( dataclass )
		type sometype
			__ as integer
		end type
		chkDataClassVariable( any ptr    , true , false, false, false, false )
		chkDataClassVariable( zstring ptr, true , false, false, false, false )
		chkDataClassVariable( wstring ptr, true , false, false, false, false )
		chkDataClassVariable( any ptr    , true , false, false, false, false )
		chkDataClassVariable( boolean    , true , false, false, false, false )
		chkDataClassVariable( byte       , true , false, false, false, false )
		chkDataClassVariable( ubyte      , true , false, false, false, false )
		chkDataClassVariable( short      , true , false, false, false, false )
		chkDataClassVariable( ushort     , true , false, false, false, false )
		chkDataClassVariable( long       , true , false, false, false, false )
		chkDataClassVariable( ulong      , true , false, false, false, false )
		chkDataClassVariable( integer    , true , false, false, false, false )
		chkDataClassVariable( uinteger   , true , false, false, false, false )
		chkDataClassVariable( longint    , true , false, false, false, false )
		chkDataClassVariable( ulongint   , true , false, false, false, false )
		chkDataClassVariable( single     , false, true , false, false, false )
		chkDataClassVariable( double     , false, true , false, false, false )
		chkDataClassVariable( string     , false, false, true , false, false )
		chkDataClassVariable( string*5   , false, false, true , false, false )
		chkDataClassVariable( zstring*5  , true , false, false, false, false )
		chkDataClassVariable( wstring*5  , true , false, false, false, false )
		chkDataClassVariable( sometype   , false, false, false, true , false )
		chkDataClassVariable( sub()      , true , false, false, false, false )
	END_TEST

	#macro setDataTypeConst( sym, datatype )
		#if typeof( sym ) = typeof( datatype )
			const is##datatype = true
		#else
			const is##datatype = false
		#endif
	#endmacro

	#macro chkDataType( decltype )
		scope
			dim as decltype x

			setDataTypeConst( x, boolean )
			setDataTypeConst( x, byte )
			setDataTypeConst( x, ubyte )
			setDataTypeConst( x, short )
			setDataTypeConst( x, ushort )
			setDataTypeConst( x, long )
			setDataTypeConst( x, uLong )
			setDataTypeConst( x, integer )
			setDataTypeConst( x, uinteger )
			setDataTypeConst( x, longint )
			setDataTypeConst( x, ulongint )
			setDataTypeConst( x, single )
			setDataTypeConst( x, double )
			setDataTypeConst( x, UDT )
			setDataTypeConst( x, ANYPTR )

			CU_ASSERT( isTypeBoolean( x )  = isBoolean  )
			CU_ASSERT( isTypeByte( x )     = isByte     )
			CU_ASSERT( isTypeUbyte( x )    = isUbyte    )
			CU_ASSERT( isTypeShort( x )    = isShort    )
			CU_ASSERT( isTypeUShort( x )   = isUshort   )
			CU_ASSERT( isTypeLong( x )     = isLong     )
			CU_ASSERT( isTypeULong( x )    = isULong    )
			CU_ASSERT( isTypeInteger( x )  = isInteger  )
			CU_ASSERT( isTypeUInteger( x ) = isUinteger )
			CU_ASSERT( isTypeLongint( x )  = isLongint  )
			CU_ASSERT( isTypeULongint( x ) = isULongint )
			CU_ASSERT( isTypeSingle( x )   = isSingle   )
			CU_ASSERT( isTypeDouble( x )   = isDouble   )
			CU_ASSERT( isTypeUDT( x )      = isUDT      )
			CU_ASSERT( isTypePointer( x )  = isANYPTR  )

		end scope
	#endmacro

	TEST( datatype )
		type UDT
			__ as integer
		end type
		type ANYPTR as any pointer
		chkDataType( boolean )
		chkDataType( byte )
		chkDataType( ubyte )
		chkDataType( short )
		chkDataType( ushort )
		chkDataType( long )
		chkDataType( uLong )
		chkDataType( integer )
		chkDataType( uinteger )
		chkDataType( longint )
		chkDataType( ulongint )
		chkDataType( single )
		chkDataType( double )
		chkDataType( UDT )
		chkDataType( ANYPTR )
	END_TEST

END_SUITE
