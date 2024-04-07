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


'' CRegex - a class wrapper for PCRE (based in the PCRE C++ wrapper)
''
'' chng: apr/2006 written [v1ctor]
''       dec/2006 updated [coderJeff] - using classes
''

#include once "CRegex.bi"

'' from make file, if USE_PCRE_STATIC was defined then define PCRE_STATIC here  
#ifdef USE_PCRE_STATIC
	#ifndef PCRE_STATIC 
		#define PCRE_STATIC 1
	#endif
#endif

#include once "pcre.bi"

namespace fb

	type CRegexCtx_
		as pcre ptr 		reg
		as pcre_extra ptr extra
		as long ptr 		vectb
		as zstring ptr 		subject
		as integer 			sublen
		as integer 			substrcnt
		as zstring ptr ptr	substrlist
	end type

	'':::::
	constructor CRegex _
		( _
			byval pattern as zstring ptr, _
			byval options as REGEX_OPT _
		)
		
		dim as zstring ptr err_msg
		dim as long err_ofs
		
		ctx = new CRegexCtx

		'' Support any CR/LF/CRLF, no matter how libpcre was compiled
		options or= PCRE_NEWLINE_ANYCRLF

		ctx->reg = pcre_compile( pattern, options, @err_msg, @err_ofs, NULL ) 
		ctx->extra = pcre_study( ctx->reg, 0, @err_msg )
		pcre_fullinfo( ctx->reg, ctx->extra, PCRE_INFO_CAPTURECOUNT, @ctx->substrcnt )
		ctx->substrcnt += 1
		ctx->vectb = allocate( sizeof( *ctx->vectb ) * (3 * ctx->substrcnt) )
		ctx->substrlist = NULL
		ctx->subject = NULL
		ctx->sublen = 0
    
	end constructor

	'':::::
	private sub _ClearSubstrlist _
		( _
			byval ctx as CRegexCtx ptr _
		)
		
		if( ctx->substrlist <> NULL ) then
			pcre_free_substring_list( ctx->substrlist )
			ctx->substrlist = NULL
		end if

	end sub

	'':::::
	destructor CRegex _
		( _
		)
		
		if( ctx = NULL ) then
			exit destructor
		end if
		
		_ClearSubstrlist( ctx )
		
		if( ctx->vectb <> NULL ) then
			deallocate( ctx->vectb )
			ctx->vectb = NULL
		end if
		
		if( ctx->extra <> NULL ) then
			pcre_free( ctx->extra )
			ctx->extra = NULL
		end if		
		
		if( ctx->reg <> NULL ) then
			pcre_free( ctx->reg )
			ctx->reg = NULL
		end if		

		delete ctx

	end destructor

	'':::::
	function CRegex.GetMaxMatches _
		( _
		) as integer

		if( ctx = NULL ) then
			return 0
		end if
		
		function = ctx->substrcnt - 1
		
	end function

	'':::::
	function CRegex.Search _
		( _
			byval subject as zstring ptr, _
			byval lgt as integer, _
			byval options as REGEX_OPT _
		) as integer
		
		if( ctx = NULL ) then
			return FALSE
		end if

		_Clearsubstrlist( ctx )
		
		ctx->subject = subject
		ctx->sublen = iif( lgt >= 0, lgt, len( *subject ) )

		'' Support any CR/LF/CRLF, no matter how libpcre was compiled
		options or= PCRE_NEWLINE_ANYCRLF

		function = ( pcre_exec( ctx->reg, ctx->extra, _
								subject, ctx->sublen, _
								0, options, _
								ctx->vectb, 3 * ctx->substrcnt ) > 0 )
		
	end function

	'':::::
	function CRegex.SearchNext _
		( _
			byval options as REGEX_OPT _
		) as integer

		if( ctx = NULL ) then
			return FALSE
		end if

		_Clearsubstrlist( ctx )
         
		'' Support any CR/LF/CRLF, no matter how libpcre was compiled
		options or= PCRE_NEWLINE_ANYCRLF

		function = ( pcre_exec( ctx->reg, ctx->extra, _
								ctx->subject, ctx->sublen, _
								ctx->vectb[1], options, _
								ctx->vectb, 3 * ctx->substrcnt ) > 0 )

	end function

	'':::::
	function CRegex.GetStr _
		( _
			byval i as integer _
		) as zstring ptr
         
		if( i < 0 ) then
			return ctx->subject
		end if

		if( i >= ctx->substrcnt ) then
			return NULL
		end if
         
		if( ctx->substrlist = NULL ) then
			pcre_get_substring_list( ctx->subject, ctx->vectb, ctx->substrcnt, @ctx->substrlist )
		end if
    
		function = ctx->substrlist[i]
    
	end function

	'':::::
	function CRegex.GetOfs _
		( _
			byval i as integer _
		) as integer
         
		if( i < 0 ) then
			return 0
		end if

		if( i >= ctx->substrcnt ) then
			return -1
		end if
		
		function = ctx->vectb[i * 2 + 0]
		
	end function

	'':::::
	function CRegex.GetLen _
		( _
			byval i as integer _
		) as integer
         
		if( i < 0 ) then
			return 0
		end if

		if( i >= ctx->substrcnt ) then
			return -1
		end if
		
		function = ctx->vectb[i * 2 + 1] - ctx->vectb[i * 2 + 0]
		
	end function

end namespace
