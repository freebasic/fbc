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


''
'' helper module protos
''

declare	sub 		hlpInit					( )
declare	sub 		hlpEnd					( )
declare	function 	hGetDefType				( symbol as string ) as integer
declare	sub 		hSetDefType				( byval ichar as integer, byval echar as integer, byval typ as integer )
declare function 	hMatch					( byval token as integer ) as integer

declare sub 		hReportErrorEx			( byval errnum as integer, msgex as string, byval linenum as integer = 0 )
declare sub 		hReportError			( byval errnum as integer, byval isbefore as integer = FALSE )
declare sub 		hReportSimpleError		( byval errnum as integer )
declare function 	hGetLastError 			( ) as integer

declare function 	hMakeTmpStr 			( ) as string
declare function 	hFBrelop2IRrelop		( byval op as integer ) as integer

declare function 	hFileExists				( filename as string ) as integer

declare function 	hScapeStr				( s as string ) as string
declare sub 		hClearName				( src as string )

declare function 	hCreateAliasName		( symbol as string, byval argslen as integer, _
						   					  byval toupper as integer, byval mode as integer ) as string

declare function 	hCreateName				( symbol as string, byval typ as integer ) as string
declare function 	hCreateNameEx			( symbol as string, byval typ as integer = INVALID, byval preservecase as integer = FALSE, _
								      		  byval addunderscore as integer = TRUE, byval clearname as integer  = TRUE) as string

declare function 	hStripExt				( filename as string ) as string
declare function 	hStripPath				( filename as string ) as string
declare function 	hStripFilename 			( filename as string ) as string

declare function 	hToPow2					( byval value as integer ) as integer

