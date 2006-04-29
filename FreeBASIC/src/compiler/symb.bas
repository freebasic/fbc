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
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"

declare sub			symbDelGlobalTb 	( )

declare sub 		symbInitKeywords	( )

declare sub 		symbInitDefines		( byval ismain as integer )

declare sub 		symbInitLibs		( )

declare sub 		symbInitFwdRef		( )

declare sub 		symbInitDims		( )

declare sub 		symbAddToFwdRef		( byval f as FBSYMBOL ptr, _
					 					  byval ref as FBSYMBOL ptr )
''globals
	dim shared symb as SYMBCTX


''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' init/end
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbInitSymbols static

	'' globals/module-level
	listNew( @symb.symlist, FB_INITSYMBOLNODES, len( FBSYMBOL ), FALSE )

	hashNew( @symb.symhash, FB_INITSYMBOLNODES )

	symb.globtb.owner = NULL
	symb.globtb.head = NULL
	symb.globtb.tail = NULL

	symb.loctb = @symb.globtb

	symb.lastlbl = NULL

	symbDataInit( )

end sub

'':::::
sub symbInit( byval ismain as integer )

	''
	if( symb.inited ) then
		exit sub
	end if

	''
	hashInit( )

	'' vars, arrays, procs & consts
	symbInitSymbols( )

	''
	symbDataInit( )

	'' keywords
	symbInitKeywords( )

	'' defines
	symbInitDefines( ismain )

	'' forward refs
	symbInitFwdRef( )

	'' arrays dim tb
	symbInitDims( )

	'' libraries
	symbInitLibs( )

    ''
    symb.inited 	= TRUE

end sub

'':::::
sub symbEnd

    if( symb.inited = FALSE ) then
    	exit sub
    end if

	''
	symbDelGlobalTb( )

	symb.globtb.head = NULL
	symb.globtb.tail = NULL
	symb.loctb = NULL

	''
	symbDataEnd( )

    ''
	hashFree( @symb.libhash )

    hashFree( @symb.symhash )

	''
	listFree( @symb.liblist )

	listFree( @symb.dimlist )

	listFree( @symb.fwdlist )

	listFree( @symb.deftoklist )

	listFree( @symb.defparamlist )

	listFree( @symb.symlist )

	hashEnd( )

	''
	symb.inited = FALSE

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hCanDuplicate( byval n as FBSYMBOL ptr, _
								byval s as FBSYMBOL ptr _
							  ) as integer

	select case as const s->class
	'' adding a define or keyword? no dups can exist
	case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD
		return FALSE

	'' adding a type field? anything is allowed (udt elms are not added to a hash tb)
	case FB_SYMBCLASS_UDTELM, FB_SYMBCLASS_PARAM

	'' adding a label? anything but a define, keyword or another label is allowed
	case FB_SYMBCLASS_LABEL

		function = FALSE

		do
			select case n->class
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD, FB_SYMBCLASS_LABEL
				exit function
			end select

			n = n->right
		loop while( n <> NULL )

	'' adding a forward ref? anything but a define or another forward ref is allowed
	case FB_SYMBCLASS_FWDREF

		function = FALSE

		do
			select case n->class
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_FWDREF
				exit function
			end select

			n = n->right
		loop while( n <> NULL )

	'' adding an udt, enum or typedef? anything but a define or
	'' themselves is allowed
	case FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, FB_SYMBCLASS_TYPEDEF

		function = FALSE

		do
			select case as const n->class
			case FB_SYMBCLASS_DEFINE, _
				 FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, FB_SYMBCLASS_TYPEDEF
				exit function
			end select

			n = n->right
		loop while( n <> NULL )

	'' adding a constant or proc? only dup allowed are labels, udts or enums
	case FB_SYMBCLASS_CONST, FB_SYMBCLASS_PROC

		function = FALSE

		do
			select case as const n->class
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			case else
				exit function
			end select

			n = n->right
		loop while( n <> NULL )

	'' adding a variable? labels, udts or enums are allowed as dups AND
	'' other vars if they have different suffixes -- if any with suffix
	'' exists, a suffix-less will not be accepted (and vice-versa)
	case FB_SYMBCLASS_VAR

		function = FALSE

		do
			select case as const n->class
			case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, _
				 FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF

			case FB_SYMBCLASS_VAR
				if( s->scope = n->scope ) then
					if( (s->var.suffix = INVALID) or (n->var.suffix = INVALID) ) then
	    				exit function
					end if

    				'' same suffix?
    				if( n->var.suffix = s->var.suffix ) then
    					exit function
    				end if
    			end if

			case else
				exit function
			end select

			n = n->right
		loop while( n <> NULL )

	end select

	''
	function = TRUE

