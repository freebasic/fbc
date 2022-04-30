#ifndef __LIST_BI__
#define __LIST_BI__

''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2022 The FreeBASIC development team.
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
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.


namespace fb

	type CListCtx as CListCtx_

	type CList

		enum flags
			flags_NONE				= &h00000000
			flags_CLEARNODES		= &h00000001
			flags_LINKFREENODES		= &h00000002
			flags_LINKUSEDNODES		= &h00000004
			flags_NOCLEAR			= flags_LINKFREENODES or flags_LINKUSEDNODES
			flags_ALL 				= &hFFFFFFFF
		end enum

		enum INSERTION_POINT
			insert_first
			insert_last
			insert_before
			insert_after
		end enum
		
		declare constructor _
			( _
				byval nodes as integer, _
				byval nodelen as integer, _
				byval flags as flags = flags_ALL _
			)
		
		declare destructor _
			( _
			) 
		
		declare function insertbefore _
			( _
				byval node as any ptr = 0 _
			) as any ptr

		declare function insertafter _
			( _
				byval node as any ptr = 0 _
			) as any ptr

		declare function insert _
			( _
				byval where as INSERTION_POINT = insert_last, _
				byval node as any ptr = 0 _
			) as any ptr

		declare sub remove	_
			( _
				byval node as any ptr _
			)
		
		declare function getHead _
			( _
			) as any ptr
		
		declare function getTail _
			( _
			) as any ptr
		
		declare function getPrev _	
			( _
				byval node as any ptr _
			) as any ptr
		
		declare function getNext _
			( _
				byval node as any ptr _
			) as any ptr
	
		
		dim ctx as CListCtx ptr
	end type

end namespace

#endif '' __LIST_BI__
