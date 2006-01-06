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


'' SCOPE..END SCOPE compound statement parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''ScopeStatement  =   SCOPE Comment?
''					  	SimpleLine*
''					  END SCOPE .
''
function cScopeStatement as integer
    dim as integer lastcompstmt
    dim as FBSYMBOL ptr s

	function = FALSE

	if( env.scope >= FB_MAXSCOPEDEPTH ) then
		hReportError( FB_ERRMSG_RECLEVELTOODEPTH )
		exit function
	end if

	'' SCOPE
	lexSkipToken( )

	'' Comment?
	cComment( )

	'' separator
	if( cStmtSeparator( ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	''
	lastcompstmt     = env.lastcompound
	env.lastcompound = FB_TK_SCOPE
	env.scope += 1

	''
	s = symbAddScope( )

	astScopeBegin( s )

	'' loop body
	do
		if( cSimpleLine( ) = FALSE ) then
			exit do
		end if
	loop while( lexGetToken( ) <> FB_TK_EOF )

	'' free dynamic vars
	symbFreeScopeDynVars( s )

	'' remove symbols from hash table
	symbDelScopeTb( s )

	''
	astScopeEnd( s )

	''
	env.scope -= 1
	env.lastcompound = lastcompstmt

	'' END SCOPE
	if( (hMatch( FB_TK_END ) = FALSE) or _
		(hMatch( FB_TK_SCOPE ) = FALSE) ) then
		hReportError( FB_ERRMSG_EXPECTEDENDSCOPE )
		exit function
	end if

	function = TRUE

end function

