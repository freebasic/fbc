'' AST conditional IF nodes
'' l = VAR access to the iif temp var
'' r = LINK( condexpr, LINK( truexpr, falsexpr ) )

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"
#include once "rtl.bi"

function hCheckTypes _
	( _
		byval ldtype as integer, _
		byval lsubtype as FBSYMBOL ptr, _
		byval rdtype as integer, _
		byval rsubtype as FBSYMBOL ptr, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	) as integer

	dim as integer lmatch = any, rmatch = any, otherdtype = any

	function = FALSE

	'' Any pointers?
	lmatch = typeIsPtr( ldtype )
	rmatch = typeIsPtr( rdtype )
	if( lmatch or rmatch ) then
		'' If both are pointers, it must be the same pointer type,
		'' otherwise we can't know which one to prefer, and an implicit
		'' conversion to a common type like ANY PTR seems useless...

		if( lmatch and rmatch ) then
			if( (typeGetDtAndPtrOnly( ldtype ) <> typeGetDtAndPtrOnly( rdtype )) or _
			    (lsubtype <> rsubtype) ) then
				exit function
			end if
			dtype = ldtype
			subtype = lsubtype
		else
			'' If only one is a ptr, use the ptr type as result,
			'' and allow only integers on the other side.
			'' At least something like
			''    #define NULL 0
			''    iif( cond, someptr, NULL )
			'' should work... allowing floats seems useless though.
			if( lmatch ) then
				dtype = ldtype
				subtype = lsubtype
				otherdtype = rdtype
			else
				dtype = rdtype
				subtype = rsubtype
				otherdtype = ldtype
			end if

			if( typeGetClass( otherdtype ) <> FB_DATACLASS_INTEGER ) then
				exit function
			end if

			'' no char/wchar though (they're also treated as
			'' FB_DATACLASS_INTEGER), they are strings in iif().
			select case( typeGetDtOnly( otherdtype ) )
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				exit function
			end select
		end if

		return TRUE
	end if

	'' (Assuming no more pointers from here on)

	'' Any strings?
	lmatch = (typeGetDtOnly( ldtype ) = FB_DATATYPE_STRING) or _
	         (typeGetDtOnly( ldtype ) = FB_DATATYPE_FIXSTR) or _
	         (typeGetDtOnly( ldtype ) = FB_DATATYPE_CHAR  )
	rmatch = (typeGetDtOnly( rdtype ) = FB_DATATYPE_STRING) or _
	         (typeGetDtOnly( rdtype ) = FB_DATATYPE_FIXSTR) or _
	         (typeGetDtOnly( rdtype ) = FB_DATATYPE_CHAR  )
	if( lmatch or rmatch ) then
		'' If one is, both must be
		if( lmatch <> rmatch ) then
			exit function
		end if
		dtype = FB_DATATYPE_STRING
		subtype = NULL
		return TRUE
	end if

	'' Any wstrings?
	lmatch = (typeGetDtOnly( ldtype ) = FB_DATATYPE_WCHAR)
	rmatch = (typeGetDtOnly( rdtype ) = FB_DATATYPE_WCHAR)
	if( lmatch or rmatch ) then
		'' If one is, both must be
		if( lmatch <> rmatch ) then
			exit function
		end if
		dtype = FB_DATATYPE_WCHAR
		subtype = NULL
		return TRUE
	end if

	'' Any UDTs?
	lmatch = (typeGetDtOnly( ldtype ) = FB_DATATYPE_STRUCT)
	rmatch = (typeGetDtOnly( rdtype ) = FB_DATATYPE_STRUCT)
	if( lmatch or rmatch ) then
		'' If one is, both must be
		if( lmatch <> rmatch ) then
			exit function
		end if

		'' And it must be the same UDT
		if( lsubtype <> rsubtype ) then
			exit function
		end if

		dtype = FB_DATATYPE_STRUCT
		subtype = lsubtype
		return TRUE
	end if

	'' Any enums?
	lmatch = (typeGetDtOnly( ldtype ) = FB_DATATYPE_ENUM)
	rmatch = (typeGetDtOnly( rdtype ) = FB_DATATYPE_ENUM)
	if( lmatch or rmatch ) then
		'' Both sides are enums?
		if( lmatch and rmatch ) then
			if( lsubtype = rsubtype ) then
				'' Both sides are the same enum, preserve the enum type.
				dtype = FB_DATATYPE_ENUM
				subtype = lsubtype
			else
				'' Different enum, make result a generic integer,
				'' since we don't know which enum to prefer.
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL
			end if
			return TRUE
		end if

		'' Only one side is an enum: it should be treated as integer
		'' and then be combined with the other side as usual (max).
		if( lmatch ) then
			ldtype = FB_DATATYPE_INTEGER
			lsubtype = NULL
		else
			rdtype = FB_DATATYPE_INTEGER
			rsubtype = NULL
		end if
	end if

	'' Use the "max" of both types, like BOPs
	typeMax( ldtype, lsubtype, rdtype, rsubtype, dtype, subtype )
	function = TRUE
