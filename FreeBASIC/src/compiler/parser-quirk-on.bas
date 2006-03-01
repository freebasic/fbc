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


'' quirk conditional statements (ON ... GOTO|GOSUB) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
function cGOTBStmt( byval expr as ASTNODE ptr, _
					byval isgoto as integer ) as integer
    dim as ASTNODE ptr idxexpr
	dim as integer l, i
	dim as FBSYMBOL ptr sym, exitlabel, tbsym, labelTB(0 to FB_MAXGOTBITEMS-1)

	function = FALSE

	'' convert to uinteger if needed
	if( astGetDataType( expr ) <> FB_DATATYPE_UINT ) then
		expr = astNewCONV( INVALID, FB_DATATYPE_UINT, NULL, expr )
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
		if( (lexGetClass( ) <> FB_TKCLASS_NUMLITERAL) and _
			(lexGetClass( ) <> FB_TKCLASS_IDENTIFIER) ) then
			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
			exit function
		end if

		'' Label
		labelTB(l) = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
		if( labelTB(l) = NULL ) then
			labelTB(l) = symbAddLabel( lexGetText( ), FALSE, TRUE )
		end if
		lexSkipToken( )

		l += 1
	loop while( hMatch( CHAR_COMMA ) )

	''
	exitlabel = symbAddLabel( NULL )

	'' < 1?
	expr = astNewBOP( IR_OP_LT, astNewVAR( sym, 0, FB_DATATYPE_UINT ), _
					  astNewCONSTi( 1, FB_DATATYPE_UINT ), exitlabel, FALSE )
	astAdd( expr )

	'' > labels?
	expr = astNewBOP( IR_OP_GT, astNewVAR( sym, 0, FB_DATATYPE_UINT ), _
					  astNewCONSTi( l, FB_DATATYPE_UINT ), exitlabel, FALSE )
	astAdd( expr )

    '' jump to table[idx]
    tbsym = hJumpTbAllocSym( )

	idxexpr = astNewBOP( IR_OP_MUL, astNewVAR( sym, 0, FB_DATATYPE_UINT ), _
    				  			    astNewCONSTi( FB_INTEGERSIZE, FB_DATATYPE_UINT ) )

    expr = astNewIDX( astNewVAR( tbsym, -1*FB_INTEGERSIZE, FB_DATATYPE_UINT ), idxexpr, _
    				  FB_DATATYPE_UINT, NULL )

    if( isgoto = FALSE ) then
    	astAdd( astNewSTACK( IR_OP_PUSH, astNewADDR( IR_OP_ADDROF, astNewVAR( exitlabel ) ) ) )
    end if

    astAdd( astNewBRANCH( IR_OP_JUMPPTR, NULL, expr ) )

    '' emit table
    astAdd( astNewLABEL( tbsym ) )

    ''
    for i = 0 to l-1
    	astAdd( astNewJMPTB( FB_DATATYPE_UINT, labelTB(i) ) )
    next

    '' emit exit label
    astAdd( astNewLABEL( exitlabel ) )

    function = TRUE

end function

'':::::
''OnStmt 		=	ON LOCAL? (Keyword | Expression) (GOTO|GOSUB) Label .
''
function cOnStmt as integer
	dim as ASTNODE ptr expr
	dim as integer isgoto, islocal, isrestore
	dim as FBSYMBOL ptr label

	function = FALSE

	'' ON
	if( hMatch( FB_TK_ON ) = FALSE ) then
		exit function
	end if

	'' LOCAL?
	if( hMatch( FB_TK_LOCAL ) ) then
		if( fbIsModLevel( ) ) then
			hReportError( FB_ERRMSG_SYNTAXERROR, TRUE )
			exit function
		end if
		islocal = TRUE
	else
		islocal = FALSE
	end if

	'' ERROR | Expression
	expr = NULL
	select case lexGetToken( )
	case FB_TK_ERROR
		lexSkipToken( )
	case else
		hMatchExpression( expr )
	end select

	'' GOTO|GOSUB
	select case lexGetToken( )
	case FB_TK_GOTO
		lexSkipToken( )
		isgoto = TRUE

	case FB_TK_GOSUB
	    '' can't do GOSUB with ON ERROR
	    if( expr = NULL ) then
	    	hReportError( FB_ERRMSG_SYNTAXERROR )
	    	exit function
	    end if

	    '' difference from QB: GOSUB not allowed inside procs
		if( fbIsModLevel() = FALSE ) then
			hReportError( FB_ERRMSG_ILLEGALINSIDEASUB )
			exit function
		end if

	    lexSkipToken( )
	    isgoto = FALSE

	case else
		hReportError( FB_ERRMSG_SYNTAXERROR )
		exit function
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
			label = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_LABEL )
			if( label = NULL ) then
				label = symbAddLabel( lexGetText( ), FALSE, TRUE )
			end if
			lexSkipToken( )

			expr = astNewVAR( label, 0, FB_DATATYPE_UINT )
			expr = astNewADDR( IR_OP_ADDROF, expr )
			rtlErrorSetHandler( expr, (islocal = TRUE) )

		else
        	rtlErrorSetHandler( astNewCONSTi( NULL, FB_DATATYPE_UINT ), (islocal = TRUE) )
		end if

		function = TRUE

	else
        function = cGOTBStmt( expr, isgoto )
	end if

end function

