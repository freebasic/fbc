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


'' symbol table module for procedures
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hCalcProcParamsLen _
	( _
		byval params as integer, _
		byval paramtail as FBSYMBOL ptr _
	) as integer

	dim as integer i, lgt

	lgt	= 0
	do while( paramtail <> NULL )
		select case paramtail->param.mode
		case FB_PARAMMODE_BYVAL
			lgt	+= ((paramtail->lgt + (FB_INTEGERSIZE-1)) and _
				   not (FB_INTEGERSIZE-1))						'' x86 assumption!

		case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
			lgt	+= FB_POINTERSIZE
		end select

		paramtail = paramtail->prev
	loop

	function = lgt

end function

'':::::
function symbAddProcParam _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval lgt as integer, _
		byval mode as integer, _
		byval suffix as integer, _
		byval optional as integer, _
		byval optexpr as ASTNODE ptr _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr param

    function = NULL

    param = symbNewSymbol( NULL, _
    					   @proc->proc.paramtb, NULL, TRUE, _
    					   FB_SYMBCLASS_PARAM, _
    				   	   FALSE, id, NULL, _
    				   	   dtype, subtype, ptrcnt, _
    				   	   TRUE )
    if( param = NULL ) then
    	exit function
    end if

	proc->proc.params += 1

	''
	param->lgt = lgt
	param->param.mode = mode
	param->param.suffix = suffix
	param->param.optional = optional
	param->param.optexpr = optexpr

    function = param

end function

'':::::
private function hGetProcRealType _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer static

    select case dtype
    '' string? it's actually a pointer to a string descriptor
    case FB_DATATYPE_STRING
    	 return FB_DATATYPE_POINTER + FB_DATATYPE_STRING

    '' UDT? follow GCC 3.x's ABI
    case FB_DATATYPE_USERDEF

		'' use the un-padded UDT len
		select case as const symbGetUDTLen( subtype )
		case 1
			return FB_DATATYPE_BYTE

		case 2
			return FB_DATATYPE_SHORT

		case 3
			'' return as int only if first is a short
			if( subtype->udt.fldtb.head->lgt = 2 ) then
				'' and if the struct is not packed
				if( subtype->lgt >= FB_INTEGERSIZE ) then
					return FB_DATATYPE_INTEGER
				end if
			end if

		case FB_INTEGERSIZE

			'' return in ST(0) if there's only one element and it's a SINGLE
			if( subtype->udt.elements = 1 ) then
				do
					if( subtype->udt.fldtb.head->typ = FB_DATATYPE_SINGLE ) then
						return FB_DATATYPE_SINGLE
					end if

					if( subtype->udt.fldtb.head->typ <> FB_DATATYPE_USERDEF ) then
						exit do
					end if

					subtype = subtype->udt.fldtb.head->subtype

					if( subtype->udt.elements <> 1 ) then
						exit do
					end if
				loop
			end if

			return FB_DATATYPE_INTEGER

		case FB_INTEGERSIZE + 1, FB_INTEGERSIZE + 2, FB_INTEGERSIZE + 3

			'' return as longint only if first is a int
			if( subtype->udt.fldtb.head->lgt = FB_INTEGERSIZE ) then
				'' and if the struct is not packed
				if( subtype->lgt >= FB_INTEGERSIZE*2 ) then
					return FB_DATATYPE_LONGINT
				end if
			end if

		case FB_INTEGERSIZE*2

			'' return in ST(0) if there's only one element and it's a DOUBLE
			if( subtype->udt.elements = 1 ) then
				do
					if( subtype->udt.fldtb.head->typ = FB_DATATYPE_DOUBLE ) then
						return FB_DATATYPE_DOUBLE
					end if

					if( subtype->udt.fldtb.head->typ <> FB_DATATYPE_USERDEF ) then
						exit do
					end if

					subtype = subtype->udt.fldtb.head->subtype

					if( subtype->udt.elements <> 1 ) then
						exit do
					end if
				loop
			end if

			return FB_DATATYPE_LONGINT

		end select

		'' if nothing matched, it's the pointer that was passed as the 1st arg
		return FB_DATATYPE_POINTER + FB_DATATYPE_USERDEF

	'' type is the same
	case else
    	return dtype

	end select