end function

function astNewIIF _
	( _
		byval condexpr as ASTNODE ptr, _
		byval truexpr as ASTNODE ptr, _
		byval truecookie as integer, _
		byval falsexpr as ASTNODE ptr, _
		byval falsecookie as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any, varexpr = any
	dim as integer dtype = any
	dim as integer is_true_ctorcall = any, is_false_ctorcall = any
	dim as integer call_true_defctor = any, call_false_defctor = any
	dim as FBSYMBOL ptr falselabel = any, subtype = any, temp = any

	function = NULL

	if( condexpr = NULL ) then
		exit function
	end if

	'' Constant condition?
	if( astIsCONST( condexpr ) ) then
		'' Note: maybe the type checks should be done for this too,
		'' but then what result type should something like
		''    iif( 0, mystr, myfixstr )
		'' produce? myfixstr is a fix-len string, it cannot just be
		'' treated as a var-len string, and there is no temp var...
		if( astConstEqZero( condexpr ) ) then
			astDelTree( truexpr )
			astDtorListScopeDelete( truecookie )
			function = falsexpr
			astDtorListUnscope( falsecookie )
		else
			astDelTree( falsexpr )
			astDtorListScopeDelete( falsecookie )
			function = truexpr
			astDtorListUnscope( truecookie )
		end if
		astDelTree( condexpr )
		exit function
	end if

	dtype = FB_DATATYPE_INVALID
	subtype = NULL

	'' Maybe UDT extends Z|WSTRING? Check for string conversions...
	if( truexpr->dtype <> falsexpr->dtype ) then
		if( truexpr->dtype = FB_DATATYPE_STRUCT ) then
			if( symbGetUdtIsZstring( truexpr->subtype ) ) then
				if( falsexpr->dtype = FB_DATATYPE_CHAR ) then
					astTryOvlStringCONV( truexpr )
					truexpr->dtype = astGetDataType( truexpr )
				end if
			elseif( symbGetUdtIsWstring( truexpr->subtype ) ) then
				if( falsexpr->dtype = FB_DATATYPE_WCHAR ) then
					astTryOvlStringCONV( truexpr )
					truexpr->dtype = astGetDataType( truexpr )
				end if
			end if
		elseif( falsexpr->dtype = FB_DATATYPE_STRUCT ) then
			if( symbGetUdtIsZstring( falsexpr->subtype ) ) then
				if( truexpr->dtype = FB_DATATYPE_CHAR ) then
					astTryOvlStringCONV( falsexpr )
					falsexpr->dtype = astGetDataType( falsexpr )
				end if
			elseif( symbGetUdtIsWstring( falsexpr->subtype ) ) then
				if( truexpr->dtype = FB_DATATYPE_WCHAR ) then
					astTryOvlStringCONV( falsexpr )
					falsexpr->dtype = astGetDataType( falsexpr )
				end if
			end if
		end if
	end if

	'' check types & find the iif() result type
	if( hCheckTypes( truexpr->dtype, truexpr->subtype, _
	                 falsexpr->dtype, falsexpr->subtype, _
	                 dtype, subtype ) = FALSE ) then
		exit function
	end if

	'' Merge CONST bits
	''    byte ptr, const byte ptr  ->  const byte ptr
	dtype or= typeGetConstMask( truexpr->dtype ) or _
	          typeGetConstMask( falsexpr->dtype )

	falselabel = symbAddLabel( NULL )

	condexpr = astBuildBranch( condexpr, falselabel, FALSE, TRUE )
	if( condexpr = NULL ) then
		exit function
	end if

	' Special treatment for fixed-len/zstrings, promote to real FBSTRING
	select case( typeGetDtAndPtrOnly( dtype ) )
	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
		dtype  = FB_DATATYPE_STRING
	end select

	'' Note: Any changes to the true/false expressions must be enclosed
	'' in astDtorListScopeBegin/astDtorListScopeEnd calls using the same
	'' true/false cookies, until the astDtorListFlush()s below, to ensure
	'' that any newly allocated temp vars end up in the same dtorlist scope
	'' that was also used when the original true/false expressions were
	'' being parsed (i.e. the same cookie must be used).

	if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_WCHAR ) then
		'' Just like with SELECT CASE, for iif() on wstrings we need
		'' a temporary wstring, but since the length of the iif() result
		'' is unknown at compile-time it must be a dynamically allocated
		'' buffer. For [z]strings we can use a normal STRING temp var,
		'' but since there is no such thing for wstrings yet,
		'' the "fake wstring", i.e. a wchar ptr, must be used.

		'' dim temp as wstring ptr (doesn't need to be cleared)
		temp = symbAddTempVar( typeAddrOf( FB_DATATYPE_WCHAR ) )
		symbSetIsWstring( temp )

		'' Register for cleanup at the end of the statement
		astDtorListAdd( temp )

		varexpr  = astBuildFakeWstringAccess( temp )

		astDtorListScopeBegin( truecookie )
		'' Using AST_OPOPT_ISINI to get a WstrAssign() immediately,
		'' as astOptAssignment() will miss it because it's nested
		'' inside an IIF node
		truexpr = astBuildFakeWstringAssign( temp, truexpr, AST_OPOPT_ISINI )
		astDtorListScopeEnd( )

		astDtorListScopeBegin( falsecookie )
		falsexpr = astBuildFakeWstringAssign( temp, falsexpr, AST_OPOPT_ISINI )
		astDtorListScopeEnd( )
	else
		temp = symbAddTempVar( dtype, subtype )

		'' Register for cleanup at the end of the statement
		astDtorListAdd( temp )

		varexpr = astNewVAR( temp )

		is_true_ctorcall   = FALSE
		is_false_ctorcall  = FALSE
		call_true_defctor  = FALSE
		call_false_defctor = FALSE

		'' Any constructors?
		if( symbHasCtor( temp ) ) then
			'' Try calling them, to construct the temp var from the true/false expressions.
			astDtorListScopeBegin( truecookie )
			truexpr  = astBuildImplicitCtorCallEx( temp, truexpr , INVALID, is_true_ctorcall  )
			astDtorListScopeEnd( )

			astDtorListScopeBegin( falsecookie )
			falsexpr = astBuildImplicitCtorCallEx( temp, falsexpr, INVALID, is_false_ctorcall )
			astDtorListScopeEnd( )

			'' If the temp var can be constructed from the true/false expressions...
			'' a) in both cases, just use these ctorcalls
			'' b) in only one case (true or false), let's try to call a defctor in the other case
			'' c) in no case at all, let's try to call a defctor once before the conditional branch

			if( is_true_ctorcall or is_false_ctorcall ) then
				if( is_true_ctorcall ) then
					astDtorListScopeBegin( truecookie )
					truexpr = astPatchCtorCall( truexpr , astNewVAR( temp ) )
					astDtorListScopeEnd( )
				else
					'' Do a normal assignment and call the defctor in front of it
					call_true_defctor = TRUE
				end if

				if( is_false_ctorcall ) then
					astDtorListScopeBegin( falsecookie )
					falsexpr = astPatchCtorCall( falsexpr, astNewVAR( temp ) )
					astDtorListScopeEnd( )
				else
					'' Do a normal assignment and call the defctor in front of it
					call_false_defctor = TRUE
				end if
			else
				'' Insert defctor call in front of the conditional branch
				condexpr = astNewLINK( astBuildCtorCall( subtype, astNewVAR( temp ) ), condexpr, AST_LINK_RETURN_NONE )
			end if

			'' No defctor but it's needed?
			if( symbHasDefCtor( temp ) = FALSE ) then
				if( (is_true_ctorcall = FALSE) or (is_false_ctorcall = FALSE) ) then
					exit function
				end if
			end if
		end if

		'' Using AST_OPOPT_ISINI to get fb_StrInit()'s instead of fb_StrAssign()'s,
		'' because those would require the temp string to be cleared manually...

		if( is_true_ctorcall = FALSE ) then
			astDtorListScopeBegin( truecookie )
			truexpr  = astNewASSIGN( astNewVAR( temp ), truexpr , AST_OPOPT_ISINI )
			if( call_true_defctor ) then
				truexpr = astNewLINK( astBuildCtorCall( subtype, astNewVAR( temp ) ), truexpr, AST_LINK_RETURN_NONE )
			end if
			astDtorListScopeEnd( )
		end if

		if( is_false_ctorcall = FALSE ) then
			astDtorListScopeBegin( falsecookie )
			falsexpr = astNewASSIGN( astNewVAR( temp ), falsexpr, AST_OPOPT_ISINI )
			if( call_false_defctor ) then
				falsexpr = astNewLINK( astBuildCtorCall( subtype, astNewVAR( temp ) ), falsexpr, AST_LINK_RETURN_NONE )
			end if
			astDtorListScopeEnd( )
		end if
	end if

	'' Update any remaining TYPEINIs (after the astNewASSIGN()s above,
	'' which could solve out TYPEINIs for optimization) in the true/false
	'' expressions, in case they have dtors, otherwise astAdd() later would
	'' do that, causing the corresponding temp vars for TYPEINIs from both
	'' true/false code paths to always be constructed and destructed.
	astDtorListScopeBegin( truecookie )
	truexpr = astTypeIniUpdate( truexpr )
	astDtorListScopeEnd( )

	astDtorListScopeBegin( falsecookie )
	falsexpr = astTypeIniUpdate( falsexpr )
	astDtorListScopeEnd( )

	'' Add dtor calls to the true/false code paths, behind the assignments
	'' to the iif temp var, so that any temp vars constructed inside the
	'' true/false expressions themselves will only be destructed when their
	'' code path was executed, but not when the other code path was chosen.
	'' Zero (0) can be given for one or both cookies, in case the
	'' corresponding expression won't have any temp var to destruct.
	if( truecookie ) then
		truexpr  = astNewLINK( truexpr , astDtorListFlush( truecookie  ), AST_LINK_RETURN_NONE )
	end if
	if( falsecookie ) then
		falsexpr = astNewLINK( falsexpr, astDtorListFlush( falsecookie ), AST_LINK_RETURN_NONE )
	end if

	n = astNewNode( AST_NODECLASS_IIF, dtype, subtype )

	n->sym = temp
	n->l = varexpr
	n->r = astNewLINK( condexpr, astNewLINK( truexpr, falsexpr, AST_LINK_RETURN_NONE ), AST_LINK_RETURN_NONE )
	n->iif.falselabel = falselabel

	function = n
