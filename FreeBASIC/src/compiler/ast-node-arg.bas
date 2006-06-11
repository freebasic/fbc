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

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private sub hParamError _
	( _
		byval f as ASTNODE ptr, _
		byval msgnum as integer = FB_ERRMSG_PARAMTYPEMISMATCHAT _
	)

	errReportParam( f->sym, f->call.args+1, NULL, msgnum )

end sub

'':::::
private sub hParamWarning _
	( _
		byval f as ASTNODE ptr, _
		byval msgnum as integer _
	)

	errReportParamWarn( f->sym, f->call.args+1, NULL, msgnum )

end sub

'':::::
private function hAllocTmpArrayDesc _
	( _
		byval f as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim s as FBSYMBOL ptr
	dim t as ASTTEMPARRAY ptr

	'' alloc a node
	t = listNewNode( @ast.temparray )
	t->prev = f->call.arraytail
	f->call.arraytail = t

	'' create a pointer
	s = symbAddTempVar( FB_DATATYPE_UINT )

	t->pdesc = s

	''
	return rtlArrayAllocTmpDesc( n, s )

end function

'':::::
private function hAllocTmpStrNode _
	( _
		byval proc as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval dtype as integer, _
		byval copyback as integer _
	) as ASTTEMPSTR ptr static

	dim as ASTTEMPSTR ptr t
	dim as FBSYMBOL ptr s

	'' alloc a node
	t = listNewNode( @ast.tempstr )
	t->prev = proc->call.strtail
	proc->call.strtail = t

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
		byval proc as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval copyback as integer _
	) as ASTNODE ptr

	dim as ASTTEMPSTR ptr t

	'' create temp string to pass as parameter
	t = hAllocTmpStrNode( proc, n, FB_DATATYPE_STRING, copyback )

	'' temp string = src string
	return rtlStrAssign( astNewVAR( t->tmpsym, 0, FB_DATATYPE_STRING ), n )

end function

