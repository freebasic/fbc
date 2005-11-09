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
function cAssignment( byval assgexpr as ASTNODE ptr ) as integer
	dim as ASTNODE ptr expr
	dim as integer op, dtype

	function = FALSE

	'' BOP?
    op = INVALID
    if( lexGetToken( ) <> FB_TK_ASSIGN ) then
    	if( lexGetClass( ) = FB_TKCLASS_OPERATOR ) then

        	select case as const lexGetToken( )
        	case FB_TK_AND
        		op = IR_OP_AND
        	case FB_TK_OR
        		op = IR_OP_OR
        	case FB_TK_XOR
        		op = IR_OP_XOR
			case FB_TK_EQV
				op = IR_OP_EQV
			case FB_TK_IMP
				op = IR_OP_IMP
        	case FB_TK_SHL
        		op = IR_OP_SHL
        	case FB_TK_SHR
        		op = IR_OP_SHR
        	case FB_TK_MOD
        		op = IR_OP_MOD
        	end select

        	if( op = INVALID ) then
        		select case as const lexGetToken( )
        		case CHAR_PLUS
        			op = IR_OP_ADD
        		case CHAR_MINUS
        			op = IR_OP_SUB
        		case CHAR_RSLASH
        			op = IR_OP_INTDIV
        		case CHAR_CARET
        			op = IR_OP_MUL
        		case CHAR_SLASH
        			op = IR_OP_DIV
        		case CHAR_CART
        			op = IR_OP_POW
        		end select
        	end if

        	if( op <> INVALID ) then
        		lexSkipToken( )
        	end if
        end if
	end if

	'' '='
    if( not hMatch( FB_TK_ASSIGN ) ) then
    	hReportError( FB_ERRMSG_EXPECTEDEQ )
    	exit function
    end if

    '' set the context symbol to allow taking the address of overloaded procs
    if( astGetDataType( assgexpr ) >= IR_DATATYPE_POINTER+IR_DATATYPE_FUNCTION ) then
    	env.ctxsym = astGetSubType( assgexpr )
    end if

    '' Expression
    if( not cExpression( expr ) ) then
       	hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
       	exit function
    end if

    env.ctxsym = NULL

    '' BOP?
    if( op <> INVALID ) then
    	'' pointer?
    	if( astGetDataType( assgexpr ) >= IR_DATATYPE_POINTER ) then
    		cUpdPointer( op, assgexpr, expr )
    		if( expr = NULL ) then
    			hReportError( FB_ERRMSG_TYPEMISMATCH )
    			exit function
    		end if
    	end if

    	expr = astNewBOP( op, astCloneTree( assgexpr ), expr )
    	if( expr = NULL ) Then
    		hReportError( FB_ERRMSG_TYPEMISMATCH )
    		exit function
    	end if
	end if

    '' do assign
    assgexpr = astNewASSIGN( assgexpr, expr )

    if( assgexpr = NULL ) then
		hReportError( FB_ERRMSG_INVALIDDATATYPES )
        exit function
	end if

    astAdd( assgexpr )

    function = TRUE

end function

'':::::
''Assignment      =   LET? Variable BOP? '=' Expression
''				  |	  Variable{function ptr} '(' ProcParamList ')' .
''
function cAssignmentOrPtrCall as integer
	dim as integer islet
	dim as ASTNODE ptr assgexpr

	function = FALSE

	if( hMatch( FB_TK_LET ) ) then
		islet = TRUE
	else
		islet = FALSE
	end if

	'' Variable
	if( cVarOrDeref( assgexpr ) ) then

    	'' calling a SUB ptr?
    	if( assgexpr = NULL ) then
    		return TRUE
    	end if

    	'' calling a FUNCTION ptr?
    	if( astIsFUNCT( assgexpr ) ) then
			'' can the result be skipped?
			if( irGetDataClass( astGetDataType( assgexpr ) ) <> IR_DATACLASS_INTEGER ) then
				hReportError( FB_ERRMSG_VARIABLEREQUIRED )
				exit function
			end if

    		'' flush the call
    		astAdd( assgexpr )
    		function = TRUE

    	'' ordinary assignment..
    	else

    		function = cAssignment( assgexpr )

    	end if


	else
		if( islet ) then
        	hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
        	exit function
		end if
	end if

end function

