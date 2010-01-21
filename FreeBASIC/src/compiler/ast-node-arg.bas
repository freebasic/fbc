''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.

'' AST function argument nodes
'' l = expression; r = next argument
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private function hParamError _
	( _
		byval parent as ASTNODE ptr, _
		byval msgnum as integer = FB_ERRMSG_PARAMTYPEMISMATCHAT _
	) as integer

	function = errReportParam( parent->sym, parent->call.args+1, NULL, msgnum )

end function

'':::::
private sub hParamWarning _
	( _
		byval parent as ASTNODE ptr, _
		byval msgnum as integer _
	)

	errReportParamWarn( parent->sym, parent->call.args+1, NULL, msgnum )

end sub

'':::::
private function hAllocTmpArrayDesc _
	( _
		byval array as FBSYMBOL ptr, _
		byval array_expr as ASTNODE ptr, _
		byref tree as ASTNODE ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr desc = any

	'' create
	desc = symbAddArrayDesc( array, symbGetArrayDimensions( array ) )

	'' don't let NewDECL() fill it
	symbGetTypeIniTree( desc ) = astBuildArrayDescIniTree( desc, _
														   array, _
														   array_expr )



	'' declare
	tree = astNewDECL( FB_SYMBCLASS_VAR, _
					   desc, _
					   symbGetTypeIniTree( desc ) )

	'' flush (see symbAddArrayDesc(), the desc can't never be static)
	tree = astNewLINK( tree, _
					   astTypeIniFlush( symbGetTypeIniTree( desc ), _
					   					desc, _
					   					AST_INIOPT_ISINI ) )

	symbSetTypeIniTree( desc, NULL )

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

	s = symbAddTempVar( dtype, NULL, FALSE, FALSE )

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
	function = astNewLINK( astNewVAR( t->sym, _
									  0, _
									  FB_DATATYPE_STRING, _
									  NULL, _
									  TRUE ), _
						   rtlStrAssign( astNewVAR( t->sym, _
												 	0, _
												 	FB_DATATYPE_STRING, _
												 	NULL ), _
						 			  	  n ) )

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
	return astNewASSIGN( astNewVAR( t->sym, _
									0, _
									typeAddrOf( FB_DATATYPE_WCHAR ), _
									NULL, _
									TRUE ), _
						 n )

end function

'':::::
private function hCheckStringArg _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval arg as ASTNODE ptr _
	) as ASTNODE ptr

    dim as integer arg_dtype = any, copyback = any

	function = arg

	arg_dtype = astGetDatatype( arg )

	'' calling the runtime lib?
	if( parent->call.isrtl ) then

		'' passed byref?
		if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then

			select case arg_dtype
			'' var-len param: all rtlib procs will free the
			'' temporary strings and descriptors automatically
			case FB_DATATYPE_STRING
				exit function

			'' wstring? convert and let rtl to free the temp
			'' var-len result..
			case FB_DATATYPE_WCHAR
				return hAllocTmpString( parent, arg, FALSE )

			'' anything else, just alloc a temp descriptor (assuming
			'' here that no rtlib function will EVER change the
			'' strings passed as param)
			case else
				return rtlStrAllocTmpDesc( arg )
			end select

		'' passed byval..
		else

			'' var-len?
			select case arg_dtype
			case FB_DATATYPE_STRING
				'' not a temp var-len returned by functions? skip..
				if( arg->class <> AST_NODECLASS_CALL ) then
					exit function
				end if

			'' wstring? convert and add it delete list or the
			'' temp var-len result would leak
			case FB_DATATYPE_WCHAR
				'' let hAllocTmpString() do it..

			'' anything else, do nothing..
			case else
				exit function
			end select

			'' create temp string to pass as parameter
			return hAllocTmpString( parent, arg, FALSE )

		end if

	end if

	'' it's not a rtl function.. var-len strings won't be automatically
	'' removed nor it's safe to pass non fixed-len strings to var-len
	'' params as they can be modified inside the callee function..
	copyback = FALSE

	select case symbGetParamMode( param )
	'' passed by reference?
	case FB_PARAMMODE_BYREF

    	select case arg_dtype
    	'' fixed-length?
    	case FB_DATATYPE_FIXSTR
    		'' byref arg and fixed-len param: alloc a temp string, copy
    		'' fixed to temp and pass temp
			'' (ast will have to copy temp back to fixed when function
			'' returns and delete temp)

			'' don't copy back if it's a function returning a fixed-len
			if( arg->class <> AST_NODECLASS_CALL ) then
				copyback = TRUE
			end if

    	'' var-len?
    	case FB_DATATYPE_STRING
    		'' if not a function's result, skip..
    		if( arg->class <> AST_NODECLASS_CALL ) then
    			exit function
            end if

		'' wstring? it must be converted and the temp var-len result
		'' have to be deleted when the function return
		case FB_DATATYPE_WCHAR
			'' let hAllocTmpString() do it..

    	'' anything else..
    	case else
    		'' byref arg and byte/w|zstring/ptr param: alloc a temp
    		'' string, copy byte ptr to temp and pass temp

    	end select

    '' passed by value?
    case FB_PARAMMODE_BYVAL

		select case arg_dtype
		'' var-len?
		case FB_DATATYPE_STRING

			'' not a temp var-len function result? do nothing..
			if( arg->class <> AST_NODECLASS_CALL ) then
				exit function
			end if

		'' wstring? it must be converted and the temp var-len result
		'' have to be deleted when the function return
		case FB_DATATYPE_WCHAR
			'' let hAllocTmpString() do it..

		'' anything else, do nothing..
		case else
			exit function
		end select

	end select

	'' create temp string to pass as parameter
	function = hAllocTmpString( parent, arg, copyback )

end function

'':::::
private function hStrArgToStrPtrParam _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval checkrtl as integer _
	) as integer

	dim as ASTNODE ptr arg = n->l
	dim as integer arg_dtype = astGetDatatype( arg )

	if( checkrtl = FALSE ) then
		'' rtl? don't mess..
		if( parent->call.isrtl ) then
			return TRUE
		end if
	end if

	'' var- or fixed-len string param?
	if( symbGetDataClass( arg_dtype ) = FB_DATACLASS_STRING ) then

		'' if it's a function returning a STRING, it will have to be
		'' deleted automagically when the proc being called return
		if( arg->class = AST_NODECLASS_CALL ) then
			'' create a temp string to pass as parameter (no copy is
			'' done at rtlib, as the returned string is a temp too)
			n->l = hAllocTmpString( parent, arg, FALSE )
			arg_dtype = FB_DATATYPE_STRING
        end if

		'' not fixed-len? deref var-len
		if( arg_dtype <> FB_DATATYPE_FIXSTR ) then
			n->l = astBuildStrPtr( n->l )

        '' fixed-len..
        else
            '' get the address of
			n->l = astNewCONV( typeAddrOf( FB_DATATYPE_CHAR ), _
    					   	   NULL, _
						   	   astNewADDROF( n->l ) )
		end if

		astGetFullType( n ) = astGetFullType( astGetLeft( n ) )

	'' w- or z-string
	else
    	select case arg_dtype
    	'' zstring? take the address of
    	case FB_DATATYPE_CHAR
			n->l = astNewADDROF( arg )
			astGetFullType( n ) = astGetFullType( astGetLeft( n ) )

		'' wstring?
		case FB_DATATYPE_WCHAR

			'' if it's a function returning a WSTRING, it will have to be
			'' deleted automatically when the proc being called return
			if( astIsCALL( arg ) ) then
            	n->l = hAllocTmpWstrPtr( parent, arg )

			'' not a temporary..
			else
				'' take the address of
				n->l = astNewADDROF( arg )
			end if

			astGetFullType( n ) = astGetFullType( astGetLeft( n ) )

		end select

	end if

	function = TRUE

