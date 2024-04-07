'' AST variable access nodes

#include once "fbint.bi"
#include once "ast.bi"
#include once "ir.bi"

function astNewVAR _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ofs as longint, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	assert( iif( sym, symbIsField( sym ) = FALSE, TRUE ) )

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
			if( symbIsParamVarByRef( sym ) or symbIsImport( sym ) or symbIsRef( sym ) ) then
				'' If it's a reference, then it's really a pointer
				'' (the caller is expected to do the implicit DEREF)
				dtype = typeAddrOf( dtype )
			end if
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

	'' boolean? do conversion on load
	if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_BOOLEAN ) then
		n = astNewCONV( dtype, NULL, n )
	end if

	function = n
end function

function astLoadVAR( byval n as ASTNODE ptr ) as IRVREG ptr
	dim as FBSYMBOL ptr s = any
	dim as longint ofs = any
	dim as IRVREG ptr vr = NULL

	s = n->sym
	ofs = n->var_.ofs
	if( s <> NULL ) then
		symbSetIsAccessed( s )
		ofs += symbGetOfs( s )
	end if

	if( ast.doemit ) then
		vr = irAllocVRVAR( astGetFullType( n ), n->subtype, s, ofs )
		vr->vector = n->vector
	end if

	function = vr
end function
