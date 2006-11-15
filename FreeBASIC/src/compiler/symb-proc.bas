''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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
#include once "inc\parser.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"

declare function hMangleFunctionPtr	_
	( _
		byval proc as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as integer _
	) as zstring ptr

declare function hDemangleParams _
	( _
		byval proc as FBSYMBOL ptr _
	) as zstring ptr

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' init
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbProcInit( )

	symb.globctorlist.head = NULL
	symb.globctorlist.tail = NULL
	listNew( @symb.globctorlist.list, 8, len( FB_GLOBCTORLIST_ITEM ), LIST_FLAGS_NOCLEAR )

	symb.globdtorlist.head = NULL
	symb.globdtorlist.tail = NULL
	listNew( @symb.globdtorlist.list, 8, len( FB_GLOBCTORLIST_ITEM ), LIST_FLAGS_NOCLEAR )

end sub

'':::::
sub symbProcEnd( )

	listFree( @symb.globdtorlist.list )
	listFree( @symb.globctorlist.list )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbCalcProcParamLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as FB_PARAMMODE _
	) as integer static

    select case as const mode
    case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
    	function = FB_POINTERSIZE

    case FB_PARAMMODE_BYVAL
    	select case dtype
    	case FB_DATATYPE_STRING
    		return FB_POINTERSIZE

    	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    		'' has a dtor, copy ctor or virtual methods? pass a copy..
    		if( symbIsTrivial( subtype ) = FALSE ) then
    			return FB_POINTERSIZE
    		end if
    	end select

    	function = symbCalcLen( dtype, subtype )

    case else
    	function = 0

    end select

end function

'':::::
function symbCalcProcParamsLen _
	( _
		byval proc as FBSYMBOL ptr _
	) as integer static

	dim as integer i, lgt
	dim as FBSYMBOL ptr param

	param = symbGetProcTailParam( proc )

	lgt	= 0

	do while( param <> NULL )
		select case param->param.mode
		case FB_PARAMMODE_BYVAL
			lgt	+= FB_ROUNDLEN( param->lgt )

		case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
			lgt	+= FB_POINTERSIZE
		end select

		param = param->prev
	loop

    '' if proc returns an UDT, add the hidden pointer passed as the 1st arg
    if( symbGetType( proc ) = FB_DATATYPE_STRUCT ) then
    	if( symbGetProcRealType( proc ) = FB_DATATYPE_POINTER + FB_DATATYPE_STRUCT ) then
    		lgt += FB_POINTERSIZE
    	end if
    end if

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

    param = symbNewSymbol( FB_SYMBOPT_PRESERVECASE, _
    					   NULL, _
    					   @proc->proc.paramtb, NULL, _
    					   FB_SYMBCLASS_PARAM, _
    				   	   id, NULL, _
    				   	   dtype, subtype, ptrcnt, _
    				   	   attrib )
    if( param = NULL ) then
    	exit function
    end if

	proc->proc.params += 1
	if( optexpr <> NULL ) then
		proc->proc.optparams += 1
	end if

	''
	param->lgt = lgt
	param->param.mode = mode
	param->param.suffix = suffix
	param->param.optexpr = optexpr

	'' for UDTs, check if not including a byval param to self
	if( dtype = FB_DATATYPE_STRUCT ) then
		if( mode = FB_PARAMMODE_BYVAL ) then
			if( subtype = symbGetCurrentNamespc( ) ) then
				symbSetUdtHasRecByvalParam( subtype )
			end if
		end if
	end if

    function = param

end function

