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


'' symbol table module for libraries
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
sub symbInitLibs( ) static

	listNew( @symb.liblist, FB_INITLIBNODES, len( FBLIBRARY ), FALSE )

    hashNew( @symb.libhash, FB_INITLIBNODES )

end sub

'':::::
function symbAddLib( byval libname as zstring ptr ) as FBLIBRARY ptr static
    dim l as FBLIBRARY ptr

    function = NULL

    '' check if not already declared
    l = hashLookup( @symb.libhash, libname )
    if( l <> NULL ) then
    	return l
    end if

    l = listNewNode( @symb.liblist )
	if( l = NULL ) then
		exit function
	end if

	''
	l->name		= ZstrAllocate( len( *libname ) )
	*l->name	= *libname

	l->hashitem = hashAdd( @symb.libhash, l->name, l, l->hashindex )

	function = l

end function

'':::::
sub symbDelLib( byval l as FBLIBRARY ptr ) static

	if( l = NULL ) then
		exit sub
	end if

	hashDel( @symb.libhash, l->hashitem, l->hashindex )

	ZstrFree( l->name )

    listDelNode( @symb.liblist, cast( TLISTNODE ptr, l ) )

end sub

'':::::
function hFindLib( byval libname as zstring ptr, _
				   namelist() as string ) as integer
    dim i as integer

	function = INVALID

	for i = 0 to ubound( namelist ) - 1

		if( len( namelist(i) ) = 0 ) then
			exit function
		end if

		if( namelist(i) = *libname ) then
			return i
		end if
	next i

end function

'':::::
function symbListLibs( namelist() as string, _
					   byval index as integer ) as integer static
    dim cnt as integer
    dim node as FBLIBRARY ptr

	cnt  = index

	node = symb.liblist.head
	do while( node <> NULL )

		if( hFindLib( node->name, namelist() ) = INVALID ) then
			namelist(cnt) = *node->name
			cnt += 1
		end if

		node = node->ll_nxt
	loop

	function = cnt - index

end function


