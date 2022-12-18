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
		/' function fb_ErrorThrowAt cdecl _
			( _
				byval linenum as const long, _
				byval fname as const zstring ptr, _
				byval reslabel as const any ptr, _
				byval resnxtlabel as const any ptr _
			) as FB_ERRHANDLER '/ _
		( _
			@FB_RTL_ERRORTHROW, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ErrorThrowEx cdecl _
			( _
				byval errnum as const long, _
				byval linenum as const long, _
				byval fname as const zstring ptr, _
				byval reslabel as const any ptr, _
				byval resnxtlabel as const any ptr _
			) as FB_ERRHANDLER '/ _
		( _
			@FB_RTL_ERRORTHROWEX, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			5, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ErrorSetHandler( byval newhandler as FB_ERRHANDLER ) as FB_ERRHANDLER '/ _
		( _
			@FB_RTL_ERRORSETHANDLER, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( FB_DATATYPE_VOID ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ErrorGetNum( ) as long '/ _
		( _
			@FB_RTL_ERRORGETNUM, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' function fb_ErrorSetNum( byval errnum as const long ) as long '/ _
		( _
			@FB_RTL_ERRORSETNUM, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ErrorResume cdecl( ) as any ptr '/ _
		( _
			@FB_RTL_ERRORRESUME, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' function fb_ErrorResumeNext cdecl( ) as any ptr '/ _
		( _
			@FB_RTL_ERRORRESUMENEXT, NULL, _
			typeAddrOf( FB_DATATYPE_VOID ), FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' function erl( ) as long '/ _
		( _
			@"erl", @"fb_ErrorGetLineNum", _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' function erfn( ) as zstring ptr '/ _
		( _
			@"erfn", @"fb_ErrorGetFuncName", _
			typeAddrOf( FB_DATATYPE_CHAR ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' function ermn( ) as zstring ptr '/ _
		( _
			@"ermn", @"fb_ErrorGetModName", _
			typeAddrOf( FB_DATATYPE_CHAR ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NOQB, _
			0 _
		), _
		/' function fb_ErrorSetModName( byval mod_name as const zstring ptr ) as zstring ptr '/ _
		( _
			@FB_RTL_ERRORSETMODNAME, NULL, _
			typeAddrOf( FB_DATATYPE_CHAR ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' function fb_ErrorSetFuncName( byval fun_name as const zstring ptr ) as zstring ptr '/ _
		( _
			@FB_RTL_ERRORSETFUNCNAME, NULL, _
			typeAddrOf( FB_DATATYPE_CHAR ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_Assert overload _
			( _
				byval filename as const zstring ptr, _
				byval linenum as const long, _
				byval funcname as const zstring ptr, _
				byval expression as const zstring ptr _
			) '/ _
		( _
			@"fb_Assert", NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			4, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_INTEGER ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_Assert overload alias "fb_AssertW" _
			( _
				byval filename as const zstring ptr, _
				byval linenum as const long, _
				byval funcname as const zstring ptr, _
				byval expression as const wstring ptr _
			) '/ _
		( _
			@"fb_Assert", @"fb_AssertW", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			4, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_AssertWarn overload _
			( _
				byval filename as const zstring ptr, _
				byval linenum as const long, _
				byval funcname as const zstring ptr, _
				byval expression as const zstring ptr _
			) '/ _
		( _
			@"fb_AssertWarn", NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			4, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
			} _
		), _
		/' sub fb_AssertWarn overload alias "fb_AssertWarnW" _
			( _
				byval fname as const zstring ptr, _
				byval linenum as const long, _
				byval funcname as const zstring ptr, _
				byval expression as const wstring ptr _
			) '/ _
		( _
			@"fb_AssertWarn", @"fb_AssertWarnW", _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_OVER, _
			4, _
			{ _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeSetIsConst( FB_DATATYPE_LONG ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_CHAR ) ), FB_PARAMMODE_BYVAL, FALSE ), _
				( typeAddrOf( typeSetIsConst( FB_DATATYPE_WCHAR ) ), FB_PARAMMODE_BYVAL, FALSE ) _
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

private function hErrorThrow _
	( _
		byval reslabel as FBSYMBOL ptr, _
		byval nxtlabel as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc = any, param = any

	'' fb_ErrorThrow( linenum, module, reslabel, resnxtlabel )
	proc = astNewCALL( PROCLOOKUP( ERRORTHROW ) )

	'' linenum
	astNewARG( proc, astNewCONSTi( lexLineNum() ) )

	'' module
	astNewARG( proc, astNewCONSTstr( env.inf.name ) )

	'' reslabel
	if( reslabel ) then
		param = astNewADDROF( astNewVAR( reslabel ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	astNewARG( proc, param )

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDROF( astNewVAR( nxtlabel ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	astNewARG( proc, param )

	'' All the astNewARG()'s should succeed, they're hard-coded, not
	'' supplied by the input code
	assert( proc->call.args = 4 )

	function = proc
end function

'' Note: The rtl error checking code needs to be LINKed with the statement it
'' checks, in order to ensure the resulting single astAdd() will clean up any
'' temp vars from the statement after the whole rtl error checking code,
'' not in the middle of it, where it'd be either too early (during the astAdd()
'' for the reslabel, that'd be before the statement even was executed), or
'' just on one code path of the IF (if it's the astAdd() for the IF check).
'' (astBuildBranch() could be used to fix the 2nd issue, but that still leaves
'' the 1st)
function rtlErrorCheck( byval expr as ASTNODE ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr nxtlabel = any, reslabel = any
	dim as ASTNODE ptr t = NULL

	if( env.clopt.resumeerr ) then
		reslabel = symbAddLabel( NULL )
		t = astNewLINK( t, astNewLABEL( reslabel ), AST_LINK_RETURN_NONE )
	else
		reslabel = NULL
	end if

	if( env.clopt.errorcheck ) then
		'' if expr = 0 then
		nxtlabel = symbAddLabel( NULL )
		t = astNewLINK( t, astNewBOP( AST_OP_EQ, expr, astNewCONSTi( 0 ), nxtlabel, AST_OPOPT_NONE ), AST_LINK_RETURN_NONE )

		'' fb_ErrorThrow()
		t = astNewLINK( t, astNewBRANCH( AST_OP_JUMPPTR, NULL, hErrorThrow( reslabel, nxtlabel ) ), AST_LINK_RETURN_NONE )

		'' end if
		t = astNewLINK( t, astNewLABEL( nxtlabel ), AST_LINK_RETURN_NONE )
	else
		t = astNewLINK( t, expr, AST_LINK_RETURN_NONE )
	end if

	function = t
end function

sub rtlErrorThrow _
	( _
		byval errexpr as ASTNODE ptr, _
		byval linenum as integer, _
		byval module as zstring ptr _
	)

	dim as ASTNODE ptr proc = any, param = any
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
	if( astNewARG( proc, astNewCONSTi( linenum ) ) = NULL ) then
		exit sub
	end if

	'' module
	if( astNewARG( proc, astNewCONSTstr( module ) ) = NULL ) then
		exit sub
	end if

	'' reslabel
	if( env.clopt.resumeerr ) then
		param = astNewADDROF( astNewVAR( reslabel ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	if( astNewARG( proc, param ) = NULL ) then
		exit sub
	end if

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDROF( astNewVAR( nxtlabel ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	if( astNewARG( proc, param ) = NULL ) then
		exit sub
	end if

	'' dst
	astAdd( astNewBRANCH( AST_OP_JUMPPTR, NULL, proc ) )

	astAdd( astNewLABEL( nxtlabel ) )
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
					expr = astNewVAR( .lasthnd )
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

sub rtlErrorResume( byval isnext as integer )
	dim as ASTNODE ptr proc = any
	dim as FBSYMBOL ptr f = any

	if( isnext = FALSE ) then
		f = PROCLOOKUP( ERRORRESUME )
	else
		f = PROCLOOKUP( ERRORRESUMENEXT )
	end if

	proc = astNewCALL( f )

	astAdd( astNewBRANCH( AST_OP_JUMPPTR, NULL, proc ) )
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
			expr = astNewVAR( .lastmod )
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
			expr = astNewVAR( .lastfun )
			function = astNewASSIGN( expr, proc )
		end with
	else
		function = proc
	end if

end function
