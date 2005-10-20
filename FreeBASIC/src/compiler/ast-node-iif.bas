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

'' AST conditional IF nodes
'' l = cond expr, r = link(true expr, false expr)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
function astNewIIF( byval condexpr as ASTNODE ptr, _
					byval truexpr as ASTNODE ptr, _
					byval falsexpr as ASTNODE ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n
    dim as integer truedtype, falsedtype
    dim as FBSYMBOL ptr falselabel

	function = NULL

	if( condexpr = NULL ) then
		exit function
	end if

	truedtype = truexpr->dtype
	falsedtype = falsexpr->dtype

    '' string? invalid
    if( irGetDataClass( truedtype ) = IR_DATACLASS_STRING ) then
    	exit function
    elseif( irGetDataClass( falsedtype ) = IR_DATACLASS_STRING ) then
    	exit function
    end if

	'' UDT's? ditto
	if( truedtype = IR_DATATYPE_USERDEF ) then
		exit function
    elseif( falsedtype = IR_DATATYPE_USERDEF ) then
    	exit function
    end if

    '' are the data types different?
    if( truedtype <> falsedtype ) then
    	if( irMaxDataType( truedtype, falsedtype ) <> INVALID ) then
    		exit function
    	end if
    end if

	falselabel = symbAddLabel( NULL )

	condexpr = astUpdComp2Branch( condexpr, falselabel, FALSE )
	if( condexpr = NULL ) then
		exit function
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_IIF, truedtype, truexpr->subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l  			  = condexpr
	n->r  			  = astNewLINK( truexpr, falsexpr )
	n->iif.falselabel = falselabel

end function

'':::::
function astLoadIIF( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r
    dim as IRVREG ptr vr
    dim as FBSYMBOL ptr exitlabel

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	''
	if( ast.doemit ) then
		'' IR can't handle inter-blocks and live vregs atm, so any
		'' register used must be spilled now or that could happen in a
		'' function call done in any child trees and also if complex
		'' expressions were used
		'''''if( astIsClassOnTree( AST_NODECLASS_FUNCT, n ) <> NULL ) then
		irEmitSPILLREGS( )
		'''''end if
	end if

	''
	astFLush( l )

	''
	exitlabel = symbAddLabel( NULL )

	'' true expr
	vr = astLoad( r->l )
	if( ast.doemit ) then
		irEmitPUSH( vr )
		irEmitBRANCH( IR_OP_JMP, exitlabel )
	end if

	'' false expr
	if( ast.doemit ) then
		irEmitLABELNF( n->iif.falselabel )
	end if

	vr = astLoad( r->r )
    if( ast.doemit ) then
		irEmitPUSH( vr )

		'' exit
		irEmitLABELNF( exitlabel )
		vr = irAllocVREG( n->dtype )
		irEmitPOP( vr )
	end if

	astDel( r->l )
	astDel( r->r )
	astDel( r )

	function = vr

end function

