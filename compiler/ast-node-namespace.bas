'' AST namespace nodes
'' l = NULL; r = NULL
''
'' chng: jun/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"


'':::::
function astNamespaceBegin _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	n = astNewNode( AST_NODECLASS_NAMESPC, FB_DATATYPE_INVALID )

	n->sym = sym

	symbNestBegin( sym, FALSE )

	function = n

end function

'':::::
sub astNamespaceEnd _
	( _
		byval n as ASTNODE ptr _
	)

	dim as FBSYMBOL ptr ns = n->sym

	symbNestEnd( FALSE )

	'' reimplementation?
	symbGetNamespaceCnt( ns ) += 1
	if( symbGetNamespaceCnt( ns ) > 1 ) then
		symbNamespaceReImport( ns )
	end if

	symbGetNamespaceLastTail( ns ) = symbGetCompSymbTb( ns ).tail

end sub


