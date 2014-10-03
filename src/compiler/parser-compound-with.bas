'' WITH..END WITH compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'' WithStmtBegin  =  WITH Variable .
sub cWithStmtBegin( )
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr expr = any
	dim as integer is_ptr = any, options = any
	dim as FB_CMPSTMTSTK ptr stk = any

	'' WITH
	lexSkipToken( )

	'' Variable
	expr = cVarOrDeref( FB_VAREXPROPT_ISEXPR )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake a var
		expr = astNewVAR( symbAddTempVar( FB_DATATYPE_INTEGER ) )
	else
		'' not an UDT?
		if( typeGetDtAndPtrOnly( astGetFullType( expr ) ) <> FB_DATATYPE_STRUCT ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
		else
			if( astIsCALL( expr ) ) then
				expr = astBuildCallResultUdt( expr )
			end if
		end if
	end if

	if( astIsVAR( expr ) ) then
		'' If it's a simple VAR access, we can just access the
		'' corresponding variable from inside the WITH.
		sym = astGetSymbol( expr )
		is_ptr = FALSE
		astDelTree( expr )
		expr = NULL
	else
		'' Otherwise, take a reference (a pointer that will be deref'ed
		'' for accesses from inside the WITH block)
		''    dim temp as typeof( expr ) ptr = @expr
		assert( astCanTakeAddrOf( expr ) )
		expr = astNewADDROF( expr )

		options = 0
		if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
			options or= FB_SYMBOPT_UNSCOPE
		end if

		sym = symbAddImplicitVar( astGetFullType( expr ), astGetSubType( expr ), options )

		if( options and FB_SYMBOPT_UNSCOPE ) then
			astAddUnscoped( astNewDECL( sym, TRUE ) )
			astAdd( astNewASSIGN( astNewVAR( sym ), expr ) )
		else
			astAdd( astNewLINK( _
				astNewDECL( sym, FALSE ), _
				astNewASSIGN( astNewVAR( sym ), expr, AST_OPOPT_ISINI ) ) )
		end if

		is_ptr = TRUE
	end if

	'' Save current WITH context to the statement stack
	stk = cCompStmtPush( FB_TK_WITH )
	stk->with = parser.stmt.with

	'' And set the new WITH context
	parser.stmt.with.sym    = sym
	parser.stmt.with.is_ptr = is_ptr
end sub

'' WithStmtEnd  =  END WITH .
sub cWithStmtEnd( )
	dim as FB_CMPSTMTSTK ptr stk = any

	stk = cCompStmtGetTOS( FB_TK_WITH )
	if( stk = NULL ) then
		hSkipStmt( )
		exit sub
	end if

	'' END WITH
	lexSkipToken( )
	lexSkipToken( )

	'' Restore the previous WITH context
	parser.stmt.with = stk->with
	cCompStmtPop( stk )
end sub
