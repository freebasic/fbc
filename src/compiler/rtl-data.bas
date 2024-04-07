'' intrinsic runtime lib data functions (DATA, RESTORE, READ)
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

'' globals
	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' sub fb_DataRestore( byval labeladdr as FB_DATADESC ptr ) '/ _
		( _
			@FB_RTL_DATARESTORE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_DataReadStr _
			( _
				byref dst as any, _
				byval dst_size as const integer, _
				byval fillrem as const long = 1 _
			) '/ _
		( _
			@FB_RTL_DATAREADSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 1 ) _
			} _
		), _
		/' sub fb_DataReadWstr( byval dst as wstring ptr, byval dst_size as const integer ) '/ _
		( _
			@FB_RTL_DATAREADWSTR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_DataReadBool( byref dst as boolean ) '/ _
		( _
			@FB_RTL_DATAREADBOOL, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			1, _
			{ _
				( FB_DATATYPE_BOOLEAN, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadByte( byref dst as byte ) '/ _
		( _
			@FB_RTL_DATAREADBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_BYTE, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadShort( byref dst as short ) '/ _
		( _
			@FB_RTL_DATAREADSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_SHORT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadInt( byref dst as long ) '/ _
		( _
			@FB_RTL_DATAREADINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_LONG, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadLongint( byref dst as longint ) '/ _
		( _
			@FB_RTL_DATAREADLONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadUByte( byref dst as ubyte ) '/ _
		( _
			@FB_RTL_DATAREADUBYTE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_UBYTE, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadUShort( byref dst as ushort ) '/ _
		( _
			@FB_RTL_DATAREADUSHORT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_USHORT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadUInt( byref dst as ulong ) '/ _
		( _
			@FB_RTL_DATAREADUINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_ULONG, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadULongint( byref dst as ulongint ) '/ _
		( _
			@FB_RTL_DATAREADULONGINT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadSingle( byref dst as single ) '/ _
		( _
			@FB_RTL_DATAREADSINGLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' sub fb_DataReadDouble( byref dst as single ) '/ _
		( _
			@FB_RTL_DATAREADDOUBLE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	}

'':::::
sub rtlDataModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlDataModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlDataRead _
	( _
		byval varexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any
	dim as integer args = any, dtype = any
	dim as longint lgt = any

	function = FALSE

	f = NULL
	args = 1
	dtype = astGetDataType( varexpr )

	select case as const typeGet( dtype )
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		f = PROCLOOKUP( DATAREADSTR )
		args = 3

	case FB_DATATYPE_WCHAR
		f = PROCLOOKUP( DATAREADWSTR )
		args = 2

	case FB_DATATYPE_BOOLEAN
		f = PROCLOOKUP( DATAREADBOOL )

	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, _
	     FB_DATATYPE_SHORT, FB_DATATYPE_USHORT, _
	     FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM, FB_DATATYPE_UINT, _
	     FB_DATATYPE_LONG, FB_DATATYPE_ULONG, FB_DATATYPE_POINTER, _
	     FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT

		select case as const( typeGetSizeType( dtype ) )
		case FB_SIZETYPE_INT8   : f = PROCLOOKUP( DATAREADBYTE )
		case FB_SIZETYPE_UINT8  : f = PROCLOOKUP( DATAREADUBYTE )
		case FB_SIZETYPE_INT16  : f = PROCLOOKUP( DATAREADSHORT )
		case FB_SIZETYPE_UINT16 : f = PROCLOOKUP( DATAREADUSHORT )
		case FB_SIZETYPE_INT32  : f = PROCLOOKUP( DATAREADINT )
		case FB_SIZETYPE_UINT32 : f = PROCLOOKUP( DATAREADUINT )
		case FB_SIZETYPE_INT64  : f = PROCLOOKUP( DATAREADLONGINT )
		case FB_SIZETYPE_UINT64 : f = PROCLOOKUP( DATAREADULONGINT )
		end select

	case FB_DATATYPE_SINGLE
		f = PROCLOOKUP( DATAREADSINGLE )

	case FB_DATATYPE_DOUBLE
		f = PROCLOOKUP( DATAREADDOUBLE )

	case FB_DATATYPE_STRUCT
		exit function                       '' illegal

	case else
		exit function
	end select

	if( f = NULL ) then
		exit function
	end if

	proc = astNewCALL( f )

	if( args > 1 ) then
		'' always calc len before pushing the param
		lgt = rtlCalcStrLen( varexpr, dtype )
	else
		lgt = 0
	end if

	'' byref var as any
	if( astNewARG( proc, varexpr ) = NULL ) then
		exit function
	end if

	if( args > 1 ) then
		'' byval dst_size as integer
		if( astNewARG( proc, astNewCONSTi( lgt ) ) = NULL ) then
			exit function
		end if

		if( args > 2 ) then
			'' byval fillrem as integer
			if( astNewARG( proc, astNewCONSTi( dtype = FB_DATATYPE_FIXSTR ) ) = NULL ) then
				exit function
			end if
		end if
	end if

	''
	astAdd( proc )

	function = TRUE

end function

function rtlDataRestore _
	( _
		byval label as FBSYMBOL ptr, _
		byval afternode as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr proc = any, expr = any
	dim as FBSYMBOL ptr sym = any

	function = FALSE

	proc = astNewCALL( PROCLOOKUP( DATARESTORE ), NULL )

	'' byval labeladdrs as void ptr
	if( label = NULL ) then
		'' blank RESTORE (no label), so use label of first DATA
		sym = astGetFirstDataStmtSymbol( )

		'' blank RESTORE used before any DATA was found? damn..
		if( sym = NULL ) then
			'' create an empty stmt, it should just contain a link to the next DATA
			expr = astDataStmtBegin( )
			astDataStmtEnd( expr )
			astDelNode( expr )

			sym = astGetFirstDataStmtSymbol( )
		end if
	else
		sym = astDataStmtAdd( label, 0 )
	end if

	if( astNewARG( proc, astNewADDROF( astNewVAR( sym ) ) ) = NULL ) then
		exit function
	end if

	if( afternode = NULL ) then
		astAdd( proc )
	else
		astAddAfter( proc, afternode )
	end if

	function = TRUE
end function
