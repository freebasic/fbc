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


'' generic double-linked list
''
'' chng: jan/2005 written [v1ctor]
''

option explicit

defint a-z
'$include: 'inc\list.bi'

const NULL 	= 0
const FALSE = 0
const TRUE  = -1


declare function listAllocTB		( byval list as TLIST ptr, byval nodes as integer ) as integer

'':::::
function listNew( byval list as TLIST ptr, byval nodes as integer, byval nodelen as integer ) as integer

	'' fill ctrl struct
	list->nodes 	= 0
	list->tblist 	= NULL
	list->nodelen	= nodelen
	list->head		= NULL
	list->tail		= NULL

	'' allocate the initial pool
	listNew = listAllocTB( list, nodes )

end function

'':::::
function listFree( byval list as TLIST ptr ) as integer
    dim tb as TLISTTB ptr, nxt as TLISTTB ptr

	'' for each pool, free the mem block and the pool ctrl struct
	tb = list->tblist
	do while( tb <> NULL )
		nxt = tb->nxt
		deallocate tb->ptr
		deallocate tb
		tb = nxt
	loop

	list->tblist 	= NULL
	list->nodes		= 0

	listFree = TRUE

end function

'':::::
private function listAllocTB( byval list as TLIST ptr, byval nodes as integer ) as integer static
	dim i as integer
	dim node as TLISTNODE ptr, prv as TLISTNODE ptr
	dim tb as TLISTTB ptr

	listAllocTB = FALSE

	if( nodes <= 1 ) then
		exit function
	end if

	'' allocate the pool
	node = callocate( nodes * list->nodelen )
	if( node = NULL ) then
		exit function
	end if

	'' and the pool ctrl struct
	tb = allocate( len( TLISTTB ) )
	if( tb = NULL ) then
		deallocate node
		exit function
	end if

	'' add the ctrl struct to pool list
	if( list->tblist <> NULL ) then
		list->tblist->nxt = tb
	else
		list->tblist = tb
	end if
	tb->ptr = node
	tb->nxt = NULL

	'' add new nodes to the free list
	list->fhead = node
	list->nodes = list->nodes + nodes

	''
	prv = NULL
	node = list->fhead

	For i = 1 to nodes-1
		node->prv	= prv
		node->nxt	= node + list->nodelen

		prv 	   	= node
		node 		= node->nxt
	Next i

	node->prv = prv
	node->nxt = NULL

	''
	listAllocTB = TRUE

end function

'':::::
function listNewNode( byval list as TLIST ptr ) as TLISTNODE ptr static
	dim node as TLISTNODE ptr
	dim tail as TLISTNODE ptr

	'' alloc new node list if there are no free nodes
	if( list->fhead = NULL ) Then
		listAllocTB list, list->nodes \ 2
	end if

	'' take from free list
	node = list->fhead
	list->fhead = node->nxt

	'' add to used list
	tail = list->tail
	list->tail = node
	if( tail <> NULL ) then
		tail->nxt = node
	else
		list->head = node
	end If

	node->prv	= tail
	node->nxt	= NULL

	''
	listNewNode = node

end function

'':::::
sub listDelNode( byval list as TLIST ptr, byval node as TLISTNODE ptr ) static
	Dim prv as TLISTNODE ptr, nxt as TLISTNODE ptr

	if( node = NULL ) then
		exit sub
	end if

	'' remove from used list
	prv = node->prv
	nxt = node->nxt
	if( prv <> NULL ) then
		prv->nxt = nxt
	else
		list->head = nxt
	end If

	if( nxt <> NULL ) then
		nxt->prv = prv
	else
		list->tail = prv
	end If

	'' add to free list
	node->nxt = list->fhead
	list->fhead = node

end sub

