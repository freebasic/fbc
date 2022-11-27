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
	name            as const zstring ptr
	id              as integer
	sym             as FBSYMBOL ptr
end type

declare sub ppInclude()
declare sub ppIncLib( )
declare sub ppLibPath( )
declare sub ppLine()
declare sub ppLang()
declare sub ppCmdline()

#if __FB_DEBUG__

declare sub ppDumpTree _
	( _
		byval optimize as integer = FALSE _
	)

declare sub ppLookup _
	( _
	)

#endif


'' globals
	dim shared as PP_CTX pp

const SYMB_MAXKEYWORDS = 24

	dim shared kwdTb( 0 to SYMB_MAXKEYWORDS-1 ) as SYMBKWD => _
	{ _
		(@"IF"      , FB_TK_PP_IF       ), _
		(@"IFDEF"   , FB_TK_PP_IFDEF    ), _
		(@"IFNDEF"  , FB_TK_PP_IFNDEF   ), _
		(@"ELSE"    , FB_TK_PP_ELSE     ), _
		(@"ELSEIF"  , FB_TK_PP_ELSEIF   ), _
		(@"ENDIF"   , FB_TK_PP_ENDIF    ), _
		(@"DEFINE"  , FB_TK_PP_DEFINE   ), _
		(@"UNDEF"   , FB_TK_PP_UNDEF    ), _
		(@"MACRO"   , FB_TK_PP_MACRO    ), _
		(@"ENDMACRO", FB_TK_PP_ENDMACRO ), _
		(@"INCLUDE" , FB_TK_PP_INCLUDE  ), _
		(@"LIBPATH" , FB_TK_PP_LIBPATH  ), _
		(@"INCLIB"  , FB_TK_PP_INCLIB   ), _
		(@"PRAGMA"  , FB_TK_PP_PRAGMA   ), _
		(@"PRINT"   , FB_TK_PP_PRINT    ), _
		(@"ERROR"   , FB_TK_PP_ERROR    ), _
		(@"LINE"    , FB_TK_PP_LINE     ), _
		(@"LANG"    , FB_TK_PP_LANG     ), _
		(@"ASSERT"  , FB_TK_PP_ASSERT   ), _
		(@"CMDLINE" , FB_TK_PP_CMDLINE  ), _
		(@"DUMP"    , FB_TK_PP_DUMP     ), _
		(@"ODUMP"   , FB_TK_PP_ODUMP    ), _
		(@"LOOKUP"  , FB_TK_PP_LOOKUP   ), _
		(NULL) _
	}

''::::
sub ppInit( )
	dim as integer i

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

		symbFreeSymbol( kwdTb(i).sym )
		kwdTb(i).sym = NULL
	next

	symbCompFreeExt( pp.kwdns.nspc.ns.ext )
	hashEnd( @pp.kwdns.nspc.ns.hashtb.tb )

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


