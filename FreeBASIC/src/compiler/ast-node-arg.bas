''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2006 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

'' AST function argument nodes (called PARAM by mistake)
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
private sub hParamError _
	( _
		byval parent as ASTNODE ptr, _
		byval msgnum as integer = FB_ERRMSG_PARAMTYPEMISMATCHAT _
	)

	errReportParam( parent->sym, parent->call.args+1, NULL, msgnum )

end sub

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
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr s
	dim as ASTTEMPARRAY ptr t

	'' alloc a node
	t = listNewNode( @ast.temparray )
	t->prev = parent->call.arraytail
	parent->call.arraytail = t

	'' create a pointer
	s = symbAddTempVar( FB_DATATYPE_UINT )

	t->pdesc = s

	''
	return rtlArrayAllocTmpDesc( n, s )

end function

'':::::
private function hAllocTmpStrNode _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval copyback as integer _
	) as ASTTEMPSTR ptr static

	dim as ASTTEMPSTR ptr t
	dim as FBSYMBOL ptr s

	'' alloc a node
	t = listNewNode( @ast.tempstr )
	t->prev = parent->call.strtail
	parent->call.strtail = t

	s = symbAddTempVarEx( dtype )

	t->tmpsym = s
	if( copyback ) then
		t->srctree = astOptimize( astCloneTree( n ) )
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

	dim as ASTTEMPSTR ptr t

	'' create temp string to pass as parameter
	t = hAllocTmpStrNode( parent, n, FB_DATATYPE_STRING, copyback )

	'' temp string = src string
	return rtlStrAssign( astNewVAR( t->tmpsym, 0, FB_DATATYPE_STRING ), n )

end function

'':::::
private function hAllocTmpWstrPtr _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTTEMPSTR ptr t

	'' create temp wstring ptr to pass as parameter
	t = hAllocTmpStrNode( parent, NULL, FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, FALSE )

	n = astNewCONV( AST_OP_TOPOINTER, FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, NULL, n )

	'' temp string = src string
	return astNewASSIGN( astNewVAR( t->tmpsym, 0, FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR ), n )

end function

'':::::
private function hCheckStringArg _
	( _
		byval parent as ASTNODE ptr, _
		byval param as FBSYMBOL ptr, _
		byval arg as ASTNODE ptr _
	) as ASTNODE ptr

    dim as integer arg_dtype, copyback

	function = arg

	arg_dtype = arg->dtype

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
private function hStrParamToPtrArg _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval checkrtl as integer _
	) as integer

	dim as ASTNODE ptr arg
	dim as integer arg_dtype

	if( checkrtl = FALSE ) then
		'' rtl? don't mess..
		if( parent->call.isrtl ) then
			return TRUE
		end if
	end if

	''
	arg = n->l
	arg_dtype = arg->dtype

	'' var- or fixed-len string param?
	if( symbGetDataClass( arg_dtype ) = FB_DATACLASS_STRING ) then

		'' if it's a function returning a STRING, it will have to be
		'' deleted automagically when the proc been called return
		if( arg->class = AST_NODECLASS_CALL ) then
			'' create a temp string to pass as parameter (no copy is
			'' done at rtlib, as the returned string is a temp too)
			n->l = hAllocTmpString( parent, arg, FALSE )
			arg_dtype = FB_DATATYPE_STRING
        end if

		'' not fixed-len? deref var-len (ptr at offset 0)
		if( arg_dtype <> FB_DATATYPE_FIXSTR ) then
    		n->l = astNewCONV( AST_OP_TOPOINTER, _
    						   FB_DATATYPE_POINTER + FB_DATATYPE_CHAR, _
    						   NULL, _
    						   astNewADDR( AST_OP_DEREF, n->l ) )

        '' fixed-len..
        else
            '' get the address of
        	if( arg->class <> AST_NODECLASS_PTR ) then
				n->l = astNewCONV( AST_OP_TOPOINTER, _
    						   	   FB_DATATYPE_POINTER + FB_DATATYPE_CHAR, _
    						   	   NULL, _
							   	   astNewADDR( AST_OP_ADDROF, n->l ) )
			end if
		end if

		n->dtype = n->l->dtype

	'' w- or z-string
	else
    	select case arg_dtype
    	'' zstring? take the address of
    	case FB_DATATYPE_CHAR
			n->l = astNewADDR( AST_OP_ADDROF, arg )
			n->dtype = n->l->dtype

		'' wstring?
		case FB_DATATYPE_WCHAR

			'' if it's a function returning a WSTRING, it will have to be
			'' deleted automatically when the proc been called return
			if( arg->class = AST_NODECLASS_CALL ) then
            	n->l = hAllocTmpWstrPtr( parent, arg )

			'' not a temporary..
			else
				'' take the address of
				n->l = astNewADDR( AST_OP_ADDROF, arg )
			end if

			n->dtype = n->l->dtype

		end select

	end if

	function = TRUE

