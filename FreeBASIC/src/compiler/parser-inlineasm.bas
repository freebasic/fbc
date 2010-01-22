''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"

const LEX_FLAGS = (LEXCHECK_NOWHITESPC or LEXCHECK_NOLETTERSUFFIX)

'':::::
sub parserAsmInit static

	listNew( @parser.asmtoklist, 16, len( FB_ASMTOK ) )

end sub

'':::::
sub parserAsmEnd static

	listFree( @parser.asmtoklist )

end sub

'':::::
''AsmCode         =   (Text !(END|Comment|NEWLINE))*
''
function cAsmCode _
	( _
	) as integer

	static as zstring * FB_MAXLITLEN+1 text
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr expr = any
	dim as FB_ASMTOK ptr head, tail = any, node = any
	dim as integer doskip = any, thisTok = any

	function = FALSE

	head = NULL
	tail = NULL
	do
		'' !(END|Comment|NEWLINE)
		thisTok = lexGetToken( LEX_FLAGS )
		select case as const thisTok
		case FB_TK_END, FB_TK_EOL, FB_TK_COMMENT, FB_TK_REM, FB_TK_EOF
			exit do
		end select

		text = *lexGetText( )
		sym = NULL
		doskip = FALSE

		select case as const lexGetClass( LEX_FLAGS )

		'' id?
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

			if thistok = FB_TK_SIZEOF then

                '' SIZEOF( valid expression )?
				cMathFunct( thisTok, expr, TRUE )
				if( expr <> NULL ) then

                    '' constant expression?
					if( astIsCONST( expr ) = TRUE ) then
						'' text replacement
					    text = str( symbGetConstValInt( expr ) )
					else
				        '' error limit?
						if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
							exit function
						else
							'' skip emission
							doskip = TRUE
						end if

					end if

					astDelNode( expr )

				else

					'' error limit?
					if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
						exit function
					else
						'' skip emission
						doskip = TRUE
					end if

				end if

			elseif( irGetOption( IR_OPT_HIGHLEVEL ) orelse emitIsKeyword( lcase(text) ) = FALSE ) then
				dim as FBSYMBOL ptr base_parent = any

				chain_ = cIdentifier( base_parent )
				do while( chain_ <> NULL )
					dim as FBSYMBOL ptr s = chain_->sym
					do
						select case symbGetClass( s )
						'' function?
						case FB_SYMBCLASS_PROC
							text = *symbGetMangledName( s )
							exit do, do

						'' const?
						case FB_SYMBCLASS_CONST
							text = symbGetConstValueAsStr( s )
							exit do, do

						'' label?
						case FB_SYMBCLASS_LABEL
							text = *symbGetMangledName( s )
							exit do, do

						case FB_SYMBCLASS_VAR
							'' var?
							sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )

							if( sym <> NULL ) then
								symbSetIsAccessed( sym )
							end if
							exit do, do

						end select

						s = s->hash.next
					loop while( s <> NULL )

					chain_ = symbChainGetNext( chain_ )
				loop
            end if

		'' lit number?
		case FB_TKCLASS_NUMLITERAL
			 expr = cNumLiteral( FALSE )
			 if( expr <> NULL ) then
             	text = astGetValueAsStr( expr )
			 	astDelNode( expr )
			 end if

		'' lit string?
		case FB_TKCLASS_STRLITERAL
			 expr = cStrLiteral( FALSE )
			 if( expr <> NULL ) then
             	dim as FBSYMBOL ptr litsym = astGetStrLitSymbol( expr )
             	if( litsym <> NULL ) then
                    text = """"
                    if( symbGetType( litsym ) <> FB_DATATYPE_WCHAR ) then
             			text += *symbGetVarLitText( litsym )
             		else
             			text += *symbGetVarLitTextW( litsym )
             		end if
             		text += """"
			 	end if

			 	astDelTree( expr )
			 end if

		''
		case FB_TKCLASS_KEYWORD
			select case thisTok
			case FB_TK_FUNCTION
			'' FUNCTION?
    			sym = symbGetProcResult( parser.currproc )
    			if( sym = NULL ) then
    				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    					exit function
    				else
    					doskip = TRUE
    				end if

    			else
    				symbSetIsAccessed( sym )
    			end if

			case FB_TK_CINT

                '' CINT( valid expression )?
				expr = cTypeConvExpr( thisTok, TRUE )
				if( expr <> NULL ) then

                    '' constant expression?
					if( astIsCONST( expr ) = TRUE ) then
						'' text replacement
					    text = str( symbGetConstValInt( expr ) )
					else
				        '' error limit?
						if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
							exit function
						else
							'' skip emission
							doskip = TRUE
						end if

					end if

					astDelNode( expr )

				else

					'' error limit?
					if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
						exit function
					else
						'' skip emission
						doskip = TRUE
					end if

				end if

			end select

		end select

		''
		if( doskip = FALSE ) then
			node = listNewNode( @parser.asmtoklist )
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

		lexSkipToken( LEX_FLAGS )
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
    dim as integer issingleline = any

	function = FALSE

	'' ASM?
	if( lexGetToken( ) <> FB_TK_ASM ) then
		exit function
	end if

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_ASM )
    	exit function
    end if

	lexSkipToken( )

	'' (Comment SttSeparator)?
	issingleline = FALSE
	if( cComment( ) ) then
		'' emit the current line in text form
		hEmitCurrLine( )

		if( cStmtSeparator( ) = FALSE ) then
    		if( errReport( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
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
		cComment( LEX_FLAGS )

		'' emit the current line in text form
		hEmitCurrLine( )

		'' NewLine
		select case lexGetToken( )
		case FB_TK_EOL
			if( issingleline ) then
				exit do
			end if

			lexSkipToken( )

		case FB_TK_EOF
			exit do

		case FB_TK_END
			exit do

		case else
    		if( errReport( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
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
    		if( errReport( FB_ERRMSG_EXPECTEDENDASM ) = FALSE ) then
    			exit function
    		end if

		elseif( hMatch( FB_TK_ASM ) = FALSE ) then
    		if( errReport( FB_ERRMSG_EXPECTEDENDASM ) = FALSE ) then
    			exit function
    		end if
		end if
	end if

	function = TRUE

end function
