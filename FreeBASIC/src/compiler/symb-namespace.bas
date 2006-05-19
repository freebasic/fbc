''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' symbol table module for namespaces
''
'' chng: may/2006 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"

'':::::
function symbAddNamespace _
	( _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s

    '' no explict alias given?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( env.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    end if

    s = symbNewSymbol( NULL, _
    				   NULL, NULL, TRUE, _
    				   FB_SYMBCLASS_NAMESPACE, _
    				   TRUE, id, id_alias )
    if( s = NULL ) then
    	return NULL
    end if

	symbSymTbInit( @s->nspc.symtb, s )

    symbHashTbInit( @s->nspc.hashtb, s, FB_INITSYMBOLNODES \ 10 )

    s->nspc.implist.head = NULL
    s->nspc.implist.tail = NULL
    s->nspc.next = NULL

	function = s

end function

'':::::
sub symbDelNamespace _
	( _
		byval ns as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr s, nxt

    if( ns = NULL ) then
    	exit sub
    end if

    '' del all symbols inside the namespace
    do
		s = ns->nspc.symtb.head
		if( s = NULL ) then
			exit do
		end if

		symbDelSymbol( s )
	loop

	''
	hashFree( @ns->nspc.hashtb.tb )

	'' del node
	symbFreeSymbol( ns )

end sub

''::::
private sub hInsertIntoHashTb _
	( _
		byval imp_ as FBSYMBOL ptr, _
		byval ns as FBSYMBOL ptr _
	) static

	dim as THASH ptr hashtb
	dim as FBSYMCHAIN ptr chain_, chain_head
	dim as FBSYMBOL ptr s

	hashtb = @symb.hashtb->tb

	'' for each symbol in the ns been imported..
	s = ns->nspc.symtb.head
    do until( s = NULL )

		'' if symbol has a name..
		if( s->hash.chain <> NULL ) then
			chain_ = listNewNode( @symb.chainlist )
			chain_->index = s->hash.chain->index

			chain_head = hashLookupEx( hashtb, s->name, chain_->index )
			'' not defined yet? create a new hash node
			if( chain_head = NULL ) then
            	chain_->sym = s
            	chain_->item = hashAdd( hashtb, s->name, chain_, chain_->index )
            	chain_->prev = NULL
            	chain_->next = NULL

			'' already defined but can be duplicated?
			elseif( symbCanDuplicate( chain_head, s ) ) then
				chain_->sym = s
				chain_->item = chain_head->item

				'' add to tail
				do while( chain_head->next <> NULL )
					chain_head = chain_head->next
				loop

				chain_head->next = chain_
				chain_->prev = chain_head
				chain_->next = NULL

            '' dup definition, show a warning?
            else
            	listDelNode( @symb.chainlist, chain_ )
            	chain_ = NULL
			end if

            '' add chain node to USING's list for deallocation later
            if( chain_ <> NULL ) then
            	if( imp_->nsimp.tail <> NULL ) then
            		imp_->nsimp.tail->imp_next = chain_
            	else
            		imp_->nsimp.head = chain_
            	end if
            	chain_->imp_next = NULL
            	imp_->nsimp.tail = chain_
            end if

		end if

		s = s->next
	loop

end sub

'':::::
private function hAddImport _
	( _
		byval ns as FBSYMBOL ptr _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr s

    '' easier to be added as a symbol because it will be removed when
    '' respecting the scope blocks (or procs)
    s = symbNewSymbol( NULL, _
    				   symb.symtb, NULL, TRUE, _
    				   FB_SYMBCLASS_NSIMPORT, _
    				   FALSE, NULL, NULL )
    if( s = NULL ) then
    	return NULL
    end if

	s->nsimp.ns = ns
	s->nsimp.head = NULL
	s->nsimp.tail = NULL

	function = s

end function

'':::::
private function hIsOnHashList _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer

    dim as FBHASHTB ptr hashtb

    hashtb = symb.hashlist.head
    do
    	if( hashtb = @ns->nspc.hashtb ) then
    		return TRUE
    	end if
    	hashtb = hashtb->next
    loop while( hashtb <> NULL )

    function = FALSE

end function

'':::::
function hIsOnImportList _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr s

	s = symb.namespc->nspc.implist.head
	do while( s <> NULL )
	    if( s = ns ) then
	    	return TRUE
	    end if
		s = s->nspc.next
	loop

	function = FALSE

end function

'':::::
function symbNamespaceImport _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer static

	dim as FBSYMBOL ptr imp_, s

	function = FALSE

	'' already imported?
    if( hIsOnImportList( ns ) ) then
    	'' not an error, show a warning?
    	return TRUE
    end if

	'' importing a parent namespace?
	if( hIsOnHashList( ns ) ) then
    	'' not an error, show a warning?
    	return TRUE
	end if

	''
	imp_ = hAddImport( ns )
	if( imp_ = NULL ) then
		exit function
	end if

	'' add to import list of the current ns, to be
	'' removed when the namespace is closed
	with *symb.namespc
		if( .nspc.implist.tail <> NULL ) then
			.nspc.implist.tail->nspc.next = ns
		else
			.nspc.implist.head = ns
		end if
		.nspc.implist.tail = ns
		ns->nspc.next = NULL
	end with

	'' for each named symbol in the name space, add it to
	'' the current symbol table
	hInsertIntoHashTb( imp_, ns )

	'' same for any namespace included by this ns
	ns = ns->nspc.implist.head
	do while( ns <> NULL )
	    hInsertIntoHashTb( imp_, ns )
		ns = ns->nspc.next
	loop

	function = TRUE

end function

'':::::
private sub hRemoveFromHashTb _
	( _
		byval imp_ as FBSYMBOL ptr _
	) static

	dim as FBSYMCHAIN ptr chain_, nxt
	dim as THASH ptr hashtb

	hashtb = @symbGetHashTb( imp_ )->tb

	chain_ = imp_->nsimp.head
	do until( chain_ = NULL )
       	nxt = chain_->imp_next
       	symbDelFromChainList( hashtb, chain_ )
       	chain_ = nxt
	loop

	imp_->nsimp.head = NULL
	imp_->nsimp.tail = NULL

end sub

'':::::
sub symbNamespaceRemove _
	( _
		byval imp_ as FBSYMBOL ptr, _
		byval hashonly as integer _
	)

	hRemoveFromHashTb( imp_ )

	if( hashonly = FALSE ) then
		'' del node
		symbFreeSymbol( imp_ )
	end if

end sub

'':::::
sub symbNamespaceInsertChain _
	( _
		byval ns as FBSYMBOL ptr _
	) static

	dim as FBHASHTB ptr hashtb, lasttb
	dim as FBSYMBOL ptr s

	'' add this ns to hash list and all parents, but the global one

	hashtb = @symbGetNamespaceHashTb( ns )
	symbHashListAdd( hashtb, FALSE )

	'' in reverse other, child ns must be the tail, parents follow
	lasttb = hashtb
	s = symbGetNamespace( ns )
	do until( s = @symbGetGlobalNamespc( ) )

		hashtb = @symbGetNamespaceHashTb( s )
		symbHashListAddBefore( lasttb, hashtb )

		lasttb = hashtb
		s = symbGetNamespace( s )
	loop

end sub

'':::::
sub symbNamespaceRemoveChain _
	( _
		byval ns as FBSYMBOL ptr _
	) static

	'' remove this ns to hash list and all parents, but the global one
	do
		symbHashListDel( @symbGetNamespaceHashTb( ns ) )

		ns = symbGetNamespace( ns )
	loop until( ns = @symbGetGlobalNamespc( ) )

end sub
