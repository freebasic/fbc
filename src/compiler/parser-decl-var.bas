'' variable declarations (DIM, REDIM, COMMON, EXTERN or STATIC)
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "rtl.bi"
#include once "ast.bi"

declare sub cAutoVarDecl( byval baseattrib as FB_SYMBATTRIB )

sub hComplainIfAbstractClass _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	)

	if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_STRUCT ) then
		if( symbCompGetAbstractCount( subtype ) > 0 ) then
			errReport( FB_ERRMSG_OBJECTOFABSTRACTCLASS )
		end if
	end if

end sub

sub hMaybeComplainTypeUsage _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint _
	)

	'' check access to structs and if the check fails, fake a
	'' a type for error recovery

	select case typeGetDtAndPtrOnly( dtype )
	case FB_DATATYPE_STRUCT

		'' Check visibility of the symbol type
		if( symbCheckAccessStruct( subtype ) = FALSE ) then
			errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
			'' error recovery: fake a type
			dtype = FB_DATATYPE_INTEGER
			subtype = NULL
			lgt = typeGetSize( dtype )
		end if

	end select

end sub

sub hComplainAboutConstDynamicArray( byval sym as FBSYMBOL ptr )
	'' Disallow const dynamic arrays, they could never be assigned,
	'' since dynamic arrays aren't allowed to have initializers.
	if( typeIsConst( symbGetFullType( sym ) ) ) then
		errReport( FB_ERRMSG_DYNAMICARRAYSCANTBECONST )
	end if
end sub

sub hSymbolType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint, _
		byval is_byref as integer, _
		byval is_extends as integer _
	)

	dim as integer options = FB_SYMBTYPEOPT_DEFAULT
	if( is_byref ) then
		options and= not FB_SYMBTYPEOPT_CHECKSTRPTR
		options or= FB_SYMBTYPEOPT_ISBYREF
	end if
	if( is_extends ) then
		options and= not FB_SYMBTYPEOPT_CHECKSTRPTR
	end if

	'' parse the symbol type (INTEGER, STRING, etc...)
	if( cSymbolType( dtype, subtype, lgt, , options ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake a type
		dtype = FB_DATATYPE_INTEGER
		subtype = NULL
		lgt = typeGetSize( dtype )
	end if

	'' ANY?
	if( dtype = FB_DATATYPE_VOID ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		'' error recovery: fake a type
		dtype = typeAddrOf( dtype )
		subtype = NULL
		lgt = typeGetSize( dtype )
	end if

	'' ANY alias "modifier" but no pointer level?
	if( typeHasMangleDt( dtype ) and (typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_VOID) ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		'' error recovery: fake a type
		dtype = typeAddrOf( dtype )
		subtype = NULL
		lgt = typeGetSize( dtype )
	end if

end sub

function hCheckScope() as integer
	if( parser.scope > FB_MAINSCOPE ) then
		if( fbIsModLevel( ) = FALSE ) then
			errReport( FB_ERRMSG_ILLEGALINSIDEASUB )
		else
			errReport( FB_ERRMSG_ILLEGALINSIDEASCOPE )
		end if
		function = FALSE
	else
		function = TRUE
	end if
end function

''
'' VariableDecl =
''    DIM|REDIM|COMMON|STATIC [SHARED] Symbol
''  | EXTERN Symbol [ALIAS StringLiteral]
''  | [STATIC] VAR AutoVarDecl
''
'' RedimStmt =
''    REDIM [PRESERVE] Symbol|Expression
''
function cVariableDecl( byval attrib as FB_SYMBATTRIB ) as integer
	dim as integer dopreserve = any, tk = any

#macro hCheckPrivPubAttrib( attrib )
	if( (attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_PRIVATE)) <> 0 ) then
		errReport( FB_ERRMSG_PRIVORPUBTTRIBNOTALLOWED )
		attrib and= not FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_PRIVATE
	end if
#endmacro

	dopreserve = FALSE

	tk = lexGetToken( )

	select case as const tk
	'' REDIM
	case FB_TK_REDIM
		'' REDIM generates code, check if allowed
		if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
			hSkipStmt( )
			return TRUE
		end if

		hCheckPrivPubAttrib( attrib )

		lexSkipToken( LEXCHECK_POST_SUFFIX )
		attrib or= FB_SYMBATTRIB_DYNAMIC

		'' PRESERVE?
		dopreserve = hMatch( FB_TK_PRESERVE, LEXCHECK_POST_SUFFIX )

	'' COMMON
	case FB_TK_COMMON
		attrib or= FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_STATIC

		'' this will be removed, if it's not a array
		attrib or= FB_SYMBATTRIB_DYNAMIC

		'' can't use COMMON inside a proc or inside a scope block
		if( hCheckScope( ) = FALSE ) then
			'' error recovery: don't make it COMMON
			attrib and= not FB_SYMBATTRIB_COMMON
		end if

		hCheckPrivPubAttrib( attrib )

		lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' EXTERN
	case FB_TK_EXTERN
		if( attrib = FB_SYMBATTRIB_NONE ) then
			'' Disambiguate from <EXTERN "..." : ... : END EXTERN> blocks
			if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_STRLITERAL ) then
				return FALSE
			end if
		end if

		attrib or= FB_SYMBATTRIB_EXTERN
		attrib or= FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC

		'' can't use EXTERN inside a proc
		if( hCheckScope( ) = FALSE ) then
			'' error recovery: don't make it extern/shared
			attrib and= not (FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_SHARED)
		end if

		hCheckPrivPubAttrib( attrib )

		lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' STATIC
	case FB_TK_STATIC
		if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE ) = FALSE ) then
			hSkipStmt( )
			return TRUE
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		attrib or= FB_SYMBATTRIB_STATIC

		'' VAR?
		if( lexGetToken( ) = FB_TK_VAR ) then
			cAutoVarDecl( attrib )
			return TRUE
		end if

	'' VAR
	case FB_TK_VAR
		cAutoVarDecl( attrib )
		return TRUE

	case else
		if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE ) = FALSE ) then
			hSkipStmt( )
			return TRUE
		end if

		'' DIM
		lexSkipToken( LEXCHECK_POST_LANG_SUFFIX )

	end select

	'' OPTION DYNAMIC enabled?
	if( env.opt.dynamic ) then
		attrib or= FB_SYMBATTRIB_DYNAMIC
	end if

	if( (attrib and FB_SYMBATTRIB_EXTERN) = 0 ) then
		'' SHARED?
		if( lexGetToken( ) = FB_TK_SHARED ) then
			'' can't use SHARED inside a proc
			if( hCheckScope( ) = FALSE ) then
				'' error recovery: don't make it shared
				attrib or= FB_SYMBATTRIB_STATIC
			else
				attrib or= FB_SYMBATTRIB_SHARED or _
				           FB_SYMBATTRIB_STATIC
			end if
			lexSkipToken( LEXCHECK_POST_SUFFIX )
		end if
	else
		'' IMPORT?
		if( lexGetToken( ) = FB_TK_IMPORT ) then
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' only if target is Windows
			select case env.clopt.target
			case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
				attrib or= FB_SYMBATTRIB_IMPORT
			end select
		end if
	end if

	if( symbGetProcStaticLocals( parser.currproc ) ) then
		attrib or= FB_SYMBATTRIB_STATIC
	end if

	cVarDecl( attrib, dopreserve, tk, FALSE )
	function = TRUE
end function

private function hExprTbIsConst _
	( _
		byval dimensions as integer, _
		exprTB() as ASTNODE ptr _
	) as integer

	for i as integer = 0 to dimensions-1
		if( astIsCONST( exprTB(i, 0) ) = FALSE ) then
			return FALSE
		elseif( exprTB(i, 1) = NULL ) then
			'' do nothing, allow NULL expression here for ellipsis
		elseif( astIsCONST( exprTB(i, 1) ) = FALSE ) then
			return FALSE
		end if
	next

	function = TRUE
end function

private function hCheckExternVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as longint, _
		byval attrib as FB_SYMBATTRIB, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	) as integer

	'' Check data type
	if( (dtype <> symbGetFullType( sym )) or _
	    (subtype <> symbGetSubType( sym )) ) then
		errReportEx( FB_ERRMSG_TYPEMISMATCH, *id )
		exit function
	end if

	'' Byref?
	if( symbIsRef( sym ) <> ((attrib and FB_SYMBATTRIB_REF) <> 0) ) then
		errReportEx( FB_ERRMSG_TYPEMISMATCH, *id )
		exit function
	end if

	'' Check fix-len string length
	select case( typeGetDtAndPtrOnly( dtype ) )
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		if( lgt <> sym->lgt ) then
			errReportEx( FB_ERRMSG_TYPEMISMATCH, *id )
			exit function
		end if
	end select

	'' One is dynamic, but the other isn't? (can't just rely on dimensions
	'' check below, because we may have seen dimensions <> -1 in a dynamic
	'' array declaration, e.g. with a REDIM)
	if( (attrib and FB_SYMBATTRIB_DYNAMIC) <> (sym->attrib and FB_SYMBATTRIB_DYNAMIC) ) then
		errReportEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, *id )
		exit function
	end if

	'' One of them has unknown dimensions? Then the other must be an array too,
	'' but there's no need to do further checks.
	if( (dimensions = -1) or (symbGetArrayDimensions( sym ) = -1) ) then
		if( (dimensions <> 0) <> (symbGetArrayDimensions( sym ) <> 0) ) then
			errReportEx( FB_ERRMSG_WRONGDIMENSIONS, *id )
			exit function
		end if
		return TRUE
	end if

	'' Mismatching array dimensions?
	if( dimensions <> symbGetArrayDimensions( sym ) ) then
		errReportEx( FB_ERRMSG_WRONGDIMENSIONS, *id )
		exit function
	end if

	'' Check bounds of fixed-size arrays
	if( (attrib and FB_SYMBATTRIB_DYNAMIC) = 0 ) then
		'' Same lbound/ubound for each dimension?
		for i as integer = 0 to dimensions - 1
			if( (symbArrayLbound( sym, i ) <> dTB(i).lower) or _
			    ((symbArrayUbound( sym, i ) <> dTB(i).upper) and _
			     (dTB(i).upper <> FB_ARRAYDIM_UNKNOWN)) ) then
				errReportEx( FB_ERRMSG_BOUNDSDIFFERFROMEXTERN, *id )
			end if
		next
	end if

	function = TRUE
