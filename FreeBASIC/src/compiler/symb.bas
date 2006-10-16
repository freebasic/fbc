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


'' symbol table core module
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\pool.bi"

declare sub			symbDelGlobalTb 	( )

declare sub 		symbKeywordInit		( )

declare sub 		symbDefineInit		( _
											byval ismain as integer _
										)

declare sub 		symbDefineEnd		( )

declare sub 		symbLibInit			( )

declare sub 		symbLibEnd			( )

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

''globals
	dim shared as SYMBCTX symb

	dim shared as integer deftypeTB( 0 to (asc("_" ) - asc( "A" ) + 1) - 1 )

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' init/end
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbInitSymbols static

	'' common symbols list
	listNew( @symb.symlist, FB_INITSYMBOLNODES, len( FBSYMBOL ), LIST_FLAGS_NOCLEAR )

	'' common chain list
	listNew( @symb.chainlist, FB_INITSYMBOLNODES, len( FBSYMCHAIN ), LIST_FLAGS_NOCLEAR )

    ''
    poolNew( @symb.namepool, FB_INITSYMBOLNODES \ 8, FB_MAXNAMELEN\8+1, FB_MAXNAMELEN+1 )

	'' global namespace - not complete, just a mock symbol
    symb.globnspc.class = FB_SYMBCLASS_NAMESPACE
    symb.globnspc.scope = FB_MAINSCOPE

    with symb.globnspc.nspc
        symbSymbTbInit( .symtb, @symb.globnspc )
		symbHashTbInit( .hashtb, @symb.globnspc, FB_INITSYMBOLNODES )
    	.implist.head = NULL
    	.implist.tail = NULL
    end with

	''
	symb.namespc = @symb.globnspc
	symb.symtb = @symb.globnspc.nspc.symtb
	symb.hashtb = @symb.globnspc.nspc.hashtb

	''
	symb.hashlist.head = NULL
	symb.hashlist.tail = NULL

	symbHashListAdd( symb.hashtb )

	''
	symb.lastlbl = NULL

	symbDataInit( )

end sub

