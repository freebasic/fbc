'' symbol table core module
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "pool.bi"

declare sub			symbDelGlobalTb 	( )

declare sub 		symbKeywordInit		( )

declare sub 		symbDefineInit		( _
											byval ismain as integer _
										)

declare sub 		symbDefineEnd		( )

declare sub 		symbFwdRefInit		( )

declare sub 		symbFwdRefEnd		( )

declare sub 		symbVarInit			( )

declare sub 		symbVarEnd			( )

declare sub 		symbProcInit		( )

declare sub 		symbProcEnd			( )

declare sub 		symbMangleInit		( )

declare sub 		symbMangleEnd		( )

declare sub 		symbCompInit		( )

declare sub 		symbCompEnd			( )

declare sub 		symbCompRTTIInit	( )

declare sub 		symbCompRTTIEnd		( )

declare sub 		symbKeywordConstsInit ( )

declare function hGetNamespacePrefix( byval sym as FBSYMBOL ptr ) as string

''globals
	dim shared as SYMBCTX symb

	dim shared as integer deftypeTB( 0 to (asc("_" ) - asc( "A" ) + 1) - 1 )

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' init/end
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbInitSymbols static

	'' symbols list
	listInit( @symb.symlist, FB_INITSYMBOLNODES, len( FBSYMBOL ), LIST_FLAGS_NOCLEAR )

	'' symbol id string pool
	poolInit( @symb.namepool, FB_INITSYMBOLNODES \ 8, FB_MAXNAMELEN\8+1, FB_MAXNAMELEN+1 )

	symb.chainpoolhead = 0

	'' namespace extension's list
	listInit( @symb.nsextlist, FB_INITSYMBOLNODES \ 16, len( FBNAMESPC_EXT ), LIST_FLAGS_CLEAR )

	'' global namespace - not complete, just a mock symbol
    symb.globnspc.class = FB_SYMBCLASS_NAMESPACE
    symb.globnspc.scope = FB_MAINSCOPE

    with symb.globnspc.nspc
        symbSymbTbInit( .ns.symtb, @symb.globnspc )
		symbHashTbInit( .ns.hashtb, @symb.globnspc, FB_INITSYMBOLNODES )
    	.ns.ext = symbCompAllocExt( )
    end with

	''
	symb.namespc = @symb.globnspc
	symb.symtb = @symb.globnspc.nspc.ns.symtb
	symb.hashtb = @symb.globnspc.nspc.ns.hashtb

	''
	symb.hashlist.head = NULL
	symb.hashlist.tail = NULL

	symbHashListAdd( symb.hashtb )

	'' import (USING) shared hash/list
	hashInit( @symb.imphashtb, FB_INITSYMBOLNODES )
	listInit( @symb.imphashlist, FB_INITSYMBOLNODES \ 2, len( FBSYMCHAIN ), LIST_FLAGS_NOCLEAR )

	''
	symb.lastlbl = NULL

	symbDataInit( )

end sub

'':::::
private sub hInitDefTypeTb
    dim as integer dtype, i

	if( fbLangIsSet( FB_LANG_QB ) ) then
		dtype = FB_DATATYPE_SINGLE
	else
		dtype = FB_DATATYPE_INTEGER
	end if

	''
	for i = 0 to (asc("_")-asc("A")+1)-1
		deftypeTB(i) = dtype
	next

end sub

'':::::
sub symbInit _
	( _
		byval ismain as integer _
	)

	''
	if( symb.inited ) then
		exit sub
	end if

	'' vars, arrays, procs & consts
	symbInitSymbols( )

	''
	symbCompInit( )

	''
	symbMangleInit( )

	'' keywords
	symbKeywordInit( )

	'' defines
	symbDefineInit( ismain )

	'' forward refs
	symbFwdRefInit( )

	'' arrays dim tb
	symbVarInit( )

	''
	symbProcInit( )

	''
	hInitDefTypeTb( )
	
	''
	symbCompRTTIInit( )

	''
	symbKeywordConstsInit( )

    ''
    symb.inited = TRUE

end sub

'':::::
sub symbEnd

    if( symb.inited = FALSE ) then
    	exit sub
    end if

	''
	symbDelGlobalTb( )

	symbGetGlobalTb( ).head = NULL
	symbGetGlobalTb( ).tail = NULL
	symb.symtb = NULL

	''
	listEnd( @symb.imphashlist )
	hashEnd( @symb.imphashtb )

	hashEnd( @symb.globnspc.nspc.ns.hashtb.tb )

	''
	symbCompRTTIEnd( )
	
	''
	symbProcEnd( )

	symbVarEnd( )

	symbFwdRefEnd( )

	symbDefineEnd( )

	symbMangleEnd( )

	symbCompEnd( )

	''
	symbCompFreeExt( symb.globnspc.nspc.ns.ext )

	''
	listEnd( @symb.nsextlist )

	poolEnd( @symb.namepool )

	listEnd( @symb.symlist )

	''
	symb.inited = FALSE

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCanDuplicate _
	( _
		byval head_sym as FBSYMBOL ptr, _
		byval s as FBSYMBOL ptr _
	) as integer

	function = FALSE

	select case as const s->class
	'' adding a define, keyword, namespace, class or field?
	case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD, _
		 FB_SYMBCLASS_NAMESPACE, FB_SYMBCLASS_CLASS, _
		 FB_SYMBCLASS_FIELD

		'' no dups allowed
		exit function

	'' struct, enum or typedef?
	case FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_ENUM, _
		 FB_SYMBCLASS_TYPEDEF

		'' note: if it's a struct, we don't have to check if it's unique,
		'' because that will be only set after the symbol is added

		do
			select case as const head_sym->class
			'' anything but a define or themselves is allowed (keywords
			'' (but quirk-keywords) are refused when parsing)
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_NAMESPACE, _
				 FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_CLASS, _
				 FB_SYMBCLASS_FIELD

				exit function
			end select

			head_sym = head_sym->hash.next
		loop while( head_sym <> NULL )

	'' forward ref?
	case FB_SYMBCLASS_FWDREF

		do
			select case head_sym->class
			'' anything but a define or another forward ref is allowed (keywords
			'' (but quirk-keywords) are refused when parsing)
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_NAMESPACE, _
				 FB_SYMBCLASS_FWDREF, FB_SYMBCLASS_CLASS

				exit function

			'' struct? only it's not unique
			case FB_SYMBCLASS_STRUCT
				if( symbGetIsUnique( head_sym ) ) then
					exit function
				end if
			end select

			head_sym = head_sym->hash.next
		loop while( head_sym <> NULL )

	'' constant or proc?
	case FB_SYMBCLASS_CONST, FB_SYMBCLASS_PROC

		do
			select case as const head_sym->class
			'' only dup allowed are labels and UDTs
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			'' struct? only it's not unique
			case FB_SYMBCLASS_STRUCT
				if( symbGetIsUnique( head_sym ) ) then
					exit function
				end if

			'' only if the keyword or the rtl-proc has a string suffix
			case FB_SYMBCLASS_KEYWORD, FB_SYMBCLASS_PROC
				if( env.clopt.lang <> FB_LANG_QB ) then
					exit function
				end if

				'' only if it's a RTL function..
				if( symbIsProc( head_sym ) ) then
					if( symbGetIsRTL( head_sym ) = FALSE ) then
						exit function
					else
						'' both RTL? don't allow dup so overloaded procs 
						'' will get chained
						if( symbGetIsRTL( head_sym ) ) then
							exit function
						end if
					end if
				end if

				'' nothing else takes a suffix but rtl-funcs returning strings
				if( symbIsSuffixed( s ) ) then
					if( symbGetType( s ) = symbGetType( head_sym ) ) then
						exit function
					end if
				else
					if( symbGetType( head_sym ) <> FB_DATATYPE_STRING ) then
						exit function
					end if
				end if

			case else
				exit function
			end select

			head_sym = head_sym->hash.next
		loop while( head_sym <> NULL )

	'' variable?
	case FB_SYMBCLASS_VAR

		do
			select case as const head_sym->class
			'' allow labels or UDTs as dups
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			'' struct? only it's not unique
			case FB_SYMBCLASS_STRUCT
				if( symbGetIsUnique( head_sym ) ) then
					exit function
				end if

			'' only if the keyword or the rtl-proc has a string suffix
			case FB_SYMBCLASS_KEYWORD, FB_SYMBCLASS_PROC
				if( env.clopt.lang <> FB_LANG_QB ) then
					exit function
				end if

				'' only if it's a RTL function..
				if( symbIsProc( head_sym ) ) then
					if( symbGetIsRTL( head_sym ) = FALSE ) then
						exit function
					end if
				end if

				'' nothing else takes a suffix but rtl-funcs returning strings
				if( symbIsSuffixed( s ) ) then
					if( symbGetType( s ) = symbGetType( head_sym ) ) then
						exit function
					end if
				else
					if( symbGetType( head_sym ) <> FB_DATATYPE_STRING ) then
						exit function
					end if
				end if

			'' allow fields dups, if in a different scope
			case FB_SYMBCLASS_FIELD
				'' same scope?
				if( s->scope = head_sym->scope ) then
					exit function
				end if

			'' and other vars if they have different suffixes -- if any
			'' with suffix exist, a suffix-less will not be accepted (and vice-versa)
			case FB_SYMBCLASS_VAR
				'' same scope?
				if( s->scope = head_sym->scope ) then
					if( env.clopt.lang = FB_LANG_FB ) then
						exit function
					end if

					'' same data type?
					if( symbGetType( head_sym ) = symbGetType( s ) ) then
						exit function
					end if

					'' neither has a suffix?
					if( ( symbIsSuffixed( head_sym ) = FALSE ) and ( symbIsSuffixed( s ) = FALSE ) ) then
						exit function
					end if

				end if

			case else
				exit function
			end select

			head_sym = head_sym->hash.next
		loop while( head_sym <> NULL )

	'' label?
	case FB_SYMBCLASS_LABEL

		do
			select case as const head_sym->class
			'' anything but a define, keyword or another label is allowed
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_NAMESPACE, _
				 FB_SYMBCLASS_KEYWORD, FB_SYMBCLASS_LABEL, _
				 FB_SYMBCLASS_CLASS

				exit function

			'' struct? only it's not unique
			case FB_SYMBCLASS_STRUCT
				if( symbGetIsUnique( head_sym ) ) then
					exit function
				end if
			end select

			head_sym = head_sym->hash.next
		loop while( head_sym <> NULL )

	'' param?
	case FB_SYMBCLASS_PARAM

		'' anything allowed, dups are only checked when adding params as variables

	end select

	function = TRUE

