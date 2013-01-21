'' AST conditional IF nodes
'' l = cond expr, r = link(true expr, false expr)
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "ast.bi"
#include once "rtl.bi"

private sub hPrepareWstring _
	( _
		byval n       as ASTNODE ptr, _
		byref truexpr as ASTNODE ptr, _
		byref falsexpr as ASTNODE ptr _
	)

	'' the wstring must be allocated() but size
	'' is unknown at compile-time, do:

	'' dim temp as wstring ptr
	n->sym = symbAddTempVar( typeAddrOf( FB_DATATYPE_WCHAR ) )

	'' Remove temp flag to have it considered for dtor calling
	symbUnsetIsTemp( n->sym )

	'' Mark it as "dynamic wstring" so it will be deallocated with
	'' WstrFree() at scope breaks/end
	symbSetIsWstring( n->sym )

	'' Pretent "= ANY" was used - even though the fake wstring
	'' is pretended to have a constructor, we don't need the
	'' default clear done by astNewDECL()
	symbSetDontInit( n->sym )

	astAdd( astNewDECL( n->sym, NULL ) )

	truexpr  = astBuildFakeWstringAssign( n->sym, truexpr )
	falsexpr = astBuildFakeWstringAssign( n->sym, falsexpr )

end sub

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
		byval falsexpr as ASTNODE ptr _
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

	condexpr = astUpdComp2Branch( condexpr, falselabel, FALSE )
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

	n->l = condexpr

	if( typeGetDtAndPtrOnly( dtype ) = FB_DATATYPE_WCHAR ) then
		hPrepareWstring( n, truexpr, falsexpr )
	else
		n->sym = symbAddTempVar( dtype, subtype )

		if( typeGetClass( dtype ) = FB_DATACLASS_STRING ) then
			'' Remove temp flag to have its dtor called at scope breaks/end
			'' (needed when the temporary is a string)
			symbUnsetIsTemp( n->sym )
			astAdd( astNewDECL( n->sym, NULL ) )
		end if

		'' Using AST_OPOPT_ISINI to get a StrAssign() immediately for strings,
		'' because this is nested in an IIF node, causing astOptAssignment() to miss it
		truexpr  = astNewASSIGN( astNewVAR( n->sym ), truexpr , AST_OPOPT_ISINI )
		falsexpr = astNewASSIGN( astNewVAR( n->sym ), falsexpr, AST_OPOPT_ISINI )
	end if

	n->r = astNewLINK( truexpr, falsexpr )

	n->iif.falselabel = falselabel

end function

function astLoadIIF( byval n as ASTNODE ptr ) as IRVREG ptr
	dim as ASTNODE ptr l = any, r = any, t = any
	dim as FBSYMBOL ptr exitlabel = any

	l = n->l
	r = n->r

	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

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
	astLoad( l )
	astDelNode( l )

	''
	exitlabel = symbAddLabel( NULL )

	'' true expr
	astLoad( r->l )

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

	astLoad( r->r )

	if( ast.doemit ) then
		'' exit
		irEmitLABELNF( exitlabel )
	end if

	if( symbGetIsWstring( n->sym ) ) then
		t = astBuildFakeWstringAccess( n->sym )
	else
		t = astNewVAR( n->sym )
	end if

	' If assigning to a string, it needs to be forced to an address of string
	if typeGetClass( astGetFullType( t ) ) = FB_DATACLASS_STRING then
		t = astNewADDROF( t )
	end if

	function = astLoad( t )
	astDelNode( t )

	astDelNode( r->l )
	astDelNode( r->r )
	astDelNode( r )
end function
