#include once "list.bi"

#ifndef FALSE
#define FALSE 0
#define TRUE -1
#endif

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
	function CList.insert _
		( _
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
			tail = ctx->tail
			ctx->tail = node
			if( tail <> NULL ) then
				tail->next = node
			else
				ctx->head = node
			end If
	
			node->prev = tail
			node->next = NULL
	
			function = cast( byte ptr, node ) + len( TNODE )
	
		else
			function = node
		end if
	
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
