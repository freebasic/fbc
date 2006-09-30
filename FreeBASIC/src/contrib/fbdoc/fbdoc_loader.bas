''  fbdoc - FreeBASIC User's Manual Converter/Generator
''	Copyright (C) 2006 Jeffery R. Marshall (coder[at]execulink.com) and
''  the FreeBASIC development team.
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


'' fbdoc_loader - global pseudo classes for wiki
''              - includes connection, cache, and parser
''
''
'' chng: jun/2006 written [coderJeff]
''

#include once "common.bi"
#include once "CWikiCache.bi"
#include once "fbdoc_cache.bi"
#include once "fbdoc_loader_web.bi"
#include once "fbdoc_loader.bi"

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
		? "Warning: LoadPage was passed NULL"
		return ""
	end if

	if( len(*sPage) = 0) then
		? "Warning: LoadPage was passed empty page name"
		return ""
	end if

	RefreshMode = CWikiCache_GetRefreshMode( wikicache )

	if( bCacheFromWeb ) then
		bLoadPage = TRUE
	else
		select case RefreshMode 
		case CACHE_REFRESH_ALL
			bLoadPage = TRUE
		case else
			if( CWikiCache_LoadPage( wikicache, sPage, sBody ) ) = FALSE then
				if RefreshMode = CACHE_REFRESH_NONE then
					return ""
				elseif( bNoReload = TRUE ) then
					return ""
				end if
				bLoadPage = TRUE
			end if
		end select
	end if

	if bLoadPage = TRUE then
		dim as CWikiCon ptr wikicon = Connection_Create( )
		? "Loading '" + *sPage + "'"
		if( CWikiCon_LoadPage( wikicon, sPage, TRUE, TRUE, sBody ) <> FALSE ) then
			if( CWikiCon_GetPageID( wikicon ) > 0 ) then
				if( len(sBody) > 0 ) then
					CWikiCache_SavePage( wikicache, sPage, sBody )
				end if
			end if
		end if
	end if

	function = sBody

end function


