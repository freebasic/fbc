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
		if( not cDeclaration( ) ) then
			if( not cCompoundStmt( ) ) then
				if( not cProcStatement( ) ) then
					if( not cQuirkStmt( ) ) then
						if( not cAsmBlock( ) ) then
							if( not cProcCallOrAssign( ) ) then
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

'':::::
''SimpleStatement =   STT_SEPARATOR? ( ConstDecl
''									 | SymbolDecl
''									 | ProcCallOrAssign
''									 | CompoundStmt
''									 | QuirkStmt
''									 | AsmBlock
''									 | AssignmentOrPtrCall )?
''                    (STT_SEPARATOR SimpleStatement)* .
''
function cSimpleStatement as integer

	'' ':'?
	if( lexGetToken( ) = FB_TK_STATSEPCHAR ) then
		lexSkipToken( )
	end if

	do
		if( not cConstDecl( ) ) then
			if( not cSymbolDecl( ) ) then
				if( not cCompoundStmt( ) ) then
					if( not cQuirkStmt( ) ) then
						if( not cAsmBlock( ) ) then
							if( not cProcCallOrAssign( ) ) then
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
    dim token as integer

	function = FALSE

	do
		token = lexGetToken( lexflags )
		if( (token <> FB_TK_STATSEPCHAR) and (token <> FB_TK_EOL) ) then
			exit do
		end if
		lexSkipToken( lexflags )

		function = TRUE
	loop

end function

