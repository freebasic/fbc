#include once "list.bi"

#ifndef FALSE
#define FALSE 0
#define TRUE -1
#endif

#define NULL 0
	
namespace fb.list
	
	type TNODE
		prev	as TNODE ptr
		next	as TNODE ptr
	end type
	
	type TLISTTB
		next	as TLISTTB ptr
		nodetb	as any ptr
		nodes	as integer
	end type
	
	type CList_
		tbhead	as TLISTTB ptr
		tbtail	as TLISTTB ptr
		nodes 	as integer
		nodelen	as integer
		fhead	as TNODE ptr						'' free list
		head	as any ptr							'' used list
		tail	as any ptr							'' /
		flags	as flags
	end type

	declare function _allocTB _
		( _
			byval l as CList ptr, _
			byval nodes as integer _
		) as integer

	'':::::
	function new _
		( _
			byval nodes as integer, _
			byval nodelen as integer, _
			byval flags as flags _
		) as CList ptr
	
		dim as CList ptr l
		
		l = allocate( len( CList ) )
		
		'' fill ctrl struct
		l->tbhead = NULL
		l->tbtail = NULL
		l->nodes = 0
		l->nodelen = nodelen + len( TNODE )
		l->head = NULL
		l->tail = NULL
		l->flags = flags
	
		'' allocate the initial pool
		_allocTB( l, nodes )
		
		function = l
	
	end function
	
	'':::::
	function delete _
		( _
			byval _this as CList ptr _
		) as integer
	
	    dim as TLISTTB ptr tb, nxt
	
		'' for each pool, free the mem block and the pool ctrl struct
		tb = _this->tbhead
		do while( tb <> NULL )
			nxt = tb->next
			deallocate( tb->nodetb )
			deallocate( tb )
			tb = nxt
		loop
	
		_this->tbhead = NULL
		_this->tbtail = NULL
		_this->nodes = 0
		
		deallocate( _this )
	
		function = TRUE
	
	end function
	
	'':::::
	private function _allocTB _
		( _
			byval _this as CList ptr, _
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
		if( (_this->flags and flags_CLEARNODES) <> 0 ) then
			nodetb = callocate( nodes * _this->nodelen )
		else
			nodetb = allocate( nodes * _this->nodelen )
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
		if( _this->tbhead = NULL ) then
			_this->tbhead = tb
		end if
		if( _this->tbtail <> NULL ) then
			_this->tbtail->next = tb
		end if
		_this->tbtail = tb
	
		tb->next = NULL
		tb->nodetb = nodetb
		tb->nodes = nodes
	
		'' add new nodes to the free list
		_this->fhead = nodetb
		_this->nodes += nodes
	
		''
		if( (_this->flags and flags_LINKFREENODES) <> 0 ) then
			prv = NULL
			node = _this->fhead
	
			for i = 1 to nodes-1
				node->prev	= prv
				node->next	= cast( TNODE ptr, cast( byte ptr, node ) + _this->nodelen )
	
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
	function insert _
		( _
			byval _this as CList ptr _
		) as any ptr static
	
		dim as TNODE ptr node, tail
	
		'' alloc new node list if there are no free nodes
		if( _this->fhead = NULL ) Then
			_allocTB( _this, cunsg(_this->nodes) \ 4 )
		end if
	
		'' take from free list
		node = _this->fhead
		_this->fhead = node->next
	
		if( (_this->flags and flags_LINKUSEDNODES) <> 0 ) then
			'' add to used list
			tail = _this->tail
			_this->tail = node
			if( tail <> NULL ) then
				tail->next = node
			else
				_this->head = node
			end If
	
			node->prev = tail
			node->next = NULL
	
			function = cast( byte ptr, node ) + len( TNODE )
	
		else
			function = node
		end if
	
	end function
	
	'':::::
	sub remove _
		( _
			byval _this as CList ptr, _
			byval node_ as any ptr _
		) static
	
		dim as TNODE ptr node, prv, nxt
	
		if( node_ = NULL ) then
			exit sub
		end if
	
		if( (_this->flags and flags_LINKUSEDNODES) <> 0 ) then
			node = cast( TNODE ptr, cast( byte ptr, node_ ) - len( TNODE ) )
	
			'' remove from used list
			prv = node->prev
			nxt = node->next
			if( prv <> NULL ) then
				prv->next = nxt
			else
				_this->head = nxt
			end If
	
			if( nxt <> NULL ) then
				nxt->prev = prv
			else
				_this->tail = prv
			end If
	
		else
			node = cast( TNODE ptr, node_ )
		end if
	
		'' add to free list
		node->next = _this->fhead
		_this->fhead = node
	
		'' node can contain strings descriptors, so, erase it..
		if( (_this->flags and flags_CLEARNODES) <> 0 ) then
			clear( byval node_, 0, _this->nodelen - len( TNODE ) )
		end if
	
	end sub
	
	'':::::
	function getHead _
		( _
			byval _this as CList ptr _
		) as any ptr
	
		assert( (_this->flags and flags_LINKUSEDNODES) <> 0 )
	
		if( _this->head = NULL ) then
			function = NULL
		else
			function = cast( byte ptr, _this->head ) + len( TNODE )
		end if
	
	end function
	
	'':::::
	function getTail _
		( _
			byval _this as CList ptr _
		) as any ptr
	
		assert( (_this->flags and flags_LINKUSEDNODES) <> 0 )
	
		if( _this->tail = NULL ) then
			function = NULL
		else
			function = cast( byte ptr, _this->tail ) + len( TNODE )
		end if
	
	end function
	
	'':::::
	function getPrev _
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
	function getNext _
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