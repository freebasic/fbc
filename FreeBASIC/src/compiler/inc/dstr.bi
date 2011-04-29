#ifndef __DSTR_BI__
#define __DSTR_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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

declare sub DZstrZero _
	( _
		byref dst as DZSTRING _
	)

declare sub DZstrAllocate _
	( _
		byref dst as DZSTRING, _
		byval chars as integer _
	)

declare sub DZstrReset _
	( _
		byref dst as DZSTRING _
	)

declare sub DZstrAssign _
	( _
		byref dst as DZSTRING, _
		byval src as zstring ptr _
	)

declare sub DZstrAssignW _
	( _
		byref dst as DZSTRING, _
		byval src as wstring ptr _
	)

declare sub DZstrAssignC _
	( _
		byref dst as DZSTRING, _
		byval src as uinteger _
	)

declare sub DZstrConcatAssign _
	( _
		byref dst as DZSTRING, _
		byval src as zstring ptr _
	)

declare sub DZstrConcatAssignW _
	( _
		byref dst as DZSTRING, _
		byval src as wstring ptr _
	)

declare sub DZstrConcatAssignC _
	( _
		byref dst as DZSTRING, _
		byval src as uinteger _
	)

declare sub DWstrZero _
	( _
		byref dst as DWSTRING _
	)

declare sub DWstrAllocate _
	( _
		byref dst as DWSTRING, _
		byval chars as integer _
	)

declare sub DWstrReset _
	( _
		byref dst as DWSTRING _
	)

declare sub DWstrAssign _
	( _
		byref dst as DWSTRING, _
		byval src as wstring ptr _
	)

declare sub DWstrAssignA _
	( _
		byref dst as DWSTRING, _
		byval src as zstring ptr _
	)

declare sub DWstrAssignC _
	( _
		byref dst as DWSTRING, _
		byval src as uinteger _
	)

declare sub DWstrConcatAssign _
	( _
		byref dst as DWSTRING, _
		byval src as wstring ptr _
	)

declare sub DWstrConcatAssignA _
	( _
		byref dst as DWSTRING, _
		byval src as zstring ptr _
	)

declare sub DWstrConcatAssignC _
	( _
		byref dst as DWSTRING, _
		byval src as uinteger _
	)


#endif ''__DSTR_BI__
