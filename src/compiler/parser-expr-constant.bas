'' atom constants and literals parsing
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

function cConstant( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
	'' Check visibility of constant
	if( symbCheckAccess( sym ) = FALSE ) then
		errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
	end if

	'' ID
	lexSkipToken( LEXCHECK_POST_LANG_SUFFIX )

	function = astBuildConst( sym )
end function

'':::::
'' LitString    =   STR_LITERAL STR_LITERAL* .
''
function cStrLiteral( byval skiptoken as integer ) as ASTNODE ptr
	dim as FBSYMBOL ptr sym = any
	dim as integer lgt = any, isunicode = any
	dim as zstring ptr zs = any
	dim as wstring ptr ws = any

	dim as ASTNODE ptr expr = NULL

	do
		lgt = lexGetTextLen( )

		if( lexGetType( ) <> FB_DATATYPE_WCHAR ) then
			'' escaped? convert to internal format..
			if( lexGetToken( ) = FB_TK_STRLIT_ESC ) then
				zs = hReEscape( lexGetText( ), lgt, isunicode )
			else
				zs = lexGetText( )

				'' any '\'?
				if( lexGetHasSlash( ) ) then
					if( fbPdCheckIsSet( FB_PDCHECK_ESCSEQ ) ) then
						if( lexGetToken( ) <> FB_TK_STRLIT_NOESC ) then
							if( hHasEscape( zs ) ) then
								errReportWarn( FB_WARNINGMSG_POSSIBLEESCSEQ, _
								               zs, _
								               FB_ERRMSGOPT_ADDCOLON or FB_ERRMSGOPT_ADDQUOTES )
							end if
						end if
					end if
				end if

				isunicode = FALSE
			end if

			if( isunicode = FALSE ) then
				sym = symbAllocStrConst( zs, lgt )
			'' convert to unicode..
			else
				sym = symbAllocWstrConst( wstr( *zs ), lgt )
			end if

		else
			'' escaped? convert to internal format..
			if( lexGetToken( ) = FB_TK_STRLIT_ESC ) then
				ws = hReEscapeW( lexGetTextW( ), lgt )
			else
				ws = lexGetTextW( )

				'' any '\'?
				if( lexGetHasSlash( ) ) then
					if( fbPdCheckIsSet( FB_PDCHECK_ESCSEQ ) ) then
						if( lexGetToken( ) <> FB_TK_STRLIT_NOESC ) then
							if( hHasEscapeW( ws ) ) then
								errReportWarn( FB_WARNINGMSG_POSSIBLEESCSEQ )
							end if
						end if
					end if
				end if
			end if

			sym = symbAllocWstrConst( ws, lgt )
		end if

		if( expr = NULL ) then
			expr = astNewVAR( sym )
		else
			expr = astNewBOP( AST_OP_ADD, expr, astNewVAR( sym ) )
		end if

		if( skiptoken ) then
			lexSkipToken( )

			'' not another literal string?
			if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
				exit do
			end if

		else
			exit do
		end if
	loop

	function = expr
end function

function cNumLiteral( byval skiptoken as integer ) as ASTNODE ptr
	dim as integer dtype = any

	dtype = lexGetType( )

	select case( dtype )
	case FB_DATATYPE_DOUBLE
		function = astNewCONSTf( val( *lexGetText( ) ), dtype )

	case FB_DATATYPE_SINGLE
		dim fval as single = val( *lexGetText( ) )
		function = astNewCONSTf( fval , dtype )

	case else
		if( typeIsSigned( dtype ) ) then
			function = astNewCONSTi( clngint( *lexGetText( ) ), dtype )
		else
			function = astNewCONSTi( culngint( *lexGetText( ) ), dtype )
		end if
	end select

	if( skiptoken ) then
		lexSkipToken( )
	end if
end function