end function

private sub hCheckExternVarAndRecover _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint, _
		byval attrib as FB_SYMBATTRIB, _
		byref dimensions as integer, _
		byref have_bounds as integer, _
		dTB() as FBARRAYDIM _
	)

	if( hCheckExternVar( sym, id, dtype, subtype, lgt, attrib, dimensions, dTB() ) = FALSE ) then
		'' Error recovery: make definition match the EXTERN declaration
		dtype = symbGetFullType( sym )
		subtype = symbGetSubType( sym )
		lgt = symbGetLen( sym )
		const AttribsToCopy = FB_SYMBATTRIB_DYNAMIC or FB_SYMBATTRIB_REF
		attrib = (attrib and (not AttribsToCopy)) or (sym->attrib and AttribsToCopy)
		dimensions = symbGetArrayDimensions( sym )
		if( attrib and FB_SYMBATTRIB_DYNAMIC ) then
			have_bounds = FALSE
		elseif( dimensions > 0 ) then
			have_bounds = TRUE
			for i as integer = 0 to dimensions - 1
				dTB(i).lower = symbArrayLbound( sym, i )
				dTB(i).upper = symbArrayUbound( sym, i )
			next
		end if
	end if

end sub

private function hAddVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval idalias as zstring ptr, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint, _
		byval addsuffix as integer, _
		byval attrib as FB_SYMBATTRIB, _
		byref dimensions as integer, _
		byref have_bounds as integer, _
		dTB() as FBARRAYDIM, _
		byval token as integer _
	) as FBSYMBOL ptr

	dim as integer is_declared = any

	'' Have an existing variable with this name?
	if( sym ) then
		'' Allocating an EXTERN? Only if this is not a duplicate EXTERN,
		'' and only if at toplevel scope.
		if( symbIsExtern( sym ) and _
		    ((attrib and FB_SYMBATTRIB_EXTERN) = 0) and _
		    (parser.scope = FB_MAINSCOPE) ) then

			'' Verify that the new variable declaration is compatible with the previous EXTERN
			hCheckExternVarAndRecover( sym, id, dtype, subtype, lgt, attrib, dimensions, have_bounds, dTB() )

			'' Then allocate the EXTERN:

			'' Remove EXTERN (or it won't be emitted), add PUBLIC (and SHARED
			'' for safety), and preserve the rest (e.g. visibility).
			sym->attrib and= not FB_SYMBATTRIB_EXTERN
			sym->attrib or= FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_SHARED

			'' array? update the descriptor attributes too
			if( dimensions <> 0 ) then
				dim as FBSYMBOL ptr desc = symbGetArrayDescriptor( sym )

				desc->attrib and= not FB_SYMBATTRIB_EXTERN
				desc->attrib or= FB_SYMBATTRIB_SHARED

				'' not dynamic? descriptor can't be public
				if( symbIsDynamic( sym ) = FALSE ) then
					desc->attrib and= not FB_SYMBATTRIB_PUBLIC
				else
					desc->attrib or= FB_SYMBATTRIB_PUBLIC
				end if

				'' Add an initializer to the descriptor, now that we know this
				'' EXTERN will be allocated in this module, and the EXTERN
				'' attribute was removed
				symbSetTypeIniTree( desc, astBuildArrayDescIniTree( desc, sym, NULL ) )
			end if

			is_declared = TRUE

		'' Duplicate EXTERN?
		elseif( symbIsExtern( sym ) and _
		        ((attrib and FB_SYMBATTRIB_EXTERN) <> 0) ) then

			'' Only verify that the EXTERN declaration is compatible with the previous one
			hCheckExternVarAndRecover( sym, id, dtype, subtype, lgt, attrib, dimensions, have_bounds, dTB() )
			is_declared = TRUE

		'' REDIM'ing an existing array (dynamic array var/field, BYDESC param)?
		'' Note: If the existing array is a COMMON, then not only REDIM is allowed,
		'' but also DIM etc.
		elseif( ((attrib and FB_SYMBATTRIB_DYNAMIC) <> 0) and _
		        have_bounds and _
		        symbGetIsDynamic( sym ) and _
		        ((token = FB_TK_REDIM) or symbIsCommon( sym )) ) then

			'' nothing to do here (besides not declaring a new variable),
			'' rtlArrayRedim() will be called below
			is_declared = TRUE

		'' Have an existing variable, but it's none of the above cases?
		'' Then this is the declaration of a new variable, and it will
		'' a) trigger a duplicate definition error (if the symbAddVar()
		''    fails because the symbol already exists in this scope)
		'' b) shadow the existing one (if the existing symbol is from
		''    another scope).
		else
			is_declared = FALSE
		end if
	else
		'' No existing variable yet, just do symbAddVar() which
		'' adds it the current scope.
		is_declared = FALSE
	end if

	if( is_declared ) then
		if( symbIsDynamic( sym ) ) then
			'' Update dynamic array dimensions - set them if they were unknown and are now known.
			''
			'' This enables compile-time dimension count tracking for dynamic arrays that were
			'' declared as () (unknown dimensions) but then REDIM'ed to certain dimension count.
			''
			'' Of course this isn't 100% reliable, because:
			''  - it will only enable checking after the REDIM was seen, so it won't affect array
			''    accesses parsed before that,
			''  - it doesn't work across modules
			''  - it doesn't handle multiple code paths
			if( (dimensions <> -1) and (symbGetArrayDimensions( sym ) = -1) ) then
				sym->var_.array.dimensions = dimensions
			end if
		end if

		if( symbGetIsDynamic( sym ) ) then
			symbCheckDynamicArrayDimensions( sym, dimensions )
		end if
	else
		'' As long as the new variable declaration has no namespace prefix,
		'' we can try to add it as new var. If it has a namespace prefix
		'' though, then we have to show an error. We can't add a variable
		'' into the namespace this way (they can only be added from inside),
		'' but we can't just ignore the namespace prefix either.
		''
		'' Normally hLookupVarAndCheckParent() should already catch all such cases,
		'' but since our "redim vs. declaration" detection may not have been
		'' accurate at the point of hLookupVarAndCheckParent(), it's probably
		'' good to have this check here too.
		if( parent ) then
			errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		end if

		if( addsuffix ) then
			attrib or= FB_SYMBATTRIB_SUFFIXED
		end if

		sym = symbAddVar( id, idalias, dtype, subtype, lgt, dimensions, dTB(), attrib, _
		                  iif( fbLangOptIsSet( FB_LANG_OPT_SCOPE ), 0, FB_SYMBOPT_UNSCOPE ) )

		if( sym ) then
			var is_global = (symbGetAttrib( sym ) and _
			                (FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_PUBLIC or _
			                FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_SHARED )) <> 0

			'' only warn if the symbol is global and in the global namespace
			if( is_global ) then
				if( (id <> NULL) and (symbGetNamespace( sym ) = @symbGetGlobalNamespc( )) ) then
					if( parserIsGlobalAsmKeyword( lcase(*id) ) ) then
						errReportWarnEx( FB_WARNINGMSG_RESERVEDGLOBALSYMBOL, id , lexLineNum( ) )
					end if
				end if
			end if
		end if
	end if

	if( sym = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
	end if

	function = sym
end function

private function hCheckForIdToken( byval parent as FBSYMBOL ptr ) as integer
	function = FB_ERRMSG_OK

	select case as const( lexGetClass( ) )
	case FB_TKCLASS_IDENTIFIER
		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
				if( lexGetPeriodPos( ) > 0 ) then
					function = FB_ERRMSG_CANTINCLUDEPERIODS
				end if
			end if
		end if

	case FB_TKCLASS_QUIRKWD
		'' Ok in -lang qb, but otherwise, need additional checks
		if( env.clopt.lang <> FB_LANG_QB ) then
			'' only if inside a ns and if not local
			if( (parent = NULL) or (parser.scope > FB_MAINSCOPE) ) then
				function = FB_ERRMSG_DUPDEFINITION
			end if
		end if

	case FB_TKCLASS_KEYWORD, FB_TKCLASS_OPERATOR
		if( env.clopt.lang <> FB_LANG_QB ) then
			function = FB_ERRMSG_DUPDEFINITION
		else
			'' Ok in -lang qb if it has a suffix
			if( lexGetType( ) = FB_DATATYPE_INVALID ) then
				function = FB_ERRMSG_DUPDEFINITION
			end if
		end if

	case else
		function = FB_ERRMSG_EXPECTEDIDENTIFIER
	end select
end function

private function hGetId _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byref suffix as integer, _
		byval is_redim as integer _
	) as FBSYMCHAIN ptr

	dim as integer errmsg = any

	errmsg = hCheckForIdToken( parent )
	if( errmsg = FB_ERRMSG_OK ) then
		*id = *lexGetText( )
		lexCheckToken( LEXCHECK_POST_LANG_SUFFIX )
		suffix = lexGetType( )

		'' no parent? read as-is
		if( parent = NULL ) then
			function = lexGetSymChain( )
		else
			function = symbLookupAt( parent, lexGetText( ), FALSE, is_redim )
		end if

		lexSkipToken( )

	else
		errReport( errmsg )
		'' error recovery: fake an id
		*id = *symbUniqueLabel( )
		suffix = FB_DATATYPE_INVALID
		function = NULL
		'' don't report on suffix, already have an error
		lexSkipToken( )
	end if

