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


'' string pool
''
''

option explicit

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'

type STRPCTX
	inited	as integer
	nodes	as integer
	idx		as integer
end type

''globals
	dim shared ctx as STRPCTX

	redim shared strPool( 0 ) as string

'':::::
sub strpRealloc( byval nodes as integer ) static
	dim lb as integer, ub as integer

	lb = ctx.nodes
	ub = ctx.nodes + (nodes - 1)

	redim preserve strPool( 0 to ub ) as string

	''
	ctx.nodes = ctx.nodes + nodes

end sub

'':::::
sub strpInit static

	if( ctx.inited ) then
		exit sub
	end if

	''
	ctx.nodes	= 0
	ctx.idx 	= 0
	ctx.inited 	= TRUE

	strpRealloc STRP.INITSTRINGNODES

end sub

'':::::
sub strpEnd static
    dim i as integer

	if( not ctx.inited ) then
		exit sub
	end if

	for i = 0 to ctx.idx-1
		strpDel i
	next i

	erase strPool

	ctx.nodes 	= 0
	ctx.idx 	= 0
	ctx.inited 	= FALSE

end sub


'':::::
function strpNew as integer static
    dim i as integer

	if( ctx.idx >= ctx.nodes ) then
		strpRealloc ctx.nodes \ 2
	end if

	strpNew = ctx.idx

	''
	ctx.idx = ctx.idx + 1

end function

'':::::
function strpAdd( s as string ) as integer static
    dim i as integer

    i = strpNew
    strpAdd = i

    if( i = INVALID ) then
    	exit function
    end if

    strPool(i) = s

end function

'':::::
sub strpDel	( byval i as integer ) static

    if( i = INVALID ) then
    	exit sub
    end if

	strPool(i) = ""

	'' can't return string i to pool

end sub

'':::::
function strpGet( byval i as integer ) as string static

    if( i = INVALID ) then
    	strpGet = ""
    	exit function
    end if

	strpGet = strPool(i)

end function

'':::::
sub strpDump
	dim i as integer

	for i = 0 to ctx.nodes-1
		if( len( strPool(i) ) > 0 ) then
			print i; "<"; strPool(i); ">"
		end if
	next i

	print

end sub
