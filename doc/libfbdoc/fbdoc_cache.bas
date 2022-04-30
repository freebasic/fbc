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


'' fbdoc_cache  - global pseudo class for local cache
''
''
'' chng: sep/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "CWikiCache.bi"
#include once "fbdoc_cache.bi"

namespace fb.fbdoc

	dim shared as CWikiCache ptr wikicache

	'':::::
	function LocalCache_Create _
		( _
			byval sLocalDir as zstring ptr, _
			byval bRefresh as integer _
		) as integer

		if( wikicache <> NULL ) then
			return TRUE
		end if

		wikicache = new CWikiCache( sLocalDir, bRefresh )
		
		if( wikicache = NULL ) then
			return FALSE
		end if

		function = TRUE
	end function

	'':::::
	sub LocalCache_Destroy( )

		if( wikicache = NULL ) then
			exit sub
		end if
		
		delete wikicache
		wikicache = NULL

	end sub

	'':::::
	function LocalCache_Get( ) as CWikiCache ptr
		return wikicache
	end function

end namespace


