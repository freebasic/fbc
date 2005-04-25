
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


'' one-way list, w/o deallocations
''
'' chng: apr/2005 written [v1ctor]
''

defint a-z
option explicit
option escape

'$include once: 'inc\flist.bi'

const NULL = 0

'':::::
function flistNew( byval flist as TFLIST ptr, _
				   byval items as integer, _
				   byval itemlen as integer ) as integer

	flist->totitems	= items
	flist->items 	= items

	function = listNew( @flist->list, items, itemlen, FALSE, FALSE )

	flist->listtb 	= flist->list.tbtail
	flist->index 	= 0
	flist->itemtb	= flist->listtb->nodetb
	flist->lastitem	= NULL

end function

'':::::
function flistFree( byval flist as TFLIST ptr ) as integer

	flist->totitems	= 0
	flist->items	= 0
	flist->index	= 0
	flist->lastitem	= NULL

	function = listFree( @flist->list )

end function

'':::::
function flistNewItem( byval flist as TFLIST ptr ) as any ptr static
    dim as TFLISTITEM ptr item

	'' alloc new item flist if there are no free items
	if( flist->items <= 0 ) Then

		flist->listtb = flist->listtb->nxt

		if( flist->listtb = NULL ) then
			flist->items = flist->totitems \ 2
			flist->totitems += flist->items
			listAllocTB( @flist->list, flist->items, FALSE )
			flist->listtb = flist->list.tbtail
		else
			flist->items = flist->listtb->nodes
		end if

		flist->itemtb = flist->listtb->nodetb
		flist->index = 0
	end if

	''
	item = flist->itemtb + (flist->index * flist->list.nodelen)
	flist->index += 1
	flist->items -= 1

	''
	if( flist->lastitem	<> NULL ) then
		flist->lastitem->nxt = item
	end if

	flist->lastitem	= item
	item->nxt = NULL

	''
	function = item

end function

'':::::
sub flistReset( byval flist as TFLIST ptr ) static

	flist->listtb 	= flist->list.tbhead
	flist->items	= flist->listtb->nodes
	flist->itemtb	= flist->listtb->nodetb
	flist->index	= 0
	flist->lastitem	= NULL

end sub

'':::::
function flistGetHead( byval flist as TFLIST ptr ) as any ptr static

	function = flist->list.tbhead->nodetb

end function