end function

'':::::
function symbNewSymbol _
	( _
		byval options as FB_SYMBOPT, _
		byval s as FBSYMBOL ptr, _
		byval symtb as FBSYMBOLTB ptr, _
		byval hashtb as FBHASHTB ptr, _
		byval class_ as FB_SYMBCLASS, _
		byval id as const zstring ptr, _
		byval id_alias as const zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB _
	) as FBSYMBOL ptr

    dim as integer slen = any, delok = any

    function = NULL

	if( symtb = NULL ) then
		symtb = symb.symtb

		'' parsing main?
		if( fbIsModLevel( )  ) then
			'' add to global tb, unless it's inside a scope block..
			if( parser.scope = FB_MAINSCOPE ) then
				'' not inside a namespace?
				if( symbIsGlobalNamespc( ) ) then
					'' symb.symbtb is pointing to main's symtb (due the
					'' implicit main function), so it can't be used
					symtb = @symbGetGlobalTb( )
				end if

				attrib and= not FB_SYMBATTRIB_LOCAL
			else
				attrib or= FB_SYMBATTRIB_LOCAL
			end if
		else
			attrib or= FB_SYMBATTRIB_LOCAL
		end if
	end if

    if( hashtb = NULL ) then
    	hashtb = symb.hashtb
    end if

    '' alloc symbol node?
    delok = FALSE
    if( s = NULL ) then
    	delok = TRUE
    	s = listNewNode( @symb.symlist )
    end if

    ''
    s->class = class_
	s->attrib = attrib
	s->stats = 0
	s->mangling = parser.mangling

    s->typ = dtype
    s->subtype = subtype

    '' QB quirks
	if( (options and FB_SYMBOPT_UNSCOPE) <> 0 ) then
		if( (parser.currproc->stats and (FB_SYMBSTATS_MAINPROC or _
									  	 FB_SYMBSTATS_MODLEVELPROC)) <> 0 ) then
			s->scope = FB_MAINSCOPE
		else
			s->scope = parser.currproc->scope + 1
		end if
	else
		s->scope = parser.scope
	end if

    '' name
    slen = iif( id <> NULL, len( *id ), 0 )
    if( slen > 0 ) then
    	s->id.name = poolNewItem( @symb.namepool, slen + 1 ) 'ZstrAllocate( slen )
    	if( (options and FB_SYMBOPT_PRESERVECASE) = 0 ) then
    		hUcase( id, s->id.name )
    	else
    	    *s->id.name = *id
		end if
    else
    	s->id.name = NULL
    	options and= not FB_SYMBOPT_DOHASH
    end if

    '' alias
    if( id_alias <> NULL ) then
    	s->id.alias = ZstrAllocate( len( *id_alias ) )
    	*s->id.alias = *id_alias
    else
    	s->id.alias = NULL
    end if

    s->id.mangled = NULL

    ''
    s->lgt = 0
    s->ofs = 0

	'' add to hash table
	s->hash.tb = hashtb

	if( (options and FB_SYMBOPT_DOHASH) <> 0 ) then
		dim as FBSYMBOL ptr head_sym = any

		s->hash.index = hashHash( s->id.name )

		'' doesn't exist yet?
		head_sym = hashLookupEx( @hashtb->tb, s->id.name, s->hash.index )
		if( head_sym = NULL ) then
			'' add to hash table
			s->hash.item = hashAdd( @hashtb->tb, s->id.name, s, s->hash.index )
            s->hash.prev = NULL
            s->hash.next = NULL

		else
			'' can it be duplicated?
			if( (options and FB_SYMBOPT_NODUPCHECK) = 0 ) then
				if( symbCanDuplicate( head_sym, s ) = FALSE ) then
					poolDelItem( @symb.namepool, s->id.name ) 'ZstrFree( s->id.name )
					ZstrFree( s->id.alias )
					ZstrFree( s->id.mangled )
					if( delok ) then
						listDelNode( @symb.symlist, s )
					end if
					exit function
				end if
			end if

			s->hash.item = head_sym->hash.item

			'' add to head so no scope resolution is needed

    		'' QB mode?
    		if( env.clopt.lang = FB_LANG_QB ) then
    			'' keywords must stay at the head
    			dim as FBSYMBOL ptr prev = NULL
    			do while( symbIsKeyword( head_sym ) )
    				prev = head_sym
    				head_sym = head_sym->hash.next
    				if( head_sym = NULL ) then
    					exit do
    				end if
    			loop

				if( prev = NULL ) then
					goto add_prev
				endif

				prev->hash.next = s
				s->hash.prev = prev
				s->hash.next = head_sym
				if( head_sym <> NULL ) then
					head_sym->hash.prev = s
				end if

    		else
add_prev:		head_sym->hash.item->data = s
				head_sym->hash.item->name = s->id.name
				head_sym->hash.prev = s
				s->hash.prev = NULL
				s->hash.next = head_sym
    		end if

		end if

	else
		s->hash.item = NULL
		s->hash.prev = NULL
        s->hash.next = NULL
	end if

	'' add to symbol table
	if( symtb->tail <> NULL ) then
		symtb->tail->next = s
	else
		symtb->head = s
	end if

	s->prev = symtb->tail
	s->next = NULL

	s->symtb = symtb

	symtb->tail = s

	s->parent = NULL

	'' forward type? add to the back-patch list..
	if( typeGetDtOnly( dtype ) = FB_DATATYPE_FWDREF ) then
		symbAddToFwdRef( subtype, s )
	end if

    ''
    function = s

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookup
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbHashListAdd _
	( _
		byval hashtb as FBHASHTB ptr _
	)

	if( symb.hashlist.tail <> NULL ) then
		symb.hashlist.tail->next = hashtb
	else
		symb.hashlist.head = hashtb
	end If

	hashtb->prev = symb.hashlist.tail
	hashtb->next = NULL

	symb.hashlist.tail = hashtb

end sub

