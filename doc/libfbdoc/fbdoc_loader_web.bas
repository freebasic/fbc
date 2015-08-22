''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006-2008 The FreeBASIC development team.
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


'' fbdoc_loader_web
''
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "CWikiCon.bi"

namespace fb.fbdoc

	dim shared as CWikiCon ptr wikicon
	dim shared as string wiki_url

	'' --------------------------------------------------------------------------
	'' Wiki Connection and Page Loader
	'' --------------------------------------------------------------------------

	'':::::
	sub Connection_SetUrl( byval url as zstring ptr )
		wiki_url = *url
	end sub

	'':::::
	function Connection_Create( ) as CWikiCon Ptr
		if( wikicon <> NULL ) then
			return wikicon
		end if
		
		wikicon = new CWikiCon( wiki_url )

		return wikicon
		
	end function

	'':::::
	sub Connection_Destroy( )
		if( wikicon = NULL ) then
			exit sub
		end if
		
		delete wikicon
		wikicon = NULL
		
	end sub

end namespace
