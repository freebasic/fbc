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


'' DO..LOOP compound statement parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
'' DoStmtBegin     =   DO ((WHILE | UNTIL) Expression)? .
''
function cDoStmtBegin as integer
    dim as ASTNODE ptr expr
	dim as integer iswhile, isuntil, isinverse
    dim as FBSYMBOL ptr il, el, cl
    dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	'' DO
	lexSkipToken( )

	'' add ini and end labels (will be used by any EXIT DO)
	il = symbAddLabel( NULL, TRUE )
	el = symbAddLabel( NULL, FALSE )

	'' emit ini label
	astAdd( astNewLABEL( il ) )

	'' ((WHILE | UNTIL) Expression)?
	iswhile = FALSE
	isuntil = fALSE

	select case lexGetToken( )
	case FB_TK_WHILE
		iswhile = TRUE
	case FB_TK_UNTIL
		isuntil = TRUE
	end select

	if( iswhile or isuntil ) then
		lexSkipToken( )

		'' Expression
		if( cExpression( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a node
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		'' branch
		if( iswhile ) then
			isinverse = FALSE
		else
			isinverse = TRUE
		end if

		expr = astUpdComp2Branch( expr, el, isinverse )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a node
				expr = astNewNOP( )
			end if
		end if

		astAdd( expr )
		cl = il

	else
		expr = NULL
		cl = symbAddLabel( NULL, FALSE )
	end if

	'' push to stmt stack
	stk = cCompStmtPush( FB_TK_DO )
	stk->do.attop = (expr <> NULL)
	stk->do.inilabel = il

	env.stmt.do.cmplabel = cl
	env.stmt.do.endlabel = el

	function = TRUE

end function

'':::::
'' DoStmtEnd     =   LOOP ((WHILE | UNTIL) Expression)? .
''
function cDoStmtEnd as integer
    dim as ASTNODE ptr expr
	dim as integer iswhile, isuntil, isinverse
	dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_DO )
	if( stk = NULL ) then
		exit function
	end if

	'' LOOP
	lexSkipToken( )

	'' ((WHILE | UNTIL | SttSeparator) Expression)?
	iswhile = FALSE
	isuntil = fALSE

	select case lexGetToken( )
	case FB_TK_WHILE
		iswhile = TRUE
	case FB_TK_UNTIL
		isuntil = TRUE
	end select

	if( (iswhile or isuntil) and (stk->do.attop) ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		end if
	end if

	'' emit comp label, if needed
	if( env.stmt.do.cmplabel <> stk->do.inilabel ) then
		astAdd( astNewLABEL( env.stmt.do.cmplabel ) )
	end if

	if( iswhile or isuntil ) then
		lexSkipToken( )

		'' Expression
		if( cExpression( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a node
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			end if
		end if

		'' branch
		if( iswhile ) then
			isinverse = TRUE
		else
			isinverse = FALSE
		end if

		expr = astUpdComp2Branch( expr, stk->do.inilabel, isinverse )
		if( expr = NULL ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a node
				expr = astNewNOP( )
			end if
		end if

		astAdd( expr )

	else
		astAdd( astNewBRANCH( AST_OP_JMP, stk->do.inilabel ) )
	end if

    '' end label (loop exit)
    astAdd( astNewLABEL( env.stmt.do.endlabel ) )

	'' pop from stmt stack
	cCompStmtPop( stk )

	function = TRUE

end function
