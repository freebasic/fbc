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


'' pre-processor, lex's helper
''
'' chng: dec/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\parser.bi"
#include once "inc\list.bi"

declare function ppInclude					( ) as integer

declare function ppIncLib					( ) as integer

declare function ppLibPath					( ) as integer

declare function ppDefine					( ) as integer

declare function ppIf 						( ) as integer

declare function ppElse 					( )  as integer

declare function ppEndIf 					( ) as integer

declare function ppSkip 					( ) as integer

declare function ppLogExpression			( logexpr as integer ) as integer

declare function ppRelExpression			( relexpr as integer, _
											  rellit as string, _
											  relisnum as integer ) as integer

declare function ppParentExpr				( parexpr as integer, _
											  atom as string, _
											  isnumber as integer ) as integer

const FB_PP_MAXRECLEVEL = 64

type LEXPP_CTX
	level 		as integer
	argtblist	as TLIST
end type

type LEXPP_REC
	istrue		as integer
	elsecnt		as integer
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
	dim shared lexpp as LEXPP_CTX
	dim shared pptb(1 to FB_PP_MAXRECLEVEL) as LEXPP_REC


''::::
sub lexPPInit( )

	listNew( @lexpp.argtblist, 5, len( LEXPP_ARGTB ), FALSE )

end sub

''::::
sub lexPPEnd( )

	listFree( @lexpp.argtblist )

end sub

''::::
function lexPPLoadDefine( byval s as FBSYMBOL ptr ) as integer
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
			argtb = cptr( LEXPP_ARGTB ptr, listNewNode( @lexpp.argtblist ) )
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
			listDelNode( @lexpp.argtblist, cptr( TLISTNODE ptr, argtb ) )
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

#define LIT_FLAGS LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX or LEXCHECK_NODEFINE or LEXCHECK_NOQUOTES

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
private function hReadLiteral( ) as zstring ptr
	static as zstring * FB_MAXINTDEFINELEN+1+1 text			'' +1 sentinel..

    text = ""
    do
    	select case lexGetToken( LIT_FLAGS )
		case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
			exit do
		end select

    	'' literal string? un-escape it if option escape is on
    	if( (lexGetClass( LIT_FLAGS ) = FB_TKCLASS_STRLITERAL) and _
    		(env.opt.escapestr) ) then
    		text += hUnescapeStr( *lexGetText( ) )

    	else
    		text += *lexGetText( )
    	end if

    	lexSkipToken( LIT_FLAGS )

    loop

	function = @text

end function

'':::::
'' PreProcess    =   '#'DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL*
''               |   '#'UNDEF ID
''               |   '#'IFDEF ID
''               |   '#'IFNDEF ID
''               |   '#'IF Expression
''				 |	 '#'ELSE
''				 |   '#'ELSEIF Expression
''               |   '#'ENDIF
''               |   '#'PRINT LITERAL*
''				 |   '#'INCLUDE ONCE? LIT_STR
''				 |   '#'INCLIB LIT_STR
''				 |	 '#'LIBPATH LIT_STR
''				 |	 '#'ERROR LIT_STR .
''
function lexPreProcessor( ) as integer
    dim as FBSYMBOL ptr s

	function = FALSE

    '' note: when adding any new PP symbol, update ppSkip() too
    select case as const lexGetToken( )

    '' DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL+
    case FB_TK_DEFINE
    	lexSkipToken( LEXCHECK_NODEFINE )

    	function = ppDefine( )

	'' UNDEF ID
    case FB_TK_UNDEF
    	lexSkipToken( LEXCHECK_NODEFINE )

    	s = lexGetSymbol( )
    	if( s <> NULL ) then
    		symbDelSymbol( s )
    	end if

    	lexSkipToken( )

    	function = TRUE

	'' IFDEF ID
	'' IFNDEF ID
	'' IF ID '=' LITERAL
    case FB_TK_IFDEF, FB_TK_IFNDEF, FB_TK_IF
    	function = ppIf( )

	'' ELSE
	case FB_TK_ELSE, FB_TK_ELSEIF
    	function = ppElse( )

	'' ENDIF
	case FB_TK_ENDIF
		function = ppEndIf( )

	'' PRINT LITERAL*
	case FB_TK_PRINT, FB_TK_LPRINT
		lexSkipToken( )
		print *hReadLiteral( )
		function = TRUE

	'' ERROR LITERAL*
	case FB_TK_ERROR
		lexSkipToken( )
		hReportErrorEx( -1, *hReadLiteral( ) )
		exit function

	'' INCLUDE ONCE? LIT_STR
	case FB_TK_INCLUDE
		lexSkipToken( )
		function = ppInclude( )

	'' INCLIB LIT_STR
	case FB_TK_INCLIB
		lexSkipToken( )
        function = ppIncLib( )

	'' LIBPATH LIT_STR
	case FB_TK_LIBPATH
		lexSkipToken( )
		function = ppLibPath( )

	case else
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end select

	'' Comment?
	cComment( )

	'' EOL
	if( lexGetToken( ) <> FB_TK_EOL ) then
		if( lexGetToken( ) <> FB_TK_EOF ) then
			hReportError( FB_ERRMSG_EXPECTEDEOL )
			return FALSE
		end if
	end if

