#ifndef __POOL_BI__
#define __POOL_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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

#include once "list.bi"

type TPOOLITEM
	idx			as integer
end type

type TPOOL
	chunks		as integer
	chunksize   as integer
	chunkTb		as TLIST ptr
end type

declare function poolNew _
	( _
		byval pool as TPOOL ptr, _
		byval items as integer, _
		byval minlen as integer, _
		byval maxlen as integer _
	) as integer


declare sub poolFree _
	( _
		byval pool as TPOOL ptr _
	)

declare function poolNewItem _
	( _
		byval pool as TPOOL ptr, _
		byval len_ as integer _
	) as any ptr

declare sub poolDelItem _
	( _
		byval pool as TPOOL ptr, _
		byval node as any ptr _
	)


#endif '' __POOL_BI__
