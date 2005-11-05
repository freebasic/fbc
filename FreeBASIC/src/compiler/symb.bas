''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

	symb.globtb.head = NULL
	symb.globtb.tail = NULL

	symb.symtb = @symb.globtb

	symb.lastlbl = NULL

end sub

'':::::
sub symbInit( byval ismain as integer )

	''
	if( symb.inited ) then
		exit sub
	end if


	''
	hashInit( )

	''
	'' vars, arrays, procs & consts
	''
	symbInitSymbols( )

	''
	'' keywords
	symbInitKeywords( )

	''
	'' defines
	''
	symbInitDefines( ismain )

	''
	'' forward refs
	''
	symbInitFwdRef( )

	''
	'' arrays dim tb
	''
	symbInitDims( )

	''
	'' libraries
	''
	symbInitLibs( )

    ''
    symb.inited 	= TRUE

end sub

'':::::
sub symbEnd

    if( not symb.inited ) then
    	exit sub
    end if

	''
	symbDelGlobalTb( )

	symb.globtb.head = NULL
	symb.globtb.tail = NULL
	symb.symtb = NULL

    ''
	hashFree( @symb.libhash )

    hashFree( @symb.symhash )

	''
	listFree( @symb.liblist )

	listFree( @symb.dimlist )

	listFree( @symb.fwdlist )

	listFree( @symb.deftoklist )

	listFree( @symb.defarglist )

	listFree( @symb.symlist )

	''
	symb.inited = FALSE

end sub

'':::::
function symbSetSymbolTb( byval tb as FBSYMBOLTB ptr ) as FBSYMBOLTB ptr

	function = symb.symtb

	if( tb = NULL ) then
		symb.symtb = @symb.globtb
	else
		symb.symtb = tb
	end if

end function

'':::::
function symbGetSymbolTbHead( ) as FBSYMBOL ptr static

	function = symb.symtb->head

end function

'':::::
function symbGetGlobalTbHead( ) as FBSYMBOL ptr static

	function = symb.globtb.head

