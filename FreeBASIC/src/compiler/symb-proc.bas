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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"

declare function hMangleFunctionPtr				( _
													byval proc as FBSYMBOL ptr, _
													byval dtype as integer, _
													byval subtype as FBSYMBOL ptr, _
													byval mode as integer _
												) as zstring ptr

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
			lgt	+= FB_ROUNDLEN( paramtail->lgt )

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
		byval attrib as FB_SYMBATTRIB, _
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
	param->attrib or= attrib
	param->lgt = lgt
	param->param.mode = mode
	param->param.suffix = suffix
	param->param.optexpr = optexpr

    function = param

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
    case FB_DATATYPE_STRUCT

		'' use the un-padded UDT len
		select case as const symbGetUDTUnpadLen( subtype )
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

					if( subtype->udt.fldtb.head->typ <> FB_DATATYPE_STRUCT ) then
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

					if( subtype->udt.fldtb.head->typ <> FB_DATATYPE_STRUCT ) then
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
		return FB_DATATYPE_POINTER + FB_DATATYPE_STRUCT

	'' type is the same
	case else
    	return dtype

	end select

end function

'':::::
private function hCanOverload _
	( _
		byval proc as FBSYMBOL ptr _
	) as integer static

	dim as FBSYMBOL ptr pparam

	'' arg-less?
	if( symbGetProcParams( proc ) = 0 ) then
		return TRUE
	end if

	'' can't be vararg..
	pparam = symbGetProcTailParam( proc )
	if( pparam->param.mode = FB_PARAMMODE_VARARG ) then
		return FALSE
	end if

	'' any AS ANY param?
	do while( pparam <> NULL )
		if( pparam->typ = FB_DATATYPE_VOID ) then
			return FALSE
		end if

		pparam = pparam->prev
	loop

	function = TRUE

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

		'' any AS ANY param?
		do while( pparam <> NULL )
			if( pparam->typ = FB_DATATYPE_VOID ) then
				exit function
			end if

			pparam = pparam->prev
		loop
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
						  parent->symtb, parent->hash.tb, symbIsLocal( parent ) = FALSE, _
						  FB_SYMBCLASS_PROC, _
						  FALSE, id, id_alias, _
					      dtype, subtype, ptrcnt, _
					      preservecase )

	if( proc = NULL ) then
		exit function
	end if

	'' add to hash chain list, as they share the same name
	if( id <> NULL ) then
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
	end if

	function = proc

end function

