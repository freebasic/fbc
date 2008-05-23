'' AST assignment nodes
'' l = destine; r = source
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

'':::::
private function hCheckStringOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldclass as FB_DATACLASS, _
		byval r as ASTNODE ptr, _
		byval rdclass as FB_DATACLASS _
	) as integer

	function = FALSE

	'' check if it's not a byte ptr
	if( ldclass = FB_DATACLASS_STRING ) then
		'' not a w|zstring?
		select case astGetDataType( r )
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		case else
			if( r->class <> AST_NODECLASS_DEREF ) then
				exit function
			elseif( astGetDataType( r ) <> FB_DATATYPE_BYTE ) then
				if( astGetDataType( r ) <> FB_DATATYPE_UBYTE ) then
					exit function
				end if
			end if
		end select

	else
		'' not a w|zstring?
		dim as FB_DATATYPE dtype = astGetDataType( l )
		select case as const dtype
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		case else
			if( l->class <> AST_NODECLASS_DEREF ) then
				exit function
			elseif( dtype <> FB_DATATYPE_BYTE ) then
				if( dtype <> FB_DATATYPE_UBYTE ) then
					exit function
				end if
			end if
		end select
	end if

	function = TRUE

end function

'':::::
private function hCheckUDTOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldclass as FB_DATACLASS, _
		byval r as ASTNODE ptr, _
		byval rdclass as FB_DATACLASS _
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
		exit function
	end if

	function = TRUE

end function

'':::::
private function hCheckWstringOps _
	( _
		byval l as ASTNODE ptr, _
		byref ldtype as FB_DATATYPE, _
		byval r as ASTNODE ptr, _
		byref rdtype as FB_DATATYPE, _
		byref is_zstr as integer _
	) as integer

	function = FALSE

	dim as FB_DATATYPE ld = any, rd = any

	ld = typeGet( ldtype )
	rd = typeGet( rdtype )

    '' left?
	if( ld = FB_DATATYPE_WCHAR ) then
		'' is right a zstring? (fixed- or
		'' var-len strings won't reach here)
		is_zstr = ( rd = FB_DATATYPE_CHAR )

	'' right?
	else
		'' is left a zstring?
		is_zstr = ( ld = FB_DATATYPE_CHAR )
	end if

	if( is_zstr ) then
		return TRUE
	end if

	'' one is not a string, nor a udt, treat as
	'' numeric type, let emit convert them if needed..
	if( ld = FB_DATATYPE_WCHAR ) then
		'' don't allow, unless it's a pointer
		if( l->class <> AST_NODECLASS_DEREF ) then
			exit function
		end if

		'' remap the type or the optimizer will
		'' assume it's a string assignment
		ldtype = typeJoin( ldtype, env.target.wchar.type )

	else
		'' same as above..
		if( r->class <> AST_NODECLASS_DEREF ) then
			exit function
		end if

		rdtype = typeJoin( rdtype, env.target.wchar.type )
	end if

	function = TRUE

end function

'':::::
private function hCheckZstringOps _
	( _
		byval l as ASTNODE ptr, _
		byref ldtype as FB_DATATYPE, _
		byval r as ASTNODE ptr, _
		byref rdtype as FB_DATATYPE _
	) as integer

	function = FALSE

	'' same as for wstring's..
	if( typeGet( ldtype ) = FB_DATATYPE_CHAR ) then
		'' don't allow, unless it's a pointer
		if( l->class <> AST_NODECLASS_DEREF ) then
			exit function
		end if

		ldtype = typeJoin( ldtype, FB_DATATYPE_UBYTE )

	else
		'' same as above..
		if( r->class <> AST_NODECLASS_DEREF ) then
			exit function
		end if

		rdtype = typeJoin( rdtype, FB_DATATYPE_UBYTE )
	end if

	function = TRUE

end function

'':::::
private function hCheckEnumOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldclass as FB_DATACLASS, _
		byval r as ASTNODE ptr, _
		byval rdclass as FB_DATACLASS _
	) as integer

	function = FALSE

    '' not the same?
    if( astGetDataType( l ) <> astGetDataType( r ) ) then
    	if( (ldclass <> FB_DATACLASS_INTEGER) or _
    		(rdclass <> FB_DATACLASS_INTEGER) ) then
    		errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
    	end if
    end if

    function = TRUE

