'' pre-processor top-level module
''
'' chng: dec/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "lex.bi"
#include once "parser.bi"
#include once "pp.bi"

#define LEX_FLAGS (LEXCHECK_NOWHITESPC or _
				   LEXCHECK_NOSUFFIX or _
				   LEXCHECK_NODEFINE or _
				   LEXCHECK_NOQUOTES or _
				   LEXCHECK_NOSYMBOL)

type SYMBKWD
	name			as zstring ptr
	id				as integer
	sym				as FBSYMBOL ptr
end type

declare function ppInclude					( ) as integer

declare function ppIncLib					( ) as integer

declare function ppLibPath					( ) as integer

declare function ppLine						( ) as integer

declare function ppLang						( ) as integer

'' globals
	dim shared as PP_CTX pp

const SYMB_MAXKEYWORDS = 24

	dim shared kwdTb( 0 to SYMB_MAXKEYWORDS-1 ) as SYMBKWD => _
	{ _
        (@"IF"		, FB_TK_PP_IF		), _
        (@"IFDEF"	, FB_TK_PP_IFDEF	), _
        (@"IFNDEF"	, FB_TK_PP_IFNDEF	), _
        (@"ELSE"	, FB_TK_PP_ELSE		), _
        (@"ELSEIF"	, FB_TK_PP_ELSEIF	), _
        (@"ENDIF"	, FB_TK_PP_ENDIF	), _
        (@"DEFINE"	, FB_TK_PP_DEFINE	), _
        (@"UNDEF"	, FB_TK_PP_UNDEF	), _
        (@"MACRO"	, FB_TK_PP_MACRO	), _
        (@"ENDMACRO", FB_TK_PP_ENDMACRO	), _
        (@"INCLUDE"	, FB_TK_PP_INCLUDE	), _
        (@"LIBPATH"	, FB_TK_PP_LIBPATH	), _
        (@"INCLIB"	, FB_TK_PP_INCLIB	), _
        (@"PRAGMA"	, FB_TK_PP_PRAGMA	), _
        (@"PRINT"	, FB_TK_PP_PRINT	), _
        (@"ERROR"	, FB_TK_PP_ERROR	), _
        (@"LINE"	, FB_TK_PP_LINE		), _
        (@"LANG"	, FB_TK_PP_LANG		), _
        (NULL) _
	}

''::::
sub ppInit( )
    dim as integer i

	''
	hashInit( )

	'' create a fake namespace
    pp.kwdns.class = FB_SYMBCLASS_NAMESPACE
    pp.kwdns.scope = FB_MAINSCOPE

	symbSymbTbInit( pp.kwdns.nspc.ns.symtb, @pp.kwdns )
	symbHashTbInit( pp.kwdns.nspc.ns.hashtb, @pp.kwdns, SYMB_MAXKEYWORDS )
    pp.kwdns.nspc.ns.ext = symbCompAllocExt(  )

	''
	for i = 0 to SYMB_MAXKEYWORDS-1
    	if( kwdTb(i).name = NULL ) then
    		exit for
    	end if

    	kwdTb(i).sym = symbAddKeyword( kwdTb(i).name, _
    								   kwdTb(i).id, _
    								   FB_TKCLASS_KEYWORD, _
    								   @pp.kwdns.nspc.ns.hashtb )
    	if( kwdTb(i).sym = NULL ) then
    		exit sub
    	end if
    next

	''
	pp.skipping = FALSE

	ppDefineInit( )

	ppCondInit( )

	ppPragmaInit( )

end sub

''::::
sub ppEnd( )
    dim as integer i

	ppPragmaEnd( )

	ppCondEnd( )

	ppDefineEnd( )

	''
	for i = 0 to SYMB_MAXKEYWORDS-1
    	if( kwdTb(i).sym = NULL ) then
    		exit for
    	end if

    	symbDelKeyword( kwdTb(i).sym )
    	kwdTb(i).sym = NULL
    next

	symbCompFreeExt( pp.kwdns.nspc.ns.ext )
	hashFree( @pp.kwdns.nspc.ns.hashtb.tb )
	hashEnd( )

end sub

