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

'' AST bound and null-pointer checking nodes
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' Bounds checking (l = index; r = call to checking func(lb, ub))
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewBOUNDCHK _
	( _
		byval l as ASTNODE ptr, _
		byval lb as ASTNODE ptr, _
		byval ub as ASTNODE ptr, _
		byval linenum as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' lbound is a const?
	if( astIsCONST( lb ) ) then
		'' ubound too?
		if( astIsCONST( ub ) ) then
			'' index also?
			if( astIsCONST( l ) ) then
				'' i < lbound?
				if( l->con.val.int < lb->con.val.int ) then
					return NULL
				end if
				'' i > ubound?
				if( l->con.val.int > ub->con.val.int ) then
					return NULL
				end if

				astDelNode( lb )
				astDelNode( ub )
				return l
			end if
		end if

		'' 0? del it
		if( lb->con.val.int = 0 ) then
			astDelNode( lb )
			lb = NULL
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_BOUNDCHK, FB_DATATYPE_INTEGER, NULL )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l = l

	n->sym = symbAddTempVar( astGetDataType( l ), l->subtype, FALSE, FALSE )

    '' check must be done using a function because calling ErrorThrow
    '' would spill used regs only if it was called, causing wrong
    '' assumptions after the branches
	n->r = rtlArrayBoundsCheck( astNewVAR( n->sym, _
    									   0, _
    									   FB_DATATYPE_INTEGER, _
    									   NULL ), _
    						 	lb, _
    						 	ub, _
    						 	linenum, _
    						 	env.inf.name )

end function

'':::::
function astLoadBOUNDCHK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any, r = any, t = any
    dim as FBSYMBOL ptr label = any
    dim as IRVREG ptr vr = any

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' assign to a temp, can't reuse the same vreg or registers could
	'' be spilled as IR can't handle inter-blocks
	t = astNewASSIGN( astNewVAR( n->sym, _
								 0, _
								 FB_DATATYPE_INTEGER, _
								 NULL ), _
					  l )
	astLoad( t )
	astDelNode( t )

    vr = astLoad( r )
    astDelNode( r )

    if( ast.doemit ) then
    	'' handler = boundchk( ... ): if handler <> NULL then handler( )
    	label = symbAddLabel( NULL )
    	irEmitBOPEx( AST_OP_EQ, _
    				 vr, _
    				 irAllocVRIMM( FB_DATATYPE_INTEGER, NULL, 0 ), _
    				 NULL, _
    				 label )
    	irEmitJUMPPTR( vr )
    	irEmitLABELNF( label )
    end if

	''
	'' re-load, see above
	t = astNewVAR( n->sym, 0, FB_DATATYPE_INTEGER, NULL )
	function = astLoad( t )
	astDelNode( t )

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' null pointer checking (l = index; r = call to checking func)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewPTRCHK _
	( _
		byval l as ASTNODE ptr, _
		byval linenum as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as integer dtype = any
    dim as FBSYMBOL ptr subtype = any

	'' constant? don't break OffsetOf() when used with Const's..
	if( l->class = AST_NODECLASS_CONST ) then
		return l
	end if

	'' alloc new node
	dtype = astGetFullType( l )
	subtype = l->subtype
	n = astNewNode( AST_NODECLASS_PTRCHK, dtype, subtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l = l

	n->sym = symbAddTempVar( dtype, subtype, FALSE, FALSE )

    '' check must be done using a function, see bounds checking
    n->r = rtlNullPtrCheck( astNewVAR( n->sym, 0, dtype, subtype ), _
    					 	linenum, _
    					 	env.inf.name )

end function

'':::::
function astLoadPTRCHK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any, r = any, t = any
    dim as FBSYMBOL ptr label = any
    dim as IRVREG ptr vr = any

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' assign to a temp, can't reuse the same vreg or registers could
	'' be spilled as IR can't handle inter-blocks
	t = astNewASSIGN( astNewVAR( n->sym, _
								 0, _
								 symbGetFullType( n->sym ), _
								 symbGetSubType( n->sym ) ), _
					  l )
	astLoad( t )
	astDelNode( t )

    ''
    vr = astLoad( r )
    astDelNode( r )

    if( ast.doemit ) then
    	'' handler = ptrchk( ... ): if handler <> NULL then handler( )
    	label = symbAddLabel( NULL )
    	irEmitBOPEx( AST_OP_EQ, _
    				 vr, _
    				 irAllocVRIMM( FB_DATATYPE_INTEGER, NULL, 0 ), _
    				 NULL, _
    				 label )
    	irEmitJUMPPTR( vr )
    	irEmitLABELNF( label )
    end if

	'' re-load, see above
	t = astNewVAR( n->sym, 0, symbGetFullType( n->sym ), symbGetSubType( n->sym ) )
	function = astLoad( t )
	astDelNode( t )

end function

