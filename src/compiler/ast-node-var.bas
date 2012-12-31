'' AST variable access nodes

#include once "fbint.bi"
#include once "ast.bi"
#include once "ir.bi"

function astNewVAR _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ofs as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_VAR, dtype, subtype )

	n->sym = sym
	n->var_.ofs = ofs

	function = n
end function

sub astBuildVAR _
	( _
		byval n as ASTNODE ptr, _
		byval sym as FBSYMBOL ptr, _
		byval ofs as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL _
	)

	astInitNode( n, AST_NODECLASS_VAR, dtype, subtype )

	n->sym = sym
	n->var_.ofs = ofs

end sub

function astLoadVAR( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as FBSYMBOL ptr s = any
    dim as integer ofs = any
	dim as IRVREG ptr vr = NULL

	s = n->sym
	ofs = n->var_.ofs
	if( s <> NULL ) then
		symbSetIsAccessed( s )
		ofs += symbGetOfs( s )
	end if

	if( ast.doemit ) then
		vr = irAllocVRVAR( astGetDataType( n ), n->subtype, s, ofs )
		vr->vector = n->vector
	end if

	function = vr
end function
