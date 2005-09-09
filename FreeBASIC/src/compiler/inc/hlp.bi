#ifndef __HELP_BI__
#define __HELP_BI__

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


#ifndef FALSE
const FALSE = 0
const TRUE  = -1
#endif

#ifndef INVALID
const INVALID = -1
#endif

''
'' helper module protos
''

declare	sub 		hlpInit					( )

declare	sub 		hlpEnd					( )

declare	function 	hGetDefType				( byval symbol as string ) as integer

declare	sub 		hSetDefType				( byval ichar as integer, _
											  byval echar as integer, _
											  byval typ as integer )

declare function 	hMatch					( byval token as integer ) as integer

declare sub 		hReportErrorEx			( byval errnum as integer, _
											  byval msgex as string, _
											  byval linenum as integer = 0 )

declare sub 		hReportError			( byval errnum as integer, _
											  byval isbefore as integer = FALSE )

declare function 	hGetLastError 			( ) as integer

declare function 	hGetErrorCnt 			( ) as integer

declare sub 		hReportWarning			( byval msgnum as integer, _
											  byval msgex as string = "" )

declare function 	hMakeTmpStr 			( byval islabel as integer = TRUE ) as zstring ptr

declare function 	hFBrelop2IRrelop		( byval op as integer ) as integer

declare function 	hFileExists				( byval filename as string ) as integer

declare function 	hEscapeStr				( byval text as string ) as string

declare function 	hUnescapeStr			( byval text as string ) as string

declare function 	hEscapeToChar			( byval text as string ) as string

declare sub 		hClearName				( byval src as string )

declare sub 		hUcase					( byval src as string, _
											  byval dst as string )

declare sub 		hReplace				( text as string, _
											  byval oldtext as string, _
											  byval newtext as string )

declare function 	hCreateProcAlias		( byval symbol as string, _
											  byval argslen as integer, _
						   					  byval mode as integer ) as zstring ptr

#ifdef FBSYMBOL
declare function 	hCreateOvlProcAlias		( byval symbol as string, _
					    	  				  byval argc as integer, _
					    	  				  byval arg as FBSYMBOL ptr ) as zstring ptr
#endif

declare function 	hCreateDataAlias		( byval symbol as string, _
											  byval isimport as integer ) as string

declare function 	hCreateName 			( byval symbol as string, _
											  byval typ as integer = INVALID, _
											  byval preservecase as integer = FALSE, _
								      		  byval addunderscore as integer = TRUE, _
								      		  byval clearname as integer  = TRUE) as zstring ptr

declare function 	hStripUnderscore		( byval symbol as string ) as string

declare function 	hStripExt				( byval filename as string ) as string

declare function 	hStripPath				( byval filename as string ) as string

declare function 	hStripFilename 			( byval filename as string ) as string

declare function 	hGetFileExt				( fname as string ) as string

declare function 	hRevertSlash			( byval s as string ) as string

declare function 	hToPow2					( byval value as uinteger ) as uinteger

declare function 	hJumpTbAllocSym			( ) as any ptr

declare function 	hFloatToStr				( byval value as double, _
					  						  byref typ as integer ) as string


'':::::
#define ZEROSTRDESC(s)	                                _
	cptr(integer ptr, @s)[0] = NULL 					:_
	cptr(integer ptr, @s)[1] = NULL						:_
	cptr(integer ptr, @s)[2] = NULL

#endif ''__HELP_BI__
