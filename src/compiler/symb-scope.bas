'' symbol table module for scopes
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "list.bi"
#include once "ast.bi"
#include once "rtl.bi"

'':::::
function symbAddScope _
	( _
		byval backnode as ASTNODE ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s

	s = symbNewSymbol( FB_SYMBOPT_NONE, _
	                   NULL, _
	                   symb.symtb, NULL, _
	                   FB_SYMBCLASS_SCOPE, _
	                   NULL, NULL, _
	                   FB_DATATYPE_INVALID, NULL, FB_SYMBATTRIB_NONE, FB_PROCATTRIB_NONE )

	symbSymbTbInit( s->scp.symtb, s )
	s->scp.backnode = backnode

	function = s

end function

'':::::
sub symbDelScope _
	( _
		byval scp as FBSYMBOL ptr _
	)

	if( scp = NULL ) then
		exit sub
	end if

	'' del all symbols inside the scope block
	do
		'' starting from last because of the USING's that could be
		'' referencing a namespace in the same scope block
		dim as FBSYMBOL ptr s = scp->scp.symtb.tail
		if( s = NULL ) then
			exit do
		end if

		symbDelSymbol( s, TRUE )
	loop

	'' del the scope node
	symbFreeSymbol( scp )

end sub

'':::::
sub symbDelScopeTb _
	( _
		byval scp as FBSYMBOL ptr _
	)

	'' for each symbol declared inside the SCOPE block..
	dim as FBSYMBOL ptr s = scp->scp.symtb.tail
	do while( s <> NULL )
		'' remove from hash only

		'' not a namespace import (USING)?
		if( s->class <> FB_SYMBCLASS_NSIMPORT ) then
			symbDelFromHash( s )
		else
			symbNamespaceRemove( s, TRUE )
		end if

		s = s->prev
	loop

end sub
