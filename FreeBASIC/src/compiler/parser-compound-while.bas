''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


'' WHILE..WEND compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''WhileStmtBegin  =   WHILE Expression .
''
function cWhileStmtBegin as integer
    dim as ASTNODE ptr expr = any
    dim as FBSYMBOL ptr il = any, el = any
    dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	'' WHILE
	lexSkipToken( )

	'' add ini and end labels
	il = symbAddLabel( NULL )
	el = symbAddLabel( NULL, FB_SYMBOPT_NONE )

	'' emit ini label
	astAdd( astNewLABEL( il ) )

	'' Expression
	expr = cExpression( )
	if( expr = NULL ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			exit function
		else
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
		end if
	end if

	'' branch
	expr = astUpdComp2Branch( expr, el, FALSE )
	if( expr = NULL ) then
		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
			exit function
		end if

	else
		astAdd( expr )
	end if

	'' push to stmt stack
	stk = cCompStmtPush( FB_TK_WHILE )
	stk->scopenode = astScopeBegin( )
	stk->while.cmplabel = il
	stk->while.endlabel = el

	function = TRUE

end function

'':::::
''WhileStmtEnd  =   WEND
''
function cWhileStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_WHILE )
	if( stk = NULL ) then
		exit function
	end if

	'' WEND
	lexSkipToken( )

	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

    astAdd( astNewBRANCH( AST_OP_JMP, stk->while.cmplabel ) )

    '' end label (loop exit)
    astAdd( astNewLABEL( stk->while.endlabel ) )

	'' pop from stmt stack
	cCompStmtPop( stk )

	function = TRUE

end function
