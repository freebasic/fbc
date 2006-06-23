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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\pool.bi"

declare sub			symbDelGlobalTb 	( )

declare sub 		symbInitKeywords	( )

declare sub 		symbInitDefines		( _
											byval ismain as integer _
										)

declare sub 		symbInitLibs		( )

declare sub 		symbInitFwdRef		( )

declare sub 		symbVarInit			( )

declare sub 		symbVarEnd			( )

declare sub 		symbAddToFwdRef		( _
											byval f as FBSYMBOL ptr, _
					 					  	byval ref as FBSYMBOL ptr _
					 					)

declare sub 		symbMangleInit		( )

declare sub 		symbMangleEnd		( )


''globals
	dim shared symb as SYMBCTX


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' init/end
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbHashTbInit _
	( _
		byval hashtb as FBHASHTB ptr, _
		byval owner as FBSYMBOL ptr, _
		byval nodes as integer _
	) as integer

	hashtb->owner = owner
	hashtb->prev = NULL
	hashtb->next = NULL
	hashNew( @hashtb->tb, nodes )

	function = TRUE

end function

'':::::
function symbSymTbInit _
	( _
		byval symtb as FBSYMBOLTB ptr, _
		byval owner as FBSYMBOL ptr _
	) as integer

	symtb->owner = owner
	symtb->head = NULL
	symtb->tail = NULL

	function = TRUE

end function

'':::::
sub symbInitSymbols static

	'' common symbols list
	listNew( @symb.symlist, FB_INITSYMBOLNODES, len( FBSYMBOL ), LIST_FLAGS_NOCLEAR )

	'' common chain list
	listNew( @symb.chainlist, FB_INITSYMBOLNODES, len( FBSYMCHAIN ), LIST_FLAGS_NOCLEAR )

    ''
    poolNew( @symb.namepool, FB_INITSYMBOLNODES \ 8, FB_MAXNAMELEN\8+1, FB_MAXNAMELEN+1 )

	'' global namespace - not complete, just a mock symbol
    with symb.globnspc.nspc
        symbSymTbInit( @.symtb, NULL )
		symbHashTbInit( @.hashtb, @symb.globnspc, FB_INITSYMBOLNODES )
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

	''

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
	symbMangleInit( )

	'' keywords
	symbInitKeywords( )

	'' defines
	symbInitDefines( ismain )

	'' forward refs
	symbInitFwdRef( )

	'' libraries
	symbInitLibs( )

	'' arrays dim tb
	symbVarInit( )

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
	hashFree( @symb.libhash )

    hashFree( @symb.globnspc.nspc.hashtb.tb )

	''
	listFree( @symb.liblist )

	symbVarEnd( )

	listFree( @symb.fwdlist )

	listFree( @symb.deftoklist )

	listFree( @symb.defparamlist )

	symbMangleEnd( )

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
	) as integer

	select case as const s->class
	'' adding a define, keyword or namespace? no dups can exist
	case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD, FB_SYMBCLASS_NAMESPACE
		return FALSE

	'' adding a type field? anything is allowed (udt elms are not added to a hash tb)
	case FB_SYMBCLASS_UDTELM, FB_SYMBCLASS_PARAM

	'' adding a label? anything but a define, keyword or another label is allowed
	case FB_SYMBCLASS_LABEL

		function = FALSE

		do
			select case as const chain_->sym->class
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD, FB_SYMBCLASS_NAMESPACE, _
				 FB_SYMBCLASS_LABEL
				exit function
			end select

			chain_ = chain_->next
		loop while( chain_ <> NULL )

	'' adding a forward ref? anything but a define or another forward ref is allowed
	case FB_SYMBCLASS_FWDREF

		function = FALSE

		do
			select case chain_->sym->class
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_NAMESPACE, FB_SYMBCLASS_FWDREF
				exit function
			end select

			chain_ = chain_->next
		loop while( chain_ <> NULL )

	'' adding an udt, enum or typedef? anything but a define or
	'' themselves is allowed
	case FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, FB_SYMBCLASS_TYPEDEF

		function = FALSE

		do
			select case as const chain_->sym->class
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_NAMESPACE, _
				 FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, FB_SYMBCLASS_TYPEDEF
				exit function
			end select

			chain_ = chain_->next
		loop while( chain_ <> NULL )

	'' adding a constant or proc? only dup allowed are labels, udts or enums
	case FB_SYMBCLASS_CONST, FB_SYMBCLASS_PROC

		function = FALSE

		do
			select case as const chain_->sym->class
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			case else
				exit function
			end select

			chain_ = chain_->next
		loop while( chain_ <> NULL )

	'' adding a variable? labels, udts or enums are allowed as dups AND
	'' other vars if they have different suffixes -- if any with suffix
	'' exists, a suffix-less will not be accepted (and vice-versa)
	case FB_SYMBCLASS_VAR

		function = FALSE

		dim as FBSYMBOL ptr sym
		do
			sym = chain_->sym
			select case as const sym->class
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			case FB_SYMBCLASS_VAR
				'' same scope?
				if( s->scope = sym->scope ) then
					if( (s->var.suffix = INVALID) or (sym->var.suffix = INVALID) ) then
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

	end select

	''
	function = TRUE

