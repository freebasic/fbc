''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

	if( dtype > IR_DATATYPE_POINTER ) then
		dtype = IR_DATATYPE_POINTER
	end if

	select case as const v->dtype
	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		select case as const dtype
		case IR_DATATYPE_BYTE
			v->con.val.int = cbyte( v->con.val.long )

		case IR_DATATYPE_UBYTE
			v->con.val.int = cubyte( culngint( v->con.val.long ) )

		case IR_DATATYPE_SHORT
			v->con.val.int = cshort( v->con.val.long )

		case IR_DATATYPE_USHORT
			v->con.val.int = cushort( culngint( v->con.val.long ) )

		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			v->con.val.int = cint( v->con.val.long )

		case IR_DATATYPE_UINT, IR_DATATYPE_POINTER
			v->con.val.int = cuint( culngint( v->con.val.long ) )

		end select

	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE

		select case as const dtype
		case IR_DATATYPE_BYTE
			v->con.val.int = cbyte( v->con.val.float )

		case IR_DATATYPE_UBYTE
			v->con.val.int = cubyte( v->con.val.float )

		case IR_DATATYPE_SHORT
			v->con.val.int = cshort( v->con.val.float )

		case IR_DATATYPE_USHORT
			v->con.val.int = cushort( v->con.val.float )

		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			v->con.val.int = cint( v->con.val.float )

		case IR_DATATYPE_UINT, IR_DATATYPE_POINTER
			v->con.val.int = cuint( v->con.val.float )

		end select

	case else
		select case as const dtype
		case IR_DATATYPE_BYTE
			v->con.val.int = cbyte( v->con.val.int )

		case IR_DATATYPE_UBYTE
			v->con.val.int = cubyte( cuint( v->con.val.int ) )

		case IR_DATATYPE_SHORT
			v->con.val.int = cshort( v->con.val.int )

		case IR_DATATYPE_USHORT
			v->con.val.int = cushort( cuint( v->con.val.int ) )
		end select

	end select

end sub

'':::::
private sub hCONVConstEvalFlt( byval dtype as integer, _
							   byval v as ASTNODE ptr ) static

	dim as integer vdtype

    vdtype = v->dtype
	if( vdtype > IR_DATATYPE_POINTER ) then
		vdtype = IR_DATATYPE_POINTER
	end if

	select case as const vdtype
	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		'' do nothing..

	case IR_DATATYPE_LONGINT

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->con.val.float = csng( v->con.val.long )
		else
			v->con.val.float = cdbl( v->con.val.long )
		end if

	case IR_DATATYPE_ULONGINT

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->con.val.float = csng( cunsg( v->con.val.long ) )
		else
			v->con.val.float = cdbl( cunsg( v->con.val.long ) )
		end if

	case IR_DATATYPE_UINT, IR_DATATYPE_POINTER

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->con.val.float = csng( cunsg( v->con.val.int ) )
		else
			v->con.val.float = cdbl( cunsg( v->con.val.int ) )
		end if

	case else

		if( dtype = IR_DATATYPE_SINGLE ) then
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
	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		'' do nothing

	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		if( dtype = IR_DATATYPE_LONGINT ) then
			v->con.val.long = clngint( v->con.val.float )
		else
			v->con.val.long = culngint( v->con.val.float )
		end if

	case else
		'' when expanding to 64bit, we must take care of signedness of source operand

		if( dtype = IR_DATATYPE_LONGINT ) then
			if( irIsSigned( v->dtype ) ) then
				v->con.val.long = clngint( v->con.val.int )
			else
				v->con.val.long = clngint( cuint( v->con.val.int ) )
			end if
		else
			if( irIsSigned( v->dtype ) ) then
				v->con.val.long = culngint( v->con.val.int )
			else
				v->con.val.long = culngint( cuint( v->con.val.int ) )
			end if
		end if

	end select

end sub

'':::::
function astNewCONV( byval op as integer, _
					 byval dtype as integer, _
					 byval subtype as FBSYMBOL ptr, _
					 byval l as ASTNODE ptr, _
					 byval check_str as integer _
				   ) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer dclass, ldtype

	function = NULL

    if( l = NULL ) then
    	exit function
    end if

	'' UDT? can't convert..
	if( dtype = IR_DATATYPE_USERDEF ) then
		exit function
	end if

    '' pointer typecasting?
    if( op = IR_OP_TOPOINTER ) then

		'' assuming all type-checking was done already
    	astSetType( l, dtype, subtype )

    	return l
    end if

    ''
    ldtype = l->dtype
    dclass = irGetDataClass( ldtype )

    '' string?
	if( check_str ) then
		select case as const ldtype
		case IR_DATATYPE_STRING, IR_DATATYPE_FIXSTR, _
			 IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR
    		return rtlStrToVal( l, dtype )
    	end select

    else
    	if( dclass = IR_DATACLASS_STRING ) then
    		exit function

    	'' CHAR and WCHAR literals are also from the INTEGER class
    	else
    		select case ldtype
    		case IR_DATATYPE_CHAR, IR_DATATYPE_WCHAR
    			'' don't allow, unless it's a deref pointer
    			if( not astIsPTR( l ) ) then
    				exit function
    			end if
    	    end select
    	end if
    end if

	'' UDT's? ditto
	if( ldtype = IR_DATATYPE_USERDEF ) then
		exit function
    end if

	'' if it's just a sign conversion, change node's sign and create no new node
	if( op <> INVALID ) then

		'' float? invalid
		if( dclass <> IR_DATACLASS_INTEGER ) then
			exit function
		end if

		if( op = IR_OP_TOSIGNED ) then
			dtype = irGetSignedType( ldtype )
		else
			dtype = irGetUnsignedType( ldtype )
		end if

		astSetDataType( l, dtype )

		return l
	end if

	'' constant? evaluate at compile-time
	if( l->defined ) then

		select case as const dtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			hCONVConstEval64( dtype, l )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			hCONVConstEvalFlt( dtype, l )
		case else
			'' byte's, short's, int's and enum's
			hCONVConstEvalInt( dtype, l )
		end select

		if( dtype <> IR_DATATYPE_ENUM ) then
			l->class = AST_NODECLASS_CONST
		else
			l->class = AST_NODECLASS_ENUM
		end if

		astSetType( l, dtype, subtype )

		return l
	end if

	'' only convert if the classes are different (ie, floating<->integer) or
	'' if sizes are different (ie, byte<->int)
	if( (dclass = irGetDataClass( dtype )) and _
		(irGetDataSize( ldtype ) = irGetDataSize( dtype )) ) then

		astSetType( l, dtype, subtype )

		return l
	end if

	'' handle special cases..
	if( dtype = IR_DATATYPE_ULONGINT ) then
		if( dclass = IR_DATACLASS_FPOINT ) then
			return rtlMathFp2ULongint( l, ldtype )
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONV, dtype, subtype )
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

	astDel( l )

	function = vr

end function


