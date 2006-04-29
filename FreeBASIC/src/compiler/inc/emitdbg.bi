''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


declare sub			edbgInit			( )

declare sub			edbgEnd				( )

declare sub 		edbgEmitHeader		( byval filename as zstring ptr )

declare sub 		edbgLineBegin		( byval proc as FBSYMBOL ptr, _
										  byval lnum as integer )

declare sub 		edbgLineEnd			( byval proc as FBSYMBOL ptr, _
										  byval unused as integer )

declare sub 		edbgEmitLine		( byval proc as FBSYMBOL ptr, _
										  byval lnum as integer, _
										  byval label as FBSYMBOL ptr )

declare sub 		edbgEmitLineFlush	( byval proc as FBSYMBOL ptr, _
										  byval lnum as integer, _
										  byval label as FBSYMBOL ptr )

declare sub 		edbgScopeBegin		( byval s as FBSYMBOL ptr )

declare sub 		edbgScopeEnd		( byval s as FBSYMBOL ptr )

declare sub 		edbgEmitScopeINI	( byval s as FBSYMBOL ptr )

declare sub 		edbgEmitScopeEND	( byval s as FBSYMBOL ptr )

declare sub 		edbgProcBegin		( byval proc as FBSYMBOL ptr )

declare sub 		edbgProcEnd			( byval proc as FBSYMBOL ptr )

declare sub			edbgProcEmitBegin	( byval proc as FBSYMBOL ptr )

declare sub 		edbgEmitProcHeader	( byval proc as FBSYMBOL ptr )

declare sub 		edbgEmitProcFooter	( byval proc as FBSYMBOL ptr, _
										  byval initlabel as FBSYMBOL ptr, _
			      						  byval exitlabel as FBSYMBOL ptr )

declare sub 		edbgEmitFooter		( )

declare sub 		edbgEmitGlobalVar	( byval sym as FBSYMBOL ptr, _
				   						  byval section as integer )

declare sub 		edbgEmitProcArg		( byval sym as FBSYMBOL ptr )

declare sub 		edbgEmitLocalVar	( byval sym as FBSYMBOL ptr, _
										  byval isstatic as integer )

declare sub 		edbgIncludeBegin 	( byval incname as zstring ptr, _
					   					  byval incfile as zstring ptr )

declare sub 		edbgIncludeEnd 		( )

