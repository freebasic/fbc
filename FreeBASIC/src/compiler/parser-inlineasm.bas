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


'' inline asm parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"


'':::::
sub parserAsmInit static

	listNew( @env.asmtoklist, 16, len( FB_ASMTOK ) )

end sub

'':::::
sub parserAsmEnd static

	listFree( @env.asmtoklist )

end sub

'':::::
''AsmCode         =   (Text !(END|Comment|NEWLINE))*
''
function cAsmCode as integer static
	static as zstring * FB_MAXLITLEN+1 text
	dim as FBSYMBOL ptr sym
	dim as FBSYMCHAIN ptr chain_
	dim as FB_ASMTOK ptr head, tail, node
	dim as integer doskip

	function = FALSE

	head = NULL
	tail = NULL
	do
		'' !(END|Comment|NEWLINE)
		select case lexGetToken( LEXCHECK_NOWHITESPC )
		case FB_TK_END, FB_TK_EOL, FB_TK_COMMENTCHAR, FB_TK_REM, FB_TK_EOF
			exit do
		end select

		text = *lexGetText( )
		sym = NULL
		doskip = FALSE

		if( lexGetClass( LEXCHECK_NOWHITESPC ) = FB_TKCLASS_IDENTIFIER ) then
			if( emitIsKeyword( text ) = FALSE ) then
				chain_ = cIdentifier( )
				if( chain_ <> NULL ) then
					'' function?
					sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
					if( sym <> NULL ) then
						text = *symbGetMangledName( sym )
						sym = NULL
					else
						'' const?
						sym = symbFindByClass( chain_, FB_SYMBCLASS_CONST )
				    	if( sym <> NULL ) then
							text = symbGetConstValueAsStr( sym )
							sym = NULL
						else
							'' label?
							sym = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
							if( sym <> NULL ) then
								text = *symbGetMangledName( sym )
								sym = NULL
							else
								'' var?
								sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
							end if
						end if
					end if
				else
					if( hGetLastError( ) <> FB_ERRMSG_OK ) then
						exit function
					end if
				end if
            end if

		''
		else
			'' FUNCTION?
			if( lexGetToken( LEXCHECK_NOWHITESPC ) = FB_TK_FUNCTION ) then
    			sym = symbGetProcResult( env.currproc )
    			if( sym = NULL ) then
    				if( hReportError( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    					exit function
    				else
    					doskip = TRUE
    				end if
    			end if
			end if

		end if

		''
		if( doskip = FALSE ) then
			node = listNewNode( @env.asmtoklist )
			if( tail <> NULL ) then
				tail->next = node
			else
				head = node
			end if
			tail = node

			if( sym <> NULL ) then
            	node->type = FB_ASMTOK_SYMB
            	node->sym = sym
			else
				node->type = FB_ASMTOK_TEXT
				node->text = ZstrAllocate( len( text ) )
				*node->text = text
			end if
			node->next = NULL
		end if

		lexSkipToken( LEXCHECK_NOWHITESPC )
	loop

	''
	if( head <> NULL ) then
		astAdd( astNewASM( head ) )
	end if

	function = TRUE

end function

'':::::
''AsmBlock        =   ASM Comment? SttSeparator
''                        (AsmCode Comment? NewLine)+
''					  END ASM .
function cAsmBlock as integer
    dim as integer issingleline

	function = FALSE

	'' ASM?
	if( lexGetToken( ) <> FB_TK_ASM ) then
		exit function
	end if

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    	exit function
    end if

	lexSkipToken( )

	'' (Comment SttSeparator)?
	issingleline = FALSE
	if( cComment( ) ) then
		if( cStmtSeparator( ) = FALSE ) then
    		if( hReportError( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: skip until next line
    			hSkipUntil( FB_TK_EOL, TRUE )
    		end if
		end if
	else
		if( cStmtSeparator( ) = FALSE ) then
			issingleline = TRUE
        end if
	end if

	'' (AsmCode Comment? NewLine)+
	do
		if( issingleline = FALSE ) then
			astAdd( astNewDBG( AST_OP_DBG_LINEINI, lexLineNum( ) ) )
		end if

		cAsmCode( )

		'' Comment?
		cComment( LEXCHECK_NOWHITESPC )

		'' NewLine
		select case lexGetToken( )
		case FB_TK_EOL
			if( issingleline ) then
				exit do
			end if

			lexSkipToken( )

		case FB_TK_END
			exit do

		case else
    		if( hReportError( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: skip until next line
    			hSkipUntil( FB_TK_EOL, TRUE )
    		end if
		end select

		if( issingleline = FALSE ) then
			astAdd( astNewDBG( AST_OP_DBG_LINEEND ) )
		end if
	loop

	if( issingleline = FALSE ) then
		'' END ASM
		if( hMatch( FB_TK_END ) = FALSE ) then
    		if( hReportError( FB_ERRMSG_EXPECTEDENDASM ) = FALSE ) then
    			exit function
    		end if

		elseif( hMatch( FB_TK_ASM ) = FALSE ) then
    		if( hReportError( FB_ERRMSG_EXPECTEDENDASM ) = FALSE ) then
    			exit function
    		end if
		end if
	end if

	function = TRUE

end function