end function

private function hLookupVar _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval dtype as integer, _
		byval is_typeless as integer, _
		byval has_suffix as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

	if( chain_ = NULL ) then
		exit function
	end if

	if( is_typeless ) then
		if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) ) then
			sym = symbFindVarByDefType( chain_, dtype )
		else
			sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
			if( sym = NULL ) then
				sym = symbFindByClass( chain_, FB_SYMBCLASS_FIELD )
			end if
		end if
	elseif( has_suffix ) then
		sym = symbFindVarBySuffix( chain_, dtype )
	else
		sym = symbFindByClassAndType( chain_, FB_SYMBCLASS_VAR, dtype )
		if( sym = NULL ) then
			sym = symbFindByClassAndType( chain_, FB_SYMBCLASS_FIELD, dtype )
		end if
	end if

	function = sym
end function

private function hLookupVarAndCheckParent _
	( _
		byval parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr, _
		byval dtype as integer, _
		byval is_typeless as integer, _
		byval has_suffix as integer, _
		byval is_redim as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

	sym = hLookupVar( chain_, dtype, is_typeless, has_suffix )

	'' Namespace prefix explicitly given? And is not global
	if( (parent <> NULL) and (parent <> @symbGetGlobalNamespc()) ) then
		if( sym ) then
			'' "DIM Parent.foo" is only allowed if there was an
			'' "EXTERN foo" in the Parent namespace, or if it's a
			'' "REDIM Parent.foo" redimming an array declared in
			'' the Parent namespace.
			'' No EXTERN, or different parent, and not REDIM?
			if( ((symbIsExtern( sym ) = FALSE) or _
			     (symbGetNamespace( sym ) <> parent)) and _
			     (not is_redim) ) then
				errReport( FB_ERRMSG_DECLOUTSIDECLASS )
			end if
		else
			'' Symbol not found in the specified parent namespace
			errReport( FB_ERRMSG_DECLOUTSIDENAMESPC, TRUE )
		end if
	else
		'' The looked up symbol may be an existing var. If it's from
		'' another namespace, then we ignore it, so that this new
		'' declaration declares a new var in the current namespace,
		'' i.e. a duplicate. However if it's from the current namespace
		'' already, then we cannot allow declaring a second variable
		'' with that name. Unless this is a REDIM, of course.
		if( sym ) then
			if( (symbGetNamespace( sym ) <> symbGetCurrentNamespc( )) and _
			    (not is_redim) ) then
				sym = NULL
			end if
		end if
	end if

	function = sym
end function

private sub hMakeArrayDimTB _
	( _
		byval dimensions as integer, _
		exprTB() as ASTNODE ptr, _
		dTB() as FBARRAYDIM _
	)

	for i as integer = 0 to dimensions-1
		dim as ASTNODE ptr expr = any

		'' lower bound
		dTB(i).lower = astConstFlushToInt( exprTB(i, 0) )

		'' upper bound
		expr = exprTB(i, 1)
		if( expr = NULL ) then
			'' if a null expr is found, that means it was an ellipsis for the
			'' upper bound, so we set a special upper value, and CONTINUE in
			'' order to skip the check
			dTB(i).upper = FB_ARRAYDIM_UNKNOWN
		else
			dTB(i).upper = astConstFlushToInt( expr )

			'' Besides the upper < lower case, also complain about FB_ARRAYDIM_UNKNOWN being
			'' specified, otherwise we'd think ellipsis was given...
			if( (dTB(i).upper < dTB(i).lower) or (dTB(i).upper = FB_ARRAYDIM_UNKNOWN) ) then
				errReport( FB_ERRMSG_INVALIDSUBSCRIPT )
				dTB(i).lower = 0
				dTB(i).upper = 0
			end if
		end if
	next

end sub

sub hMaybeConvertExprTb2DimTb _
	( _
		byref attrib as FB_SYMBATTRIB, _
		byval dimensions as integer, _
		exprTB() as ASTNODE ptr, _
		dTB() as FBARRAYDIM _
	)

	'' if subscripts are constants, convert exprTB to dimTB
	if( hExprTbIsConst( dimensions, exprTB() ) ) then
		'' only if not explicitly dynamic (ie: not REDIM, COMMON)
		if( (attrib and FB_SYMBATTRIB_DYNAMIC) = 0 ) then
			hMakeArrayDimTB( dimensions, exprTB(), dTB() )
		end if
	else
		'' Non-constant array bounds, must be dynamic
		attrib or= FB_SYMBATTRIB_DYNAMIC
	end if

end sub

sub hComplainAboutEllipsis _
	( _
		byval dimensions as integer, _
		exprTB() as ASTNODE ptr, _
		byval errmsg as integer _
	)

	'' Disallow ellipsis dimensions (nicer than "ellipsis requires initializer" +
	'' "cannot initialize dynamic array" errors)
	for i as integer = 0 to dimensions - 1
		if( exprTB(i,1) = NULL ) then
			errReport( errmsg )
			'' Error recovery: Allow further use of the exprTB() as if there were no ellipsis
			exprTB(i,1) = astNewCONSTi( 0 )
		end if
	next

end sub

'':::::
private function hVarInitDefault _
	( _
		byval sym as FBSYMBOL ptr, _
		byval is_declared as integer, _
		byval has_defctor as integer _
	) as ASTNODE ptr

	function = NULL

	if( sym = NULL ) then
		exit function
	end if

	'' No default initialization for EXTERNs
	'' (they're initialized when defined by corresponding DIM)
	if( symbIsExtern( sym ) ) then
		exit function
	end if

	'' If it's marked as CONST we require it to have an initializer,
	'' because that's the only way for the coder to set the value.
	if( typeIsConst( symbGetFullType( sym ) ) ) then
		errReport( FB_ERRMSG_AUTONEEDSINITIALIZER )
		exit function
	end if

	'' Has default constructor?
	if( has_defctor ) then
		'' not already declared nor dynamic array?
		if( (not is_declared) and ((symbGetAttrib( sym ) and (FB_SYMBATTRIB_DYNAMIC or FB_SYMBATTRIB_COMMON)) = 0) ) then
			'' Check visibility to the default constructor
			if( symbCheckAccess( symbGetCompDefCtor( symbGetSubtype( sym ) ) ) = FALSE ) then
				errReport( FB_ERRMSG_NOACCESSTODEFAULTCTOR )
			end if
			function = astBuildTypeIniCtorList( sym )
		end if
	else
		'' Complain about lack of default ctor if there are others
		if( symbHasCtor( sym ) ) then
			errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
		end if
	end if

end function

'' Ensure the initializer doesn't reference any vars it mustn't
private sub hCheckVarsUsedInGlobalInit( byval sym as FBSYMBOL ptr, byref initree as ASTNODE ptr )
	'' Allow temp vars and temp array descriptors
	var ignoreattribs = FB_SYMBATTRIB_TEMP or FB_SYMBATTRIB_DESCRIPTOR

	'' Allow only non-SHARED STATICs to reference STATICs
	if( symbIsShared( sym ) = FALSE ) then
		ignoreattribs or= FB_SYMBATTRIB_STATIC
	end if

	if( astTypeIniUsesLocals( initree, ignoreattribs ) ) then
		errReport( FB_ERRMSG_INVALIDREFERENCETOLOCAL )
		astDelTree( initree )
		initree = NULL
	end if
end sub

''
'' Check whether global var initiaizer is valid.
''
'' In general, STATIC/SHARED var initializers must be constants or OFFSETs
'' (address of other global symbols), because they're emitted into .data/.bss
'' sections, and there is no code to be executed to do the initialization.
''
'' However, for vars with constructors we have to execute code to do the
'' initialization, so the initializer may just aswell be more complex (e.g.
'' function calls as arguments to the constructor call). Temp vars are ok here,
'' because they will be duplicated to the ctor call scope as needed by the
'' TYPEINI scope handling. Local non-static vars cannot be allowed, since
'' they're from a different scope
''
'' SHARED var initializers must not reference local STATICs, because those
'' symbols will be deleted by the time the global is emitted. This can only
'' happen with STATICs from the implicit main() because those from inside
'' procedures aren't visible to SHARED declarations at the toplevel. The other
'' way round (STATIC non-SHARED initializer using a non-STATIC SHARED) is ok
'' though; it will be "forward referenced" in the .asm output, because STATICs
'' are emitted before globals, but it works.
''
private sub hValidateGlobalVarInit( byval sym as FBSYMBOL ptr, byref initree as ASTNODE ptr )
	'' Not a global?
	if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or FB_SYMBATTRIB_SHARED)) = 0 ) then
		return
	end if

	'' Disallow initialization of global dynamic strings
	'' (not implemented - requires executing code)
	if( (symbGetType( sym ) = FB_DATATYPE_STRING) and (not symbIsRef( sym )) ) then
		errReport( FB_ERRMSG_CANTINITDYNAMICSTRINGS, TRUE )
		astDelTree( initree )
		initree = NULL
		return
	end if

	'' Check for constant initializer?
	'' (doing this check first, it results in a nicer error message)
	if( (not symbHasCtor( sym )) or symbIsRef( sym ) ) then
		if( astTypeIniIsConst( initree ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDCONST )
			astDelTree( initree )
			initree = NULL
			return
		end if
	end if

	'' Check var references
	hCheckVarsUsedInGlobalInit( sym, initree )
end sub

'' Build a NULL ptr deref with the given dtype:
''    *cptr(dtype ptr, 0)
private function hBuildFakeByrefInitExpr( byval dtype as integer, byval subtype as FBSYMBOL ptr ) as ASTNODE ptr
	var expr = astNewCONSTi( 0 )
	expr = astNewCONV( typeAddrOf( dtype ), subtype, expr, AST_CONVOPT_DONTCHKPTR )
	function = astNewDEREF( expr )
end function

'' resolve reference to a reference
private function hResolveRefToRefInitializer( byval dtype as integer, byval expr as ASTNODE ptr ) as ASTNODE ptr

	dim tree as ASTNODE ptr = any
	dim n as ASTNODE ptr = any

	'' if initializer expr is a REF VAR, then crawl the INITREE of the var
	'' it references for a VAR initializer.  If none found just return the
	'' original expr.

	if( expr andalso astIsDEREF( expr ) ) then
		if( expr->l andalso astIsVAR( expr->l ) ) then
			if( expr->l->sym andalso symbIsRef( expr->l->sym ) andalso symbIsVar( expr->l->sym ) ) then
				tree = expr->l->sym->var_.initree
				if( tree andalso astIsTYPEINI( tree ) ) then
					if( tree->l andalso tree->l->class = AST_NODECLASS_TYPEINI_ASSIGN ) then
						n = tree->l->l
						if( n ) then

							select case astGetClass( n )
							case AST_NODECLASS_OFFSET
								n = n->l
								if( n andalso astIsVAR( n ) ) then
									'' compatible types?
									if( astGetFullType( n ) = dtype ) then
										astDelTree( expr )
										expr = astCloneTree( n )
									end if
								end if
							end select

						end if
					end if
				end if

			end if
		end if
	end if

	function = expr

end function

private function hCheckAndBuildByrefInitializer( byval sym as FBSYMBOL ptr, byref expr as ASTNODE ptr ) as ASTNODE ptr
	'' Check data types, CONSTness, etc.
	var ok = astCheckByrefAssign( sym->typ, sym->subtype, expr )

	'' Disallow AST nodes refering to temp vars (i.e. where addrof is
	'' permitted) that aren't already disallowed in cVarOrDeref()
	ok and= (not astIsCALL( expr ))

	'' Disallow AST nodes that can't take address of
	ok and= astCanTakeAddrOf( expr )

	if( ok = FALSE ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		astDelTree( expr )
		expr = hBuildFakeByrefInitExpr( sym->typ, sym->subtype )
	else
		expr = hResolveRefToRefInitializer( sym->typ, expr )
	end if

	'' Build the TYPEINI for initializing the reference/pointer
	'' Do the implicit ADDROF due to BYREF
	var ptrdtype = typeAddrOf( sym->typ )
	var ptrsubtype = sym->subtype
	var initree = astTypeIniBegin( ptrdtype, ptrsubtype, FALSE, 0 )
	assert( astCanTakeAddrOf( expr ) )
	astTypeIniAddAssign( initree, astNewADDROF( expr ), sym, ptrdtype, ptrsubtype )
	astTypeIniEnd( initree, TRUE )

	hValidateGlobalVarInit( sym, initree )

	function = initree
end function

'':::::
private function hVarInit _
	( _
		byval sym as FBSYMBOL ptr, _
		byval isdecl as integer _
	) as ASTNODE ptr

	dim as integer attrib = any

	function = NULL

	if( sym <> NULL ) then
		attrib = symbGetAttrib( sym )
	else
		attrib = 0
	end if

	'' already declared, extern or common?
	if( isdecl or _
	    ((attrib and (FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_COMMON)) <> 0) ) then
		errReport( FB_ERRMSG_CANNOTINITEXTERNORCOMMON )
		'' error recovery: skip
		hSkipUntil( FB_TK_EOL )
		exit function
	end if

	if( fbLangOptIsSet( FB_LANG_OPT_INITIALIZER ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_INITIALIZER )
		'' error recovery: skip
		hSkipUntil( FB_TK_EOL )
		exit function
	end if

	'' '=' | '=>'
	lexSkipToken( )

	if( sym = NULL ) then
		'' error recovery: skip until next ','
		hSkipUntil( CHAR_COMMA )
		exit function
	end if

	'' Reference? Must be initialized with a var/deref, not an arbitrary initializer
	if( symbIsRef( sym ) ) then
		assert( symbIsRef( sym ) )

		var expr = cVarOrDeref( FB_VAREXPROPT_ISEXPR )
		if( expr = NULL ) then
			'' For Dim Byref, the initializer isn't optional as for normal Dim
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			hSkipStmt( )
			exit function
		end if

		return hCheckAndBuildByrefInitializer( sym, expr )
	end if

	'' ANY?
	if( lexGetToken( ) = FB_TK_ANY ) then

		'' don't allow arrays with ellipsis denoting unknown size at this time
		if( symbArrayHasUnknownBounds( sym ) ) then
			errReport( FB_ERRMSG_CANTUSEANYINITELLIPSIS )
			exit function
		end if

		'' don't allow var-len strings
		if( symbGetType( sym ) = FB_DATATYPE_STRING ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
		else
			symbSetDontInit( sym )
		end if

		'' ...or const-qualified vars
		if( typeIsConst( symbGetFullType( sym ) ) ) then
			errReport( FB_ERRMSG_AUTONEEDSINITIALIZER )
			return NULL
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )
		exit function
	end if

	var initree = cInitializer( sym, FB_INIOPT_ISINI )
	if( initree = NULL ) then
		return NULL
	end if

	hValidateGlobalVarInit( sym, initree )

	function = initree
end function

'':::::
private function hFlushDecl _
	( _
		byval var_decl as ASTNODE ptr _
	) as ASTNODE ptr

	'' respect scopes?
	if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
		function = var_decl

	'' move to function scope..
	else
		'' note: addUnscoped() won't flush the dtor list
		astAddUnscoped( var_decl )
		function = NULL
	end if

end function

private function hWrapInStaticFlag( byval code as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr t = any
	dim as FBARRAYDIM dTB(0) = any
	dim as FBSYMBOL ptr flag = any, label = any

	'' static flag as integer
	flag = symbAddVar( symbUniqueLabel( ), NULL, FB_DATATYPE_INTEGER, NULL, 0, _
	                   0, dTB(), FB_SYMBATTRIB_STATIC )
	symbSetIsImplicit( flag )
	t = astNewDECL( flag, TRUE )

	'' Since this will wrap the initialization code in an If block, we have
	'' to take special care of temp vars from the initialization
	'' expression(s). Their dtors should no longer be called at the end of
	'' the whole vardecl statement, but only on the initialization code
	'' path.
	''
	'' Expressions parsed by cVarDecl():
	''    * var initializers
	''    * array bounds (exprTB) for Redim
	''
	'' These can all have temp vars, but luckily they all belong to the
	'' initialization step, which means that we don't have to use dtor list
	'' scopes/cookies for precise control, but can safely assume that the
	'' *whole* dtor list represents these and only these expressions.
	''
	'' This is somewhat similar to astNewIIF()'s handling of true/false code
	'' paths, except that here the expression(s) aren't split up into
	'' multiple code paths, but rather "moved" into another code path as a
	'' whole. (that's another reason why it shouldn't be necessary to use
	'' dtor list scopes/cookies here)

	'' if flag = 0 then
	'' Building this branch without calling temp var dtors, because those
	'' belong to the <code>, not to this branch condition. Luckily this
	'' condition expression is trivial and won't have temp vars itself.
	label = symbAddLabel( NULL )
	t = astNewLINK( t, _
	        astBuildBranch( _
	        astNewBOP( AST_OP_EQ, astNewVAR( flag ), astNewCONSTi( 0 ) ), _
	        label, FALSE, TRUE ), AST_LINK_RETURN_NONE )

	'' flag = 1
	t = astNewLINK( t, astBuildVarAssign( flag, 1 ), AST_LINK_RETURN_NONE )

	'' <code>
	t = astNewLINK( t, code, AST_LINK_RETURN_NONE )

	'' Destroy currently registered temp vars (should be only those from the
	'' <code>) on this code path only
	t = astNewLINK( t, astDtorListFlush( ), AST_LINK_RETURN_NONE )

	'' end if
	function = astNewLINK( t, astNewLABEL( label ), AST_LINK_RETURN_NONE )
end function

private function hCallStaticCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval var_decl as ASTNODE ptr, _
		byval initree as ASTNODE ptr, _
		byval has_dtor as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr t = any, initcode = any
	dim as FBSYMBOL ptr proc = any

	assert( symbIsRef( sym ) = FALSE )

	t = hFlushDecl( var_decl )
	initcode = NULL

	if( initree ) then
		'' static var's initializer
		initcode = astTypeIniFlush( sym, initree, FALSE, AST_OPOPT_ISINI )
	end if

	if( has_dtor ) then
		'' Register an atexit() handler to call the static var's dtor
		'' at program exit.
		'' atexit( @static_proc )
		proc = astProcAddStaticInstance( sym )
		initcode = astNewLINK( initcode, rtlAtExit( astBuildProcAddrof( proc ) ), AST_LINK_RETURN_NONE )
	end if

	'' Any initialization code for a static var must be wrapped with a
	'' static flag, to ensure it'll be only executed once, not everytime the
	'' parent procedure is called.
	if( initcode ) then
		t = astNewLINK( t, hWrapInStaticFlag( initcode ), AST_LINK_RETURN_NONE )
	end if

	function = t
end function

'':::::
private function hCallGlobalCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval var_decl as ASTNODE ptr, _
		byval initree as ASTNODE ptr, _
		byval has_dtor as integer _
	) as ASTNODE ptr

	assert( symbIsRef( sym ) = FALSE )

	var_decl = hFlushDecl( var_decl )

	if( (initree <> NULL) or has_dtor ) then
		astProcAddGlobalInstance( sym, initree, has_dtor )
	end if

	'' No temp dtors should be left registered after the TYPEINI build-up
	assert( astDtorListIsEmpty( ) )

	'' cannot call astAdd() before deleting the dtor list or it
	'' would be flushed
	function = var_decl

end function

'':::::
private function hFlushInitializer _
	( _
		byval sym as FBSYMBOL ptr, _
		byval var_decl as ASTNODE ptr, _
		byval initree as ASTNODE ptr, _
		byval has_dtor as integer _
	) as ASTNODE ptr

	'' object?
	if( has_dtor and (not symbIsRef( sym )) ) then
		'' Check visibility of the destructor
		if( symbCheckAccess( symbGetCompDtor1( symbGetSubtype( sym ) ) ) = FALSE ) then
			errReport( FB_ERRMSG_NOACCESSTODTOR )
		end if
	end if

	'' no initializer?
	if( initree = NULL ) then
		'' static or shared?
		if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
		                               FB_SYMBATTRIB_SHARED or _
		                               FB_SYMBATTRIB_COMMON)) <> 0 ) then
			'' object?
			if( has_dtor ) then
				'' local?
				if( symbIsLocal( sym ) ) then
					var_decl = hCallStaticCtor( sym, var_decl, NULL, TRUE )

				'' global..
				else
					var_decl = hCallGlobalCtor( sym, var_decl, NULL, TRUE )
				end if
			end if
		end if

		return var_decl
	end if

	'' not static or shared?
	if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
	                               FB_SYMBATTRIB_SHARED or _
	                               FB_SYMBATTRIB_COMMON)) = 0 ) then

		var_decl = hFlushDecl( var_decl )

		return astNewLINK( var_decl, astTypeIniFlush( sym, initree, FALSE, AST_OPOPT_ISINI ), AST_LINK_RETURN_NONE )
	end if

	'' not an object?
	if( symbIsRef( sym ) or (not symbHasCtor( sym )) ) then
		'' No constructor call needed
		'' let emit flush it..
		symbSetTypeIniTree( sym, initree )

		'' no dtor?
		if( symbIsRef( sym ) or (not has_dtor) ) then
			return hFlushDecl( var_decl )
		end if

		'' must be added to the dtor list..
		initree = NULL
	end if

	'' Need to call constructor and/or destructor

	'' local?
	if( symbIsLocal( sym ) ) then
		'' the only possibility is static, SHARED can't be
		'' used in -lang fb..
		function = hCallStaticCtor( sym, var_decl, initree, has_dtor )

	'' global.. add to the list, to be emitted later
	else
		function = hCallGlobalCtor( sym, var_decl, initree, has_dtor )
	end if