'':::::
private sub hInitDefTypeTb
    dim as integer dtype, i

	if( env.clopt.lang = FB_LANG_QB ) then
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

	''
	hashInit( )

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

	'' libraries
	symbLibInit( )

	'' arrays dim tb
	symbVarInit( )

	''
	symbProcInit( )

	''
	hInitDefTypeTb( )

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
	symbDataEnd( )

    ''
    hashFree( @symb.globnspc.nspc.hashtb.tb )

	''
	symbProcEnd( )

	symbVarEnd( )

	symbLibEnd( )

	symbFwdRefEnd( )

	symbDefineEnd( )

	symbMangleEnd( )

	symbCompEnd( )

	''
	poolFree( @symb.namepool )

	listFree( @symb.chainlist )

	listFree( @symb.symlist )

	hashEnd( )

	''
	symb.inited = FALSE

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCanDuplicate _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval s as FBSYMBOL ptr _
	) as integer static

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
			select case as const chain_->sym->class
			'' anything but a define or themselves is allowed (keywords
			'' (but quirk-keywords) are refused when parsing)
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_NAMESPACE, _
				 FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_CLASS, _
				 FB_SYMBCLASS_FIELD

				exit function
			end select

			chain_ = chain_->next
		loop while( chain_ <> NULL )

	'' forward ref?
	case FB_SYMBCLASS_FWDREF

		do
			select case chain_->sym->class
			'' anything but a define or another forward ref is allowed (keywords
			'' (but quirk-keywords) are refused when parsing)
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_NAMESPACE, _
				 FB_SYMBCLASS_FWDREF, FB_SYMBCLASS_CLASS

				exit function

			'' struct? only it's not unique
			case FB_SYMBCLASS_STRUCT
				if( symbGetHasMethod( chain_->sym ) ) then
					exit function
				end if
			end select

			chain_ = chain_->next
		loop while( chain_ <> NULL )

	'' constant or proc?
	case FB_SYMBCLASS_CONST, FB_SYMBCLASS_PROC

		do
			select case as const chain_->sym->class
			'' only dup allowed are labels and UDTs
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			'' struct? only it's not unique
			case FB_SYMBCLASS_STRUCT
				if( symbGetHasMethod( chain_->sym ) ) then
					exit function
				end if

			case else
				exit function
			end select

			chain_ = chain_->next
		loop while( chain_ <> NULL )

	'' variable?
	case FB_SYMBCLASS_VAR

		dim as FBSYMBOL ptr sym
		do
			sym = chain_->sym
			select case as const sym->class
			'' allow labels or UDTs as dups
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			'' struct? only it's not unique
			case FB_SYMBCLASS_STRUCT
				if( symbGetHasMethod( chain_->sym ) ) then
					exit function
				end if

			'' allow fields dups, if in a different scope
			case FB_SYMBCLASS_FIELD
				'' same scope?
				if( s->scope = sym->scope ) then
	    			exit function
    			end if

			'' and other vars if they have different suffixes -- if any
			'' with suffix exist, a suffix-less will not be accepted (and vice-versa)
			case FB_SYMBCLASS_VAR
				'' same scope?
				if( s->scope = sym->scope ) then
					if( (s->var.suffix = INVALID) or _
						(sym->var.suffix = INVALID) ) then
	    				exit function
					end if

    				'' same suffix?
    				if( sym->var.suffix = s->var.suffix ) then
    					exit function
    				end if
    			end if

			case else
				exit function
			end select

			chain_ = chain_->next
		loop while( chain_ <> NULL )

	'' label?
	case FB_SYMBCLASS_LABEL

		do
			select case as const chain_->sym->class
			'' anything but a define, keyword or another label is allowed
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_NAMESPACE, _
				 FB_SYMBCLASS_KEYWORD, FB_SYMBCLASS_LABEL, _
				 FB_SYMBCLASS_CLASS

				exit function

			'' struct? only it's not unique
			case FB_SYMBCLASS_STRUCT
				if( symbGetHasMethod( chain_->sym ) ) then
					exit function
				end if
			end select

			chain_ = chain_->next
		loop while( chain_ <> NULL )

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
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval attrib as FB_SYMBATTRIB, _
		byval suffix as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMCHAIN ptr chain_, chain_head
    dim as integer slen, delok

    function = NULL

	if( symtb = NULL ) then
		symtb = symb.symtb
		attrib or= FB_SYMBATTRIB_LOCAL

		'' parsing main?
		if( fbIsModLevel( )  ) then
			'' not inside a namespace?
			if( symbIsGlobalNamespc( ) ) then
				'' add to global tb, unless it's inside a scope block..
				if( parser.scope = FB_MAINSCOPE ) then
					'' symb.symbtb is pointing to main's symtb (due the
					'' implicit main function), so it can't be used
					symtb = @symbGetGlobalTb( )
					attrib and= not FB_SYMBATTRIB_LOCAL
				end if
			end if
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
    	if( s = NULL ) then
    		exit function
    	end if
    end if

    ''
    s->class = class_
	s->attrib = attrib
	s->stats = 0
	s->mangling = parser.mangling

    s->typ = dtype
    s->subtype = subtype
    s->ptrcnt = ptrcnt
    s->scope = parser.scope

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

    if( class_ = FB_SYMBCLASS_VAR ) then
    	'' needed by symbCanDup()
    	s->var.suffix = suffix
    end if

	'' add to hash table
	s->hash.tb = hashtb

	if( (options and FB_SYMBOPT_DOHASH) <> 0 ) then
		chain_ = listNewNode( @symb.chainlist )
		chain_->index = hashHash( s->id.name )

		'' doesn't exist yet?
		chain_head = hashLookupEx( @hashtb->tb, s->id.name, chain_->index )
		if( chain_head = NULL ) then
			'' add to hash table
            chain_->sym = s
			chain_->item = hashAdd( @hashtb->tb, s->id.name, chain_, chain_->index )
            chain_->prev = NULL
            chain_->next = NULL

		else
			'' can be duplicated?
			if( symbCanDuplicate( chain_head, s ) = FALSE ) then
				listDelNode( @symb.chainlist, chain_ )
				poolDelItem( @symb.namepool, s->id.name ) 'ZstrFree( s->id.name )
				ZstrFree( s->id.alias )
				ZstrFree( s->id.mangled )
				if( delok ) then
					listDelNode( @symb.symlist, s )
				end if
				exit function
			end if

            chain_->sym = s
			chain_->item = chain_head->item

			'' module-level scope?
			if( (attrib and FB_SYMBATTRIB_LOCAL) = 0 ) then
				'' add to tail
				do while( chain_head->next <> NULL )
					chain_head = chain_head->next
				loop

				chain_head->next = chain_
				chain_->prev = chain_head
				chain_->next = NULL

			else
				'' add to head
				chain_head->item->data = chain_
				chain_head->item->name = s->id.name
			    chain_head->prev = chain_
			    chain_->prev = NULL
			    chain_->next = chain_head

			end if
		end if

		s->hash.chain = chain_

	else
		s->hash.chain = NULL
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

	'' forward type? add to the back-patch list..
	dtype -= ptrcnt * FB_DATATYPE_POINTER
	if( dtype = FB_DATATYPE_FWDREF ) then
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
		byval hashtb as FBHASHTB ptr, _
		byval checkdup as integer _
	) static

	dim as FBHASHTB ptr n

	if( checkdup ) then
    	n = symb.hashlist.head
    	do
    		if( n = hashtb ) then
    			exit sub
    		end if
    		n = n->next
    	loop while( n <> NULL )
	end if

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
	) static

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

