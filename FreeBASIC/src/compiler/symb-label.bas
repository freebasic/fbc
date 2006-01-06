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


'' symbol table module for labels
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
function symbGetLastLabel( ) as FBSYMBOL ptr static

	function = symb.lastlbl

end function

'':::::
sub symbSetLastLabel( byval l as FBSYMBOL ptr ) static

	symb.lastlbl = l

end sub

'':::::
function symbAddLabel( byval symbol as zstring ptr, _
					   byval declaring as integer = TRUE, _
					   byval createalias as integer = FALSE ) as FBSYMBOL ptr static

    dim as zstring ptr lname, aname
    dim as FBSYMBOL ptr l

    function = NULL

    if( symbol <> NULL ) then
    	'' check if label already exists
    	l = symbFindByNameAndClass( symbol, FB_SYMBCLASS_LABEL )
    	if( l <> NULL ) then
    		if( declaring ) then
    			if( l->lbl.declared ) then
	    			exit function
    			else
    				l->lbl.declared = TRUE
    				return l
    			end if
    		else
    			return l
    		end if
    	end if

		'' add the new label
		if( createalias = FALSE ) then
    		aname = symbol
		else
			aname = hMakeTmpStr( TRUE )
		end if

		lname = symbol

	else
		lname = hMakeTmpStr( TRUE )
		aname = lname
	end if

    l = symbNewSymbol( NULL, symb.symtb, FB_SYMBCLASS_LABEL, TRUE, _
    				   lname, aname, fbIsLocal( ) )
    if( l = NULL ) then
    	exit function
    end if

	l->lbl.declared = declaring

	function = l

end function

'':::::
sub symbDelLabel( byval s as FBSYMBOL ptr, _
				  byval dolookup as integer ) static

    if( dolookup ) then
    	s = symbFindByClass( s, FB_SYMBCLASS_LABEL )
    end if

    if( s = NULL ) then
    	exit sub
    end if

    symbFreeSymbol( s )

end sub

'':::::
function symbCheckLabels( ) as integer
    dim as FBSYMBOL ptr s
    dim as integer cnt

	cnt = 0

    s = symb.globtb.head
    do while( s <> NULL )
    	if( s->class = FB_SYMBCLASS_LABEL ) then
    		if( s->lbl.declared = FALSE ) then
    			hReportErrorEx( FB_ERRMSG_UNDEFINEDLABEL, *symbGetOrgName( s ), -1 )
    			cnt += 1
    		end if
    	end if

    	s = s->next
    loop

	function = cnt

end function

'':::::
function symbCheckLocalLabels(  ) as integer
    dim as FBSYMBOL ptr s
    dim as integer cnt

    cnt = 0

    s = symb.symtb->head
    do while( s <> NULL )

    	if( s->class = FB_SYMBCLASS_LABEL ) then
    		if( s->lbl.declared = FALSE ) then
    			hReportErrorEx( FB_ERRMSG_UNDEFINEDLABEL, *symbGetOrgName( s ), -1 )
    			cnt += 1
    		end if
    	end if

    	s = s->next
    loop

	function = cnt

end function

