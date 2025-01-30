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
		'' Options for Compile
		REGEX_OPT_AUTO_CALLOUT		= &h00000004u
		REGEX_OPT_CASELESS			= &h00000008u
		REGEX_OPT_DOLLAR_ENDONLY	= &h00000010u
		REGEX_OPT_DOTALL			= &h00000020u
		REGEX_OPT_EXTENDED			= &h00000080u
		REGEX_OPT_MULTILINE			= &h00000400u
		REGEX_OPT_NO_AUTO_CAPTURE	= &h00002000u
		REGEX_OPT_UNGREEDY			= &h00040000u
		REGEX_OPT_UTF8				= &h00080000u
		'' Options for Match
		REGEX_OPT_NOTBOL			= &h00000001u
		REGEX_OPT_NOTEOL			= &h00000002u
		REGEX_OPT_NOTEMPTY			= &h00000004u
		REGEX_OPT_PARTIAL_SOFT		= &h00000010u
		REGEX_OPT_PARTIAL_HARD		= &h00000020u
		'' Options for both
		REGEX_OPT_NO_UTF8_CHECK		= &h40000000u
		REGEX_OPT_ANCHORED			= &h80000000u
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
