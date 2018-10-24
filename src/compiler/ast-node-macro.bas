'' AST va_list nodes
'' l = arg1 expression; r = arg2 expression
''


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
function astNewMACRO _
	( _
		byval op as AST_OP, _
		byval arg1 as ASTNODE ptr, _
		byval arg2 as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim n as ASTNODE ptr = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_MACRO, dtype, subtype )

	'' AST_OP_VA_START  va_start( arg1, arg2 )
	'' AST_OP_VA_END    va_end( arg1 )
	'' AST_OP_VA_ARG    expr = va_arg(arg1,typeof(arg2))
	'' AST_OP_VA_COPY   va_copy( arg1, arg2 )
		
	n->op.op = op
	n->l = arg1
	n->r = arg2
	n->sym = arg1->sym

	function = n

end function

'':::::
function astLoadMACRO _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr o = any
	dim op as AST_OP
    dim as IRVREG ptr v1 = any, v2 = any, vr = any

	op = n->op.op

	select case op
	case AST_OP_VA_START
		v1 = astLoad( n->l )
		v2 = astLoad( n->r )
		vr = NULL

	case AST_OP_VA_END
		v1 = astLoad( n->l )
		v2 = NULL
		vr = NULL

	case AST_OP_VA_ARG
		v1 = astLoad( n->l )
		v2 = astLoad( n->r )
		vr = irAllocVREG( astGetDataType( n ), astGetSubType( n ) )

	case AST_OP_VA_COPY
		v1 = astLoad( n->l )
		v2 = astLoad( n->r )
		vr = NULL
	end select

	if( ast.doemit ) then
		irEmitMACRO( op, v1, v2, vr )
	end if

	astDelNode( n->l )
	if( n->r ) then
		astDelNode( n->r )
	end if

	function = vr

end function
