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

defint a-z
option explicit
option escape

const NULL = 0

'$include once: 'inc\list.bi'


'':::::
function listNew( byval list as TLIST ptr, _
				  byval nodes as integer, _
				  byval nodelen as integer, _
				  byval relink as integer = TRUE ) as integer

	'' fill ctrl struct
	list->tbhead 	= NULL
	list->tbtail 	= NULL
	list->nodes 	= 0
	list->nodelen	= nodelen
	list->head		= NULL
	list->tail		= NULL

	'' allocate the initial pool
	function = listAllocTB( list, nodes, relink )

end function

'':::::
function listFree( byval list as TLIST ptr ) as integer
    dim as TLISTTB ptr tb, nxt

	'' for each pool, free the mem block and the pool ctrl struct
	tb = list->tbhead
	do while( tb <> NULL )
		nxt = tb->nxt
		deallocate( tb->nodetb )
		deallocate( tb )
		tb = nxt
	loop

	list->tbhead 	= NULL
	list->tbtail 	= NULL
	list->nodes		= 0

	function = TRUE

end function

'':::::
function listAllocTB( byval list as TLIST ptr, _
					  byval nodes as integer, _
					  byval relink as integer = TRUE ) as integer static
	dim as integer i
	dim as TLISTNODE ptr nodetb, node, prv
	dim as TLISTTB ptr tb

	function = FALSE

	if( nodes <= 1 ) then
		exit function
	end if

	'' allocate the pool
	nodetb = callocate( nodes * list->nodelen )
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
		list->tbtail->nxt = tb
	end if
	list->tbtail = tb

	tb->nxt 	= NULL
	tb->nodetb 	= nodetb
	tb->nodes 	= nodes

	'' add new nodes to the free list
	list->fhead = nodetb
	list->nodes += nodes

	''
	if( relink ) then
		prv = NULL
		node = list->fhead

		for i = 1 to nodes-1
			node->prv	= prv
			node->nxt	= node + list->nodelen

			prv 	   	= node
			node 		= node->nxt
		next

		node->prv = prv
		node->nxt = NULL
	end if

	''
	function = TRUE

end function

'':::::
function listNewNode( byval list as TLIST ptr ) as TLISTNODE ptr static
	dim as TLISTNODE ptr node, tail

	'' alloc new node list if there are no free nodes
	if( list->fhead = NULL ) Then
		listAllocTB( list, list->nodes \ 2 )
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
	function = node

end function

'':::::
function listDelNode( byval list as TLIST ptr, _
					  byval node as TLISTNODE ptr ) as integer static
	dim as TLISTNODE ptr prv, nxt

	if( node = NULL ) then
		exit function
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

	'' node can contain strings descriptors, so, erase it..
	clear( byval node + (len( any ptr ) * 2), 0, list->nodelen - (len( any ptr ) * 2) )

end function