end function

'':::::
private function ppInclude( ) as integer
    static as zstring * FB_MAXPATHLEN+1 incfile
    dim as integer isonce

	function = FALSE

	'' ONCE?
	isonce = FALSE
	if( lexGetClass( ) = FB_TKCLASS_IDENTIFIER ) then
		if( ucase$( *lexGetText( ) ) = "ONCE" ) then
			lexSkipToken( )
			isonce = TRUE
		end if
	end if

	lexEatToken( incfile )

	function = fbIncludeFile( hUnescapeStr( incfile ), isonce )

end function

'':::::
private function ppIncLib( ) as integer
    static as zstring * FB_MAXPATHLEN+1 libfile

	lexEatToken( libfile )

	function = symbAddLib( hUnescapeStr( libfile ) ) <> NULL

end function

'':::::
private function ppLibPath( ) as integer
    static as zstring * FB_MAXPATHLEN+1 path

	lexEatToken( path )

	if( not fbAddLibPath( hUnescapeStr( path ) ) ) then
		hReportError( FB_ERRMSG_SYNTAXERROR, TRUE )
		return FALSE
	end if

	function = TRUE

end function

'':::::
private function ppDefine( ) as integer
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
    	text = hReadLiteral( )

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

'':::::
private function ppIf as integer
    dim istrue as integer
    dim d as FBSYMBOL ptr

    function = FALSE

	istrue = FALSE

	select case as const lexGetToken( )
	'' IFDEF ID
	case FB_TK_IFDEF
        lexSkipToken( LEXCHECK_NODEFINE )

		d = lexGetSymbol( )
		if( d <> NULL ) then
			'' any symbol is okay or type's wouldn't be found
			istrue = TRUE
		end if
		lexSkipToken( )

	'' IFNDEF ID
	case FB_TK_IFNDEF
        lexSkipToken( LEXCHECK_NODEFINE )

		d = lexGetSymbol( )
		if( d = NULL ) then
			'' ditto
			istrue = TRUE
		end if
		lexSkipToken( )

	'' IF Expression
	case FB_TK_IF
        lexSkipToken( )

		if( not ppLogExpression( istrue ) ) then
			exit function
		end if

	end select

	lexpp.level += 1
	if( lexpp.level > FB_PP_MAXRECLEVEL ) then
		hReportError( FB_ERRMSG_RECLEVELTOODEPTH )
		exit function
	end if

	pptb(lexpp.level).istrue = istrue
	pptb(lexpp.level).elsecnt = 0

    if( not istrue ) then
    	function = ppSkip( )
    else
		function = TRUE
	end if

end function

'':::::
private function ppElse as integer
	dim istrue as integer

   	function = FALSE

   	istrue = FALSE

	if( lexpp.level = 0 ) then
        hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
		exit function
	end if

    if( pptb(lexpp.level).elsecnt > 0 ) then
	   	hReportError( FB_ERRMSG_SYNTAXERROR )
       	exit function
    end if

	if( lexGetToken( ) = FB_TK_ELSEIF ) then
		'' ELSEIF

        lexSkipToken( )

		if( not ppLogExpression( istrue ) ) then
			exit function
		end if

		if( pptb(lexpp.level).istrue ) then
		    return ppSkip( )
		else
			pptb(lexpp.level).istrue = istrue
		end if

	else
		'' ELSE

		lexSkipToken( )

        pptb(lexpp.level).elsecnt += 1

        pptb(lexpp.level).istrue = not pptb(lexpp.level).istrue

    end if

   	if( not pptb(lexpp.level).istrue ) then
   		function = ppSkip( )
   	else
   		function = TRUE
   	end if