end function

private function hIdxInParensOnlyExpr( ) as ASTNODE ptr
	dim as integer old_idxinparensonly = any

	old_idxinparensonly = fbGetIdxInParensOnly( )
	fbSetIdxInParensOnly( TRUE )

	function = cExpressionWithNIDXARRAY( TRUE )

	fbSetIdxInParensOnly( old_idxinparensonly )
end function

private function hCheckDynamicArrayExpr( byval varexpr as ASTNODE ptr ) as ASTNODE ptr
	if( varexpr andalso astIsNIDXARRAY( varexpr ) ) then
		varexpr = astRemoveNIDXARRAY( varexpr )

		if( astIsVAR( varexpr ) or astIsFIELD( varexpr ) ) then
			if( symbIsVar( varexpr->sym ) or symbIsField( varexpr->sym ) ) then
				if( symbGetIsDynamic( varexpr->sym ) ) then
					return varexpr
				end if
			end if
		end if
	end if

	errReport( FB_ERRMSG_EXPECTEDDYNAMICARRAY, TRUE )
	astDelTree( varexpr )
	function = NULL
end function

private sub hErrorDefTypeNotAllowed _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint _
	)

	errReportNotAllowed( FB_LANG_OPT_DEFTYPE, FB_ERRMSG_DEFTYPEONLYVALIDINLANG )

	'' error recovery: fake a type
	dtype = FB_DATATYPE_INTEGER
	subtype = NULL
	lgt = symbCalcLen( dtype, subtype )

