'' pre-processor #define parsing (including macros)
''
'' chng: dec/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "lex.bi"
#include once "parser.bi"
#include once "pp.bi"
#include once "list.bi"
#include once "dstr.bi"

#define LEX_FLAGS (LEXCHECK_NOWHITESPC or _
				   LEXCHECK_NOSUFFIX or _
				   LEXCHECK_NODEFINE or _
				   LEXCHECK_NOQUOTES or _
				   LEXCHECK_NOSYMBOL)

''::::
sub ppDefineInit( )

	listInit( @pp.argtblist, 8, len( LEXPP_ARGTB ), LIST_FLAGS_NOCLEAR )

end sub

''::::
sub ppDefineEnd( )

	listEnd( @pp.argtblist )

end sub

private sub hReportMacroError(byval s as FBSYMBOL ptr, byval errnum as integer)
	errReportEx( errnum, "expanding: " + *symbGetName( s ) )
end sub

private function isMacroAllowed(byval s as FBSYMBOL ptr) as integer
	'' The va_arg() and va_next() built in macros aren't supported with -gen gcc
	'' Error recovery: continue parsing as usual
	if (pp.skipping = FALSE) then
		if (s->def.flags and FB_DEFINE_FLAGS_NOGCC) then
			if( env.clopt.backend = FB_BACKEND_GCC ) then
				errReport(FB_ERRMSG_STMTUNSUPPORTEDINGCC)
				return FALSE
			end if
		end if
	end if
	return TRUE
end function

