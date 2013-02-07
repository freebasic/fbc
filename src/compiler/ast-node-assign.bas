'' AST assignment nodes
'' l = destine; r = source
''
'' chng: sep/2004 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

private function hCheckStringOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldclass as FB_DATACLASS, _
		byval r as ASTNODE ptr, _
		byval rdclass as FB_DATACLASS _
	) as integer

	dim as ASTNODE ptr other = any

	function = FALSE

	'' Other operand must be a z/wstring then
	'' (since they're not both strings)
	if( ldclass = FB_DATACLASS_STRING ) then
		other = r
	else
		other = l
	end if

	select case( astGetDataType( other ) )
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

	case else
		exit function
	end select

	function = TRUE
end function

'':::::
private function hCheckUDTOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldclass as FB_DATACLASS, _
		byref r as ASTNODE ptr, _
		byval rdclass as FB_DATACLASS, _
		byval checkOnly as integer = TRUE _ 
	) as integer

	dim as FBSYMBOL ptr proc = any

	function = FALSE

	'' l node must be an UDT's,
	if( astGetDataType( l ) <> FB_DATATYPE_STRUCT ) then
		exit function
	else
		'' "udtfunct() = udt" is not allowed, l node must be a variable
		if( l->class = AST_NODECLASS_CALL ) then
			exit function
		end if
	end if

    '' is r an UDT?
	if( astGetDataType( r ) <> FB_DATATYPE_STRUCT ) then
		exit function
	end if

   	'' different subtypes?
	if( l->subtype <> r->subtype ) then
		'' check if lhs is a base type of rhs
		if( symbGetUDTBaseLevel( r->subtype, l->subtype ) = 0 ) then
			exit function
		End If
		
		'' cast to the base type
		if( checkOnly = FALSE ) then
			r = astNewCONV( astGetDataType( l ), l->subtype, r )
		end if
	end if

	function = TRUE

end function

'':::::
private function hCheckWstringOps _
	( _
		byval l as ASTNODE ptr, _
		byref ldfull as integer, _
		byval r as ASTNODE ptr, _
		byref rdfull as integer, _
		byref is_zstr as integer _
	) as integer

	function = FALSE

	dim as integer ldtype = any, rdtype = any

	ldtype = typeGet( ldfull )
	rdtype = typeGet( rdfull )

    '' left?
	if( ldtype = FB_DATATYPE_WCHAR ) then
		'' is right a zstring? (fixed- or
		'' var-len strings won't reach here)
		is_zstr = (rdtype = FB_DATATYPE_CHAR)
	'' right?
	else
		'' is left a zstring?
		is_zstr = (ldtype = FB_DATATYPE_CHAR)
	end if

	if( is_zstr ) then
		return TRUE
	end if

	'' one is not a string, nor a udt, treat as
	'' numeric type, let emit convert them if needed..
	if( ldtype = FB_DATATYPE_WCHAR ) then
		'' don't allow, unless it's a pointer
		if( astIsDEREF( l ) = FALSE ) then
			exit function
		end if

		'' remap the type or the optimizer will
		'' assume it's a string assignment
		ldfull = typeJoin( ldfull, env.target.wchar )
	else
		'' same as above..
		if( astIsDEREF( r ) = FALSE ) then
			exit function
		end if

		rdfull = typeJoin( rdfull, env.target.wchar )
	end if

	function = TRUE
end function

private function hCheckZstringOps _
	( _
		byval l as ASTNODE ptr, _
		byref ldfull as integer, _
		byval r as ASTNODE ptr, _
		byref rdfull as integer _
	) as integer

	function = FALSE

	'' same as for wstring's..
	if( typeGet( ldfull ) = FB_DATATYPE_CHAR ) then
		'' don't allow, unless it's a pointer
		if( astIsDEREF( l ) = FALSE ) then
			exit function
		end if

		ldfull = typeJoin( ldfull, FB_DATATYPE_UBYTE )
	else
		'' same as above..
		if( astIsDEREF( r ) = FALSE ) then
			exit function
		end if

		rdfull = typeJoin( rdfull, FB_DATATYPE_UBYTE )
	end if

	function = TRUE
end function

'':::::
private sub hCheckEnumOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldclass as FB_DATACLASS, _
		byval r as ASTNODE ptr, _
		byval rdclass as FB_DATACLASS _
	)

    '' not the same?
    if( astGetDataType( l ) <> astGetDataType( r ) ) then
    	if( (ldclass <> FB_DATACLASS_INTEGER) or _
    		(rdclass <> FB_DATACLASS_INTEGER) ) then
    		errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
    	end if
    end if

