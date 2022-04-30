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


'' CWikiCache - Save/Load raw wiki pages to/from a local dir
''
'' chng: may/2006 written [coderJeff]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "fbdoc_defs.bi"
#include once "fbdoc_string.bi"
#include once "CWikiCache.bi"
#include once "file.bi"

namespace fb.fbdoc

	type CWikiCacheCtx_
		as zstring ptr localdir = 0
		as integer RefreshMode = 0
	end type

	const cache_ext = ".wakka"

	'':::::
	constructor CWikiCache _
		( _
			byval localdir as zstring ptr, _
			byval RefreshMode as integer _
		)

		ctx = new CWikiCacheCtx
		ctx->localdir = NULL
		ZSet @ctx->localdir, localdir
		ctx->RefreshMode = RefreshMode

	end constructor

	'':::::
	destructor CWikiCache _
		( _
		)
		
		ZFree @ctx->localdir
		delete ctx
		
	end destructor

	'':::::
	function CWikiCache.LoadPage _
		( _
			byval sPage as zstring ptr, _
			byref sBody as string _
		) as integer

		if( ctx = NULL ) then
			return FALSE
		end if

		if( sPage = NULL ) then
			return FALSE
		end if

		if( len(*sPage) = 0) then
			return FALSE
		endif

		dim as integer h
		dim as string sLocalFile

		function = FALSE
		sBody = ""

		sLocalFile = *ctx->localdir + *sPage + cache_ext

		if( fileexists( sLocalFile ) ) then
			h = freefile
			if( open( sLocalFile for binary as #h) = 0 ) then
				if( lof(h) > 0 ) then
					sBody = space( lof(	h ) )
					get #h,,sBody
				end if
				close #h
				function = TRUE
			end if
		end if

	end function

	'':::::
	function CWikiCache.SavePage _
		( _
			byval sPage as zstring ptr, _
			byval sBody as zstring ptr _
		) as integer

		if( ctx = NULL ) then
			return FALSE
		end if

		if( sPage = NULL ) then
			return FALSE
		end if

		if( len(*sPage) = 0) then
			return FALSE
		endif

		dim as integer h
		dim as string sLocalFile

		function = FALSE

		sLocalFile = *ctx->localdir + *sPage + cache_ext

		if( fileexists( sLocalFile ) ) then
			kill sLocalFile
		end if

		h = freefile
		if( open(sLocalFile for binary as #h) = 0 ) then
			put #h,,*sBody, len(*sBody)
			close #h
			function = TRUE
		end if

	end function

	'':::::
	function CWikiCache.GetRefreshMode _
		( _
		) as integer

		if( ctx = NULL ) then
			return FALSE
		end if

		function = ctx->RefreshMode

	end function

	'':::::
	function CWikiCache.SetRefreshMode _
		( _
			byval RefreshMode as integer _
		) as integer

		if( ctx = NULL ) then
			return FALSE
		end if

		ctx->RefreshMode = RefreshMode
		
	end function

end namespace
