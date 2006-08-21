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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 11 ) = _
	{ _
		/' fb_NullPtrChk ( byval p as any ptr, byval linenum as integer, byval fname as zstring ptr ) as any ptr '/ _
		( _
			@FB_RTL_NULLPTRCHK, NULL, _
	 		FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_MemCopy cdecl ( dst as any, src as any, byval bytes as integer ) as void '/ _
		( _
			@FB_RTL_MEMCOPY, @"memcpy", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_MemSwap ( dst as any, src as any, byval bytes as integer ) as void '/ _
		( _
			@FB_RTL_MEMSWAP, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_MemCopyClear ( dst as any, byval dstlen as integer, src as any, byval srclen as integer ) as void '/ _
		( _
			@FB_RTL_MEMCOPYCLEAR, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			4, _
			{ _
				( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fre ( ) as uinteger '/ _
		( _
			@"fre", @"fb_GetMemAvail", _
			FB_DATATYPE_UINT, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			) _
	 		} _
		), _
		/' allocate ( byval bytes as integer ) as any ptr '/ _
		( _
			@"allocate", @"malloc", _
			FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' callocate ( byval bytes as integer ) as any ptr '/ _
		( _
			@"callocate", @"calloc", _
			FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
 			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE, 1 _
	 			) _
	 		} _
		), _
		/' reallocate ( byval p as any ptr, byval bytes as integer ) as any ptr '/ _
		( _
			@"reallocate", @"realloc", _
			FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
 			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' deallocate ( byval p as any ptr ) as void '/ _
		( _
			@"deallocate", @"free", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' clear ( dst as any, byval value as integer = 0, byval bytes as integer ) as void '/ _
		( _
			@"clear", @"memset", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
			3, _
			{ _
				( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, TRUE, 0 _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

'':::::
sub rtlMemModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

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
	p = astNewCONV( FB_DATATYPE_POINTER+FB_DATATYPE_VOID, _
					NULL, _
					p, _
					AST_OP_TOPOINTER )
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
	if( (astGetDataType( dst ) <> FB_DATATYPE_STRUCT) and (astIsVAR( dst )) ) then

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

