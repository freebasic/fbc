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


'' unary operators (NOT, @, *, ...) parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

declare function 	cCastingExpr		( byref expr as ASTNODE ptr ) as integer

'':::::
''NegNotExpression=   ('-'|'+'|) ExpExpression
''				  |   NOT RelExpression
''				  |   HighestPresExpr .
''
function cNegNotExpression _
	( _
	 	byref negexpr as ASTNODE ptr _
	 ) as integer

	function = FALSE

	select case lexGetToken( )
	'' '-'
	case CHAR_MINUS
		lexSkipToken( )

		'' ExpExpression
		if( cExpExpression( negexpr ) = FALSE ) then
    		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a new node
    			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		end if

		else
			negexpr = astNewUOP( AST_OP_NEG, negexpr )
		end if

    	if( negexpr = NULL ) Then
    		if( errReport( FB_ERRMSG_TYPEMISMATCH ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a new node
    			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		end if
    	end if

		return TRUE

	'' '+'
	case CHAR_PLUS
		lexSkipToken( )

		'' ExpExpression
		if( cExpExpression( negexpr ) = FALSE ) then
    		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a new node
    			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		end if

		else
			negexpr = astNewUOP( AST_OP_PLUS, negexpr )
		end if

    	if( negexpr = NULL ) Then
    		if( errReport( FB_ERRMSG_TYPEMISMATCH ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a new node
    			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		end if
    	end if

    	return TRUE

	'' NOT
	case FB_TK_NOT
		lexSkipToken( )

		'' RelExpression
		if( cRelExpression( negexpr ) = FALSE ) then
    		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a new node
    			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		end if

		else
			negexpr = astNewUOP( AST_OP_NOT, negexpr )
		end if

    	if( negexpr = NULL ) Then
    		if( errReport( FB_ERRMSG_TYPEMISMATCH ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a new node
    			negexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		end if
    	end if

		return TRUE
	end select

	function = cHighestPrecExpr( NULL, negexpr )

end function

'':::::
private function hFieldAccess _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr fld = any, method_sym = any
	dim as ASTNODE ptr fldexpr = NULL

	fld = cTypeField( dtype, subtype, fldexpr, method_sym, TRUE )
	if( fld = NULL ) then
		if( method_sym = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			return NULL
		end if

	else
		'' constant? exit..
		if( symbIsConst( fld ) ) then
			astDeltree( expr )
			return fldexpr
		end if

		dtype = symbGetType( fld )
		subtype = symbGetSubType( fld )

		'' it's a proc call, but was it originally returning an UDT?
		if( astIsCALL( expr ) ) then
			if( symbGetUDTRetType( astGetSubtype( expr ) ) <> _
								FB_DATATYPE_POINTER+FB_DATATYPE_STRUCT ) then

				'' it's returning the result in registers, move to a temp var
				'' (note: if it's being returned in regs, there's no DTOR)
				dim as FBSYMBOL ptr tmp = any

				tmp = symbAddTempVar( FB_DATATYPE_STRUCT, _
							  	  	  astGetSubtype( expr ), _
							  	  	  FALSE, _
							  	  	  FALSE )

				expr = astNewASSIGN( astBuildVarField( tmp ), _
							  	  	 expr, _
							  	  	 AST_OPOPT_DONTCHKOPOVL )

        		expr = astNewLINK( astBuildVarField( tmp ), expr )
        	end if
        end if

 		'' build: cast( udt ptr, (cast( byte ptr, @udt) + fldexpr))->field
 		expr = astNewADDROF( expr )

 		'' can't be 0, or PTR will remove the ADDROF, and we are taking the
 		'' address-of a CALL result that can't be changed, ditto with LINK ..
 		if( fldexpr = NULL ) then
 			fldexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
 		end if

 		expr = astNewDEREF( 0, _
 			 			    astNewBOP( AST_OP_ADD, expr, fldexpr ), _
 						    dtype, _
 						    subtype )

 		expr = astNewFIELD( expr, fld, dtype, subtype )
	end if

	'' method call?
	if( method_sym <> NULL ) then
		expr = cMethodCall( method_sym, expr )
		if( expr = NULL ) then
			return NULL
		end if
	end if

	function = expr

end function

''::::
function cStrIdxOrFieldDeref _
	( _
		byref expr as ASTNODE ptr _
	) as integer

	dim as FBSYMBOL ptr subtype = any
	dim as integer dtype = any

	dtype = astGetDataType( expr )
	subtype = astGetSubType( expr )

	select case as const dtype
	'' zstring indexing?
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR
		'' '['?
		if( lexGetToken( ) = CHAR_LBRACKET ) then
			expr = cDerefFields( dtype, subtype, expr, TRUE )
		end if

		return expr <> NULL

	'' udt '.' ?
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		if( lexGetToken( ) = CHAR_DOT ) then
    		lexSkipToken( LEXCHECK_NOPERIOD )

			expr = hFieldAccess( dtype, subtype, expr )
			if( expr = NULL ) then
				return FALSE
			end if

 			dtype = astGetDataType( expr )
 			subtype = astGetSubType( expr )
		end if

	end select

	'' FuncPtrOrDerefFields?
	if( dtype >= FB_DATATYPE_POINTER ) then
		dim as integer isfuncptr = FALSE, isfield = FALSE

		select case lexGetToken( )
		'' function ptr '(' ?
		case CHAR_LPRNT
			isfuncptr = ( dtype = FB_DATATYPE_POINTER+FB_DATATYPE_FUNCTION )
			isfield = isfuncptr

		'' ptr ('->' | '[') ?
		case FB_TK_FIELDDEREF, CHAR_LBRACKET
			isfield = TRUE
	    end select

		if( isfield ) then
			expr = cFuncPtrOrDerefFields( dtype, _
										  subtype, _
										  expr, _
										  isfuncptr, _
										  TRUE )
		end if
	end if

	function = (errGetLast( ) = FB_ERRMSG_OK)

end function

''::::
'' HighestPrecExpr=   AddrOfExpression
''				  |	  ( DerefExpr
''				  	  |	CastingExpr
''					  | PtrTypeCastingExpr
''				  	  | ParentExpression
''					  ) FuncPtrOrDerefFields?
''				  |	  AnonUDT
''				  |   Atom .
''
function cHighestPrecExpr _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byref highexpr as ASTNODE ptr _
	) as integer

	select case lexGetToken( )
	'' AddrOfExpression
	case FB_TK_ADDROFCHAR
		return cAddrOfExpression( highexpr )

	'' DerefExpr
	case FB_TK_DEREFCHAR
		if( cDerefExpression( highexpr ) = FALSE ) then
			exit function
		end if

	'' ParentExpression
	case CHAR_LPRNT
		dim as integer is_opt = fbGetPrntOptional( )

		if( cParentExpression( highexpr ) = FALSE ) then
			exit function
		end if

		'' if parsing a SUB, don't call StrIdxOrFieldDeref() twice
		if( is_opt ) then
			return TRUE
		end if

	case else

		select case as const lexGetToken( )
		'' AddrOfExpression
		case FB_TK_VARPTR, FB_TK_PROCPTR, FB_TK_SADD, FB_TK_STRPTR
			return cAddrOfExpression( highexpr )

		'' CastingExpr
		case FB_TK_CAST
			if( cCastingExpr( highexpr ) = FALSE ) then
				exit function
			end if

		'' PtrTypeCastingExpr
		case FB_TK_CPTR
			if( cPtrTypeCastingExpr( highexpr ) = FALSE ) then
				exit function
			end if

		'' OperatorNew
		case FB_TK_NEW
			if( cOperatorNew( highexpr ) = FALSE ) then
				exit function
			end if

		'' Atom
		case else
			return cAtom( chain_, highexpr )

		end select

	end select

	''
	function = cStrIdxOrFieldDeref( highexpr )

end function

'':::::
private function hCast _
	( _
		byref expr as ASTNODE ptr, _
		byval ptronly as integer _
	) as integer

    dim as integer dtype = any, lgt = any, ptrcnt = any
    dim as FBSYMBOL ptr subtype = any

	function = FALSE

	'' '('
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until ')', fake a node
			hSkipUntil( CHAR_RPRNT, TRUE )
			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			return TRUE
		end if

	else
		lexSkipToken( )
	end if

    '' DataType
    if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
    	if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    		exit function
    	else
			'' error recovery: skip until ',', create a fake type
			hSkipUntil( CHAR_COMMA )

			if( ptronly ) then
				dtype = FB_DATATYPE_POINTER+FB_DATATYPE_VOID
			else
				dtype = FB_DATATYPE_INTEGER
			end if
            subtype = NULL
    	end if
    end if

	'' check for invalid types
	select case dtype
	case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR
		if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
			exit function
		else
			'' error recovery: create a fake type
			if( ptronly ) then
				dtype = FB_DATATYPE_POINTER+FB_DATATYPE_VOID
			else
				dtype = FB_DATATYPE_INTEGER
			end if
            subtype = NULL
		end if
	end select

	if( dtype >= FB_DATATYPE_POINTER ) then
		ptronly = TRUE
	end if

	'' ','
	if( lexGetToken( ) <> CHAR_COMMA ) then
		if( errReport( FB_ERRMSG_EXPECTEDCOMMA ) = FALSE ) then
			exit function
		end if
	else
		lexSkipToken( )
	end if

	'' expression
	if( cExpression( expr ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			exit function
		else
    		'' error recovery: create a fake node
    		expr = astNewCONSTz( dtype, subtype )
		end if
	end if

	expr = astNewCONV( dtype, _
					   subtype, _
					   expr, _
					   iif( ptronly, AST_OP_TOPOINTER, INVALID ), _
					   TRUE )

    if( expr = NULL ) Then
    	if( errReport( iif( ptronly, _
    						FB_ERRMSG_EXPECTEDPOINTER, _
    						FB_ERRMSG_TYPEMISMATCH ), TRUE ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: create a fake node
    		expr = astNewCONSTz( dtype, subtype )
    	end if
    end if

	'' ')'
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

	else
		lexSkipToken( )
	end if

	function = TRUE

end function

'':::::
'' CastingExpr	=	CAST '(' DataType ',' Expression ')'
''
function cCastingExpr _
	( _
		byref expr as ASTNODE ptr _
	) as integer

	'' CAST
	lexSkipToken( )

	function = hCast( expr, FALSE )

end function

'':::::
'' PtrTypeCastingExpr	=   CPTR '(' DataType ',' Expression{int|uint|ptr} ')'
''
function cPtrTypeCastingExpr _
	( _
		byref expr as ASTNODE ptr _
	) as integer

	'' CPTR
	lexSkipToken( )

	function = hCast( expr, TRUE )

end function

'':::::
private function hDoDeref _
	( _
		byval cnt as integer, _
		byref expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	function = INVALID

	if( (expr = NULL) or (cnt <= 0) ) then
		exit function
	end if

	do while( cnt > 0 )
		'' not a pointer?
		if( dtype < FB_DATATYPE_POINTER ) then
			if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
				exit function
			else
				exit do
			end if
		end if

		dtype -= FB_DATATYPE_POINTER

		'' incomplete type?
		if( (dtype = FB_DATATYPE_VOID) or (dtype = FB_DATATYPE_FWDREF) ) then
			if( errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE ) = FALSE ) then
				exit function
			else
				exit do
			end if
		end if

		'' null pointer checking
		if( env.clopt.extraerrchk ) then
			expr = astNewPTRCHK( expr, lexLineNum( ) )
		end if

		expr = astNewDEREF( 0, expr, dtype, subtype )

		cnt -= 1
	loop

    function = dtype

end function

'':::::
''DerefExpression	= 	DREF+ HighestPresExpr .
''
function cDerefExpression _
	( _
		byref derefexpr as ASTNODE ptr _
	) as integer

    dim as FBSYMBOL ptr subtype = any
    dim as integer derefcnt, dtype = any
    dim as ASTNODE ptr funcexpr = any

	function = FALSE

	'' DREF?
	if( lexGetToken( ) <> FB_TK_DEREFCHAR ) then
		exit function
	end if

	'' DREF+
    derefcnt = 0
	do
		lexSkipToken( )
		derefcnt += 1
	loop while( lexGetToken( ) = FB_TK_DEREFCHAR )

	'' HighestPresExpr
	if( cHighestPrecExpr( NULL, derefexpr ) = FALSE ) then
        if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
        	exit function
        else
        	'' error recovery: fake a node
        	derefexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
        	return TRUE
        end if
	end if

	if( derefexpr = NULL ) then
        if( errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE ) = FALSE ) then
        	exit function
        else
        	'' error recovery: fake a node
        	derefexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
        	return TRUE
        end if
	end if

	''
	dtype = astGetDataType( derefexpr )
	subtype = astGetSubType( derefexpr )

	''
	dtype = hDoDeref( derefcnt, derefexpr, dtype, subtype )
	if( dtype = INVALID ) then
		exit function
	end if

	function = TRUE

end function

'':::::
private function hProcPtrBody _
	( _
		byval proc as FBSYMBOL ptr, _
		byref addrofexpr as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr expr = any
	dim as FBSYMBOL ptr sym = any

	function = FALSE

	'' '('')'?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				exit function
			else
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if
		end if
	end if

	'' resolve overloaded procs
	if( symbIsOverloaded( proc ) ) then
        if( parser.ctxsym <> NULL ) then
        	if( symbIsProc( parser.ctxsym ) ) then
        		sym = symbFindOverloadProc( proc, parser.ctxsym )
        		if( sym <> NULL ) then
        			proc = sym
        		end if
        	end if
        end if
	end if

	expr = astNewVAR( proc, 0, FB_DATATYPE_FUNCTION, proc )
	addrofexpr = astNewADDROF( expr )

	''
	symbSetIsCalled( proc )

	function = (addrofexpr <> NULL)

end function

'':::::
private function hVarPtrBody _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byref addrofexpr as ASTNODE ptr _
	) as integer

	function = FALSE

	if( cHighestPrecExpr( chain_, addrofexpr ) = FALSE ) then
		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
			exit function
		else
			'' error recovery: fake a node
			addrofexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			return TRUE
		end if
	end if

	select case as const astGetClass( addrofexpr )
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, AST_NODECLASS_DEREF, AST_NODECLASS_TYPEINI

	case AST_NODECLASS_FIELD
		'' can't take address of bitfields..
		if( astGetDataType( astGetLeft( addrofexpr ) ) = FB_DATATYPE_BITFIELD ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a node
				astDelTree( addrofexpr )
				addrofexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				return TRUE
			end if
		end if

	case else
		if( errReportEx( FB_ERRMSG_INVALIDDATATYPES, "for @ or VARPTR" ) = FALSE ) then
			exit function
		else
			'' error recovery: fake a node
			astDelTree( addrofexpr )
			addrofexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
			return TRUE
		end if
	end select

	addrofexpr = astNewADDROF( addrofexpr )

    function = (addrofexpr <> NULL)

end function

'':::::
''AddrOfExpression  =   VARPTR '(' HighPrecExpr ')'
''					|   PROCPTR '(' Proc ('('')')? ')'
'' 					| 	'@' (Proc ('('')')? | HighPrecExpr)
''					|   SADD|STRPTR '(' Variable{str}|Const{str}|Literal{str} ')' .
''
function cAddrOfExpression _
	( _
		byref addrofexpr as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr expr = any
    dim as integer dtype = any
    dim as FBSYMBOL ptr sym = any
    dim as FBSYMCHAIN ptr chain_ = any

	function = FALSE

	'' '@' (Proc ('('')')? | Variable)
	if( lexGetToken( ) = FB_TK_ADDROFCHAR ) then
		lexSkipToken( )

		chain_ = cIdentifier( )
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

		'' proc?
		sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
		if( sym <> NULL ) then
			lexSkipToken( )
			return hProcPtrBody( sym, addrofexpr )

		'' anything else..
		else
			return hVarPtrBody( chain_, addrofexpr )
		end if

	end if

	select case as const lexGetToken( )
	'' VARPTR '(' Variable ')'
	case FB_TK_VARPTR
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')' and fake a node
				hSkipUntil( CHAR_RPRNT, TRUE )
				addrofexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				return TRUE
			end if

		end if

		if( hVarPtrBody( NULL, addrofexpr ) = FALSE ) then
			exit function
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if
		end if

		return TRUE

	'' PROCPTR '(' Proc ('('')')? ')'
	case FB_TK_PROCPTR
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')' and fake a node
				hSkipUntil( CHAR_RPRNT, TRUE )
				addrofexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				return TRUE
			end if
		end if

		'' proc?
		chain_ = cIdentifier( )
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

		sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
		if( sym = NULL ) then
			if( errReport( FB_ERRMSG_UNDEFINEDSYMBOL ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')' and fake a node
				hSkipUntil( CHAR_RPRNT, TRUE )
				addrofexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				return TRUE
			end if
		else
			lexSkipToken( )
		end if

		if( hProcPtrBody( sym, addrofexpr ) = FALSE ) then
			exit function
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if
		end if

		return TRUE

	'' SADD|STRPTR '(' Variable{str} ')'
	case FB_TK_SADD, FB_TK_STRPTR
		lexSkipToken( )

		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')' and fake a node
				hSkipUntil( CHAR_RPRNT, TRUE )
				addrofexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				return TRUE
			end if
		end if

		if( cHighestPrecExpr( NULL, expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')' and fake a node
				hSkipUntil( CHAR_RPRNT, TRUE )
				addrofexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				return TRUE
			end if
		end if

		dtype = astGetDataType( expr )

		if( symbIsString( dtype ) = FALSE ) then
			if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')' and fake a node
				hSkipUntil( CHAR_RPRNT, TRUE )
				astDelTree( expr )
				addrofexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				return TRUE
			end if
		end if

		'' check for invalid classes (functions, etc)
		select case as const astGetClass( expr )
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
			 AST_NODECLASS_DEREF, AST_NODECLASS_TYPEINI, _
			 AST_NODECLASS_FIELD

		case else
			if( errReportEx( FB_ERRMSG_INVALIDDATATYPES, "for STRPTR" ) = FALSE ) then
				exit function
			end if
		end select

		'' varlen? do: *cast( zstring ptr ptr, @expr )
		if( dtype = FB_DATATYPE_STRING ) then
			addrofexpr = astBuildStrPtr( expr )

		'' anything else: do cast( zstring ptr, @expr )
		else
			addrofexpr = astNewCONV( FB_DATATYPE_POINTER + FB_DATATYPE_CHAR, _
								 	 NULL, _
								 	 astNewADDROF( expr ), _
								 	 AST_OP_TOPOINTER )
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if
		end if

		return (addrofexpr <> NULL)
	end select

end function