end sub

'':::::
function symbLookup _
	( _
		byval symbol as zstring ptr, _
		byref id as integer, _
		byref class_ as integer, _
		byval preservecase as integer _
	) as FBSYMCHAIN ptr static

    static as zstring * FB_MAXNAMELEN+1 sname
    dim as FBSYMCHAIN ptr chain_
    dim as uinteger index
    dim as FBHASHTB ptr hashtb

    if( preservecase = FALSE ) then
    	hUcase( *symbol, sname )
    	symbol = @sname
    end if

    index = hashHash( symbol )

    '' for each hash tb, starting from last
    hashtb = symb.hashlist.tail
    do
    	chain_ = hashLookupEx( @hashtb->tb, symbol, index )
        if( chain_ <> NULL ) then
        	exit do
        end if
    	hashtb = hashtb->prev
    loop while( hashtb <> NULL )

	'' assume it's an unknown identifier
	id = FB_TK_ID
	class_ = FB_TKCLASS_IDENTIFIER

	if( chain_ <> NULL ) then
		'' if it's a keyword, return id and class
		if( chain_->sym->class = FB_SYMBCLASS_KEYWORD ) then
			id = chain_->sym->key.id
			class_ = chain_->sym->key.tkclass
		end if
	end if

	function = chain_

end function

'':::::
function symbLookupAtTb _
	( _
		byval hashtb as FBHASHTB ptr, _
		byval symbol as zstring ptr, _
		byval preservecase as integer _
	) as FBSYMCHAIN ptr static

    static as zstring * FB_MAXNAMELEN+1 sname

    if( preservecase = FALSE ) then
    	hUcase( *symbol, sname )
    	symbol = @sname
    end if

    function = hashLookupEx( @hashtb->tb, symbol, hashHash( symbol ) )

end function