'':::::
private function hLoadMacro _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

	dim as FB_DEFPARAM ptr param = any, nextparam = any
	dim as FB_DEFTOK ptr dt = any
	dim as FBTOKEN t = any
	dim as LEXPP_ARGTB ptr argtb = any
	dim as integer prntcnt = any, num = any, reached_vararg = any, is_variadic = any
	dim as zstring ptr argtext = any
	static as string text

	function = -1

	var hasParens = FALSE
	var hasWhitespace = lexEatWhitespace( )

	'' '('?
	if( lexCurrentChar( ) = CHAR_LPRNT ) then
		hasParens = TRUE
	end if

	if( (symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_NEEDPARENS) <> 0 ) then
		if( hasParens = FALSE ) then
			'' not an error, macro can be passed as param to other macros
			exit function
		end if
	else
		'' parens optional? then whitespace before '(' will determine that the '('
		'' is part of the first argument instead of starting the argument list
		hasParens and= not hasWhitespace
	end if

	if (isMacroAllowed(s) = FALSE) then
		exit function
	end if

	pp.invoking += 1

	if( hasParens ) then
		lexEatChar( )
	end if

	'' allocate a new arg list (support recursion)
	param = symbGetDefineHeadParam( s )
	if( param <> NULL ) then
		argtb = listNewNode( @pp.argtblist )
	else
		argtb = NULL
	end if

	prntcnt = 1
	reached_vararg = FALSE

	'' Variadic macro?
	is_variadic = ((s->def.flags and FB_DEFINE_FLAGS_VARIADIC) <> 0)

	var readdchar = -1

	'' for each arg
	num = 0   '' num represents the current last cleared/used entry in the argtb
	if( argtb ) then
		argtb->count = 0
	end if
	do
		if( argtb ) then
			'' argtb entries must be cleared! (it's a NOCLEAR list)
			DZstrZero( argtb->tb(num).text )
		end if

		nextparam = symbGetDefParamNext( param )

		'' Last param?
		if( nextparam = NULL ) then
			reached_vararg = is_variadic
		end if

		'' read text until a comma or right-parentheses is found
		do
			lexNextToken( @t, LEXCHECK_NOWHITESPC or _
							  LEXCHECK_NOSUFFIX or _
							  LEXCHECK_NOQUOTES or _
							  LEXCHECK_NOPERIOD )

			select case as const t.id
			'' (
			case CHAR_LPRNT
				prntcnt += 1

			'' )
			case CHAR_RPRNT
				if( prntcnt > 0 ) then
					prntcnt -= 1

					'' determine if we need to add back the right paren ')'
					'' if parens were optional and we didn't have any parens
					'' for this macro to start with, we need to add back the
					'' right paren ')' since it will be needed by the caller.
					if( prntcnt = 0 ) then
						if( (symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_NEEDPARENS) = 0 ) then
							if( hasParens = FALSE ) then
								if( argtb->count >= symbGetDefineParams( s ) ) then
									if( pp.invoking > 1 ) then
										readdchar = CHAR_RPRNT
									end if
								end if
							end if
						end if

						'' Closing ')'
						exit do
					end if
				end if

			'' ,
			case CHAR_COMMA
				'' A comma indicates the next arg, so we should
				'' end the current arg now, unless we're at the
				'' "..." vararg, which just "absorbs" everything
				'' until the closing ')'.
				if( prntcnt = 1 ) then

					'' Check if comma is ending the macro list of arguments:
					'' if parens are optional and we didn't have any parens
					'' for this macro to start with, and we now have enough
					'' arguments to satisfy the macro, then we can consider
					'' the macro call complete.  Add back the comma for the
					'' caller.
					if( (symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_NEEDPARENS) = 0 ) then
						if( is_variadic = FALSE ) then
							if( hasParens = FALSE ) then
								if( argtb->count >= symbGetDefineParams( s ) ) then
									if( pp.invoking > 1 ) then
										readdchar = CHAR_COMMA
									end if
									prntcnt = 0
									exit do
								end if
							end if
						end if
					end if

					if( argtb ) then
						if( argtb->count = 0 ) then
							argtb->count = 1
						end if
						argtb->count += 1
					endif
					if( reached_vararg = FALSE ) then
						exit do
					end if
				end if

			case FB_TK_STMTSEP
				if( not hasParens ) then
					readdchar = CHAR_COLON
					prntcnt = 0
					exit do
				end if

			case FB_TK_EOL, FB_TK_EOF
				if( hasParens ) then
					hReportMacroError( s, FB_ERRMSG_EXPECTEDRPRNT )
				else
					readdchar = iif(t.id = FB_TK_EOF, 0, CHAR_LF)
				end if
				prntcnt = 0
				exit do

			case CHAR_SPACE, CHAR_TAB

			case else
				if( argtb ) then
					if( argtb->count = 0 ) then
						argtb->count = 1
					end if
				endif

			end select

			'' we are still in an argument, so just join the current
			'' token to the current argument
			if( argtb <> NULL ) then
				if( t.dtype <> FB_DATATYPE_WCHAR ) then
					DZstrConcatAssign( argtb->tb(num).text, t.text )
				else
					DZstrConcatAssignW( argtb->tb(num).text, t.textw )
				end if
			end if
		loop

		if( argtb ) then
			with( argtb->tb(num) )
				'' Arguments are allowed to be empty, so must check for NULL
				if( .text.data ) then
					'' Trim space
					if( (.text.data[0][0] = CHAR_SPACE) or _
						(.text.data[0][len( *.text.data )-1] = CHAR_SPACE) ) then
						DZstrAssign( .text, trim( *.text.data ) )
					end if
				end if
			end with
		end if

		'' Reached closing parentheses?
		if( prntcnt = 0 ) then
			'' End of param list not yet reached?
			if( nextparam ) then
				'' Too few args specified. This is an error, unless it's
				'' only the "..." vararg param that wasn't given any arg.

				'' Not the last param, or not variadic?
				if( (symbGetDefParamNext( nextparam ) <> NULL) or (not is_variadic) ) then
					hReportMacroError( s, FB_ERRMSG_ARGCNTMISMATCH )
				end if

				'' Clear any missing args
				assert( num < (symbGetDefineParams( s ) - 1) )
				do
					num += 1
					'' argtb entries must be cleared! (it's a NOCLEAR list)
					DZstrZero( argtb->tb(num).text )
				loop while( num < (symbGetDefineParams( s ) - 1) )
			end if

			exit do
		end if

		'' Reached end of param list?
		if( nextparam = NULL ) then
			'' Too many args specified
			hReportMacroError( s, FB_ERRMSG_ARGCNTMISMATCH )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE, LEX_FLAGS )
			exit do
		end if

		'' Next
		param = nextparam
		num += 1
	loop

	text = ""

	'' should we call a function to get definition text?
	if( symbGetMacroCallbackZ( s ) <> NULL ) then
		'' call function
		var errnum = FB_ERRMSG_OK
		var res = symbGetMacroCallbackZ( s )( argtb, @errnum )
		if( errnum = FB_ERRMSG_OK ) then
			text = res
		else
			hReportMacroError( s, errnum )
		end if

	'' just load text as-is
	else
		if( argtb ) then
			dt = symbGetDefineHeadToken( s )
			do while( dt )
				select case as const( symbGetDefTokType( dt ) )
				'' parameter?
				case FB_DEFTOK_TYPE_PARAM
					assert( symbGetDefTokParamNum( dt ) <= num )
					argtext = argtb->tb( symbGetDefTokParamNum( dt ) ).text.data

					'' Only if not empty ("..." param can be empty)
					if( argtext <> NULL ) then
						text += *argtext
					end if

				'' stringize parameter?
				case FB_DEFTOK_TYPE_PARAMSTR
					assert( symbGetDefTokParamNum( dt ) <= num )
					argtext = argtb->tb( symbGetDefTokParamNum( dt ) ).text.data

					'' Only if not empty ("..." param can be empty)
					if( argtext <> NULL ) then
						'' don't escape, preserve the sequencies as-is
						text += "$" + QUOTE
						text += hReplace( argtext, QUOTE, QUOTE + QUOTE )
						text += QUOTE
					else
						'' If it's empty, produce an empty string ("")
						text += QUOTE + QUOTE
					end if

				'' ordinary text..
				case FB_DEFTOK_TYPE_TEX
					text += *symbGetDefTokText( dt )

				'' unicode text?
				case FB_DEFTOK_TYPE_TEXW
					text += str( *symbGetDefTokTextW( dt ) )
				end select

				'' next
				dt = symbGetDefTokNext( dt )
			loop

			'' free args text
			do while( num > 0 )
				num -= 1
				DZstrAssign( argtb->tb(num).text, NULL )
			loop

			listDelNode( @pp.argtblist, argtb )
		end if

		if( readdchar <> -1 ) then
			text += chr(readdchar)
		end if

	end if

	if( lex.ctx->deflen = 0 ) then
		DZstrAssign( lex.ctx->deftext, text )
	else
		DZstrAssign( lex.ctx->deftext, text + *lex.ctx->defptr )
	end if

	pp.invoking -= 1

	function = len( text )

end function

''::::
private function hLoadDefine _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

	static as string text
	dim as integer lgt = any

	function = FALSE

	'' define has args?
	if( symbGetDefineParams( s ) > 0 ) then

		lgt = hLoadMacro( s )
		if( lgt = -1 ) then
			exit function
		end if

	'' no args
	else

		'' should we call a function to get definition text?
		if( symbGetDefineCallback( s ) <> NULL ) then
			'' call function
			if( symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_STR ) then
				text = "$" + QUOTE + symbGetDefineCallback( s )( ) + QUOTE
			else
				text = symbGetDefineCallback( s )( )
			end if

			if( lex.ctx->deflen = 0 ) then
				DZstrAssign( lex.ctx->deftext, text )
			else
				DZstrAssign( lex.ctx->deftext, text + *lex.ctx->defptr )
			end if

			lgt = len( text )

		'' just load text as-is
		else

			'' arg-less macro?
			if( symbGetDefineIsArgless( s ) ) then
				var hasParens = FALSE
				var hasWhitespace = lexEatWhitespace( )

				'' '('?
				if( lexCurrentChar( ) = CHAR_LPRNT ) then
					hasParens = TRUE
				end if

				if( (symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_NEEDPARENS) <> 0 ) then
					if( hasParens = FALSE ) then
						'' not an error, macro can be passed as param to other macros
						exit function
					end if
				else
					'' parens optional? then whitespace before '(' will determine that the '('
					'' is part of the first argument instead of starting the argument list
					hasParens and= not hasWhitespace
				end if

				if( hasParens ) then
					lexEatChar( )
					lexEatWhitespace( )

					'' ')'
					if( lexCurrentChar( ) <> CHAR_RPRNT ) then
						errReport( FB_ERRMSG_EXPECTEDRPRNT )
					else
						lexEatChar( )
					end if
				end if
			end if

			if( symbGetType( s ) <> FB_DATATYPE_WCHAR ) then
				if( lex.ctx->deflen = 0 ) then
					DZstrAssign( lex.ctx->deftext, symbGetDefineText( s ) )
				else
					DZstrAssign( lex.ctx->deftext, _
								 *symbGetDefineText( s ) + *lex.ctx->defptr )
				end if

			else
				if( lex.ctx->deflen = 0 ) then
					DZstrAssignW( lex.ctx->deftext, symbGetDefineTextW( s ) )
				else
					DZstrAssign( lex.ctx->deftext, _
								 str( *symbGetDefineTextW( s ) ) + *lex.ctx->defptr )
				end if
			end if

			lgt = symbGetLen( s )
		end if

	end if

	''
	lex.ctx->defptr = lex.ctx->deftext.data
	lex.ctx->deflen += lgt

	'' force a re-read
	lex.ctx->currchar = cuint( INVALID )

	function = TRUE

end function

private function hLoadMacroW _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

	dim as FB_DEFPARAM ptr param = any, nextparam = any
	dim as FB_DEFTOK ptr dt = any
	dim as FBTOKEN t = any
	dim as LEXPP_ARGTB ptr argtb = any
	dim as integer prntcnt = any, lgt = any, num = any, reached_vararg = any, is_variadic = any
	dim as wstring ptr argtext = any
	static as DWSTRING text

	function = -1

	var hasParens = FALSE
	var hasWhitespace = lexEatWhitespace( )

	'' '('?
	if( lexCurrentChar( ) = CHAR_LPRNT ) then
		hasParens = TRUE
	end if

	if( (symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_NEEDPARENS) <> 0 ) then
		if( hasParens = FALSE ) then
			'' not an error, macro can be passed as param to other macros
			exit function
		end if
	else
		'' parens optional? then whitespace before '(' will determine that the '('
		'' is part of the first argument instead of starting the argument list
		hasParens and= not hasWhitespace
	end if

	if (isMacroAllowed(s) = FALSE) then
		exit function
	end if

	pp.invoking += 1

	if( hasParens ) then
		lexEatChar( )
	end if

	'' allocate a new arg list (because the recursivity)
	param = symbGetDefineHeadParam( s )
	if( param <> NULL ) then
		argtb = listNewNode( @pp.argtblist )
	else
		argtb = NULL
	end if

	prntcnt = 1
	reached_vararg = FALSE

	'' Variadic macro?
	is_variadic = ((s->def.flags and FB_DEFINE_FLAGS_VARIADIC) <> 0)

	var readdchar = -1

	'' for each arg
	num = 0 '' num represents the current last cleared/used entry in the argtb
	if( argtb ) then
		argtb->count = 0
	end if
	do
		if( argtb ) then
			'' argtb entries must be cleared! (it's a NOCLEAR list)
			DWstrZero( argtb->tb(num).textw )
		end if

		nextparam = symbGetDefParamNext( param )

		'' Last param?
		if( nextparam = NULL ) then
			reached_vararg = is_variadic
		end if

		'' read text until a comma or right-parentheses is found
		do
			lexNextToken( @t, LEXCHECK_NOWHITESPC or _
							  LEXCHECK_NOSUFFIX or _
							  LEXCHECK_NOQUOTES or _
							  LEXCHECK_NOPERIOD )

			select case as const t.id
			'' (
			case CHAR_LPRNT
				prntcnt += 1

			'' )
			case CHAR_RPRNT
				if( prntcnt > 0 ) then
					prntcnt -= 1

					'' determine if we need to add back the right paren ')'
					'' if parens were optional and we didn't have any parens
					'' for this macro to start with, we need to add back the
					'' right paren ')' since it will be needed by the caller.
					if( prntcnt = 0 ) then
						if( (symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_NEEDPARENS) = 0 ) then
							if( hasParens = FALSE ) then
								if( argtb->count >= symbGetDefineParams( s ) ) then
									if( pp.invoking > 1 ) then
										readdchar = CHAR_RPRNT
									end if
								end if
							end if
						end if

						'' Closing ')'
						exit do
					end if
				end if

			'' ,
			case CHAR_COMMA
				'' A comma indicates the next arg, so we should
				'' end the current arg now, unless we're at the
				'' "..." vararg, which just "absorbs" everything
				'' until the closing ')'.
				if( prntcnt = 1 ) then

					'' Check if comma is ending the macro list of arguments:
					'' if parens are optional and we didn't have any parens
					'' for this macro to start with, and we now have enough
					'' arguments to satisfy the macro, then we can consider
					'' the macro call complete.  Add back the comma for the
					'' caller.
					if( (symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_NEEDPARENS) = 0 ) then
						if( is_variadic = FALSE ) then
							if( hasParens = FALSE ) then
								if( argtb->count >= symbGetDefineParams( s ) ) then
									if( pp.invoking > 1 ) then
										readdchar = CHAR_COMMA
									end if
									prntcnt = 0
									exit do
								end if
							end if
						end if
					end if

					if( argtb ) then
						if( argtb->count = 0 ) then
							argtb->count = 1
						end if
						argtb->count += 1
					endif
					if( reached_vararg = FALSE ) then
						exit do
					end if
				end if

			case FB_TK_STMTSEP
				if( not hasParens ) then
					readdchar = CHAR_COLON
					prntcnt = 0
					exit do
				end if

			case FB_TK_EOL, FB_TK_EOF
				if( hasParens ) then
					hReportMacroError( s, FB_ERRMSG_EXPECTEDRPRNT )
				else
					readdchar = iif(t.id = FB_TK_EOF, 0, CHAR_LF)
				end if
				prntcnt = 0
				exit do

			case CHAR_SPACE, CHAR_TAB

			case else
				if( argtb ) then
					if( argtb->count = 0 ) then
						argtb->count = 1
					end if
				endif

			end select

			'' we are still in an argument, so just join the current
			'' token to the current argument
			if( argtb <> NULL ) then
				if( t.dtype <> FB_DATATYPE_WCHAR ) then
					DWstrConcatAssignA( argtb->tb(num).textw, t.text )
				else
					DWstrConcatAssign( argtb->tb(num).textw, t.textw )
				end if
			end if
		loop

		if( argtb ) then
			with( argtb->tb(num) )
				'' Arguments are allowed to be empty, so must check for NULL
				if( .textw.data ) then
					'' Trim space
					if( (.textw.data[0][0] = CHAR_SPACE) or _
						(.textw.data[0][len( *.textw.data )-1] = CHAR_SPACE) ) then
						DWstrAssign( .textw, trim( *.textw.data ) )
					end if
				end if
			end with
		end if

		'' Reached closing parentheses?
		if( prntcnt = 0 ) then
			'' End of param list not yet reached?
			if( nextparam ) then
				'' Too few args specified. This is an error, unless it's
				'' only the "..." vararg param that wasn't given any arg.

				'' Not the last param, or not variadic?
				if( (symbGetDefParamNext( nextparam ) <> NULL) or (not is_variadic) ) then
					hReportMacroError( s, FB_ERRMSG_ARGCNTMISMATCH )
				end if

				'' Clear any missing args
				assert( num < (symbGetDefineParams( s ) - 1) )
				do
					num += 1
					'' argtb entries must be cleared! (it's a NOCLEAR list)
					DWstrZero( argtb->tb(num).textw )
				loop while( num < (symbGetDefineParams( s ) - 1) )
			end if

			exit do
		end if

		'' Reached end of param list?
		if( nextparam = NULL ) then
			'' Too many args specified
			hReportMacroError( s, FB_ERRMSG_ARGCNTMISMATCH )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE, LEX_FLAGS )
			exit do
		end if

		'' Next
		param = nextparam
		num += 1
	loop

	'' text = ""
	DWstrAssign( text, NULL )

	'' should we call a function to get definition text?
	if( symbGetMacroCallbackZ( s ) <> NULL ) then
		'' call function
		var errnum = FB_ERRMSG_OK
		'' hander for wstring?
		if( symbGetMacroCallbackW( s ) ) then
			var res = symbGetMacroCallbackW( s )( argtb, @errnum )
			if( errnum = FB_ERRMSG_OK ) then
				DWstrAssign( text, res )
			else
				hReportMacroError( s, errnum )
			end if
		else
			var res = symbGetMacroCallbackZ( s )( argtb, @errnum )
			if( errnum = FB_ERRMSG_OK ) then
				DWstrAssignA( text, res )
			else
				hReportMacroError( s, errnum )
			end if
		end if

	'' just load text as-is
	else
		if( argtb ) then
			dt = symbGetDefineHeadToken( s )
			do while( dt )
				select case as const( symbGetDefTokType( dt ) )
				'' parameter?
				case FB_DEFTOK_TYPE_PARAM
					assert( symbGetDefTokParamNum( dt ) <= num )
					argtext = argtb->tb( symbGetDefTokParamNum( dt ) ).textw.data

					'' Only if not empty ("..." param can be empty)
					if( argtext <> NULL ) then
						DWstrConcatAssign( text, argtext )
					end if

				'' stringize parameter?
				case FB_DEFTOK_TYPE_PARAMSTR
					assert( symbGetDefTokParamNum( dt ) <= num )
					argtext = argtb->tb( symbGetDefTokParamNum( dt ) ).textw.data

					'' Only if not empty ("..." param can be empty)
					if( argtext <> NULL ) then
						'' don't escape, preserve the sequencies as-is
						DWstrConcatAssign( text, "$" + QUOTE )
						DWstrConcatAssign( text, *hReplaceW( argtext, QUOTE, QUOTE + QUOTE ) )
						DWstrConcatAssign( text, QUOTE )
					else
						'' If it's empty, produce an empty string ("")
						DWstrConcatAssign( text, QUOTE + QUOTE )
					end if

				'' ordinary text..
				case FB_DEFTOK_TYPE_TEX
					DWstrConcatAssignA( text, symbGetDefTokText( dt ) )

				'' unicode text?
				case FB_DEFTOK_TYPE_TEXW
					DWstrConcatAssign( text, symbGetDefTokTextW( dt ) )
				end select

				'' next
				dt = symbGetDefTokNext( dt )
			loop

			'' free args text
			do while( num > 0 )
				num -= 1
				DWstrAssign( argtb->tb(num).textw, NULL )
			loop

			listDelNode( @pp.argtblist, argtb )
		end if
	end if

	if( readdchar <> -1 ) then
		DWstrConcatAssignA( text, chr(readdchar) )
	end if

	if( lex.ctx->deflen = 0 ) then
		DWstrAssign( lex.ctx->deftextw, text.data )
	else
		DWstrAssign( lex.ctx->deftextw, *text.data + *lex.ctx->defptrw )
	end if

	pp.invoking -= 1

	function = len( *text.data )

end function

''::::
private function hLoadDefineW _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

	static as DWSTRING text
	dim as integer lgt = any

	function = FALSE

	'' define has args?
	if( symbGetDefineParams( s ) > 0 ) then

		lgt = hLoadMacroW( s )
		if( lgt = -1 ) then
			exit function
		end if

	'' no args
	else

		'' should we call a function to get definition text?
		if( symbGetDefineCallback( s ) <> NULL ) then
			'' call function
			if( symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_STR ) then
				DWstrAssignA( text, "$" + QUOTE + symbGetDefineCallback( s )( ) + QUOTE )
			else
				DWstrAssignA( text, symbGetDefineCallback( s )( ) )
			end if

			if( lex.ctx->deflen = 0 ) then
				DWstrAssign( lex.ctx->deftextw, text.data )
			else
				DWstrAssign( lex.ctx->deftextw, *text.data + *lex.ctx->defptrw )
			end if

			lgt = len( *text.data )

		'' just load text as-is
		else

			'' arg-less macro?
			if( symbGetDefineIsArgless( s ) ) then
				var hasParens = FALSE
				var hasWhitespace = lexEatWhitespace( )

				'' '('?
				if( lexCurrentChar( ) = CHAR_LPRNT ) then
					hasParens = TRUE
				end if

				if( (symbGetDefineFlags( s ) and FB_DEFINE_FLAGS_NEEDPARENS) <> 0 ) then
					if( hasParens = FALSE ) then
						'' not an error, macro can be passed as param to other macros
						exit function
					end if
				else
					'' parens optional? then whitespace before '(' will determine that the '('
					'' is part of the first argument instead of starting the argument list
					hasParens and= not hasWhitespace
				end if

				if( hasParens ) then
					lexEatChar( )
					lexEatWhitespace( )

					'' ')'
					if( lexCurrentChar( ) <> CHAR_RPRNT ) then
						errReport( FB_ERRMSG_EXPECTEDRPRNT )
					else
						lexEatChar( )
					end if
				end if
			end if

			if( symbGetType( s ) <> FB_DATATYPE_WCHAR ) then
				if( lex.ctx->deflen = 0 ) then
					DWstrAssignA( lex.ctx->deftextw, symbGetDefineText( s ) )
				else
					DWstrAssign( lex.ctx->deftextw, _
								 wstr( *symbGetDefineText( s ) ) + *lex.ctx->defptrw )
				end if

			else
				if( lex.ctx->deflen = 0 ) then
					DWstrAssign( lex.ctx->deftextw, symbGetDefineTextW( s ) )
				else
					DWstrAssign( lex.ctx->deftextw, _
								 *symbGetDefineTextW( s ) + *lex.ctx->defptrw )
				end if
			end if

			lgt = symbGetLen( s )
		end if

	end if

	''
	lex.ctx->defptrw = lex.ctx->deftextw.data
	lex.ctx->deflen += lgt

	function = TRUE

end function

''::::
function ppDefineLoad _
	( _
		byval s as FBSYMBOL ptr, _
		byval currmacro as FBSYMBOL ptr _
	) as integer

	'' recursion?
	if( s = currmacro ) then
		errReport( FB_ERRMSG_RECURSIVEMACRO )
		'' error recovery: skip
		hSkipUntil( INVALID, FALSE, LEX_FLAGS )
		return TRUE
	end if

	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
		function = hLoadDefine( s )
	else
		function = hLoadDefineW( s )
	end if

	'' Not empty?
	if( lex.ctx->deflen > 0 ) then
		'' Set currmacro if there is no other currmacro yet,
		'' to prevent at least trivial recursion
		if( lex.ctx->currmacro = NULL ) then
			lex.ctx->currmacro = s
		end if
	end if

	'' force a re-read
	lex.ctx->currchar = cuint( INVALID )

end function

'':::::
private function hRtrimMacroText _
	( _
		byval tokhead as FB_DEFTOK ptr, _
		byval toktail as FB_DEFTOK ptr _
	) as FB_DEFTOK ptr

	'' remove the white-spaces
	do while( toktail <> NULL )
		'' not ascii text?
		if( symbGetDefTokType( toktail ) <> FB_DEFTOK_TYPE_TEX ) then
			exit do
		end if

		select case as const (*symbGetDefTokText( toktail ))[0]
		'' space or nl?
		case CHAR_SPACE, CHAR_TAB, CHAR_LF
			toktail = symbDelDefineTok( toktail )

		case else
			exit do
		end select
	loop

	if( toktail = NULL ) then
		function = NULL
	else
		function = tokhead
	end if

end function

'':::::
private function hReadMacroText _
	( _
		byval args as integer, _
		byval paramhead as FB_DEFPARAM ptr, _
		byval ismultiline as integer _
	) as FB_DEFTOK ptr

	static as zstring * FB_MAXNAMELEN+1 arg
	dim as FB_DEFPARAM ptr param = any
	dim as FB_DEFTOK ptr toktail = NULL, tokhead = NULL
	dim as integer addquotes = any, nestedcnt = 0

	do
		addquotes = FALSE

		select case as const lexGetToken( LEX_FLAGS )
		case FB_TK_EOF
			if( ismultiline ) then
				errReport( FB_ERRMSG_EXPECTEDMACRO )
			end if

			exit do

		case FB_TK_EOL
			if( ismultiline = FALSE ) then
				exit do
			end if

			'' multi-line, only add if it's not at the beginning
			if( tokhead <> NULL ) then
				toktail = symbAddDefineTok( toktail, FB_DEFTOK_TYPE_TEX )
				'' just lf
				ZstrAssign( @toktail->text, LFCHAR )
			end if

			lexSkipToken( LEX_FLAGS )

			continue do

		case FB_TK_COMMENT, FB_TK_REM
			if( ismultiline = FALSE ) then
				exit do
			end if

			do
				lexSkipToken( LEX_FLAGS )

				select case lexGetToken( LEX_FLAGS )
				case FB_TK_EOL, FB_TK_EOF
					exit do
				end select
			loop

			continue do

		case CHAR_SHARP
			select case lexGetLookAhead( 1, (LEX_FLAGS or LEXCHECK_KWDNAMESPC) and _
			                                (not LEXCHECK_NOWHITESPC) )
			'' '##'?
			case CHAR_SHARP
				lexSkipToken( LEX_FLAGS )
				lexSkipToken( LEX_FLAGS or LEXCHECK_NOLINECONT)
				continue do

			'' '#' macro?
			case FB_TK_PP_MACRO
				if( ismultiline ) then
					nestedcnt += 1
				end if

			'' '#' endmacro?
			case FB_TK_PP_ENDMACRO
				if( ismultiline ) then
					'' not nested?
					if( nestedcnt = 0 ) then
						lexSkipToken( LEX_FLAGS )
						'' no LEX_FLAGS, white-spaces must be skipped
						lexSkipToken( )

						tokhead = hRtrimMacroText( tokhead, toktail )

						exit do
					end if

					nestedcnt -= 1
				end if

			'' '#' id?
			case FB_TK_ID
				'' note: using the PP hashtb here, non-PP keyword will be ID's
				lexSkipToken( LEX_FLAGS )
				addquotes = TRUE
			end select

		'' white space?
		case CHAR_SPACE, CHAR_TAB

			'' only add if it's not at the beginning
			if( tokhead <> NULL ) then
				toktail = symbAddDefineTok( toktail, FB_DEFTOK_TYPE_TEX )
				'' condensed to a single white-space
				ZstrAssign( @toktail->text, " " )
			end if

			lexSkipToken( LEX_FLAGS )

			continue do

		end select

		select case as const lexGetClass( LEX_FLAGS )
		'' string literal? preserve quotes
		case FB_TKCLASS_STRLITERAL

			'' ascii?
			if( env.inf.format = FBFILE_FORMAT_ASCII ) then
				toktail = symbAddDefineTok( toktail, FB_DEFTOK_TYPE_TEX )
				if( tokhead = NULL ) then
					tokhead = toktail
				end if

				ZstrAssign( @toktail->text, lexGetText( ) )

			'' unicode..
			else
				toktail = symbAddDefineTok( toktail, FB_DEFTOK_TYPE_TEXW )
				if( tokhead = NULL ) then
					tokhead = toktail
				end if

				WstrAssign( @toktail->textw, lexGetTextW( ) )
			end if

			lexSkipToken( LEX_FLAGS )

		'' identifier? check if it's a parameter (params can be keywords too)
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
			toktail = symbAddDefineTok( toktail, FB_DEFTOK_TYPE_TEX )
			if( tokhead = NULL ) then
				tokhead = toktail
			end if

			arg = ucase( *lexGetText( ) )

			'' look up..
			param = hashLookup( @symb.def.paramhash, arg )

			'' found?
			if( param <> NULL ) then
				if( addquotes = FALSE ) then
					symbSetDefTokType( toktail, FB_DEFTOK_TYPE_PARAM )
				else
					symbSetDefTokType( toktail, FB_DEFTOK_TYPE_PARAMSTR )
				end if

				symbSetDefTokParamNum( toktail, symbGetDefParamNum( param ) )

			'' none matched, read as-is
			else
				'' restore the '#'?
				if( addquotes ) then
					ZstrAssign( @toktail->text, "#" )
					ZstrConcatAssign( @toktail->text, lexGetText( ) )
				else
					ZstrAssign( @toktail->text, lexGetText( ) )
				end if
			end if

			lexSkipToken( LEX_FLAGS )

		'' anything else, read as-is
		case else
			toktail = symbAddDefineTok( toktail, FB_DEFTOK_TYPE_TEX )
			if( tokhead = NULL ) then
				tokhead = toktail
			end if

			ZstrAssign( @toktail->text, lexGetText( ) )
			lexSkipToken( LEX_FLAGS )

		end select

	loop

	function = tokhead

end function

'':::::
private sub hReadDefineText _
	( _
		byval sym as FBSYMBOL ptr, _
		byval defname as zstring ptr, _
		byval isargless as integer, _
		byval ismultiline as integer, _
		byval flags as integer _
	)

	dim as zstring ptr text = any
	dim as wstring ptr textw = any

	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
		'' LITERAL*
		text = ppReadLiteral( ismultiline )

		'' already defined? if there are no differences, do nothing..
		if( sym <> NULL ) then
			if( (symbGetDefineParams( sym ) > 0) or _
				(symbGetType( sym ) <> FB_DATATYPE_CHAR) ) then
				errReportEx( FB_ERRMSG_DUPDEFINITION, defname )
			elseif( (*symbGetDefineText( sym ) <> *text) ) then
				errReportEx( FB_ERRMSG_DUPDEFINITION, defname )
			end if
		else
			symbAddDefine( defname, text, len( *text ), isargless, , flags )
		end if

	'' unicode..
	else
		'' LITERAL*
		textw = ppReadLiteralW( ismultiline )

		'' already defined? if there are no differences, do nothing..
		if( sym <> NULL ) then
			if( (symbGetDefineParams( sym ) > 0) or _
				(symbGetType( sym ) <> FB_DATATYPE_WCHAR) ) then
				errReportEx( FB_ERRMSG_DUPDEFINITION, defname )
			elseif( (*symbGetDefineTextW( sym ) <> *textw) ) then
				errReportEx( FB_ERRMSG_DUPDEFINITION, defname )
			end if
		else
			symbAddDefineW( defname, textw, len( *textw ), isargless, , flags )
		end if

	end if
end sub

private function hMatchParamEllipsis( ) as integer

	const FLAGS = LEXCHECK_NODEFINE or LEXCHECK_NOSYMBOL

	function = FALSE

	'' '...' ?
	if( lexGetToken( FLAGS ) = CHAR_DOT ) then
		if( lexGetLookAhead( 1, FLAGS ) = CHAR_DOT ) then
			if( lexGetLookAhead( 2, FLAGS ) = CHAR_DOT ) then
				'' Skip the dots
				lexSkipToken( FLAGS )
				lexSkipToken( FLAGS )
				lexSkipToken( FLAGS )
				function = TRUE
			end if
		end if
	end if

end function

'':::::
'' Define           =   DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL+
''                  |   MACRO ID '?'? '(' ID (',' ID)* ')' Comment? EOL
''                          MacroBody*
''                      ENDMACRO .
sub ppDefine( byval ismultiline as integer )
	static as zstring * FB_MAXNAMELEN+1 defname
	dim as integer params = any, isargless = any, flags = any
	dim as FB_DEFPARAM ptr paramhead = any, lastparam = any
	dim as FBSYMBOL ptr sym = any
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr base_parent = any
	dim as FB_DEFTOK ptr tokhead = any
	dim as FB_DEFINE_FLAGS define_flags = any

	'' note: using the PP hashtb here, so any non-PP keyword won't be found

	'' don't allow explicit namespaces
	chain_ = cIdentifier( base_parent, FB_IDOPT_ISDECL or FB_IDOPT_DEFAULT )

	flags = LEX_FLAGS
	if( ismultiline ) then
		flags and= not LEXCHECK_NOWHITESPC
	end if

	lexEatToken( @defname, flags )

	if( hIsValidSymbolName( defname ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit sub
	end if

	'' contains a period? (with LEX_FLAGS it won't skip white spaces)
	if( lexGetToken( flags ) = CHAR_DOT ) then
		errReport( FB_ERRMSG_CANTINCLUDEPERIODS )
	end if

	if( chain_ <> NULL ) then
		sym = chain_->sym
		if( symbIsDefine( sym ) = FALSE ) then
			'' defines have no dups or respect namespaces
			if( symbGetCanRedef( sym ) ) then
				errReportWarn( FB_WARNINGMSG_REDEFINITIONOFINTRINSIC )
				'' remove from lookup, but not type symbol data, it
				'' may be referenced from elsewhere
				symbDelFromHash( sym )
				sym = NULL
			else
				errReportEx( FB_ERRMSG_DUPDEFINITION, @defname )
				'' error recovery: fake an id
				defname = *symbUniqueLabel( )
			end if
		end if
	else
		sym = NULL
	end if

	params = 0
	paramhead = NULL
	isargless = FALSE
	define_flags = FB_DEFINE_FLAGS_NEEDPARENS


	'' #macro?
	if( ismultiline ) then
		'' '?'?
		if( lexGetToken( flags ) = CHAR_QUESTION ) then
			lexSkipToken( LEXCHECK_NODEFINE )
			define_flags and= NOT FB_DEFINE_FLAGS_NEEDPARENS
		end if
	end if


	'' '('?
	if( lexGetToken( flags ) = CHAR_LPRNT ) then
		lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_NOSYMBOL )

		'' not arg-less?
		if( lexGetToken( LEXCHECK_NODEFINE or LEXCHECK_NOSYMBOL ) <> CHAR_RPRNT ) then
			lastparam = NULL
			do
				select case as const lexGetClass( )
				case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
					lastparam = symbAddDefineParam( lastparam, lexGetText( ) )

				case else
					errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
					'' error recovery: fake a param
					lastparam = symbAddDefineParam( lastparam, symbUniqueLabel( ) )
				end select

				if( lastparam = NULL ) then
					errReport( FB_ERRMSG_DUPDEFINITION )
				end if

				lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_NOSYMBOL )

				params += 1
				if( params >= FB_MAXDEFINEARGS ) then
					errReport( FB_ERRMSG_TOOMANYPARAMS )
					'' error recovery: skip until next ')'
					hSkipUntil( CHAR_RPRNT, TRUE )
					exit sub
				end if

				if( paramhead = NULL ) then
					paramhead = lastparam
				end if

				'' ','?
				if( lexGetToken( LEXCHECK_NODEFINE or LEXCHECK_NOSYMBOL ) <> CHAR_COMMA ) then
					exit do
				end if

				lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_NOSYMBOL )
			loop

			'' Check for ellipsis after the last parameter's name, before the ')'.
			'' (variadic macros)
			if( hMatchParamEllipsis( ) ) then
				define_flags or= FB_DEFINE_FLAGS_VARIADIC
			end if
		else
			isargless = TRUE
		end if

		'' ')'
		if( lexGetToken( LEX_FLAGS ) <> CHAR_RPRNT ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE, LEX_FLAGS )
		else
			lexSkipToken( LEX_FLAGS and (not LEXCHECK_NOWHITESPC) )
		end if
	else
		if( ismultiline = FALSE ) then
			if( lexGetToken( LEX_FLAGS ) = CHAR_SPACE ) then
				'' skip white-spaces
				lexSkipToken( LEX_FLAGS and not LEXCHECK_NOWHITESPC )
			end if
		end if
	end if

	'' not a macro?
	if( params = 0 ) then
		hReadDefineText( sym, @defname, isargless, ismultiline, define_flags )
		exit sub
	end if

	'' macro..
	'' already defined? can't check..
	if( sym <> NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, defname )
	else
		tokhead = hReadMacroText( params, paramhead, ismultiline )
		symbAddDefineMacro( @defname, tokhead, params, paramhead, define_flags )
	end if
end sub