end function

'':::::
private function hCheckArrayParam _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval adtype as integer, _
		byval adclass as integer _
	) as integer

	dim as FBSYMBOL ptr s, d
    dim as ASTNODE ptr arg

	arg = n->l

	'' type field?
	s = astGetSymbol( arg )

	if( s = NULL ) then
		hParamError( parent )
		return FALSE
	end if

	'' same type? (don't check if it's a rtl proc)
	if( parent->call.isrtl = FALSE ) then
		if( (adclass <> symbGetDataClass( s->typ ) ) or _
			(symbGetDataSize( adtype ) <> symbGetDataSize( s->typ )) ) then
			hParamError( parent )
			return FALSE
		end if
	end if

	if( s->class = FB_SYMBCLASS_UDTELM ) then
		'' not an array?
		if( symbGetArrayDimensions( s ) = 0 ) then
			hParamError( parent )
			return FALSE
		end if

		'' address of?
		''''''''if( astIsADDR( p ) ) then
		''''''''	hParamError( f )
		''''''''	return FALSE
		''''''''end if

		'' create a temp array descriptor
		n->l = hAllocTmpArrayDesc( parent, arg )
		n->dtype = FB_DATATYPE_POINTER + FB_DATATYPE_VOID

	else

		'' an argument passed by descriptor?
		if( symbIsParamByDesc( s ) ) then
        	'' it's a pointer, but could be seen as anything else
        	'' (ie: if it were "s() as string"), so, create an alias
        	n->l = astNewVAR( s, 0, FB_DATATYPE_UINT )
        	n->dtype = FB_DATATYPE_POINTER + FB_DATATYPE_VOID

    	else
			'' not an array?
			d = s->var.array.desc
			if( d = NULL ) then
				hParamError( parent )
				return FALSE
			end if

        	''
        	n->l = astNewADDR( AST_OP_ADDROF, _
        					   astNewVAR( d, 0, FB_DATATYPE_UINT ) )
        	n->dtype = FB_DATATYPE_POINTER + FB_DATATYPE_VOID

    	end if

    end if

    function = TRUE

end function

