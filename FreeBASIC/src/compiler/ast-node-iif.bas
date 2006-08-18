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

'' AST conditional IF nodes
'' l = cond expr, r = link(true expr, false expr)
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewIIF _
	( _
		byval condexpr as ASTNODE ptr, _
		byval truexpr as ASTNODE ptr, _
		byval falsexpr as ASTNODE ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr n
    dim as integer true_dtype, false_dtype
    dim as FBSYMBOL ptr falselabel

	function = NULL

	if( condexpr = NULL ) then
		exit function
	end if

	true_dtype = truexpr->dtype
	false_dtype = falsexpr->dtype

    '' string? invalid
    select case symbGetDataClass( true_dtype )
    case FB_DATACLASS_STRING
    	exit function
    case FB_DATACLASS_INTEGER
    	select case true_dtype
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		exit function
    	end select
    end select

    select case symbGetDataClass( false_dtype )
    case FB_DATACLASS_STRING
    	exit function
    case FB_DATACLASS_INTEGER
    	select case false_dtype
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		exit function
    	end select
    end select

	'' UDT's? ditto
	if( true_dtype = FB_DATATYPE_STRUCT ) then
		exit function
    end if

    if( false_dtype = FB_DATATYPE_STRUCT ) then
    	exit function
    end if

    '' are the data types different?
    if( true_dtype <> false_dtype ) then
    	if( symbMaxDataType( true_dtype, false_dtype ) <> INVALID ) then
    		exit function
    	end if
    end if

	falselabel = symbAddLabel( NULL )

	condexpr = astUpdComp2Branch( condexpr, falselabel, FALSE )
	if( condexpr = NULL ) then
		exit function
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_IIF, true_dtype, truexpr->subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->sym = symbAddTempVar( true_dtype, truexpr->subtype )
	n->l = condexpr
	n->r = astNewLINK( truexpr, falsexpr )
	n->iif.falselabel = falselabel

end function

'':::::
function astLoadIIF _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any, r = any, t = any
    dim as FBSYMBOL ptr exitlabel = any

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	if( ast.doemit ) then
		'' IR can't handle inter-blocks and live vregs atm, so any
		'' register used must be spilled now or that could happen in a
		'' function call done in any child trees and also if complex
		'' expressions were used
		'''''if( astIsClassOnTree( AST_NODECLASS_CALL, r->l ) <> NULL ) then
		irEmitSPILLREGS( )
		'''''end if
	end if

	'' condition
	astLoad( l )
	astDelNode( l )

	''
	exitlabel = symbAddLabel( NULL )

	'' true expr
	t = astNewASSIGN( astNewVAR( n->sym, _
								 0, _
								 symbGetType( n->sym ), _
								 symbGetSubType( n->sym ) ), _
					  r->l )
	astLoad( t )
	astDelNode( t )

	if( ast.doemit ) then
		irEmitBRANCH( AST_OP_JMP, exitlabel )
	end if

	'' false expr
	if( ast.doemit ) then
		irEmitLABELNF( n->iif.falselabel )
	end if

	if( ast.doemit ) then
		'' see above
		'''''if( astIsClassOnTree( AST_NODECLASS_CALL, r->r ) <> NULL ) then
		irEmitSPILLREGS( )
		'''''end if
	end if

	t = astNewASSIGN( astNewVAR( n->sym, _
								 0, _
								 symbGetType( n->sym ), _
								 symbGetSubType( n->sym ) ), _
					  r->r )
	astLoad( t )
	astDelNode( t )

    if( ast.doemit ) then
		'' exit
		irEmitLABELNF( exitlabel )
	end if

	t = astNewVAR( n->sym, 0, symbGetType( n->sym ), symbGetSubType( n->sym ) )
	function = astLoad( t )
	astDelNode( t )

	astDelNode( r )

end function

