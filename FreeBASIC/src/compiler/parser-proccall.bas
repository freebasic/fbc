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


'' proc calls (CALL or foo[(...)]) and function result assignments (function=expr)
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

declare function hCtorChain	( ) as integer

'':::::
function cAssignFunctResult _
	( _
		byval proc as FBSYMBOL ptr, _
		byval is_return as integer _
	) as integer static

    dim as FBSYMBOL ptr res, subtype
    dim as ASTNODE ptr rhs
    dim as integer has_ctor, has_defctor

    function = FALSE

    res = symbGetProcResult( proc )
    if( res = NULL ) then
    	if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip stmt, return
    		hSkipStmt( )
    		return TRUE
    	end if
    end if

    subtype = symbGetSubType( proc )

    select case symbGetType( proc )
    case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
        has_ctor = symbGetHasCtor( subtype )
        has_defctor = symbGetCompDefCtor( subtype ) <> NULL

    case else
    	has_ctor = FALSE
    	has_defctor = FALSE
    end select

	'' RETURN?
	if( is_return ) then
		if( symbGetProcStatAssignUsed( proc ) ) then
			if( has_defctor ) then
				if( errReport( FB_ERRMSG_RETURNANDFUNCTIONCANTBEUSED ) = FALSE ) then
					return FALSE
				end if
			end if
		end if

		symbSetProcStatReturnUsed( proc )

	else
		if( symbGetProcStatReturnUsed( proc ) ) then
			if( has_defctor ) then
				if( errReport( FB_ERRMSG_RETURNANDFUNCTIONCANTBEUSED ) = FALSE ) then
					return FALSE
				end if
			end if
		end if

		symbSetProcStatAssignUsed( proc )
	end if

    '' set the context symbol to allow taking the address of overloaded
    '' procs and also to allow anonymous UDT's
    parser.ctxsym = subtype

	'' Expression
	if( cExpression( rhs ) = FALSE ) then
		parser.ctxsym = NULL
		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
			exit function
		else
    		'' error recovery: skip stmt, return
    		hSkipStmt( )
    		return TRUE
    	end if
	end if

	parser.ctxsym = NULL

    '' set accessed flag here, as proc will be ended before AST is flushed
    symbSetIsAccessed( res )

    '' RETURN and has ctor? try to initialize..
    if( is_return and has_ctor ) then
    	dim as integer is_ctorcall
    	rhs = astBuildImplicitCtorCallEx( res, rhs, is_ctorcall )
    	if( rhs = NULL ) then
    		exit function
    	end if

    	if( is_ctorcall ) then
    		astAdd( astPatchCtorCall( rhs, _
    								  astBuildProcResultVar( proc, res ) ) )

    		return TRUE
    	end if
    end if

    dim as ASTNODE ptr expr

    '' do the assignment
    expr = astNewASSIGN( astBuildProcResultVar( proc, res ), rhs )
    if( expr = NULL ) then
   		astDelTree( rhs )

   		if( errReport( FB_ERRMSG_ILLEGALASSIGNMENT ) = FALSE ) then
   			exit function
   		end if

   	else
   		astAdd( expr )
   	end if

    function = TRUE

end function