end function

'':::::
private function hAddOvlProc _
	( _
		byval proc as FBSYMBOL ptr, _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval preservecase as integer _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, fparam, pparam
	dim as integer params

	function = NULL

	'' not arg-less?
	params = symbGetProcParams( proc )
	if( params > 0 ) then
		'' can't be vararg..
		pparam = symbGetProcTailParam( proc )
		if( pparam->param.mode = FB_PARAMMODE_VARARG ) then
			exit function
		end if
	end if

	'' for each overloaded proc..
	f = parent
	do while( f <> NULL )

		'' same number of params?
		if( f->proc.params = params ) then

			'' both arg-less?
			if( params = 0 ) then
				exit function
			end if

			'' for each arg..
			pparam = symbGetProcTailParam( proc )
			fparam = symbGetProcTailParam( f )

			do while( pparam <> NULL )
				'' different modes?
				if( pparam->param.mode <> fparam->param.mode ) then
					'' one is by desc? allow byref and byval args
					'' with the same type or subtype
					if( pparam->param.mode = FB_PARAMMODE_BYDESC ) then
						exit do
					elseif( fparam->param.mode = FB_PARAMMODE_BYDESC ) then
						exit do
					end if
				end if

				'' not the same type? check next proc..
				if( pparam->typ <> fparam->typ ) then
					'' handle special cases: zstring ptr and string args
					select case pparam->typ
					case FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
						if( fparam->typ <> FB_DATATYPE_STRING ) then
							exit do
						end if

					case FB_DATATYPE_STRING
						if( fparam->typ <> FB_DATATYPE_POINTER + FB_DATATYPE_CHAR ) then
							exit do
						end if

					case else
						exit do
					end select
				end if

				if( pparam->subtype <> fparam->subtype ) then
					exit do
				end if

				pparam = pparam->prev
				fparam = fparam->prev
			loop

			'' all params equal? can't overload..
			if( pparam = NULL ) then
				exit function
			end if

		end if

		f = f->proc.ovl.next
	loop


    '' add the new proc symbol, w/o adding it to the hash table

	proc = symbNewSymbol( proc, _
						  NULL, NULL, TRUE, _
						  FB_SYMBCLASS_PROC, _
						  FALSE, id, id_alias, _
					      dtype, subtype, ptrcnt, _
					      preservecase )

	if( proc = NULL ) then
		exit function
	end if

	'' add to hash chain list, as they share the same name
	dim as FBSYMCHAIN ptr chain_, nxt
	chain_ = listNewNode( @symb.chainlist )

	chain_->index = parent->hash.chain->index
	chain_->item = parent->hash.chain->item

    nxt = parent->hash.chain->next
	parent->hash.chain->next = chain_

	chain_->prev = parent->hash.chain
	chain_->next = nxt
	if( nxt <> NULL ) then
		nxt->prev = chain_
	end if

	chain_->sym = proc
	proc->hash.chain = chain_

    ''
	function = proc

end function

'':::::
function symbIsProcOverloadOf _
	( _
		byval proc as FBSYMBOL ptr, _
		byval parent as FBSYMBOL ptr _
	) as integer static

	dim as FBSYMBOL ptr f

	'' no parent?
	if( parent = NULL ) then
		return FALSE
	end if

	'' same?
	if( proc = parent ) then
		return TRUE
	end if

	'' not overloaded?
	if( symbIsOverloaded( parent ) = FALSE ) then
		return FALSE
	end if

	'' for each overloaded proc..
	f = parent->proc.ovl.next
	do while( f <> NULL )

		'' same?
		if( proc = f ) then
			return TRUE
		end if

		f = f->proc.ovl.next
	loop

	'' none found..
	return FALSE

end function

'':::::
private function hSetupProc _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval libname as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval attrib as integer, _
		byval mode as integer, _
		byval declaring as integer, _
		byval preservecase as integer _
	) as FBSYMBOL ptr static

    dim as integer lgt, realtype, stats
    dim as FBSYMBOL ptr proc, parent

    function = NULL

	''
	if( dtype = INVALID ) then
		dtype = hGetDefType( id )
		subtype = NULL
	end if

    realtype = hGetProcRealType( dtype, subtype )

    lgt = hCalcProcParamsLen( symbGetProcParams( sym ), _
    						  symbGetProcTailParam( sym ) )

    '' no explict alias?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( env.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    	stats = 0
    else
    	stats = FB_SYMBSTATS_HASALIAS
    end if

	''
	proc = symbNewSymbol( sym, _
						  NULL, NULL, TRUE, _
						  FB_SYMBCLASS_PROC, _
						  TRUE, id, id_alias, _
					   	  dtype, subtype, ptrcnt, _
					   	  preservecase )

	'' dup def?
	if( proc = NULL ) then
		'' is the dup a proc symbol?
		parent = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
										   id, _
										   FB_SYMBCLASS_PROC, _
										   preservecase )
		if( parent = NULL ) then
			exit function
		end if

		'' proc was defined as overloadable?
		if( symbIsOverloaded( parent ) = FALSE ) then
			exit function
		end if

		'' try to overload..
		proc = hAddOvlProc( sym, parent, id, id_alias, _
							dtype, subtype, ptrcnt, _
							preservecase )
		if( proc = NULL ) then
			exit function
		end if

		attrib or= FB_SYMBATTRIB_OVERLOADED

	else
		parent = NULL
	end if

    ''
	proc->attrib = attrib or FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC

    '' if proc returns an UDT, add the hidden pointer passed as the 1st arg
    if( dtype = FB_DATATYPE_USERDEF ) then
    	if( realtype = FB_DATATYPE_POINTER + FB_DATATYPE_USERDEF ) then
    		lgt += FB_POINTERSIZE
    	end if
    end if

	proc->proc.lgt = lgt

	if( declaring ) then
		symbSetIsDeclared( proc )
	end if

	proc->proc.mode	= mode
	proc->proc.realtype	= realtype

	proc->proc.rtl.callback = NULL

	if( libname <> NULL ) then
		if( len( *libname ) > 0 ) then
			proc->proc.lib = symbAddLib( libname )
		else
			proc->proc.lib = NULL
		end if
	else
		proc->proc.lib = env.currlib
	end if

	'' if overloading, update the linked-list
	if( (attrib and FB_SYMBATTRIB_OVERLOADED) <> 0 ) then
		if( parent <> NULL ) then
			proc->proc.ovl.next = parent->proc.ovl.next
			parent->proc.ovl.next = proc

			if( symbGetProcParams( proc ) > parent->proc.ovl.maxparams ) then
				parent->proc.ovl.maxparams = symbGetProcParams( proc )
			end if
		else
			proc->proc.ovl.next = NULL
			proc->proc.ovl.maxparams = symbGetProcParams( proc )
		end if

	'' ctor or dtor? even if private it should be always emitted
	elseif( (attrib and (FB_SYMBATTRIB_CONSTRUCTOR or _
						 FB_SYMBATTRIB_DESTRUCTOR)) <> 0 ) then
		symbSetIsCalled( proc )
	end if

	''
	proc->proc.ext = NULL

	proc->stats or= stats

	function = proc

