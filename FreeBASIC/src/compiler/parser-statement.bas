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


'' statements top-level parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
''Statement       =   STT_SEPARATOR? ( Declaration
''									 | ProcCallOrAssign
''								     | CompoundStmt
''									 | ProcStatement
''									 | QuirkStmt
''									 | AsmBlock
''									 | AssignmentOrPtrCall )?
''                    (STT_SEPARATOR Statement)* .
''
function cStatement as integer

	'' ':'?
	if( lexGetToken( ) = FB_TK_STATSEPCHAR ) then
		lexSkipToken( )
	end if

	do
		if( cDeclaration( ) = FALSE ) then
			if( cCompoundStmt( ) = FALSE ) then
				if( cProcCallOrAssign( ) = FALSE ) then
					if( cProcStmtBegin( ) = FALSE ) then
						if( cQuirkStmt( ) = FALSE ) then
							if( cAsmBlock( ) = FALSE ) then
								cAssignmentOrPtrCall( )
							end if
						end if
					end if
				end if
			end if
		end if

		'' ':'?
		if( lexGetToken( ) <> FB_TK_STATSEPCHAR ) then
			exit do
		end if
		lexSkipToken( )
	loop

	function = (hGetLastError( ) = FB_ERRMSG_OK)

end function

'':::
''SttSeparator    =   (STT_SEPARATOR | EOL)+ .
''
function cStmtSeparator( byval lexflags as LEXCHECK_ENUM ) as integer

	function = FALSE

	do
		select case lexGetToken( lexflags )
		case FB_TK_STATSEPCHAR, FB_TK_EOL
        	lexSkipToken( lexflags )
		case else
			exit do
		end select

		function = TRUE
	loop

end function

