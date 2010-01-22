''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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

'' AST branch nodes (including jump tables)
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' branches (l = link to the stream to be also flushed, if any; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewBRANCH _
	( _
		byval op as integer, _
		byval label as FBSYMBOL ptr, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as integer dtype = any

    if( l = NULL ) then
    	dtype = FB_DATATYPE_INVALID
    else
    	dtype = astGetFullType( l )
    end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_BRANCH, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l = l
	n->op.op = op
	n->op.ex = label
	n->op.options = AST_OPOPT_ALLOCRES

end function

'':::::
function astLoadBRANCH _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any
    dim as IRVREG ptr vr = any

	l  = n->l

	if( l <> NULL ) then
		vr = astLoad( l )
		astDelNode( l )
	else
		vr = NULL
	end if

	if( ast.doemit ) then
		'' pointer?
		if( n->op.ex = NULL ) then
			'' jump or call?
			select case n->op.op
			case AST_OP_JUMPPTR
				irEmitJUMPPTR( vr )

			case AST_OP_CALLPTR
				irEmitCALLPTR( vr, NULL, NULL, 0 )

			case AST_OP_RET
				irEmitRETURN( 0 )
			end select

		else
			irEmitBRANCH( n->op.op, n->op.ex )
		end if
	end if

	function = vr

end function

'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' JMPTB (l = NULL; r = NULL)
'':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function astNewJMPTB_Label _
	( _
		byval dtype as integer, _
		byval label as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_JMPTB, dtype )
	if( n = NULL ) then
		return NULL
	end if

	n->jmptb.op = AST_JMPTB_LABEL
	n->jmptb.label = label

	function = n

end function

'':::::
function astNewJMPTB_Begin _
	( _
		byval s as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_JMPTB, FB_DATATYPE_VOID )

	n->jmptb.op = AST_JMPTB_BEGIN
	n->jmptb.label = s

	function = n

end function

'':::::
function astNewJMPTB_END _
	( _
		byval s as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_JMPTB, FB_DATATYPE_VOID )

	n->jmptb.op = AST_JMPTB_END
	n->jmptb.label = s

	function = n

end function

'':::::
function astLoadJMPTB _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	if( ast.doemit ) then
		irEmitJMPTB( n->jmptb.op, astGetDataType( n ), n->jmptb.label )
	end if

	function = NULL

end function

