#ifndef __FLIST_BI__
#define __FLIST_BI__

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


'$include once: 'inc\list.bi'

type TFLISTITEM
	nxt			as TFLISTITEM ptr
	'' ...
end type

type TFLIST
	totitems	as integer
	items		as integer
	itemtb		as TFLISTITEM ptr
	index		as integer
	lastitem	as TFLISTITEM ptr
	list		as TLIST
	listtb 		as TLISTTB ptr
end type

declare function flistNew		( byval flist as TFLIST ptr, _
								  byval items as integer, _
								  byval itemlen as integer ) as integer

declare function flistFree		( byval flist as TFLIST ptr ) as integer

declare function flistNewItem	( byval flist as TFLIST ptr ) as any ptr

declare function flistGetHead	( byval flist as TFLIST ptr ) as any ptr

declare sub flistReset			( byval flist as TFLIST ptr )

#endif '' __FLIST_BI__
