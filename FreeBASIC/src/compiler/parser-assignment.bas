''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
function cOperator _
	( _
		byval options as FB_OPEROPTS _
	) as integer

	dim as integer op = any

    function = INVALID

    '' right class?
    select case lexGetClass( )
    case FB_TKCLASS_OPERATOR, FB_TKCLASS_KEYWORD

    case else
    	exit function
	end select

    ''
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

   	case FB_TK_EQ
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_EQ

   	case FB_TK_GT
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_GT

   	case FB_TK_LT
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_LT

   	case FB_TK_NE
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_NE

   	case FB_TK_LE
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_LE

   	case FB_TK_GE
   		if( (options and FB_OPEROPTS_RELATIVE) = 0 ) then
   			exit function
   		end if

    	lexSkipToken( )
   		return AST_OP_GE

	case FB_TK_LET
    	if( (options and FB_OPEROPTS_ASSIGN) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_ASSIGN

    case FB_TK_NOT
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_NOT

    case FB_TK_CAST
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_CAST

	case FB_TK_ABS
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_ABS

	case FB_TK_SGN
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_SGN

	case FB_TK_FIX
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FIX

	case FB_TK_FRAC
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FRAC

	case FB_TK_INT
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FLOOR

	case FB_TK_FIELDDEREF
    	if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FLDDEREF

	case FB_TK_NEW, FB_TK_DELETE

		if( (options and FB_OPEROPTS_SELF) = 0 ) then
    		exit function
    	end if

    	dim as integer is_new = (lexGetToken( ) = FB_TK_NEW)

    	lexSkipToken( )

    	'' '['?
    	if( lexGetToken( ) = CHAR_LBRACKET ) then
        	lexSkipToken( )

			'' ']'
        	if( lexGetToken( ) <> CHAR_RBRACKET ) then
        		if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
        			exit function
        		end if
        	else
        		lexSkipToken( )
        	end if

        	return iif( is_new, AST_OP_NEW_VEC_SELF, AST_OP_DEL_VEC_SELF )

        else
    		return iif( is_new, AST_OP_NEW_SELF, AST_OP_DEL_SELF )
    	end if

	case FB_TK_FOR
		if( (options and FB_OPEROPTS_SELF) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_FOR

	case FB_TK_STEP
    	if( (options and FB_OPEROPTS_SELF) = 0 ) then
        	exit function
        end if

		lexSkipToken( )
		return AST_OP_STEP

	case FB_TK_NEXT
		if( (options and FB_OPEROPTS_SELF) = 0 ) then
    		exit function
    	end if

    	lexSkipToken( )
    	return AST_OP_NEXT

	case else
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

        case CHAR_AMP
        	op = AST_OP_CONCAT

        case FB_TK_ADDROFCHAR
    		if( (options and FB_OPEROPTS_UNARY) = 0 ) then
    			exit function
    		end if

    		lexSkipToken( )
    		return AST_OP_ADDROF

        case else
        	exit function
        end select
	end select

    lexSkipToken( )

    if( (options and FB_OPEROPTS_SELF) = 0 ) then
    	return op
    end if

    '' '='?
    if( lexGetToken( ) = FB_TK_ASSIGN ) then
    	lexSkipToken( )
    	'' get the self version
    	op = astGetOpSelfVer( op )
    end if

    function = op

end function

'':::::
function cAssignment _
	( _
		byval assgexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr expr = any
	dim as integer op = any, dtype = any

	function = FALSE

	'' constant?
	dim as FBSYMBOL ptr sym = astGetSymbol( assgexpr )
	if( sym <> NULL ) then
		if( symbIsConstant( sym ) ) then
			if( errReport( FB_ERRMSG_CONSTANTCANTBECHANGED, TRUE ) = FALSE ) then
				exit function
			end if
		end if
	end if

	'' '='?
    op = INVALID
    if( lexGetToken( ) <> FB_TK_ASSIGN ) then
    	'' BOP?
    	op = cOperator( FB_OPEROPTS_NONE )

		'' '='?
    	if( lexGetToken( ) <> FB_TK_ASSIGN ) then
    		if( errReport( FB_ERRMSG_EXPECTEDEQ ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: skip stmt
    			hSkipStmt( )
    			return TRUE
    		end if
    	end if

    	lexSkipToken( )

    	'' get the self version
    	op = astGetOpSelfVer( op )
	else
    	lexSkipToken( )
    end if

    '' set the context symbol to allow taking the address of overloaded
    '' procs and also to allow anonymous UDT's
    parser.ctxsym = astGetSubType( assgexpr )

    '' Expression
    expr = cExpression( )
    if( expr = NULL ) then
       	if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
       		parser.ctxsym = NULL
       		exit function
       	else
    		'' error recovery: skip until next stmt
    		hSkipStmt( )
    		return TRUE
       	end if
    end if

    parser.ctxsym = NULL

    '' BOP?
    if( op <> INVALID ) then
    	'' do lvalue op= expr
    	expr = astNewSelfBOP( op, _
    					  	  assgexpr, _
    					  	  expr, _
    					  	  NULL, _
    					  	  AST_OPOPT_LPTRARITH )

    	if( expr = NULL ) then
    		if( errReport( FB_ERRMSG_TYPEMISMATCH ) = FALSE ) then
    			exit function
    		end if
    	else
    		astAdd( expr )
    	end if

	else
    	'' do lvalue = expr
    	expr = astNewASSIGN( assgexpr, expr )

    	if( expr = NULL ) then
			if( errReport( FB_ERRMSG_ILLEGALASSIGNMENT ) = FALSE ) then
				exit function
			end if
		else
			astAdd( expr )
		end if
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

	'' skip any casting if they won't do any conversion
	dim as ASTNODE ptr t = expr
	if( astIsCAST( expr ) ) then
		if( astGetCASTDoConv( expr ) = FALSE ) then
			t = astGetLeft( expr )
		end if
	end if

    '' ordinary assignment?
    if( astIsCALL( t ) = FALSE ) then
    	return cAssignment( expr )
    end if

	'' calling a function ptr..

	'' can the result be skipped?
	if( symbGetDataClass( astGetDataType( t ) ) <> FB_DATACLASS_INTEGER ) then
		if( errReport( FB_ERRMSG_VARIABLEREQUIRED ) = FALSE ) then
			exit function
		else
			'' error recovery: skip call
			astDelTree( expr )
			return TRUE
		end if

    '' CHAR and WCHAR literals are also from the INTEGER class
    else
    	select case astGetDataType( t )
    	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			if( errReport( FB_ERRMSG_VARIABLEREQUIRED ) = FALSE ) then
				exit function
			else
				'' error recovery: skip call
				astDelTree( expr )
				return TRUE
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
function cAssignmentOrPtrCall _
	( _
		_
	) as integer

	dim as integer islet = any
	dim as ASTNODE ptr expr = any

	function = FALSE

	if( lexGetToken( ) = FB_TK_LET ) then
    	if( fbLangOptIsSet( FB_LANG_OPT_LET ) = FALSE ) then
    		if( errReportNotAllowed( FB_LANG_OPT_LET ) = FALSE ) then
    			exit function
    		end if
    	end if

    	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    		exit function
    	end if

		lexSkipToken( )
		islet = TRUE
	else
		islet = FALSE
	end if

	'' Variable
	expr = cVarOrDeref( )
	if( expr <> NULL ) then
    	function = cAssignmentOrPtrCallEx( expr )

	else
		if( islet ) then
        	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
        		exit function
        	else
        		'' error recovery: skip stmt
        		hSkipStmt( )
        	end if
		end if
	end if

end function