'' PreProcess    =   '#'DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL*
''               |   '#'UNDEF ID
''               |   '#'IFDEF ID
''               |   '#'IFNDEF ID
''               |   '#'IF Expression
''               |   '#'ELSE
''               |   '#'ELSEIF Expression
''               |   '#'ENDIF
''               |   '#'ASSERT Expression
''               |   '#'PRINT LITERAL*
''               |   '#'INCLUDE ONCE? LIT_STR
''               |   '#'INCLIB LIT_STR
''               |   '#'LIBPATH LIT_STR
''               |   '#'ERROR LIT_STR .
''
sub ppParse( )
	'' note: when adding any new PP symbol, update ppSkip() too
	select case as const lexGetToken( LEXCHECK_KWDNAMESPC )

	'' DEFINE ID (!WHITESPC '(' ID (',' ID)* ')')? LITERAL+
	case FB_TK_PP_DEFINE
		lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_POST_SUFFIX )
		ppDefine( FALSE )

	'' MACRO ID '(' ID (',' ID)* ')' Comment? EOL
	''    MacroBody*
	'' ENDMACRO
	case FB_TK_PP_MACRO
		lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_POST_SUFFIX )
		ppDefine( TRUE )

	'' UNDEF ID
	case FB_TK_PP_UNDEF
		dim as FBSYMCHAIN ptr chain_ = any
		dim as FBSYMBOL ptr base_parent = any

		'' #undef
		lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_POST_SUFFIX )

		chain_ = cIdentifier( base_parent, FB_IDOPT_NONE )
		if( chain_ <> NULL ) then
			dim as FBSYMBOL ptr sym = chain_->sym
			'' don't remove if it was defined inside any namespace (any
			'' USING reference to that ns would break its linked-list)
			if( symbGetNamespace( sym ) <> @symbGetGlobalNamespc( ) ) then
				errReport( FB_ERRMSG_CANTREMOVENAMESPCSYMBOLS )
			else
				if( symbGetCantUndef( sym ) ) then
					errReport( FB_ERRMSG_CANTUNDEF )
				else
					'' Preserve #undef under -pp, except if #undeffing a macro,
					'' which won't be preserved (only other symbols will be)
					if( env.ppfile_num > 0 ) then
						if( symbIsDefine( sym ) = FALSE ) then
							lexPPOnlyEmitText( "#undef" )
							lexPPOnlyEmitToken( )
						end if
					end if
					'' Forget the symbol so it's no longer found by lookups,
					'' but don't fully delete it, since it might already be used somewhere.
					symbDelFromHash( sym )
				end if
			end if
		end if

		lexSkipToken( )

	'' IFDEF ID
	'' IFNDEF ID
	'' IF ID '=' LITERAL
	case FB_TK_PP_IFDEF, FB_TK_PP_IFNDEF, FB_TK_PP_IF
		ppCondIf( )

	'' ELSE
	case FB_TK_PP_ELSE, FB_TK_PP_ELSEIF
		ppCondElse( )

	'' ENDIF
	case FB_TK_PP_ENDIF
		ppCondEndIf( )

	'' ASSERT Expression
	case FB_TK_PP_ASSERT
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		ppAssert( )

	'' DUMP Expression
	case FB_TK_PP_DUMP
		#if __FB_DEBUG__
			lexSkipToken( LEXCHECK_POST_SUFFIX )
			ppDumpTree( FALSE )
		#else
			errReport( FB_ERRMSG_SYNTAXERROR )
		#endif

	'' ODUMP Expression
	case FB_TK_PP_ODUMP
		#if __FB_DEBUG__
			lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_POST_SUFFIX )
			ppDumpTree( TRUE )
		#else
			errReport( FB_ERRMSG_SYNTAXERROR )
		#endif

	'' LOOKUP Symbol
	case FB_TK_PP_LOOKUP
		#if __FB_DEBUG__
			lexSkipToken( LEXCHECK_NODEFINE or LEXCHECK_POST_SUFFIX )
			ppLookup( )
		#else
			errReport( FB_ERRMSG_SYNTAXERROR )
		#endif

	'' PRINT LITERAL*
	case FB_TK_PP_PRINT
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		print *ppReadLiteral( )

	'' ERROR LITERAL*
	case FB_TK_PP_ERROR
		lexSkipToken( LEXCHECK_POST_SUFFIX )
		errReportEx( -1, *ppReadLiteral( ) )
		parser.stmt.cnt += 1

	'' INCLUDE ONCE? LIT_STR
	case FB_TK_PP_INCLUDE
		lexSkipToken( LEXCHECK_POST_SUFFIX)
		ppInclude( )

	'' INCLIB LIT_STR
	case FB_TK_PP_INCLIB
		lexSkipToken( LEXCHECK_POST_SUFFIX)
		ppIncLib( )

	'' LIBPATH LIT_STR
	case FB_TK_PP_LIBPATH
		lexSkipToken( LEXCHECK_POST_SUFFIX)
		ppLibPath( )

	'' PRAGMA ...
	case FB_TK_PP_PRAGMA
		lexSkipToken( LEXCHECK_POST_SUFFIX)
		ppPragma( )

	case FB_TK_PP_LINE
		lexSkipToken( LEXCHECK_POST_SUFFIX)
		ppLine()

	case FB_TK_PP_LANG
		lexSkipToken( LEXCHECK_POST_SUFFIX)
		ppLang( )

	case FB_TK_PP_CMDLINE
		lexSkipToken( LEXCHECK_POST_SUFFIX)
		ppCmdline( )

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
	end select

	'' Comment?
	cComment( )

	'' emit the current line in text form
	hEmitCurrLine( )

	'' EOL
	if( lexGetToken( ) <> FB_TK_EOL ) then
		if( lexGetToken( ) <> FB_TK_EOF ) then
			errReport( FB_ERRMSG_EXPECTEDEOL )
			'' error recovery: skip until next line
			hSkipUntil( FB_TK_EOL )
		end if
	end if
