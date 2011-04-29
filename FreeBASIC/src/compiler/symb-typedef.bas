''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


'' symbol table module for typedef's
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"

'':::::
sub symbFwdRefInit( )

	listNew( @symb.fwdlist, FB_INITFWDREFNODES, len( FBFWDREF ), LIST_FLAGS_NOCLEAR )

	symb.fwdrefcnt = 0

end sub

'':::::
sub symbFwdRefEnd( )

	listFree( @symb.fwdlist )

end sub

'':::::
sub symbAddToFwdRef _
	( _
		byval f as FBSYMBOL ptr, _
		byval ref as FBSYMBOL ptr _
	)

    '' Add a symbol (ref) to the fwdref's list of references/users. The symbol
    '' uses the fwdref as its subtype, and will need patching later when the
    '' fwdref's actual type is known and can be filled in.

	dim as FBFWDREF ptr n = listNewNode( @symb.fwdlist )

	n->ref = ref
	n->prev = f->fwd.tail
	f->fwd.tail = n

end sub

'':::::
sub symbRemoveFromFwdRef _
    ( _
        byval f as FBSYMBOL ptr, _
        byval ref as FBSYMBOL ptr _
    )

    dim as FBFWDREF ptr n = f->fwd.tail
    dim as FBFWDREF ptr nxt = NULL

    do
        '' The symbol should be in the fwdref's backpatching list, otherwise it
        '' shouldn't have the fwdref datatype that got us here...
        assert( n <> NULL )

        '' Found it?
        if( n->ref = ref ) then
            exit do
        end if

        nxt = n
        n = n->prev
    loop

    if( nxt = NULL ) then
        '' Removing the tail of the list
        f->fwd.tail = n->prev
    else
        '' Link out of the middle
        nxt->prev = n->prev
    end if

    listDelNode( @symb.fwdlist, n )

end sub

'':::::
private sub symbReplaceForwardRef _
    ( _
        byval s as FBSYMBOL ptr, _
        byval dtype as integer, _
        byval subtype as FBSYMBOL ptr _
    )

    dim as integer oldptrcount = any, addptrcount = any

    '' Replace/merge the symbol's current type with the replacement type.

    '' Existing PTR's (pointer to forward ref, e.g. on typedefs/variables),
    oldptrcount = symbGetPtrCnt( s )

    '' and additional PTR's
    addptrcount = typeGetPtrCnt( dtype )

    '' Too many PTR's after replacing the forward ref with its actual type?
    if( (oldptrcount + addptrcount) > FB_DT_PTRLEVELS ) then
        errReport( FB_ERRMSG_TOOMANYPTRINDIRECTIONS )
        '' Error recovery: use the max. amount of PTR's on the final type
        oldptrcount = FB_DT_PTRLEVELS - addptrcount
    end if

    '' Replace the forward ref:

    '' dtype (but preserve existing PTR's and CONST's)
    symbGetFullType( s ) = typeMultAddrOf( dtype, oldptrcount ) or _
                             typeGetConstMask( symbGetFullType( s ) )
    '' subtype
    symbGetSubtype( s ) = subtype

    s->lgt = symbCalcLen( symbGetType( s ), subtype )

    '' We might have substituted the fwdref by another fwdref, and then this
    '' symbol must be patched again.
    if( typeGetDtOnly( dtype ) = FB_DATATYPE_FWDREF ) then
        symbAddToFwdRef( subtype, s )
    end if

end sub

'':::::
private sub hFixForwardRef _
	( _
		byval fwd as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr _
	)

    dim as FBFWDREF ptr node = any, prev = any
    dim as FBSYMBOL ptr subtype = any
    dim as integer dtype = any

    '' Replace all uses of this forward ref <fwd> with its actual
    '' enum/struct/typedef replacement <sym>.
    '' All symbols that use this fwdref were added to the fwdref's list of
    '' references and now they can be updated.

    '' This is exactly what cSymbolType() is doing too:
    select case as const symbGetClass( sym )
    case FB_SYMBCLASS_STRUCT
        dtype = FB_DATATYPE_STRUCT
        subtype = sym

    case FB_SYMBCLASS_ENUM
        dtype = FB_DATATYPE_ENUM
        subtype = sym

    case FB_SYMBCLASS_TYPEDEF
        '' For an enum/struct the dtype will simply be FB_DATATYPE_ENUM/STRUCT,
        '' but for a typedef, it can contain PTR's and CONST's, and the type
        '' can be anything, even another FB_DATATYPE_FWDREF.
        dtype = symbGetFullType( sym )

        '' For a typedef, its subtype (and not the typedef itself) is used to
        '' replace the fwdref. Afterall there is no typedef data type.
        subtype = symbGetSubtype( sym )

    case else
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
    end select

    '' Cycle through the forward ref's list of users
	node = fwd->fwd.tail
	do while( node <> NULL )

        '' Do the replacement in the user
        symbReplaceForwardRef( node->ref, dtype, subtype )

		prev = node->prev
		listDelNode( @symb.fwdlist, node )
		node = prev
	loop

    '' Delete the forward ref symbol -- since it's no longer used anywhere
	symbFreeSymbol( fwd )

	symb.fwdrefcnt -= 1

end sub

'':::::
sub symbCheckFwdRef _
	( _
		byval sym as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr fwd = any

    '' Find the fwdref that can be resolved with this <sym> (the new typedef/enum/type).

    '' to tail
    fwd = sym
    do
    	if( fwd->class = FB_SYMBCLASS_FWDREF ) then
			hFixForwardRef( fwd, sym )
			exit sub
		end if

		fwd = fwd->hash.next
	loop while( fwd <> NULL )

	'' to head
	fwd = sym->hash.prev
	do while( fwd <> NULL )

    	if( fwd->class = FB_SYMBCLASS_FWDREF ) then
			hFixForwardRef( fwd, sym )
			exit sub
		end if

		fwd = fwd->hash.prev
	loop

end sub

'':::::
function symbAddTypedef _
	( _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr t = any

    '' allocate new node
    t = symbNewSymbol( FB_SYMBOPT_DOHASH, _
    				   NULL, _
    				   NULL, NULL, _
    				   FB_SYMBCLASS_TYPEDEF, _
    				   id, NULL, _
    				   dtype, subtype )
    if( t = NULL ) then
    	return NULL
    end if

	''
	t->lgt = lgt

	'' check for forward references
	if( symb.fwdrefcnt > 0 ) then
		symbCheckFwdRef( t )
	end if

	''
	function = t

end function

'':::::
function symbAddFwdRef _
	( _
		byval id as zstring ptr _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr f = any

    '' note: assuming id is already upper-cased

    '' allocate a new node
    f = symbNewSymbol( FB_SYMBOPT_DOHASH or FB_SYMBOPT_PRESERVECASE, _
    				   NULL, _
    				   NULL, NULL, _
    				   FB_SYMBCLASS_FWDREF, _
    				   id, NULL, _
    				   FB_DATATYPE_INVALID, NULL )
    if( f = NULL ) then
    	return NULL
    end if

   	f->fwd.tail = NULL

   	''
   	symb.fwdrefcnt += 1

    function = f

end function