end sub

private function hMaybeBuildFieldAccess _
	( _
		byval fld as FBSYMBOL ptr, _
		byval is_redim as integer _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr thisparam = any

	if( is_redim = FALSE ) then
		exit function
	end if

	if( symbIsMethod( parser.currproc ) = FALSE ) then
		exit function
	end if

	thisparam = symbGetProcHeadParam( parser.currproc )
	if( thisparam = NULL ) then
		exit function
	end if

	function = astBuildVarField( symbGetParamVar( thisparam ), fld )
end function

''
'' VarDecl =
''     SingleVarDecl (',' SingleVarDecl)*
''   | [BYREF] AS DataType MultVarDecl (',' MultVarDecl)*
''
'' SingleVarDecl = [BYREF] Identifier ['(' ArrayDimensions ')'] [AS SymbolType] ['=' VarInitializer]
''
'' MultVarDecl = Identifier ['(' ArrayDimensions ')'] ['=' VarInitializer]
''
function cVarDecl _
	( _
		byval baseattrib as FB_SYMBATTRIB, _
		byval dopreserve as integer, _
		byval token as integer, _
		byval is_fordecl as integer _
	) as FBSYMBOL ptr

	static as zstring * FB_MAXNAMELEN+1 id
	static as ASTNODE ptr exprTB(0 to FB_MAXARRAYDIMS-1, 0 to 1)
	static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr sym = any, subtype = any, parent = any
	dim as ASTNODE ptr varexpr = any, initree = any, redimcall = any
	dim as integer addsuffix = any, is_multdecl = any, have_bounds = any
	dim as integer is_typeless = any, is_declared = any, is_redim = any
	dim as integer dtype = any, maybe_expr = any
	dim as longint lgt = any
	dim as integer dimensions = any, suffix = any
	dim as zstring ptr palias = any
	dim as ASTNODE ptr assign_initree = any
	dim as FB_IDOPT options = any

	function = NULL

	'' inside a namespace but outside a proc?
	if( symbIsGlobalNamespc( ) = FALSE ) then
		if( fbIsModLevel( ) ) then
			'' variables will be always shared..
			baseattrib or= FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
		end if
	end if

	'' BYREF?
	var has_byref_at_start = hMatch( FB_TK_BYREF, LEXCHECK_POST_SUFFIX )

	'' (AS SymbolType)?
	is_multdecl = FALSE
	if( lexGetToken( ) = FB_TK_AS ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' parse the symbol type (INTEGER, STRING, etc...)
		hSymbolType( dtype, subtype, lgt, has_byref_at_start )

		if( has_byref_at_start = FALSE ) then
			'' Disallow creating objects of abstract classes
			hComplainIfAbstractClass( dtype, subtype )
		end if

		hMaybeComplainTypeUsage( dtype, subtype, lgt )

		addsuffix = FALSE
		is_multdecl = TRUE
		if( has_byref_at_start ) then
			has_byref_at_start = FALSE
			baseattrib or= FB_SYMBATTRIB_REF
		end if
	end if

	do
		dim as integer attrib = baseattrib

		if( is_multdecl = FALSE ) then
			'' 1st SingleVarDecl has BYREF?
			if( has_byref_at_start ) then
				has_byref_at_start = FALSE
				attrib or= FB_SYMBATTRIB_REF
			'' additional SingleVarDecl has BYREF?
			elseif( hMatch( FB_TK_BYREF, LEXCHECK_POST_SUFFIX ) ) then
				attrib or= FB_SYMBATTRIB_REF
			end if
		end if

		'' Some code below needs to differentiate between "new variable declaration" and "redim";
		'' however this isn't always accurate. For example, a REDIM statement can act as a variable
		'' declaration, but we won't know until the array dimensions have been parsed. Before that,
		'' is_redim will be inaccurate.
		is_redim = (token = FB_TK_REDIM) and ((attrib and FB_SYMBATTRIB_SHARED) = 0)

		parent = cParentId( FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT or FB_IDOPT_ISVAR or _
		                    iif( is_redim, 0, FB_IDOPT_ISDECL ) or _
		                    FB_IDOPT_ISDEFN )

		''
		'' Ambiguity: If this is a REDIM, it can either redim an existing
		'' array or declare a new one. It can be given just an identifier
		'' (potentially with a parent namespace prefix), or a whole
		'' expression, in case of redim'ing a dynamic array field.
		''
		'' Identifiers:
		''    REDIM array(0 to 1)
		''    REDIM namespace1.namespace2.array(0 to 1)
		''    REDIM MyClass.staticarray(0 to 1)
		'' Expressions:
		''    REDIM this.array(0 to 1)
		''    REDIM udtvar.array(0 to 1)
		''    REDIM udtptr->array(0 to 1)
		''    REDIM (udtptr[10].array)(0 to 1)
		'' (and more complex expressions are possible too)
		''
		'' How to know whether to parse an identifier or an expression?
		'' Must use look-ahead and make a guess.
		''

		'' REDIM? No parent namespace prefix?
		varexpr = NULL
		if( is_redim and (parent = NULL) ) then
			'' Looks like an expression?
			'' '(foo' instead of 'foo' must be an expression.
			'' 'foo(' indicates 'foo(1 to 2)', but 'foo' followed by
			'' anything else indicates an expression too, e.g.
			'' 'foo.bar' or 'foo->bar' or 'foo[bar]'. Unless it's
			'' an AS or EOL that's following.
			'' Note: namespace prefix was parsed above already.

			maybe_expr = FALSE
			if( lexGetToken( ) = CHAR_LPRNT ) then
				maybe_expr = TRUE
			else
				select case( lexGetLookAhead( 1 ) )
				case CHAR_LPRNT, CHAR_COMMA, FB_TK_AS, FB_TK_STMTSEP, FB_TK_EOL, FB_TK_EOF

				case else
					maybe_expr = TRUE
				end select
			end if

			if( maybe_expr ) then
				varexpr = hCheckDynamicArrayExpr( hIdxInParensOnlyExpr( ) )
			end if
		end if

		'' Parse symbol identifier, or retrieve it from the expression parsed above
		if( varexpr ) then
			chain_ = NULL
			id = *symbGetName( varexpr->sym )
			suffix = FB_DATATYPE_INVALID
		else
			chain_ = hGetId( parent, @id, suffix, is_redim )
		end if

		is_typeless = FALSE

		if( is_multdecl = FALSE ) then
			dtype = suffix
			subtype = NULL
			lgt = symbCalcLen( dtype, subtype )
			addsuffix = (suffix <> FB_DATATYPE_INVALID)
		else
			'' the user did 'DIM AS _____', and then
			'' specified a suffix on a symbol, e.g.
			''
			'' DIM AS INTEGER x, y$
			if( suffix <> FB_DATATYPE_INVALID ) then
				errReportEx( FB_ERRMSG_SYNTAXERROR, @id )
				'' error recovery: the symbol gets the
				'' type specified 'AS'
				suffix = FB_DATATYPE_INVALID
			end if
		end if

		'' ('(' ArrayDecl? ')')?
		dimensions = 0
		have_bounds = FALSE
		if( (lexGetToken( ) = CHAR_LPRNT) and (is_fordecl = FALSE) ) then
			if( attrib and FB_SYMBATTRIB_REF ) then
				errReport( FB_ERRMSG_ARRAYOFREFS )
				attrib and= not FB_SYMBATTRIB_REF
			end if
			lexSkipToken( )

			'' '()'
			if( lexGetToken( ) = CHAR_RPRNT ) then
				'' Dynamic array; dimension count unknown until
				'' first array access or REDIM (see also
				'' symbSetDynamicArrayDimensions())
				dimensions = -1
				attrib or= FB_SYMBATTRIB_DYNAMIC

			'' '(' ArrayDecl ')'
			else
				cArrayDecl( dimensions, have_bounds, exprTB() )
				if( have_bounds ) then
					'' COMMON or dynamic EXTERN (can happen due to OPTION DYNAMIC)?
					'' No exact bounds allowed, just like they can't have initializers either.
					'' (but they can have fixed dimensions)
					if( ((attrib and FB_SYMBATTRIB_COMMON) <> 0) or _
					    (((attrib and FB_SYMBATTRIB_EXTERN) <> 0) and _
					    ((attrib and FB_SYMBATTRIB_DYNAMIC) <> 0)) ) then
						errReport( FB_ERRMSG_DYNAMICEXTERNCANTHAVEBOUNDS )
						dimensions = -1
						have_bounds = FALSE
					end if
				else
					attrib or= FB_SYMBATTRIB_DYNAMIC
				end if
			end if

			'' ')'
			if( lexGetToken( ) <> CHAR_RPRNT ) then
				errReport( FB_ERRMSG_EXPECTEDRPRNT )
			else
				lexSkipToken( )
			end if

		'' REDIM? Must have array dimensions
		elseif( token = FB_TK_REDIM ) then
			errReportEx( FB_ERRMSG_EXPECTEDARRAY, @id )
			dimensions = -1

		'' Scalar, no array subscripts
		else
			'' (could have been added due to OPTION DYNAMIC,
			'' but if it's not an array, then it can't be DYNAMIC)
			attrib and= not FB_SYMBATTRIB_DYNAMIC
		end if

		'' Update is_redim now that we've parsed the array bounds, if any.
		'' It's only a true redim if array bounds are given. If it's not an array,
		'' or dimensions were given without bounds, then it can't be a redim.
		is_redim and= have_bounds

		palias = NULL
		if( (attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN)) <> 0 ) then
			'' [ALIAS "id"]
			palias = cAliasAttribute()
		end if

		'' Data type
		if( is_multdecl = FALSE ) then
			'' (AS SymbolType)?
			if( lexGetToken( ) = FB_TK_AS ) then
				'' Suffix? Cannot have both suffix and 'AS DataType'
				if( dtype <> FB_DATATYPE_INVALID ) then
					errReport( FB_ERRMSG_SYNTAXERROR )
					dtype = FB_DATATYPE_INVALID
				end if

				lexSkipToken( LEXCHECK_POST_SUFFIX )

				var is_ref = ((attrib and FB_SYMBATTRIB_REF) <> 0)

				'' parse the symbol type (INTEGER, STRING, etc...)
				hSymbolType( dtype, subtype, lgt, is_ref )

				if( is_ref = FALSE ) then
					'' Disallow creating objects of abstract classes
					hComplainIfAbstractClass( dtype, subtype )
				end if

				hMaybeComplainTypeUsage( dtype, subtype, lgt )

				addsuffix = FALSE

			'' No explicit 'AS DataType', and no suffix?
			elseif( dtype = FB_DATATYPE_INVALID ) then
				'' Only allowed if DEF* is allowed, or if it's a
				'' redim because then it can use the dtype of
				'' the existing array.

				'' Try DEF*
				if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) ) then
					dtype = symbGetDefType( id )
					subtype = NULL
					lgt = symbCalcLen( dtype, subtype )
					addsuffix = TRUE
				end if

				'' Potential redim, not just a variable declaration?
				if( is_redim ) then
					'' Typeless REDIM, don't know until after lookup
					is_typeless = TRUE
				else
					'' Must have some dtype before lookup
					if( dtype = FB_DATATYPE_INVALID ) then
						hErrorDefTypeNotAllowed( dtype, subtype, lgt )
					end if
				end if
			end if
		end if

		if( varexpr ) then
			sym = varexpr->sym
		else
			sym = hLookupVarAndCheckParent( parent, chain_, dtype, is_typeless, _
			                                (suffix <> FB_DATATYPE_INVALID), _
			                                is_redim )

			if( sym ) then
				'' If it's an existing field, then we must be inside a method,
				'' and the field was accessed via implicit THIS.
				if( symbIsField( sym ) ) then
					'' Build an expression that can be used for REDIM
					varexpr = hMaybeBuildFieldAccess( sym, is_redim )
					if( varexpr ) then
						'' But ensure to only allow this with dynamic array fields
						varexpr = hCheckDynamicArrayExpr( astNewNIDXARRAY( varexpr ) )
					else
						'' Forget the field if it can't be accessed
						sym = NULL
					end if
				end if
			end if
		end if

		'' typeless REDIM?
		if( is_typeless ) then
			if( sym ) then
				if( symbIsArray( sym ) ) then
					'' REDIM'ing existing symbol, uses the same dtype
					dtype = symbGetType( sym )
					subtype = symbGetSubtype( sym )
					lgt = symbGetLen( sym )
					if( symbIsDynamic( sym ) = FALSE ) then
						'' if it's a parameter, we won't know if it's dynamic or not until run-time
						if( symbIsParamVarByDesc( sym ) = FALSE ) then
							errReportEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, @id )
						end if
					end if
				else
					'' -lang fb: typeless REDIM without pre-existing array not allowed
					hErrorDefTypeNotAllowed( dtype, subtype, lgt )
				end if
			elseif( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) ) then
				'' DEF* is allowed, so typeless REDIM defaults to the default type
				'' (can just keep using the deftype set above)
				assert( dtype = symbGetDefType( id ) )
				assert( subtype = NULL )
				assert( lgt = symbCalcLen( dtype, subtype ) )
			else
				'' -lang fb: typeless REDIM without pre-existing array not allowed
				hErrorDefTypeNotAllowed( dtype, subtype, lgt )
			end if
		end if

		if( have_bounds ) then
			'' QB quirk: when the symbol was defined already by a preceeding COMMON
			'' statement, then a DIM will work the same way as a REDIM
			if( token = FB_TK_DIM ) then
				if( (attrib and FB_SYMBATTRIB_DYNAMIC) = 0 ) then
					if( sym <> NULL ) then
						if( symbIsCommon( sym ) ) then
							if( symbGetArrayDimensions( sym ) <> 0 ) then
								attrib or= FB_SYMBATTRIB_DYNAMIC
								is_redim = TRUE
							end if
						end if
					end if
				end if
			end if

			hMaybeConvertExprTb2DimTb( attrib, dimensions, exprTB(), dTB() )

			if( attrib and FB_SYMBATTRIB_DYNAMIC ) then
				hComplainAboutEllipsis( dimensions, exprTB(), FB_ERRMSG_DYNAMICARRAYWITHELLIPSIS )
			else
				'' "array too big/huge array on stack" check
				if( symbCheckArraySize( dimensions, @dTB(0), lgt, _
				    ((attrib and (FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC)) = 0) ) = FALSE ) then
					errReport( FB_ERRMSG_ARRAYTOOBIG )
					'' error recovery: use small array
					dimensions = 1
					dTB(0).lower = 0
					dTB(0).upper = 0
				end if
			end if
		elseif( dimensions = 0 ) then
			'' "huge variable on stack" check
			if( ((attrib and (FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC)) = 0) and _
			    (lgt > env.clopt.stacksize) ) then
				errReportWarn( FB_WARNINGMSG_HUGEVARONSTACK )
			end if
		end if

		'' don't allow COMMON object instances
		if( attrib and FB_SYMBATTRIB_COMMON ) then
			if( typeHasCtor( dtype, subtype ) or typeHasDtor( dtype, subtype ) ) then
				errReport( FB_ERRMSG_COMMONCANTBEOBJINST, TRUE )
			end if
		end if

		if( attrib and FB_SYMBATTRIB_DYNAMIC ) then
			'' DIM'ing dynamic arrays requires a REDIM, check whether code is allowed
			'' (for REDIM's this check was already done by cVariableDecl())
			if( have_bounds and (token <> FB_TK_REDIM) ) then
				if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
					hSkipStmt( )
					exit function
				end if
			end if

			if( sym ) then
				hComplainAboutConstDynamicArray( sym )
			end if
		end if

		''
		'' Declare the new variable or complain about duplicate
		'' definition, etc.
		''
		sym = hAddVar( sym, parent, id, palias, dtype, subtype, lgt, addsuffix, _
		               attrib, dimensions, have_bounds, dTB(), token )

		dim as integer has_defctor = FALSE, has_dtor = FALSE
		if( sym <> NULL ) then
			'' Treat dynamic array fields as "already declared",
			'' because we don't want to emit DECL nodes for them below.
			is_declared = iif( symbIsField( sym ), TRUE, symbGetIsDeclared( sym ) )
			has_defctor = symbHasDefCtor( sym )
			has_dtor = symbHasDtor( sym )
		else
			is_declared = FALSE
		end if

		''
		'' Check for an initializer
		''

		if( is_fordecl = FALSE ) then
			'' assume no assignment
			assign_initree = NULL

			'' '=' | '=>' ?
			if( hIsAssignToken( lexGetToken( ) ) ) then
				initree = hVarInit( sym, is_declared )

				if( ( initree <> NULL ) and ( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) ) then
					'' local?
					if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
					                               FB_SYMBATTRIB_SHARED or _
					                               FB_SYMBATTRIB_COMMON)) = 0 ) then

						''
						'' The variable will be unscoped, i.e. it needs a default initree
						'' for the implicit declaration at procedure level, plus the assignment
						'' with the initializer in the nested scope where it was defined.
						''
						''      scope
						''          dim as integer i = 5
						''      end scope
						''
						''  becomes:
						''
						''      dim as integer i
						''      scope
						''          i = 5
						''      end scope
						''
						assign_initree = initree
						initree = hVarInitDefault( sym, is_declared, has_defctor )
					end if
				end if
			else
				'' default initialization
				if( sym ) then
					'' Allocating a Byref variable? Always requires an explicit initializer
					if( (not symbIsExtern( sym )) and symbIsRef( sym ) ) then
						errReport( FB_ERRMSG_MISSINGREFINIT )
						hSkipStmt( )
						exit function
					end if

					if( symbArrayHasUnknownBounds( sym ) ) then
						errReport( FB_ERRMSG_MUSTHAVEINITWITHELLIPSIS )
						hSkipStmt( )
						exit function
					end if
				end if

				initree = hVarInitDefault( sym, is_declared, has_defctor )
			end if
		else
			initree = NULL
			assign_initree = NULL
		end if

		''
		'' Add to AST: DECL nodes, initialization code, REDIMs.
		'' Nothing to do for EXTERNs.
		''
		if( sym <> NULL ) then
			if( token <> FB_TK_EXTERN ) then
				'' Build a LINK'ed tree of all code that should
				'' be astAdd'ed here in place of the vardecl.
				'' (early astAdd's would cause problems with temp var dtors)
				dim t as ASTNODE ptr

				'' not declared already?
				if( is_declared = FALSE ) then
					dim as FBSYMBOL ptr desc = NULL

					'' Don't init if it's a temp FOR var, it will
					'' have the start condition put into it.
					t = astNewDECL( sym, ((initree = NULL) and (not is_fordecl)) )

					'' add the descriptor too, if any
					desc = symbGetArrayDescriptor( sym )
					if( desc <> NULL ) then
						'' Note: descriptor may not have an initree here, in case it's COMMON
						'' FIXME: should probably not add DECL nodes for COMMONs/SHAREDs in the first place (not done for EXTERNs either)
						t = astNewLINK( t, astNewDECL( desc, (symbGetTypeIniTree( desc ) = NULL) ), AST_LINK_RETURN_NONE )
					end if

					'' handle arrays (must be done after adding the decl node)
					if( ((attrib and FB_SYMBATTRIB_DYNAMIC) <> 0) or (dimensions > 0) ) then
						'' local?
						if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
						                               FB_SYMBATTRIB_SHARED or _
						                               FB_SYMBATTRIB_COMMON)) = 0 ) then

							'' flush the decl node, safe to do here as it's a non-static
							'' local var (and because the decl must be flushed first)
							t = hFlushDecl( t )

							'' bydesc array params have no descriptor
							if( desc <> NULL ) then
								'' Initialize the array descriptor
								'' * This should be added to the variable declaration because it belongs to that,
								''   even if unscoped, more so than to the array's own initializer.
								'' * This must be LINK'ed to avoid astAdd() which would destroy temp vars from the
								''   array initializer too early.
								t = astNewLINK( t, astTypeIniFlush( desc, symbGetTypeIniTree( desc ), FALSE, AST_OPOPT_ISINI ), AST_LINK_RETURN_NONE )
								symbSetTypeIniTree( desc, NULL )
							end if
						end if
					end if

					'' all set as declared
					symbSetIsDeclared( sym )

					if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
						'' flush the init tree (must be done after adding the decl node)
						t = hFlushInitializer( sym, t, initree, has_dtor )
					'' unscoped
					else
						'' flush the init tree (must be done after adding the decl node)
						astAddUnscoped( hFlushInitializer( sym, t, initree, has_dtor ) )
						t = NULL

						'' initializer as assignment?
						if( assign_initree ) then
							'' clear it before it's initialized?
							if( symbGetVarHasDtor( sym ) ) then
								t = astNewLINK( t, astBuildVarDtorCall( sym, TRUE ), AST_LINK_RETURN_NONE )
							end if

							'' use the initializer as an assignment
							t = astNewLINK( t, astTypeIniFlush( sym, assign_initree, FALSE, AST_OPOPT_ISINI ), AST_LINK_RETURN_NONE )
						end if
					end if
				end if

				'' Dynamic array? If the dimensions are known, redim it.
				if( ((attrib and FB_SYMBATTRIB_DYNAMIC) <> 0) and have_bounds ) then
					if( varexpr = NULL ) then
						varexpr = astNewVAR( sym )
					end if
					redimcall = rtlArrayRedim( varexpr, dimensions, exprTB(), _
					                           dopreserve, (not symbGetDontInit( sym )) )

					'' If this is a local STATIC (not SHARED/COMMON) array declaration (and not
					'' a typeless REDIM), then the redim call should be executed only once, not
					'' during every call to the parent procedure.
					if( symbIsStatic( sym ) and symbIsLocal( sym ) and _
					    ((symbGetAttrib( sym ) and (FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_COMMON)) = 0) and _
					    (not is_declared) ) then
						redimcall = hWrapInStaticFlag( redimcall )
					end if

					t = astNewLINK( t, redimcall, AST_LINK_RETURN_NONE )
				end if

				astAdd( t )
			end if
		end if

		if( is_fordecl ) then
			return sym
		end if

		'' (',' SymbolDef)*
		if( lexGetToken( ) <> CHAR_COMMA ) then
			exit do
		end if

		lexSkipToken( )
	loop

	'' result unused, except by FOR loops, but that's RETURN'ed above