end function

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
	case FB_SYMBCLASS_UDTELM, FB_SYMBCLASS_PROCARG

	'' adding a label or forward ref? anything but a define and keyword is allowed,
	'' if the same class doesn't exist yet
	case FB_SYMBCLASS_LABEL, FB_SYMBCLASS_FWDREF

		function = FALSE

		do
			select case as const n->class
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD
				exit function

			case else
				if( n->class = s->class ) then
					exit function
				end if
			end select

			n = n->right
		loop while( n <> NULL )

	'' adding an udt, enum or typedef? anything but a define, keyword or
	'' themselves is allowed
	case FB_SYMBCLASS_UDT, FB_SYMBCLASS_ENUM, FB_SYMBCLASS_TYPEDEF

		function = FALSE

		do
			select case as const n->class
			case FB_SYMBCLASS_DEFINE, FB_SYMBCLASS_KEYWORD, _
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
					 	byval class as SYMBCLASS_ENUM, _
					 	byval dohash as integer = TRUE, _
					 	byval symbol as zstring ptr, _
					 	byval aliasname as zstring ptr, _
					 	byval islocal as integer, _
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
    s->class		= class
    s->scope		= env.scope
    s->typ			= typ
    s->subtype		= subtype
    s->ptrcnt		= ptrcnt

	s->alloctype	= iif( islocal, FB_ALLOCTYPE_LOCAL, 0 )
    s->lgt			= 0
    s->ofs			= 0

    if( class = FB_SYMBCLASS_VAR ) then
    	s->var.suffix = suffix
    	s->var.emited = FALSE
    end if

    ''
    ZEROSTRDESC( s->name )
    slen = len( *symbol )
    if( slen > 0 ) then
    	if( not preservecase ) then
    		s->name = ucase( *symbol )
    	else
    	    s->name = *symbol
		end if
    else
    	dohash = FALSE
    end if

    ZEROSTRDESC( s->alias )
    if( aliasname <> NULL ) then
    	s->alias = *aliasname
    else
		select case class
		case FB_SYMBCLASS_VAR, FB_SYMBCLASS_PROC
			s->alias = s->name
		end select
    end if

	s->left  = NULL
	s->right = NULL

	''
	if( dohash ) then

		'' doesn't exist yet?
		n = hashLookup( @symb.symhash, strptr( s->name ) )
		if( n = NULL ) then
			'' add to hash table
			s->hashitem = hashAdd( @symb.symhash, strptr( s->name ), s, s->hashindex )

		else
			'' can be duplicated?
			if( not hCanDuplicate( n, s ) ) then
				s->name = ""
				s->alias = ""
				if( delok ) then
					listDelNode( @symb.symlist, cptr( TLISTNODE ptr, s ) )
				end if
				exit function
			end if

			s->hashitem  = n->hashitem
			s->hashindex = n->hashindex

			'' module-level scope?
			if( s->scope = 0 ) then
				'' add to tail
				do while( n->right <> NULL )
					n = n->right
				loop

				n->right = s
				s->left  = n

			else
				'' add to head
				n->hashitem->idx  = s
				n->hashitem->name = strptr( s->name )
			    n->left	 = s
			    s->right = n

			end if
		end if

	else
		s->hashitem  = NULL
		s->hashindex = 0
	end if

	''
	typ -= ptrcnt * FB_SYMBTYPE_POINTER
	if( typ = FB_SYMBTYPE_FWDREF ) then
		symbAddToFwdRef( subtype, s )
	end if

	'' add to symbol table
	if( symtb->tail <> NULL ) then
		symtb->tail->next = s
	else
		symtb->head = s
	end if

	s->prev  = symtb->tail
	s->next  = NULL

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

    if( not preservecase ) then
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
		if( fbIsLocal( ) ) then
			if( (s->alloctype and (FB_ALLOCTYPE_LOCAL or FB_ALLOCTYPE_SHARED)) = 0 ) then
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
    	if( suffix = FB_SYMBTYPE_STRING ) then
    		do while( s <> NULL )
    			if( s->class = FB_SYMBCLASS_VAR ) then
     				select case s->typ
     				case FB_SYMBTYPE_STRING, FB_SYMBTYPE_FIXSTR, _
     					 FB_SYMBTYPE_CHAR
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
    	if( deftyp = FB_SYMBTYPE_STRING ) then
    		do while( s <> NULL )
    			if( s->class = FB_SYMBCLASS_VAR ) then
     				if( s->var.suffix = INVALID ) then
     					exit do
     				end if
     				select case s->typ
     				case FB_SYMBTYPE_STRING, FB_SYMBTYPE_FIXSTR, _
     					 FB_SYMBTYPE_CHAR
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
	if( fbIsLocal( ) ) then
		if( (s->alloctype and (FB_ALLOCTYPE_LOCAL or FB_ALLOCTYPE_SHARED)) = 0 ) then
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
    		deftyp = hGetDefType( *symbol )
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
	case FB_SYMBTYPE_FWDREF
		function = 0

	case FB_SYMBTYPE_BYTE, FB_SYMBTYPE_UBYTE, FB_SYMBTYPE_CHAR
		function = 1

	case FB_SYMBTYPE_SHORT, FB_SYMBTYPE_USHORT
		function = 2

	case FB_SYMBTYPE_WCHAR
		function = env.target.wchar.size

	case FB_SYMBTYPE_INTEGER, FB_SYMBTYPE_LONG, FB_SYMBTYPE_UINT, FB_SYMBTYPE_ENUM
		function = FB_INTEGERSIZE

	case FB_SYMBTYPE_LONGINT, FB_SYMBTYPE_ULONGINT
		function = FB_INTEGERSIZE*2

	case FB_SYMBTYPE_SINGLE
		function = 4

	case FB_SYMBTYPE_DOUBLE
    	function = 8

	case FB_SYMBTYPE_FIXSTR
		function = 0									'' 0-len literal-strings

	case FB_SYMBTYPE_STRING
		function = FB_STRDESCLEN

	case FB_SYMBTYPE_USERDEF
		if( not realsize ) then
			function = subtype->lgt
		else
			function = subtype->udt.unpadlgt
		end if

	case else
		if( typ >= FB_SYMBTYPE_POINTER ) then
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
       		s->hashitem->name = strptr( nxt->name )
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
    if( not movetoglob ) then
    	s->prev  = NULL
    	s->next  = NULL
    	s->name  = ""
    	s->alias = ""

    	listDelNode( @symb.symlist, cptr( TLISTNODE ptr, s ) )

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
    		case FB_SYMBCLASS_VAR, FB_SYMBCLASS_CONST, FB_SYMBCLASS_UDT, _
    			 FB_SYMBCLASS_ENUM, FB_SYMBCLASS_LABEL

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

	dim as FBSYMBOL ptr argl, argr

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
    	if( symbGetFuncMode( sym1 ) <> symbGetFuncMode( sym2 ) ) then
    		exit function
    	end if

    	'' not the same number of args?
    	if( symbGetProcArgs( sym1 ) <> symbGetProcArgs( sym2 ) ) then

    		'' no args?
    		if( symbGetProcArgs( sym1 ) = 0 ) then
    			exit function
    		end if

    		'' not vararg?
    		if( symbGetProcTailArg( sym1 )->arg.mode <> FB_ARGMODE_VARARG ) then
    			exit function
    		end if

    		'' not enough args?
    		if( (symbGetProcArgs( sym2 ) - symbGetProcArgs( sym1 )) < -1 ) then
    			exit function
    		end if
    	end if

    	'' check each arg
    	argl = symbGetProcHeadArg( sym1 )
    	argr = symbGetProcHeadArg( sym2 )

    	do while( argl <> NULL )
            '' vararg?
            if( argl->arg.mode = FB_ARGMODE_VARARG ) then
            	exit do
            end if

    		'' mode?
    		if( argl->arg.mode <> argr->arg.mode ) then
            	exit function
    		end if

    		'' different types?
    		if( argl->typ <> argr->typ ) then
         		exit function
        	end if

        	'' sub-types?
        	if( argl->subtype <> argr->subtype ) then
            	exit function
			end if

    		'' next arg..
    		argl = argl->next
    		argr = argr->next
    	loop
    end select

	'' and sub type
	if( sym1->subtype <> sym2->subtype ) then
        function = symbIsEqual( sym1->subtype, sym2->subtype )
    else
    	function = TRUE
    end if

end function


