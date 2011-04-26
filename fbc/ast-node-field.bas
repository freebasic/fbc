'' AST variable nodes
'' l = NULL; r = NULL
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
	if( n = NULL ) then
		return NULL
	end if

	n->sym = sym
	n->l = p

	function = n

end function

'':::::
private function hGetBitField _
	( _
		byval n as ASTNODE ptr, _
		byval dtype as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr c = any
	dim as FBSYMBOL ptr s = any

	s = n->subtype

	'' remap type
	astGetFullType( n ) = typeJoin( astGetFullType( n ), s->typ )
	n->subtype = NULL

	'' make a copy, the node itself can't be used or it will be deleted twice
	c = astNewNode( INVALID, FB_DATATYPE_INVALID )
	astCopy( c, n )

	'' final type is always an integer (the sign depends if CONV changed
	'' the parent type or not)

	if( s->bitfld.bitpos > 0 ) then
		n = astNewBOP( AST_OP_SHR, c, _
				   	   astNewCONSTi( s->bitfld.bitpos, dtype ) )
	else
		n = c
	end if

	n = astNewBOP( AST_OP_AND, n, _
				   astNewCONSTi( ast_bitmaskTB(s->bitfld.bits), dtype ) )

	function = n

end function

sub astUpdateBitfieldAccess _ 
	( _ 
		byref n as ASTNODE ptr _
	)
	
	if( astGetDataType( n ) = FB_DATATYPE_BITFIELD ) then
		n = hGetBitField( n, astGetFullType( n ) )
	end if
	
end sub

'':::::
function astLoadFIELD _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any
	dim as IRVREG ptr vr = any

	'' handle bitfields..
	l = n->l
	astUpdateBitfieldAccess( l )

	vr = astLoad( l )

	if( ast.doemit ) then
		vr->vector = n->vector
	end if

	function = vr

	astDelNode( l )

end function


