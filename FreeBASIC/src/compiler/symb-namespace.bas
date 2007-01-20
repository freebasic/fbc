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
'' (note: all functions but Add() and Del() can be used with any UDT)
''
'' chng: may/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

declare sub hDelFromImportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

'':::::
function symbAddNamespace _
	( _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr s = any

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

	symbSymbTbInit( s->nspc.ns.symtb, s )
    symbHashTbInit( s->nspc.ns.hashtb, s, FB_INITSYMBOLNODES \ 10 )

    s->nspc.ns.ext = NULL

	function = s

end function

'':::::
sub symbDelNamespace _
	( _
		byval ns as FBSYMBOL ptr _
	)

    if( ns = NULL ) then
    	exit sub
    end if

	'' del the imports (USING's) first, or NamespaceRemove() would
	'' remove try to remove the namespace from the hash tb list
	symbCompDelImportList( ns )

    '' del all symbols inside the namespace
    do
		dim as FBSYMBOL ptr s = ns->nspc.ns.symtb.head
		if( s = NULL ) then
			exit do
		end if

		symbDelSymbol( s )
	loop

	''
	if( ns->nspc.ns.ext <> NULL ) then
		symbCompFreeExt( ns->nspc.ns.ext )
		ns->nspc.ns.ext = NULL
	end if

	''
	hashFree( @ns->nspc.ns.hashtb.tb )

	'' del node
	symbFreeSymbol( ns )

end sub

'':::::
private function hAddImport _
	( _
		byval ns as FBSYMBOL ptr _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr s = any

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

	function = s

end function

'':::::
private sub hAddToImportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr curr_ns = symbGetNamespace( imp_ )

	if( symbGetCompExt( curr_ns ) = NULL ) then
		symbGetCompExt( curr_ns ) = symbCompAllocExt( )
	end if

	if( symbGetCompExt( curr_ns )->tail <> NULL ) then
		symbGetCompExt( curr_ns )->tail->nsimp.next = imp_
	else
		symbGetCompExt( curr_ns )->head = imp_
	end if

	imp_->nsimp.prev = symbGetCompExt( curr_ns )->tail
	imp_->nsimp.next = NULL

	symbGetCompExt( curr_ns )->tail = imp_

end sub

'':::::
private sub hDelFromImportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr curr_ns = symbGetNameSpace( imp_ )

	if( imp_->nsimp.prev = NULL ) then
		symbGetCompExt( curr_ns )->head = imp_->nsimp.next
	else
		imp_->nsimp.prev->nsimp.next = imp_->nsimp.next
	end if

	if( imp_->nsimp.next = NULL ) then
		symbGetCompExt( curr_ns )->tail = imp_->nsimp.prev
	else
		imp_->nsimp.next->nsimp.prev = imp_->nsimp.prev
	end if

end sub

'':::::
private sub hAddToHashTbList _
	( _
		byval ns as FBSYMBOL ptr _
	)

	symbGetCompExt( ns )->cnt += 1

	'' same for any namespace included by it
	dim as FBSYMBOL ptr imp_ = symbGetCompImportHead( ns )
	do while( imp_ <> NULL )
		if( symbGetCompExt( imp_->nsimp.ns )->cnt = 0 ) then
			hAddToHashTbList( imp_->nsimp.ns )
		end if
	    imp_ = imp_->nsimp.next
	loop

	'' add it to hash tb list
	if( symbGetCompExt( ns )->cnt = 1 ) then
		symbHashListAddBefore( @symbGetGlobalHashTb( ), _
						   	   @symbGetCompHashTb( ns ) )
	end if

end sub

'':::::
private sub hDelFromHashTbList _
	( _
		byval ns as FBSYMBOL ptr _
	)

	'' del the ns from hash tb list
	symbGetCompExt( ns )->cnt -= 1
	if( symbGetCompExt( ns )->cnt = 0 ) then
		symbHashListDel( @symbGetCompHashTb( ns ) )
	end if

	'' same for any namespace included by it
	dim as FBSYMBOL ptr imp_ = symbGetCompImportHead( ns )
	do while( imp_ <> NULL )
		if( symbGetCompExt( imp_->nsimp.ns )->cnt > 0 ) then
			hDelFromHashTbList( imp_->nsimp.ns )
		end if
	    imp_ = imp_->nsimp.next
	loop

end sub

'':::::
private function hIsOnParentList _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr parent = symbGetCurrentNamespc( )
	do until( parent = @symbGetGlobalNamespc( ) )
		if( ns = parent ) then
			return TRUE
		end if
		parent = symbGetNamespace( parent )
	loop

	function = FALSE

end function

'':::::
private function hIsOnImportList _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr imp_ = symbGetCompImportHead( ns )
	do while( imp_ <> NULL )
	    if( imp_->nsimp.ns = ns ) then
	    	return TRUE
	    end if
		imp_ = imp_->nsimp.next
	loop

	function = FALSE

end function

'':::::
function symbNamespaceImport _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer

	'' importing itself or a parent?
	if( hIsOnParentList( ns ) ) then
		return FALSE
	end if

	if( symbGetCompExt( ns ) = NULL ) then
		symbGetCompExt( ns ) = symbCompAllocExt( )
	end if

	'' add to import list of the current ns, if not yet
	if( hIsOnImportList( ns ) = FALSE ) then
		dim as FBSYMBOL ptr imp_ = hAddImport( ns )
		if( imp_ = NULL ) then
			return FALSE
		end if

		hAddToImportList( imp_ )
	end if

	'' add to hash tb list
	hAddToHashTbList( ns )

	function = TRUE

end function

'':::::
sub symbNamespaceRemove _
	( _
		byval imp_ as FBSYMBOL ptr, _
		byval hashonly as integer _
	)

	if( imp_->nsimp.ns <> NULL ) then
		'' remove all USING's
		hDelFromHashTbList( imp_->nsimp.ns )
		hDelFromImportList( imp_ )
		imp_->nsimp.ns = NULL
	end if

	if( hashonly = FALSE ) then
		'' del node
		symbFreeSymbol( imp_ )
	end if

end sub


