''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

const FBPREFIX_PROCRES = "{fbpr}"

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hCalcProcArgsLen( byval args as integer, _
						   		   byval argtail as FBSYMBOL ptr ) as integer
	dim i as integer, lgt as integer

	lgt	= 0
	do while( argtail <> NULL )
		select case argtail->arg.mode
		case FB_ARGMODE_BYVAL
			lgt	+= ((argtail->lgt + (FB_INTEGERSIZE-1)) and _
				   not (FB_INTEGERSIZE-1))						'' x86 assumption!

		case FB_ARGMODE_BYREF, FB_ARGMODE_BYDESC
			lgt	+= FB_POINTERSIZE
		end select

		argtail = argtail->prev
	loop

	function = lgt

end function

'':::::
function symbAddArg( byval proc as FBSYMBOL ptr, _
					 byval symbol as zstring ptr, _
					 byval typ as integer, _
					 byval subtype as FBSYMBOL ptr, _
					 byval ptrcnt as integer, _
					 byval lgt as integer, _
					 byval mode as integer, _
					 byval suffix as integer, _
					 byval optional as integer, _
					 byval optval as FBVALUE ptr ) as FBSYMBOL ptr static

    dim a as FBSYMBOL ptr

    function = NULL

    a = symbNewSymbol( NULL, @proc->proc.argtb, FB_SYMBCLASS_PROCARG, FALSE, _
    				   NULL, symbol, _
    				   FALSE, typ, subtype, ptrcnt, INVALID, TRUE )
    if( a = NULL ) then
    	exit function
    end if

	proc->proc.args += 1

	''
	a->lgt			= lgt
	a->arg.mode		= mode
	a->arg.suffix	= suffix
	a->arg.optional	= optional

	if( optional ) then
		a->arg.optval = *optval
	end if

    function = a

end function

'':::::
private function hGetProcRealType( byval typ as integer, _
								   byval subtype as FBSYMBOL ptr ) as integer static

    select case typ
    '' string? it's actually a pointer to a string descriptor
    case FB_SYMBTYPE_STRING
    	 return FB_SYMBTYPE_POINTER + FB_SYMBTYPE_STRING

    '' UDT? follow GCC 3.x's ABI
    case FB_SYMBTYPE_USERDEF

		'' use the un-padded UDT len
		select case as const symbGetUDTLen( subtype )
		case 1
			return FB_SYMBTYPE_BYTE

		case 2
			return FB_SYMBTYPE_SHORT

		case 3
			'' return as int only if first is a short
			if( subtype->udt.fldtb.head->lgt = 2 ) then
				'' and if the struct is not packed
				if( subtype->lgt >= FB_INTEGERSIZE ) then
					return FB_SYMBTYPE_INTEGER
				end if
			end if

		case FB_INTEGERSIZE

			'' return in ST(0) if there's only one element and it's a SINGLE
			if( subtype->udt.elements = 1 ) then
				do
					if( subtype->udt.fldtb.head->typ = FB_SYMBTYPE_SINGLE ) then
						return FB_SYMBTYPE_SINGLE
					end if

					if( subtype->udt.fldtb.head->typ <> FB_SYMBTYPE_USERDEF ) then
						exit do
					end if

					subtype = subtype->udt.fldtb.head->subtype

					if( subtype->udt.elements <> 1 ) then
						exit do
					end if
				loop
			end if

			return FB_SYMBTYPE_INTEGER

		case FB_INTEGERSIZE + 1, FB_INTEGERSIZE + 2, FB_INTEGERSIZE + 3

			'' return as longint only if first is a int
			if( subtype->udt.fldtb.head->lgt = FB_INTEGERSIZE ) then
				'' and if the struct is not packed
				if( subtype->lgt >= FB_INTEGERSIZE*2 ) then
					return FB_SYMBTYPE_LONGINT
				end if
			end if

		case FB_INTEGERSIZE*2

			'' return in ST(0) if there's only one element and it's a DOUBLE
			if( subtype->udt.elements = 1 ) then
				do
					if( subtype->udt.fldtb.head->typ = FB_SYMBTYPE_DOUBLE ) then
						return FB_SYMBTYPE_DOUBLE
					end if

					if( subtype->udt.fldtb.head->typ <> FB_SYMBTYPE_USERDEF ) then
						exit do
					end if

					subtype = subtype->udt.fldtb.head->subtype

					if( subtype->udt.elements <> 1 ) then
						exit do
					end if
				loop
			end if

			return FB_SYMBTYPE_LONGINT

		end select

		'' if nothing matched, it's the pointer that was passed as the 1st arg
		return FB_SYMBTYPE_POINTER + FB_SYMBTYPE_USERDEF

	'' type is the same
	case else
    	return typ

	end select