'':::::
function cProcCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr, _
		byval checkprnts as integer = FALSE _
	) as ASTNODE ptr

	dim as integer dtype = any
	dim as FBSYMBOL ptr reslabel = any
	dim as ASTNODE ptr procexpr = any

	function = NULL

	'' property?
	if( symbIsProperty( sym ) ) then
		'' the arg is the lhs expression

		'' '='
		if( lexGetToken( ) <> FB_TK_ASSIGN ) then
    		if( errReport( FB_ERRMSG_EXPECTEDEQ ) = FALSE ) then
    			exit function
    		end if

		else
			lexSkipToken( )
		end if

		checkprnts = FALSE

	'' anything else..
	else
		if( checkprnts = TRUE ) then
			'' if the sub has no args, prnts are optional
			if( symbGetProcParams( sym ) = 0 ) then
				checkprnts = FALSE
			end if

		'' if it's a function pointer, prnts are obligatory
		elseif( ptrexpr <> NULL ) then
			checkprnts = TRUE

		end if
	end if

	if( checkprnts ) then
		'' '('
		if( hMatch( CHAR_LPRNT ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDLPRNT ) = FALSE ) then
				exit function
			end if
		end if
	end if

	parser.prntcnt = 0
	fbSetPrntOptional( not checkprnts )

	'' ProcArgList
	procexpr = cProcArgList( sym, ptrexpr, thisexpr, FALSE, FALSE )
	if( procexpr = NULL ) then
		exit function
	end if

	'' ')'
	if( (checkprnts) or (parser.prntcnt > 0) ) then

		'' --parent cnt
		parser.prntcnt -= 1

		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if

		elseif( parser.prntcnt > 0 ) then
			'' error recovery: skip until all ')'s are found
			do while( parser.prntcnt > 0 )
				hSkipUntil( CHAR_RPRNT, TRUE )
				parser.prntcnt -= 1
			loop
		end if

	end if

	fbSetPrntOptional( FALSE )

	'' StrIdxOrFieldDeref?
	if( symbIsProperty( sym ) = FALSE ) then
		if( cStrIdxOrFieldDeref( procexpr ) = FALSE ) then
			exit function
		end if
	end if

	'' if it's a SUB, the expr will be NULL
	if( procexpr = NULL ) then
		exit function
	end if

	dtype = astGetDataType( procexpr )

	'' not a function? (because cStrIdxOrFieldDeref())
	if( astIsCALL( procexpr ) = FALSE ) then
		return procexpr
	end if

	'' can proc's result be skipped?
	if( dtype <> FB_DATATYPE_VOID ) then
		if( symbGetDataClass( dtype ) <> FB_DATACLASS_INTEGER ) then
			if( errReport( FB_ERRMSG_VARIABLEREQUIRED ) <> FALSE ) then
				'' error recovery: skip
				astDelTree( procexpr )
			end if

			exit function

    	'' CHAR and WCHAR literals are also from the INTEGER class
    	else
    		select case dtype
    		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				if( errReport( FB_ERRMSG_VARIABLEREQUIRED ) <> FALSE ) then
					'' error recovery: skip
					astDelTree( procexpr )
				end if

				exit function
			end select
		end if
	end if

	'' check error?
	sym = astGetSymbol( procexpr )
	if( sym <> NULL ) then
		if( symbGetIsThrowable( sym ) ) then
    		if( env.clopt.resumeerr ) then
				reslabel = symbAddLabel( NULL )
    			astAdd( astNewLABEL( reslabel ) )
    		else
    			reslabel = NULL
    		end if

			rtlErrorCheck( procexpr, reslabel, lexLineNum( ) )
			exit function
		end if
	end if

	astSetType( procexpr, FB_DATATYPE_VOID, NULL )

	astAdd( procexpr )

	function = NULL

end function

