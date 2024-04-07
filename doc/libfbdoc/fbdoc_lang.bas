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


'' fbdoc_lang
''
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_lang.bi"
#include once "COptions.bi"


namespace fb.fbdoc

	dim shared as COptions ptr _lang = NULL

	'':::::
	private sub _Create( ) constructor

		if( _lang <> NULL ) then
			exit sub
		end if

		_lang = new COptions

	end sub

	'':::::
	private sub _Destroy( ) destructor
		if( _lang = NULL ) then
			exit sub
		end if
		
		delete _lang
		_lang = NULL
		
	end sub

	'':::::
	function Lang.Initialized _
		( _
		) as integer

		function = ( _lang <> NULL )

	end function

	'':::::
	function Lang.LoadOptions _
		( _
			byval sFileName as zstring ptr, _
			byval bNoReset as integer _
		) as integer

		_Create

		if( _lang = NULL ) then
			return FALSE
		end if
			
		if( bNoReset = FALSE ) then
			_lang->Clear()
		end if

		function = _lang->ReadFromFile( sFileName )

	end function

	'':::::
	function Lang.GetOption _
		( _
			byval sKey as zstring ptr, _
			byval sDefault as zstring ptr _
		) as string

		if( _lang = NULL ) then
			return ""
		end if
		
		function = _lang->Get( sKey, sDefault )

	end function

	'':::::
	sub Lang.SetOption _
		( _
			byval sKey as zstring ptr, _
			byval sValue as zstring ptr _
		)

		if( _lang = NULL ) then
			exit sub
		end if
		
		_lang->Set( sKey, sValue )

	end sub

	'':::::
	function Lang.ExpandString _
		( _
			byval sText as zstring  ptr _
		) as string

		return _lang->ExpandString( sText )

	end function

end namespace
