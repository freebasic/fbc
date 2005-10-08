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


'' typedef (TYPE foo AS bar) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
function cTypedefDecl( byval id as string ) as integer
    dim as zstring ptr tname
    dim as integer typ, lgt, ptrcnt
    dim as FBSYMBOL ptr subtype

    function = FALSE

    if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then

    	if( hGetLastError( ) <> FB_ERRMSG_OK ) then
    		exit function
    	end if

    	tname = lexGetText( )
    	'' pointing to itself? then it's a void..
    	if( *tname = id ) then
    		typ 	= FB_SYMBTYPE_VOID
    		subtype = NULL
    		lgt 	= 0

    	'' else, create a forward reference (or lookup one)
    	else
    		typ 	= FB_SYMBTYPE_FWDREF
    		subtype = symbAddFwdRef( tname )
			lgt 	= -1
			if( subtype = NULL ) then
				subtype = symbFindByNameAndClass( tname, FB_SYMBCLASS_FWDREF )
				if( subtype = NULL ) then
					hReportError( FB_ERRMSG_DUPDEFINITION )
					exit function
				end if
			end if
    	end if

    	lexSkipToken( )
    end if

	if( ptrcnt = 0 ) then
		'' (PTR|POINTER)*
		do
			select case lexGetToken( )
			case FB_TK_PTR, FB_TK_POINTER
				lexSkipToken( )
				typ += FB_SYMBTYPE_POINTER
				ptrcnt += 1
			case else
				exit do
			end select
		loop
	end if

    if( symbAddTypedef( @id, typ, subtype, ptrcnt, lgt ) = NULL ) then
		hReportError( FB_ERRMSG_DUPDEFINITION, TRUE )
		exit function
    end if

	function = TRUE

end function

