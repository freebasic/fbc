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


'' IF..ELSE..ELSEIF..END IF compound statement parsing (single and multi-line)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''SingleIfStatement=  !(COMMENT|NEWLINE|STATSEP) NUM_LIT | SimpleStatement*)
''                    (ELSE SimpleStatement*)?
''
function cSingleIfStatement( byval expr as ASTNODE ptr ) as integer
	dim as FBSYMBOL ptr el, nl, l
	dim as integer lastcompstmt

	function = FALSE

	'' !COMMENT|NEWLINE
	select case lexGetToken( )
	case FB_TK_COMMENTCHAR, FB_TK_REM, FB_TK_EOL, FB_TK_STATSEPCHAR
		exit function
	end select

	'' add end and next label (at ELSE/ELSEIF)
	nl = symbAddLabel( NULL )
	el = symbAddLabel( NULL )

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_IF

	'' branch
	expr = astUpdComp2Branch( expr, nl, FALSE )
	if( expr = NULL ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end if

	astAdd( expr )

	'' NUM_LIT | SimpleStatement*
	if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then
		l = symbFindByClass( lexGetSymbol, FB_SYMBCLASS_LABEL )
		if( l = NULL ) then
			l = symbAddLabel( lexGetText( ), FALSE, TRUE )
		end if
		lexSkipToken( )

		astAdd( astNewBRANCH( IR_OP_JMP, l ) )

	elseif( cSimpleStatement( ) = FALSE ) then
		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

	'' (ELSE SimpleStatement*)?
	if( hMatch( FB_TK_ELSE ) ) then

		'' exit if stmt
		astAdd( astNewBRANCH( IR_OP_JMP, el ) )

		'' emit next label
		astAdd( astNewLABEL( nl ) )

		'' SimpleStatement|IF*
		if( cSimpleStatement = FALSE ) then
			exit function
		end if

		'' emit end label
		astAdd( astNewLABEL( el ) )

	else
		'' emit next label
		astAdd( astNewLABEL( nl ) )
	end if

	'' END IF? -- added to make complex macros easier to be done
	if( lexGetToken( ) = FB_TK_END ) then
		if( lexGetLookAhead(1) = FB_TK_IF ) then
			lexSkipToken( )
			lexSkipToken( )
		end if
	end if

	''
	env.lastcompound = lastcompstmt

	function = TRUE

end function

'':::::
function cIfStmtBody( byval expr as ASTNODE ptr, _
					  byval nl as FBSYMBOL ptr, _
					  byval el as FBSYMBOL ptr, _
					  byval checkstmtsep as integer = TRUE ) as integer

	function = FALSE

	'' branch
	expr = astUpdComp2Branch( expr, nl, FALSE )
	if( expr = NULL ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
		exit function
	end if
	astAdd( expr )

	if( checkstmtsep ) then
		'' Comment?
		cComment( )

		'' separator
		if( cStmtSeparator( ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDEOL )
			exit function
		end if
	end if

	'' loop body
	do
		if( cSimpleLine( ) = FALSE ) then
			exit do
		end if
	loop while( lexGetToken( ) <> FB_TK_EOF )

	if( hGetLastError( ) = FB_ERRMSG_OK ) then
		function = TRUE
	end if

end function

'':::::
''BlockIfStatement=   (COMMENT|NEWLINE|STATSEP)
''					  SimpleLine*
''					  (ELSEIF Expression THEN Comment? SttSeparator
''					   SimpleLine*)?
''                    (ELSE Comment? SttSeparator
''					   SimpleLine*)?
''					  END IF.
''
function cBlockIfStatement( byval expr as ASTNODE ptr ) as integer
	dim el as FBSYMBOL ptr, nl as FBSYMBOL ptr
	dim lastcompstmt as integer

	function = FALSE

	'' COMMENT|NEWLINE
	select case lexGetToken( )
	case FB_TK_COMMENTCHAR, FB_TK_REM, FB_TK_EOL, FB_TK_STATSEPCHAR

	case else
		exit function
	end select

	'' add end label (at ENDIF)
	el = symbAddLabel( NULL )

	'' add next label (at ELSE/ELSEIF)
	nl = symbAddLabel( NULL )

	''
	lastcompstmt = env.lastcompound
	env.lastcompound = FB_TK_IF

	if( cIfStmtBody( expr, nl, el ) = FALSE ) then
		exit function
	end if

	'' (ELSEIF Expression THEN SimpleLine*)?
    do while( hMatch( FB_TK_ELSEIF ) )

		'' exit last if stmt
		astAdd( astNewBRANCH( IR_OP_JMP, el ) )

		'' emit next label
		astAdd( astNewLABEL( nl ) )

		'' add next label (at ELSE/ELSEIF)
		nl = symbAddLabel( NULL )

	    '' Expression
    	if( cExpression( expr ) = FALSE ) then
    		hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    		exit function
    	end if

		'' THEN
		if( hMatch( FB_TK_THEN ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDTHEN )
			exit function
		end if

		if( cIfStmtBody( expr, nl, el, FALSE ) = FALSE ) then
			exit function
		end if

    loop

	'' (ELSE SimpleLine*)?
	if( hMatch( FB_TK_ELSE ) ) then

		'' exit last if stmt
		astAdd( astNewBRANCH( IR_OP_JMP, el ) )

		'' emit next label
		astAdd( astNewLABEL( nl ) )

		'' loop body
		do
			if( cSimpleLine( ) = FALSE ) then
				exit do
			end if
		loop while( lexGetToken( ) <> FB_TK_EOF )

	else
		'' emit next label
		astAdd( astNewLABEL( nl ) )
	end if

	'' emit end label
	astAdd( astNewLABEL( el ) )

	'' ENDIF or END IF
    if( hMatch( FB_TK_ENDIF ) = FALSE ) then
        if( (hMatch( FB_TK_END ) = FALSE) or _
        	(hMatch( FB_TK_IF ) = FALSE) ) then
            hReportError( FB_ERRMSG_EXPECTEDENDIF )
            exit function
        end if
    end if

	''
	env.lastcompound = lastcompstmt

	function = TRUE

end function

'':::::
''IfStatement	  =   IF Expression THEN (BlockIfStatement | SingleIfStatement) .
''
function cIfStatement as integer
	dim expr as ASTNODE ptr

	function = FALSE

	'' IF
	lexSkipToken( )

    '' Expression
    if( cExpression( expr ) = FALSE ) then
    	hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    	exit function
    end if

	'' THEN
	if( hMatch( FB_TK_THEN ) ) then

		'' (BlockIfStatement | SingleIfStatement)
		if( cBlockIfStatement( expr ) = FALSE ) then
			if( hGetLastError = FB_ERRMSG_OK ) then
				if( cSingleIfStatement( expr ) = FALSE ) then
					hReportError( FB_ERRMSG_SYNTAXERROR )
					exit function
				end if
			end if
		end if

	else

		'' GOTO
		if( lexGetToken( ) <> FB_TK_GOTO ) then
			hReportError( FB_ERRMSG_EXPECTEDTHEN )
			exit function
		end if

		if( cSingleIfStatement( expr ) = FALSE ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

	end if


	function = TRUE

end function


