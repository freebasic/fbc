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

'' AST misc nodes
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' labels (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLABEL( byval sym as FBSYMBOL ptr, _
					  byval doflush as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_LABEL, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->sym	= sym
	n->lbl.flush = doflush

	if( symbIsLabel( sym ) ) then
		if( symbGetLabelIsDeclared( sym ) = FALSE ) then
			symbSetLabelIsDeclared( sym )
			symbGetLabelStmt( sym ) = env.stmtcnt
			symbGetLabelParent( sym ) = env.currblock
		end if
	end if

	function = n

end function

'':::::
function astLoadLABEL( byval n as ASTNODE ptr ) as IRVREG ptr

	if( ast.doemit ) then
		if( n->lbl.flush ) then
			irEmitLABEL( n->sym )
		else
			irEmitLABELNF( n->sym )
		end if
	end if

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lit (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewLIT( byval text as zstring ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_LIT, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->lit.text = ZstrAllocate( len( *text ) )
	*n->lit.text  = *text

	function = n

end function

'':::::
function astLoadLIT( byval n as ASTNODE ptr ) as IRVREG ptr

	if( ast.doemit ) then
		irEmitCOMMENT( n->lit.text )
	end if

	ZstrFree( n->lit.text )

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' ASM (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewASM( byval listhead as FB_ASMTOK_ ptr ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ASM, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->asm.head = listhead

	function = n

end function

'':::::
function astLoadASM( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as FB_ASMTOK ptr node, nxt
    dim as string asmline

	asmline = ""

	node = n->asm.head
	do while( node <> NULL )
		nxt = node->next

		if( ast.doemit ) then
			select case node->type
			case FB_ASMTOK_SYMB
				asmline += emitGetVarName( node->sym )
			case FB_ASMTOK_TEXT
				asmline += *node->text
			end select
		end if

		if( node->type = FB_ASMTOK_TEXT ) then
			ZstrFree( node->text )
		end if

		listDelNode( @env.asmtoklist, node )
		node = nxt
	loop

	if( ast.doemit ) then
		if( len( asmline ) > 0 ) then
			irEmitASM( asmline )
		end if
	end if

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' DBG (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewDBG( byval op as integer, _
				    byval ex as integer ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	if( env.clopt.debug = FALSE ) then
		exit function
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_DBG, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->dbg.op  = op
	n->dbg.ex  = ex

	function = n

end function

'':::::
function astLoadDBG( byval n as ASTNODE ptr ) as IRVREG ptr

	if( ast.doemit ) then
		irEmitDBG( ast.proc.curr->sym, n->dbg.op, n->dbg.ex )
	end if

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' memory (l = destine; r = source)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewMEM( byval op as integer, _
					byval l as ASTNODE ptr, _
					byval r as ASTNODE ptr, _
					byval bytes as integer ) as ASTNODE ptr static

    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_MEM, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	n->mem.op  = op
	n->l	   = l
	n->r	   = r
	n->mem.bytes = bytes

	function = n

end function

'':::::
function astLoadMEM( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l, r
    dim as IRVREG ptr v1, v2

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	v1 = astLoad( l )
	v2 = astLoad( r )

	if( ast.doemit ) then
		irEmitMEM( n->mem.op, v1, v2, n->mem.bytes )
	end if

	astDelNode( l )
	astDelNode( r )

	function = NULL

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' No Operation (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewNOP( ) as ASTNODE ptr static
    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_NOP, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	function = n

end function