'':::::
function symbIsProcOverloadOf _
	( _
		byval proc as FBSYMBOL ptr, _
		byval head_proc as FBSYMBOL ptr _
	) as integer static

	dim as FBSYMBOL ptr f

	'' no parent?
	if( head_proc = NULL ) then
		return FALSE
	end if

	'' same?
	if( proc = head_proc ) then
		return TRUE
	end if

	'' not overloaded?
	if( symbIsOverloaded( head_proc ) = FALSE ) then
		return FALSE
	end if

	'' for each overloaded proc..
	f = symbGetProcOvlNext( head_proc )
	do while( f <> NULL )

		'' same?
		if( proc = f ) then
			return TRUE
		end if

		f = symbGetProcOvlNext( f )
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

		'' still parsing the struct? patch it later..
		if( subtype = symbGetCurrentNamespc( ) ) then
			symbSetUdtHasRecByvalRes( subtype )
			return dtype
		end if

		return symbGetUDTRetType( subtype )

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
		byval head_proc as FBSYMBOL ptr, _
		byval symtb as FBSYMBOLTB ptr, _
		byval hashtb as FBHASHTB ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval attrib as FB_SYMBATTRIB, _
		byval preservecase as integer _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, fparam, pparam
	dim as integer params

	function = NULL

	'' only one them is a property?
	if( (attrib and FB_SYMBATTRIB_PROPERTY) <> 0 ) then
    	if( symbIsProperty( head_proc ) = FALSE ) then
			exit function
    	end if

	elseif( symbIsProperty( head_proc ) ) then
		if( (attrib and FB_SYMBATTRIB_PROPERTY) = 0 ) then
			exit function
		end if
	end if

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
	f = head_proc
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

		f = symbGetProcOvlNext( f )
	loop

    if( symbIsLocal( head_proc ) ) then
    	attrib or= FB_SYMBATTRIB_LOCAL
    end if

    '' add the new proc symbol, w/o adding it to the hash table
	proc = symbNewSymbol( iif( preservecase, FB_SYMBOPT_PRESERVECASE, FB_SYMBOPT_NONE ), _
						  proc, _
						  symtb, hashtb, _
						  FB_SYMBCLASS_PROC, _
						  id, id_alias, _
					      dtype, subtype, ptrcnt, _
					      attrib )

	if( proc = NULL ) then
		exit function
	end if

	'' add to hash chain list, as they share the same name
	if( id <> NULL ) then
		dim as FBSYMCHAIN ptr chain_, nxt
		chain_ = listNewNode( @symb.chainlist )

		chain_->index = head_proc->hash.chain->index
		chain_->item = head_proc->hash.chain->item

    	nxt = head_proc->hash.chain->next
		head_proc->hash.chain->next = chain_

		chain_->prev = head_proc->hash.chain
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
		byval head_proc as FBSYMBOL ptr, _
		byval symtb as FBSYMBOLTB ptr, _
		byval hashtb as FBHASHTB ptr, _
		byval op as AST_OP, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval attrib as FB_SYMBATTRIB _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr p

	'' if it's not the type casting op, overloaded as an ordinary proc
	if( op <> AST_OP_CAST ) then
		return hAddOvlProc( proc, head_proc, _
							symtb, hashtb, _
							NULL, id_alias, _
							dtype, subtype, ptrcnt, attrib, _
							FALSE )
	end if

	'' type casting, must check the return type, not the parameter..

	'' for each overloaded proc..
	p = head_proc
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
		p = symbGetProcOvlNext( p )
	loop

	if( symbIsLocal( head_proc ) ) then
		attrib or= FB_SYMBATTRIB_LOCAL
	end if

    '' add it
	proc = symbNewSymbol( FB_SYMBOPT_NONE, _
						  proc, _
						  symtb, hashtb, _
						  FB_SYMBCLASS_PROC, _
						  NULL, id_alias, _
					      dtype, subtype, ptrcnt, _
					      attrib )

	'' there's no id so it can't be added to the chain list

	function = proc

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
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr static

    dim as integer stats, preserve_case
    dim as FBSYMBOL ptr proc, head_proc, parent
	dim as FBSYMBOLTB ptr symbtb
	dim as FBHASHTB ptr hashtb

    function = NULL

	attrib or= FB_SYMBATTRIB_SHARED

	''
	if( dtype = INVALID ) then
		dtype = symbGetDefType( id )
		subtype = NULL
	end if

    '' no explict alias?
    if( id_alias = NULL ) then
    	'' only preserve a case-sensitive version if in BASIC mangling
    	if( parser.mangling <> FB_MANGLING_BASIC ) then
    		id_alias = id
    	end if
    	stats = 0
    else
    	stats = FB_SYMBSTATS_HASALIAS
    end if

	'' move to global ns? (needed for function ptr protos)
	if( (options and FB_SYMBOPT_MOVETOGLOB) <> 0 ) then
		parent = @symbGetGlobalNamespc( )
		symbtb = @symbGetGlobalTb( )
		hashtb = @symbGetGlobalHashTb( )
	else
		parent = symbGetCurrentNamespc( )
    	symbtb = symbGetCompSymbTb( parent )
    	hashtb = symbGetCompHashTb( parent )
	end if

	head_proc = NULL

	'' ctor/dtor?
	if( (attrib and (FB_SYMBATTRIB_CONSTRUCTOR or _
					 FB_SYMBATTRIB_DESTRUCTOR)) <> 0 ) then

		'' ctor?
		if( (attrib and FB_SYMBATTRIB_CONSTRUCTOR) <> 0 ) then
        	head_proc = symbGetCompCtorHead( parent )
        else
        	head_proc = symbGetCompDtor( parent )
        end if

        '' not overloaded yet? just add it
        if( head_proc = NULL ) then
			if( symbIsLocal( parent ) ) then
				attrib or= FB_SYMBATTRIB_LOCAL
			end if

			proc = symbNewSymbol( FB_SYMBOPT_NONE, _
								  sym, _
					  	  	  	  symbtb, hashtb, _
					  	  	  	  FB_SYMBCLASS_PROC, _
					  	  	  	  NULL, id_alias, _
				   	  	  	  	  FB_DATATYPE_VOID, NULL, 0, _
				   	  	  	  	  attrib )

			'' ctor?
			if( (attrib and FB_SYMBATTRIB_CONSTRUCTOR) <> 0 ) then
        		symbSetCompCtorHead( parent, proc )
        	else
        		symbSetCompDtor( parent, proc )
        	end if

        '' otherwise, try to overload
        else
			'' dtor?
			if( (attrib and FB_SYMBATTRIB_DESTRUCTOR) <> 0 ) then
				'' can't overload
				return NULL
			end if

			proc = hAddOvlProc( sym, head_proc, _
								symbtb, hashtb, _
								NULL, id_alias, _
							    FB_DATATYPE_VOID, NULL, 0, _
							    attrib, _
							    FALSE )
			if( proc = NULL ) then
				exit function
			end if
        end if

		'' ctor? check for special ctors..
		if( (attrib and FB_SYMBATTRIB_CONSTRUCTOR) <> 0 ) then
			symbCheckCompCtor( parent, proc )
		end if

	'' operator?
	elseif( (attrib and FB_SYMBATTRIB_OPERATOR) <> 0 ) then

		'' op not set? (because error recovery)
		if( sym->proc.ext = NULL ) then
			goto add_proc
		end if

        dim as AST_OP op

        op = sym->proc.ext->opovl.op

        head_proc = symbGetCompOpOvlHead( parent, op )

        '' not overloaded yet? just add it
        if( head_proc = NULL ) then
			if( parent <> NULL ) then
				if( symbIsLocal( parent ) ) then
					attrib or= FB_SYMBATTRIB_LOCAL
				end if
			end if

			proc = symbNewSymbol( FB_SYMBOPT_NONE, _
								  sym, _
					  	  	  	  symbtb, hashtb, _
					  	  	  	  FB_SYMBCLASS_PROC, _
					  	  	  	  NULL, id_alias, _
				   	  	  	  	  dtype, subtype, ptrcnt, _
				   	  	  	  	  attrib )

        	symbSetCompOpOvlHead( parent, proc )

        '' otherwise, try to overload
        else
			proc = hAddOpOvlProc( sym, head_proc, _
								  symbtb, hashtb, _
								  op, id_alias, _
								  dtype, subtype, ptrcnt, _
								  attrib )
			if( proc = NULL ) then
				exit function
			end if

			'' assign? could be a clone..
			if( op = AST_OP_ASSIGN ) then
				symbCheckCompClone( parent, proc )
			end if
        end if

	'' ordinary proc..
	else
