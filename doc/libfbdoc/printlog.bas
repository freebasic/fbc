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


'' printlog
''
''
'' chng: sep/2007 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "printlog.bi"

namespace fb.fbdoc

	dim shared as PRINTLOGFUNCTION _customfunc = NULL

	private function _defaultfunc( byval text as zstring ptr, byval bNoCR as integer ) as integer
		if( bNoCR ) then
			print *text;
		else
			print *text
		end if
		return TRUE
	end function

	function PrintLog( byval text as zstring ptr, byval bNoCR as integer ) as integer
		if( _customfunc ) then
			return _customfunc(text, bNoCR)
		else
			return _defaultfunc(text, bNoCR)
		end if
	end function

	function GetPrintLogFunction() as PRINTLOGFUNCTION
		return _customfunc
	end function

	function SetPrintLogFunction( byval newfunc as PRINTLOGFUNCTION ) as PRINTLOGFUNCTION
		dim ret as PRINTLOGFUNCTION = _customfunc
		_customfunc = newfunc
		return ret
	end function


end namespace
