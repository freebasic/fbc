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


declare sub 		edbgHeader			( byval asmf as integer, filename as string )

declare sub 		edbgMain			(  byval initlabel as integer )

declare sub 		edbgLine			( byval lnum as integer, lname as string )

declare sub 		edbgProcBegin		( byval proc as integer, byval ispublic as integer, byval lnum as integer )

declare sub 		edbgProcEnd			( byval proc as integer, byval initlabel as integer, byval exitlabel as integer )

declare sub 		edbgFooter			( )
