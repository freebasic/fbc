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


'' generic hash tables
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 updated to use real linked-lists [v1ctor]

defint a-z
option explicit
option escape

const NULL = 0

#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\hlp.bi"

type HASHCTX
	itemlist    as TLIST
end type


declare function 	hashNewItem	( byval list as HASHLIST ptr ) as HASHITEM ptr
declare sub 		hashDelItem	( byval list as HASHLIST ptr, _
								  byval item as HASHITEM ptr )

''globals
	dim shared ctx as HASHCTX


'':::::
sub hashInit static

	'' allocate the initial item list pool
	listNew( @ctx.itemlist, HASH_INITITEMNODES, len( HASHITEM ), FALSE )

end sub

'':::::
sub hashNew( byval hash as THASH ptr, _
			 byval nodes as integer ) static
    dim as integer i
    dim as HASHLIST ptr list

	'' allocate a fixed list of internal linked-lists
	hash->list = callocate( nodes * len( HASHLIST ) )
	hash->nodes = nodes

	'' initialize the list
	list = hash->list
	for i = 0 to nodes-1
		list->head = NULL
		list->tail = NULL
		list += 1
	next i

end sub

''::::::
sub hashFree( byval hash as THASH ptr ) static
    dim as integer i
    dim as HASHITEM ptr item, nxt
    dim as HASHLIST ptr list

    '' for each item on each list, deallocate it and the name string
    list = hash->list
    for i = 0 to hash->nodes-1
		item = list->head
		do while( item <> NULL )
			nxt = item->r

			item->name = ""
			hashDelItem( list, item )

			item = nxt
		loop
		list += 1
	next i

	deallocate( hash->list )

end sub

'':::::
function hashHash( byval symbol as string ) as uinteger static
	dim as uinteger index
	dim as integer i

	index = 0

	for i = 0 to len( symbol )-1
		index = symbol[i] + (index shl 5) - index
	next

	function = index

end function

''::::::
function hashLookupEx( byval hash as THASH ptr, _
					   byval symbol as string, _
					   byval index as uinteger ) as any ptr static
    dim as HASHITEM ptr item
    dim as HASHLIST ptr list

    function = NULL

    index = index mod hash->nodes

	'' get the start of list
	list = @hash->list[index]
	item = list->head
	if( item = NULL ) then
		exit function
	end if

	'' loop until end of list or if item was found
	do while( item <> NULL )
		if( item->name = symbol ) then
			return item->idx
		end if
		item = item->r
	loop

end function

''::::::
function hashLookup( byval hash as THASH ptr, _
					 byval symbol as string ) as any ptr static

    function = hashLookupEx( hash, symbol, hashHash( symbol ) )

end function

''::::::
private function hashNewItem( byval list as HASHLIST ptr ) as HASHITEM ptr static
	dim as HASHITEM ptr item

	'' add a new node
	item = listNewNode( @ctx.itemlist )

	'' add it to the internal linked-list
	if( list->tail <> NULL ) then
		list->tail->r = item
	else
		list->head = item
	end if

	item->l	= list->tail
	item->r	= NULL

	list->tail = item

	function = item

end function

''::::::
private sub hashDelItem( byval list as HASHLIST ptr, _
						 byval item as HASHITEM ptr ) static
	dim as HASHITEM ptr prv, nxt

	''
	if( item = NULL ) Then
		exit sub
	end If

	'' remove from internal linked-list
	prv  = item->l
	nxt  = item->r
	if( prv <> NULL ) then
		prv->r = nxt
	else
		list->head = nxt
	end If

	if( nxt <> NULL ) then
		nxt->l = prv
	else
		list->tail = prv
	end if

	'' remove node
	listDelNode( @ctx.itemlist, cptr( TLISTNODE ptr, item ) )

end sub

''::::::
function hashAdd( byval hash as THASH ptr, _
				  byval symbol as string, _
				  byval idx as any ptr, _
			 	  index as uinteger ) as HASHITEM ptr static
    dim as HASHITEM ptr item

    '' calc hash
    index = hashHash( symbol ) mod hash->nodes

    '' allocate a new node
    item = hashNewItem( @hash->list[index] )

    function = item
    if( item = NULL ) then
    	exit function
	end if

    '' fill node
    ZEROSTRDESC( item->name )
    item->name 	  = symbol
    item->idx	  = idx

end function

''::::::
sub hashDel( byval hash as THASH ptr, _
			 byval item as HASHITEM ptr, _
			 byval index as uinteger ) static
    dim as HASHLIST ptr list

	if( item = NULL ) then
		exit sub
	end if

	'' get start of list
	list = @hash->list[index]

	''
	item->name = ""
	item->idx  = NULL

	hashDelItem( list, item )

end sub

