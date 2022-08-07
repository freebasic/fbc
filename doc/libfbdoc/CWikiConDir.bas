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


'' CWikiConDir
''
'' chng: may/2019 written [coderJeff]
''

#include once "CWikiConDir.bi"
#include once "fbdoc_string.bi"
#include once "file.bi"
#include "crt/stdlib.bi"
#include "crt/string.bi"

#ifdef __FB_LINUX__
extern "c"
	declare function strcasecmp(byval as const zstring ptr, byval as const zstring ptr) as long
end extern
#define _stricmp strcasecmp
#endif

namespace fb.fbdoc

	type CWikiConDirCtx_
		as zstring ptr      path
		as zstring ptr      pagename
		as integer          pageid
	end type

	const cache_ext = ".wakka"

	'':::::
	constructor CWikiConDir _
		( _
			byval path as zstring ptr _
		)

		ctx = new CWikiConDirCtx
		ZSet @ctx->path, path
		ctx->pagename = NULL
		ctx->pageid = -1

	end constructor

	'':::::
	destructor CWikiConDir _
		( _
		)

		if( ctx = NULL ) then
			exit destructor
		end if
		ZFree @ctx->path
		ZFree @ctx->pagename
		delete ctx

	end destructor

	'':::::
	function CWikiConDir.LoadPage _
		( _
			byval pagename as zstring ptr, _
			byref body as string _
		) as boolean

		dim sLocalFile as string
		dim h as integer

		function = FALSE
		body = ""

		if( ctx = NULL ) then
			exit function
		end if

		ZSet @ctx->pagename, pagename
		ctx->pageid = -1

		sLocalFile = *ctx->path & *ctx->pagename & cache_ext

		if( fileexists( sLocalFile ) ) then
			h = freefile
			if( open( sLocalFile for binary as #h) = 0 ) then
				if( lof(h) > 0 ) then
					body = space( lof(	h ) )
					get #h,,body
				end if
				close #h
				function = TRUE
			end if
		end if

	end function

	''
	function cmpPageName cdecl ( byval x as const any ptr, byval y as const any ptr ) as long
		function = _stricmp( *cast(zstring ptr ptr,x), *cast(zstring ptr ptr,y) )
	end function

	'':::::
	private sub scan_cache_dir _
		( _
			byval path as zstring ptr, _
			byref body as string _
		)

		dim as integer pagecount = 0
		dim as string d, lst
		
		d = dir( *path & "*.wakka" )
		while( d > "" )
			dim as integer i = instrrev( d, "." )
			if( i > 0 ) then
				d = left( d, i-1 )
				if( len(d) > 0 ) then
					pagecount += 1
					lst &= chr(0) & d
				end if
			end if
			d = dir( )
		wend

		if( pagecount > 0 ) then
			dim as zstring ptr zpage( 1 to pagecount )
			dim as integer index = 1
			for i as integer = 1 to len( lst )
				if( lst[i] = 0 ) then
					zpage(index) = @(lst[i+1])
					index += 1
				end if
			next

			'' Sort
			qsort( @zpage(1), pagecount, sizeof(zstring ptr), procptr(cmpPageName) )

			for i as integer = 1 to pagecount
				body &= *zpage(i) & nl
			next

		else
			body = ""

		end if

	end sub

	'':::::
	function CWikiConDir.LoadIndex _
		( _
			byval page as zstring ptr, _
			byref body as string, _
			byval format as CWikiCon.IndexFormat _
		) as boolean

		function = FALSE
		body = ""

		if( ctx = NULL ) then
			exit function
		end if

		if( ctx->path = NULL ) then
			exit function
		end if

		ctx->pageid = -1
		ZSet @ctx->pagename, page

		'' !!! TODO : how can we put / get revision for tracking?

		scan_cache_dir( *ctx->path, body )

		function = TRUE

	end function

	'':::::
	function CWikiConDir.StorePage _
		( _
			byval body as zstring ptr, _
			byval note as zstring ptr _
		) as boolean

		if( ctx = NULL ) then
			return FALSE
		end if

		if( body = NULL ) then
			return FALSE
		end if

		if( len(*body) = 0) then
			return FALSE
		endif

		if( ctx->pagename = NULL ) then
			return FALSE
		end if

		dim as integer h
		dim as string sLocalFile

		function = FALSE

		sLocalFile = *ctx->path + *ctx->pagename + cache_ext

		if( fileexists( sLocalFile ) ) then
			kill sLocalFile
		end if

		h = freefile
		if( open(sLocalFile for binary as #h) = 0 ) then
			put #h,,*body, len(*body)
			close #h
			function = TRUE
		end if
		
	end function

	'':::::
	function CWikiConDir.StoreNewPage _
		( _
			byval body as zstring ptr, _
			byval pagename as zstring ptr _
		) as boolean

		if( ctx = NULL ) then
			return FALSE
		end if

		ZSet @ctx->pagename, pagename

		return StorePage( body, NULL )
		
	end function

	'':::::
	function CWikiConDir.GetPageID _
		( _
		) as integer

		if( ctx = NULL ) then
			return 0
		end if

		return ctx->pageid

	end function

end namespace
