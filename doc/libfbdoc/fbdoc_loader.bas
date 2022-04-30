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


'' fbdoc_loader - global page loader (from web or cache)
''
''
'' chng: jun/2006 written [coderJeff]
''

#include once "fbdoc_defs.bi"
#include once "CWikiCache.bi"
#include once "fbdoc_cache.bi"
#include once "fbdoc_loader_web.bi"
#include once "fbdoc_loader.bi"

#include once "printlog.bi"

namespace fb.fbdoc

	'':::::
	function LoadPage _
		( _
			byval sPage as zstring ptr, _
			byval bNoReload as integer, _
			byval bCacheFromWeb as integer _
		) as string

		dim as integer bLoadPage = FALSE
		dim as string sBody
		dim as integer RefreshMode 
		dim as CWikiCache ptr wikicache = LocalCache_Get()
		
		function = ""

		if( sPage = NULL ) then
			printlog "Warning: LoadPage was passed NULL"
			return ""
		end if

		if( len(*sPage) = 0) then
			printlog "Warning: LoadPage was passed empty page name"
			return ""
		end if

		RefreshMode = wikicache->GetRefreshMode()

		if( bCacheFromWeb ) then
			bLoadPage = TRUE
		else
			select case RefreshMode 
			case CWikiCache.CACHE_REFRESH_ALL
				bLoadPage = TRUE
			case else
				if( wikicache->LoadPage( sPage, sBody ) ) = FALSE then
					if RefreshMode = CWikiCache.CACHE_REFRESH_NONE then
						return ""
					elseif( bNoReload ) then
						return ""
					end if
					bLoadPage = TRUE
				end if
			end select
		end if

		if( bLoadPage ) then
			dim as CWikiConUrl ptr wikicon = Connection_Create( )
			printlog "Loading '" + *sPage + "'"
			if( wikicon->LoadPage( sPage, sBody ) <> FALSE ) then
				if( wikicon->GetPageID() > 0 ) then
					if( len(sBody) > 0 ) then
						wikicache->SavePage( sPage, sBody )
					end if
				end if
			end if
		end if

		function = sBody

	end function

	function SavePage _
		( _
			byval sPage as zstring ptr, _
			byval sBody as zstring ptr _
		) as integer

		function = FALSE

		if sPage = NULL then
			exit function
		end if

		if sBody = NULL then
			exit function
		end if

		dim as CWikiCache ptr wikicache = LocalCache_Get()

		if( wikicache ) then
			wikicache->SavePage( sPage, sBody )
			function = TRUE
		end if

	end function

end namespace