'':::::
private function hAllocTmpWstrPtr _
	( _
		byval proc as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTTEMPSTR ptr t

	'' create temp wstring ptr to pass as parameter
	t = hAllocTmpStrNode( proc, NULL, FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, FALSE )

	n = astNewCONV( AST_OP_TOPOINTER, FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR, NULL, n )

	'' temp string = src string
	return astNewASSIGN( astNewVAR( t->tmpsym, 0, FB_DATATYPE_POINTER+FB_DATATYPE_WCHAR ), n )

end function

'':::::
private function hCheckStringArg _
	( _
		byval proc as ASTNODE ptr, _
		byval arg as FBSYMBOL ptr, _
		byval p as ASTNODE ptr _
	) as ASTNODE ptr

    dim as integer pdtype, copyback

	function = p

	pdtype = p->dtype

	'' calling the runtime lib?
	if( proc->call.isrtl ) then

		'' passed byref?
		if( symbGetParamMode( arg ) = FB_PARAMMODE_BYREF ) then

			select case pdtype
			'' var-len param: all rtlib procs will free the
			'' temporary strings and descriptors automatically
			case FB_DATATYPE_STRING
				exit function

			'' wstring? convert and let rtl to free the temp
			'' var-len result..
			case FB_DATATYPE_WCHAR
				return rtlToStr( p )

			'' anything else, just alloc a temp descriptor (assuming
			'' here that no rtlib function will EVER change the
			'' strings passed as param)
			case else
				return rtlStrAllocTmpDesc( p )
			end select

		'' passed byval..
		else

			'' var-len?
			select case pdtype
			case FB_DATATYPE_STRING
				'' not a temp var-len returned by functions? skip..
				if( p->class <> AST_NODECLASS_CALL ) then
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
			return hAllocTmpString( proc, p, FALSE )

		end if

	end if

	'' it's not a rtl function.. var-len strings won't be automatically
	'' removed nor it's safe to pass non fixed-len strings to var-len
	'' params as they can be modified inside the callee function..
	copyback = FALSE

	select case symbGetParamMode( arg )
	'' passed by reference?
	case FB_PARAMMODE_BYREF

    	select case pdtype
    	'' fixed-length?
    	case FB_DATATYPE_FIXSTR
    		'' byref arg and fixed-len param: alloc a temp string, copy
    		'' fixed to temp and pass temp
			'' (ast will have to copy temp back to fixed when function
			'' returns and delete temp)

			'' don't copy back if it's a function returning a fixed-len
			if( p->class <> AST_NODECLASS_CALL ) then
				copyback = TRUE
			end if

    	'' var-len?
    	case FB_DATATYPE_STRING
    		'' if not a function's result, skip..
    		if( p->class <> AST_NODECLASS_CALL ) then
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

		select case pdtype
		'' var-len?
		case FB_DATATYPE_STRING

			'' not a temp var-len function result? do nothing..
			if( p->class <> AST_NODECLASS_CALL ) then
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
	function = hAllocTmpString( proc, p, copyback )

end function

'':::::
private function hStrParamToPtrArg _
	( _
		byval proc as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval checkrtl as integer _
	) as integer

	dim as ASTNODE ptr p
	dim as integer pdtype

	if( checkrtl = FALSE ) then
		'' rtl? don't mess..
		if( proc->call.isrtl ) then
			return TRUE
		end if
	end if

	''
	p = n->l
	pdtype = p->dtype

	'' var- or fixed-len string param?
	if( symbGetDataClass( pdtype ) = FB_DATACLASS_STRING ) then

		'' if it's a function returning a STRING, it will have to be
		'' deleted automagically when the proc been called return
		if( p->class = AST_NODECLASS_CALL ) then
			'' create a temp string to pass as parameter (no copy is
			'' done at rtlib, as the returned string is a temp too)
			n->l = hAllocTmpString( proc, p, FALSE )
			pdtype = FB_DATATYPE_STRING
        end if

		'' not fixed-len? deref var-len (ptr at offset 0)
		if( pdtype <> FB_DATATYPE_FIXSTR ) then
    		n->l = astNewCONV( AST_OP_TOPOINTER, _
    						   FB_DATATYPE_POINTER + FB_DATATYPE_CHAR, _
    						   NULL, _
    						   astNewADDR( AST_OP_DEREF, n->l ) )

        '' fixed-len..
        else
            '' get the address of
        	if( p->class <> AST_NODECLASS_PTR ) then
				n->l = astNewCONV( AST_OP_TOPOINTER, _
    						   	   FB_DATATYPE_POINTER + FB_DATATYPE_CHAR, _
    						   	   NULL, _
							   	   astNewADDR( AST_OP_ADDROF, n->l ) )
			end if
		end if

		n->dtype = n->l->dtype

	'' w- or z-string
	else
    	select case pdtype
    	'' zstring? take the address of
    	case FB_DATATYPE_CHAR
			n->l = astNewADDR( AST_OP_ADDROF, p )
			n->dtype = n->l->dtype

		'' wstring?
		case FB_DATATYPE_WCHAR

			'' if it's a function returning a WSTRING, it will have to be
			'' deleted automatically when the proc been called return
			if( p->class = AST_NODECLASS_CALL ) then
            	n->l = hAllocTmpWstrPtr( proc, p )

			'' not a temporary..
			else
				'' take the address of
				n->l = astNewADDR( AST_OP_ADDROF, p )
			end if

			n->dtype = n->l->dtype

		end select

	end if

	function = TRUE

end function

'':::::
private function hCheckArrayParam _
	( _
		byval f as ASTNODE ptr, _
		byval n as ASTNODE ptr, _
		byval adtype as integer, _
		byval adclass as integer _
	) as integer

	dim as FBSYMBOL ptr s, d
    dim as ASTNODE ptr p

	p = n->l

	'' type field?
	s = astGetSymbol( p )

	if( s = NULL ) then
		hParamError( f )
		return FALSE
	end if

	'' same type? (don't check if it's a rtl proc)
	if( f->call.isrtl = FALSE ) then
		if( (adclass <> symbGetDataClass( s->typ ) ) or _
			(symbGetDataSize( adtype ) <> symbGetDataSize( s->typ )) ) then
			hParamError( f )
			return FALSE
		end if
	end if

	if( s->class = FB_SYMBCLASS_UDTELM ) then
		'' not an array?
		if( symbGetArrayDimensions( s ) = 0 ) then
			hParamError( f )
			return FALSE
		end if

		'' address of?
		''''''''if( astIsADDR( p ) ) then
		''''''''	hParamError( f )
		''''''''	return FALSE
		''''''''end if

		'' create a temp array descriptor
		n->l = hAllocTmpArrayDesc( f, p )
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
				hParamError( f )
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

    dim as ASTNODE ptr p

	p = n->l

	select case as const p->class
	'' var, array index or pointer? pass as-is (assuming the type was already checked)
	case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
		 AST_NODECLASS_FIELD, AST_NODECLASS_PTR

	case else
		'' string? do nothing (ie: functions returning var-len string's)
		select case as const dtype
		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
			return p

		'' UDT? do nothing, just take the addr of
		case FB_DATATYPE_USERDEF

		case else
			'' scalars: store param to a temp var and pass it
			p = astNewASSIGN( astNewVAR( symbAddTempVar( dtype, subtype ), _
									 	 0, _
									 	 dtype, _
									 	 subtype ), _
							  p, _
							  FALSE )
		end select

	end select

	'' take the address of
	p = astNewADDR( AST_OP_ADDROF, p )

	n->l = p
	n->dtype = p->dtype
	n->subtype = p->subtype
	n->arg.mode = FB_PARAMMODE_BYVAL

	function = p

end function

'':::::
private function hCheckParam _
	( _
		byval f as ASTNODE ptr, _
		byval n as ASTNODE ptr _
	) as integer

    dim as FBSYMBOL ptr sym, arg, s
    dim as integer adtype, adclass, amode
    dim as ASTNODE ptr p
    dim as integer pdtype, pdclass, pmode, pclass

    function = FALSE

	''
	sym = f->sym

	if( f->call.args >= sym->proc.params ) then
		arg = symbGetProcTailParam( sym )
	else
		arg = f->call.currarg
	end if

	'' argument
	amode = symbGetParamMode( arg )
	adtype = symbGetType( arg )
	if( adtype <> INVALID ) then
		adclass = symbGetDataClass( adtype )
	end if

	'' string concatenation is delayed for optimization reasons..
	n->l = astUpdStrConcat( n->l )

    '' parameter
	p = n->l
	pmode = n->arg.mode
	pdtype = p->dtype
	pdclass = symbGetDataClass( pdtype )
	pclass = p->class

	'' by descriptor?
	if( amode = FB_PARAMMODE_BYDESC ) then

        '' param is not an pointer
        if( pmode <> FB_PARAMMODE_BYVAL ) then
        	return hCheckArrayParam( f, n, adtype, adclass )
        end if

        return TRUE
    end if

    '' vararg?
    if( amode = FB_PARAMMODE_VARARG ) then

		select case pdclass
		'' var-len string? check..
		case FB_DATACLASS_STRING
			return hStrParamToPtrArg( f, n, FALSE )

		case FB_DATACLASS_INTEGER
			select case pdtype
			'' w|zstring? ditto..
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				return hStrParamToPtrArg( f, n, FALSE )

			case else
				'' if < len(integer), convert to int (C ABI)
				if( symbGetDataSize( pdtype ) < FB_INTEGERSIZE ) then
					p = astNewCONV( INVALID, _
									iif( symbIsSigned( pdtype ), _
										 FB_DATATYPE_INTEGER, _
										 FB_DATATYPE_UINT ), _
									NULL, _
									p )
					n->dtype = p->dtype
					n->l = p
				end if
			end select

		case FB_DATACLASS_FPOINT
			'' float? convert it to double (C ABI)
			if( pdtype = FB_DATATYPE_SINGLE ) then
				p = astNewCONV( INVALID, FB_DATATYPE_DOUBLE, NULL, p )
				n->dtype = p->dtype
				n->l = p
			end if
		end select

		return TRUE
	end if

	'' as any?
    if( adtype = FB_DATATYPE_VOID ) then

		if( pmode = FB_PARAMMODE_BYVAL ) then
			'' another quirk: BYVAL strings passed to BYREF ANY args..
			return hStrParamToPtrArg( f, n, FALSE )
		end if

		'' byref arg, check if a temp param isn't needed
		'' use the param type, not the arg type (as it's VOID)
		return hCheckByRefArg( pdtype, p->subtype, n ) <> NULL

    end if

    '' byval or byref (but as any)..

    '' string argument?
    if( adclass = FB_DATACLASS_STRING ) then

		'' if it's a function returning a STRING, it's actually a pointer
		if( pclass = AST_NODECLASS_CALL ) then
			select case pdtype
			case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
				pclass = AST_NODECLASS_PTR
			end select
		end if

		'' param not an string?
		if( pdclass <> FB_DATACLASS_STRING ) then
			'' not a zstring?
			select case pdtype
			case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

			case else
				'' check if not a byte ptr
				if( (pclass <> AST_NODECLASS_PTR) or _
					((pdtype <> FB_DATATYPE_BYTE) and (pdtype <> FB_DATATYPE_UBYTE)) ) then

					'' or if passing a ptr as byval to a byval string arg
		    		if( (pdclass <> FB_DATACLASS_INTEGER) or _
		    			(amode <> FB_PARAMMODE_BYVAL) or _
		    			(symbGetDataSize( pdtype ) <> FB_POINTERSIZE) ) then
						hParamError( f )
						exit function
		    		end if

		    		'' the BYVAL modifier was not used?
		    		if( pmode <> FB_PARAMMODE_BYVAL ) then
						'' const? only accept if it's NULL
		    			if( p->defined ) then
		    				if( p->con.val.int <> NULL ) then
								hParamError( f )
								exit function
		    				end if

		    			'' not a pointer?
		    			elseif( pdtype < FB_DATATYPE_POINTER ) then
							hParamError( f )
							exit function

		    			'' not a pointer to a zstring?
		    			else
							if( astPtrCheck( FB_DATATYPE_POINTER + FB_DATATYPE_CHAR, _
											 NULL, p ) = FALSE ) then
			        			hParamWarning( f, FB_WARNINGMSG_PASSINGDIFFPOINTERS )
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
		p = hCheckStringArg( f, arg, p )
		if( p <> n->l ) then
			'' node will be a function returning a PTR to a string descriptor
			pdtype = FB_DATATYPE_STRING
			pdclass = FB_DATACLASS_STRING
			pclass = AST_NODECLASS_PTR

			n->l = p
			n->dtype = pdtype
		end if

		''
		if( amode = FB_PARAMMODE_BYVAL ) then
			'' deref var-len (ptr at offset 0)
			if( pdtype = FB_DATATYPE_STRING ) then
				pdclass = FB_DATACLASS_INTEGER
				pdtype = FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
				n->l = astNewADDR( AST_OP_DEREF, p )
				n->dtype = pdtype
			end if
		end if

		'' not a pointer yet?
		if( pclass <> AST_NODECLASS_PTR ) then
			'' descriptor or fixed-len? get the address of
			if( (pdclass = FB_DATACLASS_STRING) or (pdtype = FB_DATATYPE_CHAR) ) then
				n->l = astNewADDR( AST_OP_ADDROF, p )
				n->dtype = FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
			end if
		end if

		return TRUE
	end if

	'' anything but strings..

	'' passing a BYVAL ptr to an BYREF arg?
	if( (pmode = FB_PARAMMODE_BYVAL) and (amode = FB_PARAMMODE_BYREF) ) then
		if( (pdclass <> FB_DATACLASS_INTEGER) or _
			(symbGetDataSize( pdtype ) <> FB_POINTERSIZE) ) then
			hParamError( f )
			exit function
		end if

		return TRUE
	end if

	'' UDT arg? check if the same, can't convert
	if( adtype = FB_DATATYPE_USERDEF ) then
		'' not another UDT?
		if( pdtype <> FB_DATATYPE_USERDEF ) then
			'' not a proc? (can be an UDT been returned in registers)
			if( pclass <> AST_NODECLASS_CALL ) then
				hParamError( f )
				exit function
			end if

			'' it's a proc, but was it originally returning an UDT?
			s = p->sym
			if( s->typ <> FB_DATATYPE_USERDEF ) then
				hParamError( f )
				exit function
			end if

			'' byref argument? can't create a tempory UDT..
			if( amode = FB_PARAMMODE_BYREF ) then
				hParamError( f, FB_ERRMSG_CANTPASSUDTRESULTBYREF )
				exit function
			end if

			'' set type..
			n->dtype = pdtype
			s = s->subtype

		else
			if( pclass <> AST_NODECLASS_CALL ) then
				s = p->subtype
			else
				s = p->sym->subtype
			end if
		end if

        '' check for invalid UDT's (different subtypes)
		if( symbGetSubtype( arg ) <> s ) then
			hParamError( f )
			exit function
		end if

		'' set the length if it's been passed by value
		if( amode = FB_PARAMMODE_BYVAL ) then
			if( pdtype = FB_DATATYPE_USERDEF ) then
				n->arg.lgt = FB_ROUNDLEN( symbGetLen( s ) )
			end if
		end if

		return TRUE
	end if

	'' anything else..

	'' can't convert UDT's to other types
	if( pdtype = FB_DATATYPE_USERDEF ) then
		hParamError( f )
		exit function
	end if

	'' string param? handle z- and w-string ptr arguments
	select case as const pdtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

		select case adtype
		'' zstring ptr arg?
		case FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
			'' if it's a wstring param, convert..
			if( pdtype = FB_DATATYPE_WCHAR ) then
				n->l = rtlToStr( p )
			end if

		'' wstring ptr arg?
		case FB_DATATYPE_POINTER + FB_DATATYPE_WCHAR
			'' if it's not a wstring param, convert..
			if( pdtype <> FB_DATATYPE_WCHAR ) then
				n->l = rtlToWstr( p )
			end if

		case else
			hParamError( f )
			exit function
		end select

		hStrParamToPtrArg( f, n, TRUE )
		p = n->l
		pdtype = p->dtype
		pdclass = symbGetDataClass( pdtype )

	end select

	'' different types? convert..
	if( (adclass <> pdclass) or _
		(symbGetDataSize( adtype ) <> symbGetDataSize( pdtype )) ) then

		'' enum args are only allowed to be passed enum or int params
		if( (adtype = FB_DATATYPE_ENUM) or _
			(pdtype = FB_DATATYPE_ENUM) ) then
			if( adclass <> pdclass ) then
				hParamWarning( f, FB_WARNINGMSG_IMPLICITCONVERSION )
			end if
		end if

		if( amode = FB_PARAMMODE_BYREF ) then
			'' param diff than arg can't passed by ref if it's a var/array/ptr
			select case as const pclass
			case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
			     AST_NODECLASS_FIELD, AST_NODECLASS_PTR
				hParamError( f )
				exit function
			end select
		end if

		'' const?
		if( p->defined ) then
			p = astCheckConst( adtype, p )
			if( p = NULL ) then
				exit function
			end if
		end if

		p = astNewCONV( INVALID, adtype, symbGetSubtype( arg ), p )
		if( p = NULL ) then
			hParamError( f, FB_ERRMSG_INVALIDDATATYPES )
			exit function
		end if
		n->dtype = adtype
		n->subtype = symbGetSubtype( arg )
		n->l = p

	end if

	'' pointer checking
	if( adtype >= FB_DATATYPE_POINTER ) then
		if( astPtrCheck( adtype, symbGetSubtype( arg ), p ) = FALSE ) then
			if( p->dtype < FB_DATATYPE_POINTER ) then
				hParamWarning( f, FB_WARNINGMSG_PASSINGSCALARASPTR )
			else
				hParamWarning( f, FB_WARNINGMSG_PASSINGDIFFPOINTERS )
			end if
		end if

    elseif( p->dtype >= FB_DATATYPE_POINTER ) then
    	hParamWarning( f, FB_WARNINGMSG_PASSINGPTRTOSCALAR )
	end if

	'' byref arg? check if a temp param isn't needed
	if( amode = FB_PARAMMODE_BYREF ) then
		p = hCheckByRefArg( adtype, symbGetSubtype( arg ), n )
        '' it's an implicit pointer
	end if

    function = TRUE

end function

'':::::
function astNewARG _
	( _
		byval f as ASTNODE ptr, _
		byval p as ASTNODE ptr, _
		byval dtype as integer = INVALID, _
		byval mode as integer = INVALID _
	) as ASTNODE ptr

    dim as ASTNODE ptr n, t
    dim as FBSYMBOL ptr sym

	if( dtype = INVALID ) then
		dtype = astGetDataType( p )
	end if

	'' alloc new node
	n = astNewNode( AST_NODECLASS_ARG, dtype )
	function = n

	if( n = NULL ) then
		exit function
	end if

	n->l = p
	n->arg.mode = mode
	n->arg.lgt = 0

	'' add param node to function's list
	sym = f->sym

	t = f->r

	'' pascal mode, first param added will be the first pushed
	if( sym->proc.mode = FB_FUNCMODE_PASCAL ) then
		if( t = NULL ) then
			f->r = n
		else
			t = f->call.lastarg
			t->r = n
		end if

		f->call.lastarg = n
		n->r = NULL

	else
		'' non-pascal, the latest param added will be the first pushed
		f->r = n
		n->r = t
	end if

	''
	if( hCheckParam( f, n ) = FALSE ) then
		return NULL
	end if

	''
	f->call.args += 1

	if( f->call.args < sym->proc.params ) then
		f->call.currarg = symbGetParamNext( f->call.currarg )
	end if

end function