end sub

'':::::
'' ppInclude        =   '#'INCLUDE ONCE? LIT_STR
''
private sub ppInclude()
	static as zstring * FB_MAXPATHLEN+1 incfile
	dim as integer isonce = any

	'' ONCE?
	isonce = hMatchIdOrKw( "ONCE", LEXCHECK_POST_SUFFIX )

	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip
		lexSkipToken( )
		return
	end if

	lexEatToken( incfile )

	fbIncludeFile( incfile, isonce )
end sub

'':::::
'' ppIncLib         =   '#'INCLIB LIT_STR
''
private sub ppIncLib( )
	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip
		lexSkipToken( )
		return
	end if

	'' Preserve under -pp
	if( env.ppfile_num > 0 ) then
		lexPPOnlyEmitText( "#inclib" )
		lexPPOnlyEmitToken( )
	end if

	fbAddLib( lexGetText( ) )
	lexSkipToken( )
end sub

'':::::
'' ppLibPath        =   '#'LIBPATH LIT_STR
''
private sub ppLibPath( )
	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip
		lexSkipToken( )
		return
	end if

	'' Preserve under -pp
	if( env.ppfile_num > 0 ) then
		lexPPOnlyEmitText( "#libpath" )
		lexPPOnlyEmitToken( )
	end if

	fbAddLibPath( lexGetText( ) )
	lexSkipToken( )
end sub

