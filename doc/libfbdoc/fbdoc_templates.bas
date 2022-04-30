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


'' fbdoc_templates - global pseudo class for template loading
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "fbdoc_templates.bi"
#include once "COptions.bi"

namespace fb.fbdoc

	dim shared as COptions ptr temp

	'':::::
	private sub _Create( ) constructor
		if( temp <> NULL ) then
			exit sub
		end if
		
		temp = new COptions
		
	end sub

	'':::::
	private sub _Destroy( ) destructor
		if( temp = NULL ) then
			exit sub
		end if
		
		delete temp
		temp = NULL
		
	end sub

	'':::::
	sub Templates.Clear _
		( _
		)
		
		_Create()
		temp->Clear()

	end sub

	'':::::
	function Templates.Set _
		( _
			byval sKey as zstring ptr, _
			byval sValue as zstring ptr _
		) as integer

		_Create()
		if( temp->Set( sKey, sValue ) ) then
			return TRUE
		end if
		return FALSE

	end function

	function Templates.LoadFile _
		( _
			byval sKey as zstring ptr, _
			byval sFileName as zstring ptr _
		) as integer

		dim x as string

		x = LoadFileAsString( sFileName )
		
		_Create()
		
		if( temp->Set( sKey, x ) ) then
			return TRUE
		end if
		
		return FALSE
			
	end function

	function Templates.Get _
		( _
			byval sKey as zstring ptr _
		) as string

		return temp->Get( sKey )

	end function

end namespace
