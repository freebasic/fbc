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
	tree = astNewLINK( tree, astTypeIniFlush( desc, initree, FALSE, AST_OPOPT_ISINI ), AST_LINK_RETURN_NONE )

	function = desc
end function

private function hAddToCopyBackList _
	( _
		byval parent as ASTNODE ptr, _
		byval temp as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as AST_TMPSTRLIST_ITEM ptr

	dim as AST_TMPSTRLIST_ITEM ptr t = any

	t = listNewNode( @ast.call.tmpstrlist )

	t->prev = parent->call.strtail
	parent->call.strtail = t

	t->sym = temp
	t->srctree = astOptimizeTree( astCloneTree( n ) )

	function = t
end function

private function hAllocTmpString _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval copyback as integer _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr temp = any

	temp = symbAddTempVar( FB_DATATYPE_STRING )
	astDtorListAdd( temp )

	if( copyback ) then
		hAddToCopyBackList( parent, temp, n )
	end if

	'' temp string = src string
	function = astNewLINK( _
		astNewLINK( _
			astBuildTempVarClear( temp ), _
			rtlStrAssign( astNewVAR( temp ), n ), _
			AST_LINK_RETURN_NONE ), _
		astNewVAR( temp ), _
		AST_LINK_RETURN_RIGHT )
end function

private function hAllocTmpWstrPtr _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr temp = any

	temp = symbAddTempVar( typeAddrOf( FB_DATATYPE_WCHAR ) )
	symbSetIsWstring( temp )
	astDtorListAdd( temp )

	'' evil hack: a function returning a "wstring" is actually returning a pointer,
	'' but NewAssign() shouldn't copy the string, just the pointer
	astSetType( n, typeAddrOf( FB_DATATYPE_WCHAR ), NULL )

	'' temp string = src string
	function = astNewASSIGN( astNewVAR( temp ), n )
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

		'' *cast( [const] zstring const ptr ptr, @expr )
		'' Don't worry about preserving CONST bits, astNewARG() should have checked.
		n->l = astBuildStrPtr( n->l )

	case FB_DATATYPE_FIXSTR
		assert( astIsCALL( n->l ) = FALSE )

		n->l = astNewCONV( typeAddrOf( FB_DATATYPE_CHAR ), NULL, astNewADDROF( n->l ) )

	case FB_DATATYPE_CHAR
		n->l = astNewADDROF( n->l )

	case FB_DATATYPE_WCHAR
		'' If it's a WSTRING function result, copy to temp WSTRING so
		'' that the result is automatically freed later.
		if( astIsCALL( n->l ) ) then
			n->l = hAllocTmpWstrPtr( parent, n->l )
		else
			n->l = astNewADDROF( n->l )
		end if

	end select
end sub

sub hBuildByrefArg( byval param as FBSYMBOL ptr, byval n as ASTNODE ptr )
	n->l = astNewADDROF( astRemoveNoConvCAST( n->l ) )
	'' Don't warn on CONST qualifier changes, astNewARG() should have checked
	n->l = astNewCONV( typeAddrOf( symbGetFullType( param ) ), symbGetSubtype( param ), n->l, AST_CONVOPT_DONTWARNCONST )
	assert( n->l )
	n->arg.mode = FB_PARAMMODE_BYVAL
end sub

private sub hCheckByrefParam _
	( _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	)

	dim as ASTNODE ptr t = any

	'' skip any casting if they won't do any conversion
	'' TODO: astSkipConstCASTs() will skip over any CONST conversions
	'' This is OK when generating the final AST, as we probably no longer care
	'' about CONST.  However, if we ever get here and we expect PARSER/AST to
	'' return an error, or preserve the CONST conversion as part of the
	'' translation, this may introduce undesired behaviour.  Need to verify.
	'' Specifically, using astSkipConstCASTs() instead of astSkipNoConvCAST()
	'' allows us to fix the fbc crash as reported in sf.net bug #910
	t = astSkipConstCASTs( n->l )

	'' If it's a CALL returning a STRING, it actually returns a pointer,
	'' which can be passed to the BYREF param as-is
	if( astIsCALL( t ) ) then
		select case as const( astGetDataType( t ) )
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
			FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			exit sub
		end select
	end if

	'' If given a variable/object, we can just take its address and pass
	'' that (BYREF semantics). For other expressions though (especially
	'' BOPs, CONSTs, etc.) we have to create a temp var to hold the arg's
	'' value and then pass the temp var byref.
	if( astCanTakeAddrOf( t ) = FALSE ) then
		n->l = astNewASSIGN( _
			astNewVAR( symbAddTempVar( n->l->dtype, n->l->subtype ) ), _
			n->l, _
			AST_OPOPT_DONTCHKPTR or AST_OPOPT_ISINI )
	end if

	'' take the address of
	hBuildByrefArg( param, n )
end sub

'' Check whether an array (could be a var/field or a paramvar itself) can be passed
'' to an array parameter.
'' 1. If the BYDESC param itself has unknown dimensions, it can accept any arrays
'' 2. If the argument array has unknown dimensions, it can be passed to any array parameter
'' 3. Otherwise (if both have known dimensions) they must have the same dimension count
private function hCheckBydescDimensions( byval param as FBSYMBOL ptr, byval arg as FBSYMBOL ptr ) as integer
	assert( param->class = FB_SYMBCLASS_PARAM )
	assert( symbIsVar( arg ) or symbIsField( arg ) )

	return (symbGetArrayDimensions( arg ) = -1) or _
		(param->param.bydescdimensions = -1) or _
		(param->param.bydescdimensions = symbGetArrayDimensions( arg ))
end function

private function hCheckByDescParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr desc_tree = any
	dim as integer arg_dtype = any, sym_dtype = any
	dim as FBSYMBOL ptr s = any, desc = any

	arg_dtype = astGetDatatype( n->l )
	function = FALSE

	'' is arg a pointer?
	if( n->arg.mode = FB_PARAMMODE_BYVAL ) then
		return TRUE
	end if

	s = astGetSymbol( n->l )
	if( s = NULL ) then
		exit function
	end if

	'' same type? (don't check if it's a rtl proc, or a forward call)
	sym_dtype = symbGetType( param )
	if( (parent->call.isrtl = FALSE) and (sym_dtype <> FB_DATATYPE_VOID) ) then
		if( (typeGetClass( arg_dtype ) <> typeGetClass( sym_dtype )) or _
			(typeGetSize( arg_dtype ) <> typeGetSize( sym_dtype )) ) then
			exit function
		end if
	end if

	'' both UDT?
	if( (sym_dtype = FB_DATATYPE_STRUCT) and (arg_dtype = FB_DATATYPE_STRUCT) ) then
		if( n->l->subtype <> symbGetSubtype( param ) ) then
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			exit function
		end if
	end if

	if( astIsVAR( n->l ) ) then
		assert( symbIsVar( s ) )

		'' BYDESC param passed to BYDESC param?
		if( symbIsParamVarByDesc( s ) ) then
			if( hCheckBydescDimensions( param, s ) = FALSE ) then
				exit function
			end if

			'' it's a pointer, but it will be seen as anything else
			'' (ie: "array() as string"), so, remap the type
			assert( symbIsStruct( s->var_.array.desctype ) and symbIsDescriptor( s->var_.array.desctype ) )
			astSetType( n->l, typeAddrOf( FB_DATATYPE_STRUCT ), s->var_.array.desctype )
			return TRUE
		end if

		'' Variable: If it's an array, then it will have an array descriptor,
		'' except if it's still incomplete (during initialization of array with
		'' ellipsis)
		desc = symbGetArrayDescriptor( s )
		if( desc ) then
			if( hCheckBydescDimensions( param, s ) = FALSE ) then
				exit function
			end if

			astDelTree( n->l )
			n->l = astNewADDROF( astNewVAR( desc ) )
			return TRUE
		end if

	elseif( astIsFIELD( n->l ) ) then
		assert( symbIsField( s ) )

		if( symbIsDynamic( s ) ) then
			if( hCheckBydescDimensions( param, s ) = FALSE ) then
				exit function
			end if

			'' Dynamic array fields: If an access to the fake array field is given,
			'' how to build the access to descriptor? The FIELD node may be optimized
			'' already, and there probably is no way to tell the UDT access expression
			'' apart from the field offset expression.
			''
			'' Luckily the fake dynamic array field is given the same field offset as
			'' the descriptor, so the expressions would be the same, except for the
			'' data types, which we can fix up here though.
			desc = symbGetArrayDescriptor( s )
			astSetType( n->l, symbGetFullType( desc ), symbGetSubtype( desc ) )

			'' + the implicit ADDROF
			n->l = astNewADDROF( n->l )
			return TRUE

		elseif( symbGetArrayDimensions( s ) > 0 ) then
			if( hCheckBydescDimensions( param, s ) = FALSE ) then
				exit function
			end if

			'' Static array field: Create a temp array descriptor
			desc = hAllocTmpArrayDesc( s, n->l, desc_tree )
			n->l = astNewLINK( astNewADDROF( astNewVAR( desc ) ), desc_tree, AST_LINK_RETURN_LEFT )
			return TRUE
		end if
	end if
