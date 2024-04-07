'' rtlib support for GOSUB/RETURN (using setjmp/longjmp)
''
'' chng: apr/2008 written [jeffm]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "lex.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' function fb_GosubPush( byval ctx as any ptr ptr ) as any ptr '/ _
		( _
			@FB_RTL_GOSUBPUSH, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeMultAddrOf( FB_DATATYPE_VOID, 2 ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_GosubPop( byval ctx as any ptr ptr ) as long '/ _
		( _
			@FB_RTL_GOSUBPOP, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeMultAddrOf( FB_DATATYPE_VOID, 2 ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_GosubReturn( byval ctx as any ptr ptr ) as long '/ _
		( _
			@FB_RTL_GOSUBRETURN, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeMultAddrOf( FB_DATATYPE_VOID, 2 ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_GosubExit( byval ctx as any ptr ptr ) '/ _
		( _
			@FB_RTL_GOSUBEXIT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeMultAddrOf( FB_DATATYPE_VOID, 2 ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	 }

	'' Win32 _setjmp()
	dim shared as FB_RTL_PROCDEF funcdata1_win32( 0 to ... ) = _
	{ _
		/' function fb_SetJmp cdecl( byval buf as any ptr ) as long '/ _
		( _
			@FB_RTL_SETJMP, @"_setjmp", _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	 }

	'' Win64 _setjmp()
	dim shared as FB_RTL_PROCDEF funcdata1_win64( 0 to ... ) = _
	{ _
		/' function fb_SetJmp cdecl( byval buf as any ptr ) as long '/ _
		( _
			@FB_RTL_SETJMP, @"_setjmp", _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	 }

	'' Linux/DOS setjmp()
	dim shared as FB_RTL_PROCDEF funcdata2( 0 to ... ) = _
	{ _
		/' function fb_SetJmp cdecl( byval buf as any ptr ) as long '/ _
		( _
			@FB_RTL_SETJMP, @"setjmp", _
			FB_DATATYPE_LONG, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	 }

'':::::
sub rtlGosubModInit( )

	'' No need to add these procs if GOSUB isn't allowed in the dialect...
	if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) ) then

		rtlAddIntrinsicProcs( @funcdata(0) )

		if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
			if( fbIs64bit() ) then
				rtlAddIntrinsicProcs( @funcdata1_win64(0) )
			else
				rtlAddIntrinsicProcs( @funcdata1_win32(0) )
			end if
		else
			rtlAddIntrinsicProcs( @funcdata2(0) )
		end if

	end if

end sub

'':::::
sub rtlGosubModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlGosubPush _
	( _
		byval ctx as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( GOSUBPUSH ) )

	'' byval ctx as any ptr ptr
	if( astNewARG( proc, ctx ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlGosubPop _
	( _
		byval ctx as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( GOSUBPOP ) )

	'' byval ctx as any ptr ptr
	if( astNewARG( proc, ctx ) = NULL ) then
		exit function
	end if

	function = proc

end function

function rtlGosubReturn( byval ctx as ASTNODE ptr ) as integer
	dim as ASTNODE ptr proc = any

	proc = astNewCALL( PROCLOOKUP( GOSUBRETURN ) )

	'' byval ctx as any ptr ptr
	if( astNewARG( proc, ctx ) = NULL ) then
		exit function
	end if

	astAdd( rtlErrorCheck( proc ) )
	function = TRUE
end function

'':::::
function rtlGosubExit _
	( _
		byval ctx as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( GOSUBEXIT ) )

	'' byval ctx as any ptr ptr
	if( astNewARG( proc, ctx ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlSetJmp _
	( _
		byval ctx as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any

	function = NULL

	proc = astNewCALL( PROCLOOKUP( SETJMP ) )

	'' byval ctx as any ptr ptr
	if( astNewARG( proc, ctx ) = NULL ) then
		exit function
	end if

	'' mingw 64bit takes 2 arguments
	'' see also ast-gosub.bas:astGosubAddJump()
	''
	'' from win64 setjmp.h it looks like mingw_getsp() is needed for the second
	'' parameter, but this causes the longjmp() to fail later in msvcrt/ntdll.
	'' It appears that when the second parameter is NULL, then there is no
	'' extra actions taken in the stack unwind and gosub 'works'.  Maybe the
	'' second parameter is for an exception record?  The documentation on this
	'' is scarce.

	if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
		if( fbIs64bit() ) then
			if( astNewARG( proc, astNewCONSTi( 0 ) ) = NULL ) then
				exit function
			end if
		end if
	end if

	function = proc

end function
