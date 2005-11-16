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

'' AST constant nodes
'' l = NULL; r = NULL
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewCONSTstr( byval v as zstring ptr ) as ASTNODE ptr static
    dim as FBSYMBOL ptr tc

	'' assuming no escape sequences are used
	tc = symbAllocStrConst( v, 0 )
    if( tc = NULL ) then
    	exit function
    end if

	function = astNewVAR( tc, 0, IR_DATATYPE_CHAR )

end function

'':::::
function astNewCONSTwstr( byval v as wstring ptr ) as ASTNODE ptr static
    dim as FBSYMBOL ptr tc

	'' assuming no escape sequences are used
	tc = symbAllocWstrConst( v, 0 )
    if( tc = NULL ) then
    	exit function
    end if

	function = astNewVAR( tc, 0, IR_DATATYPE_WCHAR )

end function


'':::::
function astNewCONSTi( byval value as integer, _
					   byval dtype as integer, _
					   byval subtype as FBSYMBOL ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->con.val.int = value
	n->defined = TRUE

end function

'':::::
function astNewCONSTf( byval value as double, _
					   byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->con.val.float = value
	n->defined   = TRUE

end function

'':::::
function astNewCONST64( byval value as longint, _
					    byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->con.val.long  = value
	n->defined   = TRUE

end function

'':::::
function astNewCONST( byval v as FBVALUE ptr, _
					  byval dtype as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_CONST, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	select case as const dtype
	case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
		n->con.val.long = v->long
	case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
		n->con.val.float = v->float
	case else
		n->con.val.int = v->int
	end select

	n->defined = TRUE

end function

'':::::
function astLoadCONST( byval n as ASTNODE ptr ) as IRVREG ptr static
	dim as integer dtype
	dim as FBSYMBOL ptr s

	if( ast.doemit ) then
		dtype = n->dtype

		select case dtype
		'' longints?
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			return irAllocVRIMM64( dtype, n->con.val.long )

		'' if node is a float, create a temp float var (x86 assumption)
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			s = symbAllocFloatConst( n->con.val.float, dtype )
			return irAllocVRVAR( dtype, s, s->ofs )

		''
		case else
			return irAllocVRIMM( dtype, n->con.val.int )
		end select
	end if

end function


