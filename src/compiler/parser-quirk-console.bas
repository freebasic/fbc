'' quirk console statements (VIEW, LOCATE) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'':::::
'' ViewStmt   =   VIEW (PRINT (Expression TO Expression)?) .
''
function cViewStmt(byval is_func as integer) as ASTNODE ptr
	dim as ASTNODE ptr expr1, expr2
	dim as integer default_view, default_view_value

	function = NULL

	default_view = is_func
	default_view_value = iif(is_func,-1,0)

	'' PRINT?
	if( lexGetLookAhead( 1 ) <> FB_TK_PRINT ) then
		exit function
	end if

	'' VIEW
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' PRINT
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' (Expression TO Expression)?
	if( is_func = FALSE ) then
		expr1 = cExpression( )
		if( expr1 <> NULL ) then
			if( hMatch( FB_TK_TO, LEXCHECK_POST_SUFFIX ) = FALSE ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
				expr1 = astNewCONSTi( 0 )
			end if
			hMatchExpressionEx( expr2, FB_DATATYPE_INTEGER )
		else
			default_view = TRUE
		end if
	end if

	if( default_view ) then
		if( is_func ) then
			hMatchLPRNT( )
			hMatchRPRNT( )
		end if
		expr1 = astNewCONSTi( default_view_value )
		expr2 = astNewCONSTi( default_view_value )
	end if

	expr1 = rtlConsoleView( expr1, expr2 )
	if (is_func = FALSE) then
		astAdd(expr1)
	end if

	function = expr1
end function

function cWidthStmt(byval isfunc as integer) as ASTNODE ptr
	dim as ASTNODE ptr fnum, width_arg, height_arg, dev_name
	dim as integer checkrprnt

	function = NULL

	'' WIDTH
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	if( isfunc ) then
		'' '('?
		checkrprnt = hMatch( CHAR_LPRNT )
	else
		checkrprnt = FALSE
	end if

	if( isfunc ) then
		'' used as function?
		if( checkrprnt = FALSE ) then
			return rtlWidthScreen( NULL, NULL, isfunc )
		'' ()?
		elseif( hMatch( CHAR_RPRNT ) ) then
			return rtlWidthScreen( NULL, NULL, isfunc )
		end if
	end if

	if( hMatch( FB_TK_LPRINT ) ) then
		' fb_WidthDev
		dev_name = astNewCONSTstr( "LPT1:" )
		hMatchExpressionEx( width_arg, FB_DATATYPE_INTEGER )

		function = rtlWidthDev( dev_name, width_arg, isfunc )

	elseif( hMatch( CHAR_SHARP ) ) then
		' fb_WidthFile

		hMatchFileNumberExpression( fnum, FB_DATATYPE_INTEGER )

		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( width_arg, FB_DATATYPE_INTEGER )
		else
			width_arg = astNewCONSTi( -1 )
		end if

		function = rtlWidthFile( fnum, width_arg, isfunc )

	elseif( hMatch( CHAR_COMMA ) ) then
		' fb_WidthScreen
		width_arg = astNewCONSTi( -1 )
		hMatchExpressionEx( height_arg, FB_DATATYPE_INTEGER )
		function = rtlWidthScreen( width_arg, height_arg, isfunc )

	else
		hMatchExpressionEx( dev_name, FB_DATATYPE_STRING )
		' fb_WidthDev
		if( symbIsString( astGetDataType( dev_name ) ) ) then
			if( hMatch( CHAR_COMMA ) ) then
				hMatchExpressionEx( width_arg, FB_DATATYPE_INTEGER )
			else
				width_arg = astNewCONSTi( -1 )
			end if
			function = rtlWidthDev( dev_name, width_arg, isfunc )

		else
			' fb_WidthScreen
			width_arg = dev_name
			dev_name = NULL

			if( hMatch( CHAR_COMMA ) ) then
				hMatchExpressionEx( height_arg, FB_DATATYPE_INTEGER )
			else
				height_arg = astNewCONSTi( -1 )
			end if
			function = rtlWidthScreen( width_arg, height_arg, isfunc )

		end if
	end if

	if( checkrprnt ) then
		'' ')'
		hMatchRPRNT( )
	end if

end function

function cColorStmt(byval isfunc as integer) as ASTNODE ptr
	dim as ASTNODE ptr fore_color, back_color = NULL

	function = NULL

	'' COLOR
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	if( isfunc ) then
		'' '('?
		if( hMatch( CHAR_LPRNT ) = TRUE ) then
			fore_color = cExpression( )
			if( hMatch( CHAR_COMMA ) = TRUE ) then
				hMatchExpression( back_color )
			end if
			hMatchRPRNT( )
		end if
	else
		'' '('?
		if( hMatch( CHAR_LPRNT ) = TRUE ) then
			'' expr?
			fore_color = cExpression(  )
			if( hMatch( CHAR_COMMA ) = TRUE ) then
				'' ',' expr ')'
				hMatchExpression( back_color )
				hMatchRPRNT( )
			else
				'' ')' (',' expr)?
				hMatchRPRNT( )
				if( hMatch( CHAR_COMMA ) = TRUE ) then
					hMatchExpression( back_color )
				end if
			end if
		else
			'' expr? (',' expr)?
			fore_color = cExpression(  )
			if( hMatch( CHAR_COMMA ) = TRUE ) then
				hMatchExpression( back_color )
			end if
		end if
	end if

	function = rtlColor( fore_color, back_color, isfunc )
end function

'':::::
'' ScreenFunct   =   SCREEN '(' expr ',' expr ( ',' expr )? ')'
''               |   SCREEN ( '(' ')' )? -- returns the current active/visible pages
''
function cScreenFunct() as ASTNODE ptr
	function = NULL

	'' SCREEN
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	dim as integer match_paren = FALSE
	dim as ASTNODE ptr yexpr = NULL
	'' '('?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )
		match_paren = TRUE
		yexpr = cExpression( )
	end if

	'' pageset?
	if( yexpr = NULL ) then
		function = rtlPageSet( NULL, NULL, TRUE )
	'' readXY..
	else
		dim as ASTNODE ptr xexpr, fexpr
		hMatchCOMMA( )
		hMatchExpressionEx( xexpr, FB_DATATYPE_INTEGER )
		fexpr = NULL
		if( hMatch( CHAR_COMMA ) ) then
			hMatchExpressionEx( fexpr, FB_DATATYPE_INTEGER )
		end if
		function = rtlConsoleReadXY( yexpr, xexpr, fexpr )
	end if

	if( match_paren ) then
		hMatchRPRNT( )
	end if
end function
