'' AST enumeration nodes
'' l = NULL; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
function astNewENUM _
	( _
		byval value as integer, _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ENUM, FB_DATATYPE_ENUM, sym )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->con.val.int = value
	n->defined	= TRUE

end function

'':::::
function astLoadENUM _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	if( ast.doemit ) then
		function = irAllocVRIMM( FB_DATATYPE_INTEGER, NULL, n->con.val.int )
	end if

end function

