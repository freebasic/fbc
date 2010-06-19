''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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

	dim as FBFWDREF ptr n = listNewNode( @symb.fwdlist )

	n->ref = ref
	n->prev	= f->fwd.reftail
	f->fwd.reftail = n

	f->fwd.refs += 1

end sub

'':::::
private sub hFixForwardRef _
	( _
		byval f as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval class_ as integer _
	)

    dim as FBFWDREF ptr n = any, p = any
    dim as FBSYMBOL ptr ref = any
    dim as integer dtype = any
	
	dtype = symbGetFullType( sym )
	
	select case as const class_
	case FB_SYMBCLASS_TYPEDEF
		sym = symbGetSubtype( sym )
		if( sym ) then
			dtype = symbGetFullType( sym )
		end if
	end select
	
	n = f->fwd.reftail
	do while( n <> NULL )
		p = n->prev

		ref = n->ref
        
		symbGetFullType( ref ) = typeMultAddrOf( dtype, symbGetPtrCnt( ref ) ) or typeGetConstMask( symbGetFullType( ref ) )
		symbGetSubtype( ref ) = sym
		ref->lgt = symbCalcLen( symbGetType( ref ), sym )

		listDelNode( @symb.fwdlist, n )

		n = p
	loop

	symbFreeSymbol( f )

	symb.fwdrefcnt -= 1

end sub

'':::::
sub symbCheckFwdRef _
	( _
		byval sym as FBSYMBOL ptr, _
		byval class_ as integer _
	)

	dim as FBSYMBOL ptr fwd = any

    '' to tail
    fwd = sym
    do
    	if( fwd->class = FB_SYMBCLASS_FWDREF ) then
			hFixForwardRef( fwd, sym, class_ )
			exit sub
		end if

		fwd = fwd->hash.next
	loop while( fwd <> NULL )

	'' to head
	fwd = sym->hash.prev
	do while( fwd <> NULL )

    	if( fwd->class = FB_SYMBCLASS_FWDREF ) then
			hFixForwardRef( fwd, sym, class_ )
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
		symbCheckFwdRef( t, FB_SYMBCLASS_TYPEDEF )
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

   	f->fwd.refs = 0
   	f->fwd.reftail = NULL

   	''
   	symb.fwdrefcnt += 1

    function = f

end function


