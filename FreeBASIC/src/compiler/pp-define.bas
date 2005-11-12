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
#include once "inc\dstr.bi"

#define LIT_FLAGS LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX or LEXCHECK_NODEFINE or LEXCHECK_NOQUOTES

type LEXPP_CTX
	argtblist	as TLIST
end type

type LEXPP_ARG
	union
		text		as DZSTRING
		textw		as DWSTRING
	end union
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
private function hLoadDefine( byval s as FBSYMBOL ptr ) as integer
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
		lexNextToken( @t, LEXCHECK_NOSUFFIX )
		if( t.id <> CHAR_LPRNT ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

		prntcnt = 1
		'' allocate a new arg list (because recursivity)
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
				DZstrZero( argtb->tb(num).text )
			end if

			'' read text until a comma or right-parentheses is found
			do
				lexNextToken( @t, LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX or LEXCHECK_NOQUOTES )
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
    				if( t.typ <> IR_DATATYPE_WCHAR ) then
    					DZstrConcatAssign( argtb->tb(num).text, t.text )
    				else
    					DZstrConcatAssignW( argtb->tb(num).text, t.textw )
    				end if
    			end if
            loop

			if( argtb <> NULL ) then
				'' trim
				with argtb->tb(num)
					if( (.text.data[0][0] = CHAR_SPACE) or _
						(.text.data[0][len( *.text.data )-1] = CHAR_SPACE) ) then
						DZstrAssign( .text, trim( *.text.data ) )
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
				select case as const symbGetDefTokType( dt )
				'' argument?
				case FB_DEFTOK_TYPE_ARG
					text += *argtb->tb( symbGetDefTokArgNum( dt ) ).text.data

				'' stringize argument?
				case FB_DEFTOK_TYPE_ARGSTR
					text += "\""
					text += hReplace( argtb->tb( symbGetDefTokArgNum( dt ) ).text.data, _
									  "\"", _
									  "\"\"" )
					text += "\""

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

			listDelNode( @ctx.argtblist, cptr( TLISTNODE ptr, argtb ) )
		end if

		lgt = len( text )

		''
		if( lex->deflen = 0 ) then
			lex->deftext = text
		else
			lex->deftext = text + *lex->defptr
		end if

	'' no args
	else

		'' should we call a function to get definition text?
		if( symbGetDefineCallback( s ) <> NULL ) then
			'' call function
            if( not bit( symbGetDefineFlags( s ), 0 ) ) then
				text = "\"" + symbGetDefineCallback( s )( ) + "\""
            else
				text = symbGetDefineCallback( s )( )
            end if

			if( lex->deflen = 0 ) then
				lex->deftext = text
			else
				lex->deftext = text + *lex->defptr
			end if

            lgt = len( text )

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

			if( symbGetType( s ) <> IR_DATATYPE_WCHAR ) then
				if( lex->deflen = 0 ) then
					lex->deftext = *symbGetDefineText( s )
				else
					lex->deftext = *symbGetDefineText( s ) + *lex->defptr
				end if

			else
				if( lex->deflen = 0 ) then
					lex->deftext = *symbGetDefineTextW( s )
				else
					lex->deftext = str( *symbGetDefineTextW( s ) ) + *lex->defptr
				end if
			end if

            lgt = symbGetLen( s )
		end if

	end if

    ''
	lex->defptr = @lex->deftext
	lex->deflen += lgt

	if( lex->deflen > FB_MAXINTDEFINELEN ) then
		lex->deflen = FB_MAXINTDEFINELEN
		hReportError( FB_ERRMSG_MACROTEXTTOOLONG )
		exit function
	end if

	'' force a re-read
	lex->currchar = cuint( INVALID )

	function = TRUE

end function

''::::
private function hLoadDefineW( byval s as FBSYMBOL ptr ) as integer
    dim as FBDEFARG ptr arg
    dim as FBDEFTOK ptr dt
    dim as FBTOKEN t
    dim as LEXPP_ARGTB ptr argtb
    dim as integer prntcnt, lgt, num
    static as DWSTRING text

    function = FALSE

	'' define has args?
	if( symbGetDefineArgs( s ) > 0 ) then

		'' '('
		lexNextToken( @t, LEXCHECK_NOSUFFIX )
		if( t.id <> CHAR_LPRNT ) then
			hReportError( FB_ERRMSG_EXPECTEDLPRNT )
			exit function
		end if

		prntcnt = 1
		'' allocate a new arg list (because the recursivity)
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
				DWstrZero( argtb->tb(num).textw )
			end if

			'' read text until a comma or right-parentheses is found
			do
				lexNextToken( @t, LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX or LEXCHECK_NOQUOTES )
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
    				if( t.typ <> IR_DATATYPE_WCHAR ) then
    					DWstrConcatAssignA( argtb->tb(num).textw, t.text )
    				else
    					DWstrConcatAssign( argtb->tb(num).textw, t.textw )
    				end if
    			end if
            loop

			if( argtb <> NULL ) then
				'' trim
				with argtb->tb(num)
					if( (.textw.data[0][0] = CHAR_SPACE) or _
						(.textw.data[0][len( *.textw.data )-1] = CHAR_SPACE) ) then
						DWstrAssign( .textw, trim( *.textw.data ) )
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

		'' text = ""
		DWstrAssign( text, NULL )

		if( argtb <> NULL ) then
			dt = symbGetDefineHeadToken( s )
			do while( dt <> NULL )
				select case as const symbGetDefTokType( dt )
				'' argument?
				case FB_DEFTOK_TYPE_ARG
					DWstrConcatAssign( text, _
									   argtb->tb( symbGetDefTokArgNum( dt ) ).textw.data )

				'' stringize argument?
				case FB_DEFTOK_TYPE_ARGSTR
					DWstrConcatAssign( text, "\"" )
					DWstrConcatAssign( text, *hReplaceW( argtb->tb( symbGetDefTokArgNum( dt ) ).textw.data, _
											 	  		"\"", _
											 	  		"\"\"" ) )
					DWstrConcatAssign( text, "\"" )

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

			listDelNode( @ctx.argtblist, cptr( TLISTNODE ptr, argtb ) )
		end if

		lgt = len( *text.data )

		''
		if( lex->deflen = 0 ) then
			lex->deftextw = *text.data
		else
			lex->deftextw = *text.data + *lex->defptrw
		end if

	'' no args
	else

		'' should we call a function to get definition text?
		if( symbGetDefineCallback( s ) <> NULL ) then
			'' call function
            if( not bit( symbGetDefineFlags( s ), 0 ) ) then
				DWstrAssignA( text, "\"" + symbGetDefineCallback( s )( ) + "\"" )
            else
				DWstrAssignA( text, symbGetDefineCallback( s )( ) )
            end if

			if( lex->deflen = 0 ) then
				lex->deftextw = *text.data
			else
				lex->deftextw = *text.data + *lex->defptrw
			end if

            lgt = len( *text.data )

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

			if( symbGetType( s ) <> IR_DATATYPE_WCHAR ) then
				if( lex->deflen = 0 ) then
					lex->deftextw = *symbGetDefineText( s )
				else
					lex->deftextw = wstr( *symbGetDefineText( s ) ) + *lex->defptrw
				end if

			else
				if( lex->deflen = 0 ) then
					lex->deftextw = *symbGetDefineTextW( s )
				else
					lex->deftextw = *symbGetDefineTextW( s ) + *lex->defptrw
				end if
			end if

            lgt = symbGetLen( s )
		end if

	end if

    ''
	lex->defptrw = @lex->deftextw
	lex->deflen += lgt

	function = TRUE

end function

''::::
function ppDefineLoad( byval s as FBSYMBOL ptr ) as integer

	select case as const env.inf.format
	case FBFILE_FORMAT_ASCII
		function = hLoadDefine( s )
	case FBFILE_FORMAT_UTF16LE, FBFILE_FORMAT_UTF16BE, _
		 FBFILE_FORMAT_UTF32LE, FBFILE_FORMAT_UTF32BE
		function = hLoadDefineW( s )
	end select

	if( lex->deflen > FB_MAXINTDEFINELEN ) then
		lex->deflen = FB_MAXINTDEFINELEN
		hReportError( FB_ERRMSG_MACROTEXTTOOLONG )
		exit function
	end if

	'' force a re-read
	lex->currchar = cuint( INVALID )

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

    	'' preserve quotes if it's a string literal
    	if( lexGetClass( LIT_FLAGS ) = FB_TKCLASS_STRLITERAL ) then

    		'' ascii?
    		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
				tok = symbAddDefineTok( tok, FB_DEFTOK_TYPE_TEX )
				if( tokhead = NULL ) then
					tokhead = tok
				end if

    			'' un-espace it if option escape is on
    			if( env.opt.escapestr ) then
    				ZstrAssign( @tok->text, hUnescapeStr( lexGetText( ) ) )
    			else
	    			ZstrAssign( @tok->text, lexGetText( ) )
    			end if

    		'' unicode..
    		else
				tok = symbAddDefineTok( tok, FB_DEFTOK_TYPE_TEXW )
				if( tokhead = NULL ) then
					tokhead = tok
				end if

    			if( env.opt.escapestr ) then
    				WstrAssign( @tok->textw, hUnescapeWstr( lexGetTextW( ) ) )
    			else
    				WstrAssign( @tok->textw, lexGetTextW( ) )
    			end if
    		end if

    		lexSkipToken( LIT_FLAGS )

    	'' anything but a literal string..
    	else

			tok = symbAddDefineTok( tok, FB_DEFTOK_TYPE_TEX )
			if( tokhead = NULL ) then
				tokhead = tok
			end if

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
    			ZstrAssign( @tok->text, lexGetText( ) )
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
    				if( token = *symbGetDefArgName( arg ) ) then

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
    						ZstrAssign( @tok->text, _
    								    cptr( zstring ptr, @token[dpos-1] ) ) ''mid( token, dpos )
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
    				ZstrAssign( @tok->text, lexGetText( ) )
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
	dim as wstring ptr textw
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
    	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
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
    				(symbGetType( s ) <> IR_DATATYPE_CHAR) ) then
    				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    				exit function

    			elseif( (*symbGetDefineText( s ) <> *text) ) then
    				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    				exit function
    			end if

    		else
    			symbAddDefine( @defname, text, textlen, isargless )

    		end if

    	'' unicode..
    	else
    		'' LITERAL*
    		textw = ppReadLiteralW( )

    		'' check len, use the sentinel as "text" is a static wstring
    		textlen = len( *textw )
    		if( textlen = FB_MAXINTDEFINELEN+1 ) then
				hReportError( FB_ERRMSG_MACROTEXTTOOLONG )
				exit function
    		end if

    		'' already defined? if there are no differences, do nothing..
    		if( s <> NULL ) then
    			if( (symbGetDefineArgs( s ) > 0) or _
    				(symbGetType( s ) <> IR_DATATYPE_WCHAR) ) then
    				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    				exit function

    			elseif( (*symbGetDefineTextW( s ) <> *textw) ) then
    				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    				exit function
    			end if

    		else
    			symbAddDefineW( @defname, textw, textlen, isargless )

    		end if

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

