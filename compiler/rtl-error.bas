'' intrinsic runtime lib error functions (ERROR, ERR, ERL, RESUME, ...)
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' fb_ErrorThrowAt cdecl ( byval linenum as integer, byval fname as zstring ptr, _
								   byval reslabel as any ptr, _
								   byval resnxtlabel as any ptr ) as integer '/ _
		( _
			@FB_RTL_ERRORTHROW, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_ErrorThrowEx cdecl ( byval errnum as integer, byval linenum as integer, _
								   byval fname as zstring ptr, _
								   byval reslabel as any ptr, _
								   byval resnxtlabel as any ptr ) as any ptr '/ _
		( _
			@FB_RTL_ERRORTHROWEX, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_VOID ),FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_VOID ),FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_ErrorSetHandler( byval newhandler as any ptr ) as any ptr '/ _
		( _
			@FB_RTL_ERRORSETHANDLER, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					typeAddrOf( FB_DATATYPE_VOID ),FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_ErrorGetNum( ) as integer '/ _
		( _
			@FB_RTL_ERRORGETNUM, NULL, _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' fb_ErrorSetNum( byval errnum as integer ) as void '/ _
		( _
			@FB_RTL_ERRORSETNUM, NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_ErrorResume cdecl( ) as any ptr '/ _
		( _
			@FB_RTL_ERRORRESUME, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' fb_ErrorResumeNext cdecl( ) as any ptr '/ _
		( _
			@FB_RTL_ERRORRESUMENEXT, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' ERL ( ) as integer '/ _
		( _
			@"erl", @"fb_ErrorGetLineNum", _
			FB_DATATYPE_INTEGER, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' ERFN ( ) as zstring ptr '/ _
		( _
			@"erfn", @"fb_ErrorGetFuncName", _
			typeAddrOf( FB_DATATYPE_CHAR ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' ERMN ( ) as zstring ptr '/ _
		( _
			@"ermn", @"fb_ErrorGetModName", _
			typeAddrOf( FB_DATATYPE_CHAR ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' fb_ErrorSetModName ( byval modname as zstring ptr ) as zstring ptr '/ _
		( _
			@FB_RTL_ERRORSETMODNAME, NULL, _
			typeAddrOf( FB_DATATYPE_CHAR ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_ErrorSetFuncName ( byval funname as zstring ptr ) as zstring ptr '/ _
		( _
			@FB_RTL_ERRORSETFUNCNAME, NULL, _
			typeAddrOf( FB_DATATYPE_CHAR ), FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
	 		{ _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_Assert ( byval fname as zstring ptr, byval linenum as integer, _
					   byval funcname as zstring ptr, _
					   byval expression as zstring ptr ) as void '/ _
		( _
			@"fb_Assert", NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			4, _
	 		{ _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_AssertW ( byval fname as zstring ptr, byval linenum as integer, _
					    byval funcname as zstring ptr, _
						byval expression as wstring ptr ) as void '/ _
		( _
			@"fb_Assert", @"fb_AssertW", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			4, _
	 		{ _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_WCHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_AssertWarn ( byval fname as zstring ptr, byval linenum as integer, _
						   byval funcname as zstring ptr, _
						   byval expression as zstring ptr ) as void '/ _
		( _
			@"fb_AssertWarn", NULL, _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			4, _
	 		{ _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ),FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_AssertWarnW ( byval fname as zstring ptr, byval linenum as integer, _
						    byval funcname as zstring ptr, _
							byval expression as wstring ptr ) as void '/ _
		( _
			@"fb_AssertWarn", @"fb_AssertWarnW", _
			FB_DATATYPE_VOID, FB_USE_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			4, _
	 		{ _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_CHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					typeAddrOf( FB_DATATYPE_WCHAR ), FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

'':::::
sub rtlErrorModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlErrorModEnd( )

	'' procs will be deleted when symbEnd is called

end sub


'':::::
function rtlErrorCheck _
	( _
		byval resexpr as ASTNODE ptr, _
		byval reslabel as FBSYMBOL ptr, _
		byval linenum as integer _
	) as integer

	dim as ASTNODE ptr proc = any, param = any, dst = any
	dim as FBSYMBOL ptr nxtlabel = any

	function = FALSE

	if( env.clopt.errorcheck = FALSE ) then
		astAdd( resexpr )
		return TRUE
	end if

	''
	proc = astNewCALL( PROCLOOKUP( ERRORTHROW ) )

	''
	nxtlabel = symbAddLabel( NULL )

	'' result >= FB_RTERROR_OK? skip..
	resexpr = astNewBOP( AST_OP_EQ, _
						 resexpr, _
						 astNewCONSTi( 0, FB_DATATYPE_INTEGER ), _
						 nxtlabel, _
						 AST_OPOPT_NONE )

	astAdd( resexpr )

	'' else, fb_ErrorThrow( linenum, module, reslabel, resnxtlabel ); -- CDECL

    '' linenum
	if( astNewARG( proc, astNewCONSTi( linenum, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' module
	if( astNewARG( proc, astNewCONSTstr( env.inf.name ) ) = NULL ) then
    	exit function
    end if

	'' reslabel
	if( reslabel <> NULL ) then
		param = astNewADDROF( astNewVAR( reslabel, 0, FB_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	if( astNewARG( proc, param ) = NULL ) then
		exit function
	end if

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDROF( astNewVAR( nxtlabel, 0, FB_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	if( astNewARG( proc, param ) = NULL ) then
		exit function
	end if

    '' dst
    dst = astNewBRANCH( AST_OP_JUMPPTR, NULL, proc )

    astAdd( dst )

	''
	astAdd( astNewLABEL( nxtlabel ) )

	'''''symbDelLabel nxtlabel
	'''''symbDelLabel reslabel

	function = TRUE

end function

'':::::
sub rtlErrorThrow _
	( _
		byval errexpr as ASTNODE ptr, _
		byval linenum as integer, _
		byval module as zstring ptr _
	)

	dim as ASTNODE ptr proc = any, param = any, dst = any
	dim as FBSYMBOL ptr nxtlabel = any, reslabel = any

	''
	proc = astNewCALL( PROCLOOKUP( ERRORTHROWEX ) )

	''
    reslabel = symbAddLabel( NULL )
    astAdd( astNewLABEL( reslabel ) )

	nxtlabel = symbAddLabel( NULL )

	'' fb_ErrorThrowEx( errnum, linenum, module, reslabel, resnxtlabel );

	'' errnum
	if( astNewARG( proc, errexpr ) = NULL ) then
		exit sub
	end if

    '' linenum
	if( astNewARG( proc, astNewCONSTi( linenum, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit sub
    end if

    '' module
	if( astNewARG( proc, astNewCONSTstr( module ) ) = NULL ) then
    	exit sub
    end if

	'' reslabel
	if( env.clopt.resumeerr ) then
		param = astNewADDROF( astNewVAR( reslabel, 0, FB_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	if( astNewARG( proc, param ) = NULL ) then
		exit sub
	end if

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDROF( astNewVAR( nxtlabel, 0, FB_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	if( astNewARG( proc, param ) = NULL ) then
		exit sub
	end if

    '' dst
    dst = astNewBRANCH( AST_OP_JUMPPTR, NULL, proc )

    astAdd( dst )

	''
	astAdd( astNewLABEL( nxtlabel ) )

	'''''symbDelLabel nxtlabel
	'''''symbDelLabel reslabel

end sub

'':::::
sub rtlErrorSetHandler _
	( _
		byval newhandler as ASTNODE ptr, _
		byval savecurrent as integer _
	)

    dim as ASTNODE ptr proc = any, expr = any

	''
    proc = astNewCALL( PROCLOOKUP( ERRORSETHANDLER ) )

    '' byval newhandler as uint
    if( astNewARG( proc, newhandler ) = NULL ) then
    	exit sub
    end if

    ''
    expr = NULL
    if( savecurrent ) then
    	if( fbIsModLevel( ) = FALSE ) then
    		with parser.currproc->proc.ext->err
    			if( .lasthnd = NULL ) then
					.lasthnd = symbAddTempVar( typeAddrOf( FB_DATATYPE_VOID ) )
                	expr = astNewVAR( .lasthnd, 0, typeAddrOf( FB_DATATYPE_VOID ) )
                	astAdd( astNewASSIGN( expr, proc ) )
    			end if
    		end with
		end if
    end if

    if( expr = NULL ) then
    	astAdd( proc )
    end if

end sub

'':::::
function rtlErrorGetNum _
	( _
		_
	) as ASTNODE ptr

    ''
    function = astNewCALL( PROCLOOKUP( ERRORGETNUM ) )

end function

'':::::
sub rtlErrorSetNum _
	( _
		byval errexpr as ASTNODE ptr _
	)

    dim as ASTNODE ptr proc = any

	''
    proc = astNewCALL( PROCLOOKUP( ERRORSETNUM ) )

    '' byval errnum as integer
    if( astNewARG( proc, errexpr ) = NULL ) then
    	exit sub
    end if

    ''
    astAdd( proc )

end sub

'':::::
sub rtlErrorResume _
	( _
		byval isnext as integer _
	)

    dim as ASTNODE ptr proc = any, dst = any
    dim as FBSYMBOL ptr f = any

	''
	if( isnext = FALSE ) then
		f = PROCLOOKUP( ERRORRESUME )
	else
		f = PROCLOOKUP( ERRORRESUMENEXT )
	end if

	proc = astNewCALL( f )

    ''
    dst = astNewBRANCH( AST_OP_JUMPPTR, NULL, proc )

    astAdd( dst )

end sub

'':::::
function rtlErrorSetModName _
	( _
		byval sym as FBSYMBOL ptr, _
		byval modname as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any, expr = any

	proc = astNewCALL( PROCLOOKUP( ERRORSETMODNAME ) )

    '' byval module as zstring ptr
    if( astNewARG( proc, modname ) = NULL ) then
    	return NULL
    end if

    if( sym <> NULL ) then
    	with sym->proc.ext->err
			.lastmod = symbAddTempVar( typeAddrOf( FB_DATATYPE_CHAR ) )
           	expr = astNewVAR( .lastmod, 0, typeAddrOf( FB_DATATYPE_CHAR ) )
          	function = astNewASSIGN( expr, proc )
    	end with
    else
    	function = proc
    end if

end function

'':::::
function rtlErrorSetFuncName _
	( _
		byval sym as FBSYMBOL ptr, _
		byval funcname as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any, expr = any

	proc = astNewCALL( PROCLOOKUP( ERRORSETFUNCNAME ) )

    '' byval function as zstring ptr
    if( astNewARG( proc, funcname ) = NULL ) then
    	return NULL
    end if

    if( sym <> NULL ) then
    	with sym->proc.ext->err
			.lastfun = symbAddTempVar( typeAddrOf( FB_DATATYPE_CHAR ) )
            expr = astNewVAR( .lastfun, 0, typeAddrOf( FB_DATATYPE_CHAR ) )
            function = astNewASSIGN( expr, proc )
    	end with
    else
    	function = proc
    end if

end function

