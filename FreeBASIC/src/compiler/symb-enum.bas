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
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr e = any

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
    				   FB_DATATYPE_ENUM, NULL, attrib )
	if( e = NULL ) then
		return NULL
	end if

	'' init tables
	symbSymbTbInit( e->enum_.ns.symtb, e )

	'' create a new hash if in BASIC mangling mode
	if( parser.mangling = FB_MANGLING_BASIC ) then
		symbHashTbInit( e->enum_.ns.hashtb, e, FB_INITFIELDNODES )
	else
		symbHashTbInit( e->enum_.ns.hashtb, e, 0 )
	end if

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
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any

    s = symbNewSymbol( FB_SYMBOPT_DOHASH, _
    				   NULL, _
    				   NULL, NULL, _
    				   FB_SYMBCLASS_CONST, _
    				   id, NULL, _
    				   FB_DATATYPE_ENUM, parent, _
    				   attrib )
	if( s = NULL ) then
		return NULL
	end if

	s->con.val.int = intval

	parent->enum_.elements += 1

	function = s

end function

'':::::
sub symbDelEnum _
	( _
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer _
	)

    if( s = NULL ) then
    	exit sub
    end if

    ''
    symbCompDelImportList( s )

	'' starting from last because of the USING's that could be
	'' referencing a namespace in the same scope block
	dim as FBSYMBOL ptr fld = symbGetCompSymbTb( s ).tail
    do while( fld <> NULL )
        dim as FBSYMBOL ptr prv = fld->prev
		symbFreeSymbol( fld )
		fld = prv
	loop

	''
	if( s->enum_.ns.ext <> NULL ) then
		symbCompFreeExt( s->enum_.ns.ext )
		s->enum_.ns.ext = NULL
	end if

	''
	if( symbGetMangling( s ) = FB_MANGLING_BASIC ) then
		hashFree( @s->enum_.ns.hashtb.tb )
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