'':::::
sub symbHashListAddBefore _
	( _
		byval lasttb as FBHASHTB ptr, _
		byval hashtb as FBHASHTB ptr _
	)

	if( lasttb->prev = NULL ) then
		symb.hashlist.head = hashtb
	else
		lasttb->prev->next = hashtb
	end if

	hashtb->prev = lasttb->prev
	hashtb->next = lasttb

	lasttb->prev = hashtb

end sub

'':::::
sub symbHashListDel _
	( _
		byval hashtb as FBHASHTB ptr _
	)

	assert( hashtb->prev <> NULL or hashtb->next <> NULL )

	if( hashtb->prev <> NULL ) then
		hashtb->prev->next = hashtb->next
	else
		symb.hashlist.head = hashtb->next
	end If

	if( hashtb->next <> NULL ) then
		hashtb->next->prev = hashtb->prev
	else
		symb.hashlist.tail = hashtb->prev
	end If

	hashtb->prev = NULL
	hashtb->next = NULL

end sub

'':::::
sub symbHashListInsertNamespace _
	( _
		byval ns as FBSYMBOL ptr, _
		byval src_head as FBSYMBOL ptr _
	)

	dim as FBSYMCHAIN ptr imp_head = symbGetCompExt( ns )->impsym_head
	dim as FBSYMCHAIN ptr imp_tail = symbGetCompExt( ns )->impsym_tail

	'' for each symbol in the ns being imported..
	dim as FBSYMBOL ptr s = src_head
    do until( s = NULL )
		'' if symbol has a name..
		if( s->hash.item <> NULL ) then
			'' only add the head symbol if it's duplicated
			if( s->hash.prev = NULL ) then
				dim as FBSYMCHAIN ptr chain_ = listNewNode( @symb.imphashlist )
				chain_->sym = s
				chain_->prev = NULL
				chain_->isimport = TRUE

				dim as FBSYMCHAIN ptr head = hashLookupEx( @symb.imphashtb, _
													   	   s->id.name, _
													   	   s->hash.index )
				'' not defined yet? create a new hash node
				if( head = NULL ) then
           			chain_->item = hashAdd( @symb.imphashtb, _
            								s->id.name, _
            								chain_, _
            								s->hash.index )
            		chain_->next = NULL

				'' already defined..
				else
					chain_->item = head->item
					'' add to head
					head->item->data = chain_
					head->prev = chain_
					chain_->next = head
				end if

            	''
            	if( imp_tail <> NULL ) then
            		imp_tail->imp_next = chain_
            	else
            		imp_head = chain_
            	end if
            	chain_->imp_next = NULL
            	imp_tail = chain_
        	end if
        end if

		s = s->next
	loop

	symbGetCompExt( ns )->impsym_head = imp_head
	symbGetCompExt( ns )->impsym_tail = imp_tail

end sub

'':::::
sub symbHashListRemoveNamespace _
	( _
		byval ns as FBSYMBOL ptr _
	)

	dim as FBSYMCHAIN ptr chain_ = symbGetCompExt( ns )->impsym_head

	do until( chain_ = NULL )
       	dim as FBSYMCHAIN ptr prv = any, nxt = any

    	prv = chain_->prev
    	nxt = chain_->next

    	if( prv <> NULL ) then
    		prv->next = nxt
    		if( nxt <> NULL ) then
    			nxt->prev = prv
    		end if
    	else
    		'' symbol was the head node?
    		if( nxt <> NULL ) then
    			nxt->prev = NULL

       			'' update list head
       			chain_->item->data = nxt

    		'' nothing left? remove from hash table
    		else
    			hashDel( @symb.imphashtb, chain_->item, chain_->sym->hash.index )
    		end if
    	end if

       	nxt = chain_->imp_next
       	listDelNode( @symb.imphashlist, chain_ )
       	chain_ = nxt
	loop

	symbGetCompExt( ns )->impsym_head = NULL
	symbGetCompExt( ns )->impsym_tail = NULL

end sub

private function chainpoolNext() as FBSYMCHAIN ptr
	symb.chainpoolhead += 1
	if (symb.chainpoolhead >= CHAINPOOL_SIZE) then
		symb.chainpoolhead = 0
	end if
	return @symb.chainpool(symb.chainpoolhead)
end function

'':::::
function symbLookup _
	( _
		byval id as zstring ptr, _
		byref tk as FB_TOKEN, _
		byref tk_class as FB_TKCLASS _
	) as FBSYMCHAIN ptr

    static as zstring * FB_MAXNAMELEN+1 sname

	'' assume it's an unknown identifier
	tk = FB_TK_ID
	tk_class = FB_TKCLASS_IDENTIFIER

	hUcase( *id, sname )
	id = @sname

    dim as uinteger index = hashHash( id )
    dim as FBSYMCHAIN ptr chain_ = NULL

    '' for each nested hash tb, starting from last
    dim as FBHASHTB ptr hashtb = symb.hashlist.tail

    do
    	dim as FBSYMBOL ptr sym = hashLookupEx( @hashtb->tb, id, index )
        if( sym <> NULL ) then
			chain_ = chainpoolNext()

			chain_->sym = sym
			chain_->next = NULL
			chain_->isimport = FALSE

			if( sym->class = FB_SYMBCLASS_KEYWORD ) then
				tk = sym->key.id
				tk_class = sym->key.tkclass
				'' return if it's a KEYWORD or a OPERATOR token, they
				'' can't never be redefined, even inside namespaces
				if( tk_class <> FB_TKCLASS_QUIRKWD ) then
					return chain_
				end if
			end if

			'' return if it's not the global ns (as in C++, any nested
			'' symbol has precedence over any imported one, even if the
			'' latter was imported in the current ns)
			if( hashtb->owner <> @symbGetGlobalNamespc( ) ) then
				return chain_
			else
				'' also if we are at the global ns, no need to check the imports
				if( symbGetCurrentNamespc( ) = @symbGetGlobalNamespc( ) ) then
					return chain_
				end if

				'' check (and add) the imports..
				exit do
			end if
        end if

    	hashtb = hashtb->prev
    loop while( hashtb <> NULL )

    '' now try the imported namespaces..
	dim as FBSYMCHAIN ptr imp_chain = hashLookupEx( @symb.imphashtb, id, index )
	if( chain_ = NULL ) then
		return imp_chain
	end if

	chain_->next = imp_chain

	return chain_

end function

'':::::
private function hLookupImportHash _
	( _
		byval ns as FBSYMBOL ptr, _
		byval id as const zstring ptr, _
		byval index as uinteger _
	) as FBSYMCHAIN ptr

    dim as FBSYMCHAIN ptr chain_head = hashLookupEx( @symb.imphashtb, id, index )
    if( chain_head = NULL ) then
    	return NULL
    end if

	dim as FBSYMCHAIN ptr head = NULL, tail = NULL

	'' for each namespace found..
	dim as FBSYMCHAIN ptr chain_ = chain_head
	do
    	'' for each namespace that imports that namespace..
    	dim as FBSYMBOL ptr exp_ = symbGetCompExportHead( symbGetNamespace( chain_->sym ) )
    	do
    		if( symbGetExportNamespc( exp_ ) = ns ) then
				dim as FBSYMCHAIN ptr node = chainpoolNext()

				node->sym = chain_->sym
				node->next = NULL
				node->isimport = TRUE

				if( head = NULL ) then
					head = node
				else
					tail->next = node
					'' it's ambiguous, just return the first two
					return head
				end if

				tail = node
			end if

			exp_ = symbGetExportNext( exp_ )
		loop while( exp_ <> NULL )

		chain_ = chain_->next
	loop while( chain_ <> NULL )

    return head

end function

'':::::
private function hLookupImportList _
	( _
		byval ns as FBSYMBOL ptr, _
		byval id as const zstring ptr, _
		byval index as uinteger _
	) as FBSYMCHAIN ptr

	dim as FBSYMCHAIN ptr head = NULL, tail = NULL

	'' for each namespace imported by this ns..
	dim as FBSYMBOL ptr imp_ = symbGetCompImportHead( ns )
	do while( imp_ <> NULL )
		dim as FBSYMBOL ptr sym = hashLookupEx( _
									@symbGetCompHashTb( _
										symbGetImportNamespc( imp_ ) ).tb, _
									id, _
									index )
    	if( sym <> NULL ) then
			dim as FBSYMCHAIN ptr chain_ = chainpoolNext()

			chain_->sym = sym
            chain_->next = NULL
            chain_->isimport = TRUE

			if( head = NULL ) then
				head = chain_
			else
				tail->next = chain_
				'' it's ambiguous, just return the first two
				return head
			end if

			tail = chain_
		end if

		imp_ = symbGetImportNext( imp_ )
	loop

	return head

