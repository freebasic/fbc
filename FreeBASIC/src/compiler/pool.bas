
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


'' memory pools
''
'' chng: may/2006 written [v1ctor]
''


#include once "inc\pool.bi"

const NULL = 0

const MIN_SIZE = 4

'':::::
function poolNew _
	( _
		byval pool as TPOOL ptr, _
		byval items as integer, _
		byval minlen as integer, _
		byval maxlen as integer _
	) as integer

	dim as integer i, len_

	minlen = (minlen + (MIN_SIZE-1)) and (not (MIN_SIZE-1))
	maxlen = (maxlen + (MIN_SIZE-1)) and (not (MIN_SIZE-1))

	pool->chunks = (maxlen + (minlen-1)) \ minlen
	pool->chunksize = minlen

	pool->chunktb = allocate( len( TLIST ) * pool->chunks )

	len_ = minlen
	for i = 0 to pool->chunks-1
		listNew( @pool->chunktb[i], _
				 items, _
				 len_, _
				 LIST_FLAGS_LINKFREENODES )
		len_ += pool->chunksize
	next

	function = TRUE

end function

'':::::
sub poolFree _
	( _
		byval pool as TPOOL ptr _
	)

	dim as integer i

	for i = 0 to pool->chunks-1
		listFree( @pool->chunktb[i] )
	next

	deallocate( pool->chunktb )

end sub

'':::::
function poolNewItem _
	( _
		byval pool as TPOOL ptr, _
		byval len_ as integer _
	) as any ptr static

    dim as TPOOLITEM ptr item
    dim as integer idx

    if( len_ <= 0 ) then
    	return NULL
    end if

    idx = (len_ - 1) \ pool->chunksize

	if( idx >= pool->chunks ) then
	    item = allocate( len_ + len( TPOOLITEM ) )
	else
		item = listNewNode( @pool->chunktb[idx] )
	end if

	item->idx = idx

	function = cast( byte ptr, item ) + len( TPOOLITEM )

end function

'':::::
sub poolDelItem _
	( _
		byval pool as TPOOL ptr, _
		byval node as any ptr _
	)  static

	dim as TPOOLITEM ptr item

	if( node = NULL ) then
		exit sub
	end if

	item = cast( TPOOLITEM ptr, cast( byte ptr, node ) - len( TPOOLITEM ) )

	if( item->idx >= pool->chunks ) then
		deallocate( item )
	else
		listDelNode( @pool->chunktb[item->idx], item )
	end if

end sub


