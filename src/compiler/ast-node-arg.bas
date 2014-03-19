'' AST function argument nodes
'' l = expression; r = next argument
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "list.bi"
#include once "ir.bi"
#include once "rtl.bi"
#include once "ast.bi"

private function hAllocTmpArrayDesc _
	( _
		byval array as FBSYMBOL ptr, _
		byval array_expr as ASTNODE ptr, _
		byref tree as ASTNODE ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr desc = any
	dim as ASTNODE ptr initree = any

	'' create
	desc = symbAddArrayDesc( array )
	initree = astBuildArrayDescIniTree( desc, array, array_expr )

	'' declare, no clear
	tree = astNewDECL( desc, FALSE )

	'' flush (see symbAddArrayDesc(), the desc can't never be static)
	tree = astNewLINK( tree, astTypeIniFlush( initree, desc, AST_INIOPT_ISINI ) )

	function = desc
end function

'':::::
private function hTmpStrListAdd _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval copyback as integer _
	) as AST_TMPSTRLIST_ITEM ptr

	dim as AST_TMPSTRLIST_ITEM ptr t = any
	dim as FBSYMBOL ptr s = any

	'' alloc a node
	t = listNewNode( @ast.call.tmpstrlist )

	t->prev = parent->call.strtail
	parent->call.strtail = t

	s = symbAddTempVar( dtype )

	t->sym = s
	if( copyback ) then
		t->srctree = astOptimizeTree( astCloneTree( n ) )
	else
		t->srctree = NULL
	end if

	function = t

end function

'':::::
private function hAllocTmpString _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval copyback as integer _
	) as ASTNODE ptr

	dim as AST_TMPSTRLIST_ITEM ptr t = any

	'' create temp string to pass as parameter
	t = hTmpStrListAdd( parent, n, FB_DATATYPE_STRING, copyback )

	'' temp string = src string
	function = astNewLINK( _
		astNewLINK( _
			astBuildTempVarClear( t->sym ), _
			rtlStrAssign( astNewVAR( t->sym ), n ), _
			FALSE ), _
		astNewVAR( t->sym ), _
		FALSE )

end function

'':::::
private function hAllocTmpWstrPtr _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as AST_TMPSTRLIST_ITEM ptr t = any

	'' create temp wstring ptr to pass as parameter
	t = hTmpStrListAdd( parent, NULL, typeAddrOf( FB_DATATYPE_WCHAR ), FALSE )

	'' evil hack: a function returning a "wstring" is actually returning a pointer,
	'' but NewAssign() shouldn't copy the string, just the pointer
	astSetType( n, typeAddrOf( FB_DATATYPE_WCHAR ), NULL )

	'' temp string = src string
	function = astNewASSIGN( astNewVAR( t->sym ), n )
end function

private function hCheckArgForStringParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval arg as ASTNODE ptr _
	) as ASTNODE ptr

	dim as integer argdtype = any, copyback = any

	argdtype = astGetDatatype( arg )

	'' Calling an rtlib function?
	if( parent->call.isrtl ) then
		'' passed byref?
		if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
			select case( argdtype )
			'' rtlib functions with BYREF AS STRING parameters will
			'' automatically free temp strings (i.e. CALL results),
			'' thus we don't need to do anything manually here in
			'' that case.
			case FB_DATATYPE_STRING
				if( astIsCALL( arg ) ) then
					assert( symbGetType( param ) = FB_DATATYPE_STRING )
					return arg
				end if

			'' Passing a fixed-length string or string literal to an
			'' rtlib function with BYREF AS STRING parameter.
			'' Optimization: Instead of creating a temp STRING to
			'' hold a copy of the string data, just create a temp
			'' string descriptor that references the existing data,
			'' but with read-only access. That's assuming the rtlib
			'' functions don't ever modify it.
			case FB_DATATYPE_CHAR, FB_DATATYPE_FIXSTR
				assert( symbGetType( param ) = FB_DATATYPE_STRING )
				return rtlStrAllocTmpDesc( arg )
			end select
		end if
	end if

	copyback = FALSE

	if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
		select case( argdtype )
		'' Fixed-length string to BYREF AS STRING param
		case FB_DATATYPE_FIXSTR
			'' must be copied to a temp STRING, which is then passed
			'' to the procedure. It may modify the given STRING,
			'' and the modified string should be copied back to the
			'' original fixed-length string after the procedure has
			'' returned.
			copyback = TRUE

			'' If the fixed-length string were a function result,
			'' then it'd be discarded and copying back wouldn't be
			'' needed. But currently we don't support returning
			'' fixed-length strings from functions.
			assert( astIsCALL( arg ) = FALSE )

