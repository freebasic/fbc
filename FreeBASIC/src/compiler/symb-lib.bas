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


'' symbol table module for libraries
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"

'':::::
sub symbLibInit( ) static

	listNew( @symb.liblist, FB_INITLIBNODES, len( FBLIBRARY ), LIST_FLAGS_NOCLEAR )

    hashNew( @symb.libhash, FB_INITLIBNODES )

end sub

'':::::
sub symbLibEnd( ) static

	hashFree( @symb.libhash )

	listFree( @symb.liblist )

end sub

'':::::
function symbAddLib _
	( _
		byval libname as zstring ptr _
	) as FBLIBRARY ptr static

    dim as FBLIBRARY ptr l

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
	l->name	= ZstrAllocate( len( *libname ) )
	*l->name = *libname

	l->hashindex = hashHash( l->name )
	l->hashitem = hashAdd( @symb.libhash, l->name, l, l->hashindex )

	function = l

end function

'':::::
sub symbDelLib _
	( _
		byval l as FBLIBRARY ptr _
	) static

	if( l = NULL ) then
		exit sub
	end if

	hashDel( @symb.libhash, l->hashitem, l->hashindex )

	ZstrFree( l->name )

    listDelNode( @symb.liblist, l )

end sub

'':::::
private function hFindLib _
	( _
		byval libname as zstring ptr, _
		byval liblist as TLIST ptr _
	) as string ptr

	dim as string ptr libf = listGetHead( liblist )
	do while( libf <> NULL )
		if( *libf = *libname ) then
			return libf
		end if

		libf = listGetNext( libf )
	loop

	function = NULL

end function

'':::::
sub symbListLibs _
	( _
		byval liblist as TLIST ptr _
	)

    dim as FBLIBRARY ptr node = any

	node = listGetHead( @symb.liblist )
	do while( node <> NULL )

		if( hFindLib( node->name, liblist ) = NULL ) then
			dim as string ptr libf = listNewNode( liblist )
			*libf = *node->name
		end if

		node = listGetNext( node )
	loop

end sub


