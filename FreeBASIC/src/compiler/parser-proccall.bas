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
function cCtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byref is_ctorcall as integer _
	) as ASTNODE ptr

    dim as FBSYMBOL ptr subtype = any

	subtype = symbGetSubType( sym )

    '' check ctor call
    if( astIsCALLCTOR( expr ) ) then
    	if( symbGetSubtype( expr ) = subtype ) then
    		is_ctorcall = TRUE
    		'' remove the the anon/temp instance
    		return astCallCtorToCall( expr )
    	end if
    end if

    '' try calling any ctor with the expression
    function = astBuildImplicitCtorCall( subtype, expr, is_ctorcall )

end function

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
    	rhs = cCtorCall( res, rhs, is_ctorcall )
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
		byref procexpr as ASTNODE ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr, _
		byval checkprnts as integer = FALSE _
	) as integer

	dim as integer dtype = any, isfuncptr = any, doflush = any
	dim as FBSYMBOL ptr subtype = any, reslabel = any

	function = FALSE

	if( checkprnts = TRUE ) then
		'' if the sub has no args, prnts are optional
		if( symbGetProcParams( sym ) = 0 ) then
			checkprnts = FALSE
		end if

	'' if it's a function pointer, prnts are obligatory
	elseif( ptrexpr <> NULL ) then
		checkprnts = TRUE

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

	sym = astGetSymbol( procexpr )
	dtype = astGetDataType( procexpr )
	subtype = astGetSubType( procexpr )

	'' if function returns a pointer, check for field deref
	doflush = TRUE
	if( dtype >= FB_DATATYPE_POINTER ) then
		isfuncptr = FALSE
   		if( lexGetToken( ) = CHAR_LPRNT ) then
   			if( dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION ) then
				isfuncptr = TRUE
   			end if
   		end if

		'' FuncPtrOrDerefFields?
		if( cFuncPtrOrDerefFields( dtype, subtype, _
								   procexpr, isfuncptr, _
								   TRUE ) = FALSE ) then
			'' error?
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

		'' type changed
		else
			doflush = FALSE
			'' if it's a SUB, the expr will be NULL
			if( procexpr <> NULL ) then
				dtype = astGetDataType( procexpr )

				'' if it stills a function, unless type = string (ie: implicit pointer),
				'' flush it, as the assignment would be invalid
				if( astIsCALL( procexpr ) ) then
					if( dtype <> FB_DATATYPE_STRING ) then
						doflush = TRUE
					end if
				end if
        	end if
		end if

	end if

	''
	if( doflush ) then
		'' can proc's result be skipped?
		if( dtype <> FB_DATATYPE_VOID ) then
			if( symbGetDataClass( dtype ) <> FB_DATACLASS_INTEGER ) then
				if( errReport( FB_ERRMSG_VARIABLEREQUIRED ) = FALSE ) then
					exit function
				else
					'' error recovery: skip
					astDelTree( procexpr )
					procexpr = NULL
					return TRUE
				end if

    		'' CHAR and WCHAR literals are also from the INTEGER class
    		else
    			select case dtype
    			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
					if( errReport( FB_ERRMSG_VARIABLEREQUIRED ) = FALSE ) then
						exit function
					else
						'' error recovery: skip
						astDelTree( procexpr )
						procexpr = NULL
						return TRUE
					end if
				end select
			end if
		end if

		'' check error?
		if( sym <> NULL ) then
			if( symbGetIsThrowable( sym ) ) then
    			if( env.clopt.resumeerr ) then
					reslabel = symbAddLabel( NULL )
    				astAdd( astNewLABEL( reslabel ) )
    			else
    				reslabel = NULL
    			end if

				function = rtlErrorCheck( procexpr, reslabel, lexLineNum( ) )
				procexpr = NULL
				return TRUE
			end if
		end if

		astSetDataType( procexpr, FB_DATATYPE_VOID )
		astAdd( procexpr )
		procexpr = NULL
	end if

	function = TRUE

end function

''::::
private function hAssignOrCall _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval iscall as integer _
	) as integer

	dim as FBSYMBOL ptr s = any
	dim as ASTNODE ptr expr = any

	function = FALSE

    do while( chain_ <> NULL )

    	s = chain_->sym
    	select case as const symbGetClass( s )
    	'' proc?
    	case FB_SYMBCLASS_PROC
    		if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
				exit function
    		end if

			lexSkipToken( )

			'' ID ProcParamList?
			if( lexGetToken( ) <> FB_TK_ASSIGN ) then
				if( cProcCall( s, expr, NULL ) = FALSE ) then
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
				if( symbIsProcOverloadOf( parser.currproc, s ) = FALSE ) then
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

        	if( symbIsVar( s ) ) then
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
  			return cQuirkStmt( s->key.id )
		end select

    	chain_ = symbChainGetNext( chain_ )
    loop

end function

'':::::
''ProcCallOrAssign=   CALL ID ('(' ProcParamList ')')?
''                |   ID ProcParamList?
''				  |	  (ID | FUNCTION | OPERATOR) '=' Expression .
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
	) as integer static

	dim as FBSYMBOL ptr proc, parent, this_, ctor_head
	dim as ASTNODE ptr expr, this_expr

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

	return cProcCall( ctor_head, expr, NULL, this_expr )

end function

