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
'' lex protos
''

type FBTOKEN
	id				as integer
	class			as integer
	typ				as integer
	text			as string * 128 'FB.MAXNANELEN
	tlen			as integer
end type


declare sub 		lexInit                 ( )
declare sub 		lexEnd					( )

declare sub 		lexSaveCtx				( byval level as integer )
declare sub 		lexRestoreCtx			( byval level as integer )


declare function 	lexCurrentChar          ( ) as integer
declare function 	lexEatChar              ( ) as integer
declare function 	lexLookAheadChar        ( ) as integer
declare function 	lexReadIdentifier		( tlen as integer, typ as integer ) as string
declare function 	lexReadNumber			( typ as integer, tlen as integer ) as string
declare function 	lexReadString 			( tlen as integer ) as string
declare sub 		lexNextToken 			( t as FBTOKEN, byval checkLineCont as integer = TRUE )

declare function 	lexCurrentToken 		( byval checkLineCont as integer = TRUE ) as integer
declare function 	lexCurrentTokenClass 	( byval checkLineCont as integer = TRUE ) as integer
declare function 	lexTokenText 			( ) as string
declare function 	lexTokenType 			( ) as integer

declare function 	lexEatToken 			( byval checkLineCont as integer = TRUE ) as string
declare sub 		lexSkipToken			( byval checkLineCont as integer = TRUE )

declare function 	lexLookAheadClass 		( byval k as integer ) as integer
declare function 	lexLookAhead 			( byval k as integer ) as integer

declare function 	lexLineNum 				( ) as integer
declare function 	lexColNum 				( ) as integer

declare sub 		lexSkipComment			( )