end function

'':::::
private function ppEndIf as integer

   	function = FALSE

	if( lexpp.level = 0 ) then
        hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
		exit function
	end if

   	'' ENDIF
   	lexSkipToken( )

	lexpp.level -= 1

end function

'':::::
private function ppSkip as integer
    dim iflevel as integer

	function = FALSE

	'' Comment?
	cComment( )

	'' EOL
	if( not hMatch( FB_TK_EOL ) ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if


	iflevel = lexpp.level

	'' skip lines until a #ENDIF or #ELSE at same level is found
    do

		select case lexGetToken( )
        case CHAR_SHARP
        	lexSkipToken( )

        	select case as const lexGetToken( )
        	case FB_TK_IF, FB_TK_IFDEF, FB_TK_IFNDEF
        		iflevel += 1

        	case FB_TK_ELSE, FB_TK_ELSEIF
        		if( iflevel = lexpp.level ) then
        			return ppElse( )
				elseif( iflevel = 0 ) then
            		hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
					exit function
        		end if

        	case FB_TK_ENDIF
        		if( iflevel = lexpp.level ) then
        			return ppEndIf( )
				elseif( iflevel = 0 ) then
	          		hReportError( FB_ERRMSG_ILLEGALOUTSIDECOMP )
					exit function
				else
        			iflevel -= 1
        		end if

    		case FB_TK_DEFINE, FB_TK_UNDEF, FB_TK_PRINT, FB_TK_LPRINT, _
    			 FB_TK_ERROR, FB_TK_INCLUDE, FB_TK_INCLIB, FB_TK_LIBPATH

        	case else
        		hReportError( FB_ERRMSG_SYNTAXERROR )
        		exit function
        	end select

       	case FB_TK_EOF
       		function = TRUE
       		exit do
       	end select

		lexSkipLine( )
		if( lexGetToken( ) = FB_TK_EOL ) then
			lexSkipToken( )
		end if
	loop

end function

'':::::
''LogExpression      =   NOT? RelExpression ( (AND | OR) NOT? RelExpression )* .
''
private function ppLogExpression( logexpr as integer )
    dim donot as integer, op as integer
    dim loglit as string, logisnum
    dim relexpr as integer, rellit as string, relisnum as integer

    logexpr = FALSE

    '' NOT?
    donot = FALSE
    if( hMatch( FB_TK_NOT ) ) then
    	donot = TRUE
    end if

    '' RelExpression
    if( not ppRelExpression( logexpr, loglit, logisnum ) ) then
    	return FALSE
    end if

    '' exec not
    if( donot ) then
    	logexpr = not logexpr
    end if

	function = TRUE

    '' ( ... )*
    do
    	'' Logical operator
    	op = lexGetToken( )
    	select case op
    	case FB_TK_AND, FB_TK_OR
 			lexSkipToken( )
    	case else
      		exit do
    	end select

    	'' NOT?
    	donot = FALSE
    	if( hMatch( FB_TK_NOT ) ) then
    		donot = TRUE
    	end if

    	'' RelExpression
    	if( not ppRelExpression( relexpr, rellit, relisnum ) ) then
    		return FALSE
    	end if

    	'' exec not
    	if( donot ) then
    		relexpr = not relexpr
    	end if

    	'' do operation
    	select case op
    	case FB_TK_AND
    		logexpr = logexpr and relexpr
    	case FB_TK_OR
    		logexpr = logexpr or relexpr
    	end select
    loop

end function

'':::::
''RelExpression   =   ParentExpr ( (EQ | GT | LT | NE | LE | GE) ParentExpr )* .
''
private function ppRelExpression( relexpr as integer, rellit as string, relisnum as integer )
    dim op as integer, ops as integer
    dim parexpr as integer, parlit as string, parisnum

   	function = FALSE

    '' Atom
    if( not ppParentExpr( relexpr, rellit, relisnum ) ) then
    	exit function
    end if

    '' ( ... )*
    ops = 0
    do
    	'' Relational operator
    	op = lexGetToken( )
    	select case as const op
    	case FB_TK_EQ, FB_TK_GT, FB_TK_LT, FB_TK_NE, FB_TK_LE, FB_TK_GE
 			lexSkipToken( )
    	case else
      		exit do
    	end select

    	'' Atom
    	if( not ppParentExpr( parexpr, parlit, parisnum ) ) then
    		exit function
    	end if

   		'' same type?
   		if( (relisnum xor parisnum) = -1 ) then
   			hReportError( FB_ERRMSG_SYNTAXERROR )
   			exit function
   		end if

   		'' do operation
   		if( relisnum ) then
   			'' can't compare as strings if both are numbers, '"10" > "2"' is FALSE for QB/FB
   			select case as const op
   			case FB_TK_EQ
   				relexpr = val( rellit ) = val( parlit )
   			case FB_TK_GT
   				relexpr = val( rellit ) > val( parlit )
   			case FB_TK_LT
   				relexpr = val( rellit ) < val( parlit )
   			case FB_TK_NE
   				relexpr = val( rellit ) <> val( parlit )
   			case FB_TK_LE
   				relexpr = val( rellit ) <= val( parlit )
   			case FB_TK_GE
   				relexpr = val( rellit ) >= val( parlit )
   			end select

   		else
   			select case as const op
   			case FB_TK_EQ
   				relexpr = rellit = parlit
   			case FB_TK_GT
   				relexpr = rellit > parlit
   			case FB_TK_LT
   				relexpr = rellit < parlit
   			case FB_TK_NE
   				relexpr = rellit <> parlit
   			case FB_TK_LE
   				relexpr = rellit <= parlit
   			case FB_TK_GE
   				relexpr = rellit >= parlit
   			end select
   		end if

   		rellit = str( relexpr )
   		relisnum = TRUE
   		ops += 1
    loop

    ''
    if( (ops = 0) and (relexpr > 0) ) then
    	relexpr = TRUE
    end if

    function = TRUE

end function

'':::::
'' ParentExpr  =   '(' Expression ')'
''			   |   DEFINED'(' ID ')'
''             |   LITERAL .
private function ppParentExpr( parexpr as integer, _
							   atom as string, _
							   isnumber as integer ) as integer
    dim d as FBSYMBOL ptr

  	function = FALSE

  	atom = ""
  	isnumber = FALSE

  	'' '(' Expression ')'
  	select case lexGetToken( )
  	case CHAR_LPRNT
  		lexSkipToken( )

  		if( not ppLogExpression( parexpr ) ) then
  			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
  			exit function
  		end if

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
  			exit function
  		end if

  	'' DEFINED'(' ID ')'
  	case FB_TK_DEFINED
  		lexSkipToken( )

    	if( lexGetToken( ) <> CHAR_LPRNT ) then
    		hReportError( FB_ERRMSG_EXPECTEDLPRNT )
    		exit function
    	else
    		lexSkipToken( LEXCHECK_NODEFINE )
    	end if

		d = lexGetSymbol( )
		parexpr = FALSE
		if( d <> NULL ) then
			if( d->class = FB_SYMBCLASS_DEFINE ) then
				parexpr = TRUE
			end if
		end if
		lexSkipToken( )

  		if( not hMatch( CHAR_RPRNT ) ) then
  			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
  			exit function
  		end if

  	'' '-'
	case CHAR_MINUS
		lexSkipToken( )

  		if( not ppParentExpr( parexpr, atom, isnumber ) ) then
  			exit function
  		elseif( not isnumber ) then
  			hReportError( FB_ERRMSG_SYNTAXERROR )
  			exit function
  		end if

  		atom = "-" + atom
  		parexpr = len( atom )

  	'' LITERAL
  	case else
  		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
  			isnumber = TRUE
  		end if

  		atom = *lexGetText( )
  		lexSkipToken( )
  		if( len( atom ) = 0 ) then
  			hReportError( FB_ERRMSG_SYNTAXERROR )
  			exit function
  		end if

  		if( isnumber ) then
  			parexpr = ( val( atom ) <> 0 )
  		end if
  	end select

	function = TRUE

end function