end function

'':::::
function symbLookupAt _
	( _
		byval ns as FBSYMBOL ptr, _
		byval id as const zstring ptr, _
		byval preserve_case as integer, _
		byval search_imports as integer _
	) as FBSYMCHAIN ptr

    static as zstring * FB_MAXNAMELEN+1 sname

	assert( symbIsStruct( ns ) or symbIsNamespace( ns ) or symbIsEnum( ns ) )

	if( symbIsEnum( ns ) and (not symbEnumHasHashTb( ns )) ) then
		exit function
	end if

    if( preserve_case = FALSE ) then
    	hUcase( *id, sname )
    	id = @sname
    end if

    dim as uinteger index = hashHash( id )

    '' search in UDT's (NAMESPACE, TYPE, CLASS or ENUM) hash tb first
    dim as FBSYMBOL ptr sym = hashLookupEx( @symbGetCompHashTb( ns ).tb, id, index )
    if( sym = NULL ) then
    	if( search_imports = FALSE ) then
    		return NULL
    	end if

    else
		dim as FBSYMCHAIN ptr chain_ = chainpoolNext()
    	chain_->sym = sym
    	chain_->next = NULL
    	chain_->isimport = FALSE
    	return chain_
    end if
	
    '' nothing found, now search the imports (if any)..
    if( symbGetCompExt( ns ) = NULL ) then
    	return NULL
    end if

	if( symbGetCompImportHead( ns ) = NULL ) then
		return NULL
	end if

    '' special cases: the global ns
    if( ns = @symbGetGlobalNamespc( ) ) then
    	return hLookupImportHash( ns, id, index )

    '' do a per-hash slow search..
    else
    	return hLookupImportList( ns, id, index )
    end if

end function

'':::::
function symbLookupByNameAndClass _
	( _
		byval ns as FBSYMBOL ptr, _
		byval id as const zstring ptr, _
	  	byval class_ as integer, _
	  	byval preserve_case as integer, _
	  	byval search_imports as integer _
	) as FBSYMBOL ptr

	dim as FBSYMCHAIN ptr chain_ = any

    chain_ = symbLookupAt( ns, id, preserve_case, search_imports )

    '' any found?
    if( chain_ <> NULL ) then
    	'' check if classes match
    	function = symbFindByClass( chain_, class_ )
    else
    	function = NULL
    end if

end function

'':::::
function symbFindByClass _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval class_ as integer _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr sym = any
    dim as integer match = FALSE

    '' lookup a symbol with the same class
    do while( chain_ <> NULL )
    	sym = chain_->sym
    	do
    		if( sym->class = class_ ) then
				match = TRUE
				exit do, do
			end if

			sym = sym->hash.next
		loop while( sym <> NULL )

    	chain_ = chain_->next
    loop
    
    if( match = FALSE ) then
		return NULL
	end if

	'' check if symbol isn't a non-shared module level one
	if( symbIsVar( sym ) ) then
		if( symbVarCheckAccess( sym ) ) then
			return sym
		else
			return NULL
		end if
	end if

	function = sym

end function

'':::::
function symbFindVarBySuffix _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval suffix as integer _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr sym = any

    '' symbol has a suffix: lookup a symbol with the same type, suffixed or not

   	'' QB quirk: fixed-len and zstrings referenced using '$' as suffix..
   	if( suffix = FB_DATATYPE_STRING ) then
   		do while( chain_ <> NULL )
    		sym = chain_->sym
    		do
    			if( symbIsVar( sym ) ) then
     				select case symbGetType( sym )
     				case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
     					goto check_var
     				end select
     			end if

				sym = sym->hash.next
			loop while( sym <> NULL )

    		chain_ = chain_->next
    	loop

    '' anything but strings..
    else
    	do while( chain_ <> NULL )
    		sym = chain_->sym
    		do
    			if( symbIsVar( sym ) ) then
    				if( symbGetType( sym ) = suffix ) then
    					goto check_var
    				end if
    			end if

				sym = sym->hash.next
			loop while( sym <> NULL )

    		chain_ = chain_->next
    	loop
    end if

	return NULL

check_var:
	'' check if symbol isn't a non-shared module level one
	if( symbVarCheckAccess( sym ) ) then
		function = sym
	else
		function = NULL
	end if

end function

'':::::
function symbFindVarByDefType _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval def_dtype as integer _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr sym = any

    '' symbol has no suffix: lookup a symbol w/o suffix or with the
    '' same type as default type (last DEF###)

    '' QB quirk: see above
    if( def_dtype = FB_DATATYPE_STRING ) then
    	do while( chain_ <> NULL )
    		sym = chain_->sym
    		do
    			if( symbIsVar( sym ) ) then
    				if( symbIsSuffixed( sym ) ) then
    					select case sym->typ
    					case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
    						goto check_var
    					end select
    				else
    					goto check_var
    				end if
    			end if

				sym = sym->hash.next
			loop while( sym <> NULL )

    		chain_ = chain_->next
    	loop

    '' anything but strings..
    else
    	do while( chain_ <> NULL )
    		sym = chain_->sym
    		do
    			if( symbIsVar( sym ) ) then
    				if( symbIsSuffixed( sym ) ) then
    					if( symbGetType( sym ) = def_dtype ) then
    						goto check_var
    					end if
    				else
    					goto check_var
    				end if
    			end if

				sym = sym->hash.next
			loop while( sym <> NULL )

    		chain_ = chain_->next
    	loop
    end if

	return NULL

check_var:
	'' check if symbol isn't a non-shared module level one
	if( symbVarCheckAccess( sym ) ) then
		function = sym
	else
		function = NULL
	end if

end function

function symbFindByClassAndType _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval symclass as integer, _
		byval dtype as integer _
	) as FBSYMBOL ptr

	function = NULL

	while( chain_ )

		var sym = chain_->sym
		do

			if( (sym->class = symclass) and (symbGetFullType( sym ) = dtype) ) then
				if( symclass = FB_SYMBCLASS_VAR ) then
					'' check if symbol isn't a non-shared module level one
					if( symbVarCheckAccess( sym ) = FALSE ) then
						exit function
					end if
				end if
				return sym
			end if

			sym = sym->hash.next
		loop while( sym )

		chain_ = chain_->next
	wend

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbDelFromChainList _
	( _
		byval s as FBSYMBOL ptr _
	)

    dim as FBSYMBOL ptr prv = any, nxt = any

	'' note: symbols declared inside namespaces can't be
    '' removed by #undef or OPTION NOKEYWORD so the import
    '' chain doesn't have to be updated

    '' relink
    prv = s->hash.prev
    nxt = s->hash.next
    if( prv <> NULL ) then
    	prv->hash.next = nxt

    	if( nxt <> NULL ) then
    		nxt->hash.prev = prv
    	end if

    else
    	'' symbol was the head node?
    	if( nxt <> NULL ) then
    		nxt->hash.prev = NULL

    		'' update list head
       		s->hash.item->data = nxt
       		s->hash.item->name = nxt->id.name

    	'' nothing left? remove from hash table
    	else
    		hashDel( @s->hash.tb->tb, s->hash.item, s->hash.index )
    	end if
    end if

end sub

'':::::
sub symbDelFromHash _
	( _
		byval s as FBSYMBOL ptr _
	)

	if( s->hash.item = NULL ) then
		exit sub
	end if

	symbDelFromChainList( s )

    s->hash.item = NULL

end sub

'':::::
sub symbFreeSymbol _
	( _
		byval s as FBSYMBOL ptr _
	)

    '' Symbol has forward type? That means it was added to the fwdref's list
    '' of references/users for backpatching later. If the fwdref type is
    '' still here, that means no backpatching happened yet, so the fwdref node
    '' still exists and may do backpatching later. 
    '' This symbol must be removed from the fwdref's user list, otherwise the
    '' fwdref could backpatch a deleted node and would then corrupt any symbol
    '' allocated at that address.
    if( typeGetDtOnly( s->typ ) = FB_DATATYPE_FWDREF ) then
        assert( s->subtype->class = FB_SYMBCLASS_FWDREF )
        symbRemoveFromFwdRef( s->subtype, s )
    end if

	'' revove from hash tb
	symbDelFromHash( s )

	symbFreeSymbol_UnlinkOnly( s )
	symbFreeSymbol_RemOnly( s )

