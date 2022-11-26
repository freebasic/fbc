'' AST va_list nodes
'' l = arg1 expression; r = arg2 expression
''
'' chng: oct/2018 written [jeffm]

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

	'' current node configuration is
	''
	''   n
	''  / \
	'' l   r
	''
	'' n = MACRO node, dtype/subtype to return (if any)
	'' l = first argument (the cva_list object)
	'' r = second argument (only used in cva_copy)
	''
	'' To make this node class more generic, need to add
	'' sub-nodes to build a list of argument expressions

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

	if( op = AST_OP_VA_ARG ) then
		'' promote?
		select case typeGetClass( dtype )
		case FB_DATACLASS_INTEGER
			if( typeGetSize( dtype ) < typeGetSize( FB_DATATYPE_INTEGER ) ) then
				n->dtype = typeJoin( dtype, FB_DATATYPE_INTEGER )
				n = astNewCONV( dtype, NULL, n )
			end if
		case FB_DATACLASS_FPOINT
			if( typeGetSize( dtype ) < typeGetSize( FB_DATATYPE_DOUBLE ) ) then
				n->dtype = typeJoin( dtype, FB_DATATYPE_DOUBLE )
				n = astNewCONV( dtype, NULL, n )
			end if
		end select
	end if

	function = n

end function

'':::::
function astLoadMACRO _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

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
		vr = irAllocVREG( astGetFullType( n ), astGetSubType( n ) )

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
