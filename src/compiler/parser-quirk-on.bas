'' quirk conditional statements (ON ... GOTO|GOSUB) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

private function cGOTBStmt _
	( _
		byval expr as ASTNODE ptr, _
		byval isgoto as integer _
	) as integer

	dim as integer l = any
	dim as FBSYMBOL ptr sym = any, exitlabel = any
	dim as ulongint values(0 to FB_MAXGOTBITEMS-1) = any
	dim as FBSYMBOL ptr labels(0 to FB_MAXGOTBITEMS-1) = any
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr base_parent = any

	function = FALSE

	''    ON expr GOTO label1, label2, etc.
	'' works similar to a
	''    SELECT CASE AS CONST expr
	''    CASE 1
	''    CASE 2
	''    etc.
	'' it also uses a jump table, however the values are "preset",
	'' in contrast to SELECT where they're given via CASE statements.
	'' expr = 1   ->   label1
	'' expr = 2   ->   label2
	'' etc.
	'' This means: minval = 1, maxval = labelcount.

	'' convert to uinteger if needed
	if( astGetDataType( expr ) <> FB_DATATYPE_UINT ) then
		expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_TYPEMISMATCH, TRUE )
			hSkipStmt( )
			exit function
		end if
	end if

	'' GOTO|GOSUB
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' store expression into a temp var
	sym = symbAddTempVar( FB_DATATYPE_UINT )
	astAdd( astNewASSIGN( astNewVAR( sym ), expr, AST_OPOPT_ISINI ) )

	'' read labels
	l = 0
	do
		'' Label
		select case lexGetClass( )
		case FB_TKCLASS_NUMLITERAL, FB_TKCLASS_IDENTIFIER
			chain_ = cIdentifier( base_parent )

			'' Not not too many target labels yet?
			if( l < FB_MAXGOTBITEMS ) then
				labels(l) = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
				if( labels(l) = NULL ) then
					labels(l) = symbAddLabel( lexGetText( ), FB_SYMBOPT_CREATEALIAS )
				end if
			elseif( l = FB_MAXGOTBITEMS ) then '' (Only show the error once)
				errReport( FB_ERRMSG_TOOMANYLABELS )
				'' Error recovery: continue parsing all labels, but don't add
				'' them to the table anymore
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )

		case else
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			if( l < FB_MAXGOTBITEMS ) then
				'' error recovery: fake an label
				labels(l) = symbAddLabel( symbUniqueLabel( ), FB_SYMBOPT_NONE )
			end if
		end select

		l += 1
	loop while( hMatch( CHAR_COMMA ) )

	'' Too many target labels?
	if( l >= FB_MAXGOTBITEMS ) then
		l = FB_MAXGOTBITEMS - 1
	end if

	exitlabel = symbAddLabel( NULL )

	'' labelcount = l, minval = 1, maxval = l
	'' astBuildJMPTB expects values to be biased
	''  bias = 1, span = labelcount-1

	'' Fill beginning of values buffer with the 1,2,3,4,... values (1 biased)
	for i as integer = 0 to l - 1
		values(i) = i
	next

	'' don't let span underflow
	expr = astBuildJMPTB( sym, @values(0), @labels(0), l, exitlabel, 1, iif(l, l-1, 0) )

	if( isgoto ) then
		astAdd( expr )
	else
		astGosubAddJumpPtr( parser.currproc, expr, exitlabel )
	end if

	'' emit exit label
	astAdd( astNewLABEL( exitlabel ) )

	function = TRUE
end function

'':::::
''OnStmt        =   ON LOCAL? (Keyword | Expression) (GOTO|GOSUB) Label .
''
function cOnStmt _
	( _
		_
	) as integer

	dim as ASTNODE ptr expr = any
	dim as integer isgoto = any, islocal = any, isrestore = any
	dim as FBSYMBOL ptr label = any
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr base_parent = any

	function = FALSE

	'' ON
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' LOCAL?
	if( hMatch( FB_TK_LOCAL, LEXCHECK_POST_SUFFIX ) ) then
		if( fbIsModLevel( ) ) then
			errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
			exit function
		end if
		islocal = TRUE
	else
		islocal = FALSE
	end if

	'' ERROR | Expression
	expr = NULL
	if( lexGetToken( ) = FB_TK_ERROR ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )
	else
		hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
	end if

	'' GOTO|GOSUB
	select case lexGetToken( )
	case FB_TK_GOTO
		isgoto = TRUE

	case FB_TK_GOSUB
		'' can't do GOSUB with ON ERROR
		if( expr = NULL ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0 )
		end if

		if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
			errReportNotAllowed( FB_LANG_OPT_GOSUB )
			hSkipStmt( )
			return TRUE
		end if

		'' gosub allowed by OPTION GOSUB?
		if( env.opt.gosub = FALSE ) then
			'' GOSUB is allowed, but hasn't been enabled with OPTION GOSUB
			errReport( FB_ERRMSG_SYNTAXERROR )
			hSkipStmt( )
			return TRUE
		end if

		isgoto = FALSE

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip stmt
		hSkipStmt( )
		return TRUE
	end select

	'' on error?
	if( expr = NULL ) then
		'' GOTO|GOSUB
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		isrestore = FALSE
		'' ON ERROR GOTO 0?
		if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
			if( *lexGetText( ) = "0" ) then
				lexSkipToken( )
				isrestore = TRUE
			end if
		end if

		if( isrestore = FALSE ) then
			'' Label
			chain_ = cIdentifier( base_parent )

			label = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
			if( label = NULL ) then
				label = symbAddLabel( lexGetText( ), FB_SYMBOPT_CREATEALIAS )
			end if

			lexSkipToken( LEXCHECK_POST_SUFFIX )

			expr = astNewADDROF( astNewVAR( label ) )
			rtlErrorSetHandler( expr, (islocal = TRUE) )
		else
			rtlErrorSetHandler( astNewCONSTi( NULL, FB_DATATYPE_UINT ), (islocal = TRUE) )
		end if

		function = TRUE
	else
		function = cGOTBStmt( expr, isgoto )
	end if

end function