end sub

'':::::
private sub hCheckConstAndPointerOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldtype as FB_DATATYPE, _
		byval r as ASTNODE ptr, _
		byval rdtype as FB_DATATYPE _
	)

	'' lhs marked CONST? disallow the assignment then.
	if( symbCheckConstAssign( ldtype, rdtype, l->subtype, r->subtype ) = FALSE ) then
		errReport( FB_ERRMSG_ILLEGALASSIGNMENT, TRUE )
		return
	end if

	if( typeIsPtr( ldtype ) ) then
		if( astPtrCheck( ldtype, l->subtype, r ) = FALSE ) then
			'' if both are UDT, a derived lhs can't be assigned from a base rhs
			if( typeGetDtOnly( ldtype ) = FB_DATATYPE_STRUCT and typeGetDtOnly( rdtype ) = FB_DATATYPE_STRUCT ) then
				if( symbGetUDTBaseLevel( astGetSubType( l ), astGetSubType( r ) ) > 0 ) then
					errReport( FB_ERRMSG_ILLEGALASSIGNMENT, TRUE )
					return
				end if
			end if
			errReportWarn( FB_WARNINGMSG_SUSPICIOUSPTRASSIGN )
		end if
		
	'' r-side expr is a ptr?
	elseif( typeIsPtr( rdtype ) ) then
		errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
	end if

end sub

'':::::
function astCheckASSIGN _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr n = any
    dim as FB_DATATYPE ldtype = any, rdtype = any, ldfull = any, rdfull = any
    dim as FB_DATACLASS ldclass = any, rdclass = any

	function = FALSE

	ldfull = astGetFullType( l )
	rdfull = astGetFullType( r )
	ldtype = typeGet( ldfull )
	rdtype = typeGet( rdfull )
	ldclass = typeGetClass( ldtype )
	rdclass = typeGetClass( rdtype )

    '' strings?
    if( (ldclass = FB_DATACLASS_STRING) or _
    	(rdclass = FB_DATACLASS_STRING) ) then

		'' both not strings?
		if( ldclass <> rdclass ) then
			if( hCheckStringOps( l, ldclass, r, rdclass ) = FALSE ) then
				exit function
			end if
		end if

		return TRUE

	'' UDT's?
	elseif( (ldtype = FB_DATATYPE_STRUCT) or _
			(rdtype = FB_DATATYPE_STRUCT) ) then

		if( hCheckUDTOps( l, ldclass, r, rdclass, TRUE ) = FALSE ) then
			exit function
		end if

		return TRUE

    '' wstrings?
    elseif( (ldtype = FB_DATATYPE_WCHAR) or _
    		(rdtype = FB_DATATYPE_WCHAR) ) then

		'' both = wstrings?
		if( ldtype <> rdtype ) then
    		dim as integer is_zstr
			if( hCheckWstringOps( l, ldfull, r, rdfull, is_zstr ) = FALSE ) then
				exit function
			end if

			if( is_zstr ) then
				return TRUE
			end if

			'' hCheckWstringOps() may have remapped the types
			ldclass = typeGetClass( ldfull )
			rdclass = typeGetClass( rdfull )
			ldtype = typeGet( ldfull )
			rdtype = typeGet( rdfull )
		end if

    '' zstrings?
    elseif( (ldtype = FB_DATATYPE_CHAR) or _
    		(rdtype = FB_DATATYPE_CHAR) ) then

		'' both zstrings?
		if( ldtype = rdtype ) then
			return TRUE
		end if

		if( hCheckZstringOps( l, ldfull, r, rdfull ) = FALSE ) then
			exit function
		end if

		'' hCheckZstringOps() may have remapped the types
		ldclass = typeGetClass( ldfull )
		rdclass = typeGetClass( rdfull )
		ldtype = typeGet( ldfull )
		rdtype = typeGet( rdfull )

    '' enums?
    elseif( (ldtype = FB_DATATYPE_ENUM) or _
    		(rdtype = FB_DATATYPE_ENUM) ) then
		hCheckEnumOps( l, ldclass, r, rdclass )
	end if

    '' check pointers
	hCheckConstAndPointerOps( l, ldfull, r, rdfull )

	'' convert types if needed
	if( ldtype <> rdtype ) then
		'' don't convert strings
		if( rdclass <> FB_DATACLASS_STRING ) then
			'' constant?
			if( astIsCONST( r ) ) then
				if( astCheckConst( ldtype, r, TRUE ) = FALSE ) then
					r = astNewCONV( ldfull, l->subtype, r )
					if( r = NULL ) then
						exit function
					end if
				end if
			end if

			if( astCheckCONV( ldfull, l->subtype, r ) = FALSE ) then
				exit function
			end if
		end if
	end if

	function = TRUE