#if 0
		''
		'' Copy back for z/wstrings can't be done safely.
		''
		'' If given a DEREF'ed zstring pointer, there's no way of
		'' knowing what it points to:
		''
		'' It could be a read-only string literal which we must never
		'' write to. It'd be nice right here if we could rely on
		'' CONSTness to detect that, but we can't because FB doesn't
		'' enforce CONSTness on string literals.
		''
		'' And either way, there's no way of knowing whether the given
		'' buffer will be big enough to hold the string that's supposed
		'' to be copied back.
		''
		'' Both these issues could be avoided by only copying back when
		'' given z/wstring vars, but then the behaviour is too
		'' inconsistent. It's better if z/wstring always behave the
		'' same, as opposed to copyback here, no copyback there.
		''
		'' I.e. copyback should only work for FIXSTR which is acceptable
		'' because FIXSTR can only appear on variables (not literals,
		'' and not DEREFs/CALLs), and STRING * N is arguable the same
		'' data type as STRING; or at least they're closer related than
		'' Z/WSTRING.
		''

		'' ZSTRINGs too
		case FB_DATATYPE_CHAR
			'' ditto, but must exclude string literals which have
			'' CHAR type (string literals are allowed to be passed
			'' to BYREF AS STRING parameters, through an implicitly
			'' created copy, but of course the string data can't be
			'' copied back into the read-only string literal), and
			'' DEREF'ed zstring pointers, because there's no way of
			'' knowing whether we can safely copyback in this case.
			copyback = (astGetStrLitSymbol( arg ) = NULL) and _
				(not astIsDEREF( arg ))

			'' ditto
			assert( astIsCALL( arg ) = FALSE )

		'' WSTRINGs too
		case FB_DATATYPE_WCHAR
			'' ditto, and also excluding CALLs because of the
			'' special WSTRING function results (no need to copy
			'' back into function results, they'll be discarded).
			copyback = (astGetStrLitSymbol( arg ) = NULL) and _
				(not astIsDEREF( arg )) and _
				(not astIsCALL( arg ))
#endif

		'' STRING to BYREF AS STRING
		case FB_DATATYPE_STRING
			'' Can pass as-is (preserving BYREF semantics) unless
			'' it's a function result, in which case a temp STRING
			'' is needed. (STRING results are special temp strings)
			if( astIsCALL( arg ) = FALSE ) then
				return arg
			end if
		end select
	end if

	'' Copy arg to temp STRING, then pass that temp
	function = hAllocTmpString( parent, arg, copyback )
end function

private sub hStrArgToStrPtrParam _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval checkrtl as integer _
	)

	if( checkrtl = FALSE ) then
		'' rtl? don't mess..
		if( parent->call.isrtl ) then
			return
		end if
	end if

	select case( astGetDatatype( n->l ) )
	case FB_DATATYPE_STRING
		'' If it's a STRING function result, copy to temp STRING so
		'' that the result is automatically freed later.
		if( astIsCALL( n->l ) ) then
			n->l = hAllocTmpString( parent, n->l, FALSE )
		end if

		n->l = astBuildStrPtr( n->l )
		n->dtype = n->l->dtype

	case FB_DATATYPE_FIXSTR
		assert( astIsCALL( n->l ) = FALSE )

		n->l = astNewCONV( typeAddrOf( FB_DATATYPE_CHAR ), NULL, astNewADDROF( n->l ) )
		n->dtype = n->l->dtype

	case FB_DATATYPE_CHAR
		n->l = astNewADDROF( n->l )
		n->dtype = n->l->dtype

	case FB_DATATYPE_WCHAR
		'' If it's a WSTRING function result, copy to temp WSTRING so
		'' that the result is automatically freed later.
		if( astIsCALL( n->l ) ) then
			n->l = hAllocTmpWstrPtr( parent, n->l )
		else
			n->l = astNewADDROF( n->l )
		end if

		n->dtype = n->l->dtype
	end select
