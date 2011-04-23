''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


'' quirk conditional statements (ON ... GOTO|GOSUB) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

'':::::
function cGOTBStmt _
	( _
		byval expr as ASTNODE ptr, _
		byval isgoto as integer _
	) as integer

	dim as ASTNODE ptr idxexpr = any
	dim as integer l = any
	dim as FBSYMBOL ptr sym = any, exitlabel = any, tbsym = any
	dim as FBSYMBOL ptr labelTB(0 to FB_MAXGOTBITEMS-1) = any
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr base_parent = any

	function = FALSE

	'' convert to uinteger if needed
	if( astGetDataType( expr ) <> FB_DATATYPE_UINT ) then
		expr = astNewCONV( FB_DATATYPE_UINT, NULL, expr )
	end if

	'' store expression into a temp var
	sym = symbAddTempVar( FB_DATATYPE_UINT )
	if( sym = NULL ) then
		exit function
	end if

	expr = astNewASSIGN( astNewVAR( sym, 0, FB_DATATYPE_UINT ), expr )
	if( expr = NULL ) then
		exit function
	end if
	astAdd( expr )

	'' read labels
	l = 0
	do
		'' Label
		select case lexGetClass( )
		case FB_TKCLASS_NUMLITERAL, FB_TKCLASS_IDENTIFIER
			chain_ = cIdentifier( base_parent )
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			labelTB(l) = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
			if( labelTB(l) = NULL ) then
				labelTB(l) = symbAddLabel( lexGetText( ), FB_SYMBOPT_CREATEALIAS )
			end if

			lexSkipToken( )

		case else
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an label
				labelTB(l) = symbAddLabel( hMakeTmpStr( ), FB_SYMBOPT_NONE )
			end if
		end select

		l += 1
	loop while( hMatch( CHAR_COMMA ) )

	''
	exitlabel = symbAddLabel( NULL )

	'' < 1?
	expr = astNewBOP( AST_OP_LT, astNewVAR( sym, 0, FB_DATATYPE_UINT ), _
					  astNewCONSTi( 1, FB_DATATYPE_UINT ), exitlabel, FALSE )
	astAdd( expr )

	'' > labels?
	expr = astNewBOP( AST_OP_GT, astNewVAR( sym, 0, FB_DATATYPE_UINT ), _
					  astNewCONSTi( l, FB_DATATYPE_UINT ), exitlabel, FALSE )
	astAdd( expr )

	'' jump to table[idx]
	tbsym = hJumpTbAllocSym( )

	idxexpr = astNewBOP( AST_OP_MUL, _
						 astNewVAR( sym, 0, FB_DATATYPE_UINT ), _
						 astNewCONSTi( FB_POINTERSIZE, FB_DATATYPE_UINT ) )

	expr = astNewIDX( astNewVAR( tbsym, _
								 -1*FB_POINTERSIZE, _
								 typeAddrOf( FB_DATATYPE_VOID ) ), _
					  idxexpr, _
					  typeAddrOf( FB_DATATYPE_VOID ), NULL )

	'' not high-level IR? emit the jump before the table
	if( (irGetOption( IR_OPT_HIGHLEVEL ) = FALSE) or (isgoto = FALSE) ) then
		if( isgoto ) then
			astAdd( astNewBRANCH( AST_OP_JUMPPTR, NULL, expr ) )
		else
			astGosubAddJumpPtr( parser.currproc, expr, exitlabel )
		end if
	end if

	'' emit table
	astAdd( astNewJMPTB_Begin( tbsym ) )

	''
	dim as integer i = any
	for i = 0 to l-1
		astAdd( astNewJMPTB_Label( FB_DATATYPE_UINT, labelTB(i) ) )
	next

	astAdd( astNewJMPTB_End( tbsym ) )

	'' high-level IR? emit the jump after the table
	if( irGetOption( IR_OPT_HIGHLEVEL and isgoto ) ) then
		astAdd( astNewBRANCH( AST_OP_JUMPPTR, NULL, expr ) )
    end if

	'' emit exit label
	astAdd( astNewLABEL( exitlabel ) )

	function = TRUE

end function

'':::::
''OnStmt		=	ON LOCAL? (Keyword | Expression) (GOTO|GOSUB) Label .
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
	lexSkipToken( )

	'' LOCAL?
	if( hMatch( FB_TK_LOCAL ) ) then
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
		lexSkipToken( )
	else
		hMatchExpressionEx( expr, FB_DATATYPE_INTEGER )
	end if

	'' GOTO|GOSUB
	select case lexGetToken( )
	case FB_TK_GOTO
		lexSkipToken( )
		isgoto = TRUE

	case FB_TK_GOSUB
		'' can't do GOSUB with ON ERROR
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		if( fbLangOptIsSet( FB_LANG_OPT_GOSUB ) = FALSE ) then
			if( errReportNotAllowed( FB_LANG_OPT_GOSUB ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return TRUE
			end if
		end if

		'' gosub allowed by OPTION GOSUB?
		if( env.opt.gosub ) then
			lexSkipToken( )
			isgoto = FALSE

		else
			'' GOSUB is allowed, but hasn't been enabled with OPTION GOSUB
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			else
				hSkipStmt( )
				return TRUE
			end if

		end if

	case else
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: skip stmt
			hSkipStmt( )
			return TRUE
		end if
	end select

	'' on error?
	if( expr = NULL ) then
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
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			label = symbFindByClass( chain_, FB_SYMBCLASS_LABEL )
			if( label = NULL ) then
				label = symbAddLabel( lexGetText( ), FB_SYMBOPT_CREATEALIAS )
			end if

			lexSkipToken( )

			expr = astNewADDROF( astNewVAR( label, 0, FB_DATATYPE_UINT ) )
			rtlErrorSetHandler( expr, (islocal = TRUE) )

		else
			rtlErrorSetHandler( astNewCONSTi( NULL, FB_DATATYPE_UINT ), (islocal = TRUE) )
		end if

		function = TRUE

	else
		function = cGOTBStmt( expr, isgoto )
	end if

end function

