''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


declare sub edbgInit _
	( _
	)

declare sub edbgEnd _
	( _
	)

declare sub edbgEmitHeader _
	( _
		byval filename as zstring ptr _
	)

declare sub edbgLineBegin _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval pos as integer _
	)

declare sub edbgLineEnd _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval pos as integer _
	)

declare sub edbgEmitLine _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval label as FBSYMBOL ptr _
	)

declare sub edbgEmitLineFlush _
	( _
		byval proc as FBSYMBOL ptr, _
		byval lnum as integer, _
		byval label as FBSYMBOL ptr _
	)

declare sub edbgScopeBegin _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub edbgScopeEnd _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub edbgEmitScopeINI _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub edbgEmitScopeEND _
	( _
		byval s as FBSYMBOL ptr _
	)

declare sub edbgProcBegin _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub edbgProcEnd _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub edbgProcEmitBegin _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub edbgEmitProcHeader _
	( _
		byval proc as FBSYMBOL ptr _
	)

declare sub edbgEmitProcFooter _
	( _
		byval proc as FBSYMBOL ptr, _
		byval initlabel as FBSYMBOL ptr, _
		byval exitlabel as FBSYMBOL ptr _
	)

declare sub edbgEmitFooter _
	( _
	)

declare sub edbgEmitGlobalVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval section as integer _
	)

declare sub edbgEmitProcArg _
	( _
		byval sym as FBSYMBOL ptr _
	)

declare sub edbgEmitLocalVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isstatic as integer _
	)

declare sub edbgIncludeBegin _
	( _
		byval incname as zstring ptr, _
		byval incfile as zstring ptr _
	)

declare sub edbgIncludeEnd _
	( _
	)


