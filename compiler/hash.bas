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

DefInt a-z
Option Explicit

'$include:'inc\hash.bi'
'$include:'inc\strpool.bi'

Const INVALID = -1
Const TRUE = -1
Const FALSE = 0

declare function 	hashHash	( symbol as string, byval entries as uinteger ) as integer
declare function 	hashNewItem	( e as HASHTB ) as integer
declare sub 		hashDelItem	( byval i as integer, e as HASHTB )


''globals
	Dim shared ctx as HASHCTX
	ReDim shared hitemTB( 0 ) as HASHITEM


'':::::
sub hashRealloc( byval nodes as integer ) static
	dim i as integer
	dim lb as integer, ub as integer

	lb = ctx.nodes
	ub = ctx.nodes + (nodes - 1)

	redim preserve hitemTB( 0 to ub ) as HASHITEM

	For i = lb to ub
		hitemTB(i).prv  = i-1
		hitemTB(i).nxt  = i+1
	Next i

	if( lb = 0 ) then
		hitemTB(lb).prv = INVALID
	end if

	hitemTB(ub).nxt = INVALID

	''
	ctx.fhead 		= lb
	ctx.nodes 		= ctx.nodes + nodes

end sub

'':::::
sub hashInit static

	''
	ctx.fhead = INVALID
	ctx.nodes = 0

	hashRealloc HASH.INITITEMNODES

end sub

'':::::
sub hashNew( hTB() as HASHTB, byval entries as integer ) static
    dim i as integer

	redim hTB( 0 to entries-1 ) as HASHTB

	for i = 0 to entries-1
		hTB(i).items = 0
		hTB(i).head = INVALID
		hTB(i).tail = INVALID
	next i

end sub

''::::::
sub hashFree( hTB() as HASHTB, byval entries as integer ) static
    dim i as integer, n as integer, nn as integer

    for i = 0 to entries-1
		n = hTB(i).head
		do while( n <> INVALID )
			nn = hitemTB(n).nxt

			strpDel hitemTB(n).nameidx
			hashDelItem n, hTB(i)

			n = nn
		loop
	next i

	erase hTB

end sub

'':::::
function hashHash( symbol as string, byval entries as uinteger ) as integer static
	dim index as uinteger
	dim i as integer, c as uinteger
	dim p as ubyte ptr

	index = 0

	p = sadd( symbol )
	for i = 1 to len( symbol )
		index = *p + (index shl 5) - index
		p = p + 1
	next i

	hashHash = index mod entries

end function

''::::::
function hashLookup( symbol as string, hTB() as HASHTB, byval entries as integer ) as integer static
    dim index as integer, n as integer

    hashLookup = INVALID

    index = hashHash( symbol, entries )

	n = hTB(index).head
	if( n = INVALID ) then
		exit function
	end if

	do while( n <> INVALID )
		if( strpGet( hitemTB(n).nameidx ) = symbol ) then
			hashLookup = hitemTB(n).idx
			exit function
		end if
		n = hitemTB(n).nxt
	loop

end function

''::::::
function hashNewItem( e as HASHTB ) as integer static
	Dim i as integer, t as integer

	If( ctx.fhead = INVALID ) Then
		hashRealloc ctx.nodes \ 2
	End If

	'' take from global free list
	i = ctx.fhead
	ctx.fhead = hitemTB(i).nxt

	'' add to entry used list
	t = e.tail
	e.tail = i
	If( t <> INVALID ) Then
		hitemTB(t).nxt = i
	Else
		e.head = i
	End If

	hitemTB(i).prv	= t
	hitemTB(i).nxt	= INVALID

	''
	e.items = e.items + 1

	hashNewItem = i

end function

''::::::
sub hashDelItem( byval i as integer, e as HASHTB ) static
	Dim pn as integer, nn as integer

	if( i = INVALID ) Then
		Exit Sub
	End If

	'' remove from entry used list
	pn = hitemTB(i).prv
	nn = hitemTB(i).nxt
	If( pn <> INVALID ) Then
		hitemTB(pn).nxt = nn
	Else
		e.head = nn
	End If

	If( nn <> INVALID ) Then
		hitemTB(nn).prv = pn
	Else
		e.tail = pn
	End If

	'' add to global free list
	hitemTB(i).nxt = ctx.fhead
	ctx.fhead = i

	''
	e.items = e.items - 1

end sub

''::::::
sub hashAdd( symbol as string, byval idx as integer, byval nameidx as integer, _
			 hTB() as HASHTB, byval entries as integer ) static
    dim index as integer, n as integer

    index = hashHash( symbol, entries )

    n = hashNewItem( hTB(index) )

    if( n = INVALID ) then
    	exit sub
	end if

    hitemTB(n).nameidx = nameidx
    hitemTB(n).idx	= idx

end sub


''::::::
sub hashDel( symbol as string, hTB() as HASHTB, byval entries as integer ) static
    dim index as integer, n as integer

    index = hashHash( symbol, entries )

	n = hTB(index).head
	if( n = INVALID ) then
		exit sub
	end if

	do while( n <> INVALID )
		if( strpGet( hitemTB(n).nameidx ) = symbol ) then
			hashDelItem n, hTB(index)
			exit do
		end if
		n = hitemTB(n).nxt
	loop

end sub


''::::::
sub hashDump( hTB() as HASHTB, byval entries as integer ) static
    dim i as integer, n as integer

    for i = 0 to entries-1
		n = hTB(i).head
		do while( n <> INVALID )
			print strpGet( hitemTB(n).nameidx ); " ";
			n = hitemTB(n).nxt
		loop
	next i

end sub