'':::::
function symbLookupByNameAndClass _
	( _
		byval ns as FBSYMBOL ptr, _
		byval symbol as zstring ptr, _
	  	byval class_ as integer, _
	  	byval preservecase as integer _
	) as FBSYMBOL ptr static

	dim as FBSYMCHAIN ptr chain_

    chain_ = symbLookupAt( ns, symbol, preservecase )

    '' any found?
    if( chain_ <> NULL ) then
    	'' check if classes match
    	function = symbFindByClass( chain_, class_ )
    else
    	function = NULL
    end if

end function

'':::::
function symbLookupByNameAndSuffix _
	( _
		byval ns as FBSYMBOL ptr, _
		byval symbol as zstring ptr, _
		byval suffix as integer, _
		byval preservecase as integer _
	) as FBSYMBOL ptr static

	dim as FBSYMCHAIN ptr chain_
	dim as integer deftyp

	chain_ = symbLookupAt( ns, symbol, preservecase )

    '' any found?
    if( chain_ <> NULL ) then
    	'' get default type if no suffix was given
    	if( suffix = INVALID ) then
    		deftyp = symbGetDefType( symbol )
    	end if

		'' check if types match
		function = symbFindBySuffix( chain_, suffix, deftyp )
	else
		function = NULL
	end if

end function

'':::::
function symbFindByClass _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval class_ as integer _
	) as FBSYMBOL ptr static

    '' lookup a symbol with the same class
    do while( chain_ <> NULL )
    	if( chain_->sym->class = class_ ) then
			exit do
		end if
    	chain_ = chain_->next
    loop

	if( chain_ = NULL ) then
		return NULL
	end if

	'' check if symbol isn't a non-shared module level one
	if( class_ = FB_SYMBCLASS_VAR ) then
		'' inside a proc? (but main())
		if( fbIsModLevel( ) = FALSE ) then
			'' local?
			if( symbIsLocal( chain_->sym ) ) then
				'' not a main()'s local?
				if( chain_->sym->scope = FB_MAINSCOPE ) then
					return NULL
			    end if
			'' not shared?
			elseif( symbIsShared( chain_->sym ) = FALSE ) then
				return NULL
			end if
		end if
	end if

	function = chain_->sym

end function

