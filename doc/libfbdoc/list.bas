''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2022 The FreeBASIC development team.
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
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.


'' CList - generic double-linked list
''
'' chng: jan/2005 written [v1ctor]
''       dec/2006 updated [v1ctor] - using classes
''

#include once "list.bi"

#define NULL 0
	
namespace fb
	
	type TNODE
		prev	as TNODE ptr
		next	as TNODE ptr
	end type
	
	type TLISTTB
		next	as TLISTTB ptr
		nodetb	as any ptr
		nodes	as integer
	end type
	
	type CListCtx_
		tbhead	as TLISTTB ptr
		tbtail	as TLISTTB ptr
		nodes 	as integer
		nodelen	as integer
		fhead	as TNODE ptr						'' free list
		head	as any ptr							'' used list
		tail	as any ptr							'' /
		flags	as CList.flags
	end type

	declare function _allocTB _
		( _
			byval ctx as CListCtx ptr, _
			byval nodes as integer _
		) as integer

	'':::::
	constructor Clist _
		( _
			byval nodes as integer, _
			byval nodelen as integer, _
			byval flags as flags _
		) 
	
		ctx = new CListCtx
		
		'' fill ctrl struct
		ctx->tbhead = NULL
		ctx->tbtail = NULL
		ctx->nodes = 0
		ctx->nodelen = nodelen + len( TNODE )
		ctx->head = NULL
		ctx->tail = NULL
		ctx->flags = flags
	
		'' allocate the initial pool
		_allocTB( ctx, nodes )
		
	end constructor
	
	'':::::
	destructor Clist _
		( _
		) 
	
	    dim as TLISTTB ptr tb, nxt
	
		'' for each pool, free the mem block and the pool ctrl struct
		tb = ctx->tbhead
		do while( tb <> NULL )
			nxt = tb->next
			deallocate( tb->nodetb )
			deallocate( tb )
			tb = nxt
		loop
	
		ctx->tbhead = NULL
		ctx->tbtail = NULL
		ctx->nodes = 0
		
		deallocate( ctx )
	
	end destructor
	
	'':::::
	private function _allocTB _
		( _
			byval ctx as CListCtx ptr, _
			byval nodes as integer _
		) as integer static
	
		dim as TNODE ptr nodetb, node, prv
		dim as TLISTTB ptr tb
		dim as integer i
	
		function = FALSE
	
		if( nodes <= 1 ) then
			exit function
		end if
	
		'' allocate the pool
		if( (ctx->flags and CList.flags_CLEARNODES) <> 0 ) then
			nodetb = callocate( nodes * ctx->nodelen )
		else
			nodetb = allocate( nodes * ctx->nodelen )
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
		if( ctx->tbhead = NULL ) then
			ctx->tbhead = tb
		end if
		if( ctx->tbtail <> NULL ) then
			ctx->tbtail->next = tb
		end if
		ctx->tbtail = tb
	
		tb->next = NULL
		tb->nodetb = nodetb
		tb->nodes = nodes
	
		'' add new nodes to the free list
		ctx->fhead = nodetb
		ctx->nodes += nodes
	
		''
		if( (ctx->flags and CList.flags_LINKFREENODES) <> 0 ) then
			prv = NULL
			node = ctx->fhead
	
			for i = 1 to nodes-1
				node->prev	= prv
				node->next	= cast( TNODE ptr, cast( byte ptr, node ) + ctx->nodelen )
	
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
	function CList.insertafter _
		( _
			byval prev_node_ as any ptr _
		) as any ptr static
	
		dim as TNODE ptr node, tail
	
		'' alloc new node list if there are no free nodes
		if( ctx->fhead = NULL ) Then
			_allocTB( ctx, cunsg(ctx->nodes) \ 4 )
		end if

		'' take from free list
		node = ctx->fhead
		ctx->fhead = node->next

		if( (ctx->flags and flags_LINKUSEDNODES) <> 0 ) then
			'' add to used list

			if( prev_node_ <> NULL ) then
				tail = cast( TNODE ptr, cast( byte ptr, prev_node_ ) - len( TNODE ) )
			else
				tail = ctx->tail
			end if

			if( tail <> NULL ) then

				node->prev = tail
				node->next = tail->next
				tail->next = node

				if( node->next <> NULL ) then
					node->next->prev = node
				else
					ctx->tail = node
				end if

			else
				
				ctx->head = node
				ctx->tail = node
				node->prev = NULL
				node->next = NULL

			end if

			function = cast( byte ptr, node ) + len( TNODE )
	
		else
			function = node
		end if
	
	end function

	'':::::
	function CList.insertbefore _
		( _
			byval next_node_ as any ptr _
		) as any ptr static
	
		dim as TNODE ptr node, head
	
		'' alloc new node list if there are no free nodes
		if( ctx->fhead = NULL ) Then
			_allocTB( ctx, cunsg(ctx->nodes) \ 4 )
		end if

		'' take from free list
		node = ctx->fhead
		ctx->fhead = node->next

		if( (ctx->flags and flags_LINKUSEDNODES) <> 0 ) then
			'' add to used list

			if( next_node_ <> NULL ) then
				head = cast( TNODE ptr, cast( byte ptr, next_node_ ) - len( TNODE ) )
			else
				head = ctx->head
			end if

			if( head <> NULL ) then

				node->prev = head->prev
				node->next = head
				head->prev = node

				if( node->prev <> NULL ) then
					node->prev->next = node
				else
					ctx->head = node
				end if

			else
				
				ctx->head = node
				ctx->tail = node
				node->prev = NULL
				node->next = NULL

			end if

			function = cast( byte ptr, node ) + len( TNODE )
	
		else
			function = node
		end if
	
	end function

	'':::::
	function CList.insert _
		( _
			byval where as INSERTION_POINT, _
			byval node as any ptr _
		) as any ptr static

		select case where
		case insert_first
			function = insertbefore( NULL )
		case insert_last
			function = insertafter( NULL )
		case insert_before
			function = insertbefore( node )
		case insert_after
			function = insertafter( node )
		case else
			function = NULL
		end select

	end function
	
	'':::::
	sub CList.remove _
		( _
			byval node_ as any ptr _
		) static
	
		dim as TNODE ptr node, prv, nxt
	
		if( node_ = NULL ) then
			exit sub
		end if
	
		if( (ctx->flags and flags_LINKUSEDNODES) <> 0 ) then
			node = cast( TNODE ptr, cast( byte ptr, node_ ) - len( TNODE ) )
	
			'' remove from used list
			prv = node->prev
			nxt = node->next
			if( prv <> NULL ) then
				prv->next = nxt
			else
				ctx->head = nxt
			end If
	
			if( nxt <> NULL ) then
				nxt->prev = prv
			else
				ctx->tail = prv
			end If
	
		else
			node = cast( TNODE ptr, node_ )
		end if
	
		'' add to free list
		node->next = ctx->fhead
		ctx->fhead = node
	
		'' node can contain strings descriptors, so, erase it..
		if( (ctx->flags and flags_CLEARNODES) <> 0 ) then
			clear( byval node_, 0, ctx->nodelen - len( TNODE ) )
		end if
	
	end sub
	
	'':::::
	function CList.getHead _
		( _
		) as any ptr
	
		assert( (ctx->flags and flags_LINKUSEDNODES) <> 0 )
	
		if( ctx->head = NULL ) then
			function = NULL
		else
			function = cast( byte ptr, ctx->head ) + len( TNODE )
		end if
	
	end function
	
	'':::::
	function CList.getTail _
		( _
		) as any ptr
	
		assert( (ctx->flags and flags_LINKUSEDNODES) <> 0 )
	
		if( ctx->tail = NULL ) then
			function = NULL
		else
			function = cast( byte ptr, ctx->tail ) + len( TNODE )
		end if
	
	end function
	
	'':::::
	function CList.getPrev _
		( _
			byval node as any ptr _
		) as any ptr
	
	    dim as TNODE ptr prev
	
		assert( node <> NULL )
	
		prev = cast( TNODE ptr, _
					 cast( byte ptr, node ) - len( TNODE ) )->prev
	
		if( prev = NULL ) then
			function = NULL
		else
			function = cast( byte ptr, prev ) + len( TNODE )
		end if
		
	end function
	
	'':::::
	function CList.getNext _
		( _
			byval node as any ptr _
		) as any ptr
	
	    dim as TNODE ptr nxt
	
		assert( node <> NULL )
	
		nxt = cast( TNODE ptr, _
					cast( byte ptr, node ) - len( TNODE ) )->next
	
		if( nxt = NULL ) then
			function = NULL
		else
			function = cast( byte ptr, nxt ) + len( TNODE )
		end if
	
	end function
	
end namespace