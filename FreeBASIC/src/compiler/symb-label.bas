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
#include once "inc\lex.bi"

'':::::
function symbGetLastLabel( ) as FBSYMBOL ptr static

	function = symb.lastlbl

end function

'':::::
sub symbSetLastLabel _
	( _
		byval l as FBSYMBOL ptr _
	) static

	symb.lastlbl = l

end sub

'':::::
function symbAddLabel _
	( _
		byval symbol as zstring ptr, _
		byval declaring as integer = TRUE, _
		byval createalias as integer = FALSE _
	) as FBSYMBOL ptr static

    dim as zstring ptr id, id_alias
    dim as FBSYMBOL ptr l
    dim as FBSYMBOLTB ptr symtb

    function = NULL

    if( symbol <> NULL ) then
    	'' check if label already exists
    	l = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
    								  symbol, _
    								  FB_SYMBCLASS_LABEL )
    	if( l <> NULL ) then
    		if( declaring ) then
    			'' dup definition?
    			if( l->lbl.declared ) then
	    			exit function
    			end if

    			'' set the right values
    			l->lbl.declared = TRUE
    			l->lbl.parent = env.currblock
    			l->lbl.stmtnum = env.stmtcnt
    			return l

    		else
    			return l
    		end if
    	end if

		'' add the new label
		if( createalias = FALSE ) then
    		id_alias = symbol
		else
			id_alias = hMakeTmpStr( TRUE )
		end if

		id = symbol

	else
		id = NULL
		id_alias = hMakeTmpStr( TRUE )
	end if

    '' parsing main? add to global tb
    if( fbIsModLevel( ) ) then
    	'' unless inside a namespace..
    	if( symbIsGlobalNamespc() = FALSE ) then
    		symtb = symb.symtb
    	else
    		symtb = @symbGetGlobalTb( )
    	end if

    '' otherside the current proc sym table must be used, not the
    '' current scope because labels inside scopes are unique,
    '' and branching to them from other scopes must be allowed
    else
    	symtb = @env.currproc->proc.symtb
    end if

    l = symbNewSymbol( NULL, _
    				   symtb, NULL, fbIsModLevel( ), _
    				   FB_SYMBCLASS_LABEL, _
    				   symbol <> NULL, id, id_alias )
    if( l = NULL ) then
    	exit function
    end if

	l->lbl.declared = declaring

	if( declaring ) then
		'' label parent won't be the current proc block is
		'' it's been defined inside a scope block
		l->lbl.parent = env.currblock
		l->lbl.stmtnum = env.stmtcnt
	end if

	function = l

end function

'':::::
sub symbDelLabel _
	( _
		byval s as FBSYMBOL ptr _
	) static

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

    s = symbGetGlobalTb( ).head
    do while( s <> NULL )
    	if( s->class = FB_SYMBCLASS_LABEL ) then
    		if( s->lbl.declared = FALSE ) then
    			if( symbGetName( s ) <> NULL ) then
    				hReportErrorEx( FB_ERRMSG_UNDEFINEDLABEL, *symbGetName( s ), -1 )
    				cnt += 1
    			end if
    		end if
    	end if

    	s = s->next
    loop

	function = cnt

end function

'':::::
function symbCheckLocalLabels( ) as integer
    dim as FBSYMBOL ptr s
    dim as integer cnt

    cnt = 0

    s = env.currproc->proc.symtb.head
    do while( s <> NULL )

    	if( s->class = FB_SYMBCLASS_LABEL ) then
    		if( s->lbl.declared = FALSE ) then
    			if( symbGetName( s ) <> NULL ) then
    				hReportErrorEx( FB_ERRMSG_UNDEFINEDLABEL, *symbGetName( s ), -1 )
    				cnt += 1
    			end if
    		end if
    	end if

    	s = s->next
    loop

	function = cnt

end function

