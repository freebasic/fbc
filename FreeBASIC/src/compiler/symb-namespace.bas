''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

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
    	if( parser.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    end if

    s = symbNewSymbol( FB_SYMBOPT_DOHASH, _
    				   NULL, _
    				   NULL, NULL,  _
    				   FB_SYMBCLASS_NAMESPACE, _
    				   id, id_alias, _
    				   FB_DATATYPE_NAMESPC, NULL, 0 )
    if( s = NULL ) then
    	return NULL
    end if

	symbSymbTbInit( s->nspc.symtb, s )

    symbHashTbInit( s->nspc.hashtb, s, FB_INITSYMBOLNODES \ 10 )

    s->nspc.cnt = 0
    s->nspc.implist.head = NULL
    s->nspc.implist.tail = NULL
    s->nspc.explist.head = NULL
    s->nspc.explist.tail = NULL
    s->nspc.symtail = NULL

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
		byval src_head as FBSYMBOL ptr, _
		byval dst_hash as FBHASHTB ptr = NULL _
	) static

	dim as THASH ptr hashtb
	dim as FBSYMCHAIN ptr chain_, chain_head
	dim as FBSYMBOL ptr s

	if( dst_hash = NULL ) then
		hashtb = @symb.hashtb->tb
	else
		hashtb = @dst_hash->tb
	end if

	'' for each symbol in the ns been imported..
	s = src_head
    do until( s = NULL )

		'' if symbol has a name..
		if( s->hash.chain <> NULL ) then
			chain_ = listNewNode( @symb.chainlist )
			chain_->index = s->hash.chain->index

			chain_head = hashLookupEx( hashtb, s->id.name, chain_->index )
			'' not defined yet? create a new hash node
			if( chain_head = NULL ) then
            	chain_->sym = s
            	chain_->item = hashAdd( hashtb, s->id.name, chain_, chain_->index )
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
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s

    '' easier to be added as a symbol because it will be removed
    '' respecting the scope blocks (or procs)
    s = symbNewSymbol( FB_SYMBOPT_NONE, _
    				   NULL, _
    				   symb.symtb, symb.hashtb, _
    				   FB_SYMBCLASS_NSIMPORT, _
    				   NULL, NULL, _
    				   INVALID, NULL, 0, _
    				   iif( parser.scope = FB_MAINSCOPE, _
    				   		FB_SYMBATTRIB_NONE, _
    				   		FB_SYMBATTRIB_LOCAL ) )
    if( s = NULL ) then
    	return NULL
    end if

	s->nsimp.ns = ns
	s->nsimp.head = NULL
	s->nsimp.tail = NULL
    s->nsimp.imp_next = NULL
    s->nsimp.exp_next = NULL

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
private function hIsOnImportList _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr s

	'' find the real namespace (the current one could be an TYPE or CLASS)
	s = symbGetCurrentNamespc( )
	do until( symbIsNamespace( s ) )
		s = symbGetNamespace( s )
	loop

	s = s->nspc.implist.head
	do while( s <> NULL )
	    if( s->nsimp.ns = ns ) then
	    	return TRUE
	    end if
		s = s->nsimp.imp_next
	loop

	function = FALSE

end function

'':::::
private sub hAddToImportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr ns

	'' find the real namespace (the current one could be an TYPE or CLASS)
	ns = symbGetCurrentNamespc( )
	do until( symbIsNamespace( ns ) )
		ns = symbGetNamespace( ns )
	loop

	if( ns->nspc.implist.tail <> NULL ) then
		ns->nspc.implist.tail->nsimp.imp_next = imp_
	else
		ns->nspc.implist.head = imp_
	end if
	ns->nspc.implist.tail = imp_

	imp_->nsimp.imp_next = NULL

end sub

'':::::
private sub hDelFromImportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr currns, ns, s, prev

	'' find the real namespace (the current one could be an TYPE or CLASS)
	currns = symbGetNameSpace( imp_ )
	do until( symbIsNamespace( currns ) )
		currns = symbGetNamespace( currns )
	loop

	ns = imp_->nsimp.ns

	prev = NULL
	s = currns->nspc.implist.head

	do while( s <> NULL )
	    if( s = imp_ ) then
	    	if( prev = NULL ) then
	        	currns->nspc.implist.head = imp_->nsimp.imp_next
	        else
	        	prev->nsimp.imp_next = imp_->nsimp.imp_next
	        end if

	    	if( imp_->nsimp.imp_next = NULL ) then
	        	currns->nspc.implist.tail = prev
	        else
	        	imp_->nsimp.imp_next = NULL
	        end if

	        exit sub
	    end if

		prev = s
		s = s->nsimp.imp_next
	loop

end sub

'':::::
private sub hAddToExportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr ns

	ns = imp_->nsimp.ns

	if( ns->nspc.explist.tail <> NULL ) then
		ns->nspc.explist.tail->nsimp.exp_next = imp_
	else
		ns->nspc.explist.head = imp_
	end if
	ns->nspc.explist.tail = imp_

	imp_->nsimp.exp_next = NULL

end sub

'':::::
private sub hDelFromExportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr ns, s, prev

	ns = imp_->nsimp.ns

	prev = NULL
	s = ns->nspc.explist.head

	do while( s <> NULL )
	    if( s = imp_ ) then
	    	if( prev = NULL ) then
	        	ns->nspc.explist.head = imp_->nsimp.exp_next
	        else
	        	prev->nsimp.exp_next = imp_->nsimp.exp_next
	        end if

	    	if( imp_->nsimp.exp_next = NULL ) then
	        	ns->nspc.explist.tail = prev
	        else
	        	imp_->nsimp.exp_next = NULL
	        end if

	        exit sub
	    end if

		prev = s
		s = s->nsimp.exp_next
	loop

end sub

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

	'' for each named symbol in the name space, add it to
	'' the current symbol table
	hInsertIntoHashTb( imp_, symbGetNamespaceTbHead( ns ) )

	'' same for any namespace included by this ns
	s = ns->nspc.implist.head
	do while( s <> NULL )

	    hInsertIntoHashTb( imp_, symbGetNamespaceTbHead( s->nsimp.ns ) )

		s = s->nsimp.imp_next
	loop

	'' add to import list of the current ns
	hAddToImportList( imp_ )

	hAddToExportList( imp_ )

	function = TRUE

end function

'':::::
function symbNamespaceReImport _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer static

	dim as FBSYMBOL ptr imp_, head

	function = FALSE

	'' for each USING that is pointing to this namespace
	imp_ = ns->nspc.explist.head
	do while( imp_ <> NULL )

	    head = symbGetNamespaceLastTbTail( imp_->nsimp.ns )
	    if( head = NULL ) then
	    	head = symbGetNamespaceTbHead( imp_->nsimp.ns )
	    end if

	    hInsertIntoHashTb( imp_, _
	    				   head, _
	    				   @symbGetNamespaceHashTb( symbGetNamespace( imp_ ) ) )

		imp_ = imp_->nsimp.exp_next
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

	if( imp_->scope > FB_MAINSCOPE ) then
		if( imp_->nsimp.ns <> NULL ) then
			hDelFromImportList( imp_ )
			hDelFromExportList( imp_ )
			imp_->nsimp.ns = NULL
		end if
	end if

	if( hashonly = FALSE ) then
		'' del node
		symbFreeSymbol( imp_ )
	end if

end sub


