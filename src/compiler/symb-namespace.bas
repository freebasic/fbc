'' symbol table module for namespaces
'' (note: all functions but Add() and Del() can be used with any UDT)
''
'' chng: may/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

declare sub symbCompAddToImportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

declare sub symbCompDelFromImportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

declare sub symbCompAddToExportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

declare sub symbCompDelFromExportList _
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
	                   FB_DATATYPE_NAMESPC, NULL, FB_SYMBATTRIB_NONE, FB_PROCATTRIB_NONE )
	if( s = NULL ) then
		return NULL
	end if

	symbSymbTbInit( s->nspc.ns.symtb, s )
	symbHashTbInit( s->nspc.ns.hashtb, s, FB_INITSYMBOLNODES \ 10 )

	s->nspc.ns.ext = NULL
	s->nspc.cnt = 0
	s->nspc.last_tail = NULL

	function = s

end function

sub symbDelNamespaceMembers _
	( _
		byval s as FBSYMBOL ptr, _
		byval delete_hashtb as integer _
	)

	'' The namespace can be a NAMESPACE, STRUCT or ENUM, assuming that
	'' FBS_STRUCT, FBS_ENUM and FBS_NAMESPACE all extend FBNAMESPC.

	symbCompDelImportList( s )

	'' Delete all member symbols, starting from last because of the USING's
	'' that could be referencing a namespace in the same scope block
	while( symbGetCompSymbTb( s ).tail )
		symbDelSymbol( symbGetCompSymbTb( s ).tail, TRUE )
	wend

	if( s->nspc.ns.ext ) then
		symbCompFreeExt( s->nspc.ns.ext )
		s->nspc.ns.ext = NULL
	end if

	if( delete_hashtb ) then
		hashEnd( @s->nspc.ns.hashtb.tb )
	end if
end sub

sub symbDelNamespace( byval s as FBSYMBOL ptr )
	symbDelNamespaceMembers( s, TRUE )
	symbFreeSymbol( s )
end sub