end sub

sub hBuildByrefArg _
	( _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr, _
		byval arg as ASTNODE ptr _
	)

	arg = astNewADDROF( arg )
	arg = astNewCONV( typeAddrOf( symbGetFullType( param ) ), symbGetSubtype( param ), arg )
	assert( arg )

	n->l = arg
	n->arg.mode = FB_PARAMMODE_BYVAL

end sub

private sub hCheckByrefParam _
	( _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	)

    dim as ASTNODE ptr arg = n->l

	'' skip any casting if they won't do any conversion
	dim as ASTNODE ptr t = astSkipNoConvCAST( arg )

	'' If it's a CALL returning a STRING, it actually returns a pointer,
	'' which can be passed to the BYREF param as-is
	if( astIsCALL( t ) ) then
		select case as const( astGetDataType( arg ) )
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		     FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			exit sub
		end select
	end if

	select case as const( t->class )
	'' variable/object? take address and pass (BYREF semantics)
	'' also iif() and TYPEINIs/CALLCTORs whose temp vars can be passed.
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
	     AST_NODECLASS_FIELD, AST_NODECLASS_DEREF, _
	     AST_NODECLASS_IIF, _
	     AST_NODECLASS_TYPEINI, AST_NODECLASS_CALLCTOR

	case else
		'' Other expressions (especially BOPs, CONSTs, etc. that aren't variables/objects):
		'' store arg to a temp var, take address and pass
		arg = astNewASSIGN( astNewVAR( symbAddTempVar( arg->dtype, arg->subtype ) ), _
		                    arg, AST_OPOPT_DONTCHKPTR )

	end select

	'' take the address of
	hBuildByrefArg( param, n, arg )
end sub

'':::::
private function hCheckByDescParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr arg = n->l, desc_tree = any
    dim as integer arg_dtype = astGetDatatype( arg ), sym_dtype = any

	'' is arg a pointer?
	if( n->arg.mode = FB_PARAMMODE_BYVAL ) then
		return TRUE
	end if

	dim as FBSYMBOL ptr s = any, desc = any

	s = astGetSymbol( arg )

	if( s = NULL ) then
		errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
		return FALSE
	end if

	sym_dtype = symbGetType( param )

	'' same type? (don't check if it's a rtl proc, or a forward call)
	if( (parent->call.isrtl = FALSE) and (sym_dtype <> FB_DATATYPE_VOID) ) then
		if( (typeGetClass( arg_dtype ) <> typeGetClass( sym_dtype )) or _
			(typeGetSize( arg_dtype ) <> typeGetSize( sym_dtype )) ) then
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			return FALSE
		end if
	end if

	'' type field?
	if( symbGetClass( s ) = FB_SYMBCLASS_FIELD ) then
		'' not an array?
		if( symbGetArrayDimensions( s ) = 0 ) then
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			return FALSE
		end if

		'' create a temp array descriptor
		desc = hAllocTmpArrayDesc( s, arg, desc_tree )

	else
		'' an argument passed by descriptor?
		if( symbIsParamByDesc( s ) ) then
			'' it's a pointer, but it will be seen as anything else
			'' (ie: "array() as string"), so, remap the type
  			astDelTree( arg )
			n->l = astNewVAR( s, 0, typeAddrOf( FB_DATATYPE_VOID ) )
        	return TRUE
        end if

		'' it's a var? !!!WRITEME!!! (this probably needs to change
		'' if functions return arrays...)
		if( symbIsVar( s ) ) then
			'' not an array?
			desc = symbGetArrayDescriptor( s )
			if( desc = NULL ) then
				errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
				return FALSE
			end if
		else
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			return FALSE
		end if

    	desc_tree = NULL

    	'' remove node
    	astDelTree( arg )
    end if

	'' create a new
	n->l = astNewLINK( _
		astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), NULL, _
			astNewADDROF( astNewVAR( desc ) ) ), _
		desc_tree )

    function = TRUE

end function

