
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


'' circular list
''
'' chng: jan/2007 written [v1ctor]
''


#include once "inc\clist.bi"

const NULL = 0

'':::::
function clistNew _
	( _
		byval clist as TCLIST ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval flags as LIST_FLAGS = LIST_FLAGS_ALL _
	) as integer

	function = listNew( @clist->list, _
						nodes, _
						nodelen, _
						flags or LIST_FLAGS_LINKFREENODES )

	clist->head = clist->list.fhead
	clist->tail = cast( TLISTNODE ptr, _
						cast( byte ptr, clist->list.fhead ) + _
								((nodes-1) * clist->list.nodelen) )

end function

'':::::
function clistFree _
	( _
		byval clist as TCLIST ptr _
	) as integer

	clist->head = NULL
	clist->tail = NULL

	function = listFree( @clist->list )

end function

'':::::
function clistNextNode _
	( _
		byval clist as TCLIST ptr, _
		byval do_circ as integer _
	) as any ptr

	dim as TLISTNODE ptr node = any

	if( clist->head = NULL ) then
		if( do_circ = FALSE ) then
			dim as integer nodes = cunsg(clist->list.nodes) \ 4
			listAllocTB( @clist->list, nodes )

			node = clist->list.fhead

			clist->tail->next = clist->list.fhead

			clist->tail = cast( TLISTNODE ptr, _
							cast( byte ptr, node ) + ((nodes-1) * clist->list.nodelen) )

		else
			node = clist->list.tbhead->nodetb
		end if
	else
		node = clist->head
	end if

	function = cast( byte ptr, node ) + len( TLISTNODE )

	clist->head = node->next

end function


