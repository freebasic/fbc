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
'' obs: uses the string pool to not duplicate the symbol table string names
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 updated to use real linked-lists [v1ctor]

DefInt a-z
Option Explicit

'$include:'inc\hash.bi'
'$include:'inc\list.bi'
'$include:'inc\strpool.bi'

Const INVALID = -1
Const TRUE = -1
Const FALSE = 0
Const NULL = 0

Type HASHCTX
	itemlist    as TLIST
End Type


declare function 	hashHash	( symbol as string, byval nodes as uinteger ) as integer

declare function 	hashNewItem	( byval list as HASHLIST ptr ) as HASHITEM ptr
declare sub 		hashDelItem	( byval list as HASHLIST ptr, byval item as HASHITEM ptr )

''globals
	Dim shared ctx as HASHCTX


'':::::
sub hashInit static

	'' allocate the initial item list pool
	listNew( @ctx.itemlist, HASH.INITITEMNODES, len( HASHITEM ) )

end sub

'':::::
sub hashNew( hash as THASH, byval nodes as integer ) static
    dim i as integer
    dim list as HASHLIST ptr

	'' allocate a fixed list of internal linked-lists
	hash.list = callocate( nodes * len( HASHLIST ) )
	hash.nodes = nodes

	'' initialize the list
	list = hash.list
	for i = 0 to nodes-1
		list->head = NULL
		list->tail = NULL
		list = list + len( HASHLIST )
	next i

end sub

''::::::
sub hashFree( hash as THASH ) static
    dim i as integer
    dim item as HASHITEM ptr, nxt as HASHITEM ptr
    dim list as HASHLIST ptr

    '' for each item on each list, deallocate it and the string from the pool
    list = hash.list
    for i = 0 to hash.nodes-1
		item = list->head
		do while( item <> NULL )
			nxt = item->r

			strpDel item->nameidx
			hashDelItem list, item

			item = nxt
		loop
		list = list + len( HASHLIST )
	next i

	deallocate hash.list

end sub

'':::::
function hashHash( symbol as string, byval nodes as uinteger ) as integer static
	dim index as uinteger
	dim i as integer, c as uinteger
	dim p as ubyte ptr

	index = 0

	p = sadd( symbol )
	for i = 1 to len( symbol )
		index = *p + (index shl 5) - index
		p = p + 1
	next i

	hashHash = index mod nodes

end function

''::::::
function hashLookup( hash as THASH, symbol as string ) as any ptr static
    dim index as integer
    dim item as HASHITEM ptr
    dim list as HASHLIST ptr

    hashLookup = NULL

    '' calc hash
    index = hashHash( symbol, hash.nodes )

	'' get the start of list
	list = hash.list + (index * len( HASHLIST ))
	item = list->head
	if( item = NULL ) then
		exit function
	end if

	'' loop until end of list or if item was found
	do while( item <> NULL )
		if( strpGet( item->nameidx ) = symbol ) then
			hashLookup = item->idx
			exit function
		end if
		item = item->r
	loop

end function

''::::::
private function hashNewItem( byval list as HASHLIST ptr ) as HASHITEM ptr static
	Dim item as HASHITEM ptr

	'' add a new node
	item = listNewNode( @ctx.itemlist )

	'' add it to the internal linked-list
	If( list->tail <> NULL ) Then
		list->tail->r = item
	Else
		list->head = item
	End If

	item->l	= list->tail
	item->r	= NULL

	list->tail = item

	hashNewItem = item

end function

''::::::
private sub hashDelItem( byval list as HASHLIST ptr, byval item as HASHITEM ptr ) static
	Dim prv as HASHITEM ptr, nxt as HASHITEM ptr

	''
	if( item = NULL ) Then
		Exit Sub
	End If

	'' remove from internal linked-list
	prv  = item->l
	nxt  = item->r
	If( prv <> NULL ) Then
		prv->r = nxt
	Else
		list->head = nxt
	End If

	If( nxt <> NULL ) Then
		nxt->l = prv
	Else
		list->tail = prv
	End If

	'' remove node
	listDelNode @ctx.itemlist, item

end sub

''::::::
sub hashAdd( hash as THASH, symbol as string, byval idx as any ptr, byval nameidx as integer ) static
    dim index as integer
    dim item as HASHITEM ptr

    '' calc hash
    index = hashHash( symbol, hash.nodes )

    '' allocate a new node
    item = hashNewItem( hash.list + (index * len( HASHLIST )) )
    if( item = NULL ) then
    	exit sub
	end if

    '' fill node
    item->nameidx = nameidx
    item->idx	  = idx

end sub

''::::::
sub hashDel( hash as THASH, symbol as string ) static
    dim index as integer
    dim item as HASHITEM ptr
    dim list as HASHLIST ptr

    '' calc hash
    index = hashHash( symbol, hash.nodes )

	'' get start of list
	list = hash.list + (index * len( HASHLIST ))

	item = list->head
	if( item = NULL ) then
		exit sub
	end if

	'' loop until item is found or if list ended
	do while( item <> NULL )
		if( strpGet( item->nameidx ) = symbol ) then
			hashDelItem list, item
			exit do
		end if
		item = item->r
	loop

end sub


''::::::
sub hashDump( hash as THASH ) static
    dim i as integer
    dim item as HASHITEM ptr
    dim list as HASHLIST ptr

    list = hash.list
    for i = 0 to hash.nodes-1
		item = list->head
		do while( item <> NULL )
			print strpGet( item->nameidx ); " ";
			item = item->r
		loop
		list = list + len( HASHLIST )
	next i

end sub

