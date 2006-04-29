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

'' AST conversion nodes
'' l = expression to convert; r = NULL
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private sub hCONVConstEvalInt( byval dtype as integer, _
							   byval v as ASTNODE ptr ) static

	if( dtype > FB_DATATYPE_POINTER ) then
		dtype = FB_DATATYPE_POINTER
	end if

	select case as const v->dtype
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		select case as const dtype
		case FB_DATATYPE_BYTE
			v->con.val.int = cbyte( v->con.val.long )

		case FB_DATATYPE_UBYTE
			v->con.val.int = cubyte( culngint( v->con.val.long ) )

		case FB_DATATYPE_SHORT
			v->con.val.int = cshort( v->con.val.long )

		case FB_DATATYPE_USHORT
			v->con.val.int = cushort( culngint( v->con.val.long ) )

		case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
			v->con.val.int = cint( v->con.val.long )

		case FB_DATATYPE_UINT, FB_DATATYPE_POINTER
			v->con.val.int = cuint( culngint( v->con.val.long ) )

		end select

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE

		select case as const dtype
		case FB_DATATYPE_BYTE
			v->con.val.int = cbyte( v->con.val.float )

		case FB_DATATYPE_UBYTE
			v->con.val.int = cubyte( v->con.val.float )

		case FB_DATATYPE_SHORT
			v->con.val.int = cshort( v->con.val.float )

		case FB_DATATYPE_USHORT
			v->con.val.int = cushort( v->con.val.float )

		case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
			v->con.val.int = cint( v->con.val.float )

		case FB_DATATYPE_UINT, FB_DATATYPE_POINTER
			v->con.val.int = cuint( v->con.val.float )

		end select

	case else
		select case as const dtype
		case FB_DATATYPE_BYTE
			v->con.val.int = cbyte( v->con.val.int )

		case FB_DATATYPE_UBYTE
			v->con.val.int = cubyte( cuint( v->con.val.int ) )

		case FB_DATATYPE_SHORT
			v->con.val.int = cshort( v->con.val.int )

		case FB_DATATYPE_USHORT
			v->con.val.int = cushort( cuint( v->con.val.int ) )
		end select

	end select

end sub

'':::::
private sub hCONVConstEvalFlt( byval dtype as integer, _
							   byval v as ASTNODE ptr ) static

	dim as integer vdtype

    vdtype = v->dtype
	if( vdtype > FB_DATATYPE_POINTER ) then
		vdtype = FB_DATATYPE_POINTER
	end if

	select case as const vdtype
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		'' do nothing..

	case FB_DATATYPE_LONGINT

		if( dtype = FB_DATATYPE_SINGLE ) then
			v->con.val.float = csng( v->con.val.long )
		else
			v->con.val.float = cdbl( v->con.val.long )
		end if

	case FB_DATATYPE_ULONGINT

		if( dtype = FB_DATATYPE_SINGLE ) then
			v->con.val.float = csng( cunsg( v->con.val.long ) )
		else
			v->con.val.float = cdbl( cunsg( v->con.val.long ) )
		end if

	case FB_DATATYPE_UINT, FB_DATATYPE_POINTER

		if( dtype = FB_DATATYPE_SINGLE ) then
			v->con.val.float = csng( cunsg( v->con.val.int ) )
		else
			v->con.val.float = cdbl( cunsg( v->con.val.int ) )
		end if

	case else

		if( dtype = FB_DATATYPE_SINGLE ) then
			v->con.val.float = csng( v->con.val.int )
		else
			v->con.val.float = cdbl( v->con.val.int )
		end if

	end select

end sub

'':::::
private sub hCONVConstEval64( byval dtype as integer, _
							  byval v as ASTNODE ptr ) static

	select case as const v->dtype
	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		'' do nothing

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		if( dtype = FB_DATATYPE_LONGINT ) then
			v->con.val.long = clngint( v->con.val.float )
		else
			v->con.val.long = culngint( v->con.val.float )
		end if

	case else
		'' when expanding to 64bit, we must take care of signedness of source operand

		if( dtype = FB_DATATYPE_LONGINT ) then
			if( symbIsSigned( v->dtype ) ) then
				v->con.val.long = clngint( v->con.val.int )
			else
				v->con.val.long = clngint( cuint( v->con.val.int ) )
			end if
		else
			if( symbIsSigned( v->dtype ) ) then
				v->con.val.long = culngint( v->con.val.int )
			else
				v->con.val.long = culngint( cuint( v->con.val.int ) )
			end if
		end if

	end select

end sub

