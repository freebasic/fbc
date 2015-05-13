'' atom constants and literals parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

function cConstant( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	'' check visibility
	if( symbCheckAccess( sym ) = FALSE ) then
		errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
	end if

  	'' ID
  	lexSkipToken( )

	dtype = symbGetFullType( sym )
	subtype = symbGetSubType( sym )

  	select case as const dtype
  	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
  		return astNewVAR( symbGetConstValStr( sym ), 0, dtype )

  	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
  		return astNewCONSTl( symbGetConstValLong( sym ), dtype )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
  		return astNewCONSTf( symbGetConstValFloat( sym ), dtype )

  	case FB_DATATYPE_LONG, FB_DATATYPE_ULONG
  		if( FB_LONGSIZE = len( integer ) ) then
  			return astNewCONSTi( symbGetConstValInt( sym ), dtype, subtype )
  		else
  			return astNewCONSTl( symbGetConstValLong( sym ), dtype )
  		end if

  	case else
		'' bytes/shorts/integers/enums
		return astNewCONSTi( symbGetConstValInt( sym ), dtype, subtype )

  	end select

end function

'':::::
'' LitString	= 	STR_LITERAL STR_LITERAL* .
''
function cStrLiteral _
	( _
		byval skiptoken as integer _
	) as ASTNODE ptr

    dim as integer dtype = any
	dim as FBSYMBOL ptr sym = any
    dim as integer lgt = any, isunicode = any
    dim as zstring ptr zs = any
	dim as wstring ptr ws = any

    dim as ASTNODE ptr expr = NULL

	do
  		dtype = lexGetType( )
		lgt = lexGetTextLen( )

  		if( dtype <> FB_DATATYPE_WCHAR ) then
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
				dtype = FB_DATATYPE_WCHAR
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
			expr = astNewVAR( sym, 0, dtype )
		else
			expr = astNewBOP( AST_OP_ADD, expr, astNewVAR( sym, 0, dtype ) )
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

'':::::
function cNumLiteral _
	( _
		byval skiptoken as integer _
	) as ASTNODE ptr

	dim as integer dtype = any

  	dtype = lexGetType( )
  	select case as const dtype
  	case FB_DATATYPE_LONGINT
		function = astNewCONSTl( vallng( *lexGetText( ) ), dtype )

	case FB_DATATYPE_ULONGINT
		function = astNewCONSTl( valulng( *lexGetText( ) ), dtype )

  	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = astNewCONSTf( val( *lexGetText( ) ), dtype )

	case FB_DATATYPE_UINT
		function = astNewCONSTi( valuint( *lexGetText( ) ), dtype )

  	case FB_DATATYPE_LONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = astNewCONSTi( valint( *lexGetText( ) ), dtype )
		else
			function = astNewCONSTl( vallng( *lexGetText( ) ), dtype )
		end if

	case FB_DATATYPE_ULONG
		if( FB_LONGSIZE = len( integer ) ) then
			function = astNewCONSTi( valuint( *lexGetText( ) ), dtype )
		else
			function = astNewCONSTl( valulng( *lexGetText( ) ), dtype )
		end if

	case else
		function = astNewCONSTi( valint( *lexGetText( ) ), dtype )
  	end select

  	if( skiptoken ) then
  		lexSkipToken( )
  	end if

end function

'':::::
''Literal		  = NUM_LITERAL
''				  | STR_LITERAL STR_LITERAL* .
''
function cLiteral _
	( _
		_
	) as ASTNODE ptr

	select case lexGetClass( )
	'' NUM_LITERAL?
	case FB_TKCLASS_NUMLITERAL
		return cNumLiteral( )

  	'' (STR_LITERAL STR_LITERAL*)?
  	case FB_TKCLASS_STRLITERAL
        return cStrLiteral( )

  	case else
  		return NULL
  	end select

end function