''::::
private function hAssignOrCall _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval iscall as integer _
	) as integer

	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr expr = any

	function = FALSE

    do while( chain_ <> NULL )

    	sym = chain_->sym
    	select case as const symbGetClass( sym )
    	'' proc?
    	case FB_SYMBCLASS_PROC
    		if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
				exit function
    		end if

			lexSkipToken( )

            ''
            dim as integer do_call = lexGetToken( ) <> FB_TK_ASSIGN

            if( do_call = FALSE ) then
            	'' special case: property
            	if( symbIsProperty( sym ) ) then
                	do_call = TRUE

                	'' unless it's inside a PROPERTY GET block
                	if( symbIsProperty( parser.currproc ) ) then
                		if( symbGetProcParams( parser.currproc ) = 1 ) then
                			if( symbIsProcOverloadOf( parser.currproc, sym ) ) then
                				do_call = FALSE
                			end if
                		end if
                	end if
            	end if
            end if

			'' ID ProcParamList?
			if( do_call ) then
				dim as ASTNODE ptr this_ = NULL
				if( symbIsMethod( sym ) ) then
					this_ = astBuildInstPtr( _
								symbGetParamVar( _
									symbGetProcHeadParam( parser.currproc ) ) )
				end if

				expr = cProcCall( sym, NULL, this_ )
				if( errGetLast( ) <> FB_ERRMSG_OK ) then
					exit function
				end if

				'' assignment of a function deref?
				if( expr <> NULL ) then
					return cAssignment( expr )
       			end if

       			return TRUE

			'' ID '=' Expression
			else
            	'' CALL?
            	if( iscall ) then
					if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
						exit function
					else
						'' error recovery: skip stmt, return
						hSkipStmt( )
						return TRUE
					end if
            	end if

            	'' check if name is valid (or if overloaded)
				if( symbIsProcOverloadOf( parser.currproc, sym ) = FALSE ) then
					if( errReport( FB_ERRMSG_ILLEGALOUTSIDEASUB ) = FALSE ) then
						exit function
					else
						'' error recovery: skip stmt, return
						hSkipStmt( )
						return TRUE
					end if
				end if

       			'' skip the '='
       			lexSkipToken( )

       			return cAssignFunctResult( parser.currproc, FALSE )
			end if

    	'' variable or field?
    	case FB_SYMBCLASS_VAR, FB_SYMBCLASS_FIELD

        	if( symbIsVar( sym ) ) then
        		'' must process variables here, multiple calls to
        		'' Identifier() will fail if a namespace was explicitly
    	    	'' given, because the next call will return an inner symbol
        		if( cVariableEx( chain_, expr, TRUE ) = FALSE ) then
        			exit function
        		end if
        	else
        		if( cFieldVariable( NULL, chain_, expr, TRUE ) = FALSE ) then
        			exit function
        		end if
        	end if

    		'' CALL?
    		if( iscall ) then
    			'' calling a SUB ptr?
    			if( expr = NULL ) then
    				return TRUE
    			end if

    			'' not a ptr call?
    			if( astIsCALL( expr ) = FALSE ) then
    				astDelTree( expr )
					if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
						exit function
					else
						'' error recovery: skip stmt, return
						hSkipStmt( )
						return TRUE
					end if
    			end if
    		end if

        	return cAssignmentOrPtrCallEx( expr )

  		'' quirk-keyword?
  		case FB_SYMBCLASS_KEYWORD
  			return cQuirkStmt( sym->key.id )
		end select

    	chain_ = symbChainGetNext( chain_ )
    loop

end function

