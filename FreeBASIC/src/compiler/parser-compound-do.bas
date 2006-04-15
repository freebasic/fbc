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
''DoStatement     =   DO ((WHILE | UNTIL) Expression)? Comment? SttSeparator
''					  SimpleLine*
''					  LOOP ((WHILE | UNTIL) Expression)? .
''
function cDoStatement as integer
    dim as ASTNODE ptr expr
	dim as integer iswhile, isuntil, isinverse, lastcompstmt, op
    dim as FBSYMBOL ptr il, el, cl
    dim as FBCMPSTMT olddostmt

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
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' branch
		if( iswhile ) then
			isinverse = FALSE
		else
			isinverse = TRUE
		end if

		expr = astUpdComp2Branch( expr, el, isinverse )
		if( expr = NULL ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		astAdd( expr )
		cl = il

	else
		expr = NULL
		cl = symbAddLabel( NULL, FALSE )
	end if

	'' save old do stmt info
	olddostmt = env.dostmt

	env.dostmt.cmplabel = cl
	env.dostmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_DO

	'' Comment?
	cComment( )

	'' separator
	if( cStmtSeparator( ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	'' loop body
	do
		if( cSimpleLine( ) = FALSE ) then
			exit do
		end if
	loop while( lexGetToken( ) <> FB_TK_EOF )

	'' LOOP
	if( hMatch( FB_TK_LOOP ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDLOOP )
		exit function
	end if

	'' ((WHILE | UNTIL | SttSeparator) Expression)?
	iswhile = FALSE
	isuntil = fALSE

	select case lexGetToken( )
	case FB_TK_WHILE
		iswhile = TRUE
	case FB_TK_UNTIL
		isuntil = TRUE
	end select

	if( (iswhile or isuntil) and (expr <> NULL) ) then
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
	end if

	'' emit comp label, if needed
	if( cl <> il ) then
		astAdd( astNewLABEL( cl ) )
	end if

	if( iswhile or isuntil ) then
		lexSkipToken( )

		'' Expression
		if( cExpression( expr ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
			exit function
		end if

		'' branch
		if( iswhile ) then
			isinverse = TRUE
		else
			isinverse = FALSE
		end if

		expr = astUpdComp2Branch( expr, il, isinverse )
		if( expr = NULL ) then
			hReportError( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if
		astAdd( expr )

	else
		astAdd( astNewBRANCH( AST_OP_JMP, il ) )
	end if

    '' end label (loop exit)
    astAdd( astNewLABEL( el ) )

	'' restore old for stmt info
	env.dostmt = olddostmt

	''
	env.lastcompound = lastcompstmt

	function = TRUE

end function