end sub

'':::::
sub symbFreeSymbol_RemOnly _
	( _
		byval s as FBSYMBOL ptr _
	)

	'' remove from symbol tb
	poolDelItem( @symb.namepool, s->id.name ) 'ZstrFree( s->id.name )

	ZstrFree( s->id.alias )
	ZstrFree( s->id.mangled )

	listDelNode( @symb.symlist, s )

end sub

'':::::
sub symbFreeSymbol_UnlinkOnly _
	( _
		byval s as FBSYMBOL ptr _
	)

	dim as FBSYMBOLTB ptr tb = any
	dim as FBSYMBOL ptr prv = any, nxt = any

	'' del from table
	tb = s->symtb

	prv = s->prev
	nxt = s->next
	if( prv <> NULL ) then
		prv->next = nxt
	else
		tb->head = nxt
	end if

	if( nxt <> NULL ) then
		nxt->prev = prv
	else
		tb->tail = prv
	end if

	s->prev = NULL
	s->next = NULL

end sub

sub symbDelSymbol _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer _
	)

	'' is_tbdel: If the whole symbol table of a scope or namespace is
	'' being deleted, we don't need to bother deleting symbols recursively,
	'' such as array descriptors attached to variables, because the symbol
	'' table deletion will catch them already. In fact, when deleting a
	'' symbol table, any attached symbols might be deleted *before* their
	'' parents, which then can not use the dangling pointers...

	select case as const( s->class )
	case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD : symbDelVar( s, is_tbdel )
	case FB_SYMBCLASS_CONST     : symbDelConst( s )
	case FB_SYMBCLASS_PROC      : symbDelPrototype( s )
	case FB_SYMBCLASS_DEFINE    : symbDelDefine( s )
	case FB_SYMBCLASS_LABEL     : symbDelLabel( s )
	case FB_SYMBCLASS_ENUM      : symbDelEnum( s )
	case FB_SYMBCLASS_STRUCT    : symbDelStruct( s )
	case FB_SYMBCLASS_SCOPE     : symbDelScope( s )
	case FB_SYMBCLASS_NAMESPACE : symbDelNamespace( s )
	case FB_SYMBCLASS_NSIMPORT  : symbNamespaceRemove( s, FALSE )
	case else                   : symbFreeSymbol( s )
	end select

end sub

function symbCloneSymbol( byval s as FBSYMBOL ptr ) as FBSYMBOL ptr
	dim as integer arraydtype = any
	dim as FBSYMBOL ptr arraysubtype = any

	'' assuming only non-complex symbols will be passed,
	'' for use by astTypeIniClone() mainly

	select case as const s->class
	case FB_SYMBCLASS_PROC
		'' Only procptr subtype PROC symbols, but no real PROCs,
		'' should appear in TYPEINI scopes.
		assert( symbGetIsFuncPtr( s ) )
		function = symbAddProcPtrFromFunction( s )

    case FB_SYMBCLASS_VAR
    	function = symbCloneVar( s )

    case FB_SYMBCLASS_CONST
		function = symbCloneConst( s )

    case FB_SYMBCLASS_LABEL
    	function = symbCloneLabel( s )

	case FB_SYMBCLASS_STRUCT
		'' Assuming only array descriptor types will ever be cloned
		'' (most other structs would be too complex, especially classes)
		assert( symbIsDescriptor( s ) )

		symbGetDescTypeArrayDtype( s, arraydtype, arraysubtype )
		function = symbAddArrayDescriptorType( symbGetDescTypeDimensions( s ), arraydtype, arraysubtype )

    case else
		assert( FALSE )
    	function = NULL
    end select

end function

'':::::
sub symbDelGlobalTb( )

    do
    	'' starting from last (an USING must be removed before
    	'' the ns in the same scope it's referencing)
    	dim as FBSYMBOL ptr s = symbGetGlobalTb( ).tail
    	if( s = NULL ) then
    		exit do
    	end if

    	symbDelSymbol( s, TRUE )
    loop

end sub

'':::::
sub symbDelSymbolTb _
	( _
		byval tb as FBSYMBOLTB ptr, _
		byval hashonly as integer _
	)

    '' del from hash tb only?
    if( hashonly ) then
		dim as FBSYMBOL ptr s = tb->head
		while( s )
			symbDelFromHash( s )

			if( s->class = FB_SYMBCLASS_NSIMPORT ) then
				symbNamespaceRemove( s, TRUE )
			end if

			s = s->next
		wend
    '' del from hash and symbol tb's
    else
    	do
    	    '' starting from last because USING's can be referencing
    	    '' namespace symbols in the same scope block
    	    dim as FBSYMBOL ptr s = tb->tail
    		if( s = NULL ) then
    			exit do
    		end if

	    	symbDelSymbol( s, TRUE )
    	loop

    end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

function symbHasCtor( byval sym as FBSYMBOL ptr ) as integer
	'' shouldn't be called on structs - can directly use symbGetCompCtorHead()
	assert( symbIsStruct( sym ) = FALSE )
	'' Handle vars, params, function results, etc.
	function = typeHasCtor( sym->typ, sym->subtype )
end function

function symbHasDefCtor( byval sym as FBSYMBOL ptr ) as integer
	assert( symbIsStruct( sym ) = FALSE )
	function = typeHasDefCtor( sym->typ, sym->subtype )
end function

function symbHasDtor( byval sym as FBSYMBOL ptr ) as integer
	assert( symbIsStruct( sym ) = FALSE )
	function = typeHasDtor( sym->typ, sym->subtype )
end function

function symbIsDataDesc( byval sym as FBSYMBOL ptr ) as integer
	if( symbGetType( sym ) = FB_DATATYPE_STRUCT ) then
		function = (symbGetSubtype( sym ) = ast.data.desc)
	end if
end function

function symbIsArray( byval sym as FBSYMBOL ptr ) as integer
	select case sym->class
	case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
		assert( iif( symbGetIsDynamic( sym ), (symbGetArrayDimensions( sym ) <> 0), TRUE ) )
		function = (symbGetArrayDimensions( sym ) <> 0)
	case else
		function = FALSE
	end select
end function

'':::::
function symbIsString _
	( _
		byval dtype as integer _
	) as integer

	select case as const dtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		function = TRUE
	case else
		function = FALSE
	end select

end function

function symbTypeToStr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval length as longint, _
		byval is_fixlenstr as integer _
	) as string

	dim as string s

	if( dtype = FB_DATATYPE_INVALID ) then
		exit function
	end if

	if( length <= 0 ) then
		length = symbCalcLen( dtype, subtype )
	end if

	var ptrcount = typeGetPtrCnt( dtype )
	var dtypeonly = typeGetDtOnly( dtype )

	if( typeIsConstAt( dtype, ptrcount ) ) then
		s = "const "
	else
		s = ""
	end if

	select case as const( dtypeonly )
	case FB_DATATYPE_FWDREF, FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
		s += hGetNamespacePrefix( subtype )
		s += *symbGetName( subtype )

	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, FB_DATATYPE_FIXSTR
		s += *symb_dtypeTB(dtypeonly).name
		if( is_fixlenstr or (length <> symb_dtypeTB(dtypeonly).size) ) then
			select case( dtypeonly )
			case FB_DATATYPE_FIXSTR
				'' For STRING*N the null terminator is
				'' implicitly added, the length actually is N+1,
				'' unlike Z/WSTRING*N where N includes it.
				length -= 1
			case FB_DATATYPE_WCHAR
				'' Convert bytes back to chars
				length \= typeGetSize( FB_DATATYPE_WCHAR )
			end select
			s += " * " + str( length )
		end if

	case FB_DATATYPE_FUNCTION
		'' Procedure pointer

		'' The sub() or function() already implies one PTR
		assert( ptrcount > 0 )
		ptrcount -= 1

		'' If there are any more PTRs, i.e. a PTR to a proc PTR,
		'' then it must be emitted inside a typeof():
		''    typeof( function( ) as integer ) ptr
		'' otherwise, the PTR would be seen as part of the
		'' function result type:
		''    function( ) as integer ptr
		if( ptrcount > 0 ) then
			s += "typeof("
		end if

		s += symbProcPtrToStr( subtype )

		if( ptrcount > 0 ) then
			s += ")"
		end if

	case else
		s += *symb_dtypeTB(dtypeonly).name
	end select

	for i as integer = ptrcount-1 to 0 step -1
		if( typeIsConstAt( dtype, i ) ) then
			s += " const"
		end if
		s += " ptr"
	next

	function = s
