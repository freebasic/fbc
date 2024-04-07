#ifndef __CREGEX_BI__
#define __CREGEX_BI__

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


#ifndef NULL
#define NULL 0
#endif

namespace fb
	
	type CRegexCtx as CRegexCtx_

	enum REGEX_OPT
		REGEX_OPT_CASELESS			= &h0001
		REGEX_OPT_MULTILINE			= &h0002
		REGEX_OPT_DOTALL			= &h0004
		REGEX_OPT_EXTENDED			= &h0008
		REGEX_OPT_ANCHORED			= &h0010
		REGEX_OPT_DOLLAR_ENDONLY	= &h0020
		REGEX_OPT_EXTRA_			= &h0040
		REGEX_OPT_NOTBOL			= &h0080
		REGEX_OPT_NOTEOL			= &h0100
		REGEX_OPT_UNGREEDY			= &h0200
		REGEX_OPT_NOTEMPTY			= &h0400
		REGEX_OPT_UTF8				= &h0800
		REGEX_OPT_NO_AUTO_CAPTURE	= &h1000
		REGEX_OPT_NO_UTF8_CHECK		= &h2000
		REGEX_OPT_AUTO_CALLOUT		= &h4000
		REGEX_OPT_PARTIAL			= &h8000
	end enum

	type CRegex

		declare constructor _
			( _
				byval pattern as zstring ptr, _
				byval options as REGEX_OPT = 0 _
			)

		declare destructor _
			( _
			)

		declare function GetMaxMatches _
			( _
			) as integer

		declare function Search _
			( _
				byval subject as zstring ptr, _
				byval lgt as integer = -1, _
				byval options as REGEX_OPT = 0 _
			) as integer

		declare function SearchNext _
			( _
				byval options as REGEX_OPT = 0 _
			) as integer


		declare function GetStr _
			( _
				byval i as integer = 1 _
			) as zstring ptr

		declare function GetOfs _
			( _
				byval i as integer = 1 _
			) as integer

		declare function GetLen _
			( _
				byval i as integer = 1 _
			) as integer

		ctx as CRegexCtx ptr

	end type

end namespace

#endif