'' AST variable access nodes

#include once "fbint.bi"
#include once "ast.bi"
#include once "ir.bi"

function astNewVAR _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ofs as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	if( dtype = FB_DATATYPE_INVALID ) then
		select case( symbGetClass( sym ) )
		case FB_SYMBCLASS_LABEL
			dtype = FB_DATATYPE_VOID
			subtype = NULL
		case FB_SYMBCLASS_PROC
			dtype = FB_DATATYPE_FUNCTION
			if( symbGetIsFuncPtr( sym ) ) then
				subtype = sym
			else
				subtype = symbAddProcPtrFromFunction( sym )
			end if
		case else
			dtype = symbGetFullType( sym )
			subtype = symbGetSubtype( sym )
		end select
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_VAR, dtype, subtype )

	if( sym ) then
		if( symbIsVar( sym ) and symbIsTemp( sym ) ) then
			astDtorListAddRef( sym )
		end if
	end if

	n->sym = sym
	n->var_.ofs = ofs

	function = n
end function

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