end function

'':::::
function symbAddPrototype _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval libname as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval attrib as integer, _
		byval mode as integer, _
		byval isexternal as integer, _
		byval preservecase as integer = FALSE _
	) as FBSYMBOL ptr static

    function = NULL

	proc = hSetupProc( proc, id, id_alias, libname, _
					   dtype, subtype, ptrcnt, _
					   attrib, mode, isexternal, preservecase )
	if( proc = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function symbAddProc _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval libname as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval attrib as integer, _
		byval mode as integer _
	) as FBSYMBOL ptr static

    function = NULL

	proc = hSetupProc( proc, id, id_alias, libname, _
					   dtype, subtype, ptrcnt, _
					   attrib, mode, TRUE, FALSE )
	if( proc = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function symbPreAddProc _
	( _
		byval symbol as zstring ptr _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr proc

	proc = listNewNode( @symb.symlist )
	if( proc = NULL ) then
		exit function
	end if

	proc->class = FB_SYMBCLASS_PROC
	proc->proc.params	= 0
	proc->proc.paramtb.owner = proc
	proc->proc.paramtb.head = NULL
	proc->proc.paramtb.tail = NULL
	proc->name = symbol

	function = proc

end function

'':::::
function symbAddParam _
	( _
		byval symbol as zstring ptr, _
		byval param as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

    dim as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr s
    dim as integer attrib, dtype

	function = NULL

	dtype = param->typ

	select case as const param->param.mode
    case FB_PARAMMODE_BYVAL
    	'' byval string? it's actually an pointer to a zstring
    	if( dtype = FB_DATATYPE_STRING ) then
    		attrib = FB_SYMBATTRIB_PARAMBYREF
    		dtype = FB_DATATYPE_CHAR
    	else
    		attrib = FB_SYMBATTRIB_PARAMBYVAL
    	end if

	case FB_PARAMMODE_BYREF
	    attrib = FB_SYMBATTRIB_PARAMBYREF

	case FB_PARAMMODE_BYDESC
    	attrib = FB_SYMBATTRIB_PARAMBYDESC

	case else
    	exit function
	end select

    function = symbAddVarEx( symbol, NULL, dtype, param->subtype, 0, 0, _
    				  		 0, dTB(), attrib, _
    				  		 param->param.suffix <> INVALID, FALSE )

end function

'':::::
function symbAddProcResultParam _
	( _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

    dim as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr s

	'' UDT?
	if( proc->typ <> FB_DATATYPE_USERDEF ) then
		return NULL
	end if

	'' returning a ptr?
	if( proc->proc.realtype <> FB_DATATYPE_POINTER+FB_DATATYPE_USERDEF ) then
		return NULL
	end if

    s = symbAddVarEx( NULL, NULL, _
    				  FB_DATATYPE_POINTER+FB_DATATYPE_USERDEF, proc->subtype, 0, 0, _
    				  0, dTB(), FB_SYMBATTRIB_PARAMBYVAL, _
    				  TRUE, TRUE )


	if( proc->proc.ext = NULL ) then
		proc->proc.ext = callocate( len( FB_PROCEXT ) )
	end if

	proc->proc.ext->res = s

	function = s

end function

'':::::
function symbAddProcResult _
	( _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

	dim as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s, subtype
	dim as integer dtype

	'' UDT?
	if( proc->typ = FB_DATATYPE_USERDEF ) then
		'' returning a ptr? result is at the hidden arg
		if( proc->proc.realtype = FB_DATATYPE_POINTER+FB_DATATYPE_USERDEF ) then
			return symbGetProcResult( proc )
		end if
	end if

	s = symbAddVarEx( NULL, NULL, proc->typ, proc->subtype, 0, 0, 0, _
					  dTB(), FB_SYMBATTRIB_FUNCRESULT, TRUE, TRUE )

	if( proc->proc.ext = NULL ) then
		proc->proc.ext = callocate( len( FB_PROCEXT ) )
	end if

	proc->proc.ext->res = s

	function = s

end function

'':::::
function symbProcAllocLocals _
	( _
		byval proc as FBSYMBOL ptr _
	) as integer static

    dim as FBSYMBOL ptr s
    dim as integer lgt

    function = FALSE

    s = symbGetProcLocTbHead( proc )
    do while( s <> NULL )
    	'' variable?
    	if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared or static?
    		if( (s->attrib and (FB_SYMBATTRIB_SHARED or _
    			 				FB_SYMBATTRIB_STATIC)) = 0 ) then

				'' not a parameter?
    			if( (s->attrib and (FB_SYMBATTRIB_PARAMBYDESC or _
    						   	    FB_SYMBATTRIB_PARAMBYVAL or _
    			  				   	FB_SYMBATTRIB_PARAMBYREF)) = 0 ) then

					lgt = s->lgt * symbGetArrayElements( s )
					s->ofs = emitAllocLocal( env.currproc, lgt )

				'' parameter..
				else
					lgt = iif( (s->attrib and FB_SYMBATTRIB_PARAMBYVAL), _
						   	   s->lgt, _
						   	   FB_POINTERSIZE )
					s->ofs = emitAllocArg( env.currproc, lgt )

				end if

				symbSetIsAllocated( s )

			end if

		end if

    	s = s->next
    loop

    function = TRUE

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookup
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbFindOverloadProc _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, fparam, pparam, fsubtype, psubtype
	dim as integer params

	''
	if( (parent = NULL) or (proc = NULL) ) then
		return NULL
	end if

	'' procs?
	if( (symbGetClass( parent ) <> FB_SYMBCLASS_PROC) or _
		(symbGetClass( proc ) <> FB_SYMBCLASS_PROC) ) then
		return NULL
	end if

	params = symbGetProcParams( proc )

	'' for each proc starting from parent..
	f = parent
	do while( f <> NULL )

		if( params = f->proc.params ) then

			'' arg-less?
			if( params = 0 ) then
				return f
			end if

			'' for each arg..
			fparam = symbGetProcTailParam( f )
			pparam = symbGetProcTailParam( proc )
			do while( pparam <> NULL )

				'' different modes?
				if( pparam->param.mode <> fparam->param.mode ) then
					'' one is by desc? can't be the same..
					if( pparam->param.mode = FB_PARAMMODE_BYDESC ) then
						exit do
					elseif( fparam->param.mode = FB_PARAMMODE_BYDESC ) then
						exit do
					end if
				end if

				'' not the same type? check next proc..
				if( pparam->typ <> fparam->typ ) then
					exit do
				end if

				if( pparam->subtype <> fparam->subtype ) then
					exit do
				end if

				pparam = pparam->prev
				fparam = fparam->prev
			loop

			'' all args equal?
			if( pparam = NULL ) then
				return f
			end if

		end if

		f = f->proc.ovl.next
	loop

	function = NULL

end function

const FB_OVLPROC_HALFMATCH = FB_DATATYPES
const FB_OVLPROC_FULLMATCH = FB_OVLPROC_HALFMATCH * 2

'':::::
private function hCheckOvlParam _
	( _
		byval param as FBSYMBOL ptr, _
	  	byval arg_expr as ASTNODE ptr, _
		byval arg_mode as integer _
	) as integer static

	dim as integer adtype, adclass, pdtype
	dim as FBSYMBOL ptr s, asubtype

	'' arg not passed?
	if( arg_expr = NULL ) then
		'' but param isn't optional?
		if( symbGetParamOptional( param ) = FALSE ) then
			return 0
		end if

		return FB_OVLPROC_FULLMATCH
    end if

	pdtype = symbGetType( param )

	adtype = astGetDataType( arg_expr )
	asubtype = astGetSubType( arg_expr )

	'' by descriptor param?
	if( symbGetParamMode( param ) = FB_PARAMMODE_BYDESC ) then
		'' but arg isn't?
		if( arg_mode <> FB_PARAMMODE_BYDESC ) then
			return 0
		end if

		'' not a full match?
        if( pdtype <> adtype ) then
        	return 0
        end if

        if( symbGetSubType( param ) <> asubtype ) then
        	return 0
        end if

		return FB_OVLPROC_FULLMATCH

	'' by descriptor arg?
	elseif( arg_mode = FB_PARAMMODE_BYDESC ) then
		'' refuse
		return 0
	end if

	'' same types?
	if( pdtype = adtype ) then
		'' check the subtype
		if( symbGetSubType( param ) <> asubtype ) then

			'' pointer? subtypes can't be different
			if( pdtype >= FB_DATATYPE_POINTER ) then
				return 0
			end if

			'' check classes
			select case symbGetDataClass( pdtype )
			'' UDT? can't be different..
			case FB_DATACLASS_UDT
				return 0
			end select

			'' allow different ENUM's?

			return FB_OVLPROC_HALFMATCH
        end if

		'' same subtype too, full match..
		return FB_OVLPROC_FULLMATCH
	end if

	'' different types..
	adclass = symbGetDataClass( adtype )

	'' check classes
	select case as const symbGetDataClass( pdtype )
	'' integer?
	case FB_DATACLASS_INTEGER

		select case as const adclass
		'' another integer..
		case FB_DATACLASS_INTEGER

			'' handle special cases..
			select case as const adtype
			case FB_DATATYPE_CHAR
				select case pdtype
				case FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
					return FB_OVLPROC_FULLMATCH
				case FB_DATATYPE_POINTER + FB_DATATYPE_WCHAR
					return FB_OVLPROC_HALFMATCH
				end select

			case FB_DATATYPE_WCHAR
				select case pdtype
				case FB_DATATYPE_POINTER + FB_DATATYPE_WCHAR
					return FB_OVLPROC_FULLMATCH
				case FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
					return FB_OVLPROC_HALFMATCH
				end select

			case FB_DATATYPE_BITFIELD, FB_DATATYPE_ENUM
				adtype = symbRemapType( adtype, asubtype )

			end select

			'' check pointers..
			if( pdtype >= FB_DATATYPE_POINTER ) then
				'' isn't arg a pointer too?
				if( adtype < FB_DATATYPE_POINTER ) then
					'' not a numeric constant?
					if( astIsCONST( arg_expr ) = FALSE ) then
						return 0
					end if
					'' not 0 (NULL)?
					if( astGetValInt( arg_expr ) <> 0 ) then
						return 0
					end if

					return FB_OVLPROC_FULLMATCH
				end if

				'' param isn't an any ptr?
				if( pdtype <> FB_DATATYPE_POINTER+FB_DATATYPE_VOID ) then
					'' arg neither?
					if( adtype <> FB_DATATYPE_POINTER+FB_DATATYPE_VOID ) then
						return 0
					end if

					'' not the same level of indirection?
					if( (pdtype mod FB_DATATYPE_POINTER) > 1 ) then
						return 0
					end if

					return FB_OVLPROC_FULLMATCH

				else
					'' as in g++, the arg indirection level shouldn't matter..
					return FB_OVLPROC_FULLMATCH
				end if

			'' param not a pointer, but is arg?
			elseif( adtype >= FB_DATATYPE_POINTER ) then
				'' use an UINT instead or LONGINT will match if any..
				adtype = FB_DATATYPE_UINT
			end if

			return FB_OVLPROC_HALFMATCH - abs( pdtype - adtype )

		'' float? (ok due the auto-coercion, unless it's a pointer)
		case FB_DATACLASS_FPOINT
			if( pdtype >= FB_DATATYPE_POINTER ) then
				return 0
			end if

			return FB_OVLPROC_HALFMATCH - abs( pdtype - adtype )

		'' string? only if it's a w|zstring ptr arg
		case FB_DATACLASS_STRING
			select case pdtype
			case FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
				return FB_OVLPROC_FULLMATCH
			case FB_DATATYPE_POINTER + FB_DATATYPE_WCHAR
				return FB_OVLPROC_HALFMATCH
			case else
				return 0
			end select

		'' refuse anything else
		case else
			return 0
		end select

	'' floating-point?
	case FB_DATACLASS_FPOINT

		select case as const adclass
		'' only accept if it's an integer (but pointers)
		case FB_DATACLASS_INTEGER
			if( adtype >= FB_DATATYPE_POINTER ) then
				return 0
			end if

			'' remap to real type if it's a bitfield..
			select case adtype
			case FB_DATATYPE_BITFIELD, FB_DATATYPE_ENUM
				adtype = symbRemapType( adtype, asubtype )
			end select

			return FB_OVLPROC_HALFMATCH - abs( pdtype - adtype )

		'' or if another float..
		case FB_DATACLASS_FPOINT
			return FB_OVLPROC_HALFMATCH - abs( pdtype - adtype )

		'' refuse anything else
		case else
			return 0

		end select

	'' string?
	case FB_DATACLASS_STRING

		select case adclass
		'' okay if it's a fixed-len string
		case FB_DATACLASS_STRING
			return FB_OVLPROC_FULLMATCH

		'' integer only if it's a w|zstring
		case FB_DATACLASS_INTEGER
			select case adtype
			case FB_DATATYPE_CHAR
				return FB_OVLPROC_FULLMATCH
			case FB_DATATYPE_WCHAR
				return FB_OVLPROC_HALFMATCH
			case else
				return 0
			end select

		'' refuse anything else
		case else
			return 0
		end select

	'' user-defined..
	case FB_DATACLASS_UDT

		'' not another udt?
		if( adclass <> FB_DATACLASS_UDT ) then
			'' not a proc? (can be an UDT been returned in registers)
			if( astGetClass( arg_expr ) <> AST_NODECLASS_CALL ) then
				return 0
			end if

			'' it's a proc, but was it originally returning an UDT?
			s = astGetSymbol( arg_expr )
			if( symbGetType( s ) <> FB_DATATYPE_USERDEF ) then
				return 0
			end if

			'' get the original subtype
			s = symbGetSubType( s )

		'' udt..
		else
           	s = asubtype
		end if

        '' can't be different
		if( symbGetSubType( param ) <> s ) then
			return 0
		end if

		return FB_OVLPROC_FULLMATCH

	'' can't happen?
	case else
		return 0

	end select

end function

'':::::
function symbFindClosestOvlProc _
	( _
		byval prochead as FBSYMBOL ptr, _
		byval args as integer, _
		byval arg_head as FB_CALL_ARG ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr proc, ovlproc, param
	dim as integer i, argmatches, matches, maxmatches, ambcnt
	dim as FB_CALL_ARG ptr arg

	ovlproc = NULL
	maxmatches = 0
	ambcnt = 0

	'' for each proc..
	proc = prochead
	do while( proc <> NULL )

		if( args <= symbGetProcParams( proc ) ) then

			'' arg-less? exit..
			if( symbGetProcParams( proc ) = 0 ) then
				return proc
			end if

			param = symbGetProcLastParam( proc )
			matches = 0

			'' for each arg..
			arg = arg_head
			for i = 0 to args-1

				argmatches = hCheckOvlParam( param, arg->expr, arg->mode )
				if( argmatches = 0 ) then
					matches = 0
					exit for
				end if
				matches += argmatches

               	'' next param
				param = symbGetProcPrevParam( proc, param )
				arg = arg->next
			next

			'' fewer params? check if the ones missing are optional
			if( args < symbGetProcParams( proc ) ) then
				if( (matches > 0) or (args = 0) ) then
					do while( param <> NULL )
			    		'' not optional? exit
			    		if( symbGetParamOptional( param ) = FALSE ) then
			    			matches = 0
			    			exit do
			    		else
			    			matches += FB_OVLPROC_FULLMATCH
			    		end if

						'' next param
						param = symbGetProcPrevParam( proc, param )
					loop
				end if
			end if

		    '' closer?
		    if( matches > maxmatches ) then
			   	ovlproc = proc
			   	maxmatches = matches
			   	ambcnt = 0

			'' same? ambiguity..
			elseif( matches = maxmatches ) then
				if( maxmatches > 0 ) then
					ambcnt += 1
				end if
			end if

		end if

		'' next overloaded proc
		proc = proc->proc.ovl.next
	loop

	'' more than one possibility?
	if( ambcnt > 0 ) then
		errReportParam( prochead, 0, NULL, FB_ERRMSG_AMBIGUOUSCALLTOPROC )
		function = NULL
	else
		'' no matches?
		if( ovlproc = NULL ) then
			errReportParam( prochead, 0, NULL, FB_ERRMSG_NOMATCHINGPROC )
		end if
		function = ovlproc
	end if

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hDelParams _
	( _
		byval f as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr param, nxt

    param = f->proc.paramtb.head
    do while( param <> NULL )
    	nxt = param->next
    	symbFreeSymbol( param )
    	param = nxt
    loop

end sub

'':::::
sub symbDelPrototype _
	( _
		byval s as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr n

    if( s = NULL ) then
    	exit sub
    end if

	do
		'' overloaded?
		if( symbIsOverloaded( s ) ) then
			n = s->proc.ovl.next
		else
			n = NULL
		end if

		'' del args..
		if( s->proc.params > 0 ) then
			hDelParams( s )
		end if

    	''
    	if( s->proc.ext <> NULL ) then
    		deallocate( s->proc.ext )
    		s->proc.ext = NULL
    	end if

    	symbFreeSymbol( s )

    	'' next overload
    	s = n
    loop while( s <> NULL )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbGetProcResult _
	( _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

	if( proc = NULL ) then
		return NULL
	end if

	if( proc->proc.ext = NULL ) then
		return NULL
	end if

	function = proc->proc.ext->res

end function

'':::::
function symbCalcParamLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as integer _
	) as integer static

    dim as integer lgt

	select case mode
	case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
		lgt = FB_POINTERSIZE
	case else
		if( dtype = FB_DATATYPE_STRING ) then
			lgt = FB_POINTERSIZE
		else
			lgt = symbCalcLen( dtype, subtype )
		end if
	end select

	function = lgt

end function

'':::::
sub symbSetProcIncFile _
	( _
		byval p as FBSYMBOL ptr, _
		byval incf as zstring ptr _
	)

	if( p->proc.ext = NULL ) then
		p->proc.ext = callocate( len( FB_PROCEXT ) )
	end if

	p->proc.ext->dbg.incfile = incf

end sub

'':::::
function symbMangleFunctionPtr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as integer _
	) as zstring ptr static

    static as string id
    dim as FBSYMBOL ptr param
    dim as integer i

    '' cheapo and fast internal mangling..

    id = "{fbfp}"

    '' for each param..
    param = symbGetProcHeadParam( proc )
    for i = 0 to symbGetProcParams( proc )-1
    	id += "_"

    	if( param->subtype = NULL ) then
    		id += hex( param->typ * cint(param->param.mode) )
    	else
    		id += hex( param->subtype )
    	end if

    	param = symbGetParamNext( param )
    next

    id += "@"

	if( subtype = NULL ) then
		id += hex( dtype )
	else
		id += hex( subtype )
	end if

    id += "@"

    id += hex( mode )

	function = strptr( id )

end function

'':::::
function symbDemangleFunctionPtr _
	( _
		byval proc as FBSYMBOL ptr _
	) as zstring ptr

	static as zstring ptr parammodeTb( FB_PARAMMODE_BYVAL to FB_PARAMMODE_VARARG ) = _
	{ _
		@"byval", _
		@"byref", _
		@"bydesc", _
		@"vararg" _
	}
	static as string res
	dim as FBSYMBOL ptr param

	'' sub or function?
	if( proc->typ <> FB_DATATYPE_VOID ) then
		res = "function("
	else
		res = "sub("
	end if

    '' for each param..
    param = symbGetProcHeadParam( proc )
    do while( param <> NULL )
    	select case as const param->param.mode
    	case FB_PARAMMODE_BYVAL, FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
			res += *parammodeTb(param->param.mode)
			res += " as "
			res += *symbTypeToStr( param->typ, param->subtype )

		case FB_PARAMMODE_VARARG
			res += "..."
		end select

    	param = symbGetParamNext( param )

    	if( param <> NULL ) then
    		res += ", "
    	end if
    loop

	res += ")"

	'' any return type?
	if( proc->typ <> FB_DATATYPE_VOID ) then
    	res += " as "
    	res += *symbTypeToStr( proc->typ, proc->subtype )
	end if

	function = strptr( res )

end function