end function

'':::::
private function hCheckConstAndPointerOps _
	( _
		byval l as ASTNODE ptr, _
		byval ldtype as FB_DATATYPE, _
		byval r as ASTNODE ptr, _
		byval rdtype as FB_DATATYPE _
	) as integer

	function = FALSE

	'' check constant
	if( symbCheckConstAssign( ldtype, rdtype, l->subtype, r->subtype ) = FALSE ) then
		if( errReport( FB_ERRMSG_ILLEGALASSIGNMENT, TRUE ) = FALSE ) then
			exit function
		else
			return TRUE
		end if
	end if

	if( typeIsPtr( ldtype ) ) then
		if( astPtrCheck( ldtype, l->subtype, r ) = FALSE ) then
			errReportWarn( FB_WARNINGMSG_SUSPICIOUSPTRASSIGN )
		end if
	'' r-side expr is a ptr?
	elseif( typeIsPtr( rdtype ) ) then
		errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
	end if

    function = TRUE

end function

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
	ldclass = symbGetDataClass( ldtype )
	rdclass = symbGetDataClass( rdtype )

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

		if( hCheckUDTOps( l, ldclass, r, rdclass ) = FALSE ) then
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
		end if

    '' zstrings?
    elseif( (ldtype = FB_DATATYPE_CHAR) or _
    		(rdtype = FB_DATATYPE_CHAR) ) then

		'' both zstrings?
		if( ldtype = rdtype ) then
			return TRUE
		end if

		if( hCheckZstringOps( l, ldtype, r, rdtype ) = FALSE ) then
			exit function
		end if

    '' enums?
    elseif( (ldtype = FB_DATATYPE_ENUM) or _
    		(rdtype = FB_DATATYPE_ENUM) ) then

		if( hCheckEnumOps( l, ldclass, r, rdclass ) = FALSE ) then
			exit function
		end if

	end if

    '' check pointers
	if( hCheckConstAndPointerOps( l, ldfull, r, rdfull ) = FALSE ) then
		exit function
	end if

	'' convert types if needed
	if( ldtype <> rdtype ) then
		'' don't convert strings
		if( rdclass <> FB_DATACLASS_STRING ) then
			'' constant?
			if( astIsCONST( r ) ) then
				r = astCheckConst( ldtype, r )
				if( r = NULL ) then
					exit function
				end if
			end if

			if( astCheckCONV( ldtype, l->subtype, r ) = FALSE ) then
				exit function
			end if
		end if
	else
		'' check for overflows
		if( symbGetDataClass( rdtype ) = FB_DATACLASS_FPOINT ) then
			if( astIsCONST( r ) ) then
				r = astCheckConst( ldtype, r )
				if( r = NULL ) then
					exit function
				end if
			end if
		end if
	end if

	function = TRUE

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

	function = NULL

	if( (l = NULL) or (r = NULL) ) then
		exit function
	end if

	ldfull = astGetFullType( l )
	ldtype = typeGet( ldfull )
	ldclass = symbGetDataClass( ldtype )
	lsubtype = l->subtype

	rdfull = astGetFullType( r )
	rdtype = typeGet( rdfull )
	rdclass = symbGetDataClass( rdtype )

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
			else
				if( err_num <> FB_ERRMSG_OK ) then
					return NULL
				end if
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
	rdclass = symbGetDataClass( rdtype )

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

		if( hCheckUDTOps( l, ldclass, r, rdclass ) = FALSE ) then
			exit function
		end if

        dim as integer is_udt = TRUE
        if( astIsCALL( r ) ) then
        	is_udt = (symbIsUDTReturnedInRegs( r->subtype ) = FALSE)
        end if

        '' is r an UDT too?
		if( is_udt ) then
			'' type ini tree?
			if( r->class = AST_NODECLASS_TYPEINI ) then
				'' skip any casting if they won't do any conversion
				dim as ASTNODE ptr t = l
				if( l->class = AST_NODECLASS_CONV ) then
					if( l->cast.doconv = FALSE ) then
						t = l->l
					end if
				end if

				'' !!FIXME!! can't be used with complex l-hand side expressions
				if( t->class = AST_NODECLASS_VAR ) then
					'' no double assign, just flush the tree
					return astTypeIniFlush( r, l->sym, AST_INIOPT_NONE )
				end if
			end if

			'' do a shallow copy..

			'' call and returning a pointer? deref the hidden arg (the result)
			var do_move = TRUE
			if( astIsCALL( r ) ) then
				if( typeIsPtr( symbGetUDTRetType( r->subtype ) ) ) then
					r = astBuildCallHiddenResVar( r )
				else
					do_move = FALSE
				end if
			end if

			if( do_move ) then
				return astNewMEM( AST_OP_MEMMOVE, _
							  	l, _
							  	r, _
							  	symbGetUDTUnpadLen( l->subtype ) )
			end if

		'' r is function returning an UDT on registers
		else
            '' patch both type
            ldfull = symbGetUDTRetType( r->subtype )
            ldtype = typeGet( ldfull )
            lsubtype = NULL
            ldclass = symbGetDataClass( ldtype )
            astSetType( l, ldfull, NULL )

            rdfull = ldfull
            rdtype = ldtype
            rdclass = ldclass
            astSetType( r, rdfull, NULL )
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

		if( hCheckZstringOps( l, ldtype, r, rdtype ) = FALSE ) then
			exit function
		end if

    '' enums?
    elseif( (ldtype = FB_DATATYPE_ENUM) or _
    		(rdtype = FB_DATATYPE_ENUM) ) then

		if( hCheckEnumOps( l, ldclass, r, rdclass ) = FALSE ) then
			exit function
		end if

	end if

    '' check pointers
    if( (options and AST_OPOPT_DONTCHKPTR) = 0 ) then
		if( hCheckConstAndPointerOps( l, ldfull, r, rdfull ) = FALSE ) then
			exit function
		end if
    end if

	'' convert types if needed
	if( ldtype <> rdtype ) then
		'' don't convert strings
		if( rdclass <> FB_DATACLASS_STRING ) then
			'' constant?
			if( astIsCONST( r ) ) then
				r = astCheckConst( ldtype, r )
				if( r = NULL ) then
					exit function
				end if
			end if

			'' let the fpu do the convertion if any operand
			'' is a float (unless a special case must be handled)
			dim as integer doconv = TRUE
			if( irGetOption( IR_OPT_HIGHLEVEL ) = FALSE ) then
				if( (ldclass = FB_DATACLASS_FPOINT) or (rdclass = FB_DATACLASS_FPOINT) ) then
					if( ldtype <> FB_DATATYPE_ULONGINT ) then
						doconv = irGetOption( IR_OPT_FPU_CONVERTOPER )
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
	else
		'' check for overflows
		if( symbGetDataClass( rdtype ) = FB_DATACLASS_FPOINT ) then
			if( astIsCONST( r ) ) then
				r = astCheckConst( ldtype, r )
				if( r = NULL ) then
					exit function
				end if
			end if
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ASSIGN, ldfull, lsubtype )

	if( n = NULL ) then
		return NULL
	end if

	n->l = l
	n->r = r

	function = n

end function

'':::::
function astLoadASSIGN _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

    dim as ASTNODE ptr l = any, r = any
    dim as IRVREG ptr vs = any, vr = any

	l = n->l
	r = n->r
	if( (l = NULL) or (r = NULL) ) then
		return NULL
	end if

	'' handle bitfields..
	astUpdateFieldAssignment( l, r )

	vs = astLoad( r )
	vr = astLoad( l )

	if( ast.doemit ) then
		irEmitSTORE( vr, vs )
	end if

	astDelNode( l )
	astDelNode( r )

	function = vr

end function