'':::::
'' ppLine       =   '#'LINE LIT_NUM LIT_STR?
''
private sub ppLine()
	'' LIT_NUM
	if( lexGetClass( ) <> FB_TKCLASS_NUMLITERAL ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip
		hSkipUntil( FB_TK_EOL )
	else
		lex.ctx->linenum = clng( *lexGetText( ) )
		lexSkipToken( )

		'' LIT_STR?
		if( lexGetClass( ) = FB_TKCLASS_STRLITERAL ) then
			fbOverrideFilename( *lexGetText( ) )
			lexSkipToken( )
		end if
	end if
end sub

'':::::
'' ppLang       =   '#'LANG LIT_STR
''
private sub ppLang( )
	dim as FB_LANG id = any

	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip
		lexSkipToken( )
		exit sub
	end if

	id = fbGetLangId( lexGetText( ) )
	if( id = FB_LANG_INVALID ) then
		errReport( FB_ERRMSG_INVALIDLANG )
		lexSkipToken( )
		exit sub
	end if

	'' Preserve under -pp
	if( env.ppfile_num > 0 ) then
		lexPPOnlyEmitText( "#lang """ + fbGetLangName( id ) + """" )
	end if

	fbChangeOption( FB_COMPOPT_LANG, id )
	lexSkipToken( )
end sub

#if __FB_DEBUG__

'':::::
'' ppDump      =   '#'DUMP|ODUMP Expression
''
private sub ppDumpTree _
	( _
		byval optimize as integer _
	)

	dim as ASTNODE ptr expr = any

	expr = cExpression( )

	if( expr <> NULL ) then

		if( optimize ) then
			expr = astOptimizeTree( expr )
		end if

		astDumpTree( expr )

		astDelTree( expr )
	else
		errReport( FB_ERRMSG_SYNTAXERROR )
	end if

end sub

'':::::
'' ppLookup    =   '#'LOOKUP name
''
private sub ppLookup _
	( _
	)

	symbDumpLookup( lexGetText( ) )
	lexSkipToken( )

end sub

#endif

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
				lexSkipToken( LEX_FLAGS or LEXCHECK_NOLINECONT )

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
			'' '##'?
			case CHAR_SHARP
				lexSkipToken( LEX_FLAGS )
				lexSkipToken( LEX_FLAGS or LEXCHECK_NOLINECONT)

				'' we can't check lexGetToken( ) here because a single '_' will
				'' return as FB_TK_ID, so we need to do a lexGetText( ) check
				'' Is only '##_'?
				if *lexGetText( ) <> "_" then
					DZstrConcatAssign( text, "##" )
				end if

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
				lexSkipToken( LEX_FLAGS or LEXCHECK_NOLINECONT )

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
			'' '##'?
			case CHAR_SHARP
				lexSkipToken( LEX_FLAGS )
				lexSkipToken( LEX_FLAGS or LEXCHECK_NOLINECONT)

				'' we can't check lexGetToken( ) here because a single '_' will
				'' return as FB_TK_ID, so we need to do a lexGetText( ) check
				'' Is only '##_'?
				if *lexGetText( ) <> "_" then
					DWstrConcatAssignA( text, "##" )
				end if

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

function ppTypeOf( ) as string
	'' TYPEOF
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' '('
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDLPRNT )
	else
		lexSkipToken( )
	end if

	dim as integer dtype, is_fixlenstr
	dim as longint lgt
	dim as FBSYMBOL ptr subtype
	cTypeOf( dtype, subtype, lgt, is_fixlenstr )

	function = ucase( symbTypeToStr( dtype, subtype, lgt, is_fixlenstr ) )

	'' ')'
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		errReport( FB_ERRMSG_EXPECTEDRPRNT )
		'' error recovery: skip until next ')'
		hSkipUntil( CHAR_RPRNT )
	else
		lexSkipToken( )
	end if
end function


'' fbcParseArgsFromString() exists in fbc.bas which is our main
'' entry point for the fbc compiler.  We would probably like to
'' separate it in to another interface, but fbc.bas has everything
'' we need to process options.  So, we've made fbcParseArgsFromString()
'' public and just declare it here because for now this is the only
'' place we use it outside of fbc.bas

declare sub fbcParseArgsFromString _
	( _
		byval args as zstring ptr, _
		byval is_source as integer, _
		byval is_file as integer _
	)

'':::::
'' ppCmdLine        =   '#'CMDLINE LIT_STR
''
private sub ppCmdline( )
	dim as zstring ptr args = any

	'' Prepocessor is done parsing? warn that statement is ignored
	if( parser.stage > 0 ) then
		errReportWarn( FB_WARNINGMSG_CMDLINEIGNORED )
		'' error recovery: skip
		lexSkipToken( )
		exit sub
	end if

	if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip
		lexSkipToken( )
		exit sub
	end if

	args = lexGetText( )

	'' Preserve under -pp
	if( env.ppfile_num > 0 ) then
		lexPPOnlyEmitText( "#cmdline """ + *args + """" )
	end if

	'' not in module scope?
	if( parser.scope <> FB_MAINSCOPE ) then

		if( fbIsModLevel( ) = FALSE ) then
			errReport( FB_ERRMSG_ILLEGALINSIDEASUB )
		else
			errReport( FB_ERRMSG_ILLEGALINSIDEASCOPE )
		end if

	'' not first module?
	elseif( env.module_count <> 1 ) then
		errReportWarn( FB_WARNINGMSG_CMDLINEIGNORED )

	'' ignoring all #cmdline's due to '-z nocmdline' option?
	elseif( fbGetOption(FB_COMPOPT_NOCMDLINE) ) then
		errReportWarn( FB_WARNINGMSG_CMDLINEIGNORED )

	'' Already restarted due to #cmdline "-end" | "-restart"?
	elseif( (env.restart_status and FB_RESTART_CMDLINE) <> 0 ) then
		'' do nothing

	'' #cmdline "-end" ?
	elseif( lcase(trim(*args)) = "-end" ) then

		'' We don't have any clever way to auto-detect when all #cmdline's have been read
		'' Check for '#cmdline "-end"' to begin a restart and not wait for end of file
		'' The restart request will have been stored in env.restart_request
		fbRestartAcceptRequest( FB_RESTART_CMDLINE )

		'' and don't show any more errors until we've restarted
		errHideFurtherErrors()

	'' #cmdline "-restart" ?
	elseif( lcase(trim(*args)) = "-restart" ) then

		'' like "-end" above, but always reset fbc
		fbRestartBeginRequest( FB_RESTART_FBC_CMDLINE )
		fbRestartAcceptRequest( FB_RESTART_CMDLINE )

		'' and don't show any more errors until we've restarted
		errHideFurtherErrors()

	'' must be first pass in the first module, so process the option
	else
		fbcParseArgsFromString( args, TRUE, FALSE )

	end if

	'' "args..."
	lexSkipToken( )

end sub
