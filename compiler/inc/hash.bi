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


Const HASH.INITENTRYNODES%	= 500
Const HASH.INITITEMNODES%	= HASH.INITENTRYNODES*8

Type HASHCTX
	fhead		as integer
	nodes		as integer
End Type

Type HASHTB
	items		as integer
	head		as integer
	tail		as integer
End Type

type HASHITEM
	nameidx		as integer
	idx			as integer

	prv			as integer
	nxt			as integer
end type


declare sub 		hashInit	( )
declare sub 		hashNew		( hTB() as HASHTB, byval entries as integer )
declare sub 		hashFree	( hTB() as HASHTB, byval entries as integer )
declare function 	hashLookup	( symbol as string, hTB() as HASHTB, byval entries as integer ) as integer
declare sub 		hashAdd		( symbol as string, byval idx as integer, byval nameidx as integer, hTB() as HASHTB, byval entries as integer )
declare sub 		hashDel		( symbol as string, hTB() as HASHTB, byval entries as integer )

declare sub 		hashDump	( hTB() as HASHTB, byval entries as integer )
