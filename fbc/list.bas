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


'' generic double-linked list
''
'' chng: jan/2005 written [v1ctor]
''


const NULL = 0

#include once "list.bi"


'':::::
function listNew _
	( _
		byval list as TLIST ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval flags as LIST_FLAGS _
	) as integer

	'' fill ctrl struct
	list->tbhead = NULL
	list->tbtail = NULL
	list->nodes	= 0
	list->nodelen = nodelen + len( TLISTNODE )
	list->head = NULL
	list->tail = NULL
	list->flags	= flags

	'' allocate the initial pool
	function = listAllocTB( list, nodes )

end function

'':::::
function listFree _
	( _
		byval list as TLIST ptr _
	) as integer

    dim as TLISTTB ptr tb = any, nxt = any

	'' for each pool, free the mem block and the pool ctrl struct
	tb = list->tbhead
	do while( tb <> NULL )
		nxt = tb->next
		deallocate( tb->nodetb )
		deallocate( tb )
		tb = nxt
	loop

	list->tbhead = NULL
	list->tbtail = NULL
	list->nodes	= 0

	function = TRUE

end function

'':::::
function listAllocTB _
	( _
		byval list as TLIST ptr, _
		byval nodes as integer _
	) as integer

	dim as TLISTNODE ptr nodetb = any, node = any, prv = any
	dim as TLISTTB ptr tb = any
	dim as integer i = any

	function = FALSE

	if( nodes < 1 ) then
		exit function
	end if

	'' allocate the pool
	if( (list->flags and LIST_FLAGS_CLEARNODES) <> 0 ) then
		nodetb = callocate( nodes * list->nodelen )
	else
		nodetb = allocate( nodes * list->nodelen )
	end if

	if( nodetb = NULL ) then
		exit function
	end if

	'' and the pool ctrl struct
	tb = allocate( len( TLISTTB ) )
	if( tb = NULL ) then
		deallocate( nodetb )
		exit function
	end if

	'' add the ctrl struct to pool list
	if( list->tbhead = NULL ) then
		list->tbhead = tb
	end if
	if( list->tbtail <> NULL ) then
		list->tbtail->next = tb
	end if
	list->tbtail = tb

	tb->next = NULL
	tb->nodetb = nodetb
	tb->nodes = nodes

	'' add new nodes to the free list
	list->fhead = nodetb
	list->nodes += nodes

	''
	if( (list->flags and LIST_FLAGS_LINKFREENODES) <> 0 ) then
		prv = NULL
		node = list->fhead

		for i = 1 to nodes-1
			node->prev	= prv
			node->next	= cast( TLISTNODE ptr, cast( byte ptr, node ) + list->nodelen )

			prv = node
			node = node->next
		next

		node->prev = prv
		node->next = NULL
	end if

	''
	function = TRUE

end function

'':::::
function listNewNode _
	( _
		byval list as TLIST ptr _
	) as any ptr

	dim as TLISTNODE ptr node = any, tail = any

	'' alloc new node list if there are no free nodes
	if( list->fhead = NULL ) Then
		listAllocTB( list, cunsg(list->nodes) \ 4 )
	end if

	'' take from free list
	node = list->fhead
	list->fhead = node->next

	if( (list->flags and LIST_FLAGS_LINKUSEDNODES) <> 0 ) then
		'' add to used list
		tail = list->tail
		list->tail = node
		if( tail <> NULL ) then
			tail->next = node
		else
			list->head = node
		end If

		node->prev = tail
		node->next = NULL

		function = cast( byte ptr, node ) + len( TLISTNODE )

	else
		function = node
	end if

end function

'':::::
sub listDelNode _
	( _
		byval list as TLIST ptr, _
		byval node_ as any ptr _
	)

	dim as TLISTNODE ptr node = any, prv = any, nxt = any

	if( node_ = NULL ) then
		exit sub
	end if

	if( (list->flags and LIST_FLAGS_LINKUSEDNODES) <> 0 ) then
		node = cast( TLISTNODE ptr, cast( byte ptr, node_ ) - len( TLISTNODE ) )

		'' remove from used list
		prv = node->prev
		nxt = node->next
		if( prv <> NULL ) then
			prv->next = nxt
		else
			list->head = nxt
		end If

		if( nxt <> NULL ) then
			nxt->prev = prv
		else
			list->tail = prv
		end If

	else
		node = cast( TLISTNODE ptr, node_ )
	end if

	'' add to free list
	node->next = list->fhead
	list->fhead = node

	'' node can contain strings descriptors, so, erase it..
	if( (list->flags and LIST_FLAGS_CLEARNODES) <> 0 ) then
		clear( byval node_, 0, list->nodelen - len( TLISTNODE ) )
	end if

end sub

'':::::
function listGetHead _
	( _
		byval list as TLIST ptr _
	) as any ptr

	assert( (list->flags and LIST_FLAGS_LINKUSEDNODES) <> 0 )

	if( list->head = NULL ) then
		function = NULL
	else
		function = cast( byte ptr, list->head ) + len( TLISTNODE )
	end if

end function

'':::::
function listGetTail _
	( _
		byval list as TLIST ptr _
	) as any ptr

	assert( (list->flags and LIST_FLAGS_LINKUSEDNODES) <> 0 )

	if( list->tail = NULL ) then
		function = NULL
	else
		function = cast( byte ptr, list->tail ) + len( TLISTNODE )
	end if

end function

'':::::
function listGetPrev _
	( _
		byval node as any ptr _
	) as any ptr

    dim as TLISTNODE ptr prev = any

	assert( node <> NULL )

	prev = cast( TLISTNODE ptr, _
				 cast( byte ptr, node ) - len( TLISTNODE ) )->prev

	if( prev = NULL ) then
		function = NULL
	else
		function = cast( byte ptr, prev ) + len( TLISTNODE )
	end if

end function

'':::::
function listGetNext _
	( _
		byval node as any ptr _
	) as any ptr

    dim as TLISTNODE ptr nxt = any

	assert( node <> NULL )

	nxt = cast( TLISTNODE ptr, _
				cast( byte ptr, node ) - len( TLISTNODE ) )->next

	if( nxt = NULL ) then
		function = NULL
	else
		function = cast( byte ptr, nxt ) + len( TLISTNODE )
	end if

end function

