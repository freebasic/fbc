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


'' symbol table module for typedef's
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"

'':::::
sub symbInitFwdRef( ) static

	listNew( @symb.fwdlist, FB_INITFWDREFNODES, len( FBFWDREF ), FALSE )

	symb.fwdrefcnt = 0

end sub

'':::::
sub symbAddToFwdRef( byval f as FBSYMBOL ptr, _
					 byval ref as FBSYMBOL ptr ) static
	dim n as FBFWDREF ptr

	n = listNewNode( @symb.fwdlist )

	n->ref 	= ref
	n->prev	= f->fwd.reftail
	f->fwd.reftail = n

	f->fwd.refs += 1

end sub

'':::::
private sub hFixForwardRef( byval f as FBSYMBOL ptr, _
							byval sym as FBSYMBOL ptr, _
							byval class as integer )
    dim as FBFWDREF ptr n, p
    dim as FBSYMBOL ptr ref
    dim as integer typ, ptrcnt

	select case as const class
	case FB_SYMBCLASS_UDT
		typ 	= FB_DATATYPE_USERDEF
		ptrcnt 	= 0
	case FB_SYMBCLASS_ENUM
		typ 	= FB_DATATYPE_ENUM
		ptrcnt 	= 0
	case FB_SYMBCLASS_TYPEDEF
		typ 	= sym->typ
		ptrcnt 	= sym->ptrcnt
		sym 	= sym->subtype
	end select

	n = f->fwd.reftail
	do while( n <> NULL )
		p = n->prev

		ref = n->ref

		ref->typ     = typ + (ref->ptrcnt * FB_DATATYPE_POINTER)
		ref->subtype = sym
		ref->ptrcnt  = ptrcnt
		ref->lgt	 = symbCalcLen( ref->typ, sym )

		listDelNode( @symb.fwdlist, cptr( TLISTNODE ptr, n ) )

		n = p
	loop

	symbFreeSymbol( f )

	symb.fwdrefcnt -= 1

end sub

'':::::
sub symbCheckFwdRef( byval s as FBSYMBOL ptr, _
					 byval class as integer ) static
	dim as FBSYMBOL ptr f, n

	'' go to head
	n = s
	do while( n->left <> NULL )
		n = n->left
	loop

	f = symbFindByClass( n, FB_SYMBCLASS_FWDREF )
	if( f <> NULL ) then
		hFixForwardRef( f, s, class )
	end if

end sub

'':::::
function symbAddTypedef( byval symbol as zstring ptr, _
						 byval typ as integer, _
						 byval subtype as FBSYMBOL ptr, _
						 byval ptrcnt as integer, _
						 byval lgt as integer ) as FBSYMBOL ptr static
    dim as FBSYMBOL ptr t

    function = NULL

    '' allocate new node
    t = symbNewSymbol( NULL, symb.symtb, FB_SYMBCLASS_TYPEDEF, TRUE, _
    				   symbol, NULL, _
    				   fbIsLocal( ), typ, subtype, ptrcnt )
    if( t = NULL ) then
    	exit function
    end if

	''
	t->lgt 	= lgt

	'' check for forward references
	if( symb.fwdrefcnt > 0 ) then
		symbCheckFwdRef( t, FB_SYMBCLASS_TYPEDEF )
	end if

	''
	function = t

end function

'':::::
function symbAddFwdRef( byval symbol as zstring ptr ) as FBSYMBOL ptr static
    dim f as FBSYMBOL ptr

    function = NULL

    '' allocate new node
    f = symbNewSymbol( NULL, symb.symtb, FB_SYMBCLASS_FWDREF, TRUE, _
    				   symbol, NULL, fbIsLocal( ) )
    if( f = NULL ) then
    	exit function
    end if

   	f->fwd.refs = 0
   	f->fwd.reftail = NULL

   	''
   	symb.fwdrefcnt += 1

    function = f

end function


