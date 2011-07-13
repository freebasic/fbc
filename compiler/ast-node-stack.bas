'' AST stack nodes
'' l = expression; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
function astNewSTACK _
	( _
		byval op as integer, _
		byval l as ASTNODE ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

    if( l = NULL ) then
    	return NULL
    end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_STACK, astGetFullType( l ), NULL )
	if( n = NULL ) then
		return NULL
	end if

	n->stack.op = op
	n->l = l

	function = n

end function

'':::::
function astLoadSTACK _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any
    dim as IRVREG ptr vr = any

	l  = n->l
	if( l = NULL ) then
		return NULL
	end if

	vr = astLoad( l )

	if( ast.doemit ) then
		irEmitSTACK( n->stack.op, vr )
	end if

	astDelNode( l )

	function = vr

end function

