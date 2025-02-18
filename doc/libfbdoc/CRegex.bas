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

#define PCRE2_CODE_UNIT_WIDTH 8
#include once "pcre2.bi"

namespace fb

	type CRegexCtx_
		as pcre2_code ptr		code
		as pcre2_compile_context ptr ccontext
		as pcre2_match_data ptr	matchdata
		as PCRE2_SIZE ptr 		ovector
		as zstring ptr 			subject
		as integer 				sublen
		as PCRE2_SIZE 			substrcnt
		as zstring ptr ptr		substrlist
	end type

	'':::::
	constructor CRegex _
		( _
			byval pattern as zstring ptr, _
			byval options as REGEX_OPT _
		)
		
		dim as ulong errorflag
		dim as integer erroffset

		ctx = new CRegexCtx

		'' Support any CR/LF/CRLF line ending
		ctx->ccontext = pcre2_compile_context_create( NULL )
		pcre2_set_newline(ctx->ccontext, PCRE2_NEWLINE_ANYCRLF)

		ctx->code = pcre2_compile( pattern, PCRE2_ZERO_TERMINATED, _
					options, @errorflag, @erroffset, ctx->ccontext )
		ctx->matchdata = pcre2_match_data_create_from_pattern(ctx->code, NULL)

		ctx->substrlist = NULL
		ctx->substrcnt = NULL
		ctx->subject = NULL
		ctx->ovector = NULL
		ctx->sublen = 0
    
	end constructor

	'':::::
	private sub _ClearSubstrlist _
		( _
			byval ctx as CRegexCtx ptr _
		)
		
		if( ctx->substrlist <> NULL ) then
			pcre2_substring_list_free ( ctx->substrlist )
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
		
		if( ctx->matchdata <> NULL ) then
			pcre2_match_data_free(ctx->matchdata)
			ctx->matchdata = NULL
		end if
		if( ctx->code <> NULL ) then
			pcre2_code_free(ctx->code)
			ctx->code = NULL
		end if
		if( ctx->ccontext <> NULL ) then
			pcre2_compile_context_free( ctx->ccontext )
			ctx->ccontext = NULL
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


		if( ctx = NULL or ctx->code = NULL ) then
			return FALSE
		end if

		_Clearsubstrlist( ctx )

		ctx->subject = subject
		ctx->sublen = iif( lgt >= 0, lgt, len( *subject ) )

		Dim as Integer rc
		rc = pcre2_match(ctx->code, ctx->subject, _
					PCRE2_ZERO_TERMINATED, 0, options, _
					ctx->matchdata, NULL)
		if rc < 0 then
			return FALSE
		end if
		ctx->substrcnt = rc
		ctx->ovector = pcre2_get_ovector_pointer(ctx->matchdata)

		function = TRUE
	end function

	'':::::
	function CRegex.SearchNext _
		( _
			byval options as REGEX_OPT _
		) as integer

		if( ctx = NULL or ctx->code = NULL or ctx->ovector = NULL ) then
			return FALSE
		end if

		_Clearsubstrlist( ctx )

		Dim as Integer rc, startoffset, startchar
		startoffset = ctx->ovector[1]
		rc = pcre2_match(ctx->code, ctx->subject, _
					PCRE2_ZERO_TERMINATED, startoffset, options, _
					ctx->matchdata, NULL)
		if rc < 0 then
			return FALSE
		end if
		ctx->substrcnt = rc
		ctx->ovector = pcre2_get_ovector_pointer(ctx->matchdata)

		function = TRUE
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
			pcre2_substring_list_get ( ctx->matchdata, @ctx->substrlist, NULL)
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

		function = ctx->ovector[i * 2 + 0]
		
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
		
		function = ctx->ovector[i * 2 + 1] - ctx->ovector[i * 2 + 0]

	end function

end namespace
