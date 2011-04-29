''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


'' generic stack
''
'' chng: jan/2005 written [v1ctor]
''


const NULL = 0

#include once "inc\stack.bi"

declare function hAllocTB		( _
									byval stk as TSTACK ptr, _
					  	   		  	byval nodes as integer _
						 		) as integer

'':::::
function stackNew _
	( _
		byval stk as TSTACK ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval doclear as integer _
	) as integer

	'' fill ctrl struct
	stk->tbhead 	= NULL
	stk->tbtail 	= NULL
	stk->nodes 		= 0
	stk->nodelen	= nodelen + len( TSTACKNODE )
	stk->tos		= NULL
	stk->clear		= doclear

	'' allocate the initial pool
	function = hAllocTB( stk, nodes )

end function

'':::::
function stackFree _
	( _
		byval stk as TSTACK ptr _
	) as integer

    dim as TSTACKTB ptr tb, nxt

	'' for each pool, free the mem block and the pool ctrl struct
	tb = stk->tbhead
	do while( tb <> NULL )
		nxt = tb->next
		deallocate( tb->nodetb )
		deallocate( tb )
		tb = nxt
	loop

	stk->tbhead 	= NULL
	stk->tbtail 	= NULL
	stk->nodes		= 0

	function = TRUE

end function

'':::::
private function hAllocTB _
	( _
		byval stk as TSTACK ptr, _
		byval nodes as integer _
	) as integer static

	dim as TSTACKNODE ptr nodetb, node, prev
	dim as TSTACKTB ptr tb
	dim as integer i

	function = FALSE

	if( nodes <= 1 ) then
		exit function
	end if

	'' allocate the pool
	if( stk->clear ) then
		nodetb = callocate( nodes * stk->nodelen )
	else
		nodetb = allocate( nodes * stk->nodelen )
	end if
	if( nodetb = NULL ) then
		exit function
	end if

	'' and the pool ctrl struct
	tb = allocate( len( TSTACKTB ) )
	if( tb = NULL ) then
		deallocate( nodetb )
		exit function
	end if

	'' add the ctrl struct to pool list
	if( stk->tbhead = NULL ) then
		stk->tbhead = tb
	end if
	if( stk->tbtail <> NULL ) then
		stk->tbtail->next = tb
	end if
	stk->tbtail = tb

	tb->next = NULL
	tb->nodetb = nodetb
	tb->nodes = nodes

	'' relink
	stk->nodes += nodes

	prev = stk->tos
	node = nodetb
	if( prev <> NULL ) then
		prev->next = node
	end if

	for i = 1 to nodes-1
		node->prev = prev
		node->next = cast( TSTACKNODE ptr, cast( byte ptr, node ) + stk->nodelen)
		prev = node
		node = node->next
	next

	node->prev = prev
	node->next = NULL

	''
	function = TRUE

end function

'':::::
function stackPush _
	( _
		byval stk as TSTACK ptr _
	) as any ptr static

	'' move up
	if( stk->tos = NULL ) then
    	stk->tos = stk->tbhead->nodetb
    else
		'' alloc new node if there are no free nodes
		if( stk->tos->next = NULL ) Then
			hAllocTB( stk, cunsg(stk->nodes) \ 4 )
		end if

		stk->tos = stk->tos->next
	end if

	function = cast( byte ptr, stk->tos ) + len( TSTACKNODE )

end function

'':::::
sub stackPop _
	( _
		byval stk as TSTACK ptr _
	) static

	'' node can contain strings descriptors, so, erase it..
	if( stk->clear ) then
		clear( byval cast(TSTACKNODE ptr, stk->tos) + 1, 0, stk->nodelen - len( TSTACKNODE ) )
	end if

	'' move down
	stk->tos = stk->tos->prev

end sub

'':::::
function stackGetTOS _
	( _
		byval stk as TSTACK ptr _
	) as any ptr

	if( stk->tos = NULL ) then
		return NULL
	else
		return cast( byte ptr, stk->tos ) + len( TSTACKNODE )
	end if

end function