'':::::
function symbFindBySuffix _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval suffix as integer, _
		byval deftyp as integer _
	) as FBSYMBOL ptr static

    '' symbol has a suffix? lookup a symbol with the same type, suffixed or not
    if( suffix <> INVALID ) then

    	'' QB quirk: fixed-len and zstrings referenced using '$' as suffix..
    	if( suffix = FB_DATATYPE_STRING ) then
    		do while( chain_ <> NULL )
    			if( chain_->sym->class = FB_SYMBCLASS_VAR ) then
     				select case chain_->sym->typ
     				case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
     					 FB_DATATYPE_CHAR
     					exit do
     				end select
     			end if

    			chain_ = chain_->next
    		loop

    	'' anything but strings..
    	else
    		do while( chain_ <> NULL )
    			if( chain_->sym->class = FB_SYMBCLASS_VAR ) then
     				if( chain_->sym->typ = suffix ) then
     					exit do
     				end if
     			end if

    			chain_ = chain_->next
    		loop
    	end if

    '' symbol has no suffix: lookup a symbol w/o suffix or with the
    '' same type as default type (last DEF###)
    else

    	'' QB quirk: see above
    	if( deftyp = FB_DATATYPE_STRING ) then
    		do while( chain_ <> NULL )
    			if( chain_->sym->class = FB_SYMBCLASS_VAR ) then
     				if( chain_->sym->var.suffix = INVALID ) then
     					exit do
     				end if
     				select case chain_->sym->typ
     				case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
     					 FB_DATATYPE_CHAR
     					exit do
     				end select
     			end if

    			chain_ = chain_->next
    		loop

    	'' anything but strings..
    	else
    		do while( chain_ <> NULL )
    			if( chain_->sym->class = FB_SYMBCLASS_VAR ) then
     				if( chain_->sym->var.suffix = INVALID ) then
     					exit do
     				elseif( chain_->sym->typ = deftyp ) then
     					exit do
     				end if
     			end if

    			chain_ = chain_->next
    		loop
    	end if
    end if

	if( chain_ = NULL ) then
		return NULL
	end if

	'' check if symbol isn't a non-shared module level one
	if( fbIsModLevel( ) = FALSE ) then
		'' local?
		if( symbIsLocal( chain_->sym ) ) then
			'' not a main()'s local?
			if( chain_->sym->scope = FB_MAINSCOPE ) then
				return NULL
		    end if
		'' not shared?
		elseif( symbIsShared( chain_->sym ) = FALSE ) then
			return NULL
		end if
	end if

	function = chain_->sym

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbDelFromChainList _
	( _
		byval hashtb as THASH ptr, _
		byval chain_ as FBSYMCHAIN ptr _
	) static

    dim as FBSYMCHAIN ptr prv, nxt

	'' note: symbols declared inside namespaces can't be
    '' removed by #undef or OPTION NOKEYWORD so the import
    '' chain doesn't have to be updated

    '' relink
    prv = chain_->prev
    nxt = chain_->next
    if( prv <> NULL ) then
    	prv->next = nxt
    end if
    if( nxt <> NULL ) then
    	nxt->prev = prv
    end if

    '' symbol was the head node?
    if( prv = NULL ) then
    	'' nothing left? remove from hash table
    	if( nxt = NULL ) then
    		hashDel( hashtb, chain_->item, chain_->index )

    	'' update list head
    	else
       		chain_->item->data = nxt
       		chain_->item->name = nxt->sym->id.name
    	end if
    end if

    '' delete node
    listDelNode( @symb.chainlist, chain_ )

end sub

'':::::
sub symbDelFromHash _
	( _
		byval s as FBSYMBOL ptr _
	) static

	if( s->hash.chain = NULL ) then
		exit sub
	end if

	symbDelFromChainList( @s->hash.tb->tb, s->hash.chain )

    s->hash.chain = NULL

end sub

'':::::
#macro doUnlink( s )

    scope
	    dim as FBSYMBOLTB ptr tb
    	dim as FBSYMBOL ptr prv, nxt

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
    end scope

#endmacro

'':::::
#macro doRemove( s )

    '' remove from symbol tb
    poolDelItem( @symb.namepool, s->id.name ) 'ZstrFree( s->id.name )

    ZstrFree( s->id.alias )
    ZstrFree( s->id.mangled )

    listDelNode( @symb.symlist, s )

#endmacro

'':::::
sub symbFreeSymbol _
	( _
		byval s as FBSYMBOL ptr _
	) static

	'' revove from hash tb
	symbDelFromHash( s )

	doUnlink( s )

    doRemove( s )

end sub

'':::::
sub symbFreeSymbol_RemOnly _
	( _
		byval s as FBSYMBOL ptr _
	) static

    doRemove( s )

end sub

'':::::
sub symbFreeSymbol_UnlinkOnly _
	( _
		byval s as FBSYMBOL ptr _
	) static

	doUnlink( s )

end sub

'':::::
sub symbDelSymbol _
	( _
		byval s as FBSYMBOL ptr _
	)

	select case as const s->class
    case FB_SYMBCLASS_VAR
    	symbDelVar( s )

    case FB_SYMBCLASS_CONST
		symbDelConst( s )

    case FB_SYMBCLASS_PROC
    	symbDelPrototype( s )

	case FB_SYMBCLASS_DEFINE
		symbDelDefine( s )

	case FB_SYMBCLASS_KEYWORD
		symbDelKeyword( s )

    case FB_SYMBCLASS_LABEL
    	symbDelLabel( s )

    case FB_SYMBCLASS_ENUM
		symbDelEnum( s )

    case FB_SYMBCLASS_STRUCT
    	symbDelStruct( s )

    case FB_SYMBCLASS_SCOPE
    	symbDelScope( s )

    case FB_SYMBCLASS_NAMESPACE
    	symbDelNamespace( s )

	case FB_SYMBCLASS_NSIMPORT
		symbNamespaceRemove( s, FALSE )

	case FB_SYMBCLASS_BITFIELD
        symbFreeSymbol( s )

	case else
		symbFreeSymbol( s )

    end select

end sub

'':::::
function symbCloneSymbol _
	( _
		byval s as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	'' assuming only non-complex symbols will be passed,
	'' for use by astTypeIniClone() mainly

	select case as const s->class
    case FB_SYMBCLASS_VAR
    	function = symbCloneVar( s )

    case FB_SYMBCLASS_CONST
		function = symbCloneConst( s )

    case FB_SYMBCLASS_LABEL
    	function = symbCloneLabel( s )

    case FB_SYMBCLASS_STRUCT
    	function = symbCloneStruct( s )

    case else
    	errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
    	function = NULL
    end select

end function

'':::::
sub symbDelGlobalTb( ) static
    dim as FBSYMBOL ptr s

    do
    	s = symbGetGlobalTb( ).head
    	if( s = NULL ) then
    		exit do
    	end if

    	symbDelSymbol( s )
    loop

end sub

'':::::
sub symbDelSymbolTb _
	( _
		byval tb as FBSYMBOLTB ptr, _
		byval hashonly as integer _
	) static

    dim as FBSYMBOL ptr s

    '' del from hash tb only?
    if( hashonly ) then

    	s = tb->head
    	do while( s <> NULL )

	    	select case as const s->class
    		case FB_SYMBCLASS_VAR, _
    			 FB_SYMBCLASS_CONST, _
    			 FB_SYMBCLASS_STRUCT, _
    			 FB_SYMBCLASS_ENUM, _
    			 FB_SYMBCLASS_TYPEDEF, _
    			 FB_SYMBCLASS_LABEL, _
    			 FB_SYMBCLASS_DEFINE

    			symbDelFromHash( s )

    		case FB_SYMBCLASS_NSIMPORT
    			symbNamespaceRemove( s, TRUE )

    		case FB_SYMBCLASS_SCOPE
    			'' already removed..
    			''''' symbDelScopeTb( s )
    		end select

    		s = s->next
    	loop

    '' del from hash and symbol tb's
    else
    	do
    	    s = tb->head
    		if( s = NULL ) then
    			exit do
    		end if

	    	symbDelSymbol( s )
    	loop

    end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbIsArray _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	select case sym->class
	case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD
		if( (sym->attrib and (FB_SYMBATTRIB_DYNAMIC or FB_SYMBATTRIB_PARAMBYDESC)) <> 0 ) then
			return TRUE
		else
			return sym->var.array.dims <> 0
		end if
	end select

	function = FALSE

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

'':::::
function symbIsEqual _
	( _
		byval sym1 as FBSYMBOL ptr, _
		byval sym2 as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr paraml, paramr

	function = FALSE

	'' same symbol?
	if( sym1 = sym2 ) then
		return TRUE
	end if

	'' any NULL?
	if( (sym1 = NULL) or (sym2 = NULL) ) then
		exit function
	end if

	'' different classes?
    if( sym1->class <> sym2->class ) then
    	exit function
    end if

	'' different types?
    if( sym1->typ <> sym2->typ ) then
    	exit function
    end if

    select case sym1->class
    '' UDT or enum?
    case FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_ENUM
    	'' no check, they are pointing to different symbols
    	exit function

    '' function? must check because a @foo will point to a different
    '' symbol than funptr, but both can have the same signature
    case FB_SYMBCLASS_PROC

    	'' check calling convention
    	if( symbGetProcMode( sym1 ) <> symbGetProcMode( sym2 ) ) then
    		exit function
    	end if

    	'' not the same number of args?
    	if( symbGetProcParams( sym1 ) <> symbGetProcParams( sym2 ) ) then

    		'' no args?
    		if( symbGetProcParams( sym1 ) = 0 ) then
    			exit function
    		end if

    		'' not vararg?
    		if( symbGetProcTailParam( sym1 )->param.mode <> FB_PARAMMODE_VARARG ) then
    			exit function
    		end if

    		'' not enough args?
    		if( (symbGetProcParams( sym2 ) - symbGetProcParams( sym1 )) < -1 ) then
    			exit function
    		end if
    	end if

    	'' check each param
    	paraml = symbGetProcHeadParam( sym1 )
    	paramr = symbGetProcHeadParam( sym2 )

    	do while( paraml <> NULL )
            '' vararg?
            if( paraml->param.mode = FB_PARAMMODE_VARARG ) then
            	exit do
            end if

    		'' mode?
    		if( paraml->param.mode <> paramr->param.mode ) then
            	exit function
    		end if

    		'' different types?
    		if( paraml->typ <> paramr->typ ) then
         		exit function
        	end if

        	'' sub-types?
        	if( paraml->subtype <> paramr->subtype ) then
            	exit function
			end if

    		'' next arg..
    		paraml = paraml->next
    		paramr = paramr->next
    	loop
    end select

	'' and sub type
	if( sym1->subtype <> sym2->subtype ) then
        function = symbIsEqual( sym1->subtype, sym2->subtype )
    else
    	function = TRUE
    end if

end function

'':::::
function symbTypeToStr _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as zstring ptr

	static as string res
	dim as integer dtype_np

	dtype_np = dtype mod FB_DATATYPE_POINTER

	select case as const dtype_np
	case FB_DATATYPE_FWDREF, FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
		res = *symbGetName( subtype )

	case else
		res = *symb_dtypeTB(dtype_np).name
	end select

	do while( dtype >= FB_DATATYPE_POINTER )
		res += " ptr"
		dtype -= FB_DATATYPE_POINTER
	loop

	function = strptr( res )

end function

'':::::
function symbGetDefType _
	( _
		byval symbol as zstring ptr _
	) as integer static

    dim as integer c

	c = symbol[0][0]

	'' to upper
	if( (c >= asc("a")) and (c <= asc("z")) ) then
		c -= (asc("a") - asc("A"))
	end if

	function = deftypeTB(c - asc("A"))

end function

'':::::
sub symbSetDefType _
	( _
		byval ichar as integer, _
		byval echar as integer, _
		byval dtype as integer _
	) static

    dim as integer i

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

'':::::
function symbCalcLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval unpadlen as integer _
	) as integer static

    dim e as FBSYMBOL ptr

	select case as const dtype
	case FB_DATATYPE_FWDREF
		function = 0

	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, FB_DATATYPE_CHAR
		function = 1

	case FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
		function = 2

	case FB_DATATYPE_WCHAR
		function = env.target.wchar.size

	case FB_DATATYPE_INTEGER, FB_DATATYPE_UINT, FB_DATATYPE_ENUM
		function = FB_INTEGERSIZE

	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = FB_INTEGERSIZE*2

	case FB_DATATYPE_SINGLE
		function = 4

	case FB_DATATYPE_DOUBLE
    	function = 8

	case FB_DATATYPE_FIXSTR
		function = 0									'' 0-len literal-strings

	case FB_DATATYPE_STRING
		function = FB_STRDESCLEN

	case FB_DATATYPE_STRUCT
		if( unpadlen ) then
			function = subtype->udt.unpadlgt
		else
			function = subtype->lgt
		end if

	case FB_DATATYPE_BITFIELD
		function = subtype->lgt

	case else
		if( dtype >= FB_DATATYPE_POINTER ) then
			function = FB_POINTERSIZE
		else
			function = 0
		end if
	end select

end function


