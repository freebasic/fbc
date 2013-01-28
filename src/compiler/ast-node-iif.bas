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

	'' Disallow UDTs
	if( (typeGet( ldtype ) = FB_DATATYPE_STRUCT) or _
	    (typeGet( rdtype ) = FB_DATATYPE_STRUCT) ) then
		exit function
	end if

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
	dtype = typeMax( ldtype, rdtype )
	if( dtype = FB_DATATYPE_INVALID ) then
		if( typeGetClass( ldtype ) = FB_DATACLASS_FPOINT ) then
			'' SINGLE, SINGLE -> SINGLE
			'' everything else -> DOUBLE
			if( (typeGetDtOnly( ldtype ) = FB_DATATYPE_SINGLE) and _
			    (typeGetDtOnly( rdtype ) = FB_DATATYPE_SINGLE) ) then
				dtype = FB_DATATYPE_SINGLE
			else
				dtype = FB_DATATYPE_DOUBLE
			end if
		else
			'' typeMax() returns FB_DATATYPE_INVALID also
			'' for INT vs. UINT, so prefer the unsigned one.
			if( typeIsSigned( ldtype ) ) then
				dtype = rdtype
			else
				dtype = ldtype
			end if
		end if
	end if
	subtype = NULL

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

	dim as ASTNODE ptr n = any
	dim as integer dtype = any
	dim as FBSYMBOL ptr falselabel = any, subtype = any

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
		if( astCONSTIsTrue( condexpr ) ) then
			astDelTree( falsexpr )
			function = truexpr
		else
			astDelTree( truexpr )
			function = falsexpr
		end if
		astDelTree( condexpr )
		exit function
	end if

	dtype = FB_DATATYPE_INVALID
	subtype = NULL

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

	'' alloc new node
	n = astNewNode( AST_NODECLASS_IIF, dtype, subtype )
	function = n

	if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_WCHAR ) then
		'' Just like with SELECT CASE, for iif() on wstrings we need
		'' a temporary wstring, but since the length of the iif() result
		'' is unknown at compile-time it must be a dynamically allocated
		'' buffer. For [z]strings we can use a normal STRING temp var,
		'' but since there is no such thing for wstrings yet,
		'' the "fake wstring", i.e. a wchar ptr, must be used.

		'' dim temp as wstring ptr (doesn't need to be cleared)
		n->sym = symbAddTempVar( typeAddrOf( FB_DATATYPE_WCHAR ) )
		symbSetIsWstring( n->sym )

		'' Register for cleanup at the end of the statement
		astDtorListAdd( n->sym )

		n->l = astBuildFakeWstringAccess( n->sym )

		truexpr  = astBuildFakeWstringAssign( n->sym, truexpr )
		falsexpr = astBuildFakeWstringAssign( n->sym, falsexpr )
	else
		n->sym = symbAddTempVar( dtype, subtype )

		'' Register for cleanup at the end of the statement
		astDtorListAdd( n->sym )

		n->l = astNewVAR( n->sym )

		'' Using AST_OPOPT_ISINI to get fb_StrInit()'s instead of fb_StrAssign()'s,
		'' because those would require the temp string to be cleared manually...
		truexpr  = astNewASSIGN( astNewVAR( n->sym ), truexpr , AST_OPOPT_ISINI )
		falsexpr = astNewASSIGN( astNewVAR( n->sym ), falsexpr, AST_OPOPT_ISINI )
	end if

	'' Add dtor calls to the true/false code paths, behind the assignments
	'' to the iif temp var, so that any temp vars constructed inside the
	'' true/false expressions themselves will only be destructed when their
	'' code path was executed, but not when the other code path was chosen.
	'' Zero (0) can be given for one or both cookies, in case the
	'' corresponding expression won't have any temp var to destruct.
	if( truecookie ) then
		truexpr  = astNewLINK( truexpr , astDtorListFlush( truecookie  ) )
	end if
	if( falsecookie ) then
		falsexpr = astNewLINK( falsexpr, astDtorListFlush( falsecookie ) )
	end if

	n->r = astNewLINK( condexpr, astNewLINK( truexpr, falsexpr ) )

	n->iif.falselabel = falselabel

end function

function astLoadIIF( byval n as ASTNODE ptr ) as IRVREG ptr
	dim as ASTNODE ptr condexpr = any, truexpr = any, falsexpr = any
	dim as FBSYMBOL ptr exitlabel = any

	assert( n->r->class = AST_NODECLASS_LINK )
	assert( n->r->r->class = AST_NODECLASS_LINK )

	condexpr = n->r->l
	truexpr  = n->r->r->l
	falsexpr = n->r->r->r

	if( ast.doemit ) then
		'' IR can't handle inter-blocks and live vregs atm, so any
		'' register used must be spilled now or that could happen in a
		'' function call done in any child trees and also if complex
		'' expressions were used
		'''''if( astIsClassOnTree( AST_NODECLASS_CALL, r->l ) <> NULL ) then
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
		'''''if( astIsClassOnTree( AST_NODECLASS_CALL, r->r ) <> NULL ) then
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