'':::::
sub ppCheck( )

	'' not a '#' char?
	if( lex.ctx->head->id <> CHAR_SHARP ) then
		exit sub
	end if

	'' already inside the PP? (ie: skipping a false #IF or #ELSE)
	if( lex.ctx->reclevel <> 0 ) then
		exit sub
	end if

	'' not at the beginning of line?
	if( lex.ctx->lasttk_id <> FB_TK_EOL ) then
		'' or top of source-file?
		if( lex.ctx->lasttk_id <> INVALID ) then
			exit sub
		end if
	end if

	lex.ctx->reclevel += 1

    '' !!!FIXME!!! if LEXCHECK_KWDNAMESPC is used in future, it
    '' must be restored
    lex.ctx->kwdns = @pp.kwdns

    lexSkipToken( LEXCHECK_KWDNAMESPC )

    '' let the parser do the rest..
    ppParse( )
	lex.ctx->reclevel -= 1

end sub


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
function ppParse( ) as integer

	function = FALSE

    '' note: when adding any new PP symbol, update ppSkip() too
    select case as const lexGetToken( LEXCHECK_KWDNAMESPC )

    '' DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL+
    case FB_TK_PP_DEFINE
    	lexSkipToken( LEXCHECK_NODEFINE )
    	function = ppDefine( FALSE )

	'' MACRO ID '(' ID (',' ID)* ')' Comment? EOL
	'' 	MacroBody*
	'' ENDMACRO
	case FB_TK_PP_MACRO
    	lexSkipToken( LEXCHECK_NODEFINE )
    	function = ppDefine( TRUE )

	'' UNDEF ID
    case FB_TK_PP_UNDEF
    	dim as FBSYMCHAIN ptr chain_ = any
    	dim as FBSYMBOL ptr base_parent = any

    	lexSkipToken( LEXCHECK_NODEFINE )

    	chain_ = cIdentifier( base_parent, FB_IDOPT_NONE )
    	if( chain_ <> NULL ) then
    		dim as FBSYMBOL ptr sym = chain_->sym
    		'' don't remove if it was defined inside any namespace (any
    		'' USING reference to that ns would break its linked-list)
    		if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
    			if( errReport( FB_ERRMSG_CANTREMOVENAMESPCSYMBOLS ) = FALSE ) then
    				exit function
    			end if
    		else
    			if( symbGetCantUndef( sym ) ) then
    				if( errReport( FB_ERRMSG_CANTUNDEF ) = FALSE ) then
    					exit function
    				end if
    			else
    				symbDelSymbol( sym )
    			end if
    		end if
    	end if

    	lexSkipToken( )

    	function = TRUE

	'' IFDEF ID
	'' IFNDEF ID
	'' IF ID '=' LITERAL
    case FB_TK_PP_IFDEF, FB_TK_PP_IFNDEF, FB_TK_PP_IF
    	function = ppCondIf( )

	'' ELSE
	case FB_TK_PP_ELSE, FB_TK_PP_ELSEIF
    	function = ppCondElse( )

	'' ENDIF
	case FB_TK_PP_ENDIF
		function = ppCondEndIf( )

	'' PRINT LITERAL*
	case FB_TK_PP_PRINT
		lexSkipToken( )
		print *ppReadLiteral( )
		function = TRUE

	'' ERROR LITERAL*
	case FB_TK_PP_ERROR
		lexSkipToken( )
		return errReportEx( -1, *ppReadLiteral( ) )

	'' INCLUDE ONCE? LIT_STR
	case FB_TK_PP_INCLUDE
		lexSkipToken( )
		function = ppInclude( )

	'' INCLIB LIT_STR
	case FB_TK_PP_INCLIB
		lexSkipToken( )
        function = ppIncLib( )

	'' LIBPATH LIT_STR
	case FB_TK_PP_LIBPATH
		lexSkipToken( )
		function = ppLibPath( )

	'' PRAGMA ...
	case FB_TK_PP_PRAGMA
		lexSkipToken( )
		function = ppPragma( )

	case FB_TK_PP_LINE
		lexSkipToken( )
		function = ppLine( )

	case FB_TK_PP_LANG
		lexSkipToken( )
		function = ppLang( )

	case else
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		end if
	end select

	'' Comment?
	cComment( )

	'' emit the current line in text form
	hEmitCurrLine( )

	'' EOL
	if( lexGetToken( ) <> FB_TK_EOL ) then
		if( lexGetToken( ) <> FB_TK_EOF ) then
			if( errReport( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
				return FALSE
			else
				'' error recovery: skip until next line
				hSkipUntil( FB_TK_EOL )
			end if
		end if
	end if

end function

'':::::
'' ppInclude		=   '#'INCLUDE ONCE? LIT_STR
''
private function ppInclude( ) as integer
    static as zstring * FB_MAXPATHLEN+1 incfile
    dim as integer isonce = any

	function = FALSE

	'' ONCE?
	isonce = FALSE
	if( lexGetClass( ) = FB_TKCLASS_IDENTIFIER ) then
		if( hMatchText( "ONCE" ) ) then
			isonce = TRUE
		end if
	end if

	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: skip
			lexSkipToken( )
			return TRUE
		end if
	end if

	lexEatToken( incfile )

	function = fbIncludeFile( incfile, isonce )

end function

'':::::
'' ppIncLib			=   '#'INCLIB LIT_STR
''
private function ppIncLib( ) as integer
	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			return FALSE
		else
			'' error recovery: skip
			lexSkipToken( )
			return TRUE
		end if
	end if

	fbAddLib(lexGetText())
	lexSkipToken()

	function = TRUE
end function

'':::::
'' ppLibPath		=   '#'LIBPATH LIT_STR
''
private function ppLibPath( ) as integer
	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			return FALSE
		else
			'' error recovery: skip
			lexSkipToken( )
			return TRUE
		end if
	end if

	fbAddLibPath(lexGetText())
	lexSkipToken()

	function = TRUE
end function

'':::::
'' ppLine		=   '#'LINE LIT_NUM LIT_STR?
''
private function ppLine( ) as integer

	function = FALSE

	'' LIT_NUM
	if( lexGetClass( ) <> FB_TKCLASS_NUMLITERAL ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			return FALSE
		else
			'' error recovery: skip
			hSkipUntil( FB_TK_EOL )
		end if

	else
		lex.ctx->linenum = valint( *lexGetText( ) )
		lexSkipToken( )

		'' LIT_STR?
		if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
    		env.inf.name = *lexGetText( )
    		lexSkipToken( )
		end if
	end if

	function = TRUE

end function

'':::::
'' ppLang		=   '#'LANG LIT_STR
''
private function ppLang( ) as integer
    static as zstring * FB_MAXPATHLEN+1 opt
	dim as FB_LANG id = any

	function = FALSE

	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			return FALSE
		else
			'' error recovery: skip
			lexSkipToken( )
			return TRUE
		end if
	end if

	lexEatToken( opt )

	id = fbGetLangId( @opt )

	if( id = FB_LANG_INVALID ) then
		if( errReport( FB_ERRMSG_INVALIDLANG ) = FALSE ) then
			return FALSE
		end if

	else
		'' fbChangeOption will return FALSE if we should stop
		'' parsing and TRUE if we should continue.

		function = fbChangeOption( FB_COMPOPT_LANG, id )

	end if


end function

'':::::
private sub hRtrimMacroText _
	( _
		byval text as DZSTRING ptr _
	) static

	dim as zstring ptr p

	'' remove the white-spaces (including nl)
	if( text = NULL ) then
		exit sub
	elseif( text->data = NULL ) then
		exit sub
	end if

	p = text->data + (text->len - 1)
    do while( p > text->data )

		select case as const (*p)[0]
		'' space or nl?
    	case CHAR_SPACE, CHAR_TAB, CHAR_LF
    		text->len -= 1
    		*p = 0

		case else
        	exit do
		end select

		p -= 1
    loop

end sub

'':::::
function ppReadLiteral _
	( _
		byval ismultiline as integer _
	) as zstring ptr

	static as DZSTRING text
	dim as integer nestedcnt = 0

    DZstrReset( text )

    do
    	select case as const lexGetToken( LEX_FLAGS )
		case FB_TK_EOF
			if( ismultiline ) then
				errReport( FB_ERRMSG_EXPECTEDMACRO )
			end if

			exit do

		'' nl?
		case FB_TK_EOL
			if( ismultiline = FALSE ) then
				exit do
			end if

    		'' multi-line, only add if it's not at the beginning
    		if( text.len > 0 ) then
    			'' just lf
    			DZstrConcatAssign( text, LFCHAR )
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

    	'' '#'?
    	case CHAR_SHARP
    		select case lexGetLookAhead( 1, (LEX_FLAGS or LEXCHECK_KWDNAMESPC) and _
    								 		(not LEXCHECK_NOWHITESPC) )
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

						hRtrimMacroText( @text )

    					exit do
    				end if

    				nestedcnt -= 1
    			end if

   			end select

   		'' white space?
   		case CHAR_SPACE, CHAR_TAB

    		'' only add if it's not at the beginning
    		if( text.len > 0 ) then
    			'' condensed to a single white-space
    			DZstrConcatAssign( text, " " )
    		end if

    		lexSkipToken( LEX_FLAGS )

    		continue do

	  	case FB_TK_TYPEOF
	  		lexSkipToken( )
			DZstrConcatAssign( text, ppTypeOf( ) )
			exit do

    	end select

    	'' anything else..
    	if( lexGetType() <> FB_DATATYPE_WCHAR ) then
    		DZstrConcatAssign( text, lexGetText( ) )
    	else
    	    DZstrConcatAssignW( text, lexGetTextW( ) )
    	end if

    	lexSkipToken( LEX_FLAGS )

    loop

	function = text.data

end function

'':::::
private sub hRtrimMacroTextW _
	( _
		byval text as DWSTRING ptr _
	) static

	dim as wstring ptr p

	'' remove the white-spaces (including nl)

	p = text->data + (text->len - 1)
    do while( p > text->data )

		select case as const (*p)[0]
		'' space or nl?
    	case CHAR_SPACE, CHAR_TAB, CHAR_LF
    		text->len -= 1
    		*p = 0

		case else
        	exit do
		end select

		p -= 1
    loop

end sub

'':::::
function ppReadLiteralW _
	( _
		byval ismultiline as integer _
	) as wstring ptr

	static as DWSTRING text
	dim as integer nestedcnt = 0

    DWstrAllocate( text, 0 )

    do
    	select case as const lexGetToken( LEX_FLAGS )
		case FB_TK_EOF
			if( ismultiline ) then
				errReport( FB_ERRMSG_EXPECTEDMACRO )
			end if

			exit do

		'' nl?
		case FB_TK_EOL
			if( ismultiline = FALSE ) then
				exit do
			end if

    		'' multi-line, only add if it's not at the beginning
    		if( text.len > 0 ) then
    			'' just lf
    			DWstrConcatAssign( text, wstr( LFCHAR ) )
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

    	'' '#'?
    	case CHAR_SHARP
    		select case lexGetLookAhead( 1, (LEX_FLAGS or LEXCHECK_KWDNAMESPC) and _
    								 		(not LEXCHECK_NOWHITESPC) )
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

						hRtrimMacroTextW( @text )

    					exit do
    				end if

    				nestedcnt -= 1
    			end if

   			end select

   		'' white space?
   		case CHAR_SPACE, CHAR_TAB

    		'' only add if it's not at the beginning
    		if( text.len > 0 ) then
    			'' condensed to a single white-space
    			DWstrConcatAssign( text, wstr( " " ) )
    		end if

    		lexSkipToken( LEX_FLAGS )

    		continue do

	  	case FB_TK_TYPEOF
	  		lexSkipToken( )

	        DWstrConcatAssignA( text, ppTypeOf( ) )
			exit do

    	end select

        '' anything else..
    	if( lexGetType( ) = FB_DATATYPE_WCHAR ) then
    		DWstrConcatAssign( text, lexGetTextW( ) )
    	else
    		DWstrConcatAssignA( text, lexGetText( ) )
    	end if

    	lexSkipToken( LEX_FLAGS )

    loop

	function = text.data

end function

function ppTypeOf _
	( _
	) as zstring ptr

    function = FALSE

	'' get type's name
	dim as zstring ptr res
	dim as integer dtype, lgt
	dim as FBSYMBOL ptr subtype

    '' '('
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
			exit function
		end if
	else
		lexSkipToken( LEXCHECK_NODEFINE )
	end if

	if( cTypeOf( dtype, subtype, lgt ) = TRUE ) then
		res = symbTypeToStr( dtype, subtype, lgt )
	end if
	if( res ) then
		*res = ucase( *res )
	end if

    '' ')'
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT )
		end if
	else
		lexSkipToken( LEXCHECK_NODEFINE )
	end if

	function = res

end function
