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

'' pre-processor #define parsing (including macros)
''
'' chng: dec/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\pp.bi"
#include once "inc\list.bi"

#define LIT_FLAGS LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX or LEXCHECK_NODEFINE or LEXCHECK_NOQUOTES

type LEXPP_CTX
	argtblist	as TLIST
end type

type LEXPP_ARG
	text		as string
end type

type LEXPP_ARGTB
	ll_prv		as LEXPP_ARGTB ptr				'' linked-list nodes
	ll_nxt		as LEXPP_ARGTB ptr				'' /

	tb(0 to FB_MAXDEFINEARGS-1) as LEXPP_ARG
end type

'' globals
	dim shared ctx as LEXPP_CTX

''::::
sub ppDefineInit( )

	listNew( @ctx.argtblist, 5, len( LEXPP_ARGTB ), FALSE )

end sub

''::::
sub ppDefineEnd( )

	listFree( @ctx.argtblist )

end sub


''::::
function ppDefineLoad( byval s as FBSYMBOL ptr ) as integer
    dim as FBDEFARG ptr arg
    dim as FBDEFTOK ptr dt
    dim as FBTOKEN t
    dim as LEXPP_ARGTB ptr argtb
    dim as integer prntcnt, lgt, num
    static as string text

    function = FALSE

	'' define has args?
	if( symbGetDefineArgs( s ) > 0 ) then

		'' '('
		lexNextToken( t, LEXCHECK_NOSUFFIX )
		if( t.id <> CHAR_LPRNT ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

		prntcnt = 1
		if( symbGetDefineHeadToken( s ) ) then
			argtb = cptr( LEXPP_ARGTB ptr, listNewNode( @ctx.argtblist ) )
		else
			argtb = NULL
		end if

		'' for each arg
		arg = symbGetDefineHeadArg( s )
		num = 0
		do
			if( argtb <> NULL ) then
				ZEROSTRDESC( argtb->tb(num).text )
			end if

			'' read text until a comma or right-parentheses is found
			do
				lexNextToken( t, LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX or LEXCHECK_NOQUOTES )
				select case t.id
				'' (
				case CHAR_LPRNT
					prntcnt += 1
				'' )
				case CHAR_RPRNT
					prntcnt -= 1
					if( prntcnt = 0 ) then
						exit do
					end if
				'' ,
				case CHAR_COMMA
					if( prntcnt = 1 ) then
						exit do
					end if
				''
				case FB_TK_EOL, FB_TK_EOF
					hReportError( FB_ERRMSG_EXPECTEDRPRNT )
					exit function
				end select

                if( argtb <> NULL ) then
    				with argtb->tb(num)
    					.text += t.text
    				end with
    			end if
            loop

			if( argtb <> NULL ) then
				'' trim
				with argtb->tb(num)
					if( (.text[0] = CHAR_SPACE) or _
						(.text[len( .text )-1] = CHAR_SPACE) ) then
						.text = trim( .text )
					end if
				end with
			end if

			'' closing parentheses?
			if( prntcnt = 0 ) then
				exit do
			end if

			'' next
			arg = symbGetDefArgNext( arg )
			num += 1
		loop while( arg <> NULL )

		''
		text = ""

		if( argtb <> NULL ) then
			dt = symbGetDefineHeadToken( s )
			do while( dt <> NULL )
				select case symbGetDefTokType( dt )
				'' argument?
				case FB_DEFTOK_TYPE_ARG
					text += argtb->tb(symbGetDefTokArgNum( dt )).text

				'' stringize argument?
				case FB_DEFTOK_TYPE_ARGSTR
					text += "\""
					text += hReplace( argtb->tb(symbGetDefTokArgNum( dt )).text, "\"", "\"\"" )
					text += "\""

				'' ordinary text..
				case FB_DEFTOK_TYPE_TEX
					text += symbGetDefTokText( dt )

				end select

				'' next
				dt = symbGetDefTokNext( dt )
			loop

			''
			listDelNode( @ctx.argtblist, cptr( TLISTNODE ptr, argtb ) )
		end if

		lgt = len( text )

		''
		if( lex.deflen = 0 ) then
			lex.deftext = text
		else
			lex.deftext = text + *lex.defptr
		end if

	'' no args
	else

		'' should we call a function to get definition text?
		if( symbGetDefineCallback( s ) <> NULL ) then
			'' call function
            if( not bit( symbGetDefineFlags( s ), 0 ) ) then
				s->def.text = "\"" + symbGetDefineCallback( s )( ) + "\""
            else
				s->def.text = symbGetDefineCallback( s )( )
            end if

            lgt = len( symbGetDefineText( s ) )

		'' just load text as-is
		else
			if( symbGetDefineIsArgless( s ) ) then
				'' '(' ')'?
				if( lexCurrentChar( ) = CHAR_LPRNT ) then
					if( lexGetLookAheadChar( TRUE ) = CHAR_RPRNT ) then
						lexEatChar( )
						lexEatChar( )
					end if
				end if
			end if

            lgt = symbGetLen( s )
		end if

		if( lex.deflen = 0 ) then
			lex.deftext = symbGetDefineText( s )
		else
			lex.deftext = symbGetDefineText( s ) + *lex.defptr
		end if

	end if

    ''
	lex.defptr = @lex.deftext
	lex.deflen += lgt

	if( lex.deflen > FB_MAXINTDEFINELEN ) then
		lex.deflen = FB_MAXINTDEFINELEN
		hReportError( FB_ERRMSG_MACROTEXTTOOLONG )
		exit function
	end if

	'' force a re-read
	lex.currchar = cuint( INVALID )

	function = TRUE

end function

'':::::
private function hReadMacroText( byval args as integer, _
						   		 byval arghead as FBDEFARG ptr ) as FBDEFTOK ptr

	static as zstring * FB_MAXNAMELEN+1 token
    dim as integer dpos, num, addquotes
    dim as FBDEFARG ptr arg
    dim as FBDEFTOK ptr tok, tokhead

    tok = NULL
    tokhead = NULL

    do
    	select case lexGetToken( LIT_FLAGS )
		case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
			exit do
		end select

		tok = symbAddDefineTok( tok, FB_DEFTOK_TYPE_TEX )

		if( tokhead = NULL ) then
			tokhead = tok
		end if

    	'' preserve quotes if it's a string literal
    	if( lexGetClass( LIT_FLAGS ) = FB_TKCLASS_STRLITERAL ) then
    		'' un-espace it if option escape is on
    		if( env.opt.escapestr ) then
    			tok->text += hUnescapeStr( *lexGetText( ) )
    		else
    			tok->text += *lexGetText( )
    		end if

    		lexSkipToken( LIT_FLAGS )

    	else

    		addquotes = FALSE

    		'' '#'?
    		if( lexGetToken( LIT_FLAGS ) = CHAR_SHARP ) then
    			select case lexGetLookAhead( 1, LIT_FLAGS )
    			'' '##'?
    			case CHAR_SHARP
    				lexSkipToken( LIT_FLAGS )
    				lexSkipToken( LIT_FLAGS )
    				continue do

    			'' '#' id?
    			case FB_TK_ID
    			    lexSkipToken( LIT_FLAGS )
    			    addquotes = TRUE
    			end select
    		end if

    		'' not and identifier? read as-is
    		if( lexGetToken( LIT_FLAGS ) <> FB_TK_ID ) then
    			tok->text = *lexGetText( )
    			lexSkipToken( LIT_FLAGS )

    		'' otherwise, check if it's an argument
    		else
    			token = ucase( *lexGetText( ) )
    			'' contains a period? assume it's an udt access
    			dpos = lexGetPeriodPos( )
    			if( dpos > 1 ) then
    				token[dpos-1] = 0 			'' token = left( token, dpos-1 )
    			end if

    			'' for each define arg..
    			arg = arghead
    			num = 0
    			do
    				'' same?
    				if( token = symbGetDefArgName( arg ) ) then

						if( not addquotes ) then
							symbSetDefTokType( tok, FB_DEFTOK_TYPE_ARG )
						else
							symbSetDefTokType( tok, FB_DEFTOK_TYPE_ARGSTR )
						end if

						symbSetDefTokArgNum( tok, num )

    					'' add the remainder if it's an udt access
    					if( dpos > 1 ) then
    						tok = symbAddDefineTok( tok, FB_DEFTOK_TYPE_TEX )
    						lexEatToken( token, LIT_FLAGS )
    						tok->text = *cptr( zstring ptr, @token[dpos-1] ) ''mid( token, dpos )
    					else
    						lexSkipToken( LIT_FLAGS )
    					end if

    					exit do
    				end if

    				'' next arg
    				arg = symbGetDefArgNext( arg )
    				num += 1
    			loop while( arg <> NULL )

    			'' if none matched, read as-is
    			if( arg = NULL ) then
    				tok->text = *lexGetText( )
    				lexSkipToken( LIT_FLAGS )
    			end if
    		end if

    	end if

    loop

	function = tokhead

end function

'':::::
function ppDefine( ) as integer
	static as zstring * FB_MAXNAMELEN+1 defname, argname
	dim as zstring ptr text
	dim as integer args, isargless, textlen
	dim as FBDEFARG ptr arghead, lastarg
	dim as FBSYMBOL ptr s
	dim as FBDEFTOK ptr tokhead

	function = FALSE

    '' ID
    s = lexGetSymbol( )
    if( s <> NULL ) then
    	if( not symbIsDefine( s ) ) then
    		hReportError( FB_ERRMSG_DUPDEFINITION )
    		exit function
    	end if
    end if

    lexEatToken( defname, LIT_FLAGS )

    args = 0
    arghead = NULL
    isargless = FALSE

    '' '('?
    if( lexGetToken( LIT_FLAGS ) = CHAR_LPRNT ) then
    	lexSkipToken( LEXCHECK_NODEFINE )

		'' not arg-less?
		if( lexGetToken( LEXCHECK_NODEFINE ) <> CHAR_RPRNT ) then
			lastarg = NULL
			do
		    	lexEatToken( argname, LEXCHECK_NODEFINE )
		    	lastarg = symbAddDefineArg( lastarg, @argname )
		    	args += 1

		    	if( arghead = NULL ) then
		    		arghead = lastarg
		    	end if

				'' ','?
				if( lexGetToken( LEXCHECK_NODEFINE ) <> CHAR_COMMA ) then
					exit do
				end if
		    	lexSkipToken( LEXCHECK_NODEFINE )
			loop

		else
			isargless = TRUE
		end if

    	'' ')'
    	if( lexGetToken( LIT_FLAGS ) <> CHAR_RPRNT ) then
    		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
    		exit function
    	end if
    	lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_NOQUOTES )

    else
    	if( lexGetToken( LIT_FLAGS ) = CHAR_SPACE ) then
    		'' skip white-spaces
    		lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_NOQUOTES )
    	end if
    end if

    '' not a macro?
    if( args = 0 ) then
    	'' LITERAL*
    	text = ppReadLiteral( )

    	'' check len, use the sentinel as "text" is a static zstring
    	textlen = len( *text )
    	if( textlen = FB_MAXINTDEFINELEN+1 ) then
			hReportError( FB_ERRMSG_MACROTEXTTOOLONG )
			exit function
    	end if

    	'' already defined? if there are no differences, do nothing..
    	if( s <> NULL ) then
    		if( (symbGetDefineArgs( s ) > 0) or _
    			(symbGetDefineText( s ) <> *text) ) then
    			hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    			exit function
    		end if

    	else
    		symbAddDefine( @defname, text, textlen, isargless )

    	end if

    '' macro..
    else
    	'' already defined? can't check..
    	if( s <> NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    		exit function
    	end if

        tokhead = hReadMacroText( args, arghead )

    	symbAddDefineMacro( @defname, tokhead, args, arghead )

    end if

	function = TRUE

end function

