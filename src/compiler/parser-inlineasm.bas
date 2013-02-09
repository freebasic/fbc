'' inline asm parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "emit.bi"

const LEX_FLAGS = (LEXCHECK_NOWHITESPC or LEXCHECK_NOLETTERSUFFIX)

'':::::
''AsmCode         =   (Text !(END|Comment|NEWLINE))*
''
sub cAsmCode()
	static as zstring * FB_MAXLITLEN+1 text
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr expr = any
	dim as ASTASMTOK ptr head = any, tail = any
	dim as integer doskip = any, thisTok = any

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
				expr = cMathFunct(thisTok, TRUE)
				if( expr <> NULL ) then

                    '' constant expression?
					if( astIsCONST( expr ) = TRUE ) then
						'' text replacement
					    text = str( symbGetConstValInt( expr ) )
					else
						errReport( FB_ERRMSG_EXPECTEDCONST )
						'' skip emission
						doskip = TRUE
					end if

					astDelNode( expr )
				else
					errReport( FB_ERRMSG_SYNTAXERROR )
					'' skip emission
					doskip = TRUE
				end if

			elseif( (env.clopt.backend = FB_BACKEND_GCC) orelse emitIsKeyword( lcase(text) ) = FALSE ) then
				dim as FBSYMBOL ptr base_parent = any

				chain_ = cIdentifier( base_parent )
				do while( chain_ <> NULL )
					dim as FBSYMBOL ptr s = chain_->sym
					do
						select case symbGetClass( s )
						case FB_SYMBCLASS_PROC, FB_SYMBCLASS_LABEL
							sym = s
							exit do, do

						'' const?
						case FB_SYMBCLASS_CONST
							text = symbGetConstValueAsStr( s )
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
				text = astConstFlushToStr( expr )
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
					errReport( FB_ERRMSG_SYNTAXERROR )
					doskip = TRUE
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
						errReport( FB_ERRMSG_EXPECTEDCONST )
						'' skip emission
						doskip = TRUE
					end if

					astDelNode( expr )
				else
					errReport( FB_ERRMSG_SYNTAXERROR )
					'' skip emission
					doskip = TRUE
				end if
			end select
		end select

		''
		if( doskip = FALSE ) then
			if( sym ) then
				tail = astAsmAppendSymb( tail, sym )
			else
				tail = astAsmAppendText( tail, text )
			end if
			if( head = NULL ) then
				head = tail
			end if
		end if

		lexSkipToken( LEX_FLAGS )
	loop

	'' One ASM node per line of asm, with as many asm tokens as needed each
	if( head <> NULL ) then
		astAdd( astNewASM( head ) )
	end if
end sub

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
			errReport( FB_ERRMSG_EXPECTEDEOL )
			'' error recovery: skip until next line
			hSkipUntil( FB_TK_EOL, TRUE )
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
			errReport( FB_ERRMSG_EXPECTEDEOL )
			'' error recovery: skip until next line
			hSkipUntil( FB_TK_EOL, TRUE )
		end select

		if( issingleline = FALSE ) then
			astAdd( astNewDBG( AST_OP_DBG_LINEEND ) )
		end if
	loop

	if( issingleline = FALSE ) then
		'' END ASM
		if( hMatch( FB_TK_END ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDENDASM )
		elseif( hMatch( FB_TK_ASM ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDENDASM )
		end if
	end if

	function = TRUE

end function