end function

'':::::
private function hCheckVarargParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as integer arg_dtype = astGetDatatype( n->l )

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
						NULL, n->l )
			end if
		end select

	case FB_DATACLASS_FPOINT
		'' float? convert it to double (C ABI)
		if( arg_dtype = FB_DATATYPE_SINGLE ) then
			n->l = astNewCONV( FB_DATATYPE_DOUBLE, NULL, n->l )
		end if

	case else
		errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
		return FALSE
	end select

	function = TRUE

end function

private sub hCheckVoidParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	)

	if( n->arg.mode = FB_PARAMMODE_BYVAL ) then
		'' check strings passed BYVAL
		hStrArgToStrPtrParam( parent, n, FALSE )
		return
	end if

	'' another quirk: constants, pass byval even if BYVAL wasn't given
	if( env.clopt.lang <> FB_LANG_QB ) then
		if( astIsCONST( n->l ) or astIsOFFSET( n->l ) ) then
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
			hBuildByrefArg( param, n )
		end if
	'' BYVAL AS STRING? Ditto (STRINGs are non-trivial, so a temp copy is
	'' passed BYREF implicitly)
	case FB_PARAMMODE_BYVAL
		hBuildByrefArg( param, n )
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
	dim as ASTNODE ptr t = any, callexpr = any
	dim as integer is_ctorcall = any

	t = astSkipNoConvCAST( n->l )

	'' no dtor, copy-ctor or virtual members?
	if( symbCompIsTrivial( symbGetSubtype( param ) ) ) then
		if( astIsCALL( t ) ) then
			n->l = astRemoveNoConvCAST( n->l )
			assert( astIsCALL( n->l ) )
			if( symbProcReturnsOnStack( n->l->sym ) ) then
				'' Returning on stack, access the temp result var
				n->l = astBuildCallResultVar( n->l )
				hByteByByte( param, n )
			else
				assert( symbIsReturnByRef( n->l->sym ) = FALSE )
				'' CALL with result in registers, patch the type
				astSetType( n->l, symbGetProcRealType( n->l->sym ), _
						symbGetProcRealSubtype( n->l->sym ) )
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

	if( astIsTYPEINI( t ) ) then
		'' TYPEINI (e.g. from parameter initializer), assign to the temp
		'' directly (it will probably always be a ctor call too, since
		'' the parameter initializer wouldn't have allowed anything else)
		n->l = astRemoveNoConvCAST( n->l )
		assert( astIsTYPEINI( n->l ) )
		n->l = astNewLINK( astTypeIniFlush( tmp, n->l, TRUE, AST_OPOPT_ISINI ), astNewVAR( tmp ), AST_LINK_RETURN_RIGHT )
	else
		'' Otherwise, call a constructor
		n->l = astBuildImplicitCtorCallEx( param, n->l, n->arg.mode, is_ctorcall )
		if( is_ctorcall ) then
			'' Wrap in a CALLCTOR again just for fun
			n->l = astNewCALLCTOR( astPatchCtorCall( n->l, astNewVAR( tmp ) ), astNewVAR( tmp ) )
		else
			'' Shallow copy, and return a VAR access on the temp var
			n->l = astNewLINK( _
				astNewASSIGN( astNewVAR( tmp ), n->l, AST_OPOPT_ISINI ), _
				astNewVAR( tmp ), _
				AST_LINK_RETURN_RIGHT )
		end if
	end if

	hBuildByrefArg( param, n )

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
		hBuildByrefArg( param, n )
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

	'' not another UDT?
	if( astGetDatatype( n->l ) <> FB_DATATYPE_STRUCT ) then
		if( hImplicitCtor( param, n ) = FALSE ) then
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			return FALSE
		end if
		return TRUE
	end if

	'' check for invalid UDT's (different subtypes)
	if( n->l->subtype <> symbGetSubtype( param ) ) then
		'' param is not a base type of arg?
		if( symbGetUDTBaseLevel( n->l->subtype, symbGetSubtype( param ) ) = 0 ) then
			'' no ctor in the param's type?
			if( hImplicitCtor( param, n ) = FALSE ) then
				'' no cast operator?
				n->l = astNewCONV( symbGetType( param ), symbGetSubtype( param ), n->l )
				if( n->l = NULL ) then
					errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
					return FALSE
				end if
			else
				'' Found matching param.ctor to create param from arg
				return TRUE
			end if
		'' cast to the base type
		else
			n->l = astNewCONV( symbGetType( param ), symbGetSubtype( param ), n->l )
		end if
	end if

	select case symbGetParamMode( param )
	'' byref param?
	case FB_PARAMMODE_BYREF
		n->l = astRemoveNoConvCAST( n->l )

		if( astIsCALL( n->l ) ) then
			if( symbProcReturnsOnStack( n->l->sym ) = FALSE ) then
				assert( symbIsRef( n->l->sym ) = FALSE )

				'' Returning in registers, passed to a BYREF param
				'' Create a temp var and pass that
				tmp = symbAddTempVar( astGetDatatype( n->l ), n->l->subtype )

				'' No need to bother doing astDtorListAdd()
				assert( symbHasDtor( tmp ) = FALSE )

				n->l = astNewLINK( _
					astNewASSIGN( astBuildVarField( tmp ), n->l, AST_OPOPT_DONTCHKOPOVL or AST_OPOPT_ISINI ), _
					astNewADDROF( astBuildVarField( tmp ) ), _
					AST_LINK_RETURN_RIGHT )
				n->arg.mode = FB_PARAMMODE_BYVAL
				return TRUE
			end if
		end if

		hBuildByrefArg( param, n )

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

	dim as integer param_dtype = any, arg_dtype = any

	function = FALSE

	'' string concatenation is delayed for optimization reasons..
	n->l = astUpdStrConcat( n->l )

	'' strip the non-type flags
	param_dtype = symbGetType( param )
	arg_dtype   = astGetDatatype( n->l )

	select case symbGetParamMode( param )
	'' by descriptor?
	case FB_PARAMMODE_BYDESC
		if( hCheckByDescParam( parent, param, n ) = FALSE ) then
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			exit function
		end if

		return TRUE

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
		if( astIsBITFIELD( n->l ) ) then
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			exit function
		end if

	end select

	'' UDT arg? convert to param type if possible (including strings)
	select case arg_dtype
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		'' try implicit constructor and casting op overloading
		dim as integer err_num = any
		dim as FBSYMBOL ptr proc = any

		'' try constructor first - but only if byval parameter
		if( symbGetParamMode( param ) = FB_PARAMMODE_BYVAL ) then
			proc = symbFindCtorOvlProc( symbGetSubtype( param ), n->l, symbGetParamMode( param ), _
			                            @err_num, FB_SYMBFINDOPT_NO_CAST )

			if( proc <> NULL ) then
				return hCheckUDTParam( param, n )
			end if
		end if

		'' try implicit casting op overloading
		proc = symbFindCastOvlProc( symbGetFullType( param ), symbGetSubtype( param ), _
		                            n->l, @err_num )

		if( proc <> NULL ) then
			static as integer rec_cnt = 0
			'' recursion? (astBuildCall() will call newARG with the same expr)
			if( rec_cnt = 0 ) then
				'' build a proc call
				rec_cnt += 1
				n->l = astBuildCall( proc, n->l )
				rec_cnt -= 1

				arg_dtype = astGetDatatype( n->l )
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
				n->l = rtlToStr( n->l, FALSE )
			end if

		'' wstring ptr / wstring?
		case typeAddrOf( FB_DATATYPE_WCHAR ), FB_DATATYPE_WCHAR
			'' if it's not a wstring param, convert..
			if( arg_dtype <> FB_DATATYPE_WCHAR ) then
				n->l = rtlToWstr( n->l )
			end if

		case else
			errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
			exit function
		end select

		hStrArgToStrPtrParam( parent, n, TRUE )

		if( typeIsPtr( param_dtype ) = FALSE ) then
			n->l = astNewDEREF( n->l )
		end if

		arg_dtype = astGetDatatype( n->l )

	'' UDT? implicit casting failed, can't convert..
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
		exit function
	end select

	'' enum args are only allowed to be passed to enum or int params
	if( (param_dtype = FB_DATATYPE_ENUM) or (arg_dtype = FB_DATATYPE_ENUM) ) then
		if( typeGetClass( param_dtype ) <> typeGetClass( arg_dtype ) ) then
			errReportWarn( FB_WARNINGMSG_IMPLICITCONVERSION )
		end if
	end if

	'' pointer checking
	if( typeIsPtr( param_dtype ) ) then
		if( astPtrCheck( param->typ, param->subtype, param->param.mode, n->l ) = FALSE ) then
			if( typeIsPtr( arg_dtype ) = FALSE ) then
				errReportWarn( FB_WARNINGMSG_PASSINGSCALARASPTR )
			else
				'' if both are UDT, a base arg can't be passed to a derived param
				if( typeGetDtOnly( param_dtype ) = FB_DATATYPE_STRUCT and typeGetDtOnly( arg_dtype ) = FB_DATATYPE_STRUCT ) then
					if( symbGetUDTBaseLevel( symbGetSubtype( param ), astGetSubType( n->l ) ) > 0 ) then
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
	if( (param_dtype <> arg_dtype) or (param->subtype <> n->l->subtype) ) then
		'' Cannot pass BYREF if different size/class, but we do allow
		'' passing INTEGER vars to BYREF AS UINTEGER params etc.
		if( (typeGetSize( param_dtype ) <> typeGetSize( arg_dtype )) or _
			(typeGetClass( param_dtype ) <> typeGetClass( arg_dtype ))    ) then
			if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
				'' Different size/dclass; can't allow passing BYREF
				'' if it's a var because the pointer types are
				'' incompatible. But if it's not a var then it's ok
				'' because hCheckByrefParam() will copy the arg into
				'' a temp var of the proper type.
				if( astCanTakeAddrOf( astSkipNoConvCAST( n->l ) ) ) then
					errReport( FB_ERRMSG_PARAMTYPEMISMATCHAT )
					exit function
				end if
			end if
		end if

		n->l = astNewCONV( symbGetFullType( param ), symbGetSubtype( param ), n->l )
		if( n->l = NULL ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if
		arg_dtype = astGetDatatype( n->l )
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

		'' still NULL? then hCreateOptArg() failed
		if( arg = NULL ) then
			function = NULL
			exit function
		end if
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
	if( ((not symbIsInstanceParam( param )) or _
		((sym->pattrib and FB_PROCATTRIB_NOTHISCONSTNESS) = 0)) ) then
		if( symbCheckConstAssignTopLevel( symbGetFullType( param ), dtype, param->subtype, arg->subtype, symbGetParamMode( param ) ) = FALSE ) then
			if( symbIsInstanceParam( param ) ) then
				errReportParam( parent->sym, 0, NULL, FB_ERRMSG_CONSTUDTTONONCONSTMETHOD )
			else
				errReportParam( parent->sym, parent->call.args+1, NULL, FB_ERRMSG_ILLEGALASSIGNMENT )
			end if
			function = NULL
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
	assert( symbIsInstanceParam( param ) )

	'' Delete the old argument expression
	astDelTree( n->l )

	assert( n->sym = param )
	n->l = expr
	n->arg.mode = mode
	n->arg.lgt = 0

	hCheckParam( parent, param, n )
end sub