end function

'':::::
function symbNewSymbol _
	( _
		byval s as FBSYMBOL ptr, _
		byval symtb as FBSYMBOLTB ptr, _
		byval hashtb as FBHASHTB ptr, _
		byval isglobal as integer, _
		byval class as FB_SYMBCLASS, _
		byval dohash as integer, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval preservecase as integer, _
		byval suffix as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMCHAIN ptr chain_, chain_head
    dim as integer slen, delok

    function = NULL

	if( symtb = NULL ) then
    	'' parsing main and not inside a namespace? add to global tb
    	if( fbIsModLevel( ) and symbIsGlobalNamespc( ) ) then
    		'' unless it's inside a scope block..
    		if( env.scope > FB_MAINSCOPE ) then
    			symtb = symb.symtb
    			isglobal = FALSE

    		else
    			symtb = @symbGetGlobalTb( )
    			isglobal = TRUE
    		end if

    	else
    		symtb = symb.symtb
    		isglobal = FALSE
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
    s->class = class
	s->attrib = iif( isglobal, 0, FB_SYMBATTRIB_LOCAL )
	s->stats = 0
	symbSetMangling( s, env.mangling )

    s->typ = dtype
    s->subtype = subtype
    s->ptrcnt = ptrcnt
    s->scope = env.scope

    '' name
    slen = iif( id <> NULL, len( *id ), 0 )
    if( slen > 0 ) then
    	s->name = poolNewItem( @symb.namepool, slen + 1 ) 'ZstrAllocate( slen )
    	if( preservecase = FALSE ) then
    		hUcase( id, s->name )
    	else
    	    *s->name = *id
		end if
    else
    	s->name = NULL
    	dohash = FALSE
    end if

    '' alias
    if( id_alias <> NULL ) then
    	s->alias = ZstrAllocate( len( *id_alias ) )
    	*s->alias = *id_alias
    else
    	s->alias = NULL
    end if

    ''
    s->lgt = 0
    s->ofs = 0

    if( class = FB_SYMBCLASS_VAR ) then
    	'' needed by symbCanDup()
    	s->var.suffix = suffix
    end if

	'' add to hash table
	if( dohash ) then
		chain_ = listNewNode( @symb.chainlist )
		chain_->index = hashHash( s->name )

		'' doesn't exist yet?
		chain_head = hashLookupEx( @hashtb->tb, s->name, chain_->index )
		if( chain_head = NULL ) then
			'' add to hash table
            chain_->sym = s
			chain_->item = hashAdd( @hashtb->tb, s->name, chain_, chain_->index )
            chain_->prev = NULL
            chain_->next = NULL

		else
			'' can be duplicated?
			if( symbCanDuplicate( chain_head, s ) = FALSE ) then
				listDelNode( @symb.chainlist, chain_ )
				poolDelItem( @symb.namepool, s->name ) 'ZstrFree( s->name )
				ZstrFree( s->alias )
				if( delok ) then
					listDelNode( @symb.symlist, s )
				end if
				exit function
			end if

            chain_->sym = s
			chain_->item = chain_head->item

			'' module-level scope?
			if( isglobal ) then
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
				chain_head->item->name = s->name
			    chain_head->prev = chain_
			    chain_->prev = NULL
			    chain_->next = chain_head

			end if
		end if

		s->hash.chain = chain_

	else
		s->hash.chain = NULL
	end if

	s->hash.tb = hashtb

	'' add to symbol table
	if( symtb->tail <> NULL ) then
		symtb->tail->next = s
	else
		symtb->head = s
	end if

	s->prev = symtb->tail
	s->next = NULL

	symtb->tail = s

	s->symtb = symtb

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
		byref class as integer, _
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
	class = FB_TKCLASS_IDENTIFIER

	if( chain_ <> NULL ) then
		'' if it's a keyword, return id and class
		if( chain_->sym->class = FB_SYMBCLASS_KEYWORD ) then
			id = chain_->sym->key.id
			class = chain_->sym->key.class
		end if
	end if

	function = chain_

end function

'':::::
function symbLookupAt _
	( _
		byval ns as FBSYMBOL ptr, _
		byval symbol as zstring ptr, _
		byval preservecase as integer _
	) as FBSYMCHAIN ptr static

    static as zstring * FB_MAXNAMELEN+1 sname
    dim as uinteger index

    if( preservecase = FALSE ) then
    	hUcase( *symbol, sname )
    	symbol = @sname
    end if

    index = hashHash( symbol )

    function = hashLookupEx( @ns->nspc.hashtb.tb, symbol, index )

end function

'':::::
function symbLookupByNameAndClass _
	( _
		byval ns as FBSYMBOL ptr, _
		byval symbol as zstring ptr, _
	  	byval class as integer, _
	  	byval preservecase as integer _
	) as FBSYMBOL ptr static

	dim as FBSYMCHAIN ptr chain_

    chain_ = symbLookupAt( ns, symbol, preservecase )

    '' any found?
    if( chain_ <> NULL ) then
    	'' check if classes match
    	function = symbFindByClass( chain_, class )
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
    		deftyp = hGetDefType( symbol )
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
		byval class as integer _
	) as FBSYMBOL ptr static

    '' lookup a symbol with the same class
    do while( chain_ <> NULL )
    	if( chain_->sym->class = class ) then
			exit do
		end if
    	chain_ = chain_->next
    loop

	if( chain_ = NULL ) then
		return NULL
	end if

	'' check if symbol isn't a non-shared module level one
	if( class = FB_SYMBCLASS_VAR ) then
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
'' helpers
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCalcLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval unpadlen as integer _
	) as integer static

    dim e as FBSYMBOL ptr

	function = 0

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

	case FB_DATATYPE_USERDEF
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
		end if
	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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
       		chain_->item->name = nxt->sym->name
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
sub symbFreeSymbol _
	( _
		byval s as FBSYMBOL ptr _
	) static

    dim as FBSYMBOLTB ptr tb
    dim as FBSYMBOL ptr prv, nxt

	'' revove from hash tb
	symbDelFromHash( s )

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

    '' remove from symbol tb
    s->prev = NULL
    s->next = NULL
    poolDelItem( @symb.namepool, s->name ) 'ZstrFree( s->name )
    ZstrFree( s->alias )

    listDelNode( @symb.symlist, s )

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

    case FB_SYMBCLASS_UDT
    	symbDelUDT( s )

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
    			 FB_SYMBCLASS_UDT, _
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
    case FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM
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
	case FB_DATATYPE_FWDREF, FB_DATATYPE_USERDEF, FB_DATATYPE_ENUM
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