'':::::
function astCheckCONV( byval to_dtype as integer, _
					   byval to_subtype as FBSYMBOL ptr, _
					   byval l as ASTNODE ptr _
				     ) as integer static

	function = FALSE

	'' UDT? can't convert..
	if( to_dtype = FB_DATATYPE_USERDEF ) then
		exit function
	end if

    '' string? neither
    if( symbGetDataClass( l->dtype ) = FB_DATACLASS_STRING ) then
    	exit function
	end if

	select case l->dtype
	'' CHAR and WCHAR literals are also from the INTEGER class
    case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    	'' don't allow, unless it's a deref pointer
    	if( astIsPTR( l ) = FALSE ) then
    		exit function
    	end if

    '' UDT's? ditto
    case FB_DATATYPE_USERDEF
    	exit function
    end select

	function = TRUE

end function

'':::::
function astNewCONV( byval op as integer, _
					 byval to_dtype as integer, _
					 byval to_subtype as FBSYMBOL ptr, _
					 byval l as ASTNODE ptr, _
					 byval check_str as integer _
				   ) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer ldclass, ldtype

	function = NULL

    if( l = NULL ) then
    	exit function
    end if

	'' UDT? can't convert..
	if( to_dtype = FB_DATATYPE_USERDEF ) then
		exit function
	end if

    ldtype = l->dtype

    '' pointer typecasting?
    if( op = AST_OP_TOPOINTER ) then
		'' assuming all type-checking was done already
    	astSetType( l, to_dtype, to_subtype )

    	return l

    '' else, to pointer? only allow integers..
    elseif( to_dtype >= FB_DATATYPE_POINTER ) then
		select case as const ldtype
		case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_ENUM
		case else
			if( ldtype < FB_DATATYPE_POINTER ) then
				exit function
			end if
		end select

    '' from pointer? only allow integers..
    elseif( ldtype >= FB_DATATYPE_POINTER ) then
		select case as const to_dtype
		case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_ENUM
		case else
			if( to_dtype < FB_DATATYPE_POINTER ) then
				exit function
			end if
		end select
    end if

    ''
    ldclass = symbGetDataClass( ldtype )

    '' string?
	if( check_str ) then
		select case as const ldtype
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		return rtlStrToVal( l, to_dtype )
    	end select

    else
    	if( ldclass = FB_DATACLASS_STRING ) then
    		exit function

    	'' CHAR and WCHAR literals are also from the INTEGER class
    	else
    		select case ldtype
    		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    			'' don't allow, unless it's a deref pointer
    			if( astIsPTR( l ) = FALSE ) then
    				exit function
    			end if
    	    end select
    	end if
    end if

	'' UDT's? ditto
	if( ldtype = FB_DATATYPE_USERDEF ) then
		exit function
    end if

	'' if it's just a sign conversion, change node's sign and create no new node
	if( op <> INVALID ) then

		'' float? invalid
		if( ldclass <> FB_DATACLASS_INTEGER ) then
			exit function
		end if

		if( op = AST_OP_TOSIGNED ) then
			to_dtype = symbGetSignedType( ldtype )
		else
			to_dtype = symbGetUnsignedType( ldtype )
		end if

		astSetDataType( l, to_dtype )

		return l
	end if

	'' constant? evaluate at compile-time
	if( l->defined ) then

		select case as const to_dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			hCONVConstEval64( to_dtype, l )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			hCONVConstEvalFlt( to_dtype, l )
		case else
			'' byte's, short's, int's and enum's
			hCONVConstEvalInt( to_dtype, l )
		end select

		if( to_dtype <> FB_DATATYPE_ENUM ) then
			l->class = AST_NODECLASS_CONST
		else
			l->class = AST_NODECLASS_ENUM
		end if

		astSetType( l, to_dtype, to_subtype )

		return l
	end if

	'' only convert if the classes are different (ie, floating<->integer) or
	'' if sizes are different (ie, byte<->int)
	if( (ldclass = symbGetDataClass( to_dtype )) and _
		(symbGetDataSize( ldtype ) = symbGetDataSize( to_dtype )) ) then

		astSetType( l, to_dtype, to_subtype )

		return l
	end if

	'' handle special cases..
	if( to_dtype = FB_DATATYPE_ULONGINT ) then
		if( ldclass = FB_DATACLASS_FPOINT ) then
			return rtlMathFp2ULongint( l, ldtype )
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONV, to_dtype, to_subtype )
	if( n = NULL ) then
		exit function
	end if

	n->l  = l

	function = n

end function

'':::::
function astLoadCONV( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l
    dim as IRVREG ptr vs, vr

	l  = n->l

	if( l = NULL ) then
		return NULL
	end if

	vs = astLoad( l )

	if( ast.doemit ) then
		vr = irAllocVREG( n->dtype )
		irEmitCONVERT( vr, n->dtype, vs, INVALID )
	end if

	astDelNode( l )

	function = vr

end function


