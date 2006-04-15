''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' intrinsic runtime lib error functions (ERROR, ERR, ERL, RESUME, ...)
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"


'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

'' fb_ErrorThrowAt cdecl ( byval linenum as integer, byval fname as zstring ptr, _
''						   byval reslabel as any ptr, byval resnxtlabel as any ptr ) as integer
data @FB_RTL_ERRORTHROW,"", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE

''
'' fb_ErrorThrowEx cdecl ( byval errnum as integer, byval linenum as integer, _
''						   byval fname as zstring ptr, _
''						   byval reslabel as any ptr, byval resnxtlabel as any ptr ) as any ptr
data @FB_RTL_ERRORTHROWEX,"", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 5, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE

'' fb_ErrorSetHandler( byval newhandler as any ptr ) as any ptr
data @FB_RTL_ERRORSETHANDLER,"", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE

'' fb_ErrorGetNum( ) as integer
data @FB_RTL_ERRORGETNUM, "", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' fb_ErrorSetNum( byval errnum as integer ) as void
data @FB_RTL_ERRORSETNUM, "", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_ErrorResume( ) as any ptr
data @FB_RTL_ERRORRESUME, "", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 0

'' fb_ErrorResumeNext( ) as any ptr
data @FB_RTL_ERRORRESUMENEXT, "", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 0

'' ERL ( ) as integer
data @"erl", "fb_ErrorGetLineNum", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 0

'' fb_Assert ( byval fname as zstring ptr, byval linenum as integer, _
'''			   byval funcname as zstring ptr, byval expression as zstring ptr ) as void
data @"fb_Assert","", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 4, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_AssertW ( byval fname as zstring ptr, byval linenum as integer, _
'''			    byval funcname as zstring ptr, byval expression as wstring ptr ) as void
data @"fb_Assert","fb_AssertW", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 4, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_AssertWarn ( byval fname as zstring ptr, byval linenum as integer, _
''				   byval funcname as zstring ptr, byval expression as zstring ptr ) as void
data @"fb_AssertWarn","", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 4, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_AssertWarnW ( byval fname as zstring ptr, byval linenum as integer, _
''				    byval funcname as zstring ptr, byval expression as wstring ptr ) as void
data @"fb_AssertWarn","fb_AssertWarnW", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, TRUE, _
	 4, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR,FB_PARAMMODE_BYVAL, FALSE

'' EOL
data NULL


'':::::
sub rtlErrorModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlErrorModEnd( )

	'' procs will be deleted when symbEnd is called

end sub


'':::::
function rtlErrorCheck( byval resexpr as ASTNODE ptr, _
						byval reslabel as FBSYMBOL ptr, _
						byval linenum as integer ) as integer static

	dim as ASTNODE ptr proc, param, dst
	dim as FBSYMBOL ptr nxtlabel

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
	resexpr = astNewBOP( AST_OP_EQ, resexpr, astNewCONSTi( 0, FB_DATATYPE_INTEGER ), nxtlabel, FALSE )

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
		param = astNewADDR( AST_OP_ADDROF, astNewVAR( reslabel, 0, FB_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	if( astNewARG( proc, param ) = NULL ) then
		exit function
	end if

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDR( AST_OP_ADDROF, astNewVAR( nxtlabel, 0, FB_DATATYPE_BYTE ) )
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
sub rtlErrorThrow( byval errexpr as ASTNODE ptr, _
				   byval linenum as integer, _
				   byval module as zstring ptr _
				 ) static

	dim as ASTNODE ptr proc, param, dst
	dim as FBSYMBOL ptr nxtlabel, reslabel

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
		param = astNewADDR( AST_OP_ADDROF, astNewVAR( reslabel, 0, FB_DATATYPE_BYTE ) )
	else
		param = astNewCONSTi( NULL, FB_DATATYPE_UINT )
	end if
	if( astNewARG( proc, param ) = NULL ) then
		exit sub
	end if

	'' resnxtlabel
	if( env.clopt.resumeerr ) then
		param = astNewADDR( AST_OP_ADDROF, astNewVAR( nxtlabel, 0, FB_DATATYPE_BYTE ) )
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
sub rtlErrorSetHandler( byval newhandler as ASTNODE ptr, _
						byval savecurrent as integer ) static

    dim as ASTNODE ptr proc, expr

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
    		if( env.procerrorhnd = NULL ) then
				env.procerrorhnd = symbAddTempVar( FB_DATATYPE_POINTER+FB_DATATYPE_VOID )
                expr = astNewVAR( env.procerrorhnd, 0, FB_DATATYPE_POINTER+FB_DATATYPE_VOID )
                astAdd( astNewASSIGN( expr, proc ) )
    		end if
		end if
    end if

    if( expr = NULL ) then
    	astAdd( proc )
    end if

end sub

'':::::
function rtlErrorGetNum as ASTNODE ptr static
    dim as ASTNODE ptr proc

	''
    proc = astNewCALL( PROCLOOKUP( ERRORGETNUM ) )

    ''
    function = proc

end function

'':::::
sub rtlErrorSetNum( byval errexpr as ASTNODE ptr ) static
    dim as ASTNODE ptr proc

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
sub rtlErrorResume( byval isnext as integer )
    dim as ASTNODE ptr proc, dst
    dim as FBSYMBOL ptr f

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