end function

'':::::
private function hAddOvlProc( byval proc as FBSYMBOL ptr, _
							  byval parent as FBSYMBOL ptr, _
							  byval symbol as zstring ptr, _
							  byval aname as zstring ptr, _
							  byval typ as integer, _
							  byval subtype as FBSYMBOL ptr, _
							  byval ptrcnt as integer, _
				              byval preservecase as integer ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, farg, parg
	dim as integer argc

	function = NULL

	'' not arg-less?
	argc = symbGetProcArgs( proc )
	if( argc > 0 ) then
		'' can't be vararg..
		parg = symbGetProcTailArg( proc )
		if( parg->arg.mode = FB_ARGMODE_VARARG ) then
			exit function
		end if
	end if

	'' for each overloaded proc..
	f = parent
	do while( f <> NULL )

		'' same number of args?
		if( f->proc.args = argc ) then

			'' both arg-less?
			if( argc = 0 ) then
				exit function
			end if

			'' for each arg..
			parg = symbGetProcTailArg( proc )
			farg = symbGetProcTailArg( f )

			do while( parg <> NULL )
				'' different modes?
				if( parg->arg.mode <> farg->arg.mode ) then
					'' one is by desc? allow byref and byval args
					'' with the same type or subtype
					if( parg->arg.mode = FB_ARGMODE_BYDESC ) then
						exit do
					elseif( farg->arg.mode = FB_ARGMODE_BYDESC ) then
						exit do
					end if
				end if

				'' not the same type? check next proc..
				if( parg->typ <> farg->typ ) then
					'' handle special cases: zstring ptr and string args
					select case parg->typ
					case FB_SYMBTYPE_POINTER + FB_SYMBTYPE_CHAR
						if( farg->typ <> FB_SYMBTYPE_STRING ) then
							exit do
						end if

					case FB_SYMBTYPE_STRING
						if( farg->typ <> FB_SYMBTYPE_POINTER + FB_SYMBTYPE_CHAR ) then
							exit do
						end if

					case else
						exit do
					end select
				end if

				if( parg->subtype <> farg->subtype ) then
					exit do
				end if

				parg = parg->prev
				farg = farg->prev
			loop

			'' all args equal? can't overload..
			if( parg = NULL ) then
				exit function
			end if

		end if

		f = f->proc.ovl.next
	loop


    '' add the new proc symbol, w/o adding it to the hash table
	proc = symbNewSymbol( proc, @symb.globtb, FB_SYMBCLASS_PROC, FALSE, _
					      symbol, aname, _
					      FALSE, typ, subtype, ptrcnt, INVALID, preservecase )

	if( proc = NULL ) then
		exit function
	end if

	'' add to linked-list or getOrgName will fail
	parent->right	= proc
	proc->left      = parent

	proc->hashitem  = parent->hashitem
	proc->hashindex	= parent->hashindex

    ''
	function = proc

end function

'':::::
function symbIsProcOverloadOf( byval proc as FBSYMBOL ptr, _
							   byval parent as FBSYMBOL ptr ) as integer static

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
private function hSetupProc( byval sym as FBSYMBOL ptr, _
							 byval id as zstring ptr, _
							 byval aliasname as zstring ptr, _
							 byval libname as zstring ptr, _
				             byval typ as integer, _
				             byval subtype as FBSYMBOL ptr, _
				             byval ptrcnt as integer, _
				             byval alloctype as integer, _
				             byval mode as integer, _
			                 byval declaring as integer, _
			                 byval preservecase as integer ) as FBSYMBOL ptr static

    static as zstring * FB_MAXINTNAMELEN+1 aname
    dim as integer lgt, realtype
    dim as FBSYMBOL ptr proc, parent

    function = NULL

	''
	if( typ = INVALID ) then
		typ = hGetDefType( id )
		subtype = NULL
	end if

    realtype = hGetProcRealType( typ, subtype )

    lgt = hCalcProcArgsLen( symbGetProcArgs( sym ), symbGetProcTailArg( sym ) )

    '' no alias? make one..
    if( aliasname = NULL ) then

    	hUcase( id, aname )

    	'' overloaded?
		if( (alloctype and FB_ALLOCTYPE_OVERLOADED) > 0 ) then
			aname = *hCreateOvlProcAlias( aname, _
										  symbGetProcArgs( sym ), _
										  symbGetProcHeadArg( sym ) )
		end if

		aname = *hCreateProcAlias( aname, lgt, mode )

    '' alias given..
    else
	   	aname = *hCreateProcAlias( aliasname, lgt, mode )
    end if

    ''
	proc = symbNewSymbol( sym, @symb.globtb, FB_SYMBCLASS_PROC, TRUE, _
					   	  id, @aname, _
					   	  FALSE, typ, subtype, ptrcnt, INVALID, preservecase )

	'' dup def?
	if( proc = NULL ) then
		'' is the dup a proc symbol?
		parent = symbFindByNameAndClass( id, FB_SYMBCLASS_PROC, preservecase )
		if( parent = NULL ) then
			exit function
		end if

		'' proc was defined as overloadable?
		if( symbIsOverloaded( parent ) = FALSE ) then
			exit function
		end if

    	'' no alias?
    	if( aliasname = NULL ) then
			'' not declared explicitly as overloaded?
			if( (alloctype and FB_ALLOCTYPE_OVERLOADED) = 0 ) then
    			hUcase( *id, aname )

				aname = *hCreateOvlProcAlias( aname, _
											  symbGetProcArgs( sym ), _
											  symbGetProcHeadArg( sym ) )

				aname = *hCreateProcAlias( aname, lgt, mode )
			end if
		end if

		'' try to overload..
		proc = hAddOvlProc( sym, parent, id, aname, typ, subtype, ptrcnt, preservecase )
		if( proc = NULL ) then
			exit function
		end if

		alloctype or= FB_ALLOCTYPE_OVERLOADED

	else
		parent = NULL
	end if

    ''
	proc->alloctype			= alloctype or FB_ALLOCTYPE_SHARED

    '' if proc returns an UDT, add the hidden pointer passed as the 1st arg
    if( typ = FB_SYMBTYPE_USERDEF ) then
    	if( realtype = FB_SYMBTYPE_POINTER + FB_SYMBTYPE_USERDEF ) then
    		lgt += FB_POINTERSIZE
    	end if
    end if

	proc->lgt				= lgt

	proc->proc.isdeclared 	= declaring
	proc->proc.iscalled		= FALSE
	proc->proc.isrtl		= FALSE
	proc->proc.doerrorcheck	= FALSE

	proc->proc.mode			= mode
	proc->proc.realtype		= realtype

	proc->proc.rtl.callback = NULL

	if( libname <> NULL ) then
		if( len( *libname ) > 0 ) then
			proc->proc.lib 	= symbAddLib( libname )
		else
			proc->proc.lib 	= NULL
		end if
	else
		proc->proc.lib 		= NULL
	end if

	'' if overloading, update the linked-list
	if( (alloctype and FB_ALLOCTYPE_OVERLOADED) > 0 ) then
		if( parent <> NULL ) then
			proc->proc.ovl.next = parent->proc.ovl.next
			parent->proc.ovl.next = proc

			if( symbGetProcArgs( proc ) > parent->proc.ovl.maxargs ) then
				parent->proc.ovl.maxargs = symbGetProcArgs( proc )
			end if
		else
			proc->proc.ovl.next		= NULL
			proc->proc.ovl.maxargs	= symbGetProcArgs( proc )
		end if

	'' ctor or dtor? even if private it should be always emitted
	elseif( (alloctype and (FB_ALLOCTYPE_CONSTRUCTOR or FB_ALLOCTYPE_DESTRUCTOR)) > 0 ) then
		proc->proc.iscalled = TRUE
	end if

	function = proc

end function

'':::::
function symbAddPrototype( byval proc as FBSYMBOL ptr, _
						   byval symbol as zstring ptr, _
						   byval aliasname as zstring ptr, _
						   byval libname as zstring ptr, _
						   byval typ as integer, _
						   byval subtype as FBSYMBOL ptr, _
						   byval ptrcnt as integer, _
						   byval alloctype as integer, _
						   byval mode as integer, _
						   byval isexternal as integer, _
						   byval preservecase as integer = FALSE ) as FBSYMBOL ptr static

    function = NULL

	proc = hSetupProc( proc, symbol, aliasname, libname, _
					   typ, subtype, ptrcnt, _
					   alloctype, mode, isexternal, preservecase )
	if( proc = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function symbAddProc( byval proc as FBSYMBOL ptr, _
					  byval symbol as zstring ptr, _
					  byval aliasname as zstring ptr, _
					  byval libname as zstring ptr, _
					  byval typ as integer, _
					  byval subtype as FBSYMBOL ptr, _
					  byval ptrcnt as integer, _
					  byval alloctype as integer, _
					  byval mode as integer ) as FBSYMBOL ptr static

    function = NULL

	proc = hSetupProc( proc, symbol, aliasname, libname, _
					   typ, subtype, ptrcnt, _
					   alloctype, mode, TRUE, FALSE )
	if( proc = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function symbPreAddProc( ) as FBSYMBOL ptr static
    dim as FBSYMBOL ptr proc

	proc = listNewNode( @symb.symlist )
	if( proc = NULL ) then
		exit function
	end if

	proc->class				= FB_SYMBCLASS_PROC
	proc->proc.args 		= 0
	proc->proc.argtb.head	= NULL
	proc->proc.argtb.tail	= NULL

	function = proc

end function

'':::::
function symbAddArgAsVar( byval symbol as zstring ptr, _
						  byval arg as FBSYMBOL ptr ) as FBSYMBOL ptr static

    dim as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr s
    dim as integer alloctype, typ

	function = NULL

	typ = arg->typ

	select case as const arg->arg.mode
    case FB_ARGMODE_BYVAL
    	'' byval string? it's actually an pointer to a zstring
    	if( typ = FB_SYMBTYPE_STRING ) then
    		alloctype = FB_ALLOCTYPE_ARGUMENTBYREF
    		typ = FB_SYMBTYPE_CHAR
    	else
    		alloctype = FB_ALLOCTYPE_ARGUMENTBYVAL
    	end if

	case FB_ARGMODE_BYREF
	    alloctype = FB_ALLOCTYPE_ARGUMENTBYREF

	case FB_ARGMODE_BYDESC
    	alloctype = FB_ALLOCTYPE_ARGUMENTBYDESC

	case else
    	exit function
	end select

    s = symbAddVarEx( symbol, NULL, typ, arg->subtype, 0, 0, _
    				  0, dTB(), alloctype, _
    				  arg->arg.suffix <> INVALID, FALSE, TRUE )

    if( s = NULL ) then
    	exit function
    end if

	function = s

end function

'':::::
function symbAddProcResArg( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr static
    static as zstring * FB_MAXINTNAMELEN+1 symbol
    dim as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr s

	'' UDT?
	if( proc->typ <> FB_SYMBTYPE_USERDEF ) then
		return NULL
	end if

	'' returning a ptr?
	if( proc->proc.realtype <> FB_SYMBTYPE_POINTER+FB_SYMBTYPE_USERDEF ) then
		return NULL
	end if

	symbol = FBPREFIX_PROCRES
	symbol += *symbGetOrgName( proc )

    s = symbAddVarEx( @symbol, NULL, _
    				  FB_SYMBTYPE_POINTER+FB_SYMBTYPE_USERDEF, proc->subtype, 0, 0, _
    				  0, dTB(), FB_ALLOCTYPE_ARGUMENTBYVAL, _
    				  TRUE, TRUE, FALSE )

	function = s

end function

'':::::
function symbAddProcResult( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr static
	static as zstring * FB_MAXINTNAMELEN+1 rname
	dim as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr s, subtype
	dim as integer dtype

	'' UDT?
	if( proc->typ = FB_SYMBTYPE_USERDEF ) then
		'' returning a ptr? result is at the hidden arg
		if( proc->proc.realtype = FB_SYMBTYPE_POINTER+FB_SYMBTYPE_USERDEF ) then
			return symbLookupProcResult( proc )
		end if
	end if

	rname = FBPREFIX_PROCRES
	rname += *symbGetOrgName( proc )

	s = symbAddVarEx( @rname, NULL, proc->typ, proc->subtype, 0, 0, 0, _
					  dTB(), 0, TRUE, TRUE, FALSE )

	function = s

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookup
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbLookupProcResult( byval f as FBSYMBOL ptr ) as FBSYMBOL ptr static
	static as zstring * FB_MAXINTNAMELEN+1 rname

	if( f = NULL ) then
		return NULL
	end if

	rname = FBPREFIX_PROCRES
	rname += *symbGetOrgName( f )

	function = symbFindByNameAndClass( @rname, FB_SYMBCLASS_VAR, TRUE )

end function

'':::::
function symbFindOverloadProc( byval parent as FBSYMBOL ptr, _
							   byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, farg, parg, fsubtype, psubtype
	dim as integer argc

	''
	if( (parent = NULL) or (proc = NULL) ) then
		return NULL
	end if

	'' procs?
	if( (symbGetClass( parent ) <> FB_SYMBCLASS_PROC) or _
		(symbGetClass( proc ) <> FB_SYMBCLASS_PROC) ) then
		return NULL
	end if

	argc = symbGetProcArgs( proc )

	'' for each proc starting from parent..
	f = parent
	do while( f <> NULL )

		if( argc = f->proc.args ) then

			'' arg-less?
			if( argc = 0 ) then
				return f
			end if

			'' for each arg..
			farg = symbGetProcTailArg( f )
			parg = symbGetProcTailArg( proc )
			do while( parg <> NULL )

				'' different modes?
				if( parg->arg.mode <> farg->arg.mode ) then
					'' one is by desc? can't be the same..
					if( parg->arg.mode = FB_ARGMODE_BYDESC ) then
						exit do
					elseif( farg->arg.mode = FB_ARGMODE_BYDESC ) then
						exit do
					end if
				end if

				'' not the same type? check next proc..
				if( parg->typ <> farg->typ ) then
					exit do
				end if

				if( parg->subtype <> farg->subtype ) then
					exit do
				end if

				parg = parg->prev
				farg = farg->prev
			loop

			'' all args equal?
			if( parg = NULL ) then
				return f
			end if

		end if

		f = f->proc.ovl.next
	loop

	function = NULL

end function

'' enough to an impossible-to-reach level of indirection
const FB_OVLPROC_FULLMATCH = 1073741824 \ FB_MAXPROCARGS
const FB_OVLPROC_HALFMATCH = FB_OVLPROC_FULLMATCH \ 2

'':::::
private function hCheckOvlArg( byval arg as FBSYMBOL ptr, _
							   byval pexpr as ASTNODE ptr, _
							   byval pmode as integer _
							 ) as integer static

	dim as integer pdtype, pdclass, adtype
	dim as FBSYMBOL ptr s, psubtype

	'' param optional?
	if( pexpr = NULL ) then
		'' but arg isn't?
		if( symbGetArgOptional( arg ) = FALSE ) then
			return 0
		end if

		return FB_OVLPROC_FULLMATCH
    end if

	adtype = symbGetType( arg )

	pdtype = astGetDataType( pexpr )
	psubtype = astGetSubType( pexpr )

	'' by descriptor arg?
	if( symbGetArgMode( arg ) = FB_ARGMODE_BYDESC ) then
		'' but param isn't?
		if( pmode <> FB_ARGMODE_BYDESC ) then
			return 0
		end if

		'' not a full match?
        if( adtype <> pdtype ) then
        	return 0
        end if

        if( symbGetSubType( arg ) <> psubtype ) then
        	return 0
        end if

		return FB_OVLPROC_FULLMATCH

	'' by descriptor param?
	elseif( pmode = FB_ARGMODE_BYDESC ) then
		'' refuse
		return 0
	end if

	'' same types?
	if( adtype = pdtype ) then
		'' check the subtype
		if( symbGetSubType( arg ) <> psubtype ) then

			'' check classes
			select case irGetDataClass( adtype )
			'' UDT? can't be different..
			case IR_DATACLASS_UDT
				return 0
			end select

			return FB_OVLPROC_HALFMATCH
        end if

		'' same subtype too, full match..
		return FB_OVLPROC_FULLMATCH
	end if

	'' different types..
	pdclass = irGetDataClass( pdtype )

	'' check classes
	select case as const irGetDataClass( adtype )
	'' integer?
	case IR_DATACLASS_INTEGER

		select case as const pdclass
		'' another integer..
		case IR_DATACLASS_INTEGER

			'' handle special cases..
			select case as const pdtype
			case IR_DATATYPE_CHAR
				select case adtype
				case IR_DATATYPE_POINTER + IR_DATATYPE_CHAR
					return FB_OVLPROC_FULLMATCH
				case IR_DATATYPE_POINTER + IR_DATATYPE_WCHAR
					return FB_OVLPROC_HALFMATCH
				end select

			case IR_DATATYPE_WCHAR
				select case adtype
				case IR_DATATYPE_POINTER + IR_DATATYPE_WCHAR
					return FB_OVLPROC_FULLMATCH
				case IR_DATATYPE_POINTER + IR_DATATYPE_CHAR
					return FB_OVLPROC_HALFMATCH
				end select

			case IR_DATATYPE_BITFIELD, IR_DATATYPE_ENUM
				pdtype = irRemapType( pdtype, psubtype )

			end select

			'' check pointers..
			if( adtype >= IR_DATATYPE_POINTER ) then
				'' not a pointer param?
				if( pdtype < IR_DATATYPE_POINTER ) then
					'' not a numeric constant?
					if( astIsCONST( pexpr ) = FALSE ) then
						return 0
					end if
					'' not 0 (NULL)?
					if( astGetValInt( pexpr ) <> 0 ) then
						return 0
					end if
				end if
			end if

			return FB_OVLPROC_HALFMATCH - abs( adtype - pdtype )

		'' float? (ok due the auto-coercion, unless it's a pointer)
		case IR_DATACLASS_FPOINT
			if( adtype >= IR_DATATYPE_POINTER ) then
				return 0
			end if

			return FB_OVLPROC_HALFMATCH - abs( adtype - pdtype )

		'' string? only if it's a w|zstring ptr arg
		case IR_DATACLASS_STRING
			select case adtype
			case IR_DATATYPE_POINTER + IR_DATATYPE_CHAR
				return FB_OVLPROC_FULLMATCH
			case IR_DATATYPE_POINTER + IR_DATATYPE_WCHAR
				return FB_OVLPROC_HALFMATCH
			case else
				return 0
			end select

		'' refuse anything else
		case else
			return 0
		end select

	'' floating-point?
	case IR_DATACLASS_FPOINT

		select case as const pdclass
		'' only accept if it's an integer (but pointers)
		case IR_DATACLASS_INTEGER
			if( pdtype >= IR_DATATYPE_POINTER ) then
				return 0
			end if

			'' remap to real type if it's a bitfield..
			select case pdtype
			case IR_DATATYPE_BITFIELD, IR_DATATYPE_ENUM
				pdtype = irRemapType( pdtype, psubtype )
			end select

			return FB_OVLPROC_HALFMATCH - abs( adtype - pdtype )

		'' or if another float..
		case IR_DATACLASS_FPOINT
			return FB_OVLPROC_HALFMATCH - abs( adtype - pdtype )

		'' refuse anything else
		case else
			return 0

		end select

	'' string?
	case IR_DATACLASS_STRING

		select case pdclass
		'' okay if it's a fixed-len string
		case IR_DATACLASS_STRING
			return FB_OVLPROC_FULLMATCH

		'' integer only if it's a w|zstring
		case IR_DATACLASS_INTEGER
			select case pdtype
			case IR_DATATYPE_CHAR
				return FB_OVLPROC_FULLMATCH
			case IR_DATATYPE_WCHAR
				return FB_OVLPROC_HALFMATCH
			case else
				return 0
			end select

		'' refuse anything else
		case else
			return 0
		end select

	'' user-defined..
	case IR_DATACLASS_UDT

		'' not another udt?
		if( pdclass <> IR_DATACLASS_UDT ) then
			'' not a proc? (can be an UDT been returned in registers)
			if( astGetClass( pexpr ) <> AST_NODECLASS_FUNCT ) then
				return 0
			end if

			'' it's a proc, but was it originally returning an UDT?
			s = astGetSymbol( pexpr )
			if( symbGetType( s ) <> FB_SYMBTYPE_USERDEF ) then
				return 0
			end if

			'' get the original subtype
			s = symbGetSubType( s )

		'' udt..
		else
           	s = psubtype
		end if

        '' can't be different
		if( symbGetSubType( arg ) <> s ) then
			return 0
		end if

		return FB_OVLPROC_FULLMATCH

	'' can't happen?
	case else
		return 0

	end select

end function


'':::::
function symbFindClosestOvlProc( byval proc as FBSYMBOL ptr, _
					   		     byval params as integer, _
					   		     exprTB() as ASTNODE ptr, _
					   		     modeTB() as integer _
					   		   ) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr ovlproc, arg
	dim as integer p, argmatches, matches, maxmatches, ambcnt

	ovlproc = NULL
	maxmatches = 0
	ambcnt = 0

	'' for each proc..
	do while( proc <> NULL )

		if( params <= symbGetProcArgs( proc ) ) then

			'' arg-less? exit..
			if( symbGetProcArgs( proc ) = 0 ) then
				return proc
			end if

			arg = symbGetProcLastArg( proc )
			matches = 0

			'' for each arg..
			for p = 0 to params-1

				argmatches = hCheckOvlArg( arg, exprTB(p), modeTB(p) )
				if( argmatches = 0 ) then
					matches = 0
					exit for
				end if
				matches += argmatches

               	'' next arg
				arg = symbGetProcPrevArg( proc, arg )
			next

			'' fewer params? check if the ones missing are optional
			if( params < symbGetProcArgs( proc ) ) then
				if( (matches > 0) or (params = 0) ) then
					do while( arg <> NULL )
			    		'' not optional? exit
			    		if( symbGetArgOptional( arg ) = FALSE ) then
			    			matches = 0
			    			exit do
			    		else
			    			matches += FB_OVLPROC_FULLMATCH
			    		end if

						'' next arg
						arg = symbGetProcPrevArg( proc, arg )
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
				ambcnt += 1
			end if

		end if

		'' next overloaded proc
		proc = proc->proc.ovl.next
	loop

	'' more than one possibility?
	if( ambcnt > 0 ) then
		function = NULL
	else
		function = ovlproc
	end if

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hDelArgs( byval f as FBSYMBOL ptr )
	dim as FBSYMBOL ptr a, n

    a = f->proc.argtb.head
    do while( a <> NULL )
    	n = a->next
    	symbFreeSymbol( a )
    	a = n
    loop

end sub

'':::::
sub symbDelPrototype( byval s as FBSYMBOL ptr, _
				      byval dolookup as integer )
	dim as FBSYMBOL ptr n

    if( dolookup ) then
    	s = symbFindByClass( s, FB_SYMBCLASS_PROC )
    end if

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
		if( s->proc.args > 0 ) then
			hDelArgs( s )
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
function symbCalcArgLen( byval typ as integer, _
						 byval subtype as FBSYMBOL ptr, _
						 byval mode as integer ) as integer static
    dim lgt as integer

	select case mode
	case FB_ARGMODE_BYREF, FB_ARGMODE_BYDESC
		lgt = FB_POINTERSIZE
	case else
		if( typ = FB_SYMBTYPE_STRING ) then
			lgt = FB_POINTERSIZE
		else
			lgt = symbCalcLen( typ, subtype )
		end if
	end select

	function = lgt

end function

'':::::
function symbGetCurrentProcName( ) as zstring ptr

	if( env.currproc = NULL ) then
		function = @"(main)"
	else
		function = symbGetOrgName( env.currproc )
	end if

end function
