#ifndef __LIST_BI__
#define __LIST_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

namespace fb.list

	enum flags
		flags_NONE				= &h00000000
		flags_CLEARNODES		= &h00000001
		flags_LINKFREENODES		= &h00000002
		flags_LINKUSEDNODES		= &h00000004
		flags_NOCLEAR			= flags_LINKFREENODES or flags_LINKUSEDNODES
		flags_ALL 				= &hFFFFFFFF
	end enum
	
	type CList as CList_
	
	declare function new _
		( _
			byval nodes as integer, _
			byval nodelen as integer, _
			byval flags as flags = flags_ALL _
		) as CList ptr
	
	declare function delete _
		( _
			byval _this as CList ptr _
		) as integer
	
	declare function insert _
		( _
			byval _this as CList ptr _
		) as any ptr
	
	declare sub remove	_
		( _
			byval _this as CList ptr, _
			byval node as any ptr _
		)
	
	declare function getHead _
		( _
			byval _this as CList ptr _
		) as any ptr
	
	declare function getTail _
		( _
			byval _this as CList ptr _
		) as any ptr
	
	declare function getPrev _	
		( _
			byval node as any ptr _
		) as any ptr
	
	declare function getNext _
		( _
			byval node as any ptr _
		) as any ptr

end namespace

#endif '' __LIST_BI__
