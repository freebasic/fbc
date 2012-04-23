'' AST field nodes - used only temporarily in expression trees, to be able to
'' check for bitfield assignment/access and opimizations. FIELDs are pruned
'' during astOptimizeTree().
''
'' l = field access; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
function astNewFIELD _
	( _
		byval p as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	if( dtype = FB_DATATYPE_BITFIELD ) then
		'' final type is always an unsigned int
		dtype = typeJoin( dtype, FB_DATATYPE_UINT )
		subtype = NULL
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_FIELD, dtype, subtype )

	n->sym = sym
	n->l = p

	function = n

end function
