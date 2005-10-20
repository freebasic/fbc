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

'' AST unary operation nodes
'' l = operand expression; r = NULL
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
private sub hUOPConstFoldInt( byval op as integer, _
						      byval v as ASTNODE ptr ) static

	select case as const op
	case IR_OP_NOT
		v->val.int = not v->val.int

	case IR_OP_NEG
		v->val.int = -v->val.int

	case IR_OP_ABS
		v->val.int = abs( v->val.int )

	case IR_OP_SGN
		v->val.int = sgn( v->val.int )
	end select

end sub

'':::::
private sub hUOPConstFoldFlt( byval op as integer, _
						      byval v as ASTNODE ptr ) static

	select case as const op
	case IR_OP_NOT
		v->val.int = not cint( v->val.float )

	case IR_OP_NEG
		v->val.float = -v->val.float

	case IR_OP_ABS
		v->val.float = abs( v->val.float )

	case IR_OP_SGN
		v->val.int = sgn( v->val.float )

	case IR_OP_SIN
		v->val.float = sin( v->val.float )

	case IR_OP_ASIN
		v->val.float = asin( v->val.float )

	case IR_OP_COS
		v->val.float = cos( v->val.float )

	case IR_OP_ACOS
		v->val.float = acos( v->val.float )

	case IR_OP_TAN
		v->val.float = tan( v->val.float )

	case IR_OP_ATAN
		v->val.float = atn( v->val.float )

	case IR_OP_SQRT
		v->val.float = sqr( v->val.float )

	case IR_OP_LOG
		v->val.float = log( v->val.float )

	case IR_OP_FLOOR
		v->val.float = int( v->val.float )
	end select

end sub

'':::::
private sub hUOPConstFold64( byval op as integer, _
							 byval v as ASTNODE ptr ) static

	select case as const op
	case IR_OP_NOT
		v->val.long = not v->val.long

	case IR_OP_NEG
		v->val.long = -v->val.long

	case IR_OP_ABS
		v->val.long = abs( v->val.long )

	case IR_OP_SGN
		v->val.int = sgn( v->val.long )
	end select

end sub

'':::::
function astNewUOP( byval op as integer, _
					byval o as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer dclass, dtype

	function = NULL

	if( o = NULL ) then
		exit function
	end if

	dtype 	= o->dtype

    '' string? can't operate
    dclass = irGetDataClass( dtype )
    if( dclass = IR_DATACLASS_STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( dtype = IR_DATATYPE_USERDEF ) then
		exit function
    end if

    '' pointer?
    if( dtype >= IR_DATATYPE_POINTER ) then
    	'' only NOT allowed
    	if( op <> IR_OP_NOT ) then
    		exit function
    	end if
    end if

	'' convert byte to integer
	if( irGetDataSize( dtype ) = 1 ) then
		if( irIsSigned( dtype ) ) then
			dtype = IR_DATATYPE_INTEGER
		else
			dtype = IR_DATATYPE_UINT
		end if
		o = astNewCONV( INVALID, dtype, NULL, o )
	end if

	select case as const op
	'' NOT can only operate on integers
	case IR_OP_NOT
		if( dclass <> IR_DATACLASS_INTEGER ) then
			dtype = IR_DATATYPE_INTEGER
			o = astNewCONV( INVALID, dtype, NULL, o )
		end if

	'' with SGN the result is always signed integer
	case IR_OP_SGN
		if( dclass <> IR_DATACLASS_INTEGER ) then
			dtype = IR_DATATYPE_INTEGER
		else
			dtype = irGetSignedType( dtype )
		end if

	'' transcendental can only operate on floats
	case IR_OP_SIN, IR_OP_ASIN, IR_OP_COS, IR_OP_ACOS, _
		 IR_OP_TAN, IR_OP_ATAN, IR_OP_SQRT, IR_OP_LOG, IR_OP_FLOOR
		if( dclass <> IR_DATACLASS_FPOINT ) then
			dtype = IR_DATATYPE_DOUBLE
			o = astNewCONV( INVALID, dtype, NULL, o )
		end if
	end select

	'' constant folding
	if( o->defined ) then

		if( op = IR_OP_NEG ) then
			if( astGetDataClass( o ) = IR_DATACLASS_INTEGER ) then
				if( not irIsSigned( dtype ) ) then
					'' test overflow
					select case dtype
					case IR_DATATYPE_UINT
						if( astGetValInt( o ) and &h80000000 ) then
							if( astGetValInt( o ) <> &h80000000 ) then
								hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
							end if
						end if

					case IR_DATATYPE_ULONGINT
						if( astGetValLong( o ) and &h8000000000000000 ) then
							if( astGetValLong( o ) <> &h8000000000000000 ) then
								hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
							end if
						end if

					case else
						if( -astGetValueAsLongint( o ) < ast_minlimitTB( o->dtype ) ) then
							hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
						end if
					end select

					dtype = irGetSignedType( dtype )
				end if
			end if
		end if

		select case as const o->dtype
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		    hUOPConstFold64( op, o )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			hUOPConstFoldFlt( op, o )
		case else
			'' byte's, short's, int's and enum's
			hUOPConstFoldInt( op, o )
		end select

		o->dtype = dtype

		return o
	end if

	select case as const op
	case IR_OP_SGN
		'' hack! SGN with floats is handled by a function
		if( dclass = IR_DATACLASS_FPOINT ) then
			return rtlMathFSGN( o )
		end if

	case IR_OP_ASIN, IR_OP_ACOS, IR_OP_LOG
		return rtlMathTRANS( op, o )
	end select

	'' alloc new node
	n = astNewNode( AST_NODECLASS_UOP, dtype, o->subtype )
	if( n = NULL ) then
		exit function
	end if

	n->op 		= op
	n->l  		= o
	n->r  		= NULL
	n->allocres	= TRUE
	n->ex 		= NULL

	function = n

end function

'':::::
function astLoadUOP( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr o
    dim as integer op
    dim as IRVREG ptr v1, vr

	o  = n->l
	op = n->op

	if( o = NULL ) then
		return NULL
	end if

	v1 = astLoad( o )

	if( ast.doemit ) then
		if( n->allocres ) then
			vr = irAllocVREG( o->dtype )
		else
			vr = NULL
		end if

		irEmitUOP( op, v1, vr )

		'' "op var" optimizations
		if( vr = NULL ) then
			vr = v1
		end if
	end if

	astDel( o )

	function = vr

end function