end function

'' look for ... followed by ')', ',' or TO
private function hMatchEllipsis( ) as integer
	function = FALSE

	if( lexGetToken( ) = CHAR_DOT ) then
		if( lexGetLookAhead( 1 ) = CHAR_DOT ) then
			if( lexGetLookAhead( 2 ) = CHAR_DOT ) then
				select case lexGetLookAhead( 3 )
					case CHAR_COMMA, CHAR_RPRNT, FB_TK_TO
						function = TRUE
						' Skip the dots
						lexSkipToken( )
						lexSkipToken( )
						lexSkipToken( )
				end select
			end if
		end if
	end if
end function

private function hIntExpr( byval defaultexpr as ASTNODE ptr ) as ASTNODE ptr
	dim as ASTNODE ptr expr = any, intexpr = any

	expr = cExpression( )

	if( expr ) then
		'' expression must be integral (no strings, etc.)
		intexpr = astNewCONV( FB_DATATYPE_INTEGER, NULL, expr )
		if( intexpr ) then
			expr = intexpr
		else
			errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
			astDelTree( expr )
			expr = NULL
		end if
	else
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an expr
		if( lexGetToken( ) <> FB_TK_TO ) then
			hSkipUntil( CHAR_COMMA )
		end if
	end if

	if( expr = NULL ) then
		if( defaultexpr ) then
			expr = astCloneTree( defaultexpr )
		else
			expr = astNewCONSTi( env.opt.base )
		end if
	end if

	function = expr
