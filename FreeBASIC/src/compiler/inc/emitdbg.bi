''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


declare sub 		edbgEmitHeader		( byval asmf as integer, _
										  byval filename as string, _
										  byval modulename as string, _
										  byval entryname as string )

declare sub 		edbgLineBegin		( byval proc as FBSYMBOL ptr, _
										  byval lnum as integer )

declare sub 		edbgLineEnd			( byval proc as FBSYMBOL ptr )

declare sub 		edbgEmitLine		( byval proc as FBSYMBOL ptr, _
										  byval lnum as integer, _
										  byval label as FBSYMBOL ptr )

declare sub 		edbgEmitLineFlush	( byval proc as FBSYMBOL ptr, _
										  byval lnum as integer, _
										  byval label as FBSYMBOL ptr )

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

declare sub 		edbgEmitLocalVar	( byval sym as FBSYMBOL ptr )

declare sub 		edbgEmitProcArg		( byval sym as FBSYMBOL ptr )

declare sub 		edbgIncludeBegin 	( byval incname as string, _
					   					  byval incfile as integer )

declare sub 		edbgIncludeEnd 		( )