add_proc:

		preserve_case = (options and FB_SYMBOPT_PRESERVECASE) <> 0

		if( parser.scope > FB_MAINSCOPE ) then
			attrib or= FB_SYMBATTRIB_LOCAL
		end if

		proc = symbNewSymbol( options or FB_SYMBOPT_DOHASH, _
							  sym, _
						  	  symbtb, hashtb, _
						  	  FB_SYMBCLASS_PROC, _
						  	  id, id_alias, _
					   	  	  dtype, subtype, ptrcnt, _
					   	  	  attrib )

		'' dup def?
		if( proc = NULL ) then
			'' is the dup a proc symbol?
			head_proc = symbLookupByNameAndClass( parent, _
										   	   	  id, _
										   	   	  FB_SYMBCLASS_PROC, _
										   	   	  preserve_case )
			if( head_proc = NULL ) then
				exit function
			end if

			'' proc was defined as overloadable?
			if( symbIsOverloaded( head_proc ) = FALSE ) then
				if( fbLangOptIsSet( FB_LANG_OPT_ALWAYSOVL ) = FALSE ) then
					exit function
				end if
			end if

			'' try to overload..
			proc = hAddOvlProc( sym, head_proc, _
								symbtb, hashtb, _
								id, id_alias, _
								dtype, subtype, ptrcnt, _
								attrib, _
								preserve_case )
			if( proc = NULL ) then
				exit function
			end if

			proc->attrib or= FB_SYMBATTRIB_OVERLOADED

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
						proc->attrib or= FB_SYMBATTRIB_OVERLOADED
					end if
				end if
			end if
		end if

	end if

	if( (options and FB_SYMBOPT_RTL) <> 0 ) then
		stats or= FB_SYMBSTATS_RTL
	end if

	''
	proc->proc.mode	= mode

	'' last compound was an EXTERN?
	if( fbGetCompStmtId( ) = FB_TK_EXTERN ) then
		'' don't add parent when mangling, even if inside an UDT, unless
		'' it's in "c++" mode
		if( parser.mangling <> FB_MANGLING_CPP ) then
			stats or= FB_SYMBSTATS_EXCLPARENT
		end if
	end if

	proc->proc.real_dtype = hGetProcRealType( dtype, subtype )

	'' note: symbCalcProcParamsLen() depends on proc.realtype to be set
	proc->proc.lgt = symbCalcProcParamsLen( sym )

	if( (options and FB_SYMBOPT_DECLARING) <> 0 ) then
		stats or= FB_SYMBSTATS_DECLARED

    	'' param list too large?
    	if( proc->proc.lgt > 256 ) then
	    	errReportWarn( FB_WARNINGMSG_PARAMLISTSIZETOOBIG, id )
    	end if
	end if

	proc->proc.rtl.callback = NULL

	if( libname <> NULL ) then
		if( len( *libname ) > 0 ) then
			proc->proc.lib = symbAddLib( libname )
		else
			proc->proc.lib = NULL
		end if
	else
		proc->proc.lib = parser.currlib
	end if

	'' if overloading, update the linked-list
	if( symbIsOverloaded( proc ) ) then
		if( head_proc <> NULL ) then
			proc->proc.ovl.next = head_proc->proc.ovl.next
			head_proc->proc.ovl.next = proc

			if( symbGetProcParams( proc ) < symGetProcOvlMinParams( head_proc ) ) then
				symGetProcOvlMinParams( head_proc ) = symbGetProcParams( proc )
			end if

			if( symbGetProcParams( proc ) > symGetProcOvlMaxParams( head_proc ) ) then
				symGetProcOvlMaxParams( head_proc ) = symbGetProcParams( proc )
			end if

		else
			proc->proc.ovl.next = NULL
			symGetProcOvlMinParams( proc ) = symbGetProcParams( proc )
			symGetProcOvlMaxParams( proc ) = symbGetProcParams( proc )
		end if
	end if

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
function symbAddOperator _
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
function symbAddCtor _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id_alias as zstring ptr, _
		byval libname as zstring ptr, _
		byval attrib as integer, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr sym, parent

    function = NULL

	sym = hSetupProc( proc, NULL, id_alias, libname, _
					  FB_DATATYPE_VOID, NULL, 0, _
					  attrib, mode, _
					  options )

	if( sym = NULL ) then
		exit function
	end if

	parent = symbGetNamespace( sym )

	'' check if it's copy constructor
	if( symbIsConstructor( sym ) ) then
		if( symbGetCompCopyCtor( parent ) = sym ) then
			symbSetHasCopyCtor( parent )
		end if

		symbSetHasCtor( parent )

	else
		symbSetHasDtor( parent )
	end if

	function = sym

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
	dim as FBSYMBOL ptr sym, parent
	dim as FB_SYMBOPT options

	id = hMangleFunctionPtr( proc, dtype, subtype, mode )

    '' if in main (or inside a NS), add the func ptr to the main table
    if( parser.scope = FB_MAINSCOPE ) then
		parent = @symbGetGlobalNamespc( )
		options = FB_SYMBOPT_MOVETOGLOB
    else
    	parent = symbGetCurrentNamespc( )
    	options = 0
	end if

	'' already exists? (it's ok to use LookupAt, literal str's are always
	'' prefixed with {fbsc}, there will be clashes with func ptr mangled names )
    chain_ = symbLookupAt( parent, id, TRUE )
	if( chain_ <> NULL ) then
		return chain_->sym
	end if

	'' create a new prototype
	sym = symbAddPrototype( proc, _
							id, NULL, NULL, _
							dtype, subtype, ptrcnt, _
							0, mode, _
							options or FB_SYMBOPT_DECLARING or FB_SYMBOPT_PRESERVECASE )

	if( sym <> NULL ) then
		symbSetIsFuncPtr( sym )
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
	proc->proc.optparams = 0
	symbSymbTbInit( proc->proc.paramtb, proc )
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

	dtype = symbGetType( param )

	select case as const param->param.mode
    case FB_PARAMMODE_BYVAL
    	attrib = FB_SYMBATTRIB_PARAMBYVAL

    	select case dtype
    	'' byval string? it's actually an pointer to a zstring
    	case FB_DATATYPE_STRING
    		attrib = FB_SYMBATTRIB_PARAMBYREF
    		dtype = FB_DATATYPE_CHAR

    	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    		'' has a dtor, copy ctor or virtual methods? it's a copy..
    		if( symbIsTrivial( symbGetSubtype( param ) ) = FALSE ) then
    			attrib = FB_SYMBATTRIB_PARAMBYREF
    		end if
    	end select

	case FB_PARAMMODE_BYREF
	    attrib = FB_SYMBATTRIB_PARAMBYREF

	case FB_PARAMMODE_BYDESC
    	attrib = FB_SYMBATTRIB_PARAMBYDESC

	case else
    	exit function
	end select

	'' "this"?
	if( symbIsParamInstance( param ) ) then
		attrib or= FB_SYMBATTRIB_PARAMINSTANCE
	end if

    s = symbAddVarEx( symbol, NULL, dtype, param->subtype, 0, 0, _
    				  0, dTB(), attrib, _
    				  iif( param->param.suffix <> INVALID, _
    				  	   FB_SYMBOPT_ADDSUFFIX, _
    				  	   FB_SYMBOPT_NONE ) )

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
	if( proc->proc.real_dtype <> FB_DATATYPE_POINTER+FB_DATATYPE_STRUCT ) then
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
		if( proc->proc.real_dtype = FB_DATATYPE_POINTER+FB_DATATYPE_STRUCT ) then
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
function symAddProcInstancePtr _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr sym
	dim as integer dtype

	select case symbGetClass( parent )
	case FB_SYMBCLASS_STRUCT
		dtype = FB_DATATYPE_STRUCT
	case FB_SYMBCLASS_CLASS
		'dtype = FB_DATATYPE_CLASS
	end select

    sym = symbAddProcParam( proc, FB_INSTANCEPTR, _
    					  	dtype, parent, 0, _
    					  	FB_POINTERSIZE, FB_PARAMMODE_BYREF, INVALID, _
    					  	FB_SYMBATTRIB_PARAMINSTANCE, NULL )

	function = sym

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookup
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbFindOverloadProc _
	( _
		byval head_proc as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr f, fparam, pparam, fsubtype, psubtype
	dim as integer params

	''
	if( (head_proc = NULL) or (proc = NULL) ) then
		return NULL
	end if

	'' procs?
	if( (symbGetClass( head_proc ) <> FB_SYMBCLASS_PROC) or _
		(symbGetClass( proc ) <> FB_SYMBCLASS_PROC) ) then
		return NULL
	end if

	params = symbGetProcParams( proc )

	'' for each proc starting from parent..
	f = head_proc
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

		f = symbGetProcOvlNext( f )
	loop

	function = NULL

end function

'':::::
function symbFindOpOvlProc _
	( _
		byval op as AST_OP, _
		byval head_proc as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr p

	'' if it's not type casting op, handle is as an ordinary proc
	if( op <> AST_OP_CAST ) then
		return symbFindOverloadProc( head_proc, proc )
	end if

	'' for each proc starting from parent..
	p = head_proc
	do while( p <> NULL )

		'' same return type?
		if( proc->typ = p->typ ) then
			if( proc->subtype = p->subtype ) then
				return p
			end if
		end if

		p = symbGetProcOvlNext( p )
	loop

	function = NULL

end function

'':::::
function symbFindCtorProc _
	( _
		byval head_proc as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr p

	'' dtor? can't overload..
	if( symbIsDestructor( head_proc ) ) then
		return head_proc
	else
		return symbFindOverloadProc( head_proc, proc )
	end if

end function


const FB_OVLPROC_HALFMATCH = FB_DATATYPES
const FB_OVLPROC_FULLMATCH = FB_OVLPROC_HALFMATCH * 2

'':::::
#macro hCheckCtorOvl _
	( _
		rec_cnt, _
		param_subtype, _
		arg_expr _
	)

	if( rec_cnt = 0 ) then
		dim as integer err_num = any
		dim as FBSYMBOL ptr proc = any

		rec_cnt += 1
		proc = symbFindCtorOvlProc( param_subtype, arg_expr, @err_num )
		rec_cnt -= 1

		if( proc <> NULL ) then
			return FB_OVLPROC_HALFMATCH - FB_DATATYPE_STRUCT
		end if
	end if
#endmacro

'':::::
private function hCalcTypesDiff _
	( _
		byval param_dtype as integer, _
		byval param_subtype as FBSYMBOL ptr, _
		byval param_ptrcnt as integer, _
		byval arg_dtype as integer, _
		byval arg_subtype as FBSYMBOL ptr, _
	  	byval arg_expr as ASTNODE ptr _
	) as integer

	dim as integer arg_dclass = any

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

					return FB_OVLPROC_HALFMATCH
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

	'' anything else, this function is only used when nothing matches
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
	) as integer

	dim as integer param_dtype = any, arg_dtype = any, param_ptrcnt = any
	dim as FBSYMBOL ptr param_subtype = any, arg_subtype = any

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
	param_ptrcnt = symbGetPtrCnt( param )

	arg_dtype = astGetDataType( arg_expr )
	arg_subtype = astGetSubType( arg_expr )

	select case symbGetParamMode( param )
	'' by descriptor param?
	case FB_PARAMMODE_BYDESC
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

	'' byref param?
	case FB_PARAMMODE_BYREF
		'' arg being passed by value?
		if( arg_mode = FB_PARAMMODE_BYVAL ) then
			'' invalid type? refuse..
			if( (symbGetDataClass( arg_dtype ) <> FB_DATACLASS_INTEGER) or _
				(symbGetDataSize( arg_dtype ) <> FB_POINTERSIZE) ) then
               	return 0
			end if

			'' pretend param is a pointer
			param_dtype += FB_DATATYPE_POINTER
			param_ptrcnt += 1
		end if
	end select

	'' arg passed by descriptor? refuse..
	if( arg_mode = FB_PARAMMODE_BYDESC ) then
		return 0
	end if

	static as integer ctor_rec_cnt = 0

	'' same types?
	if( param_dtype = arg_dtype ) then
		'' same subtype? full match..
		if( param_subtype = arg_subtype ) then
			return FB_OVLPROC_FULLMATCH
		end if

		'' pointer? check if valid (could be a NULL)
		if( param_dtype >= FB_DATATYPE_POINTER ) then
			if( astPtrCheck( param_dtype, _
				 			 param_subtype, _
				 			 arg_expr ) ) then

				return FB_OVLPROC_FULLMATCH
			end if

			return 0
		end if
	end if

	'' different types..

	select case param_dtype
	'' UDT? try to find a ctor
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
        hCheckCtorOvl( ctor_rec_cnt, param_subtype, arg_expr )
		return 0

	'' enum param? refuse any other argument type, even integers,
	'' or operator overloading wouldn't work (as in C++)
    case FB_DATATYPE_ENUM
       	return 0

    case else
		select case arg_dtype
		'' UDT arg? try implicit casting..
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			static as integer cast_rec_cnt = 0
			if( cast_rec_cnt <> 0 ) then
				return 0
			end if

			dim as integer err_num = any
			dim as FBSYMBOL ptr proc = any

			cast_rec_cnt += 1
			proc = symbFindCastOvlProc( param_dtype, _
										param_subtype, _
										arg_expr, _
										@err_num )
			cast_rec_cnt -= 1

			return iif( proc <> NULL, FB_OVLPROC_HALFMATCH - FB_DATATYPE_STRUCT, 0 )
		end select
    end select

	'' last resource, calc the differences
	function = hCalcTypesDiff( param_dtype, _
						  	   param_subtype, _
						  	   param_ptrcnt, _
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
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr proc = any, closest_proc = any, param = any
	dim as integer i = any, arg_matches = any, matches = any
	dim as integer max_matches = any, amb_cnt = any
	dim as FB_CALL_ARG ptr arg = any

	*err_num = FB_ERRMSG_OK

	closest_proc = NULL
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
			   	closest_proc = proc
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
		proc = symbGetProcOvlNext( proc )
	loop

	'' more than one possibility?
	if( amb_cnt > 0 ) then
		*err_num = FB_ERRMSG_AMBIGUOUSCALLTOPROC
		function = NULL
	else
		function = closest_proc
	end if

end function

'':::::
function symbFindBopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

	dim as FB_CALL_ARG argTb(0 to 1) = any
	dim as FBSYMBOL ptr proc = any

   	*err_num = FB_ERRMSG_OK

	'' at least one must be an UDT
   	select case astGetDataType( l )
   	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

   	case else
   		'' try the 2nd one..
   		select case astGetDataType( r )
   		case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

   		case else
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

	proc = symbFindClosestOvlProc( symb.globOpOvlTb(op).head, 2, @argTb(0), err_num )

	if( proc = NULL ) then
		if( *err_num <> FB_ERRMSG_OK ) then
			errReport( *err_num, TRUE )
		end if
	end if

	function = proc

end function

'':::::
function symbFindSelfBopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval r as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

	dim as FB_CALL_ARG argTb(0 to 1) = any
	dim as FBSYMBOL ptr proc = any, head_proc = any

   	*err_num = FB_ERRMSG_OK

	'' lhs must be an UDT
   	select case astGetDataType( l )
   	case FB_DATATYPE_STRUCT
   		dim as FBSYMBOL ptr subtype = astGetSubType( l )

   		if( subtype->udt.ext = NULL ) then
			return NULL
		end if

   		head_proc = symbGetUDTOpOvlTb( subtype )(op - AST_OP_SELFBASE)

   	'case FB_DATATYPE_CLASS

   	case else
   		return NULL
   	end select

   	if( head_proc = NULL ) then
   		return NULL
   	end if

	'' try (l, r)
	argTb(0).expr = l
	argTb(0).mode = INVALID
	argTb(0).next = @argTb(1)

	argTb(1).expr = r
	argTb(1).mode = INVALID
	argTb(1).next = NULL

	proc = symbFindClosestOvlProc( head_proc, 2, @argTb(0), err_num )

	if( proc = NULL ) then
		if( *err_num <> FB_ERRMSG_OK ) then
			errReport( *err_num, TRUE )
		end if
	end if

	function = proc

end function

'':::::
function symbFindUopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

	dim as FB_CALL_ARG argTb(0) = any
	dim as FBSYMBOL ptr proc = any

   	*err_num = FB_ERRMSG_OK

	'' arg must be an UDT
   	select case astGetDataType( l )
   	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

   	case else
   		'' note: the CAST op shouldn't be passed to this function
   		return NULL
   	end select

	argTb(0).expr = l
	argTb(0).mode = INVALID
	argTb(0).next = NULL

	proc = symbFindClosestOvlProc( symb.globOpOvlTb(op).head, 1, @argTb(0), err_num )

	if( proc = NULL ) then
		if( *err_num <> FB_ERRMSG_OK ) then
			errReport( *err_num, TRUE )
		end if
	end if

	function = proc

end function

'':::::
private function hCheckCastOvl _
	( _
		byval proc as FBSYMBOL ptr, _
		byval to_dtype as integer, _
		byval to_subtype as FBSYMBOL ptr _
	) as integer

	dim as integer proc_dtype = any
	dim as FBSYMBOL ptr proc_subtype = any

	proc_dtype = symbGetType( proc )
	proc_subtype = symbGetSubType( proc )

	'' same types?
	if( proc_dtype = to_dtype ) then
		'' same subtype?
		if( proc_subtype = to_subtype ) then
			return FB_OVLPROC_FULLMATCH
		end if

		if( proc_dtype >= FB_DATATYPE_POINTER ) then
			return 0
		end if
	end if

	'' different types..

	select case proc_dtype
	'' UDT or enum? can't be different (this is the last resource,
	'' don't try to do coercion inside a casting routine)
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS
		return 0

	case else
		select case to_dtype
		'' UDT arg? refuse
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			return 0
		end select

	end select

	'' last resource, calc the differences
	function = hCalcTypesDiff( proc_dtype, _
						   	   proc_subtype, _
						   	   symbGetPtrCnt( proc ), _
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
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr proc_head = any, subtype = any

   	*err_num = FB_ERRMSG_OK

	'' arg must be an UDT
   	select case astGetDataType( l )
   	case FB_DATATYPE_STRUCT
   		subtype = astGetSubType( l )
   		if( subtype = NULL ) then
   			return NULL
   		end if

   		if( subtype->udt.ext = NULL ) then
			return NULL
		end if

   		proc_head = symbGetUDTOpOvlTb( subtype )(AST_OP_CAST - AST_OP_SELFBASE)

   	case else
   		return NULL
   	end select

   	if( proc_head = NULL ) then
   		return NULL
   	end if

	dim as FBSYMBOL ptr p = any, proc = any, closest_proc = any
	dim as integer matches = any, max_matches = any, amb_cnt = any

	'' must check the return type, not the parameter..
	closest_proc = NULL
	max_matches = 0
	amb_cnt = 0

	if( to_dtype <> FB_DATATYPE_VOID ) then
		'' for each overloaded proc..
		proc = proc_head
		do while( proc <> NULL )

			matches = hCheckCastOvl( proc, to_dtype, to_subtype )
			if( matches > max_matches ) then
		   		closest_proc = proc
		   		max_matches = matches
		   		amb_cnt = 0

			'' same? ambiguity..
			elseif( matches = max_matches ) then
				if( max_matches > 0 ) then
					amb_cnt += 1
				end if
			end if

			'' next
			proc = symbGetProcOvlNext( proc )
		loop

	'' find the most precise possible..
	else
		'' for each overloaded proc..
		proc = proc_head
		do while( proc <> NULL )

			'' simple type?
			if( symbGetSubType( proc ) = NULL ) then
				if( symbGetType( proc ) <= FB_DATATYPE_DOUBLE ) then
					'' more precise than the last?
					if( symbGetType( proc ) > to_dtype ) then
		   				closest_proc = proc
		   				to_dtype = symbGetType( proc )
					end if
				end if
			end if

			'' next
			proc = symbGetProcOvlNext( proc )
		loop

	end if

	'' more than one possibility?
	if( amb_cnt > 0 ) then
		*err_num = FB_ERRMSG_AMBIGUOUSCALLTOPROC
		errReportParam( proc_head, 0, NULL, FB_ERRMSG_AMBIGUOUSCALLTOPROC )
		function = NULL
	else
		function = closest_proc
	end if

end function

'':::::
function symbFindCtorOvlProc _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

 	dim as FB_CALL_ARG argTb(0 to 1) = any

 	argTb(0).expr = astBuildMockInstPtr( sym )
 	argTb(0).mode = FB_PARAMMODE_BYVAL
 	argTb(0).next = @argtb(1)

 	argTb(1).expr = expr
 	argTb(1).mode = INVALID
 	argTb(1).next = NULL

    dim as FBSYMBOL ptr proc = any

 	function = symbFindClosestOvlProc( symbGetCompCtorHead( sym ), _
 								   	   2, _
 								   	   @argTb(0), _
 								   	   err_num )

	'' delete the mock node
	astDelTree( argTb(0).expr )

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

    if( s = NULL ) then
    	exit sub
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

    '' note: can't delete the next overloaded procs in the list here
    '' because global operators can be declared inside namespaces,
    '' but they will be linked together

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' global ctors
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hAddToGlobCtorList _
	( _
		byval list as FB_GLOBCTORLIST ptr, _
		byval proc as FBSYMBOL ptr _
	) as FB_GLOBCTORLIST_ITEM ptr

    dim as FB_GLOBCTORLIST_ITEM ptr n = any

    n = listNewNode( @list->list )

    '' add to list
    if( list->tail <> NULL ) then
    	list->tail->next = n
    else
    	list->head = n
    end if

    n->next = NULL
    list->tail = n

    ''
    n->sym = proc

    function = n

end function

'':::::
function symbAddGlobalCtor _
	( _
		byval proc as FBSYMBOL ptr _
	) as FB_GLOBCTORLIST_ITEM ptr

    symbSetIsGlobalCtor( proc )

	function = hAddToGlobCtorList( @symb.globctorlist, proc )

end function

'':::::
function symbAddGlobalDtor _
	( _
		byval proc as FBSYMBOL ptr _
	) as FB_GLOBCTORLIST_ITEM ptr

    symbSetIsGlobalDtor( proc )

	function = hAddToGlobCtorList( @symb.globdtorlist, proc )

end function

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

    s = symbGetProcSymbTbHead( proc )
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
					s->ofs = emitAllocLocal( parser.currproc, lgt )

				'' parameter..
				else
					lgt = iif( (s->attrib and FB_SYMBATTRIB_PARAMBYVAL), _
						   	   s->lgt, _
						   	   FB_POINTERSIZE )
					s->ofs = emitAllocArg( parser.currproc, lgt )

				end if

				symbSetVarIsAllocated( s )

			end if

		end if

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
    		id += symbMangleParam( param )
    	end if

    	param = symbGetParamNext( param )
    next

    '' return type
    id += ")"
	if( subtype = NULL ) then
		id += hex( dtype )
	else
		'' see the notes above
		id += symbMangleType( dtype, subtype )
	end if

    symbMangleEndAbbrev( )

    '' calling convention
    id += "$"
    id += hex( mode )

	function = strptr( id )

end function

private function hDemangleParams _
	( _
		byval proc as FBSYMBOL ptr _
	) as zstring ptr

	static as string res
	dim as FBSYMBOL ptr param

	static as zstring ptr parammodeTb( FB_PARAMMODE_BYVAL to FB_PARAMMODE_VARARG ) = _
	{ _
		@"byval", _
		@"byref", _
		@"bydesc", _
		@"vararg" _
	}

    res = ""

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

    function = strptr( res )

end function

'':::::
function symbDemangleFunctionPtr _
	( _
		byval proc as FBSYMBOL ptr _
	) as zstring ptr

	static as string res

	'' sub or function?
	if( proc->typ <> FB_DATATYPE_VOID ) then
		res = "function("
	else
		res = "sub("
	end if

	res += *hDemangleParams( proc )

	res += ")"

	'' any return type?
	if( proc->typ <> FB_DATATYPE_VOID ) then
    	res += " as "
    	res += *symbTypeToStr( proc->typ, proc->subtype )
	end if

	function = strptr( res )

end function

'':::::
function symbGetFullProcName _
	( _
		byval proc as FBSYMBOL ptr _
	) as zstring ptr

	static as string res

	res = ""

	dim as FBSYMBOL ptr ns = symbGetNamespace( proc )

	do while( ns <> @symbGetGlobalNamespc( ) )
		res = *symbGetName( ns ) + "." + res
		ns = symbGetNamespace( ns )
	loop

	if( symbIsConstructor( proc ) ) then
	 	res += "constructor"

	elseif( symbIsDestructor( proc ) ) then
		res += "destructor"

	elseif( symbIsOperator( proc ) ) then
		res += "operator."
		if( proc->proc.ext <> NULL ) then
			res += *astGetOpId( proc->proc.ext->opovl.op )
		end if

	elseif( symbIsProperty( proc ) ) then
		res += *symbGetName( proc )

		res += ".property."
		if( symbGetType( proc ) <> FB_DATATYPE_VOID ) then
			res += "get"
		else
			res += "set"
		end if

	else
		res += *symbGetName( proc )
	end if

	function = strptr( res )

end function

'':::::
function symbDemangleMethod _
	( _
		byval proc as FBSYMBOL ptr _
	) as zstring ptr

	static as string res

	res = *symbGetFullProcName( proc )

	res += "("

	res += *hDemangleParams( proc )

	res += ")"

	'' any return type?
	if( proc->typ <> FB_DATATYPE_VOID ) then
    	res += " as "
    	res += *symbTypeToStr( proc->typ, proc->subtype )
	end if

	function = strptr( res )

end function