'':::::
private function hAddImport _
	( _
		byval dst_ns as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOLTB ptr symbtb = any
	dim as FBHASHTB ptr hashtb = any
	dim as integer is_local = any

	if( dst_ns = symbGetCurrentNamespc( ) ) then
		symbtb = NULL
		hashtb = NULL
		is_local = 0
	else
		symbtb = @symbGetCompSymbTb( dst_ns )
		hashtb = @symbGetCompHashTb( dst_ns )
		is_local = symbIsLocal( dst_ns )
	end if

	'' easier to be added as a symbol because it will be removed
	'' respecting the scope blocks (or procs)
	function = symbNewSymbol( FB_SYMBOPT_NONE, _
	                          NULL, _
	                          symbtb, hashtb, _
	                          FB_SYMBCLASS_NSIMPORT, _
	                          NULL, NULL, _
	                          FB_DATATYPE_INVALID, NULL, _
	                          iif( is_local, FB_SYMBATTRIB_LOCAL, FB_SYMBATTRIB_NONE ), _
	                          FB_PROCATTRIB_NONE )
end function

'':::::
private sub hAddToHashTbList _
	( _
		byval ns as FBSYMBOL ptr _
	)

	'' add it to hash tb list
	symbGetCompExt( ns )->cnt += 1
	if( symbGetCompExt( ns )->cnt = 1 ) then
		symbHashListInsertNamespace( ns, symbGetCompSymbTb( ns ).head )
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
		symbHashListRemoveNamespace( ns )
	end if

end sub

'':::::
private function hIsOnParentList _
	( _
		byval src_ns as FBSYMBOL ptr, _
		byval dst_ns as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr parent = dst_ns
	do until( parent = @symbGetGlobalNamespc( ) )
		if( src_ns = parent ) then
			return TRUE
		end if
		parent = symbGetNamespace( parent )
	loop

	function = FALSE

end function

'':::::
private function hIsOnImportList _
	( _
		byval src_ns as FBSYMBOL ptr, _
		byval dst_ns as FBSYMBOL ptr _
	) as integer

	if( symbGetCompExt( dst_ns ) <> NULL ) Then

		dim as FBSYMBOL ptr imp_ = symbGetCompImportHead( dst_ns )

		do while( imp_ <> NULL )
			if( symbGetImportNamespc( imp_ ) = src_ns ) then
				return TRUE
			end if
			imp_ = symbGetImportNext( imp_ )
		Loop

	End if

	function = FALSE

end function

'':::::
function symbNamespaceImportEx _
	( _
		byval ns as FBSYMBOL ptr, _
		byval to_ns as FBSYMBOL ptr _
	) as integer

	'' importing itself or a parent?
	if( hIsOnParentList( ns, to_ns ) ) then
		return FALSE
	end if

	if( symbGetCompExt( ns ) = NULL ) then
		symbGetCompExt( ns ) = symbCompAllocExt( )
	end if

	'' not already on list?
	if( hIsOnImportList( ns, to_ns ) = FALSE ) then
		dim as FBSYMBOL ptr imp_ = any

		imp_ = hAddImport( to_ns )
		if( imp_ = NULL ) then
			return FALSE
		end if

		imp_->nsimp.imp_ns = ns
		imp_->nsimp.exp_ns = to_ns

		'' add to the import list of the dst ns
		symbCompAddToImportList( imp_ )

		'' add to the export list of the src ns
		symbCompAddToExportList( imp_ )

		'' recurse into the imported ns, importing its imports too
		imp_ = symbGetCompImportHead( ns )
		do while( imp_ <> NULL )
			symbNamespaceImportEx( symbGetImportNamespc( imp_ ), to_ns )
			imp_ = symbGetImportNext( imp_ )
		loop

		'' add to hash tb list
		hAddToHashTbList( ns )
	end if

	function = TRUE

end function

'':::::
function symbNamespaceImport _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer

	function = symbNamespaceImportEx( ns, symbGetCurrentNamespc( ) )

end function

'':::::
sub symbNamespaceRemove _
	( _
		byval imp_ as FBSYMBOL ptr, _
		byval hashonly as integer _
	)

	if( symbGetImportNamespc( imp_ ) <> NULL ) then
		'' remove all USING's
		hDelFromHashTbList( symbGetImportNamespc( imp_ ) )
		symbCompDelFromExportList( imp_ )
		symbCompDelFromImportList( imp_ )
		symbGetImportNamespc( imp_ ) = NULL
	end if

	if( hashonly = FALSE ) then
		'' del node
		symbFreeSymbol( imp_ )
	end if

end sub

'':::::
sub symbNamespaceReImport _
	( _
		byval ns as FBSYMBOL ptr _
	)

	'' currently at the import hash tb?
	if( symbGetCompExt( ns )->impsym_head <> NULL ) then
		dim as FBSYMBOL ptr head = symbGetNamespaceLastTail( ns )
		if( head = NULL ) then
			head = symbGetNamespaceTbHead( ns )
		else
			'' skip the last (already added)
			head = head->next
		end if

		if( head <> NULL ) then
			symbHashListInsertNamespace( ns, head )
		end if
	end if

	'' for each namespace importing this namespace, update
	'' their import lists with our import list (that could
	'' have been updated in the re-implementation)
	dim as FBSYMBOL ptr exp_ = symbGetCompExportHead( ns )
	do while( exp_ <> NULL )
		dim as FBSYMBOL ptr imp_ = symbGetCompImportHead( ns )
		do while( imp_ <> NULL )
			symbNamespaceImportEx( symbGetImportNamespc( imp_ ), _
			                       symbGetExportNamespc( exp_ ) )
			imp_ = symbGetImportNext( imp_ )
		loop
		exp_ = symbGetExportNext( exp_ )
	loop

end sub

