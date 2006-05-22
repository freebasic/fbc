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


'' assignments (including LET) or function-pointer calls (foo()) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
function cAssignment _
	( _
		byval assgexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr expr
	dim as integer op, dtype, doskip

	function = FALSE

	'' constant?
	dim as FBSYMBOL ptr sym = astGetSymbol( assgexpr )
	if( sym <> NULL ) then
		if( symbIsConstant( sym ) ) then
			if( hReportError( FB_ERRMSG_CONSTANTCANTBECHANGED, TRUE ) = FALSE ) then
				exit function
			end if
		end if
	end if

	'' BOP?
    op = INVALID
    if( lexGetToken( ) <> FB_TK_ASSIGN ) then
    	if( lexGetClass( ) = FB_TKCLASS_OPERATOR ) then

        	select case as const lexGetToken( )
        	case FB_TK_AND
        		op = AST_OP_AND
        	case FB_TK_OR
        		op = AST_OP_OR
        	case FB_TK_XOR
        		op = AST_OP_XOR
			case FB_TK_EQV
				op = AST_OP_EQV
			case FB_TK_IMP
				op = AST_OP_IMP
        	case FB_TK_SHL
        		op = AST_OP_SHL
        	case FB_TK_SHR
        		op = AST_OP_SHR
        	case FB_TK_MOD
        		op = AST_OP_MOD
        	end select

        	if( op = INVALID ) then
        		select case as const lexGetToken( )
        		case CHAR_PLUS
        			op = AST_OP_ADD
        		case CHAR_MINUS
        			op = AST_OP_SUB
        		case CHAR_RSLASH
        			op = AST_OP_INTDIV
        		case CHAR_CARET
        			op = AST_OP_MUL
        		case CHAR_SLASH
        			op = AST_OP_DIV
        		case CHAR_CART
        			op = AST_OP_POW
        		end select
        	end if

        	if( op <> INVALID ) then
        		lexSkipToken( )
        	end if
        end if
	end if

	'' '='
    if( lexGetToken( ) <> FB_TK_ASSIGN ) then
    	if( hReportError( FB_ERRMSG_EXPECTEDEQ ) = FALSE ) then
    		exit function
    	end if
    else
    	lexSkipToken( )
    end if

    '' set the context symbol to allow taking the address of overloaded
    '' procs and also to allow anonymous UDT's
    env.ctxsym = astGetSubType( assgexpr )

    '' Expression
    doskip = FALSE
    if( cExpression( expr ) = FALSE ) then
       	if( hReportError( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
       		env.ctxsym = NULL
       		exit function
       	else
       		expr = NULL
       		doskip = TRUE
       	end if
    end if

    env.ctxsym = NULL

    '' BOP?
    if( op <> INVALID ) then
    	'' pointer?
    	if( astGetDataType( assgexpr ) >= FB_DATATYPE_POINTER ) then
    		expr = cUpdPointer( op, astCloneTree( assgexpr ), expr )
    	else
    		expr = astNewBOP( op, astCloneTree( assgexpr ), expr )
    	end if

    	if( expr = NULL ) Then
    		if( hReportError( FB_ERRMSG_TYPEMISMATCH ) = FALSE ) then
    			exit function
    		end if
    	end if
	end if

    if( expr <> NULL ) then
    	'' do assign
    	assgexpr = astNewASSIGN( assgexpr, expr )

    	if( assgexpr = NULL ) then
			if( hReportError( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			end if
		else
			astAdd( assgexpr )
		end if
    end if

    if( doskip ) then
    	'' error recovery: skip until next stmt
    	hSkipStmt( )
    end if

    function = TRUE

end function

'':::::
function cAssignmentOrPtrCallEx _
	( _
		byval expr as ASTNODE ptr _
	) as integer

    function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    	exit function
    end if

    '' calling a SUB ptr?
    if( expr = NULL ) then
    	return TRUE
    end if

    '' ordinary assignment?
    if( astIsFUNCT( expr ) = FALSE ) then
    	return cAssignment( expr )
    end if

	'' calling a FUNCTION ptr..

	'' can the result be skipped?
	if( symbGetDataClass( astGetDataType( expr ) ) <> FB_DATACLASS_INTEGER ) then
		if( hReportError( FB_ERRMSG_VARIABLEREQUIRED ) = FALSE ) then
			exit function
		else
			'' error recovery: skip call
			astDelTree( expr )
			expr = NULL
		end if

    '' CHAR and WCHAR literals are also from the INTEGER class
    else
    	select case astGetDataType( expr )
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			if( hReportError( FB_ERRMSG_VARIABLEREQUIRED ) = FALSE ) then
				exit function
			else
				'' error recovery: skip call
				astDelTree( expr )
				expr = NULL
			end if
		end select
	end if

    '' flush the call
    if( expr <> NULL ) then
    	astAdd( expr )
    end if

    function = TRUE

end function

'':::::
''Assignment      =   LET? Variable BOP? '=' Expression
''				  |	  Variable{function ptr} '(' ProcParamList ')' .
''
function cAssignmentOrPtrCall as integer
	dim as integer islet
	dim as ASTNODE ptr expr

	function = FALSE

	if( lexGetToken( ) = FB_TK_LET ) then
    	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    		exit function
    	end if

		lexSkipToken( )
		islet = TRUE
	else
		islet = FALSE
	end if

	'' Variable
	if( cVarOrDeref( expr ) ) then
    	function = cAssignmentOrPtrCallEx( expr )

	else
		if( islet ) then
        	if( hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
        		exit function
        	else
        		'' error recovery: skip stmt
        		hSkipStmt( )
        	end if
		end if
	end if

end function

