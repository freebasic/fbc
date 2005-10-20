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
			v->val.int = cbyte( v->val.long )

		case IR_DATATYPE_UBYTE
			v->val.int = cubyte( culngint( v->val.long ) )

		case IR_DATATYPE_SHORT
			v->val.int = cshort( v->val.long )

		case IR_DATATYPE_USHORT
			v->val.int = cushort( culngint( v->val.long ) )

		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			v->val.int = cint( v->val.long )

		case IR_DATATYPE_UINT, IR_DATATYPE_POINTER
			v->val.int = cuint( culngint( v->val.long ) )

		end select

	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE

		select case as const dtype
		case IR_DATATYPE_BYTE
			v->val.int = cbyte( v->val.float )

		case IR_DATATYPE_UBYTE
			v->val.int = cubyte( v->val.float )

		case IR_DATATYPE_SHORT
			v->val.int = cshort( v->val.float )

		case IR_DATATYPE_USHORT
			v->val.int = cushort( v->val.float )

		case IR_DATATYPE_INTEGER, IR_DATATYPE_ENUM
			v->val.int = cint( v->val.float )

		case IR_DATATYPE_UINT, IR_DATATYPE_POINTER
			v->val.int = cuint( v->val.float )

		end select

	case else
		select case as const dtype
		case IR_DATATYPE_BYTE
			v->val.int = cbyte( v->val.int )

		case IR_DATATYPE_UBYTE
			v->val.int = cubyte( cuint( v->val.int ) )

		case IR_DATATYPE_SHORT
			v->val.int = cshort( v->val.int )

		case IR_DATATYPE_USHORT
			v->val.int = cushort( cuint( v->val.int ) )
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
			v->val.float = csng( v->val.long )
		else
			v->val.float = cdbl( v->val.long )
		end if

	case IR_DATATYPE_ULONGINT

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->val.float = csng( cunsg( v->val.long ) )
		else
			v->val.float = cdbl( cunsg( v->val.long ) )
		end if

	case IR_DATATYPE_UINT, IR_DATATYPE_POINTER

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->val.float = csng( cunsg( v->val.int ) )
		else
			v->val.float = cdbl( cunsg( v->val.int ) )
		end if

	case else

		if( dtype = IR_DATATYPE_SINGLE ) then
			v->val.float = csng( v->val.int )
		else
			v->val.float = cdbl( v->val.int )
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
			v->val.long = clngint( v->val.float )
		else
			v->val.long = culngint( v->val.float )
		end if

	case else
		'' when expanding to 64bit, we must take care of signedness of source operand

		if( dtype = IR_DATATYPE_LONGINT ) then
			if( irIsSigned( v->dtype ) ) then
				v->val.long = clngint( v->val.int )
			else
				v->val.long = clngint( cuint( v->val.int ) )
			end if
		else
			if( irIsSigned( v->dtype ) ) then
				v->val.long = culngint( v->val.int )
			else
				v->val.long = culngint( cuint( v->val.int ) )
			end if
		end if

	end select

end sub

'':::::
function astNewCONV( byval op as integer, _
					 byval dtype as integer, _
					 byval subtype as FBSYMBOL ptr, _
					 byval l as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer dclass, ldtype

	function = NULL

    if( l = NULL ) then
    	exit function
    end if

    '' pointer typecasting?
    if( op = IR_OP_TOPOINTER ) then

		'' assuming all type-checking was done already

    	l->dtype   = dtype
    	l->subtype = subtype

    	return l
    end if

    ''
    ldtype = l->dtype

    dclass = irGetDataClass( ldtype )

    '' string? can't operate
    if( dclass = IR_DATACLASS_STRING ) then
    	exit function
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
			l->dtype = irGetSignedType( ldtype )
		else
			l->dtype = irGetUnsignedType( ldtype )
		end if

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

		l->dtype   = dtype
		l->subtype = subtype

		return l
	end if

	'' only convert if the classes are different (ie, floating<->integer) or
	'' if sizes are different (ie, byte<->int)
	if( (dclass = irGetDataClass( dtype )) and _
		(irGetDataSize( ldtype ) = irGetDataSize( dtype )) ) then

		l->dtype   = dtype
		l->subtype = subtype

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
    dim as integer dtype
    dim as IRVREG ptr vs, vr

	l  = n->l

	if( l = NULL ) then
		return NULL
	end if

	vs = astLoad( l )

	dtype = n->dtype

	if( ast.doemit ) then
		vr = irAllocVREG( dtype )
		irEmitCONVERT( vr, dtype, vs, INVALID )
	end if

	astDel( l )

	function = vr

end function