end function

''
'' ArrayDimension =
''    Expression [TO Expression]
''
private sub cArrayDimension( byref dimensions as integer, exprTB() as ASTNODE ptr )
	'' 1st expression: lbound or ubound
	'' (depends on whether there's a TO and a 2nd expression following)
	if( hMatchEllipsis( ) ) then
		exprTB(dimensions,0) = NULL
	else
		'' Expression
		exprTB(dimensions,0) = hIntExpr( NULL )
	end if

	'' TO
	if( lexGetToken( ) = FB_TK_TO ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' lbound can't be unknown
		if( exprTB(dimensions,0) = NULL ) then
			errReport( FB_ERRMSG_CANTUSEELLIPSISASLOWERBOUND )
			exprTB(dimensions,0) = astNewCONSTi( 0 )
		end if

		'' ubound
		if( hMatchEllipsis( ) ) then
			exprTB(dimensions,1) = NULL
		else
			'' Expression
			exprTB(dimensions,1) = hIntExpr( exprTB(dimensions,0) )
		end if
	else
		'' 1st expression was ubound, not lbound
		exprTB(dimensions,1) = exprTB(dimensions,0)
		exprTB(dimensions,0) = astNewCONSTi( env.opt.base )
	end if
end sub

''
'' PlaceHolder =
''    ANY
''
'' ArrayDecl =
''    '(' ArrayDimension (',' ArrayDimension)* ')'
''  | '(' PlaceHolder (',' PlaceHolder)* ')'
''
''
'' Examples:
''    (0 to 0)            => dimensions = 1, have_bounds = TRUE
''    (0 to 0, 0 to 0)    => dimensions = 2, have_bounds = TRUE
''    (ANY)               => dimensions = 1, have_bounds = FALSE
''    (ANY, ANY)          => dimensions = 2, have_bounds = FALSE
''
sub cArrayDecl _
	( _
		byref dimensions as integer, _
		byref have_bounds as integer, _
		exprTB() as ASTNODE ptr _
	)

	dimensions = 0
	have_bounds = TRUE

	do
		if( dimensions >= FB_MAXARRAYDIMS ) then
			errReport( FB_ERRMSG_TOOMANYDIMENSIONS )
			'' error recovery: skip to next ')'
			hSkipUntil( CHAR_RPRNT )
			exit do
		end if

		'' 'ANY'? (only if no ArrayDimension seen yet, or had others
		'' previously)
		if( (lexGetToken( ) = FB_TK_ANY) and _
		    ((dimensions = 0) or (have_bounds = FALSE)) ) then
			have_bounds = FALSE
			lexSkipToken( LEXCHECK_POST_SUFFIX )
		elseif( have_bounds = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDANY )
		else
			cArrayDimension( dimensions, exprTB() )
		end if

		dimensions += 1

		'' ','?
	loop while( hMatch( CHAR_COMMA ) )
end sub

private function hBuildAutoVarInitializer( byval sym as FBSYMBOL ptr, byval expr as ASTNODE ptr ) as ASTNODE ptr
	'' build a ini-tree
	var initree = astTypeIniBegin( sym->typ, sym->subtype, symbIsLocal( sym ) )

	'' not an object?
	if( symbHasCtor( sym ) = FALSE ) then
		astTypeIniAddAssign( initree, expr, sym )
	'' handle constructors..
	else
		dim as integer is_ctorcall = any
		expr = astBuildImplicitCtorCallEx( sym, expr, cBydescArrayArgParens( expr ), is_ctorcall )

		if( expr <> NULL ) then
			if( is_ctorcall ) then
				astTypeIniAddCtorCall( initree, sym, expr )
			else
				'' no proper ctor, try an assign
				astTypeIniAddAssign( initree, expr, sym )
			end if
		end if
	end if

	astTypeIniEnd( initree, TRUE )
	function = initree
end function

private function hCheckAndBuildAutoVarInitializer( byval sym as FBSYMBOL ptr, byval expr as ASTNODE ptr ) as ASTNODE ptr
	var initree = hBuildAutoVarInitializer( sym, expr )
	hValidateGlobalVarInit( sym, initree )
	return initree
end function

''
'' AutoVar =
''    SymbolDef '=' Initializer
''
'' AutoVarDecl =
''    VAR [SHARED] AutoVar (',' AutoVar)*
''
private sub cAutoVarDecl( byval baseattrib as FB_SYMBATTRIB )
	static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
	static as zstring * FB_MAXNAMELEN+1 id
	dim as FBSYMBOL ptr parent = any, sym = any

	'' allowed?
	if( fbLangOptIsSet( FB_LANG_OPT_AUTOVAR ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_AUTOVAR, FB_ERRMSG_AUTOVARONLYVALIDINLANG )
		'' error recovery: skip stmt
		hSkipStmt( )
		return
	end if

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipStmt( )
		exit sub
	end if

	'' VAR
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' SHARED?
	if( lexGetToken( ) = FB_TK_SHARED ) then
		'' can't use SHARED inside a proc
		if( hCheckScope( ) = FALSE ) then
			'' error recovery: don't make it shared
			baseattrib or= FB_SYMBATTRIB_STATIC
		else
			baseattrib or= FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
		end if
		lexSkipToken( LEXCHECK_POST_SUFFIX )
	end if

	'' this proc static?
	if( symbGetProcStaticLocals( parser.currproc ) ) then
		baseattrib or= FB_SYMBATTRIB_STATIC
	end if

	'' inside a namespace but outside a proc?
	if( symbIsGlobalNamespc( ) = FALSE ) then
		if( fbIsModLevel( ) ) then
			'' variables will be always shared..
			baseattrib or= FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
		end if
	end if

	do
		var attrib = baseattrib

		'' BYREF?
		if( hMatch( FB_TK_BYREF, LEXCHECK_POST_SUFFIX ) ) then
			attrib or= FB_SYMBATTRIB_REF
		end if

		'' id.id? if not, NULL
		parent = cParentId( FB_IDOPT_DEFAULT or FB_IDOPT_ISDECL or _
		                    FB_IDOPT_ALLOWSTRUCT or FB_IDOPT_ISVAR or _
		                    FB_IDOPT_ISDEFN)

		'' get id
		dim as integer suffix = any
		dim as FBSYMCHAIN ptr chain_ = hGetId( parent, @id, suffix, FALSE )

		if( suffix <> FB_DATATYPE_INVALID ) then
			errReportEx( FB_ERRMSG_SYNTAXERROR, @id )
		end if

		'' array? rejected.
		if( lexGetToken( ) = CHAR_LPRNT ) then
			errReport( FB_ERRMSG_TYPEMISMATCH )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if

		sym = hLookupVarAndCheckParent( parent, chain_, FB_DATATYPE_INVALID, _
		                                TRUE, FALSE, FALSE )

		'' '=' | '=>' ?
		if( cAssignToken( ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDEQ )
		end if

		'' Parse initializer expression
		'' (before adding the symbol, so that it can't be used in the initializer)
		dim expr as ASTNODE ptr
		var is_byref = (attrib and FB_SYMBATTRIB_REF) orelse (sym andalso symbIsRef( sym ))
		if( is_byref ) then
			'' Reference; must be initialized with a var/deref, not an arbitrary expression
			expr = cVarOrDeref( FB_VAREXPROPT_ISEXPR )
		else
			expr = cExpression( )
		end if
		if( expr = NULL ) then
			errReport( FB_ERRMSG_AUTONEEDSINITIALIZER )
			hSkipStmt( )
			'' error recovery: build an expression with a simple dtype
			if( is_byref ) then
				expr = hBuildFakeByrefInitExpr( FB_DATATYPE_INTEGER, NULL )
			else
				expr = astNewCONSTi( 0 )
			end if
		end if

		'' Determine var's dtype based on the initializer expression
		var dtype = expr->dtype
		var subtype = expr->subtype

		if( is_byref = FALSE ) then
			select case( typeGetDtAndPtrOnly( dtype ) )
			case FB_DATATYPE_WCHAR
				'' wstrings: can't make a "wstring variable" to hold this expression,
				'' because 1) we don't have dynamic wstrings yet, and 2) we can't use
				'' a fixed-length wstring because we don't know the length (it may not
				'' even be constant).
				'' TODO: could allow VAR initialized with a wstring literal, then the length is known
				errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
				'' error recovery: create a fake expression
				astDelTree( expr )
				expr = astNewCONSTi( 0 )
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL

			case FB_DATATYPE_CHAR, FB_DATATYPE_FIXSTR
				'' zstring: create a dynamic string variable to hold the zstring data
				dtype = FB_DATATYPE_STRING

			end select
		end if

		'' For function pointers, the expression's subtype should be one of the special PROCs created by
		'' symbAddProcPtr(), not a normal procedure symbol (e.g. in a case like "VAR foo = @myproc"), to
		'' ensure the new function pointer var uses the same procptr subtype symbol as any other compatible
		'' procptrs in the scope, allowing them to be seen as compatible. astNewVAR() should have done the
		'' symbAddProcPtrFromFunction() if it was needed already.
		assert( iif( typeGetDtOnly( dtype ) = FB_DATATYPE_FUNCTION, symbGetIsFuncPtr( subtype ), TRUE ) )

		'' add var after parsing the expression, or the the var itself could be used
		sym = hAddVar( sym, parent, id, NULL, dtype, subtype, _
		               symbCalcLen( dtype, subtype ), FALSE, attrib, 0, FALSE, dTB(), FB_TK_VAR )

		if( sym <> NULL ) then
			if( symbIsRef( sym ) ) then
				expr = hCheckAndBuildByrefInitializer( sym, expr )
			else
				expr = hCheckAndBuildAutoVarInitializer( sym, expr )
			end if

			'' add to AST
			dim as ASTNODE ptr var_decl = astNewDECL( sym, FALSE )

			'' set as declared
			symbSetIsDeclared( sym )

			'' flush the init tree (must be done after adding the decl node)
			astAdd( hFlushInitializer( sym, var_decl, expr, symbHasDtor( sym ) ) )
		end if

		'' (',' SymbolDef)*
		if( lexGetToken( ) <> CHAR_COMMA ) then
			exit do
		end if

		lexSkipToken( )
	loop
end sub
