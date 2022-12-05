'' intrinsic runtime lib console functions (LOCATE, COLOR, CLS, INKEY, ...)
''
'' chng: oct/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "lex.bi"
#include once "rtl.bi"

#define FB_COLOR_FG_DEFAULT     &h00000001
#define FB_COLOR_BG_DEFAULT     &h00000002

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' function fb_ConsoleView _
			( _
				byval toprow as const long = 0, _
				byval botrow as const long = 0 _
			) as long '/ _
		( _
			@FB_RTL_CONSOLEVIEW, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_ReadXY _
			( _
				byval x as const long, _
				byval y as const long, _
				byval colorflag as const long _
			) as ulong '/ _
		( _
			@FB_RTL_CONSOLEREADXY, NULL, _
			FB_DATATYPE_ULONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function fb_Width _
			( _
				byval cols as const long = -1, _
				byval rows as const long = -1 _
			) as long '/ _
		( _
			@FB_RTL_WIDTH, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function fb_WidthDev( byref dev as const string, byval width as const long = -1 ) as long '/ _
		( _
			@FB_RTL_WIDTHDEV, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_STRING ), FB_PARAMMODE_BYREF, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function fb_WidthFile( byval fnum as const long, byval width as const long = -1 ) as long '/ _
		( _
			@FB_RTL_WIDTHFILE, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function locate _
			( _
				byval row as const long = 0, _
				byval col as const long = 0, _
				byval cursor as const long = -1, _
				byval start as const long = 0, _
				byval stop as const long = 0 _
			) as long '/ _
		( _
			@"locate", @"fb_Locate", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE,0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE,0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, 0 ) _
			} _
		), _
		/' function pos overload( ) as long '/ _
		( _
			@"pos", @"fb_GetX", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			0 _
		), _
		/' function pos overload( byval dummy as const long ) as long '/ _
		( _
			@"pos", @"fb_Pos", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function csrlin( ) as long '/ _
		( _
			@"csrlin", @"fb_GetY", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' sub cls( byval mode as const long = &hFFFF0000 ) '/ _
		( _
			@"cls", @"fb_Cls", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, &hFFFF0000 ) _
			} _
		), _
		/' function fb_Color _
			( _
				byval fc as const ulong, _
				byval bc as const ulong, _
				byval flags as const long _
			) as ulong '/ _
		( _
			@FB_RTL_COLOR, NULL, _
			FB_DATATYPE_ULONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_ULONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function inkey( ) as string '/ _
		( _
			@"inkey", @"fb_Inkey", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_STRSUFFIX or FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' function inkey( ) as string '/ _
		( _
			@"inkey", @"fb_InkeyQB", _
			FB_DATATYPE_STRING, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_STRSUFFIX or FB_RTL_OPT_QBONLY, _
			0 _
		), _
		/' function getkey( ) as long '/ _
		( _
			@"getkey", @"fb_Getkey", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' function pcopy( byval src as const long = -1, byval dst as const long = -1 ) as long '/ _
		( _
			@"pcopy", @"fb_PageCopy", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' function fb_PageSet( byval active as const long = -1, byval visible as const long = -1 ) as long '/ _
		( _
			@FB_RTL_PAGESET, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, TRUE, -1 ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	}

'':::::
sub rtlConsoleModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlConsoleModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlConsoleView _
	( _
		byval topexpr as ASTNODE ptr, _
		byval botexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	''
	proc = astNewCALL( PROCLOOKUP( CONSOLEVIEW ) )

	'' byval toprow as integer
	if( astNewARG( proc, topexpr ) = NULL ) then
		exit function
	end if

	'' byval botrow as integer
	if( astNewARG( proc, botexpr ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlWidthScreen _
	( _
		byval width_arg as ASTNODE ptr, _
		byval height_arg as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	''
	proc = astNewCALL( PROCLOOKUP( WIDTH ) )

	'' byval width_arg as integer
	if( width_arg = NULL ) then
		width_arg = astNewCONSTi( -1 )
	end if
	if( astNewARG( proc, width_arg ) = NULL ) then
		exit function
	end if

	'' byval height_arg as integer
	if( height_arg = NULL ) then
		height_arg = astNewCONSTi( -1 )
	end if
	if( astNewARG( proc, height_arg ) = NULL ) then
		exit function
	end if

	if( isfunc = FALSE ) then
		astAdd( rtlErrorCheck( proc ) )
	end if

	function = proc
end function

'':::::
function rtlColor _
	( _
		byval fexpr as ASTNODE ptr, _
		byval bexpr as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any
	dim as integer flags = any

	function = NULL
	flags = 0

	''
	proc = astNewCALL( PROCLOOKUP( COLOR ) )

	'' byval fore_color as integer
	if( fexpr = NULL ) then
		fexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		flags or= FB_COLOR_FG_DEFAULT
	end if
	if( astNewARG( proc, fexpr ) = NULL ) then
		exit function
	end if

	'' byval back_color as integer
	if( bexpr = NULL ) then
		bexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		flags or= FB_COLOR_BG_DEFAULT
	end if
	if( astNewARG( proc, bexpr ) = NULL ) then
		exit function
	end if

	'' byval flags as integer
	if( astNewARG( proc, astNewCONSTi( flags ) ) = NULL ) then
		exit function
	end if

	if( isfunc = FALSE ) then
		astAdd( proc )
	end if

	function = proc

end function

'':::::
function rtlPageSet _
	( _
		byval active as ASTNODE ptr, _
		byval visible as ASTNODE ptr, _
		byval isfunc as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	''
	proc = astNewCALL( PROCLOOKUP( PAGESET ) )

	'' byval active as integer = -1
	if( active = NULL ) then
		active = astNewCONSTi( -1 )
	end if
	if( astNewARG( proc, active ) = NULL ) then
		exit function
	end if

	'' byval visible as integer = -1
	if( visible = NULL ) then
		visible = astNewCONSTi( -1 )
	end if
	if( astNewARG( proc, visible ) = NULL ) then
		exit function
	end if

	if( isfunc = FALSE ) then
		astAdd( proc )
	end if

	function = proc

end function

'':::::
function rtlConsoleReadXY _
	( _
		byval rowexpr as ASTNODE ptr, _
		byval columnexpr as ASTNODE ptr, _
		byval colorflagexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	''
	proc = astNewCALL( PROCLOOKUP( CONSOLEREADXY ) )

	'' byval column as integer
	if( astNewARG( proc, columnexpr ) = NULL ) then
		exit function
	end if

	'' byval row as integer
	if( astNewARG( proc, rowexpr ) = NULL ) then
		exit function
	end if

	'' byval colorflag as integer
	if( colorflagexpr = NULL ) then
		colorflagexpr = astNewCONSTi( 0 )
	end if
	if( astNewARG( proc, colorflagexpr ) = NULL ) then
		exit function
	end if

	function = proc

end function
