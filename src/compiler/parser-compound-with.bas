'' WITH..END WITH compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'' Visit all the vars in the given scope, and ...
'' * remove the TEMP flag from all of them (so they'll no longer be
''   treated as living in the current statement only)
'' * remove them from the AST dtor list (so they won't be automatically
''   destroyed at the next astAdd() anymore)
'' * build DECL nodes for them (for the C backend)
private function hExtendTempLifeTime( byval scp as FBSYMBOL ptr ) as ASTNODE ptr
	dim as ASTNODE ptr t = NULL

	assert( symbIsScope( scp ) )
	var sym = symbGetScopeSymbTbHead( scp )
	while( sym )

		if( symbIsVar( sym ) ) then
			assert( symbIsTemp( sym ) )
			assert( sym->stats and FB_SYMBSTATS_IMPLICIT )

			astDtorListDel( sym )

			sym->attrib and= not FB_SYMBATTRIB_TEMP

			t = astNewLINK( t, astNewDECL( sym, FALSE ), AST_LINK_RETURN_RIGHT )
		end if

		sym = sym->next
	wend

	assert( astDtorListIsEmpty( ) )
	function = t
end function

'' WithStmtBegin  =  WITH Variable .
sub cWithStmtBegin( )
	static as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr sym = any
	dim as ASTNODE ptr expr = any
	dim as integer is_ptr = any, options = any
	dim as FB_CMPSTMTSTK ptr stk = any

	'' WITH
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	''
	'' Open an implicit scope.
	''
	'' It will enclose any temporaries from the WITH expression. We can
	'' easily check the scope to detect them, remove the TEMP flag, and then
	'' the scope will ensure to destroy them at scope breaks/end.
	''
	'' The scope must be created before parsing the expression given to
	'' WITH, otherwise any temporaries it uses would be destroyed too
	'' early by astScopeBegin() because that flushes the AST dtor list.
	''
	var scopenode = astScopeBegin( )
	if( scopenode = NULL ) then
		errReport( FB_ERRMSG_RECLEVELTOODEEP )
	end if

	'' UDT variable/expression. We can accept ...
	''  * plain variable accesses, array elements, DEREF expressions
	''  * even function calls, which (due to returning a UDT) have the
	''    result in a variable anyways, or can be copied to one via
	''    astBuildCallResultUdt())
	''  * and anything else that represents a temp var, e.g. type<UDT>(...)
	''    expressions a.k.a. TYPEINI/CALLCTOR
	'' Since we're only accepting UDTs anyways, we don't even need that many
	'' checks. An UDT expression will always be a var/deref in the end.
	expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake a var
		expr = astNewVAR( symbAddTempVar( FB_DATATYPE_INTEGER ) )
	else
		'' not an UDT?
		if( typeGetDtAndPtrOnly( astGetFullType( expr ) ) <> FB_DATATYPE_STRUCT ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			expr = astNewVAR( symbAddTempVar( FB_DATATYPE_INTEGER ) )
		else
			if( astIsCALL( expr ) ) then
				expr = astBuildCallResultUdt( expr )
			end if
		end if
	end if

	'' Turn TYPEINI trees into real assignments.  Since TYPEINIs will be assigned
	'' to temporary variables, this must be done before we extend the lifetime
	'' of the temporary variables below.
	expr = astTypeIniUpdate( expr )

	''
	'' Turn the vars in the given scope from TEMPs into normal (but still
	'' implicit) vars, remove them from the AST dtor list, and build a DECL
	'' node for each one. But without calling ctors/doing default
	'' initialization, because the expression has already done that.
	''
	'' This way we "extend the lifetime" of all the temp vars in the WITH
	'' expression.
	''
	'' This must be done before any astAdd()'s, otherwise the AST dtor list
	'' flush would generate dtor calls for the temp vars immediately.
	'' We only want that to happen at scope breaks/end though (and for that,
	'' the vars mustn't have the TEMP flag).
	''
	var t = hExtendTempLifeTime( scopenode->sym )

	var effectiveexpr = astGetEffectiveNode( expr )
	if( astIsVAR( effectiveexpr ) ) then
		'' If it's a simple VAR access, we can just access the
		'' corresponding variable from inside the WITH.
		sym = astGetSymbol( effectiveexpr )
		is_ptr = FALSE
		t = astNewLINK( t, astRebuildWithoutEffectivePart( expr ), AST_LINK_RETURN_RIGHT )
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
			t = astNewLINK( t, astNewASSIGN( astNewVAR( sym ), expr ), AST_LINK_RETURN_RIGHT )
		else
			t = astNewLINK( t, astNewDECL( sym, FALSE ), AST_LINK_RETURN_RIGHT )
			t = astNewLINK( t, astNewASSIGN( astNewVAR( sym ), expr, AST_OPOPT_ISINI ), AST_LINK_RETURN_RIGHT )
		end if

		is_ptr = TRUE
	end if

	astAdd( t )

	'' Create new WITH context on the statement stack
	stk = cCompStmtPush( FB_TK_WITH )
	stk->with.sym = sym
	stk->with.is_ptr = is_ptr
	stk->scopenode = scopenode
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
	lexSkipToken( LEXCHECK_POST_SUFFIX )
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' Close implicit scope
	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	'' Restore the previous WITH context
	cCompStmtPop( stk )
end sub
