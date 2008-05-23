'' symbol table module for bit fields
''
'' chng: nov/2005 written [v1ctor]
''


#include once "fb.bi"
#include once "fbint.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "ast.bi"

'':::::
function symbAddBitField _
	( _
		byval bitpos as integer, _
		byval bits as integer, _
		byval dtype as integer, _
		byval lgt as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr sym

    '' table must be the global one, if the UDT is been defined
    '' at main(), it will be deleted before some private function
    '' accessing the bitfield

    sym = symbNewSymbol( FB_SYMBOPT_NONE, _
    					 NULL, _
    					 NULL, NULL, _
    					 FB_SYMBCLASS_BITFIELD, _
    				   	 NULL, NULL, _
    				   	 dtype, NULL )
	if( sym = NULL ) then
		return NULL
	end if

    sym->bitfld.bitpos = bitpos
    sym->bitfld.bits = bits
	sym->bitfld.typ = dtype
    sym->lgt = lgt

	function = sym

end function

