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
	case AST_OP_NOT
		v->con.val.int = not v->con.val.int

	case AST_OP_NEG
		v->con.val.int = -v->con.val.int

	case AST_OP_ABS
		v->con.val.int = abs( v->con.val.int )

	case AST_OP_SGN
		v->con.val.int = sgn( v->con.val.int )
	end select

end sub

'':::::
private sub hUOPConstFoldFlt( byval op as integer, _
						      byval v as ASTNODE ptr ) static

	select case as const op
	case AST_OP_NOT
		v->con.val.int = not cint( v->con.val.float )

	case AST_OP_NEG
		v->con.val.float = -v->con.val.float

	case AST_OP_ABS
		v->con.val.float = abs( v->con.val.float )

	case AST_OP_SGN
		v->con.val.int = sgn( v->con.val.float )

	case AST_OP_SIN
		v->con.val.float = sin( v->con.val.float )

	case AST_OP_ASIN
		v->con.val.float = asin( v->con.val.float )

	case AST_OP_COS
		v->con.val.float = cos( v->con.val.float )

	case AST_OP_ACOS
		v->con.val.float = acos( v->con.val.float )

	case AST_OP_TAN
		v->con.val.float = tan( v->con.val.float )

	case AST_OP_ATAN
		v->con.val.float = atn( v->con.val.float )

	case AST_OP_SQRT
		v->con.val.float = sqr( v->con.val.float )

	case AST_OP_LOG
		v->con.val.float = log( v->con.val.float )

	case AST_OP_FLOOR
		v->con.val.float = int( v->con.val.float )
	end select

end sub

'':::::
private sub hUOPConstFold64( byval op as integer, _
							 byval v as ASTNODE ptr ) static

	select case as const op
	case AST_OP_NOT
		v->con.val.long = not v->con.val.long

	case AST_OP_NEG
		v->con.val.long = -v->con.val.long

	case AST_OP_ABS
		v->con.val.long = abs( v->con.val.long )

	case AST_OP_SGN
		v->con.val.int = sgn( v->con.val.long )
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
    dclass = symbGetDataClass( dtype )
    if( dclass = FB_DATACLASS_STRING ) then
    	exit function
    end if

    select case dtype
    '' CHAR and WCHAR literals are also from the INTEGER class..
    case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    	'' only if it's a deref pointer, to allow "NOT *p" etc
    	if( astIsPTR( o ) = FALSE ) then
    		exit function
    	end if

    '' UDT's?
    case FB_DATATYPE_USERDEF
    	exit function

	'' pointer?
	case IS >= FB_DATATYPE_POINTER
    	'' only NOT allowed
    	if( op <> AST_OP_NOT ) then
    		exit function
    	end if
    end select

	'' convert byte to integer
	if( symbGetDataSize( dtype ) = 1 ) then
		if( symbIsSigned( dtype ) ) then
			dtype = FB_DATATYPE_INTEGER
		else
			dtype = FB_DATATYPE_UINT
		end if
		o = astNewCONV( INVALID, dtype, NULL, o )
	end if

	select case as const op
	'' NOT can only operate on integers
	case AST_OP_NOT
		if( dclass <> FB_DATACLASS_INTEGER ) then
			dtype = FB_DATATYPE_INTEGER
			o = astNewCONV( INVALID, dtype, NULL, o )
		end if

	'' with SGN the result is always signed integer
	case AST_OP_SGN
		if( dclass <> FB_DATACLASS_INTEGER ) then
			dtype = FB_DATATYPE_INTEGER
		else
			dtype = symbGetSignedType( dtype )
		end if

	'' transcendental can only operate on floats
	case AST_OP_SIN, AST_OP_ASIN, AST_OP_COS, AST_OP_ACOS, _
		 AST_OP_TAN, AST_OP_ATAN, AST_OP_SQRT, AST_OP_LOG, AST_OP_FLOOR
		if( dclass <> FB_DATACLASS_FPOINT ) then
			dtype = FB_DATATYPE_DOUBLE
			o = astNewCONV( INVALID, dtype, NULL, o )
		end if
	end select

	'' constant folding
	if( o->defined ) then

		if( op = AST_OP_NEG ) then
			if( astGetDataClass( o ) = FB_DATACLASS_INTEGER ) then
				if( symbIsSigned( dtype ) = FALSE ) then
					'' test overflow
					select case dtype
					case FB_DATATYPE_UINT
						if( astGetValInt( o ) and &h80000000 ) then
							if( astGetValInt( o ) <> &h80000000 ) then
								hReportWarning( FB_WARNINGMSG_IMPLICITCONVERSION )
							end if
						end if

					case FB_DATATYPE_ULONGINT
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

					dtype = symbGetSignedType( dtype )
				end if
			end if
		end if

		select case as const o->dtype
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		    hUOPConstFold64( op, o )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			hUOPConstFoldFlt( op, o )
		case else
			'' byte's, short's, int's and enum's
			hUOPConstFoldInt( op, o )
		end select

		astSetDataType( o, dtype )

		return o
	end if

	select case as const op
	case AST_OP_SGN
		'' hack! SGN with floats is handled by a function
		if( dclass = FB_DATACLASS_FPOINT ) then
			return rtlMathFSGN( o )
		end if

	case AST_OP_ASIN, AST_OP_ACOS, AST_OP_LOG
		return rtlMathTRANS( op, o )
	end select

	'' alloc new node
	n = astNewNode( AST_NODECLASS_UOP, dtype, o->subtype )
	if( n = NULL ) then
		exit function
	end if

	n->l  		= o
	n->r  		= NULL
	n->op.op	= op
	n->op.ex	= NULL
	n->op.allocres = TRUE

	function = n

end function

'':::::
function astLoadUOP( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr o
    dim as integer op
    dim as IRVREG ptr v1, vr

	o  = n->l
	op = n->op.op

	if( o = NULL ) then
		return NULL
	end if

	v1 = astLoad( o )

	if( ast.doemit ) then
		if( n->op.allocres ) then
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

	astDelNode( o )

	function = vr

end function