end function

'':::::
function symbNewSymbol( byval s as FBSYMBOL ptr, _
					 	byval symtb as FBSYMBOLTB ptr, _
					 	byval isglobal as integer, _
					 	byval class as FB_SYMBCLASS, _
					 	byval dohash as integer, _
					 	byval symbol as zstring ptr, _
					 	byval aliasname as zstring ptr, _
					 	byval typ as integer, _
					 	byval subtype as FBSYMBOL ptr, _
					 	byval ptrcnt as integer, _
					 	byval suffix as integer, _
					 	byval preservecase as integer _
					  ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr n
    dim as integer slen, delok

    function = NULL

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

    s->scope = env.scope
    s->typ = typ
    s->subtype = subtype
    s->ptrcnt = ptrcnt

	s->attrib = iif( isglobal, 0, FB_SYMBATTRIB_LOCAL )
    s->lgt = 0
    s->ofs = 0

	s->stats = 0

    if( class = FB_SYMBCLASS_VAR ) then
    	s->var.suffix = suffix
    end if

    ''
    s->name = NULL
    slen = len( *symbol )
    if( slen > 0 ) then
    	if( preservecase = FALSE ) then
    		s->name = ZstrAllocate( slen )
    		hUcase( symbol, s->name )
    	else
    	    ZstrAssign( @s->name, symbol )
		end if
    else
    	dohash = FALSE
    end if

    s->alias = NULL
    if( aliasname <> NULL ) then
    	ZstrAssign( @s->alias, aliasname )
    else
		if( class = FB_SYMBCLASS_PROC ) then
			ZstrAssign( @s->alias, s->name )
		end if
    end if

	s->left  = NULL
	s->right = NULL

	''
	if( dohash ) then

		'' doesn't exist yet?
		s->hashindex = hashHash( s->name )
		n = hashLookupEx( @symb.symhash, s->name, s->hashindex )
		if( n = NULL ) then
			'' add to hash table
			s->hashitem = hashAdd( @symb.symhash, s->name, s, s->hashindex )

		else
			'' can be duplicated?
			if( hCanDuplicate( n, s ) = FALSE ) then
				ZstrFree( s->name )
				ZstrFree( s->alias )
				if( delok ) then
					listDelNode( @symb.symlist, cast( TLISTNODE ptr, s ) )
				end if
				exit function
			end if

			s->hashitem = n->hashitem
			s->hashindex = n->hashindex

			'' module-level scope?
			if( isglobal ) then
				'' add to tail
				do while( n->right <> NULL )
					n = n->right
				loop

				n->right = s
				s->left = n

			else
				'' add to head
				n->hashitem->idx = s
				n->hashitem->name = s->name
			    n->left = s
			    s->right = n

			end if
		end if

	else
		s->hashitem = NULL
		s->hashindex = 0
	end if

	''
	typ -= ptrcnt * FB_DATATYPE_POINTER
	if( typ = FB_DATATYPE_FWDREF ) then
		symbAddToFwdRef( subtype, s )
	end if

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

    ''
    function = s

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookup
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbLookup( byval symbol as zstring ptr, _
					 byref id as integer, _
					 byref class as integer, _
					 byval preservecase as integer = FALSE _
				   ) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 sname
    dim as FBSYMBOL ptr s

    if( preservecase = FALSE ) then
    	hUcase( *symbol, sname )
    	s = hashLookup( @symb.symhash, @sname )
    else
    	s = hashLookup( @symb.symhash, symbol )
    end if

	'' assume it's an unknown identifier
	id 	  = FB_TK_ID
	class = FB_TKCLASS_IDENTIFIER

	if( s <> NULL ) then
		'' if it's a keyword, return id and class
		if( s->class = FB_SYMBCLASS_KEYWORD ) then
			id 	  = s->key.id
			class = s->key.class
		end if
	end if

	function = s

end function

'':::::
function symbFindByClass( byval s as FBSYMBOL ptr, _
						  byval class as integer _
						) as FBSYMBOL ptr static

    '' lookup a symbol with the same class
    do while( s <> NULL )
    	if( s->class = class ) then
			exit do
		end if
    	s = s->right
    loop

	if( s = NULL ) then
		return NULL
	end if

	'' check if symbol isn't a non-shared module level one
	if( class = FB_SYMBCLASS_VAR ) then
		'' inside a proc? (but main())
		if( fbIsModLevel( ) = FALSE ) then
			'' local?
			if( symbIsLocal( s ) ) then
				'' not a main()'s local?
				if( s->scope = FB_MAINSCOPE ) then
					return NULL
			    end if
			'' not shared?
			elseif( symbIsShared( s ) = FALSE ) then
				return NULL
			end if
		end if
	end if

	function = s

end function

'':::::
function symbFindBySuffix( byval s as FBSYMBOL ptr, _
						   byval suffix as integer, _
						   byval deftyp as integer _
						 ) as FBSYMBOL ptr static

    '' symbol has a suffix? lookup a symbol with the same type, suffixed or not
    if( suffix <> INVALID ) then

    	'' QB quirk: fixed-len and zstrings referenced using '$' as suffix..
    	if( suffix = FB_DATATYPE_STRING ) then
    		do while( s <> NULL )
    			if( s->class = FB_SYMBCLASS_VAR ) then
     				select case s->typ
     				case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
     					 FB_DATATYPE_CHAR
     					exit do
     				end select
     			end if

    			s = s->right
    		loop

    	'' anything but strings..
    	else
    		do while( s <> NULL )
    			if( s->class = FB_SYMBCLASS_VAR ) then
     				if( s->typ = suffix ) then
     					exit do
     				end if
     			end if

    			s = s->right
    		loop
    	end if

    '' symbol has no suffix: lookup a symbol w/o suffix or with the
    '' same type as default type (last DEF###)
    else

    	'' QB quirk: see above
    	if( deftyp = FB_DATATYPE_STRING ) then
    		do while( s <> NULL )
    			if( s->class = FB_SYMBCLASS_VAR ) then
     				if( s->var.suffix = INVALID ) then
     					exit do
     				end if
     				select case s->typ
     				case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
     					 FB_DATATYPE_CHAR
     					exit do
     				end select
     			end if

    			s = s->right
    		loop

    	'' anything but strings..
    	else
    		do while( s <> NULL )
    			if( s->class = FB_SYMBCLASS_VAR ) then
     				if( s->var.suffix = INVALID ) then
     					exit do
     				elseif( s->typ = deftyp ) then
     					exit do
     				end if
     			end if

    			s = s->right
    		loop
    	end if
    end if

	if( s = NULL ) then
		return NULL
	end if

	'' check if symbol isn't a non-shared module level one
	if( fbIsModLevel( ) = FALSE ) then
		'' local?
		if( symbIsLocal( s ) ) then
			'' not a main()'s local?
			if( s->scope = FB_MAINSCOPE ) then
				return NULL
		    end if
		'' not shared?
		elseif( symbIsShared( s ) = FALSE ) then
			return NULL
		end if
	end if

	function = s

end function

'':::::
function symbFindByNameAndClass ( byval symbol as zstring ptr, _
	  							  byval class as integer, _
	  							  byval preservecase as integer = FALSE _
								) as FBSYMBOL ptr static

	dim s as FBSYMBOL ptr
	dim tkid as integer, tkclass as integer

    s = symbLookup( symbol, tkid, tkclass, preservecase )

    '' any found?
    if( s <> NULL ) then
    	'' check if classes match
    	function = symbFindByClass( s, class )
    else
    	function = NULL
    end if

end function

'':::::
function symbFindByNameAndSuffix( byval symbol as zstring ptr, _
								  byval suffix as integer, _
								  byval preservecase as integer = FALSE _
								) as FBSYMBOL ptr static
	dim s as FBSYMBOL ptr
	dim deftyp as integer
	dim tkid as integer, tkclass as integer

	s = symbLookup( symbol, tkid, tkclass, preservecase )

    '' any found?
    if( s <> NULL ) then
    	'' get default type if no suffix was given
    	if( suffix = INVALID ) then
    		deftyp = hGetDefType( symbol )
    	end if

		'' check if types match
		function = symbFindBySuffix( s, suffix, deftyp )
	else
		function = NULL
	end if

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' helpers
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCalcLen( byval typ as integer, _
					  byval subtype as FBSYMBOL ptr, _
					  byval realsize as integer = FALSE _
					) as integer static

    dim e as FBSYMBOL ptr

	function = 0

	select case as const typ
	case FB_DATATYPE_FWDREF
		function = 0

	case FB_DATATYPE_BYTE, FB_DATATYPE_UBYTE, FB_DATATYPE_CHAR
		function = 1

	case FB_DATATYPE_SHORT, FB_DATATYPE_USHORT
		function = 2

	case FB_DATATYPE_WCHAR
		function = env.target.wchar.size

	case FB_DATATYPE_INTEGER, FB_DATATYPE_LONG, FB_DATATYPE_UINT, FB_DATATYPE_ENUM
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
		if( realsize = FALSE ) then
			function = subtype->lgt
		else
			function = subtype->udt.unpadlgt
		end if

	case FB_DATATYPE_BITFIELD
		function = subtype->lgt

	case else
		if( typ >= FB_DATATYPE_POINTER ) then
			function = FB_POINTERSIZE
		end if
	end select

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbDelFromHash( byval s as FBSYMBOL ptr ) static
    dim as FBSYMBOL ptr prv, nxt

	if( s->hashitem = NULL ) then
		exit sub
	end if

    '' relink
    prv = s->left
    nxt = s->right
    if( prv <> NULL ) then
    	prv->right = nxt
    end if
    if( nxt <> NULL ) then
    	nxt->left = prv
    end if

    '' symbol was the head node?
    if( prv = NULL ) then
    	'' nothing left? remove from hash table
    	if( nxt = NULL ) then
    		hashDel( @symb.symhash, s->hashitem, s->hashindex )

    	'' update list head
    	else
       		s->hashitem->idx  = nxt
       		s->hashitem->name = nxt->name
    	end if
    end if

    s->hashitem  = NULL
    s->hashindex = 0
    s->left 	 = NULL
    s->right 	 = NULL

end sub

'':::::
sub symbFreeSymbol( byval s as FBSYMBOL ptr, _
				 	byval movetoglob as integer ) static

    dim as FBSYMBOLTB ptr tb
    dim as FBSYMBOL ptr prv, nxt

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

    '' remove from symbol list
    if( movetoglob = FALSE ) then
    	s->prev  = NULL
    	s->next  = NULL
    	ZstrFree( s->name )
    	ZstrFree( s->alias )

    	listDelNode( @symb.symlist, cast( TLISTNODE ptr, s ) )

    '' move from local to global table
    else
		if( symb.globtb.tail <> NULL ) then
			symb.globtb.tail->next = s
		else
			symb.globtb.head = s
		end if

		s->prev = symb.globtb.tail
		s->next = NULL
		symb.globtb.tail = s
		s->symtb = @symb.globtb
    end if

end sub

'':::::
sub symbDelSymbol( byval s as FBSYMBOL ptr )

	select case as const s->class
    case FB_SYMBCLASS_VAR
    	symbDelVar( s, FALSE )

    case FB_SYMBCLASS_CONST
		symbDelConst( s, FALSE )

    case FB_SYMBCLASS_PROC
    	symbDelPrototype( s, FALSE )

	case FB_SYMBCLASS_DEFINE
		symbDelDefine( s, FALSE )

	case FB_SYMBCLASS_KEYWORD
		symbDelKeyword( s, FALSE )

    case FB_SYMBCLASS_LABEL
    	symbDelLabel( s, FALSE )

    case FB_SYMBCLASS_ENUM
		symbDelEnum( s, FALSE )

    case FB_SYMBCLASS_UDT
    	symbDelUDT( s, FALSE )

    case FB_SYMBCLASS_SCOPE
    	symbDelScope( s )

	case else
		symbFreeSymbol( s )

    end select

end sub

'':::::
sub symbDelGlobalTb( ) static
    dim as FBSYMBOL ptr s

    do
    	s = symb.globtb.head
    	if( s = NULL ) then
    		exit do
    	end if

    	symbDelSymbol( s )
    loop

end sub

'':::::
sub symbDelSymbolTb( byval tb as FBSYMBOLTB ptr, _
					 byval hashonly as integer ) static

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
    			 FB_SYMBCLASS_LABEL
    			 '''''FB_SYMBCLASS_DEFINE, _  can't be declared inside procs
    			 '''''FB_SYMBCLASS_TYPEDEF, _ ditto

    			symbDelFromHash( s )

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
function symbIsEqual( byval sym1 as FBSYMBOL ptr, _
					  byval sym2 as FBSYMBOL ptr ) as integer

	dim as FBSYMBOL ptr paraml, paramr

	function = FALSE

	'' same?
	if( sym1 = sym2 ) then
		return TRUE
	end if

	'' NULL?
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
    case FB_SYMBCLASS_UDT
    	''
    	if( sym1->udt.isunion <> sym2->udt.isunion ) then
    		exit function
    	end if

    	''
    	if( sym1->udt.elements <> sym2->udt.elements ) then
    		exit function
    	end if

    	''
    	if( sym1->udt.fldtb.head <> sym2->udt.fldtb.head ) then
    		exit function
    	end if

    	''
    	if( sym1->udt.fldtb.tail <> sym2->udt.fldtb.tail ) then
    		exit function
    	end if

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