end function

function astLoadIIF( byval n as ASTNODE ptr ) as IRVREG ptr
	dim as ASTNODE ptr condexpr = any, truexpr = any, falsexpr = any
	dim as FBSYMBOL ptr exitlabel = any

	assert( n->r->class = AST_NODECLASS_LINK )

	'' exect a link or temporary variable assignment
	assert( (n->r->r->class = AST_NODECLASS_LINK) or (n->r->r->class = AST_NODECLASS_ASSIGN) )

	condexpr = n->r->l
	truexpr  = n->r->r->l
	falsexpr = n->r->r->r

	if( ast.doemit ) then
		'' IR can't handle inter-blocks and live vregs atm, so any
		'' register used must be spilled now or that could happen in a
		'' function call done in any child trees and also if complex
		'' expressions were used
		'''''if( astHasSideFx( r->l ) ) then
		irEmitSPILLREGS( )
		'''''end if
	end if

	'' condition
	astLoad( condexpr )
	astDelNode( condexpr )

	exitlabel = symbAddLabel( NULL )

	'' true expr
	astLoad( truexpr )
	astDelNode( truexpr )

	if( ast.doemit ) then
		irEmitBRANCH( AST_OP_JMP, exitlabel )
	end if

	'' false expr
	if( ast.doemit ) then
		irEmitLABELNF( n->iif.falselabel )
	end if

	if( ast.doemit ) then
		'' see above
		'''''if( astHasSideFx( r->r ) ) then
		irEmitSPILLREGS( )
		'''''end if
	end if

	astLoad( falsexpr )
	astDelNode( falsexpr )

	if( ast.doemit ) then
		'' exit
		irEmitLABELNF( exitlabel )
	end if

	'' Return the VAR access on the temp var
	function = astLoad( n->l )
	astDelNode( n->l )

	astDelNode( n->r->r )
	astDelNode( n->r )
end function
