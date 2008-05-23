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
		/' fb_DataRestore ( byval labeladdrs as void ptr ) as void '/ _
		( _
			@FB_RTL_DATARESTORE, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadStr ( byref dst as any, byval dst_size as integer, _
							byval fillrem as integer = 1 ) as void '/ _
		( _
			@FB_RTL_DATAREADSTR, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		3, _
	 		{ _
	 			( _
	 				FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' fb_DataReadWstr ( byval dst as wstring ptr, _
							 byval dst_size as integer ) as void '/ _
		( _
			@FB_RTL_DATAREADWSTR, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		2, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_WCHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
	 				FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadByte ( byref dst as byte ) as void '/ _
		( _
			@FB_RTL_DATAREADBYTE, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_BYTE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadShort ( byref dst as short ) as void '/ _
		( _
			@FB_RTL_DATAREADSHORT, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_SHORT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadInt ( byref dst as integer ) as void '/ _
		( _
			@FB_RTL_DATAREADINT, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_INTEGER, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadLongint ( byref dst as longint ) as void '/ _
		( _
			@FB_RTL_DATAREADLONGINT, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_LONGINT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadUByte ( byref dst as ubyte ) as void '/ _
		( _
			@FB_RTL_DATAREADUBYTE, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_UBYTE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadUShort ( byref dst as ushort ) as void '/ _
		( _
			@FB_RTL_DATAREADUSHORT, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_USHORT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadUInt ( byref dst as uinteger ) as void '/ _
		( _
			@FB_RTL_DATAREADUINT, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_UINT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadUInt ( byref dst as uinteger ) as void '/ _
		( _
			@FB_RTL_DATAREADPTR, @FB_RTL_DATAREADUINT, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_DUPDECL, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadULongint ( byref dst as ulongint ) as void '/ _
		( _
			@FB_RTL_DATAREADULONGINT, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_ULONGINT, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadSingle ( byref dst as single ) as void '/ _
		( _
			@FB_RTL_DATAREADSINGLE, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_SINGLE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
		/' fb_DataReadDouble ( byref dst as single ) as void '/ _
		( _
			@FB_RTL_DATAREADDOUBLE, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				FB_DATATYPE_DOUBLE, FB_PARAMMODE_BYREF, FALSE _
	 			) _
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
    dim as integer args = any, dtype = any, lgt = any

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

	case FB_DATATYPE_BOOL8
		'' !!!FIXME!!! (BOOL)
		f = PROCLOOKUP( DATAREADBYTE )

	case FB_DATATYPE_BOOL32
		'' !!!FIXME!!! (BOOL)
		f = PROCLOOKUP( DATAREADINT )

	case FB_DATATYPE_BYTE
		f = PROCLOOKUP( DATAREADBYTE )

	case FB_DATATYPE_UBYTE
		f = PROCLOOKUP( DATAREADUBYTE )

	case FB_DATATYPE_SHORT
		f = PROCLOOKUP( DATAREADSHORT )

	case FB_DATATYPE_USHORT
		f = PROCLOOKUP( DATAREADUSHORT )

	case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
		f = PROCLOOKUP( DATAREADINT )

	case FB_DATATYPE_UINT
		f = PROCLOOKUP( DATAREADUINT )

	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			f = PROCLOOKUP( DATAREADINT )
		else
			f = PROCLOOKUP( DATAREADLONGINT )
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			f = PROCLOOKUP( DATAREADUINT )
		else
			f = PROCLOOKUP( DATAREADULONGINT )
		end if

	case FB_DATATYPE_LONGINT
		f = PROCLOOKUP( DATAREADLONGINT )

	case FB_DATATYPE_ULONGINT
		f = PROCLOOKUP( DATAREADULONGINT )

	case FB_DATATYPE_SINGLE
		f = PROCLOOKUP( DATAREADSINGLE )

	case FB_DATATYPE_DOUBLE
		f = PROCLOOKUP( DATAREADDOUBLE )

	case FB_DATATYPE_STRUCT
		exit function						'' illegal

	case FB_DATATYPE_POINTER
		f = PROCLOOKUP( DATAREADPTR )

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
		if( astNewARG( proc, _
					   astNewCONSTi( lgt, FB_DATATYPE_INTEGER ), _
					   FB_DATATYPE_INTEGER ) = NULL ) then
 			exit function
 		end if

		if( args > 2 ) then
			'' byval fillrem as integer
			if( astNewARG( proc, _
						   astNewCONSTi( dtype = FB_DATATYPE_FIXSTR, _
										 FB_DATATYPE_INTEGER ), _
						   FB_DATATYPE_INTEGER ) = NULL ) then
    			exit function
    		end if
    	end if
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
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

    expr = astNewADDROF( astNewVAR( sym, 0, FB_DATATYPE_BYTE ) )
    if( astNewARG( proc, expr ) = NULL ) then
 		exit function
 	end if

	''
	if( afternode = NULL ) then
		astAdd( proc )
	else
		astAddAfter( proc, afternode )
	end if

	function = TRUE

end function