'':::::
private function hAddOpOvlProc _
	( _
		byval proc as FBSYMBOL ptr, _
		byval parent as FBSYMBOL ptr, _
		byval op as AST_OP, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr p

	'' if it's not the type casting op, overloaded as an ordinary proc
	if( op <> AST_OP_CAST ) then
		return hAddOvlProc( proc, parent, NULL, id_alias, dtype, subtype, ptrcnt, FALSE )
	end if

	'' type casting, must check the return type, not the parameter..

	'' for each overloaded proc..
	p = parent
	do while( p <> NULL )

		'' same type?
		if( proc->typ = p->typ ) then
			'' and sub-type?
			if( proc->subtype = p->subtype ) then
				'' dup definition..
				return NULL
			end if
		end if

		'' next
		p = p->proc.ovl.next
	loop

    '' add it
	proc = symbNewSymbol( proc, _
						  parent->symtb, parent->hash.tb, symbIsLocal( parent ) = FALSE, _
						  FB_SYMBCLASS_PROC, _
						  FALSE, NULL, id_alias, _
					      dtype, subtype, ptrcnt, _
					      FALSE )

	'' there's no id so it can't be added to the chain list

	function = proc

end function

'':::::
function symbGetGlobOpOvlParent _
	( _
		byval op as AST_OP, _
		byval proc_param as FBSYMBOL ptr _
	) as FBSYMBOL ptr

    '' special case: casting
    if( op = AST_OP_CAST ) then
   		select case symbGetType( proc_param )
   		case FB_DATATYPE_STRUCT
   			function = symbGetSubtype( proc_param )->udt.opovl.cast

   		case FB_DATATYPE_ENUM
   			function = symbGetSubtype( proc_param )->enum.opovl.cast

   		end select

	'' anything else..
	else
       	function = symb.globOpOvlTb(op).head

	end if

end function

'':::::
private sub hSetGlobOpOvlParent _
	( _
		byval proc as FBSYMBOL ptr _
	)

	dim as AST_OP op = proc->proc.ext->opovl.op

	'' casting?
    if( op = AST_OP_CAST ) then
		dim as FBSYMBOL ptr param = symbGetProcHeadParam( proc )

  		select case symbGetType( param )
   		case FB_DATATYPE_STRUCT
			symbGetSubtype( param )->udt.opovl.cast = proc

   		case FB_DATATYPE_ENUM
			symbGetSubtype( param )->enum.opovl.cast = proc

   		end select

    '' anything else
    else
   		symb.globOpOvlTb(op).head = proc
	end if

end sub

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
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr static

    dim as integer lgt, realtype, stats, preservecase
    dim as FBSYMBOL ptr proc, parent, ns
	dim as FBSYMBOLTB ptr symtb
	dim as FBHASHTB ptr hashtb

    function = NULL

	''
	if( dtype = INVALID ) then
		dtype = symbGetDefType( id )
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

	ns = symbGetCurrentNamespc( )
	symtb = NULL
	hashtb = NULL

	'' move to global ns? (needed for function ptr protos)
	if( (options and FB_SYMBOPT_MOVETOGLOB) <> 0 ) then
    	'' only if not inside a scope block..
    	if( env.scope = FB_MAINSCOPE ) then
			ns = @symbGetGlobalNamespc( )
			symtb = @symbGetGlobalTb( )
			hashtb = @symbGetGlobalHashTb( )
		end if
	end if

	parent = NULL

	'' not an operator or op not set (because error-recovery)?
	if( ((attrib and FB_SYMBATTRIB_OPERATOR) = 0) or (sym->proc.ext = NULL) ) then
		preservecase = (options and FB_SYMBOPT_PRESERVECASE) <> 0

		proc = symbNewSymbol( sym, _
						  	  symtb, hashtb, env.scope = FB_MAINSCOPE, _
						  	  FB_SYMBCLASS_PROC, _
						  	  TRUE, id, id_alias, _
					   	  	  dtype, subtype, ptrcnt, _
					   	  	  preservecase )

		'' dup def?
		if( proc = NULL ) then
			'' is the dup a proc symbol?
			parent = symbLookupByNameAndClass( ns, _
										   	   id, _
										   	   FB_SYMBCLASS_PROC, _
										   	   preservecase )
			if( parent = NULL ) then
				exit function
			end if

			'' proc was defined as overloadable?
			if( symbIsOverloaded( parent ) = FALSE ) then
				if( fbLangOptIsSet( FB_LANG_OPT_ALWAYSOVL ) = FALSE ) then
					exit function
				end if
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
			'' only if not the RTL
			if( (options and FB_SYMBOPT_RTL) = 0 ) then
				'' check overloading
				if( (attrib and FB_SYMBATTRIB_OVERLOADED) <> 0 ) then
					if( hCanOverload( sym ) = FALSE ) then
						exit function
					end if

				elseif( fbLangOptIsSet( FB_LANG_OPT_ALWAYSOVL ) ) then
					if( hCanOverload( sym ) ) then
						attrib or= FB_SYMBATTRIB_OVERLOADED
					end if
				end if
			end if
		end if

		proc->proc.ext = NULL

	'' operator..
	else
        dim as AST_OP op
        op = sym->proc.ext->opovl.op

        parent = symbGetGlobOpOvlParent( op, symbGetProcHeadParam( sym ) )

        '' no parent? just add it
        if( parent = NULL ) then
			proc = symbNewSymbol( sym, _
					  	  	  	  symtb, hashtb, env.scope = FB_MAINSCOPE, _
					  	  	  	  FB_SYMBCLASS_PROC, _
					  	  	  	  FALSE, NULL, id_alias, _
				   	  	  	  	  dtype, subtype, ptrcnt, _
				   	  	  	  	  FALSE )

        	hSetGlobOpOvlParent( proc )

        '' otherwise, try to overload
        else
			proc = hAddOpOvlProc( sym, parent, op, id_alias, _
								  dtype, subtype, ptrcnt )
			if( proc = NULL ) then
				exit function
			end if
        end if

	end if

    ''
	proc->attrib = attrib or FB_SYMBATTRIB_SHARED

    '' if proc returns an UDT, add the hidden pointer passed as the 1st arg
    if( dtype = FB_DATATYPE_STRUCT ) then
    	if( realtype = FB_DATATYPE_POINTER + FB_DATATYPE_STRUCT ) then
    		lgt += FB_POINTERSIZE
    	end if
    end if

	proc->proc.lgt = lgt

	if( (options and FB_SYMBOPT_DECLARING) <> 0 ) then
		stats or= FB_SYMBSTATS_DECLARED

    	'' param list too large?
    	if( lgt > 256 ) then
	    	errReportWarn( FB_WARNINGMSG_PARAMLISTSIZETOOBIG, id )
    	end if
	end if

	if( (options and FB_SYMBOPT_RTL) <> 0 ) then
		stats or= FB_SYMBSTATS_RTL
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
		stats or= FB_SYMBSTATS_CALLED
	end if

	'' hack! stats field shared with mangling info
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
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr static

    function = NULL

	proc = hSetupProc( proc, id, id_alias, libname, _
					   dtype, subtype, ptrcnt, _
					   attrib, mode, _
					   options )
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
					   attrib, mode, _
					   FB_SYMBOPT_DECLARING )
	if( proc = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function symbAddOperatorOvl _
	( _
		byval proc as FBSYMBOL ptr, _
		byval op as AST_OP, _
		byval id_alias as zstring ptr, _
		byval libname as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval attrib as integer, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr sym

    function = NULL

	''
	proc->proc.ext = callocate( len( FB_PROCEXT ) )
	proc->proc.ext->opovl.op = op

	''
	sym = hSetupProc( proc, NULL, id_alias, libname, _
					  dtype, subtype, ptrcnt, _
					  attrib, mode, _
					  options )

	if( sym = NULL ) then
		deallocate( proc->proc.ext )
		exit function
	end if

	function = sym

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
	proc->proc.params = 0
	proc->proc.paramtb.owner = proc
	proc->proc.paramtb.head = NULL
	proc->proc.paramtb.tail = NULL
	proc->id.name = symbol
	proc->proc.ext = NULL
	proc->stats = 0

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

    s = symbAddVarEx( symbol, NULL, dtype, param->subtype, 0, 0, _
    				  0, dTB(), attrib, _
    				  iif( param->param.suffix <> INVALID, FB_SYMBOPT_ADDSUFFIX, FB_SYMBOPT_NONE ) )

    if( s = NULL ) then
    	return NULL
    end if

    '' declare it or arrays passed by descriptor will be initialized when REDIM'd
    symbSetIsDeclared( s )

    if( symbGetDontInit( param ) ) then
    	symbSetDontInit( s )
    end if

	function = s

end function

'':::::
function symbAddProcResultParam _
	( _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

    dim as FBARRAYDIM dTB(0)
    dim as FBSYMBOL ptr s

	'' UDT?
	if( proc->typ <> FB_DATATYPE_STRUCT ) then
		return NULL
	end if

	'' returning a ptr?
	if( proc->proc.realtype <> FB_DATATYPE_POINTER+FB_DATATYPE_STRUCT ) then
		return NULL
	end if

    s = symbAddVarEx( NULL, NULL, _
    				  FB_DATATYPE_POINTER+FB_DATATYPE_STRUCT, proc->subtype, 0, 0, _
    				  0, dTB(), FB_SYMBATTRIB_PARAMBYVAL, _
    				  FB_SYMBOPT_ADDSUFFIX or FB_SYMBOPT_PRESERVECASE )


	if( proc->proc.ext = NULL ) then
		proc->proc.ext = callocate( len( FB_PROCEXT ) )
	end if

	proc->proc.ext->res = s

	symbSetIsDeclared( s )

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
	if( proc->typ = FB_DATATYPE_STRUCT ) then
		'' returning a ptr? result is at the hidden arg
		if( proc->proc.realtype = FB_DATATYPE_POINTER+FB_DATATYPE_STRUCT ) then
			return symbGetProcResult( proc )
		end if
	end if

	s = symbAddVarEx( NULL, NULL, proc->typ, proc->subtype, 0, 0, 0, _
					  dTB(), FB_SYMBATTRIB_FUNCRESULT, _
					  FB_SYMBOPT_ADDSUFFIX or FB_SYMBOPT_PRESERVECASE )

	if( proc->proc.ext = NULL ) then
		proc->proc.ext = callocate( len( FB_PROCEXT ) )
	end if

	proc->proc.ext->res = s

	'' clear up the result
	astAdd( astNewDECL( FB_SYMBCLASS_VAR, s, NULL ) )

	symbSetIsDeclared( s )

	function = s

end function

'':::::
function symbAddProcPtr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval mode as integer _
	) as FBSYMBOL ptr static

	dim as zstring ptr id
	dim as FBSYMCHAIN ptr chain_
	dim as FBSYMBOL ptr sym

	id = hMangleFunctionPtr( proc, dtype, subtype, mode )

	'' already exists? (it's ok to use LookupAt, literal str's are always
	'' prefixed with {fbsc}, there will be clashes with func ptr mangled names )
    chain_ = symbLookupAt( @symbGetGlobalNamespc( ), id, TRUE )
	if( chain_ <> NULL ) then
		return chain_->sym
	end if

	'' create a new prototype
	sym = symbAddPrototype( proc, id, NULL, NULL, _
							dtype, subtype, ptrcnt, _
							0, mode, _
							FB_SYMBOPT_DECLARING or _
							FB_SYMBOPT_MOVETOGLOB or _
							FB_SYMBOPT_PRESERVECASE )

	if( sym <> NULL ) then
		symbGetAttrib( sym ) or= FB_SYMBATTRIB_FUNCPTR
	end if

	function = sym

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

'':::::
function symbFindOpOvlProc _
	( _
		byval op as AST_OP, _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr p

	'' if it's not type casting op, handle is as an ordinary proc
	if( op <> AST_OP_CAST ) then
		return symbFindOverloadProc( parent, proc )
	end if

	'' for each proc starting from parent..
	p = parent
	do while( p <> NULL )

		'' same return type?
		if( proc->typ = p->typ ) then
			if( proc->subtype = p->subtype ) then
				return p
			end if
		end if

		p = p->proc.ovl.next
	loop

	function = NULL

end function

const FB_OVLPROC_HALFMATCH = FB_DATATYPES
const FB_OVLPROC_FULLMATCH = FB_OVLPROC_HALFMATCH * 2

'':::::
private function hCalcTypesDiff _
	( _
		byval param_dtype as integer, _
		byval param_subtype as FBSYMBOL ptr, _
		byval param_ptrcnt as integer, _
		byval arg_dtype as integer, _
		byval arg_subtype as FBSYMBOL ptr, _
	  	byval arg_expr as ASTNODE ptr _
	) as integer static

	dim as integer arg_dclass

	arg_dclass = symbGetDataClass( arg_dtype )

	'' check classes
	select case as const symbGetDataClass( param_dtype )
	'' integer?
	case FB_DATACLASS_INTEGER

		select case as const arg_dclass
		'' another integer..
		case FB_DATACLASS_INTEGER

			'' handle special cases..
			select case as const arg_dtype
			case FB_DATATYPE_CHAR
				select case param_dtype
				case FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
					return FB_OVLPROC_FULLMATCH
				case FB_DATATYPE_POINTER + FB_DATATYPE_WCHAR
					return FB_OVLPROC_HALFMATCH
				end select

			case FB_DATATYPE_WCHAR
				select case param_dtype
				case FB_DATATYPE_POINTER + FB_DATATYPE_WCHAR
					return FB_OVLPROC_FULLMATCH
				case FB_DATATYPE_POINTER + FB_DATATYPE_CHAR
					return FB_OVLPROC_HALFMATCH
				end select

			case FB_DATATYPE_BITFIELD, FB_DATATYPE_ENUM
				'' enum args can be passed to integer params (as in C++)
				arg_dtype = symbRemapType( arg_dtype, arg_subtype )

			end select

			'' check pointers..
			if( param_dtype >= FB_DATATYPE_POINTER ) then
				'' isn't arg a pointer too?
				if( arg_dtype < FB_DATATYPE_POINTER ) then
					'' not an expression?
					if( arg_expr = NULL ) then
						return 0
					end if

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

				'' param is an any ptr?
				if( param_dtype = FB_DATATYPE_POINTER+FB_DATATYPE_VOID ) then
					'' as in g++, the arg indirection level shouldn't matter..
					return FB_OVLPROC_FULLMATCH
				end if

				'' arg is an any ptr?
				if( arg_dtype = FB_DATATYPE_POINTER+FB_DATATYPE_VOID ) then
					'' not the same level of indirection?
					if( param_ptrcnt > 1 ) then
						return 0
					end if

					return FB_OVLPROC_FULLMATCH
				end if

				'' no match
				return 0

			'' param not a pointer, but is arg?
			elseif( arg_dtype >= FB_DATATYPE_POINTER ) then
				'' use an UINT instead or LONGINT will match if any..
				arg_dtype = FB_DATATYPE_UINT
			end if

			return FB_OVLPROC_HALFMATCH - abs( param_dtype - arg_dtype )

		'' float? (ok due the auto-coercion, unless it's a pointer)
		case FB_DATACLASS_FPOINT
			if( param_dtype >= FB_DATATYPE_POINTER ) then
				return 0
			end if

			return FB_OVLPROC_HALFMATCH - abs( param_dtype - arg_dtype )

		'' string? only if it's a w|zstring ptr arg
		case FB_DATACLASS_STRING
			select case param_dtype
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

		select case as const arg_dclass
		'' only accept if it's an integer (but pointers)
		case FB_DATACLASS_INTEGER
			if( arg_dtype >= FB_DATATYPE_POINTER ) then
				return 0
			end if

			'' remap to real type if it's a bitfield..
			select case arg_dtype
			case FB_DATATYPE_BITFIELD, FB_DATATYPE_ENUM
				'' enum args can be passed to fpoint params (as in C++)
				arg_dtype = symbRemapType( arg_dtype, arg_subtype )
			end select

			return FB_OVLPROC_HALFMATCH - abs( param_dtype - arg_dtype )

		'' or if another float..
		case FB_DATACLASS_FPOINT
			return FB_OVLPROC_HALFMATCH - abs( param_dtype - arg_dtype )

		'' refuse anything else
		case else
			return 0

		end select

	'' string?
	case FB_DATACLASS_STRING

		select case arg_dclass
		'' okay if it's a fixed-len string
		case FB_DATACLASS_STRING
			return FB_OVLPROC_FULLMATCH

		'' integer only if it's a w|zstring
		case FB_DATACLASS_INTEGER
			select case arg_dtype
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

		dim as FBSYMBOL ptr s

		'' not another udt?
		if( arg_dclass <> FB_DATACLASS_UDT ) then
			'' not an expression?
			if( arg_expr = NULL ) then
				return 0
			end if

			'' not a proc? (could be an UDT being returned in registers)
			if( astGetClass( arg_expr ) <> AST_NODECLASS_CALL ) then
				return 0
			end if

			'' it's a proc, but was it originally returning an UDT?
			s = astGetSymbol( arg_expr )
			if( symbGetType( s ) <> FB_DATATYPE_STRUCT ) then
				return 0
			end if

			'' get the original subtype
			s = symbGetSubType( s )

		'' udt..
		else
           	s = arg_subtype
		end if

        '' can't be different
		if( param_subtype <> s ) then
			return 0
		end if

		return FB_OVLPROC_FULLMATCH

	'' can't happen?
	case else
		return 0

	end select

end function

'':::::
private function hCheckOvlParam _
	( _
		byval param as FBSYMBOL ptr, _
	  	byval arg_expr as ASTNODE ptr, _
		byval arg_mode as integer _
	) as integer static

	dim as integer param_dtype, arg_dtype
	dim as FBSYMBOL ptr param_subtype, arg_subtype

	'' arg not passed?
	if( arg_expr = NULL ) then
		'' is param optional?
		if( symbGetIsOptional( param ) ) then
			return FB_OVLPROC_FULLMATCH
		else
			return 0
		end if
    end if

	param_dtype = symbGetType( param )
	param_subtype = symbGetSubType( param )

	arg_dtype = astGetDataType( arg_expr )
	arg_subtype = astGetSubType( arg_expr )

	'' by descriptor param?
	if( symbGetParamMode( param ) = FB_PARAMMODE_BYDESC ) then
		'' but arg isn't?
		if( arg_mode <> FB_PARAMMODE_BYDESC ) then
			return 0
		end if

		'' not a full match?
        if( param_dtype <> arg_dtype ) then
        	return 0
        end if

        if( param_subtype <> arg_subtype ) then
        	return 0
        end if

		return FB_OVLPROC_FULLMATCH

	'' by descriptor arg?
	elseif( arg_mode = FB_PARAMMODE_BYDESC ) then
		'' refuse
		return 0
	end if

	'' same types?
	if( param_dtype = arg_dtype ) then
		'' check the subtype
		if( param_subtype <> arg_subtype ) then

			select case param_dtype
			'' UDT or ENUM? can't be different..
			case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM
				return 0

			'' pointer? ditto
			case is >= FB_DATATYPE_POINTER
				if( astPtrCheck( param_dtype, _
					 			 param_subtype, _
					 			 arg_expr ) ) then

					return FB_OVLPROC_FULLMATCH
				end if

				return 0

			'' can't happen?
			case else
				return FB_OVLPROC_HALFMATCH
			end select

        end if

		'' same subtype too, full match..
		return FB_OVLPROC_FULLMATCH
	end if

	'' different types..

	'' enum param? refuse any other argument type, even integers,
	'' or operator overloading wouldn't work (as in C++)
	if( param_dtype = FB_DATATYPE_ENUM ) then
		return 0
	end if

	''
	function = hCalcTypesDiff( param_dtype, _
							   param_subtype, _
							   param->ptrcnt, _
							   arg_dtype, _
							   arg_subtype, _
							   arg_expr )

end function

'':::::
function symbFindClosestOvlProc _
	( _
		byval proc_head as FBSYMBOL ptr, _
		byval args as integer, _
		byval arg_head as FB_CALL_ARG ptr, _
		byval is_ambiguous as integer ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr proc, ovl_proc, param
	dim as integer i, arg_matches, matches, max_matches, amb_cnt
	dim as FB_CALL_ARG ptr arg

	ovl_proc = NULL
	max_matches = 0
	amb_cnt = 0

	'' for each proc..
	proc = proc_head
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

				arg_matches = hCheckOvlParam( param, arg->expr, arg->mode )
				if( arg_matches = 0 ) then
					matches = 0
					exit for
				end if
				matches += arg_matches

               	'' next param
				param = symbGetProcPrevParam( proc, param )
				arg = arg->next
			next

			'' fewer params? check if the ones missing are optional
			if( args < symbGetProcParams( proc ) ) then
				if( (matches > 0) or (args = 0) ) then
					do while( param <> NULL )
			    		'' not optional? exit
			    		if( symbGetIsOptional( param ) = FALSE ) then
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
		    if( matches > max_matches ) then
			   	ovl_proc = proc
			   	max_matches = matches
			   	amb_cnt = 0

			'' same? ambiguity..
			elseif( matches = max_matches ) then
				if( max_matches > 0 ) then
					amb_cnt += 1
				end if
			end if

		end if

		'' next overloaded proc
		proc = proc->proc.ovl.next
	loop

	if( is_ambiguous <> NULL ) then
		*is_ambiguous = amb_cnt > 0
	end if

	'' more than one possibility?
	if( amb_cnt > 0 ) then
		errReportParam( proc_head, 0, NULL, FB_ERRMSG_AMBIGUOUSCALLTOPROC )
		function = NULL
	else
		'' no matches?
		if( ovl_proc = NULL ) then
			'' only show the error if not trying to find an operator
			if( is_ambiguous = NULL ) then
				errReportParam( proc_head, 0, NULL, FB_ERRMSG_NOMATCHINGPROC )
			end if
		end if
		function = ovl_proc
	end if

end function

'':::::
function symbFindBopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval isambiguous as integer ptr _
	) as FBSYMBOL ptr static

	dim as FB_CALL_ARG argTb(0 to 1)
	dim as SYMB_OVLOP ptr pop

	pop = @symb.globOpOvlTb(op)

	'' at least one must be an UDT
   	select case astGetDataType( l )
   	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

   	case else
   		'' try the 2nd one..
   		select case astGetDataType( r )
   		case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

   		case else
   			*isambiguous = FALSE
   			return NULL
   		end select
   	end select

	'' try (l, r)
	argTb(0).expr = l
	argTb(0).mode = INVALID
	argTb(0).next = @argTb(1)

	argTb(1).expr = r
	argTb(1).mode = INVALID
	argTb(1).next = NULL

	function = symbFindClosestOvlProc( pop->head, 2, @argTb(0), isambiguous )

end function

'':::::
function symbFindUopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval isambiguous as integer ptr _
	) as FBSYMBOL ptr static

	dim as FB_CALL_ARG argTb(0)
	dim as SYMB_OVLOP ptr pop

	pop = @symb.globOpOvlTb(op)

	'' arg must be an UDT
   	select case astGetDataType( l )
   	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

   	case else
   		'' note: the CAST op shouldn't be passed to this function
   		*isambiguous = FALSE
   		return NULL
   	end select

	argTb(0).expr = l
	argTb(0).mode = INVALID
	argTb(0).next = NULL

	function = symbFindClosestOvlProc( pop->head, 1, @argTb(0), isambiguous )

end function

'':::::
private function hCheckCastOvl _
	( _
		byval proc as FBSYMBOL ptr, _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr _
	) as integer static

	dim as integer proc_dtype
	dim as FBSYMBOL ptr proc_subtype

	proc_dtype = symbGetType( proc )
	proc_subtype = symbGetSubType( proc )

	'' same types?
	if( proc_dtype = to_dtype ) then
		'' check the subtype
		if( proc_subtype <> to_subtype ) then

			select case proc_dtype
			'' UDT, ENUM or pointer? can't be different..
			case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM, is >= FB_DATATYPE_POINTER
				return 0

			'' can't happen?
			case else
				return FB_OVLPROC_HALFMATCH
			end select

		end if

		'' same subtype too, full match..
		return FB_OVLPROC_FULLMATCH
	end if

	'' different types..

	'' enum res? refuse any other cast type, even integers,
	'' or operator overloading wouldn't work (as in C++)
	if( proc_dtype = FB_DATATYPE_ENUM ) then
		return 0
	end if

	''
	function = hCalcTypesDiff( proc_dtype, _
							   proc_subtype, _
							   proc->ptrcnt, _
							   to_dtype, _
							   to_subtype, _
							   NULL )

end function

'':::::
function symbFindCastOvlProc _
	( _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr, _
		byval l as ASTNODE ptr, _
		byval isambiguous as integer ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr proc_head, proc, ovl_proc
	dim as integer matches, max_matches, amb_cnt

   	*isambiguous = FALSE

	'' arg must be an UDT
   	select case astGetDataType( l )
   	case FB_DATATYPE_STRUCT
   		proc_head = astGetSubType( l )->udt.opovl.cast

   	case FB_DATATYPE_ENUM
   		proc_head = astGetSubType( l )->enum.opovl.cast

   	case else
   		return NULL
   	end select

   	if( proc_head = NULL ) then
   		return NULL
   	end if

	dim as FBSYMBOL ptr p

	'' must check the return type, not the parameter..
	ovl_proc = NULL
	max_matches = 0
	amb_cnt = 0

	'' for each overloaded proc..
	proc = proc_head
	do while( proc <> NULL )

		matches = hCheckCastOvl( proc, to_dtype, to_subtype )
		if( matches > max_matches ) then
		   	ovl_proc = proc
		   	max_matches = matches
		   	amb_cnt = 0

		'' same? ambiguity..
		elseif( matches = max_matches ) then
			if( max_matches > 0 ) then
				amb_cnt += 1
			end if
		end if

		'' next
		proc = proc->proc.ovl.next
	loop

	'' more than one possibility?
	if( amb_cnt > 0 ) then
		*isambiguous = TRUE
		errReportParam( proc_head, 0, NULL, FB_ERRMSG_AMBIGUOUSCALLTOPROC )
		function = NULL
	else
		function = ovl_proc
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
function symbProcAllocLocalVars _
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

'':::::
function symbProcAllocStaticVars _
	( _
		byval s as FBSYMBOL ptr _
	) as integer static

    function = FALSE

    do while( s <> NULL )

    	select case s->class
    	'' scope block? recursion..
    	case FB_SYMBCLASS_SCOPE
    		symbProcAllocStaticVars( symbGetScopeTbHead( s ) )

    	'' variable?
    	case FB_SYMBCLASS_VAR
    		'' static?
    		if( symbIsStatic( s ) ) then
				'' it's ok to call emit directly from here, the
				'' proc is fully flushed, from ast, ir and emit itself
				emitDeclVariable( s )
			end if
		end select

    	s = s->next
    loop

    function = TRUE

end function

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
private function hMangleFunctionPtr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as integer _
	) as zstring ptr static

    dim as string id
    dim as integer i
    dim as FBSYMBOL ptr param

    '' cheapo and fast internal mangling..
    id = "{fbfp}("

    symbMangleInitAbbrev( )

    '' for each param..
    param = symbGetProcHeadParam( proc )
    for i = 0 to symbGetProcParams( proc )-1
    	if( i > 0 ) then
    		id += ","
    	end if

    	'' not an UDT?
    	if( param->subtype = NULL ) then
    		id += hex( param->typ * cint(param->param.mode) )
    	else
    		'' notes:
    		'' - can't use hex( param->subtype ), because slots can be
    		''   reused if fwd types were resolved and removed
    		'' - can't use only the param->id.name because UDT's with the same
    		''   name declared inside different namespaces
    		id += symbMangleType( param )
    	end if

    	param = symbGetParamNext( param )
    next

    '' return type
    id += ")"
	if( subtype = NULL ) then
		id += hex( dtype )
	else
		'' see the notes above
		id += symbMangleType( subtype )
	end if

    symbMangleEndAbbrev( )

    '' calling convention
    id += "$"
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


