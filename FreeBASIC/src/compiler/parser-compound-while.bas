''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''WhileStatement  =   WHILE Expression Comment? SttSeparator
''					  SimpleLine*
''					  WEND .
''
function cWhileStatement as integer
    dim as ASTNODE ptr expr
    dim as integer lastcompstmt
    dim as FBSYMBOL ptr il, el
    dim as FBCMPSTMT oldwhilestmt

	function = FALSE

	'' WHILE
	lexSkipToken( )

	'' add ini and end labels
	il = symbAddLabel( NULL )
	el = symbAddLabel( NULL )

	'' save old while stmt info
	oldwhilestmt = env.whilestmt

	env.whilestmt.cmplabel = il
	env.whilestmt.endlabel = el

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_WHILE

	'' emit ini label
	astAdd( astNewLABEL( il ) )

	'' Expression
	if( cExpression( expr ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
		exit function
	end if

	'' branch
	expr = astUpdComp2Branch( expr, el, FALSE )
	if( expr = NULL ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end if
	astAdd( expr )

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
	loop while( (lexGetToken( ) <> FB_TK_EOF) )

	'' WEND
	if( hMatch( FB_TK_WEND ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDWEND )
		exit function
	end if

    astAdd( astNewBRANCH( IR_OP_JMP, il ) )

    '' end label (loop exit)
    astAdd( astNewLABEL( el ) )

	'' restore old while stmt info
	env.whilestmt = oldwhilestmt

	''
	env.lastcompound = lastcompstmt

	function = TRUE

end function

