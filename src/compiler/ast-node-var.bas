'' AST variable nodes
'' l = clean up expr (used with temp strings only, due the rtlib assumptions); r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
private function hDoCleanup _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	'' static?
	if( symbIsStatic( sym ) ) then
		return NULL
	end if

	dim as integer lgt = 0

	select case symbGetType( sym )
	'' var-len string?
	case FB_DATATYPE_STRING
		lgt = FB_STRDESCLEN

	'' complex UDT?
	case FB_DATATYPE_STRUCT
    	if( symbGetUDTHasCtorField( symbGetSubtype( sym ) ) or _
    		symbIsUDTReturnedInRegs( symbGetSubtype( sym ) ) = FALSE ) then
        	lgt = symbGetLen( sym )
		else
			return NULL
		end if

	case else
		return NULL
	end select

	'' clear memory
	function = astNewMEM( AST_OP_MEMCLEAR, _
						  astNewVAR( sym, _
						  			 0, _
						  			 symbGetFullType( sym ), _
						  			 symbGetSubtype( sym ) ), _
						  astNewCONSTi( lgt ) )

end function

'':::::
function astNewVAR _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ofs as integer, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr = NULL, _
		byval clean_up as integer = FALSE _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_VAR, dtype, subtype )

	n->sym = sym
	n->var_.ofs = ofs

	'' clean up?
	if( clean_up ) then
		n->l = hDoCleanup( sym )
	end if

	function = n

end function

'':::::
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

'':::::
function astLoadVAR _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as FBSYMBOL ptr s = any
    dim as integer ofs = any
	dim as IRVREG ptr vr = NULL

	'' clean up?
	if( n->l <> NULL ) then
		astLoad( n->l )
		astDelNode( n->l )
	end if

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


