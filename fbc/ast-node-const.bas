''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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

'' AST constant nodes
'' l = NULL; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewCONSTstr _
	( _
		byval v as zstring ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr tc = any

	'' assuming no escape sequences are used
	tc = symbAllocStrConst( v, -1 )
    if( tc = NULL ) then
    	exit function
    end if

	function = astNewVAR( tc, 0, FB_DATATYPE_CHAR )

end function

'':::::
function astNewCONSTwstr _
	( _
		byval v as wstring ptr _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr tc = any

	'' assuming no escape sequences are used
	tc = symbAllocWstrConst( v, -1 )
    if( tc = NULL ) then
    	exit function
    end if

	function = astNewVAR( tc, 0, FB_DATATYPE_WCHAR )

end function


'':::::
function astNewCONSTi _
	( _
		byval value as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->con.val.int = value

	if( hTruncateInt( dtype, @n->con.val.int ) <> FALSE ) then
		errReportWarn( FB_WARNINGMSG_CONVOVERFLOW )
	end if

	n->defined = TRUE

end function

'':::::
function astNewCONSTf _
	( _
		byval value as double, _
		byval dtype as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->con.val.float = value
	n->defined = TRUE

end function

'':::::
function astNewCONSTl _
	( _
		byval value as longint, _
		byval dtype as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->con.val.long  = value
	n->defined = TRUE

end function

'':::::
function astNewCONST _
	( _
		byval v as FBVALUE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	select case as const typeGet( dtype )
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		if( v <> NULL ) then
			n->con.val.long = v->long
		else
			n->con.val.long = 0
		end if

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		if( v <> NULL ) then
			n->con.val.float = v->float
	    else
	    	n->con.val.float = 0.0
	    end if

	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			if( v <> NULL ) then
				n->con.val.int = v->int
			else
				n->con.val.int = 0
			end if
		else
			if( v <> NULL ) then
				n->con.val.long = v->long
			else
				n->con.val.long = 0
			end if
		end if

	case else
		if( v <> NULL ) then
			n->con.val.int = v->int
		else
			n->con.val.int = 0
		end if
	end select

	n->defined = TRUE

end function

'':::::
function astNewCONSTz _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr static

    select case as const typeGet( dtype )
    case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
    	function = astNewCONSTstr( NULL )

    case FB_DATATYPE_WCHAR
    	function = astNewCONSTwstr( NULL )

    case FB_DATATYPE_STRUCT
    	function = astNewCONST( NULL, typeAddrOf( dtype ), subtype )

    case else
    	if( dtype = FB_DATATYPE_INVALID ) then
    		dtype = FB_DATATYPE_INTEGER
    	end if

    	function = astNewCONST( NULL, dtype, subtype )

    end select

end function

'':::::
function astLoadCONST _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	dim as integer dtype = any

	if( ast.doemit ) then
		dtype = astGetDataType( n )

		select case as const typeGet( dtype )
		'' longint?
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			return irAllocVrImm64( dtype, NULL, n->con.val.long )

		'' floating-point?
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			return irAllocVrImmF( dtype, NULL, n->con.val.float )

		'' long?
		case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
			if( FB_LONGSIZE = len( integer ) ) then
				return irAllocVrImm( dtype, NULL, n->con.val.int )
			else
				'' !!!FIXME!!! cross-compilation 32-bit -> 64-bit
				errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
			end if

		''
		case else
			return irAllocVRIMM( dtype, astGetSubtype( n ), n->con.val.int )
		end select
	end if

end function


