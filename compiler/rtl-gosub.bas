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
		/' fb_GosubPush ( byval ctx as any ptr ptr ) as any ptr '/ _
		( _
			@FB_RTL_GOSUBPUSH, NULL, _
	 		typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				typeMultAddrOf( FB_DATATYPE_VOID, 2 ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' fb_GosubPop ( byval ctx as any ptr ptr ) as integer '/ _
		( _
			@FB_RTL_GOSUBPOP, NULL, _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				typeMultAddrOf( FB_DATATYPE_VOID, 2 ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' fb_GosubReturn ( byval ctx as any ptr ptr ) as integer '/ _
		( _
			@FB_RTL_GOSUBRETURN, NULL, _
	 		FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				typeMultAddrOf( FB_DATATYPE_VOID, 2 ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
		/' fb_GosubExit ( byval ctx as any ptr ptr ) as void '/ _
		( _
			@FB_RTL_GOSUBEXIT, NULL, _
	 		FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				typeMultAddrOf( FB_DATATYPE_VOID, 2 ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

	dim shared as FB_RTL_PROCDEF funcdata1( 0 to ... ) = _
	{ _
		/' fb_SetJmp cdecl ( byval buf as any ptr ) as integer '/ _
		( _
			@FB_RTL_SETJMP, @"_setjmp", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

	dim shared as FB_RTL_PROCDEF funcdata2( 0 to ... ) = _
	{ _
		/' fb_SetJmp cdecl ( byval buf as any ptr ) as integer '/ _
		( _
			@FB_RTL_SETJMP, @"setjmp", _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		1, _
	 		{ _
	 			( _
	 				typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
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
			rtlAddIntrinsicProcs( @funcdata1(0) )
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

'':::::
function rtlGosubReturn _
	( _
		byval ctx as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any

	function = NULL

    proc = astNewCALL( PROCLOOKUP( GOSUBRETURN ) )

    '' byval ctx as any ptr ptr
    if( astNewARG( proc, ctx ) = NULL ) then
    	exit function
    end if

    function = iif( rtlErrorCheck( proc ), proc, NULL )

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

	function = proc

end function