end function

'':::::
#macro hBuildByrefArg( n_, arg_ )

	n_->l = astNewADDROF( arg_ )
	n_->arg.mode = FB_PARAMMODE_BYVAL

#endmacro

'':::::
private function hCheckByRefArg _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

    dim as ASTNODE ptr arg = n->l

	'' skip any casting if they won't do any conversion
	dim as ASTNODE ptr t = arg
	if( arg->class = AST_NODECLASS_CONV ) then
		if( arg->cast.doconv = FALSE ) then
			t = arg->l
		end if
	end if

	select case as const t->class
	'' var, array index or pointer? pass as-is (assuming the type was already checked)
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
		 AST_NODECLASS_FIELD, AST_NODECLASS_DEREF

	case else
		'' string? do nothing (ie: functions returning var-len string's)
		select case as const typeGet( dtype )
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			return TRUE

		'' UDT? do nothing, just take the address of
		case FB_DATATYPE_STRUCT

		case else
			'' scalars: store param to a temp var and pass it
			arg = astNewASSIGN( astNewVAR( symbAddTempVar( dtype, subtype, FALSE, FALSE ), _
									 	   0, _
									 	   dtype, _
									 	   subtype ), _
							    arg, _
							    AST_OPOPT_DONTCHKPTR )
		end select

	end select

	'' take the address of
    hBuildByrefArg( n, arg )

	function = TRUE

end function

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
		hParamError( parent )
		return FALSE
	end if

	sym_dtype = symbGetType( param )

	'' same type? (don't check if it's a rtl proc, or a forward call)
	if( (parent->call.isrtl = FALSE) and (sym_dtype <> FB_DATATYPE_VOID) ) then
		if( (symbGetDataClass( arg_dtype ) <> symbGetDataClass( sym_dtype )) or _
			(symbGetDataSize( arg_dtype ) <> symbGetDataSize( sym_dtype )) ) then
			hParamError( parent )
			return FALSE
		end if
	end if

	'' type field?
	if( symbGetClass( s ) = FB_SYMBCLASS_FIELD ) then
		'' not an array?
		if( symbGetArrayDimensions( s ) = 0 ) then
			hParamError( parent )
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
				hParamError( parent )
				return FALSE
			end if
		else
			hParamError( parent )
			return FALSE
		end if

    	desc_tree = NULL

    	'' remove node
    	astDelTree( arg )
    end if

    '' create a new
    n->l = astNewLINK( astNewCONV( typeAddrOf( FB_DATATYPE_VOID ), _
    							   NULL, _
    				   			   astNewADDROF( astNewVAR( desc, _
        					   	  			  				0, _
        					   	  			  				FB_DATATYPE_STRUCT, _
        					   	  			  				symb.arrdesctype ) ) ), _
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

	select case as const symbGetDataClass( arg_dtype )
	'' var-len string? check..
	case FB_DATACLASS_STRING
		return hStrArgToStrPtrParam( parent, n, FALSE )

	case FB_DATACLASS_INTEGER
		select case arg_dtype
		'' w|zstring? ditto..
		case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			return hStrArgToStrPtrParam( parent, n, FALSE )

		case else
			'' if < len(integer), convert to int (C ABI)
			if( symbGetDataSize( arg_dtype ) < FB_INTEGERSIZE ) then
				n->l = astNewCONV( iif( symbIsSigned( arg_dtype ), _
									   	FB_DATATYPE_INTEGER, _
									   	FB_DATATYPE_UINT ), _
								   NULL, _
								   arg )
			end if
		end select

	case FB_DATACLASS_FPOINT
		'' float? convert it to double (C ABI)
		if( arg_dtype = FB_DATATYPE_SINGLE ) then
			n->l = astNewCONV( FB_DATATYPE_DOUBLE, NULL, arg )
		end if

	case else
		hParamError( parent )
		return FALSE
	end select

	function = TRUE

end function

'':::::
private function hCheckVoidParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr arg = n->l
	dim as integer arg_dtype = astGetDatatype( arg )

	if( n->arg.mode = FB_PARAMMODE_BYVAL ) then
		'' check strings passed BYVAL
		return hStrArgToStrPtrParam( parent, n, FALSE )
	end if

	'' another quirk: constants, pass byval even if BYVAL wasn't given
	if( env.clopt.lang <> FB_LANG_QB ) then
		if( astIsCONST( arg ) or astIsOFFSET( arg ) ) then
			return TRUE
		end if
	end if

	'' pass BYREF, check if a temp param isn't needed
	'' use the arg type, not the param one (as it's VOID)
	function = hCheckByRefArg( astGetFullType( arg ), arg->subtype, n ) <> NULL

end function

'':::::
private function hCheckStrParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr arg = n->l
	dim as integer arg_dtype = astGetDatatype( arg )

	'' check arg type
	select case as const arg_dtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR

	'' a z|wstring?
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

	'' not a string?
	case else
		hParamError( parent )
		return FALSE
	end select

	'' byval and variable:
	''   pass the pointer at ofs 0 of the string descriptor
	'' byval and fixed/zstring:
	''   pass the pointer as-is
	'' byval and wstring
	''	 same as above but convert to ascii first

	'' byref and variable:
	''   pass the pointer to descriptor
	'' byref and fixed/zstring:
	''   alloc a temp string, copy fixed to temp, pass temp,
	''	 copy temp back to fixed when func returns, del temp
	'' byref and wstring
	''	 same as above but convert to ascii first

	'' alloc a temp string if needed
	arg = hCheckStringArg( parent, param, arg )
	n->l = arg

	'' byval param?
	if( symbGetParamMode( param ) = FB_PARAMMODE_BYVAL ) then
		'' var-len? deref..
		if( arg_dtype = FB_DATATYPE_STRING ) then
			n->l = astBuildStrPtr( arg )
			return TRUE
		end if
	end if

	'' if it's a function returning a STRING, it's actually a pointer
	if( arg->class <> AST_NODECLASS_CALL ) then
		n->l = astNewADDROF( arg )
	end if

	function = TRUE

end function

'':::::
private sub hUDTPassByval _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	)

	dim as ASTNODE ptr arg = n->l

	'' no dtor, copy-ctor or virtual members?
	if( symbIsTrivial( symbGetSubtype( param ) ) ) then
		dim as FBSYMBOL ptr subtype = arg->subtype

		'' not returned in registers?
		dim as integer is_udt = TRUE
		if( astIsCALL( arg ) ) then
			is_udt = typeGetDtAndPtrOnly( symbGetUDTRetType( subtype ) ) = typeAddrOf( FB_DATATYPE_STRUCT )
		end if

		'' udt? push byte by byte to stack
		if( is_udt ) then
			n->arg.lgt = FB_ROUNDLEN( symbGetLen( symbGetSubtype( param ) ) )

			'' call? use the hidden call arg
			if( astIsCALL( arg ) ) then
				n->l = astBuildCallHiddenResVar( arg )
			end if

		else
			'' patch the type
			astSetType( arg, symbGetUDTRetType( subtype ), NULL )
		end if

		exit sub
	end if

	'' non-trivial type, pass a pointer to a temp copy
	dim as FBSYMBOL ptr tmp = any
	tmp = symbAddTempVar( symbGetFullType( param ), _
						  symbGetSubtype( param ), _
						  FALSE, _
						  FALSE )

	arg = astNewCALLCTOR( astBuildCopyCtorCall( astBuildVarField( tmp ), arg ), _
						  astBuildVarField( tmp ) )

	hBuildByrefArg( n, arg )

	if( symbGetHasDtor( symbGetSubtype( param ) ) ) then
		astDtorListAdd( tmp )
	end if

end sub

'':::::
private function hImplicitCtor _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

   	static as integer rec_cnt = 0

   	dim as FBSYMBOL ptr subtype = symbGetSubtype( param )
   	dim as integer param_dtype = symbGetType( param )

   	if( symbGetHasCtor( subtype ) = FALSE ) then
   		return FALSE
   	end if

    '' recursion? (astBuildImplicitCtorCall() will call newARG with the same expr)
    if( rec_cnt <> 0 ) then
    	return FALSE
    end if

    dim as integer is_ctorcall = any

    '' try calling any ctor with the expression
    rec_cnt += 1
    dim as ASTNODE ptr arg = astBuildImplicitCtorCall( subtype, _
    												   n->l, _
    												   n->arg.mode, _
    												   is_ctorcall )
    rec_cnt -= 1

    if( is_ctorcall = FALSE ) then
    	return NULL
    end if

    dim as FBSYMBOL ptr tmp = symbAddTempVar( param_dtype, _
    				  						  subtype, _
    				  						  FALSE, _
    				  						  FALSE )

    n->l = astNewCALLCTOR( astPatchCtorCall( arg, _
    										 astBuildVarField( tmp ) ), _
    					   astBuildVarField( tmp ) )

	if( symbGetParamMode( param ) = FB_PARAMMODE_BYVAL ) then
		hUDTPassByval( parent, param, n )
	else
		hBuildByrefArg( n, n->l )
	end if

	if( symbGetHasDtor( subtype ) ) then
		astDtorListAdd( tmp )
	end if

	function = TRUE

end function

'':::::
private function hCheckUDTParam _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as integer

	dim as ASTNODE ptr arg = n->l
	dim as integer arg_dtype = astGetDatatype( arg )

	'' not another UDT?
	if( arg_dtype <> FB_DATATYPE_STRUCT ) then
		if( hImplicitCtor( parent, param, n ) = FALSE ) then
			hParamError( parent )
			return FALSE
		end if
		return TRUE
	end if

    '' check for invalid UDT's (different subtypes)
	if( symbGetSubtype( param ) <> arg->subtype ) then
		if( hImplicitCtor( parent, param, n ) = FALSE ) then
			hParamError( parent )
			return FALSE
		end if
		return TRUE
	end if

	select case symbGetParamMode( param )
	'' byref param?
	case FB_PARAMMODE_BYREF
		'' it's a proc call, but was it originally returning an UDT?
    	if( astIsCALL( arg ) ) then
			if( typeGetDtAndPtrOnly( symbGetUDTRetType( arg->subtype ) ) <> _
									typeAddrOf( FB_DATATYPE_STRUCT ) ) then

				'' create a temporary UDT and pass it..
				dim as FBSYMBOL ptr tmp = any

				'' (note: if it's being returned in regs, there's no DTOR)
				tmp = symbAddTempVar( FB_DATATYPE_STRUCT, _
									  arg->subtype, _
									  FALSE, _
									  FALSE )

				n->l = astNewLink( astNewADDROF( astBuildVarField( tmp ) ), _
								   astNewASSIGN( astBuildVarField( tmp ), _
								   			     arg, _
									   			 AST_OPOPT_DONTCHKOPOVL ) )
				n->arg.mode = FB_PARAMMODE_BYVAL
				return TRUE
			end if
		end if

		''
		hBuildByrefArg( n, arg )

	'' set the length if it's being passed by value
	case FB_PARAMMODE_BYVAL
		hUDTPassByval( parent, param, n )

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
    		return hCheckVoidParam( parent, param, n )
    	end if

		'' passing a BYVAL ptr to an BYREF arg?
		if( n->arg.mode = FB_PARAMMODE_BYVAL ) then
			if( (symbGetDataClass( arg_dtype ) <> FB_DATACLASS_INTEGER) or _
				(symbGetDataSize( arg_dtype ) <> FB_POINTERSIZE) ) then
				hParamError( parent )
				exit function
			end if

			return TRUE
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
				n->l = astBuildCall( proc, 1, arg )
				rec_cnt -= 1

				arg = n->l
				arg_dtype = astGetDatatype( arg )
			end if
		end if
	end select

    select case param_dtype
    '' string param?
    case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR
		return hCheckStrParam( parent, param, n )

	'' UDT param? check if the same, can't convert
	case FB_DATATYPE_STRUCT
		return hCheckUDTParam( parent, param, n )

	end select

	select case as const arg_dtype
	'' string arg? check z- and w-string ptr params
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		select case param_dtype
		'' zstring ptr param?
		case typeAddrOf( FB_DATATYPE_CHAR )
			'' if it's a wstring param, convert..
			if( arg_dtype = FB_DATATYPE_WCHAR ) then
				n->l = rtlToStr( arg, FALSE )
			end if

		'' wstring ptr?
		case typeAddrOf( FB_DATATYPE_WCHAR )
			'' if it's not a wstring param, convert..
			if( arg_dtype <> FB_DATATYPE_WCHAR ) then
				n->l = rtlToWstr( arg )
			end if

		case else
			hParamError( parent )
			exit function
		end select

		hStrArgToStrPtrParam( parent, n, TRUE )
		arg = n->l
		arg_dtype = astGetDatatype( arg )

	'' UDT? implicit casting failed, can't convert..
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		hParamError( parent )
		exit function
	end select

	'' different types? convert..
	dim as integer do_conv = any

	do_conv = symbGetDataSize( param_dtype ) <> symbGetDataSize( arg_dtype )
	if( do_conv = FALSE ) then
		do_conv = symbGetDataClass( param_dtype ) <> symbGetDataClass( arg_dtype )
	end if

	if( do_conv ) then
		'' enum args are only allowed to be passed enum or int params
		if( (param_dtype = FB_DATATYPE_ENUM) or _
			(arg_dtype = FB_DATATYPE_ENUM) ) then
			if( symbGetDataClass( param_dtype ) <> _
				symbGetDataClass( arg_dtype ) ) then
				hParamWarning( parent, FB_WARNINGMSG_IMPLICITCONVERSION )
			end if
		end if

		if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
			'' skip any casting if they won't do any conversion
			dim as ASTNODE ptr t = arg
			if( arg->class = AST_NODECLASS_CONV ) then
				if( arg->cast.doconv = FALSE ) then
					t = arg->l
				end if
			end if

			'' param diff than arg can't passed by ref if it's a var/array/ptr
			select case as const t->class
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
			     AST_NODECLASS_FIELD, AST_NODECLASS_DEREF
				hParamError( parent )
				exit function
			end select
		end if

		'' const?
		if( astIsCONST( arg ) ) then
			arg = astCheckConst( symbGetType( param ), arg )
			if( arg = NULL ) then
				exit function
			end if
			arg_dtype = astGetDatatype( arg )
		end if

		arg = astNewCONV( symbGetFullType( param ), symbGetSubtype( param ), arg )
		if( arg = NULL ) then
			hParamError( parent, FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if
		arg_dtype = astGetDatatype( arg )

		n->l = arg

	else
		'' check for overflows
		if( symbGetDataClass( arg_dtype ) = FB_DATACLASS_FPOINT ) then
			if( astIsCONST( arg ) ) then
				arg = astCheckConst( symbGetType( param ), arg )
				if( arg = NULL ) then
					exit function
				end if
				arg_dtype = astGetDatatype( arg )
			end if
		end if
	end if

	'' pointer checking
	if( typeIsPtr( param_dtype ) ) then
		if( astPtrCheck( symbGetFullType( param ), symbGetSubtype( param ), arg ) = FALSE ) then
			if( typeIsPtr( arg_dtype ) = FALSE ) then
				hParamWarning( parent, FB_WARNINGMSG_PASSINGSCALARASPTR )
			else
				hParamWarning( parent, FB_WARNINGMSG_PASSINGDIFFPOINTERS )
			end if
		end if

    elseif( typeIsPtr( arg_dtype ) ) then
    	hParamWarning( parent, FB_WARNINGMSG_PASSINGPTRTOSCALAR )
	end if

	'' byref arg? check if a temp param isn't needed
	if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
		return hCheckByRefArg( symbGetFullType( param ), symbGetSubtype( param ), n )
        '' it's an implicit pointer
	end if

    function = TRUE

end function

'':::::
private function hCreateOptArg _
	( _
		byval param as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tree = symbGetParamOptExpr( param )
	dim as integer param_dtype = symbGetType( param )

	if( tree = NULL ) then
		return NULL
	end if

	'' make a clone
	if( tree->class = AST_NODECLASS_TYPEINI ) then
		tree = astTypeIniClone( tree )
	else
		tree = astCloneTree( tree )
	end if

	'' UDT?
	if( param_dtype = FB_DATATYPE_STRUCT ) then
		'' update the counters
		astTypeIniUpdCnt( tree )
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

    dim as ASTNODE ptr n = any, t = any
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

    '' check const arg to non-const non-byval param (if not rtl)
    if( (symbGetIsRTL( sym ) = FALSE) or (symbGetIsRTLConst( param )) ) then

    	if( symbCheckConstAssign( symbGetFullType( param ), dtype, param->subtype, arg->subtype, symbGetParamMode( param ) ) = FALSE ) then
    		if( symbIsParamInstance( param ) ) then
    			errReport( FB_ERRMSG_NONCONSTUDTTOCONSTMETHOD, TRUE )
    		else
				hParamError( parent, FB_ERRMSG_ILLEGALASSIGNMENT )
			end if
			exit function
		end if

    end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ARG, FB_DATATYPE_INVALID )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l = arg
	n->arg.mode = mode
	n->arg.lgt = 0

	'' add param node to function's list
	t = parent->r

	'' pascal mode, first param added will be the first pushed
	if( sym->proc.mode = FB_FUNCMODE_PASCAL ) then
		if( t = NULL ) then
			parent->r = n
		else
			t = parent->call.lastarg
			t->r = n
		end if

		parent->call.lastarg = n
		n->r = NULL

	else

		'' non-pascal, the latest param added will be the first pushed
		parent->r = n
		n->r = t
	end if

	''
	if( hCheckParam( parent, param, n ) = FALSE ) then
		return NULL
	end if

	''
	parent->call.args += 1

	if( parent->call.args < sym->proc.params ) then
		parent->call.currarg = symbGetParamNext( parent->call.currarg )
	end if

end function

'':::::
function astReplaceARG _
	( _
		byval parent as ASTNODE ptr, _
		byval argnum as integer, _
		byval expr as ASTNODE ptr, _
		byval dtype as integer, _
		byval mode as integer = INVALID _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr sym = any, param = any
	dim as integer cnt = any
	dim as ASTNODE ptr n = any

	sym = parent->sym

	if( dtype = FB_DATATYPE_INVALID ) then
		dtype = astGetDataType( expr )
	end if

	'' find the argument (assuming argnum is valid)
	cnt = parent->call.args
	param = symbGetProcFirstParam( sym )
	n = parent->r
	do while( n <> NULL )

		cnt -= 1
		if( cnt = argnum ) then
			exit do
		end if

		param = symbGetProcNextParam( sym, param )
		n = n->r
	loop

	if( (n = NULL) or (param = NULL) ) then
		return NULL
	end if

	astDelTree( n->l )

	n->l = expr
	n->arg.mode = mode
	n->arg.lgt = 0

	if( hCheckParam( parent, param, n ) = FALSE ) then
		return NULL
	end if

	function = n

end function
