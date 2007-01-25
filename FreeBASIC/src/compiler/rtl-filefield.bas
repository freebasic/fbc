''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


'' intrinsic runtime lib file functions (FIELD, GET, PUT)
''
'' chng: jan/2007 written [jeffmarshall]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\lex.bi"
#include once "inc\rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 15 ) = _
	{ _
		/' fb_FileField ( byval filenum as integer, byval args as integer, ... ) as integer '/ _
		( _
			@FB_RTL_FILEFIELD, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			3, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					INVALID, FB_PARAMMODE_VARARG, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileFieldPut ( byval filenum as integer, byval offset as uinteger ) as integer '/ _
		( _
			@FB_RTL_FILEFIELDPUT, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileFieldPutLarge ( byval filenum as integer, byval offset as longint ) as integer '/ _
		( _
			@FB_RTL_FILEFIELDPUTLARGE, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileFieldGet ( byval filenum as integer, byval offset as uinteger ) as integer '/ _
		( _
			@FB_RTL_FILEFIELDGET, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_UINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileFieldGetLarge ( byval filenum as integer, byval offset as longint ) as integer '/ _
		( _
			@FB_RTL_FILEFIELDGETLARGE, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
	 		{ _
	 			( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_LONGINT, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_FileFieldStrDelete ( byref str as string ) as void '/ _
		( _
			@FB_RTL_FILEFIELDSTRDELETE, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_STRING, FB_PARAMMODE_BYREF, FALSE _
				) _
			} _
 		), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }


'':::::
sub rtlFileFieldModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlFileFieldModEnd( )

	'' procs will be deleted when symbEnd is called

end sub


'':::::
function rtlFileField _
	( _
		byval filenum as ASTNODE ptr, _
		byval numfields as integer, _
		byref params as TLIST, _
        byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any, exprsiz = any, exprvar = any
    dim as FBSYMBOL ptr reslabel = any
	dim as integer i

	function = NULL

	''
    proc = astNewCALL( PROCLOOKUP( FILEFIELD ) )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval numfields as integer
    if( astNewARG( proc, astNewCONSTi( numfields, FB_DATATYPE_INTEGER ) ) = NULL ) then
    	exit function
    end if

    '' ...
	dim as FB_RTL_FILE_FIELD_PARAM ptr param = listGetHead( @params )
    for i = 0 to numfields-1

		exprsiz = param->exprsiz
		exprvar = param->exprvar

		'' field size - convert to integer if needed

    	'' check if non-numeric
    	if( astGetDataClass( exprsiz ) >= FB_DATACLASS_STRING ) then
    		errReportEx( FB_ERRMSG_PARAMTYPEMISMATCHAT, "at field: " + str( i+2 ) )
    		exit function
    	end if

    	'' don't allow w|zstring's
    	select case astGetDataType( exprsiz )
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		errReportEx( FB_ERRMSG_PARAMTYPEMISMATCHAT, "at field: " + str( i+2 ) )
    		exit function

    	case FB_DATATYPE_INTEGER

    	case else
    		exprsiz = astNewCONV( FB_DATATYPE_INTEGER, NULL, exprsiz )
    	end select

    	if( astNewARG( proc, exprsiz, FB_DATATYPE_INTEGER ) = NULL ) then
    		exit function
    	end if

		'' field var

		'' astNewARG won't do this for us and we want to
		'' pass a pointer to the descriptor as a vararg.

		exprvar = astNewADDROF( exprvar )
    
		if( astNewARG( proc, exprvar ) = NULL ) then
    		exit function
    	end if

		param = listGetNext( param )

    next

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileFieldPut _
	( _
		byval filenum as ASTNODE ptr, _
		byval offset as ASTNODE ptr, _
        byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as FBSYMBOL ptr reslabel
    dim as integer islarge

	function = FALSE

    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if

	''
	select case as const astGetDataType( offset )
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		islarge = TRUE

	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		islarge = (FB_LONGSIZE <> FB_INTEGERSIZE)

	case else
		islarge = FALSE

	end select

	if( islarge ) then
		f = PROCLOOKUP( FILEFIELDPUTLARGE )
	else
		f = PROCLOOKUP( FILEFIELDPUT )
	end if

	''
    proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function

'':::::
function rtlFileFieldGet _
	( _
		byval filenum as ASTNODE ptr, _
		byval offset as ASTNODE ptr, _
        byval isfunc as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr f
    dim as FBSYMBOL ptr reslabel
    dim as integer islarge

	function = FALSE

    if( offset = NULL ) then
    	offset = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    end if

	''
	select case as const astGetDataType( offset )
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		islarge = TRUE

	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		islarge = (FB_LONGSIZE <> FB_INTEGERSIZE)

	case else
		islarge = FALSE

	end select

	if( islarge ) then
		f = PROCLOOKUP( FILEFIELDGETLARGE )
	else
		f = PROCLOOKUP( FILEFIELDGET )
	end if

	''
    proc = astNewCALL( f )

    '' byval filenum as integer
    if( astNewARG( proc, filenum ) = NULL ) then
 		exit function
 	end if

    '' byval offset as integer
    if( astNewARG( proc, offset ) = NULL ) then
 		exit function
 	end if

    ''
    if( isfunc = FALSE ) then
    	if( env.clopt.resumeerr ) then
    		reslabel = symbAddLabel( NULL )
    		astAdd( astNewLABEL( reslabel ) )
    	else
    		reslabel = NULL
    	end if

    	function = iif( rtlErrorCheck( proc, reslabel, lexLineNum( ) ), proc, NULL )

    else
    	function = proc
    end if

end function


'':::::
function rtlFileFieldStrDelete _
	( _
		byval strg as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr proc = any
    dim as integer dtype = any

	function = NULL

	'' This should only ever be string
    dtype = astGetDataType( strg )
	assert( dtype = FB_DATATYPE_STRING )

   	proc = astNewCALL( PROCLOOKUP( FILEFIELDSTRDELETE ) )

    '' str as string
    if( astNewARG( proc, strg, dtype ) = NULL ) then
    	exit function
    end if

    function = proc

end function
