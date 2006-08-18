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


'' symbol table module for typedef's
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"

'':::::
sub symbFwdRefInit( ) static

	listNew( @symb.fwdlist, FB_INITFWDREFNODES, len( FBFWDREF ), LIST_FLAGS_NOCLEAR )

	symb.fwdrefcnt = 0

end sub

'':::::
sub symbFwdRefEnd( ) static

	listFree( @symb.fwdlist )

end sub

'':::::
sub symbAddToFwdRef _
	( _
		byval f as FBSYMBOL ptr, _
		byval ref as FBSYMBOL ptr _
	) static

	dim n as FBFWDREF ptr

	n = listNewNode( @symb.fwdlist )

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
		byval class as integer _
	)

    dim as FBFWDREF ptr n, p
    dim as FBSYMBOL ptr ref
    dim as integer dtype, ptrcnt

	select case as const class
	case FB_SYMBCLASS_UDT
		dtype = FB_DATATYPE_STRUCT
		ptrcnt 	= 0

	case FB_SYMBCLASS_ENUM
		dtype = FB_DATATYPE_ENUM
		ptrcnt = 0

	case FB_SYMBCLASS_TYPEDEF
		dtype = sym->typ
		ptrcnt = sym->ptrcnt
		sym = sym->subtype
	end select

	n = f->fwd.reftail
	do while( n <> NULL )
		p = n->prev

		ref = n->ref

		ref->typ = dtype + (ref->ptrcnt * FB_DATATYPE_POINTER)
		ref->subtype = sym
		ref->ptrcnt = ptrcnt
		ref->lgt = symbCalcLen( ref->typ, sym )

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
		byval class as integer _
	) static

	dim as FBSYMBOL ptr fwd
	dim as FBSYMCHAIN ptr chain_

	'' go to head
	chain_ = sym->hash.chain
	if( chain_ = NULL ) then
		exit sub
	end if

	do while( chain_->prev <> NULL )
		chain_ = chain_->prev
	loop

	fwd = symbFindByClass( chain_, FB_SYMBCLASS_FWDREF )
	if( fwd <> NULL ) then
		hFixForwardRef( fwd, sym, class )
	end if

end sub

'':::::
function symbAddTypedef _
	( _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval lgt as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr t

    function = NULL

    '' allocate new node
    t = symbNewSymbol( NULL, _
    				   NULL, NULL, 0, _
    				   FB_SYMBCLASS_TYPEDEF, _
    				   TRUE, id, NULL, _
    				   dtype, subtype, ptrcnt )
    if( t = NULL ) then
    	exit function
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
		byval id as zstring ptr, _
		byval id_alias as zstring ptr _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr f

    function = NULL

    '' no explict alias given?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( env.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    end if

    '' allocate new node
    f = symbNewSymbol( NULL, _
    				   NULL, NULL, 0, _
    				   FB_SYMBCLASS_FWDREF, _
    				   TRUE, id, id_alias )
    if( f = NULL ) then
    	exit function
    end if

   	f->fwd.refs = 0
   	f->fwd.reftail = NULL

   	''
   	symb.fwdrefcnt += 1

    function = f

end function