end function

'':::::
function symbGetDefType _
	( _
		byval symbol as const zstring ptr _
	) as integer

    dim as integer c = any
	dim as integer i = any

	c = symbol[0][0]

	'' to upper
	if( (c >= asc("a")) and (c <= asc("z")) ) then
		c -= (asc("a") - asc("A"))
	end if

	i = c - asc("A")

	'' if lead character is not on the table, use the dialect default
	'' (error recovery may create a temporary symbol name)
	if( (i < lbound(deftypeTB)) or (i > ubound(deftypeTB)) ) then
		if( fbLangIsSet( FB_LANG_QB ) ) then
			function = FB_DATATYPE_SINGLE
		else
			function = FB_DATATYPE_INTEGER
		end if
	else
		function = deftypeTB(i)
	end if

end function

'':::::
sub symbSetDefType _
	( _
		byval ichar as integer, _
		byval echar as integer, _
		byval dtype as integer _
	)

    dim as integer i = any

	if( ichar < asc("A") ) then
		ichar = asc("A")
	elseif( ichar > asc("_") ) then
		ichar = asc("_")
	end if

	if( echar < asc("A") ) then
		echar = asc("A")
	elseif( echar > asc("_") ) then
		echar = asc("_")
	end if

	if( ichar > echar ) then
		swap ichar, echar
	end if

	for i = ichar to echar
		deftypeTB(i - asc("A")) = dtype
	next

end sub

'' Recalculate the length, to be used after the symbol's type was set/changed
sub symbRecalcLen( byval sym as FBSYMBOL ptr )
	if( sym->class = FB_SYMBCLASS_PARAM ) then
		sym->lgt = symbCalcParamLen( sym->typ, sym->subtype, sym->param.mode )
	else
		sym->lgt = symbCalcLen( sym->typ, sym->subtype )
	end if
end sub

sub symbSetType _
	( _
		byval sym as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

	sym->typ = dtype
	sym->subtype = subtype

	symbRecalcLen( sym )

	'' If it's a procedure, the real dtype must be updated too
	if( symbIsProc( sym ) ) then
		symbProcRecalcRealType( sym )
	end if

	'' If setting type to a fwdref, register symbol for back-patching
	'' (e.g. when substituting a fwdref by another fwdref)
	if( typeGetDtOnly( dtype ) = FB_DATATYPE_FWDREF ) then
		symbAddToFwdRef( subtype, sym )
	end if

end sub

function symbCalcLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as longint

	dtype = typeGet( dtype )

	select case as const( dtype )
	case FB_DATATYPE_FIXSTR
		function = 0  '' zero-length literal-strings

	case FB_DATATYPE_STRUCT
		function = subtype->lgt

	case else
		function = typeGetSize( dtype )
	end select

end function

function symbCalcDerefLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr  _
	) as longint

	dim as longint length = any

	assert( typeIsPtr( dtype ) )

	length = symbCalcLen( typeDeref( dtype ), subtype )

	'' incomplete type?
	if( length = 0 ) then
		'' ANY PTR?
		if( dtype = typeAddrOf( FB_DATATYPE_VOID ) ) then
			'' treat as BYTE PTR
			length = 1
		end if
		'' (for anything else, we return 0 to indicate the error)
	end if

	function = length
end function

function symbCheckAccess( byval sym as FBSYMBOL ptr ) as integer
	dim as FBSYMBOL ptr parent = any, context = any

	'' Neither private nor protected? Always ok.
	if( (sym->attrib and (FB_SYMBATTRIB_VIS_PRIVATE or FB_SYMBATTRIB_VIS_PROTECTED)) = 0 ) then
		return TRUE
	end if

	'' Notes:
	''  - Only UDT members will have visibility flags
	''  - Private/protected members can *only* be accessed from inside
	''    member procedures or the UDT body
	''  - There may be nested namespaces inside those procedures,
	''    from which accesses are possible
	''      (e.g. enum constant initializers)
	''  - UDTs may contain nested namespaces whose members should be
	''    affected by visibility too (e.g. named enums)
	''  - There are no nested procedures
	''  - All UDTs are also namespaces

	'' Walk upwards the symbol's parent namespaces until we find the
	'' symbol's parent UDT. (Usually it's the first parent, but e.g. with
	'' named enums inside UDTs there can be another namespace in between)
	parent = sym
	do
		assert( parent <> @symbGetGlobalNamespc( ) )
		parent = symbGetNamespace( parent )
	loop while( not symbIsStruct( parent ) )

	'' Check against the current context, only allowing...
	'' - private access from inside the symbol's parent UDT namespace,
	''   i.e. the UDT body, a method, or a namespace nested inside either.
	'' - protected access from inside the namespace of an UDT that was
	''   derived from the symbol's real parent UDT.

	'' For all nested namespaces in the current parsing context,
	'' from the current namespace up to the toplevel one...
	context = symbGetCurrentNamespc( )
	while( context <> @symbGetGlobalNamespc( ) )

		'' Is it an UDT namespace? (i.e. a method or UDT body?)
		if( symbIsStruct( context ) ) then
			'' Ok if same namespace for private/protected
			if( context = parent ) then
				'' We're inside the parent
				return TRUE
			end if

			'' Protected additionally allows derived UDTs
			if( sym->attrib and FB_SYMBATTRIB_VIS_PROTECTED ) then
				if( symbGetUDTBaseLevel( context, parent ) > 0 ) then
					'' We're inside an UDT derived from the parent
					return TRUE
				end if
			end if
		end if

		context = symbGetNamespace( context )
	wend

	function = FALSE
end function

