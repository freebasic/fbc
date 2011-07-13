'' AST branch nodes (including jump tables)
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

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