'':::::
private function hCheckVarargParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr arg = n->l
    dim as integer arg_dtype = astGetDatatype( arg )

	select case as const typeGetClass( arg_dtype )
	'' var-len string? check..
	case FB_DATACLASS_STRING
		hStrArgToStrPtrParam( parent, n, FALSE )

	case FB_DATACLASS_INTEGER
		select case arg_dtype
		'' w|zstring? ditto..
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			hStrArgToStrPtrParam( parent, n, FALSE )

		case else
			'' if < sizeof(int), convert to int (C ABI)
			'' Even for 64bit, varargs are promoted to 32bit int.
			if( typeGetSize( arg_dtype ) < 4 ) then
				n->l = astNewCONV( iif( typeIsSigned( arg_dtype ), _
							FB_DATATYPE_LONG, _
							FB_DATATYPE_ULONG ), _
						NULL, arg )
			end if
		end select

	case FB_DATACLASS_FPOINT
		'' float? convert it to double (C ABI)
		if( arg_dtype = FB_DATATYPE_SINGLE ) then
			n->l = astNewCONV( FB_DATATYPE_DOUBLE, NULL, arg )
		end if

	case else
		errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
		return FALSE
	end select

	function = TRUE

end function

'':::::
private sub hCheckVoidParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	)

	dim as ASTNODE ptr arg = n->l

	if( n->arg.mode = FB_PARAMMODE_BYVAL ) then
		'' check strings passed BYVAL
		hStrArgToStrPtrParam( parent, n, FALSE )
		return
	end if

	'' another quirk: constants, pass byval even if BYVAL wasn't given
	if( env.clopt.lang <> FB_LANG_QB ) then
		if( astIsCONST( arg ) or astIsOFFSET( arg ) ) then
			return
		end if
	end if

	'' pass BYREF, check if a temp param isn't needed
	hCheckByrefParam( param, n )
end sub

private function hCheckStrParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as integer argdtype = astGetDatatype( n->l )

	'' check arg type
	select case as const( argdtype )
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR

	'' a z|wstring?
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

	'' not a string?
	case else
		errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
		return FALSE
	end select

	n->l = hCheckArgForStringParam( parent, param, n->l )

	select case( symbGetParamMode( param ) )
	'' BYREF AS STRING? Do the implicit address-of
	case FB_PARAMMODE_BYREF
		'' Unless it's a STRING function result, then it already is a
		'' pointer implicitly
		if( astIsCALL( n->l ) = FALSE ) then
			hBuildByrefArg( param, n, n->l )
		end if
	'' BYVAL AS STRING? Ditto (STRINGs are non-trivial, so a temp copy is
	'' passed BYREF implicitly)
	case FB_PARAMMODE_BYVAL
		hBuildByrefArg( param, n, n->l )
	end select

	function = TRUE
end function

private sub hByteByByte( byval param as FBSYMBOL ptr, byval n as ASTNODE ptr )
	'' UDT in memory, push byte-by-byte, by setting ASTNODE.arg.lgt,
	'' telling irEmitPUSHARG() to push this arg to stack byte-by-byte.
	'' Note: No rounding, to prevent overruns in the ASM
	n->arg.lgt = symbGetLen( symbGetSubtype( param ) )
end sub

