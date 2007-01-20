''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


'' symbol table module for enumerations
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"

'':::::
function symbAddEnum _
	( _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval attrib as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr e

    function = NULL

	'' no explict alias given?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( parser.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    end if

    e = symbNewSymbol( FB_SYMBOPT_DOHASH, _
    				   NULL, _
    				   NULL, NULL, _
    				   FB_SYMBCLASS_ENUM, _
    				   id, id_alias, _
    				   INVALID, NULL, 0, attrib )
	if( e = NULL ) then
		exit function
	end if

	'' init tables
	symbSymbTbInit( e->enum_.ns.symtb, e )
	symbHashTbInit( e->enum_.ns.hashtb, e, 0 )

    '' unused (while mixins aren't supported)
    e->enum_.ns.ext = NULL

	e->enum_.elements = 0
	e->enum_.dbg.typenum = INVALID

	'' check for forward references
	if( symb.fwdrefcnt > 0 ) then
		symbCheckFwdRef( e, FB_SYMBCLASS_ENUM )
	end if

	function = e

end function

'':::::
function symbAddEnumElement _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval intval as integer, _
		byval attrib as integer _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr s

    s = symbNewSymbol( FB_SYMBOPT_DOHASH, _
    				   NULL, _
    				   NULL, NULL, _
    				   FB_SYMBCLASS_CONST, _
    				   id, NULL, _
    				   FB_DATATYPE_ENUM, parent, 0, attrib )
	if( s = NULL ) then
		exit function
	end if

	s->con.val.int = intval

	parent->enum_.elements += 1

	''
	function = s

end function

'':::::
sub symbDelEnum _
	( _
		byval s as FBSYMBOL ptr _
	)

    if( s = NULL ) then
    	exit sub
    end if

	'' del the imports (USING's) first, or NamespaceRemove() would
	'' remove try to remove the namespace from the hash tb list
    symbCompDelImportList( s )

    '' del all enum constants
	dim as FBSYMBOL ptr e = any, nxt = any

	e = s->enum_.ns.symtb.head
    do while( e <> NULL )
        nxt = e->next
		symbFreeSymbol( e )
		e = nxt
	loop

	''
	if( s->enum_.ns.ext <> NULL ) then
		symbCompFreeExt( s->enum_.ns.ext )
		s->enum_.ns.ext = NULL
	end if

	'' del the enum node
	symbFreeSymbol( s )

end sub

'':::::
function symbGetEnumFirstElm _
	( _
		byval parent as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = symbGetEnumSymbTbHead( parent )

	'' find the first const
	do while( sym <> NULL )
		if( symbIsConst( sym ) ) then
			return sym
		end if
		sym = sym->next
	loop

	function = NULL

end function

'':::::
function symbGetEnumNextElm _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	'' find the next const
	sym = sym->next
	do while( sym <> NULL )
		if( symbIsConst( sym ) ) then
			return sym
		end if
		sym = sym->next
	loop

	function = NULL

end function