function symbCheckConstAssign _
	( _
		byval ldtype as FB_DATATYPE, _
		byval rdtype as FB_DATATYPE, _
		byval lsubtype as FBSYMBOL ptr, _
		byval rsubtype as FBSYMBOL ptr, _
		byval mode as FB_PARAMMODE = 0, _
		byref matches as integer = 0 _
	) as integer

	dim as integer i = any, lcount = any, rcount = any, rmatches = any
	dim as integer lconst = any, rconst = any

	''
	'' Toplevel const:
	''
	''       T := const T    ok (byval copy)
	'' const T :=       T    ok in initialization, not later
	''
	'' T       ptr := T const ptr    ok (byval copy)
	'' T const ptr := T       ptr    ok in initialization, not later
	''
	''
	'' Nested consts:
	''
	'' const T ptr := const T ptr    ok
	'' const T ptr :=       T ptr    ok
	''       T ptr := const T ptr    not ok
	''
	'' Basically the lhs may add CONSTs, but not remove them.
	''
	'' If pointer indirection levels differ, then the check stops at the
	'' last level that they still have in common, for example:
	''
	''     T ptr ptr := const T ptr
	''     (rhs is a pointer to something const, but lhs is a ptr to
	''     something non-const, so they're incompatible)
	''
	''     T ptr := const T ptr ptr
	''     (rhs is a pointer to a non-const "const T ptr"; lhs is a pointer
	''     to something non-const aswell, match)
	''
	''     const T ptr := T const ptr ptr
	''     (rhs is a pointer to a const "T ptr"; lhs is a pointer to a
	''     const something, match)
	''

	function = FALSE
	matches = 0

	'' no consts? short-circuit
	if( (typeGetConstMask( ldtype ) or typeGetConstMask( rdtype )) = 0 ) then
		return TRUE
	end if

	'' vararg? they aren't type safe anyway
	if( mode = FB_PARAMMODE_VARARG ) then
		return TRUE
	end if

	lcount = typeGetPtrCnt( ldtype )
	rcount = typeGetPtrCnt( rdtype )
	i = 0
	rmatches = rcount

	select case( mode )
	'' byval params need extra matching for overload resolution
	case FB_PARAMMODE_BYVAL
		i = 1
		matches = rcount + 1
		'' top-level const gets precedence...
		if( typeIsConst( ldtype ) ) then
			matches += 1
		end if

	'' just a variable assignment?
	case 0
		i = 1

	'' byref/bydesc param, check every level
	case else
		rmatches += 1
	end select

	'' Walk along all the CONST flags. It's an error if the rhs is CONST
	'' while the lhs isn't, i.e. the lhs "loses" CONSTness.
	while( (i <= lcount) and (i <= rcount) )
		lconst = typeIsConstAt( ldtype, i )
		rconst = typeIsConstAt( rdtype, i )

		if( lconst = rconst ) then
			if( matches < rmatches ) then
				matches = rmatches
			end if
		end if

		if( rconst and (not lconst) ) then
			exit function
		end if

		rmatches -= 1
		i += 1
	wend

	function = TRUE
end function

private sub hForEachGlobal _
	( _
		byval sym as FBSYMBOL ptr, _
		byval symclass as integer, _
		byval callback as sub( byval as FBSYMBOL ptr ) _
	)

	while( sym )
		select case( symbGetClass( sym ) )
		case FB_SYMBCLASS_NAMESPACE
			hForEachGlobal( symbGetNamespaceTbHead( sym ), symclass, callback )

		case FB_SYMBCLASS_STRUCT
			hForEachGlobal( symbGetCompSymbTb( sym ).head, symclass, callback )

		case FB_SYMBCLASS_SCOPE
			hForEachGlobal( symbGetScopeSymbTbHead( sym ), symclass, callback )

		case symclass
			callback( sym )
		end select

		sym = sym->next
	wend

end sub

sub symbForEachGlobal _
	( _
		byval symclass as integer, _
		byval callback as sub( byval as FBSYMBOL ptr ) _
	)

	hForEachGlobal( symbGetGlobalTbHead( ), symclass, callback )

end sub

private function hGetNamespacePrefix( byval sym as FBSYMBOL ptr ) as string
	dim as FBSYMBOL ptr ns = any
	dim as string s

	if( symbGetHashtb( sym ) = NULL ) then
		return "<no hash tb>"
	end if

	ns = symbGetNamespace( sym )
	while( ns <> @symbGetGlobalNamespc( ) )
		s = *symbGetName( ns ) + "." + s

		if( symbGetHashtb( ns ) = NULL ) then
			exit while
		end if

		ns = symbGetNamespace( ns )
	wend

	function = s
end function

#if __FB_DEBUG__
static shared as zstring ptr classnames(FB_SYMBCLASS_VAR to FB_SYMBCLASS_NSIMPORT) = _
{ _
	@"var"      , _
	@"const"    , _
	@"proc"     , _
	@"param"    , _
	@"define"   , _
	@"keyword"  , _
	@"label"    , _
	@"namespace", _
	@"enum"     , _
	@"struct"   , _
	@"class"    , _
	@"field"    , _
	@"typedef"  , _
	@"fwdref"   , _
	@"scope"    , _
	@"nsimport"   _
}

'' For debugging
function typeDump _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as string

	dim as string dump
	dim as integer ok = any, ptrcount = any, dtypeonly = any

	dump = "["

	if( dtype and FB_DATATYPE_INVALID ) then
		dump += "invalid"
		ok = (subtype = NULL)
	else
		ptrcount = typeGetPtrCnt( dtype )
		assert( ptrcount >= 0 )

		if( typeIsRef( dtype ) ) then
			dump += "byref "
		end if

		if( typeIsConstAt( dtype, ptrcount ) ) then
			dump += "const "
		end if

		dtypeonly = typeGetDtOnly( dtype )
		select case( dtypeonly )
		case FB_DATATYPE_STRUCT
			dump += "struct"
		case FB_DATATYPE_WCHAR
			dump += "wchar"
		case FB_DATATYPE_FIXSTR
			dump += "fixstr"
		case else
			if( (dtypeonly >= 0) and (dtypeonly < FB_DATATYPES) ) then
				dump += *symb_dtypeTB(dtypeonly).name
			else
				dump += "<invalid dtype " & dtypeonly & ">"
			end if
		end select

		'' UDT name
		select case( typeGetDtOnly( dtype ) )
		case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
			if( subtype ) then
				if( symbIsStruct( subtype ) ) then
					dump += " "
					dump += hGetNamespacePrefix( subtype )
					dump += *symbGetName( subtype )
				end if
			end if

		case FB_DATATYPE_NAMESPC
			if( subtype ) then
				if( symbIsNamespace( subtype ) ) then
					if( subtype = @symbGetGlobalNamespc( ) ) then
						dump += " <global namespace>"
					else
						dump += " " + *symbGetName( subtype )
					end if
				end if
			end if
		end select

		for i as integer = (ptrcount-1) to 0 step -1
			if( typeIsConstAt( dtype, i ) ) then
				dump += " const"
			end if
			dump += " ptr"
		next

		'' Report unusual subtypes
		if( subtype ) then
			select case( typeGetDtOnly( dtype ) )
			case FB_DATATYPE_STRUCT
				ok = symbIsStruct( subtype )
			case FB_DATATYPE_ENUM
				ok = symbIsEnum( subtype )
			case FB_DATATYPE_NAMESPC
				ok = symbIsNamespace( subtype )
			case FB_DATATYPE_FUNCTION
				ok = symbIsProc( subtype )
			case FB_DATATYPE_FWDREF
				ok = symbIsFwdref( subtype )
			case else
				ok = FALSE
			end select
		else
			select case( typeGetDtOnly( dtype ) )
			case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM, _
			     FB_DATATYPE_NAMESPC, _
			     FB_DATATYPE_FUNCTION, FB_DATATYPE_FWDREF
				ok = FALSE
			case else
				ok = TRUE
			end select
		end if
	end if

	if( ok = FALSE ) then
		dump += ", "
		if( subtype ) then
			if( (subtype->class >= FB_SYMBCLASS_VAR) and _
			    (subtype->class <  FB_SYMBCLASS_NSIMPORT) ) then
				dump += *classnames(subtype->class)
			else
				dump += str( subtype->class )
			end if
		else
			dump += "NULL"
		end if
	end if

	dump += "]"

	function = dump
end function

private sub hDumpName( byref s as string, byval sym as FBSYMBOL ptr )
	if( sym = @symbGetGlobalNamespc( ) ) then
		s += "<global namespace>"
	else
		s += hGetNamespacePrefix( sym )
	end if

	if( sym->id.name ) then
		s += *sym->id.name
	else
		s += "<unnamed>"
	end if

	if( sym->id.alias ) then
		s += " alias """ + *sym->id.alias + """"
	end if

#if 0
	'' Note: symbGetMangledName() will mangle the proc and set the
	'' "mangled" flag. If this is done too early though, before the proc is
	'' setup properly, then the mangled name will be empty or wrong.
	s += " mangled """ + *symbGetMangledName( sym ) + """"
#endif
end sub

function symbDump( byval sym as FBSYMBOL ptr ) as string
	dim as string s

	if( sym = NULL ) then
		return "<NULL>"
	end if

#if 0
	s += "[" & hex( sym ) & "] "
#endif

#if 1
	if( (sym->class < FB_SYMBCLASS_VAR) or (sym->class > FB_SYMBCLASS_NSIMPORT) ) then
		s += "<bad class " + str( sym->class ) + "> "
	else
		s += *classnames(sym->class) + " "
	end if
#endif

#if 1
	#macro checkAttrib( ID )
		if( sym->attrib and FB_SYMBATTRIB_##ID ) then
			s += lcase( #ID ) + " "
		end if
	#endmacro

	checkAttrib( SHARED )
	checkAttrib( STATIC )
	checkAttrib( DYNAMIC )
	checkAttrib( COMMON )
	checkAttrib( EXTERN )
	checkAttrib( PUBLIC )
	checkAttrib( PRIVATE )
	checkAttrib( LOCAL )
	checkAttrib( EXPORT )
	checkAttrib( IMPORT )
	checkAttrib( OVERLOADED )
	if( symbIsProc( sym ) ) then
		checkAttrib( METHOD )
	else
		checkAttrib( INSTANCEPARAM )
	end if
	checkAttrib( CONSTRUCTOR )
	checkAttrib( DESTRUCTOR )
	checkAttrib( OPERATOR )
	checkAttrib( PROPERTY )
	checkAttrib( PARAMBYDESC )
	checkAttrib( PARAMBYVAL )
	checkAttrib( PARAMBYREF )
	checkAttrib( LITERAL )
	checkAttrib( CONST )
	checkAttrib( STATICLOCALS )
	checkAttrib( TEMP )
	checkAttrib( DESCRIPTOR )
	checkAttrib( FUNCRESULT )
	checkAttrib( REF )
	checkAttrib( VIS_PRIVATE )
	checkAttrib( VIS_PROTECTED )
	if( symbIsProc( sym ) ) then
		checkAttrib( NAKED )
	else
		checkAttrib( SUFFIXED )
	end if
	checkAttrib( ABSTRACT )
	checkAttrib( VIRTUAL )
	checkAttrib( NOTHISCONSTNESS )
#endif

#if 1
	#macro checkStat( ID )
		if( sym->stats and FB_SYMBSTATS_##ID ) then
			s += lcase( #ID ) + " "
		end if
	#endmacro

	checkStat( ACCESSED )
	checkStat( CTORINITED )
	checkStat( DECLARED )
	checkStat( IMPLICIT )
	checkStat( RTL )
	checkStat( THROWABLE )
	checkStat( PARSED )
	checkStat( RTTITABLE )
	checkStat( HASALIAS )
	checkStat( VTABLE )
	if( symbIsProc( sym ) ) then
		checkStat( EXCLPARENT )
	else
		checkStat( DONTINIT )
	end if
	checkStat( MAINPROC )
	checkStat( MODLEVELPROC )
	checkStat( FUNCPTR )
	checkStat( JUMPTB )
	checkStat( GLOBALCTOR )
	checkStat( GLOBALDTOR )
	checkStat( CANTDUP )
	if( symbIsProc( sym ) ) then
		checkStat( CANBECLONED )
	else
		checkStat( ARGV )
	end if
	checkStat( HASRTTI )
	checkStat( CANTUNDEF )
	if( symbIsField( sym ) ) then
		checkStat( UNIONFIELD )
	elseif( symbIsProc( sym ) ) then
		checkStat( PROCEMITTED )
	else
		checkStat( WSTRING )
	end if
	checkStat( RTL_CONST )
	checkStat( EMITTED )
	checkStat( BEINGEMITTED )
#endif

	if( sym->class = FB_SYMBCLASS_NSIMPORT ) then
		s += "from: "
		s += symbDump( sym->nsimp.imp_ns )
		return s
	end if

	select case( sym->class )
	case FB_SYMBCLASS_PROC
		s += *symbGetFullProcName( sym )

		select case( symbGetProcMode( sym ) )
		case FB_FUNCMODE_STDCALL    : s += " stdcall"
		case FB_FUNCMODE_STDCALL_MS : s += " stdcallms"
		case FB_FUNCMODE_PASCAL     : s += " pascal"
		case FB_FUNCMODE_CDECL      : s += " cdecl"
		end select

#if 0
		'' Dump parameters recursively (if any)
		s += "("
		var param = symbGetProcHeadParam( sym )
		while( param )
			s += symbDump( param )
			param = param->next
			if( param ) then
				s += ", "
			end if
		wend
		s += ")"
#endif

	case FB_SYMBCLASS_PARAM
		select case( symbGetParamMode( sym ) )
		case FB_PARAMMODE_BYVAL  : s += "byval "
		case FB_PARAMMODE_BYREF  : s += "byref "
		case FB_PARAMMODE_BYDESC : s += "bydesc "
		case FB_PARAMMODE_VARARG : s += "vararg "
		end select

		hDumpName( s, sym )

		if( sym->param.mode = FB_PARAMMODE_BYDESC ) then
			s += hDumpDynamicArrayDimensions( sym->param.bydescdimensions )
		end if

	case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
		hDumpName( s, sym )

		'' Array dimensions, if any
		if( symbGetIsDynamic( sym ) ) then
			s += hDumpDynamicArrayDimensions( symbGetArrayDimensions( sym ) )
		elseif( symbGetArrayDimensions( sym ) > 0 ) then
			s += "("
			for i as integer = 0 to symbGetArrayDimensions( sym ) - 1
				if( i > 0 ) then
					s += ", "
				end if
				s &= symbArrayLbound( sym, i )
				s += " to "
				if( symbArrayUbound( sym, i ) = FB_ARRAYDIM_UNKNOWN ) then
					s += "..."
				else
					s &= symbArrayUbound( sym, i )
				end if
			next
			s += ")"
		end if

	case else
		hDumpName( s, sym )
	end select

	s += " "

	if( sym->typ and FB_DATATYPE_INVALID ) then
		if( sym->class = FB_SYMBCLASS_KEYWORD ) then
			s += "<keyword>"
		else
			s += "<invalid>"
		end if
	else
		'' UDTs themselves are FB_DATATYPE_STRUCT, but with NULL subtype,
		'' so treat that as special case, so symbTypeToStr() doesn't crash.
		if( sym->subtype = NULL ) then
			select case as const( sym->typ )
			case FB_DATATYPE_FWDREF
				s += "<fwdref>"
			case FB_DATATYPE_STRUCT
				if( symbIsStruct( sym ) ) then
					if( symbGetUDTIsUnion( sym ) ) then
						s += "<union>"
					else
						s += "<struct>"
					end if
				else
					s += "<struct>"
				end if
			case FB_DATATYPE_ENUM
				s += "<enum>"
			case else
				s += typeDump( sym->typ, NULL )
			end select
		else
			s += typeDump( sym->typ, sym->subtype )
		end if
	end if

	if( symbIsField( sym ) ) then
		if( sym->var_.bits > 0 ) then
			s += " bitfield : " & sym->var_.bits & " (" & sym->var_.bitpos & ".." & sym->var_.bitpos + sym->var_.bits - 1 & ")"
		end if

		s += " offset=" & sym->ofs
	end if

	function = s
end function

sub symbDumpNamespace( byval ns as FBSYMBOL ptr )
	select case( ns->class )
	case FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_ENUM, FB_SYMBCLASS_NAMESPACE

	case else
		print "symbDumpNamespace(): not a namespace"
	end select

	print symbDump( ns ) + ":"

	var i = symbGetCompSymbTb( ns ).head
	while( i )
		print "    symtb: " + symbDump( i )
		i = i->next
	wend

	'' For each bucket in the hashtb...
	var hash = @symbGetCompHashTb( ns ).tb
	for index as integer = 0 to hash->nodes-1
		'' For each item in this bucket...
		'' (can have multiple items in case of hash collisions)
		var hashitem = hash->list[index].head
		while( hashitem )
			'' The user data stored in the hashtb entry is the "head" symbol.
			'' It can link to more symbols through its FBSYMBOL.hash.next field.
			'' symbNewSymbol() prepends new symbols to that list, so they shadow the previous ones.
			''   1st/head symbol = the one from the current scope
			''   other symbols   = shadowed symbols from parent scopes
			dim as FBSYMBOL ptr sym = hashitem->data
			var bucketprefix = "    hashtb[" & index & "]: "
			print bucketprefix + *hashitem->name + " = " + symbDump( sym )
			while( sym->hash.next )
				sym = sym->hash.next
				print space(len(bucketprefix)) + "next: " + symbDump( sym )
			wend
			hashitem = hashitem->next
		wend
	next
end sub

sub symbDumpChain( byval chain_ as FBSYMCHAIN ptr )
	print "symchain [" + hex( chain_ ) + "]:"
	if( chain_ ) then
		'' Also printing the "index" in the chain, so we can differentiate between
		'' symbols from the same FBSYMCHAIN node (linked by their FBSYMBOL.hash.next fields),
		'' and symbols in different FBSYMCHAIN nodes (linked via symbChainGetNext()).
		var i = 0
		do
			var sym = chain_->sym
			do
				print "   " & i & "  " + symbDump( sym )
				sym = sym->hash.next
			loop while( sym )
			i += 1
			chain_ = symbChainGetNext( chain_ )
		loop while( chain_ )
	end if
end sub
#endif

dim shared as zstring ptr classnamesPretty(FB_SYMBCLASS_VAR to FB_SYMBCLASS_NSIMPORT) = _
{ _
	@"variable", _
	@"constant", _
	@"procedure", _
	@"parameter", _
	@"#define", _
	@"keyword", _
	@"label", _
	@"namespace", _
	@"enum", _
	@"type", _
	@"class", _
	@"field", _
	@"type alias", _
	@"forward reference", _
	@"scope", _
	@"namespace import" _
}

function symbDumpPretty( byval sym as FBSYMBOL ptr ) as string
	function = *classnamesPretty(sym->class) + " " + *sym->id.name
end function
