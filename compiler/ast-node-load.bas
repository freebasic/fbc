'' AST loading nodes
'' l = expression to load to a register; r = NULL
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"

'':::::
function astNewLOAD _
	( _
		byval l as ASTNODE ptr, _
		byval dtype as integer, _
		byval isresult as integer _
	) as ASTNODE ptr

	'' alloc new node
	dim as ASTNODE ptr n = astNewNode( AST_NODECLASS_LOAD, dtype )

	n->l  = l
	n->lod.isres = isresult

	function = n
end function

'':::::
function astLoadLOAD _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any
    dim as IRVREG ptr v1 = any, vr = any

	l = n->l
	if( l = NULL ) then
		return NULL
	end if

	v1 = astLoad( l )

	if( ast.doemit ) then
		if( n->lod.isres ) then
			vr = irAllocVREG( irGetVRDataType( v1 ), irGetVRSubType( v1 ) )
			irEmitLOADRES( v1, vr )
		else
			irEmitLOAD( v1 )
		end if
	end if

	astDelNode( l )

	function = v1

end function