end function

function astCheckASSIGNToType _
	( _
		byval ldtype as integer, _
		byval lsubtype as FBSYMBOL ptr, _
		byval r as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr l = any

	l = astNewVAR( NULL, 0, ldtype, lsubtype )

	function = astCheckASSIGN( l, r )

	astDelTree( l )
end function

'':::::
function astNewASSIGN _
	( _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval options as AST_OPOPT _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any
    dim as FB_DATATYPE ldtype = any, rdtype = any, ldfull = any, rdfull = any
    dim as FB_DATACLASS ldclass = any, rdclass = any
    dim as FBSYMBOL ptr lsubtype = any, proc = any
	dim as FB_ERRMSG err_num = any
	dim as integer do_move = any

	function = NULL

	if( (l = NULL) or (r = NULL) ) then
		exit function
	end if

	ldfull = astGetFullType( l )
	ldtype = typeGet( ldfull )
	ldclass = typeGetClass( ldtype )
	lsubtype = l->subtype

	rdfull = astGetFullType( r )
	rdtype = typeGet( rdfull )
	rdclass = typeGetClass( rdtype )

	'' 1st) check assign op overloading (unless the types are the same and
	''      there's no clone function: just do a shallow copy)
	if( (options and AST_OPOPT_DONTCHKOPOVL) = 0 ) then

   		dim as integer check_letop = TRUE

   		select case as const ldtype
   		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			if( ldtype = rdtype ) then
				if( l->subtype = r->subtype ) then

					'' Only invoke the LET operator if it's not an
					'' initialization.  The initializer should be
					'' a fully constructed object.
					if( (options and AST_OPOPT_ISINI) = 0 ) then
						check_letop = (symbGetCompCloneProc( l->subtype ) <> NULL)
					else
						check_letop = FALSE
					end if
				end if
			end if
		end select

		if( check_letop ) then
			proc = symbFindSelfBopOvlProc( AST_OP_ASSIGN, l, r, @err_num )
			if( proc <> NULL ) then
				dim as ASTNODE ptr result = any

				'' if this is a variable initialization, we have to
				'' ensure that the variable is zeroed in memory,
				'' because operator let could do nothing.
				if( (options and AST_OPOPT_ISINI) <> 0 ) then
					if( symbGetCompDefCtor( l->subtype ) <> NULL ) then
	   					result = astBuildCtorCall( l->subtype, astCloneTree( l ) )
	   				else
						result = astNewMEM( AST_OP_MEMCLEAR, _
						                    astCloneTree( l ), _
						                    astNewCONSTi( symbGetLen( l->subtype ) ) )
					end if
				else
					result = NULL
				end if

				'' build a proc call
				return astNewLINK( result, astBuildCall( proc, l, r ) )
			end if

			if( err_num <> FB_ERRMSG_OK ) then
				return NULL
			end if
		end if
	end if

	'' 2nd) implicit casting op overloading
	if( (options and AST_OPOPT_DONTCHKOPOVL) = 0 ) then
		proc = symbFindCastOvlProc( ldfull, lsubtype, r, @err_num )
		if( proc <> NULL ) then

			'' we don't have to worry about initializing the lhs
			'' in case of an initialization, this is because in
			'' parser-decl-symb-init.bas::hDoAssign( ), the node
			'' has already been converted if necessary, therefore
			'' it would fall back on either a shallow copy, or the
			'' operator LET, which was handled just above.

			'' build a proc call
			r = astBuildCall( proc, r, NULL )
		else
			if( err_num <> FB_ERRMSG_OK ) then
				return NULL
			end if
		end if
	end if

	rdfull = astGetFullType( r )
	rdtype = typeGet( rdfull )
	rdclass = typeGetClass( rdtype )

    '' strings?
    if( (ldclass = FB_DATACLASS_STRING) or _
    	(rdclass = FB_DATACLASS_STRING) ) then

		'' both not strings?
		if( ldclass <> rdclass ) then
			if( hCheckStringOps( l, ldclass, r, rdclass ) = FALSE ) then
				exit function
			end if

			return rtlStrAssign( l, r, (options and AST_OPOPT_ISINI) <> 0 )
		end if

		'' otherwise, don't do any assignment by now to allow optimizations..
		if( (options and AST_OPOPT_ISINI) <> 0 ) then
			'' unless it's an initialization
			return rtlStrAssign( l, r, TRUE	)
		end if

	'' UDT's?
	elseif( (ldtype = FB_DATATYPE_STRUCT) or _
			(rdtype = FB_DATATYPE_STRUCT) ) then

		if( hCheckUDTOps( l, ldclass, r, rdclass, FALSE ) = FALSE ) then
			exit function
		end if

		'' type ini tree?
		if( astIsTYPEINI( r ) ) then
			'' skip any casting if they won't do any conversion
			dim as ASTNODE ptr t = l
			if( l->class = AST_NODECLASS_CONV ) then
				if( l->cast.doconv = FALSE ) then
					t = l->l
				end if
			end if

			'' Initialize the lhs with the TYPEINI directly,
			'' instead of using a temp var and then copying that,
			'' unless there are ctors/dtors (let/cast overloads were
			'' already handled above).
			'' FIXME: This currently only works with VAR on the lhs,
			'' because astTypeIniFlush() takes a symbol, not an expression...
			if( t->class = AST_NODECLASS_VAR ) then
				if( (symbHasCtor( t->sym ) or symbHasDtor( t->sym )) = FALSE ) then
					return astTypeIniFlush( r, t->sym, AST_INIOPT_NONE )
				end if
			end if
		end if

		'' Do a shallow copy

		if( astIsCALL( r ) ) then
			do_move = symbProcReturnsOnStack( r->sym )
			if( do_move ) then
				'' Returning on stack, copy from the temp result var
				r = astBuildCallResultVar( r )
			else
				assert( symbProcReturnsByref( r->sym ) = FALSE )

				'' Returning in registers, patch the types and do a normal ASSIGN
				ldfull = symbGetProcRealType( r->sym )
				ldtype = typeGet( ldfull )
				lsubtype = symbGetProcRealSubtype( r->sym )
				ldclass = typeGetClass( ldtype )
				astSetType( l, ldfull, lsubtype )

				rdfull = ldfull
				rdtype = ldtype
				rdclass = ldclass
				astSetType( r, rdfull, lsubtype )
			end if
		else
			'' Not a CALL, it must be an UDT in memory, copy from that
			do_move = TRUE
		end if

		if( do_move ) then
			return astNewMEM( AST_OP_MEMMOVE, l, r, symbGetLen( l->subtype ) )
		end if

    '' wstrings?
    elseif( (ldtype = FB_DATATYPE_WCHAR) or _
    		(rdtype = FB_DATATYPE_WCHAR) ) then

		'' both not wstrings? otherwise don't do any assignment by now
		'' to allow optimizations..
		if( ldtype <> rdtype ) then
    		dim as integer is_zstr

			if( hCheckWstringOps( l, ldfull, r, rdfull, is_zstr ) = FALSE ) then
				exit function
			end if

			'' one of them is an ascii string, just assign
			if( is_zstr ) then
				return rtlWstrAssign( l, r, (options and AST_OPOPT_ISINI) <> 0 )
			end if

			'' hCheckWstringOps() may have remapped the types
			ldclass = typeGetClass( ldfull )
			rdclass = typeGetClass( rdfull )
			ldtype = typeGet( ldfull )
			rdtype = typeGet( rdfull )
		end if

		'' unless it's an initialization
		if( (options and AST_OPOPT_ISINI) <> 0 ) then
			return rtlWstrAssign( l, r, TRUE )
		end if

    '' zstrings?
    elseif( (ldtype = FB_DATATYPE_CHAR) or _
    		(rdtype = FB_DATATYPE_CHAR) ) then

		'' both the same? assign as string..
		if( ldtype = rdtype ) then
			return rtlStrAssign( l, r )
		end if

		if( hCheckZstringOps( l, ldfull, r, rdfull ) = FALSE ) then
			exit function
		end if

		'' hCheckZstringOps() may have remapped the types
		ldclass = typeGetClass( ldfull )
		rdclass = typeGetClass( rdfull )
		ldtype = typeGet( ldfull )
		rdtype = typeGet( rdfull )

    '' enums?
    elseif( (ldtype = FB_DATATYPE_ENUM) or _
    		(rdtype = FB_DATATYPE_ENUM) ) then
		hCheckEnumOps( l, ldclass, r, rdclass )
	end if

    '' check pointers
    if( (options and AST_OPOPT_DONTCHKPTR) = 0 ) then
		hCheckConstAndPointerOps( l, ldfull, r, rdfull )
    end if

	'' convert types if needed
	if( ldtype <> rdtype ) then
		'' don't convert strings
		if( rdclass <> FB_DATACLASS_STRING ) then
			'' constant?
			if( astIsCONST( r ) ) then
				if( astCheckConst( ldtype, r, TRUE ) = FALSE ) then
					r = astNewCONV( ldfull, lsubtype, r )
					if( r = NULL ) then
						exit function
					end if
				end if
			end if

			'' let the fpu do the conversion if any operand
			'' is a float (unless a special case must be handled)
			dim as integer doconv = TRUE
			if( env.clopt.backend = FB_BACKEND_GAS ) then
				if( (ldclass = FB_DATACLASS_FPOINT) or (rdclass = FB_DATACLASS_FPOINT) ) then
					if( ldtype <> FB_DATATYPE_ULONGINT ) then
						doconv = irGetOption( IR_OPT_FPUCONV )
					end if
				end if
			end if

			if( doconv ) then
				r = astNewCONV( ldfull, l->subtype, r )
				if( r = NULL ) then
					exit function
				end if
			end if
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ASSIGN, ldfull, lsubtype )

	n->l = l
	n->r = r

	function = n

end function

function astLoadASSIGN( byval n as ASTNODE ptr ) as IRVREG ptr
    dim as ASTNODE ptr l = any, r = any
    dim as IRVREG ptr vs = any, vr = any

	l = n->l
	r = n->r
	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	if( r->class = AST_NODECLASS_CONV ) then
		astUpdateCONVFD2FS( r, l->dtype, FALSE )
	end if

	vs = astLoad( r )
	vr = astLoad( l )

	if( ast.doemit ) then
		irEmitSTORE( vr, vs )
	end if

	astDelNode( l )
	astDelNode( r )

	function = vr
end function
