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

#define LEX_FLAGS LEXCHECK_NOWHITESPC or LEXCHECK_NOSUFFIX or LEXCHECK_NODEFINE or LEXCHECK_NOQUOTES

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

'':::::
private sub hReportMacroError( byval s as FBSYMBOL ptr, _
							   byval errnum as integer )

	hReportErrorEx( errnum, "expanding: " + *symbGetOrgName( s ) )

end sub

'':::::
private function hLoadMacro( byval s as FBSYMBOL ptr ) as integer
    dim as FB_DEFPARAM ptr param
    dim as FB_DEFTOK ptr dt
    dim as FBTOKEN t
    dim as LEXPP_ARGTB ptr argtb
    dim as integer prntcnt, num
    static as string text

	function = -1

	'' '('?
	if( lexCurrentChar( TRUE ) <> CHAR_LPRNT ) then
		'' not an error, macro can be passed as param to other macros
		exit function
	end if

	lexEatChar( )

	prntcnt = 1

	'' allocate a new arg list (support recursion)
	if( symbGetDefineHeadToken( s ) ) then
		argtb = listNewNode( @ctx.argtblist )
	else
		argtb = NULL
	end if

	'' for each arg
	param = symbGetDefineHeadParam( s )
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
				hReportMacroError( s, FB_ERRMSG_EXPECTEDRPRNT )
				exit function
			end select

			if( argtb <> NULL ) then
	   			if( t.typ <> FB_DATATYPE_WCHAR ) then
	    			DZstrConcatAssign( argtb->tb(num).text, t.text )
	    		else
	    			DZstrConcatAssignW( argtb->tb(num).text, t.textw )
	    		end if
	    	end if
		loop

		if( argtb <> NULL ) then
			'' trim
			with argtb->tb(num)
				if( .text.data = NULL ) then
					hReportMacroError( s, FB_ERRMSG_EXPECTEDEXPRESSION )
					exit function
				end if

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
		param = symbGetDefParamNext( param )
		num += 1

		'' too many args?
		if( param = NULL ) then
			hReportMacroError( s, FB_ERRMSG_ARGCNTMISMATCH )
			exit function
		end if
	loop

	'' too few args?
	if( symbGetDefParamNext( param ) <> NULL ) then
		hReportMacroError( s, FB_ERRMSG_ARGCNTMISMATCH )
		exit function
	end if

	''
	text = ""

	if( argtb <> NULL ) then
		dt = symbGetDefineHeadToken( s )
		do while( dt <> NULL )
			select case as const symbGetDefTokType( dt )
			'' parameter?
			case FB_DEFTOK_TYPE_PARAM
				text += *argtb->tb( symbGetDefTokParamNum( dt ) ).text.data

			'' stringize parameter?
			case FB_DEFTOK_TYPE_PARAMSTR
				'' !!!FIXME!!! $'s won't turn off escaping
				text += "\""
				text += hReplace( argtb->tb( symbGetDefTokParamNum( dt ) ).text.data, _
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

		listDelNode( @ctx.argtblist, argtb )
	end if

	''
	if( lex->deflen = 0 ) then
		DZstrAssign( lex->deftext, text )
	else
		DZstrAssign( lex->deftext, text + *lex->defptr )
	end if

	function = len( text )

end function

''::::
private function hLoadDefine( byval s as FBSYMBOL ptr ) as integer
    dim as integer lgt
    static as string text

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
            if( bit( symbGetDefineFlags( s ), 0 ) = 0 ) then
				text = "\"" + symbGetDefineCallback( s )( ) + "\""
            else
				text = symbGetDefineCallback( s )( )
            end if

			if( lex->deflen = 0 ) then
				DZstrAssign( lex->deftext, text )
			else
				DZstrAssign( lex->deftext, text + *lex->defptr )
			end if

            lgt = len( text )

		'' just load text as-is
		else

			'' arg-less macro?
			if( symbGetDefineIsArgless( s ) ) then
				'' '('?
				if( lexCurrentChar( TRUE ) <> CHAR_LPRNT ) then
					'' not an error, macro can be passed as param to other macros
					exit function
				end if
				lexEatChar( )

				'' ')'
				if( lexCurrentChar( TRUE ) <> CHAR_RPRNT ) then
					hReportError( FB_ERRMSG_EXPECTEDRPRNT )
					exit function
				end if
				lexEatChar( )
			end if

			if( symbGetType( s ) <> FB_DATATYPE_WCHAR ) then
				if( lex->deflen = 0 ) then
					DZstrAssign( lex->deftext, symbGetDefineText( s ) )
				else
					DZstrAssign( lex->deftext, _
								 *symbGetDefineText( s ) + *lex->defptr )
				end if

			else
				if( lex->deflen = 0 ) then
					DZstrAssignW( lex->deftext, symbGetDefineTextW( s ) )
				else
					DZstrAssign( lex->deftext, _
								 str( *symbGetDefineTextW( s ) ) + *lex->defptr )
				end if
			end if

            lgt = symbGetLen( s )
		end if

	end if

    ''
	lex->defptr = lex->deftext.data
	lex->deflen += lgt

	'' force a re-read
	lex->currchar = cuint( INVALID )

	function = TRUE

end function

private function hLoadMacroW( byval s as FBSYMBOL ptr ) as integer
    dim as FB_DEFPARAM ptr param
    dim as FB_DEFTOK ptr dt
    dim as FBTOKEN t
    dim as LEXPP_ARGTB ptr argtb
    dim as integer prntcnt, lgt, num
    static as DWSTRING text

	function = -1

	'' '('?
	if( lexCurrentChar( TRUE ) <> CHAR_LPRNT ) then
		'' not an error, macro can be passed as param to other macros
		exit function
	end if

	lexEatChar( )

	prntcnt = 1
	'' allocate a new arg list (because the recursivity)
	if( symbGetDefineHeadToken( s ) ) then
		argtb = listNewNode( @ctx.argtblist )
	else
		argtb = NULL
	end if

	'' for each arg
	param = symbGetDefineHeadParam( s )
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
				hReportMacroError( s, FB_ERRMSG_EXPECTEDRPRNT )
				exit function
			end select

			if( argtb <> NULL ) then
    			if( t.typ <> FB_DATATYPE_WCHAR ) then
    				DWstrConcatAssignA( argtb->tb(num).textw, t.text )
    			else
    				DWstrConcatAssign( argtb->tb(num).textw, t.textw )
    			end if
    		end if
		loop

		if( argtb <> NULL ) then
			'' trim
			with argtb->tb(num)
				if( .textw.data = NULL ) then
					hReportMacroError( s, FB_ERRMSG_EXPECTEDEXPRESSION )
					exit function
				end if

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
		param = symbGetDefParamNext( param )
		num += 1

		'' too many args?
		if( param = NULL ) then
			hReportMacroError( s, FB_ERRMSG_ARGCNTMISMATCH )
			exit function
		end if
	loop

	'' too few args?
	if( symbGetDefParamNext( param ) <> NULL ) then
		hReportMacroError( s, FB_ERRMSG_ARGCNTMISMATCH )
		exit function
	end if

	'' text = ""
	DWstrAssign( text, NULL )

	if( argtb <> NULL ) then
		dt = symbGetDefineHeadToken( s )
		do while( dt <> NULL )
			select case as const symbGetDefTokType( dt )
			'' parameter?
			case FB_DEFTOK_TYPE_PARAM
				DWstrConcatAssign( text, _
								   argtb->tb( symbGetDefTokParamNum( dt ) ).textw.data )

			'' stringize parameter?
			case FB_DEFTOK_TYPE_PARAMSTR
				'' !!!FIXME!!! $'s won't turn off escaping
				DWstrConcatAssign( text, "\"" )
				DWstrConcatAssign( text, *hReplaceW( argtb->tb( symbGetDefTokParamNum( dt ) ).textw.data, _
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

		listDelNode( @ctx.argtblist, argtb )
	end if

	''
	if( lex->deflen = 0 ) then
		DWstrAssign( lex->deftextw, text.data )
	else
		DWstrAssign( lex->deftextw, *text.data + *lex->defptrw )
	end if

	function = len( *text.data )

end function

''::::
private function hLoadDefineW( byval s as FBSYMBOL ptr ) as integer
    dim as integer lgt
    static as DWSTRING text

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
            if( bit( symbGetDefineFlags( s ), 0 ) = 0 ) then
				DWstrAssignA( text, "\"" + symbGetDefineCallback( s )( ) + "\"" )
            else
				DWstrAssignA( text, symbGetDefineCallback( s )( ) )
            end if

			if( lex->deflen = 0 ) then
				DWstrAssign( lex->deftextw, text.data )
			else
				DWstrAssign( lex->deftextw, *text.data + *lex->defptrw )
			end if

            lgt = len( *text.data )

		'' just load text as-is
		else
			'' arg-less macro?
			if( symbGetDefineIsArgless( s ) ) then
				'' '('?
				if( lexCurrentChar( TRUE ) <> CHAR_LPRNT ) then
					'' not an error, macro can be passed as param to other macros
					exit function
				end if
				lexEatChar( )

				'' ')'
				if( lexCurrentChar( TRUE ) <> CHAR_RPRNT ) then
					hReportError( FB_ERRMSG_EXPECTEDRPRNT )
					exit function
				end if
				lexEatChar( )
			end if

			if( symbGetType( s ) <> FB_DATATYPE_WCHAR ) then
				if( lex->deflen = 0 ) then
					DWstrAssignA( lex->deftextw, symbGetDefineText( s ) )
				else
					DWstrAssign( lex->deftextw, _
								 wstr( *symbGetDefineText( s ) ) + *lex->defptrw )
				end if

			else
				if( lex->deflen = 0 ) then
					DWstrAssign( lex->deftextw, symbGetDefineTextW( s ) )
				else
					DWstrAssign( lex->deftextw, _
								 *symbGetDefineTextW( s ) + *lex->defptrw )
				end if
			end if

            lgt = symbGetLen( s )
		end if

	end if

    ''
	lex->defptrw = lex->deftextw.data
	lex->deflen += lgt

	function = TRUE

end function

''::::
function ppDefineLoad( byval s as FBSYMBOL ptr ) as integer

	'' recursion?
	if( s = lex->currmacro ) then
		hReportError( FB_ERRMSG_RECURSIVEMACRO )
		return FALSE
	end if

	'' only one level
	if( lex->currmacro = NULL ) then
		lex->currmacro = s
	end if

	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
		function = hLoadDefine( s )
	else
		function = hLoadDefineW( s )
	end if

	'' force a re-read
	lex->currchar = cuint( INVALID )

end function

'':::::
private function hReadMacroText( byval args as integer, _
						   		 byval paramhead as FB_DEFPARAM ptr _
						   	   ) as FB_DEFTOK ptr

	static as zstring * FB_MAXNAMELEN+1 token
    dim as integer dpos, num, addquotes
    dim as FB_DEFPARAM ptr param
    dim as FB_DEFTOK ptr tok, tokhead

    tok = NULL
    tokhead = NULL

    do
    	select case lexGetToken( LEX_FLAGS )
		case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM
			exit do
		end select

    	'' preserve quotes if it's a string literal
    	if( lexGetClass( LEX_FLAGS ) = FB_TKCLASS_STRLITERAL ) then

    		'' ascii?
    		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
				tok = symbAddDefineTok( tok, FB_DEFTOK_TYPE_TEX )
				if( tokhead = NULL ) then
					tokhead = tok
				end if

	    		ZstrAssign( @tok->text, lexGetText( ) )

    		'' unicode..
    		else
				tok = symbAddDefineTok( tok, FB_DEFTOK_TYPE_TEXW )
				if( tokhead = NULL ) then
					tokhead = tok
				end if

    			WstrAssign( @tok->textw, lexGetTextW( ) )
    		end if

    		lexSkipToken( LEX_FLAGS )

    	'' anything but a literal string..
    	else

			tok = symbAddDefineTok( tok, FB_DEFTOK_TYPE_TEX )
			if( tokhead = NULL ) then
				tokhead = tok
			end if

    		addquotes = FALSE

    		'' '#'?
    		if( lexGetToken( LEX_FLAGS ) = CHAR_SHARP ) then
    			select case lexGetLookAhead( 1, LEX_FLAGS )
    			'' '##'?
    			case CHAR_SHARP
    				lexSkipToken( LEX_FLAGS )
    				lexSkipToken( LEX_FLAGS )
    				continue do

    			'' '#' id?
    			case FB_TK_ID
    			    lexSkipToken( LEX_FLAGS )
    			    addquotes = TRUE
    			end select
    		end if

    		'' not and identifier? read as-is
    		if( lexGetToken( LEX_FLAGS ) <> FB_TK_ID ) then
    			ZstrAssign( @tok->text, lexGetText( ) )
    			lexSkipToken( LEX_FLAGS )

    		'' otherwise, check if it's a parameter
    		else
    			token = ucase( *lexGetText( ) )
    			'' contains a period? assume it's an udt access
    			dpos = lexGetPeriodPos( )
    			if( dpos > 1 ) then
    				token[dpos-1] = 0 			'' token = left( token, dpos-1 )
    			end if

    			'' for each define param..
    			param = paramhead
    			num = 0
    			do
    				'' same?
    				if( token = *symbGetDefParamName( param ) ) then

						if( addquotes = FALSE ) then
							symbSetDefTokType( tok, FB_DEFTOK_TYPE_PARAM )
						else
							symbSetDefTokType( tok, FB_DEFTOK_TYPE_PARAMSTR )
						end if

						symbSetDefTokParamNum( tok, num )

    					'' add the remainder if it's an udt access
    					if( dpos > 1 ) then
    						tok = symbAddDefineTok( tok, FB_DEFTOK_TYPE_TEX )
    						lexEatToken( token, LEX_FLAGS )
    						ZstrAssign( @tok->text, _
    								    cast( zstring ptr, @token[dpos-1] ) ) ''mid( token, dpos )
    					else
    						lexSkipToken( LEX_FLAGS )
    					end if

    					exit do
    				end if

    				'' next arg
    				param = symbGetDefParamNext( param )
    				num += 1
    			loop while( param <> NULL )

    			'' if none matched, read as-is
    			if( param = NULL ) then
    				ZstrAssign( @tok->text, lexGetText( ) )
    				lexSkipToken( LEX_FLAGS )
    			end if
    		end if

    	end if

    loop

	function = tokhead

end function

'':::::
function ppDefine( ) as integer
	static as zstring * FB_MAXNAMELEN+1 defname, paramname
	dim as zstring ptr text
	dim as wstring ptr textw
	dim as integer params, isargless
	dim as FB_DEFPARAM ptr paramhead, lastparam
	dim as FBSYMBOL ptr s
	dim as FB_DEFTOK ptr tokhead

	function = FALSE

    '' ID
    s = lexGetSymbol( )
    if( s <> NULL ) then
    	if( symbIsDefine( s ) = FALSE ) then
    		hReportError( FB_ERRMSG_DUPDEFINITION )
    		exit function
    	end if
    end if

    lexEatToken( defname, LEX_FLAGS )

    params = 0
    paramhead = NULL
    isargless = FALSE

    '' '('?
    if( lexGetToken( LEX_FLAGS ) = CHAR_LPRNT ) then
    	lexSkipToken( LEXCHECK_NODEFINE )

		'' not arg-less?
		if( lexGetToken( LEXCHECK_NODEFINE ) <> CHAR_RPRNT ) then
			lastparam = NULL
			do
		    	lexEatToken( paramname, LEXCHECK_NODEFINE )
		    	lastparam = symbAddDefineParam( lastparam, @paramname )

		    	params += 1
				if( params >= FB_MAXDEFINEARGS ) then
					hReportError( FB_ERRMSG_TOOMANYPARAMS )
					exit function
				end if

		    	if( paramhead = NULL ) then
		    		paramhead = lastparam
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
    	if( lexGetToken( LEX_FLAGS ) <> CHAR_RPRNT ) then
    		hReportError( FB_ERRMSG_EXPECTEDRPRNT )
    		exit function
    	end if
    	lexSkipToken( LEX_FLAGS and not LEXCHECK_NOWHITESPC )

    else
    	if( lexGetToken( LEX_FLAGS ) = CHAR_SPACE ) then
    		'' skip white-spaces
    		lexSkipToken( LEX_FLAGS and not LEXCHECK_NOWHITESPC )
    	end if
    end if


   	'' not a macro?
   	if( params = 0 ) then
    	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
    		'' LITERAL*
    		text = ppReadLiteral( )

    		'' already defined? if there are no differences, do nothing..
    		if( s <> NULL ) then
    			if( (symbGetDefineParams( s ) > 0) or _
    				(symbGetType( s ) <> FB_DATATYPE_CHAR) ) then
    				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    				exit function

    			elseif( (*symbGetDefineText( s ) <> *text) ) then
    				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    				exit function
    			end if

    		else
    			symbAddDefine( @defname, text, len( *text ), isargless )

    		end if

    	'' unicode..
    	else
    		'' LITERAL*
    		textw = ppReadLiteralW( )

    		'' already defined? if there are no differences, do nothing..
    		if( s <> NULL ) then
    			if( (symbGetDefineParams( s ) > 0) or _
    				(symbGetType( s ) <> FB_DATATYPE_WCHAR) ) then
    				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    				exit function

    			elseif( (*symbGetDefineTextW( s ) <> *textw) ) then
    				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    				exit function
    			end if

    		else
    			symbAddDefineW( @defname, textw, len( *textw ), isargless )

    		end if

    	end if

    '' macro..
    else
    	'' already defined? can't check..
    	if( s <> NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, defname )
    		exit function
    	end if

       	tokhead = hReadMacroText( params, paramhead )

    	symbAddDefineMacro( @defname, tokhead, params, paramhead )

    end if

	function = TRUE

end function