'':::::
''ProcCallOrAssign=   CALL ID ('(' ProcParamList ')')?
''                |   ID ProcParamList?
''				  |	  (ID | FUNCTION | OPERATOR | PROPERTY) '=' Expression .
''
function cProcCallOrAssign as integer
	dim as FBSYMCHAIN ptr chain_ = any
	dim as ASTNODE ptr expr

	function = FALSE

  	select case as const lexGetClass( )
    case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

		chain_ = cIdentifier( )
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

		return hAssignOrCall( chain_, FALSE )

  	case FB_TKCLASS_KEYWORD

		select case as const lexGetToken( )
		'' FUNCTION?
		case FB_TK_FUNCTION

			'' '='?
			if( lexGetLookAhead( 1 ) = FB_TK_ASSIGN ) then
				if( fbIsModLevel( ) ) then
					if( errReport( FB_ERRMSG_ILLEGALOUTSIDEASUB ) = FALSE ) then
						exit function
					else
						'' error recovery: skip stmt, return
						hSkipStmt( )
						return TRUE
					end if
				end if

				'' useless check.. don't allow FUNCTION inside OPERATOR or PROPERTY
				if( symbIsOperator( parser.currproc ) ) then
					if( errReport( FB_ERRMSG_EXPECTEDOPERATOR ) = FALSE ) then
						exit function
					end if

				elseif( symbIsProperty( parser.currproc ) ) then
					if( errReport( FB_ERRMSG_EXPECTEDPROPERTY ) = FALSE ) then
						exit function
					end if
				end if

				lexSkipToken( )
				lexSkipToken( )

    	    	return cAssignFunctResult( parser.currproc, FALSE )
			end if

		'' OPERATOR?
		case FB_TK_OPERATOR

			'' ambiguity: it could be just the operator '=' body
			if( fbIsModLevel( ) = FALSE ) then
				'' '='?
				if( lexGetLookAhead( 1 ) = FB_TK_ASSIGN ) then
					'' not inside an OPERATOR function?
					if( symbIsOperator( parser.currproc ) = FALSE ) then
						if( errReport( FB_ERRMSG_ILLEGALOUTSIDEANOPERATOR ) = FALSE ) then
							exit function
						else
							'' error recovery: skip stmt, return
							hSkipStmt( )
							return TRUE
						end if
					end if

					lexSkipToken( )
					lexSkipToken( )

	        		return cAssignFunctResult( parser.currproc, FALSE )
    	    	end if
			end if

		'' PROPERTY?
		case FB_TK_PROPERTY

			'' '='?
			if( lexGetLookAhead( 1 ) = FB_TK_ASSIGN ) then
				if( fbIsModLevel( ) ) then
					if( errReport( FB_ERRMSG_ILLEGALOUTSIDEANPROPERTY ) = FALSE ) then
						exit function
					else
						'' error recovery: skip stmt, return
						hSkipStmt( )
						return TRUE
					end if

				else
					if( symbIsProperty( parser.currproc ) = FALSE ) then
						if( errReport( FB_ERRMSG_ILLEGALOUTSIDEANPROPERTY ) = FALSE ) then
							exit function
						end if
					end if
				end if

				lexSkipToken( )
				lexSkipToken( )

    	    	return cAssignFunctResult( parser.currproc, FALSE )
			end if

		'' CONSTRUCTOR?
		case FB_TK_CONSTRUCTOR

			'' ambiguity: it could be an external ctor definition
			if( fbIsModLevel( ) = FALSE ) then
				'' not inside a ctor?
				if( symbIsConstructor( parser.currproc ) = FALSE ) then
					if( errReport( FB_ERRMSG_ILLEGALOUTSIDEACTOR ) = FALSE ) then
						exit function
					else
						'' error recovery: skip stmt, return
						hSkipStmt( )
						return TRUE
					end if
				end if

				return hCtorChain( )
			end if

		'' CALL?
		case FB_TK_CALL

    		if( fbLangOptIsSet( FB_LANG_OPT_CALL ) = FALSE ) then
    			if( errReportNotAllowed( FB_LANG_OPT_CALL ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: skip stmt
    				hSkipStmt( )
    				return TRUE
    			end if
    		end if

    		if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    			exit function
    		end if

			lexSkipToken( )

 			chain_ = cIdentifier( )
  			if( chain_ <> NULL ) then
				if( hAssignOrCall( chain_, TRUE ) ) then
					return TRUE
				end if
			end if

			'' !!!FIXME!!! add forward function call support like in QB: ie: all
			''             params are byref as any, show a warning too
			return errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )

		end select

	case FB_TKCLASS_DELIMITER

		'' '.'?
		if( lexGetToken( ) = CHAR_DOT ) then
  			'' can be a global ns symbol access, or a WITH variable..
 			chain_ = cIdentifier( )
  			if( chain_ <> NULL ) then
  				return hAssignOrCall( chain_, FALSE )

  			else
				if( errGetLast( ) <> FB_ERRMSG_OK ) then
					exit function
				end if

  				if( parser.stmt.with.sym <> NULL ) then
  					if( cWithVariable( parser.stmt.with.sym, _
  									   expr, _
  									   fbGetCheckArray( ) ) = FALSE ) then
  						exit function
  					end if

  					cAssignmentOrPtrCallEx( expr )
  				end if
  			end if
  		end if

	end select

end function

'':::::
private function hCtorChain _
	( _
		_
	) as integer

	dim as FBSYMBOL ptr proc = any, parent = any, this_ = any, ctor_head = any
	dim as ASTNODE ptr this_expr = any

	proc = parser.currproc

	parent = symbGetNamespace( proc )

	'' not the first stmt?
	if( symbGetIsCtorInited( proc ) ) then
		if( errReport( FB_ERRMSG_CALLTOCTORMUSTBETHEFIRSTSTMT ) = FALSE ) then
			return FALSE
		end if
	end if

	'' CONSTRUCTOR
	lexSkipToken( )

	ctor_head = symbGetCompCtorHead( parent )
	if( ctor_head = NULL ) then
		return FALSE
	end if

	'' this must be set before doing any AST call, or the ctor
	'' initialization would be trigged
	symbSetIsCtorInited( proc )

	this_ = symbGetProcHeadParam( proc )
	if( this_ = NULL ) then
		return FALSE
	end if

	this_expr = astBuildInstPtr( symbGetParamVar( this_ ) )

	cProcCall( ctor_head, NULL, this_expr )

	function = (errGetLast( ) = FB_ERRMSG_OK)

end function

