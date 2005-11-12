#ifndef __DSTR_BI__
#define __DSTR_BI__

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



#define DECL_STRTYPE(_name,_type)		_
	type _name                          :_
		data		as _type ptr        :_
		len			as integer          :_
		size		as integer          :_
	end type

DECL_STRTYPE( DSTRING, any )
DECL_STRTYPE( DZSTRING, zstring )
DECL_STRTYPE( DWSTRING, wstring )


declare sub 	DZstrZero 						( byref dst as DZSTRING )

declare sub 	DZstrAllocate					( byref dst as DZSTRING, _
				 								  byval chars as integer )

declare sub 	DZstrAssign 					( byref dst as DZSTRING, _
				  								  byval src as zstring ptr )

declare sub 	DZstrAssignW 					( byref dst as DZSTRING, _
				   								  byval src as wstring ptr )

declare sub 	DZstrConcatAssign 				( byref dst as DZSTRING, _
												  byval src as zstring ptr )

declare sub 	DZstrConcatAssignW 				( byref dst as DZSTRING, _
						 						  byval src as wstring ptr )


declare sub 	DWstrZero 						( byref dst as DWSTRING )

declare sub 	DWstrAllocate					( byref dst as DWSTRING, _
				 								  byval chars as integer )

declare sub 	DWstrAssign 					( byref dst as DWSTRING, _
				  								  byval src as wstring ptr )

declare sub 	DWstrAssignA 					( byref dst as DWSTRING, _
				   								  byval src as zstring ptr )

declare sub 	DWstrConcatAssign 				( byref dst as DWSTRING, _
												  byval src as wstring ptr )

declare sub 	DWstrConcatAssignA 				( byref dst as DWSTRING, _
						 						  byval src as zstring ptr )

#endif ''__DSTR_BI__