private sub hUDTPassByval _
	( _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	)

	dim as FBSYMBOL ptr tmp = any
	dim as ASTNODE ptr arg = any, callexpr = any
	dim as integer is_ctorcall = any

	arg = n->l

	'' no dtor, copy-ctor or virtual members?
	if( symbCompIsTrivial( symbGetSubtype( param ) ) ) then
		if( astIsCALL( arg ) ) then
			if( symbProcReturnsOnStack( arg->sym ) ) then
				'' Returning on stack, access the temp result var
				n->l = astBuildCallResultVar( arg )
				hByteByByte( param, n )
			else
				assert( symbProcReturnsByref( arg->sym ) = FALSE )
				'' CALL with result in registers, patch the type
				astSetType( arg, symbGetProcRealType( arg->sym ), _
						symbGetProcRealSubtype( arg->sym ) )
			end if
		else
			'' not a CALL, so it must be an UDT in memory
			hByteByByte( param, n )
		end if

		exit sub
	end if

	'' Non-trivial type, pass a pointer to a temp copy (implicit BYREF)
	tmp = symbAddTempVar( symbGetFullType( param ), symbGetSubtype( param ) )
	astDtorListAdd( tmp )

	arg = n->l

	if( astIsTYPEINI( arg ) ) then
		'' TYPEINI (e.g. from parameter initializer), assign to the temp
		'' directly (it will probably always be a ctor call too, since
		'' the parameter initializer wouldn't have allowed anything else)
		arg = astNewLINK( astTypeIniFlush( arg, tmp, AST_INIOPT_NONE ), astNewVAR( tmp ), FALSE )
	else
		'' Otherwise, call a constructor
		arg = astBuildImplicitCtorCallEx( param, n->l, n->arg.mode, is_ctorcall )
		if( is_ctorcall ) then
			'' Wrap in a CALLCTOR again just for fun
			arg = astNewCALLCTOR( astPatchCtorCall( arg, astNewVAR( tmp ) ), astNewVAR( tmp ) )
		else
			'' Shallow copy, and return a VAR access on the temp var
			arg = astNewLINK( astNewASSIGN( astNewVAR( tmp ), arg ), astNewVAR( tmp ), FALSE )
		end if
	end if

	hBuildByrefArg( param, n, arg )

end sub

private function hImplicitCtor _
	( _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	static as integer rec_cnt = 0
	dim as ASTNODE ptr arg = any
	dim as FBSYMBOL ptr tmp = any
	dim as integer is_ctorcall = any

	if( symbHasCtor( param ) = FALSE ) then
		exit function
	end if

	'' recursion? (astBuildImplicitCtorCallEx() will call astNewARG() with the same expr)
	if( rec_cnt <> 0 ) then
		exit function
	end if

	'' try calling any ctor with the expression
	rec_cnt += 1
	arg = astBuildImplicitCtorCallEx( param, n->l, n->arg.mode, is_ctorcall )
	rec_cnt -= 1

	if( is_ctorcall = FALSE ) then
		'' No implicit construction possible, n->l is not changed
		exit function
	end if

	tmp = symbAddTempVar( symbGetFullType( param ), symbGetSubtype( param ) )
	astDtorListAdd( tmp )

	'' Using a CALLCTOR, to allow hUDTPassByval() to reuse this ctor call if possible
	'' (instead of making another temp copy)
	n->l = astNewCALLCTOR( astPatchCtorCall( arg, astNewVAR( tmp ) ), astNewVAR( tmp ) )

	if( symbGetParamMode( param ) = FB_PARAMMODE_BYVAL ) then
		hUDTPassByval( param, n )
	else
		hBuildByrefArg( param, n, n->l )
	end if

	function = TRUE
end function

'':::::
private function hCheckUDTParam _
	( _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as FBSYMBOL ptr tmp = any
	dim as ASTNODE ptr arg = n->l

	'' not another UDT?
	if( astGetDatatype( arg ) <> FB_DATATYPE_STRUCT ) then
		if( hImplicitCtor( param, n ) = FALSE ) then
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			return FALSE
		end if
		return TRUE
	end if

    '' check for invalid UDT's (different subtypes)
	if( arg->subtype <> symbGetSubtype( param ) ) then
		'' param is not a base type of arg?
		if( symbGetUDTBaseLevel( arg->subtype, symbGetSubtype( param ) ) = 0 ) then
			'' no ctor in the param's type?
			if( hImplicitCtor( param, n ) = FALSE ) then
				'' no cast operator? 
				arg = astNewCONV( symbGetType( param ), symbGetSubtype( param ), arg )
				if( arg = NULL ) then
					errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
					return FALSE
				end if
				n->l = arg
			else
				'' Found matching param.ctor to create param from arg
				return TRUE
			end if
		'' cast to the base type
		else
			arg = astNewCONV( symbGetType( param ), symbGetSubtype( param ), arg )
			n->l = arg
		end if
	end if

	select case symbGetParamMode( param )
	'' byref param?
	case FB_PARAMMODE_BYREF
		if( astIsCALL( arg ) ) then
			if( symbProcReturnsOnStack( arg->sym ) = FALSE ) then
				assert( symbProcReturnsByref( arg->sym ) = FALSE )

				'' Returning in registers, passed to a BYREF param
				'' Create a temp var and pass that
				tmp = symbAddTempVar( astGetDatatype( arg ), arg->subtype )

				'' No need to bother doing astDtorListAdd()
				assert( symbHasDtor( tmp ) = FALSE )

				n->l = astNewLINK( astNewADDROF( astBuildVarField( tmp ) ), _
						astNewASSIGN( astBuildVarField( tmp ), arg, AST_OPOPT_DONTCHKOPOVL ) )
				n->arg.mode = FB_PARAMMODE_BYVAL
				return TRUE
			end if
		end if

		hBuildByrefArg( param, n, arg )

	'' set the length if it's being passed by value
	case FB_PARAMMODE_BYVAL
		hUDTPassByval( param, n )

	end select

	function = TRUE
end function

'':::::
private function hCheckParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr arg = any
    dim as integer param_dtype = any, arg_dtype

    function = FALSE

	'' string concatenation is delayed for optimization reasons..
	n->l = astUpdStrConcat( n->l )

	arg = n->l

	'' strip the non-type flags
	param_dtype = symbGetType( param )
	arg_dtype   = astGetDatatype( arg )

	select case symbGetParamMode( param )
	'' by descriptor?
	case FB_PARAMMODE_BYDESC
        return hCheckByDescParam( parent, param, n )

    '' vararg?
    case FB_PARAMMODE_VARARG
		return hCheckVarargParam( parent, param, n )

	case FB_PARAMMODE_BYREF
		'' as any?
		if( param_dtype = FB_DATATYPE_VOID ) then
			hCheckVoidParam( parent, param, n )
			return TRUE
		end if

		'' passing a BYVAL ptr to an BYREF arg?
		if( n->arg.mode = FB_PARAMMODE_BYVAL ) then
			if( (typeGetClass( arg_dtype ) <> FB_DATACLASS_INTEGER) or _
				(typeGetSize( arg_dtype ) <> env.pointersize) ) then
				errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
				exit function
			end if
			return TRUE
		end if

		'' Passing a bitfield arg to a byref param? Can't be allowed,
		'' @udt.bitfield isn't possible either...
		if( astGetClass( arg ) = AST_NODECLASS_FIELD ) then
			if( symbFieldIsBitfield( arg->sym ) ) then
				errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
				exit function
			end if
		end if

	end select

	'' UDT arg? convert to param type if possible (including strings)
	select case arg_dtype
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		'' try implicit casting op overloading
		dim as integer err_num = any
		dim as FBSYMBOL ptr proc = any

		proc = symbFindCastOvlProc( symbGetFullType( param ), _
									symbGetSubtype( param ), _
									arg, _
									@err_num )

		if( proc <> NULL ) then
    		static as integer rec_cnt = 0
    		'' recursion? (astBuildCall() will call newARG with the same expr)
    		if( rec_cnt = 0 ) then
				'' build a proc call
				rec_cnt += 1
				n->l = astBuildCall( proc, arg )
				rec_cnt -= 1

				arg = n->l
				arg_dtype = astGetDatatype( arg )
			end if
		end if
	end select

	assert( param_dtype <> FB_DATATYPE_FIXSTR )

	select case( param_dtype )
	'' string param?
	case FB_DATATYPE_STRING
		return hCheckStrParam( parent, param, n )

	'' z/wstring param?
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		assert( symbGetParamMode( param ) = FB_PARAMMODE_BYREF )

		'' arg must be a string too (for z/wstring: it doesn't matter
		'' whether it's a DEREF or not, since DEREF can be handled as
		'' string just fine)
		select case( arg_dtype )
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		     FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			'' Rest will be handled below
		case else
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			exit function
		end select

	'' UDT param? check if the same, can't convert
	case FB_DATATYPE_STRUCT
		return hCheckUDTParam( param, n )
	end select

	select case as const arg_dtype
	'' string arg? check z- and w-string ptr params
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		select case param_dtype
		'' zstring ptr / zstring param?
		case typeAddrOf( FB_DATATYPE_CHAR ), FB_DATATYPE_CHAR
			'' if it's a wstring param, convert..
			if( arg_dtype = FB_DATATYPE_WCHAR ) then
				n->l = rtlToStr( arg, FALSE )
			end if

		'' wstring ptr / wstring?
		case typeAddrOf( FB_DATATYPE_WCHAR ), FB_DATATYPE_WCHAR
			'' if it's not a wstring param, convert..
			if( arg_dtype <> FB_DATATYPE_WCHAR ) then
				n->l = rtlToWstr( arg )
			end if

		case else
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			exit function
		end select

		hStrArgToStrPtrParam( parent, n, TRUE )

		if( typeIsPtr( param_dtype ) = FALSE ) then
			n = astNewDEREF( n )
			arg = n
		else
			arg = n->l
		end if

		arg_dtype = astGetDatatype( arg )

	'' UDT? implicit casting failed, can't convert..
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
		exit function
	end select

	'' enum args are only allowed to be passed enum or int params
	if( (param_dtype = FB_DATATYPE_ENUM) or (arg_dtype = FB_DATATYPE_ENUM) ) then
		if( typeGetClass( param_dtype ) <> typeGetClass( arg_dtype ) ) then
			errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
		end if
	end if

	'' pointer checking
	if( typeIsPtr( param_dtype ) ) then
		if( astPtrCheck( symbGetFullType( param ), symbGetSubtype( param ), arg ) = FALSE ) then
			if( typeIsPtr( arg_dtype ) = FALSE ) then
				errReportWarn( FB_WARNINGMSG_PASSINGSCALARASPTR )
			else
				'' if both are UDT, a base param can't be passed to a derived arg
				if( typeGetDtOnly( param_dtype ) = FB_DATATYPE_STRUCT and typeGetDtOnly( arg_dtype ) = FB_DATATYPE_STRUCT ) then
					if( symbGetUDTBaseLevel( symbGetSubtype( param ), astGetSubType( arg ) ) > 0 ) then
						errReport( FB_ERRMSG_INVALIDDATATYPES )
						exit function
					else
						errReportWarn( FB_WARNINGMSG_PASSINGDIFFPOINTERS )
					end if
				else
					errReportWarn( FB_WARNINGMSG_PASSINGDIFFPOINTERS )
				end if
			end if
		end if
	elseif( typeIsPtr( arg_dtype ) ) then
		errReportWarn( FB_WARNINGMSG_PASSINGPTRTOSCALAR )
	end if

	'' If types are still different, then try to convert the arg to the
	'' param's type. This is important for astLoadCALL() which determines
	'' the number of bytes to push/pop based on the ARG dtypes, and also
	'' helps the GCC/LLVM backends, which need to emit code with proper
	'' types to avoid errors/warnings from GCC/LLVM, unlike the ASM backend.
	if( (param_dtype <> arg_dtype) or (param->subtype <> arg->subtype) ) then
		'' Cannot pass BYREF if different size/class, but we do allow
		'' passing INTEGER vars to BYREF AS UINTEGER params etc.
		if( (typeGetSize( param_dtype ) <> typeGetSize( arg_dtype )) or _
		    (typeGetClass( param_dtype ) <> typeGetClass( arg_dtype ))    ) then
			if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
				'' skip any casting if they won't do any conversion
				dim as ASTNODE ptr t = astSkipNoConvCAST( arg )

				'' param diff than arg can't be passed by ref if it's a var/array/ptr
				'' (cannot pass a bytevar (1 byte) to BYREF INTEGER (4 bytes) param,
				''  that could cause a segfault)
				select case as const t->class
				case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
				     AST_NODECLASS_FIELD, AST_NODECLASS_DEREF, _
				     AST_NODECLASS_IIF
					errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
					exit function
				end select

				'' If it's an rvalue expression though then it's ok,
				'' because it will be stored into a temp var of the
				'' same type as the BYREF param. Then that temp var
				'' is given to the BYREF param, and then it's safe.
			end if
		end if

		arg = astNewCONV( symbGetFullType( param ), symbGetSubtype( param ), arg )
		if( arg = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if
		arg_dtype = astGetDatatype( arg )

		n->l = arg
	end if

	'' byref arg? check if a temp param isn't needed
	if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
		hCheckByrefParam( param, n )
        '' it's an implicit pointer
	end if

    function = TRUE

end function

private function hCreateOptArg( byval param as FBSYMBOL ptr ) as ASTNODE ptr
	dim as ASTNODE ptr tree = symbGetParamOptExpr( param )

	if( tree = NULL ) then
		return NULL
	end if

	'' make a clone
	'' Note: Cannot assume TYPEINI here, because of RTL functions with
	'' other initializer expressions
	if( astIsTYPEINI( tree ) ) then
		tree = astTypeIniClone( tree )

		'' Try to remove the TYPEINI if it was just used as a wrapper
		'' to handle temp vars
		tree = astTypeIniTryRemove( tree )
	else
		tree = astCloneTree( tree )
	end if

	function = tree
end function

'':::::
function astNewARG _
	( _
		byval parent as ASTNODE ptr, _
		byval arg as ASTNODE ptr, _
		byval dtype as integer, _
		byval mode as integer = INVALID _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any
    dim as FBSYMBOL ptr sym = any, param = any

	sym = parent->sym

	if( parent->call.args >= sym->proc.params ) then
		param = symbGetProcTailParam( sym )
	else
		param = parent->call.currarg
	end if

	'' optional/default?
	if( arg = NULL ) then
		arg = hCreateOptArg( param )
	end if

	if( dtype = FB_DATATYPE_INVALID ) then
		dtype = astGetFullType( arg )
	end if

	'' Complain about const arg passed to non-const non-byval param,
	'' unless it's a RTL function or the instance arg of a ctor/dtor call.
	'' (ctors/dtors should be able to operate even on const objects, because
	'' a ctor that can't initialize the object would be useless, and after
	'' dtors run the object is dead anyways, so modifications made by the
	'' dtor don't matter)
	if( ((symbGetIsRTL( sym ) = FALSE) or symbGetIsRTLConst( param )) and _
	    ((not symbIsParamInstance( param )) or _
	     ((not symbIsConstructor( sym )) and (not symbIsDestructor( sym )))) ) then
		if( symbCheckConstAssign( symbGetFullType( param ), dtype, param->subtype, arg->subtype, symbGetParamMode( param ) ) = FALSE ) then
			if( symbIsParamInstance( param ) ) then
				errReportParam( parent->sym, 0, NULL, FB_ERRMSG_CONSTUDTTONONCONSTMETHOD )
			else
				errReportParam( parent->sym, parent->call.args+1, NULL, FB_ERRMSG_ILLEGALASSIGNMENT )
			end if
			exit function
		end if
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ARG, FB_DATATYPE_INVALID )
	function = n

	n->sym = param
	n->l = arg
	n->arg.mode = mode
	n->arg.lgt = 0

	'' Add ARGs to the CALL in the order they'll be pushed
	if( symbGetProcMode( sym ) = FB_FUNCMODE_PASCAL ) then
		'' Pascal, push as-is, this ARG is added to the end of the list
		if( parent->r = NULL ) then
			parent->r = n
		else
			parent->call.argtail->r = n
		end if
		parent->call.argtail = n
		n->r = NULL
	else
		'' Non-pascal, push in reverse order,
		'' this ARG is added to the front of the list
		if( parent->r = NULL ) then
			parent->call.argtail = n
		end if
		n->r = parent->r
		parent->r = n
	end if

	errPushParamLocation( parent->sym, -1, parent->call.args+1, NULL )

	''
	if( hCheckParam( parent, param, n ) = FALSE ) then
		errPopParamLocation( )
		return NULL
	end if

	errPopParamLocation( )

	''
	parent->call.args += 1

	if( parent->call.args < sym->proc.params ) then
		parent->call.currarg = symbGetParamNext( parent->call.currarg )
	end if

end function

sub astReplaceInstanceArg _
	( _
		byval parent as ASTNODE ptr, _
		byval expr as ASTNODE ptr, _
		byval mode as integer _
	)

	dim as FBSYMBOL ptr sym = any, param = any
	dim as ASTNODE ptr n = any

	assert( astIsCALL( parent ) )
	sym = parent->sym

	'' For PASCAL procs, THIS will be the first ARG;
	'' for others, it will be the last
	if( symbGetProcMode( sym ) = FB_FUNCMODE_PASCAL ) then
		n = parent->r
	else
		n = parent->call.argtail
	end if

	param = symbGetProcHeadParam( sym )
	assert( symbIsParamInstance( param ) )

	'' Delete the old argument expression
	astDelTree( n->l )

	assert( n->sym = param )
	n->l = expr
	n->arg.mode = mode
	n->arg.lgt = 0

	hCheckParam( parent, param, n )
end sub