'':::::
private function hCheckByRefArg _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr arg

	arg = n->l

	select case as const arg->class
	'' var, array index or pointer? pass as-is (assuming the type was already checked)
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
		 AST_NODECLASS_FIELD, AST_NODECLASS_PTR

	case else
		'' string? do nothing (ie: functions returning var-len string's)
		select case as const dtype
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			return arg

		'' UDT? do nothing, just take the addr of
		case FB_DATATYPE_STRUCT

		case else
			'' scalars: store param to a temp var and pass it
			arg = astNewASSIGN( astNewVAR( symbAddTempVar( dtype, subtype ), _
									 	   0, _
									 	   dtype, _
									 	   subtype ), _
							    arg, _
							    FALSE )
		end select

	end select

	'' take the address of
	arg = astNewADDR( AST_OP_ADDROF, arg )

	n->l = arg
	n->dtype = arg->dtype
	n->subtype = arg->subtype
	n->arg.mode = FB_PARAMMODE_BYVAL

	function = arg

end function

'':::::
private function hCheckParam _
	( _
		byval parent as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as integer

    dim as FBSYMBOL ptr param = any
    dim as integer param_dtype = any, param_dclass = any, param_mode = any
    dim as ASTNODE ptr arg = any
    dim as integer arg_dtype = any, arg_dclass = any, arg_mode = any, arg_nodeclass = any

    function = FALSE

	''
	if( parent->call.args >= parent->sym->proc.params ) then
		param = symbGetProcTailParam( parent->sym )
	else
		param = parent->call.currarg
	end if

	'' parameter
	param_mode = symbGetParamMode( param )
	param_dtype = symbGetType( param )
	if( param_dtype <> INVALID ) then
		param_dclass = symbGetDataClass( param_dtype )
	end if

	'' string concatenation is delayed for optimization reasons..
	n->l = astUpdStrConcat( n->l )

    '' argument
	arg_mode = n->arg.mode
	arg = n->l
	arg_dtype = arg->dtype
	arg_dclass = symbGetDataClass( arg_dtype )
	arg_nodeclass = arg->class

	'' by descriptor?
	if( param_mode = FB_PARAMMODE_BYDESC ) then

        '' param is not an pointer
        if( arg_mode <> FB_PARAMMODE_BYVAL ) then
        	return hCheckArrayParam( parent, n, param_dtype, param_dclass )
        end if

        return TRUE
    end if

    '' vararg?
    if( param_mode = FB_PARAMMODE_VARARG ) then

		select case arg_dclass
		'' var-len string? check..
		case FB_DATACLASS_STRING
			return hStrParamToPtrArg( parent, n, FALSE )

		case FB_DATACLASS_INTEGER
			select case arg_dtype
			'' w|zstring? ditto..
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				return hStrParamToPtrArg( parent, n, FALSE )

			case else
				'' if < len(integer), convert to int (C ABI)
				if( symbGetDataSize( arg_dtype ) < FB_INTEGERSIZE ) then
					arg = astNewCONV( INVALID, _
									  iif( symbIsSigned( arg_dtype ), _
										   FB_DATATYPE_INTEGER, _
										   FB_DATATYPE_UINT ), _
									  NULL, _
									  arg )
					n->dtype = arg->dtype
					n->l = arg
				end if
			end select

		case FB_DATACLASS_FPOINT
			'' float? convert it to double (C ABI)
			if( arg_dtype = FB_DATATYPE_SINGLE ) then
				arg = astNewCONV( INVALID, FB_DATATYPE_DOUBLE, NULL, arg )
				n->dtype = arg->dtype
				n->l = arg
			end if
		end select

		return TRUE
	end if

	'' as any?
    if( param_dtype = FB_DATATYPE_VOID ) then

		if( arg_mode = FB_PARAMMODE_BYVAL ) then
			'' another quirk: BYVAL strings passed to BYREF ANY args..
			return hStrParamToPtrArg( parent, n, FALSE )
		end if

		'' byref arg, check if a temp param isn't needed
		'' use the param type, not the arg type (as it's VOID)
		return hCheckByRefArg( arg_dtype, arg->subtype, n ) <> NULL

    end if

    '' byval or byref (but as any)..

    '' string argument?
    if( param_dclass = FB_DATACLASS_STRING ) then

		'' if it's a function returning a STRING, it's actually a pointer
		if( arg_nodeclass = AST_NODECLASS_CALL ) then
			select case arg_dtype
			case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
				arg_nodeclass = AST_NODECLASS_PTR
			end select
		end if

		'' param not an string?
		if( arg_dclass <> FB_DATACLASS_STRING ) then
			'' not a zstring?
			select case arg_dtype
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

			case else
				'' check if not a byte ptr
				if( (arg_nodeclass <> AST_NODECLASS_PTR) or _
					((arg_dtype <> FB_DATATYPE_BYTE) and _
					 (arg_dtype <> FB_DATATYPE_UBYTE)) ) then

					'' or if passing a ptr as byval to a byval string arg
		    		if( (arg_dclass <> FB_DATACLASS_INTEGER) or _
		    			(param_mode <> FB_PARAMMODE_BYVAL) or _
		    			(symbGetDataSize( arg_dtype ) <> FB_POINTERSIZE) ) then
						hParamError( parent )
						exit function
		    		end if

		    		'' the BYVAL modifier was not used?
		    		if( arg_mode <> FB_PARAMMODE_BYVAL ) then
						'' const? only accept if it's NULL
		    			if( arg->defined ) then
		    				if( arg->con.val.int <> NULL ) then
								hParamError( parent )
								exit function
		    				end if

		    			'' not a pointer?
		    			elseif( arg_dtype < FB_DATATYPE_POINTER ) then
							hParamError( parent )
							exit function

		    			'' not a pointer to a zstring?
		    			else
							if( astPtrCheck( FB_DATATYPE_POINTER + FB_DATATYPE_CHAR, _
											 NULL, arg ) = FALSE ) then
			        			hParamWarning( parent, FB_WARNINGMSG_PASSINGDIFFPOINTERS )
			    			end if

		    			end if
		    		end if

		    	end if
			end select
		end if

		'' byval and variable:
		''   pass the pointer at ofs 0 of the string descriptor
		'' byval and fixed/byte ptr/ptr:
		''   pass the pointer as-is
		'' byval and wstring
		''	 same as above but convert to ascii first

		'' byref and variable:
		''   pass the pointer to descriptor
		'' byref and fixed/byte ptr:
		''   alloc a temp string, copy fixed to temp, pass temp,
		''	 copy temp back to fixed when func returns, del temp
		'' byref and wstring
		''	 same as above but convert to ascii first

		'' alloc a temp string if needed
		arg = hCheckStringArg( parent, param, arg )
		if( arg <> n->l ) then
			'' node will be a function returning a PTR to a string descriptor
			arg_dtype = FB_DATATYPE_STRING
			arg_dclass = FB_DATACLASS_STRING
			arg_nodeclass = AST_NODECLASS_PTR

			n->l = arg
			n->dtype = arg_dtype
		end if

		''
		if( param_mode = FB_PARAMMODE_BYVAL ) then
			'' deref var-len (ptr at offset 0)
			if( arg_dtype = FB_DATATYPE_STRING ) then
				arg_dclass = FB_DATACLASS_INTEGER
				arg_dtype = FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
				n->l = astNewADDR( AST_OP_DEREF, arg )
				n->dtype = arg_dtype
			end if
		end if

		'' not a pointer yet?
		if( arg_nodeclass <> AST_NODECLASS_PTR ) then
			'' descriptor or fixed-len? get the address of
			if( (arg_dclass = FB_DATACLASS_STRING) or (arg_dtype = FB_DATATYPE_CHAR) ) then
				n->l = astNewADDR( AST_OP_ADDROF, arg )
				n->dtype = FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
			end if
		end if

		return TRUE
	end if

	'' anything but strings..

	'' passing a BYVAL ptr to an BYREF arg?
	if( (arg_mode = FB_PARAMMODE_BYVAL) and (param_mode = FB_PARAMMODE_BYREF) ) then
		if( (arg_dclass <> FB_DATACLASS_INTEGER) or _
			(symbGetDataSize( arg_dtype ) <> FB_POINTERSIZE) ) then
			hParamError( parent )
			exit function
		end if

		return TRUE
	end if

	'' UDT arg? check if the same, can't convert
	if( param_dtype = FB_DATATYPE_STRUCT ) then
		dim as FBSYMBOL ptr s = any
		'' not another UDT?
		if( arg_dtype <> FB_DATATYPE_STRUCT ) then
			'' not a proc? (can be an UDT been returned in registers)
			if( arg_nodeclass <> AST_NODECLASS_CALL ) then
				hParamError( parent )
				exit function
			end if

			'' it's a proc call, but was it originally returning an UDT?
			s = arg->sym
			if( s->typ <> FB_DATATYPE_STRUCT ) then
				hParamError( parent )
				exit function
			end if

			'' byref argument? can't create a tempory UDT..
			if( param_mode = FB_PARAMMODE_BYREF ) then
				hParamError( parent, FB_ERRMSG_CANTPASSUDTRESULTBYREF )
				exit function
			end if

			'' set type..
			n->dtype = arg_dtype
			s = s->subtype

		else
			if( arg_nodeclass <> AST_NODECLASS_CALL ) then
				s = arg->subtype
			else
				s = arg->sym->subtype
			end if
		end if

        '' check for invalid UDT's (different subtypes)
		if( symbGetSubtype( param ) <> s ) then
			hParamError( parent )
			exit function
		end if

		'' set the length if it's been passed by value
		if( param_mode = FB_PARAMMODE_BYVAL ) then
			if( arg_dtype = FB_DATATYPE_STRUCT ) then
				n->arg.lgt = FB_ROUNDLEN( symbGetLen( s ) )
			end if
		end if

		return TRUE
	end if

	'' anything else..

	'' can't convert UDT's to other types
	if( arg_dtype = FB_DATATYPE_STRUCT ) then
		hParamError( parent )
		exit function
	end if

	'' string param? handle z- and w-string ptr arguments
	select case as const arg_dtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		select case param_dtype
		'' zstring ptr arg?
		case FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
			'' if it's a wstring param, convert..
			if( arg_dtype = FB_DATATYPE_WCHAR ) then
				n->l = rtlToStr( arg )
			end if

		'' wstring ptr arg?
		case FB_DATATYPE_POINTER + FB_DATATYPE_WCHAR
			'' if it's not a wstring param, convert..
			if( arg_dtype <> FB_DATATYPE_WCHAR ) then
				n->l = rtlToWstr( arg )
			end if

		case else
			hParamError( parent )
			exit function
		end select

		hStrParamToPtrArg( parent, n, TRUE )
		arg = n->l
		arg_dtype = arg->dtype
		arg_dclass = symbGetDataClass( arg_dtype )

	end select

	'' different types? convert..
	if( (param_dclass <> arg_dclass) or _
		(symbGetDataSize( param_dtype ) <> symbGetDataSize( arg_dtype )) ) then

		'' enum args are only allowed to be passed enum or int params
		if( (param_dtype = FB_DATATYPE_ENUM) or _
			(arg_dtype = FB_DATATYPE_ENUM) ) then
			if( param_dclass <> arg_dclass ) then
				hParamWarning( parent, FB_WARNINGMSG_IMPLICITCONVERSION )
			end if
		end if

		if( param_mode = FB_PARAMMODE_BYREF ) then
			'' param diff than arg can't passed by ref if it's a var/array/ptr
			select case as const arg_nodeclass
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
			     AST_NODECLASS_FIELD, AST_NODECLASS_PTR
				hParamError( parent )
				exit function
			end select
		end if

		'' const?
		if( arg->defined ) then
			arg = astCheckConst( param_dtype, arg )
			if( arg = NULL ) then
				exit function
			end if
		end if

		arg = astNewCONV( INVALID, param_dtype, symbGetSubtype( param ), arg )
		if( arg = NULL ) then
			hParamError( parent, FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if

		n->dtype = param_dtype
		n->subtype = symbGetSubtype( param )
		n->l = arg

	end if

	'' pointer checking
	if( param_dtype >= FB_DATATYPE_POINTER ) then
		if( astPtrCheck( param_dtype, symbGetSubtype( param ), arg ) = FALSE ) then
			if( arg->dtype < FB_DATATYPE_POINTER ) then
				hParamWarning( parent, FB_WARNINGMSG_PASSINGSCALARASPTR )
			else
				hParamWarning( parent, FB_WARNINGMSG_PASSINGDIFFPOINTERS )
			end if
		end if

    elseif( arg->dtype >= FB_DATATYPE_POINTER ) then
    	hParamWarning( parent, FB_WARNINGMSG_PASSINGPTRTOSCALAR )
	end if

	'' byref arg? check if a temp param isn't needed
	if( param_mode = FB_PARAMMODE_BYREF ) then
		arg = hCheckByRefArg( param_dtype, symbGetSubtype( param ), n )
        '' it's an implicit pointer
	end if

    function = TRUE

end function

'':::::
function astNewARG _
	( _
		byval parent as ASTNODE ptr, _
		byval arg as ASTNODE ptr, _
		byval dtype as integer = INVALID, _
		byval mode as integer = INVALID _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any, t = any
    dim as FBSYMBOL ptr sym = any

	if( dtype = INVALID ) then
		dtype = astGetDataType( arg )
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ARG, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l = arg
	n->arg.mode = mode
	n->arg.lgt = 0

	'' add param node to function's list
	sym = parent->sym

	t = parent->r

	'' pascal mode, first param added will be the first pushed
	if( sym->proc.mode = FB_FUNCMODE_PASCAL ) then
		if( t = NULL ) then
			parent->r = n
		else
			t = parent->call.lastarg
			parent->r = n
		end if

		parent->call.lastarg = n
		n->r = NULL

	else
		'' non-pascal, the latest param added will be the first pushed
		parent->r = n
		n->r = t
	end if

	''
	if( hCheckParam( parent, n ) = FALSE ) then
		return NULL
	end if

	''
	parent->call.args += 1

	if( parent->call.args < sym->proc.params ) then
		parent->call.currarg = symbGetParamNext( parent->call.currarg )
	end if

end function

