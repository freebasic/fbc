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


'' intrinsic runtime lib memory functions (ALLOCATE, SWAP, ...)
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

'' fb_NullPtrChk ( byval p as any ptr, byval linenum as integer, byval fname as zstring ptr ) as any ptr
data @FB_RTL_NULLPTRCHK,"", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_MemCopy cdecl ( dst as any, src as any, byval bytes as integer ) as void
data @FB_RTL_MEMCOPY,"memcpy", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_MemSwap ( dst as any, src as any, byval bytes as integer ) as void
data @FB_RTL_MEMSWAP,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fb_MemCopyClear ( dst as any, byval dstlen as integer, src as any, byval srclen as integer ) as void
data @FB_RTL_MEMCOPYCLEAR,"", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 4, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' fre ( ) as uinteger
data @"fre","fb_GetMemAvail", _
	 FB_DATATYPE_UINT,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,0

'' allocate ( byval bytes as integer ) as any ptr
data @"allocate","malloc", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' callocate ( byval bytes as integer ) as any ptr
data @"callocate","calloc", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,1

'' reallocate ( byval p as any ptr, byval bytes as integer ) as any ptr
data @"reallocate","realloc", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 2, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' deallocate ( byval p as any ptr ) as void
data @"deallocate","free", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE

'' clear ( dst as any, byval value as integer = 0, byval bytes as integer ) as void
data @"clear","memset", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_CDECL, _
	 NULL, FALSE, FALSE, _
	 3, _
	 FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE,0, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' EOL
data NULL


'':::::
sub rtlMemModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlMemModEnd( )

	'' procs will be deleted when symbEnd is called

end sub


'':::::
function rtlNullPtrCheck _
	( _
		byval p as ASTNODE ptr, _
		byval linenum as integer, _
		byval module as zstring ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr proc

   	function = NULL

   	proc = astNewCALL( PROCLOOKUP( NULLPTRCHK ) )

	'' ptr
	p = astNewCONV( AST_OP_TOPOINTER, FB_DATATYPE_POINTER+FB_DATATYPE_VOID, NULL, p )
	if( astNewARG( proc, p, FB_DATATYPE_POINTER+FB_DATATYPE_VOID ) = NULL ) then
		exit function
	end if

	'' linenum
	if( astNewARG( proc, astNewCONSTi( linenum, FB_DATATYPE_INTEGER ), FB_DATATYPE_INTEGER ) = NULL ) then
    	exit function
    end if

    '' module
	if( astNewARG( proc, astNewCONSTstr( module ) ) = NULL ) then
    	exit function
    end if

    function = proc

end function

'':::::
function rtlMemCopy _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr, _
		byval bytes as integer _
	) as ASTNODE ptr static

    dim as ASTNODE ptr proc

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( MEMCOPY ) )

    '' dst as any
    if( astNewARG( proc, dst ) = NULL ) then
    	exit function
    end if

    '' src as any
    if( astNewARG( proc, src ) = NULL ) then
    	exit function
    end if

    '' byval bytes as integer
    if( astNewARG( proc, astNewCONSTi( bytes, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    ''
    function = proc

end function

'':::::
function rtlMemSwap _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr _
	) as integer static

    dim as ASTNODE ptr proc
    dim as integer bytes

    function = FALSE

	'' simple type?
	'' !!!FIXME!!! other classes should be allowed too, but pointers??
	if( (astGetDataType( dst ) <> FB_DATATYPE_USERDEF) and (astIsVAR( dst )) ) then

		'' push src
		astAdd( astNewSTACK( AST_OP_PUSH, astCloneTree( src ) ) )

		'' src = dst
		astAdd( astNewASSIGN( src, astCloneTree( dst ) ) )

		'' pop dst
		astAdd( astNewSTACK( AST_OP_POP, dst ) )

		exit function
	end if

	''
    proc = astNewCALL( PROCLOOKUP( MEMSWAP ) )

    '' always calc len before pushing the param
    bytes = rtlCalcExprLen( dst )

    '' dst as any
    if( astNewARG( proc, dst ) = NULL ) then
    	exit function
    end if

    '' src as any
    if( astNewARG( proc, src ) = NULL ) then
    	exit function
    end if

    '' byval bytes as integer
    if( astNewARG( proc, astNewCONSTi( bytes, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

'':::::
function rtlMemCopyClear _
	( _
		byval dstexpr as ASTNODE ptr, _
		byval dstlen as integer, _
		byval srcexpr as ASTNODE ptr, _
		byval srclen as integer _
	) as integer static

    dim as ASTNODE ptr proc

	function = FALSE

	''
    proc = astNewCALL( PROCLOOKUP( MEMCOPYCLEAR ) )

    '' dst as any
    if( astNewARG( proc, dstexpr ) = NULL ) then
    	exit function
    end if

    '' byval dstlen as integer
    if( astNewARG( proc, astNewCONSTi( dstlen, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    '' src as any
    if( astNewARG( proc, srcexpr ) = NULL ) then
    	exit function
    end if

    '' byval srclen as integer
    if( astNewARG( proc, astNewCONSTi( srclen, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    ''
    astAdd( proc )

    function = TRUE

end function

