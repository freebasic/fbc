'' symbol table module for procedures
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "ast.bi"

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
	) as integer

	'' assumes dtype has const info stripped

    select case as const mode
    case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
    	function = FB_POINTERSIZE

    case FB_PARAMMODE_BYVAL
    	select case as const dtype
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
	) as integer

	dim as integer lgt = any
	dim as FBSYMBOL ptr param = any

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
    	if( typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ) = typeAddrOf( FB_DATATYPE_STRUCT ) ) then
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
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as integer, _
		byval mode as integer, _
		byval attrib as FB_SYMBATTRIB, _
		byval optexpr as ASTNODE ptr _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr param = any

    function = NULL

    param = symbNewSymbol( FB_SYMBOPT_PRESERVECASE, _
    					   NULL, _
    					   @proc->proc.paramtb, NULL, _
    					   FB_SYMBCLASS_PARAM, _
    				   	   id, id_alias, _
    				   	   dtype, subtype, _
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
	param->param.optexpr = optexpr

	'' for UDTs, check if not including a byval param to self
	if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
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
	) as integer

	dim as FBSYMBOL ptr f = any

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
	) as integer

    select case typeGet( dtype )
    '' string? it's actually a pointer to a string descriptor
    case FB_DATATYPE_STRING
    	 return typeAddrOf( FB_DATATYPE_STRING )

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
	) as integer

	dim as FBSYMBOL ptr pparam = any

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
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval symtb as FBSYMBOLTB ptr, _
		byval hashtb as FBHASHTB ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB, _
		byval preservecase as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr ovl = any, ovl_param = any, param = any
	dim as integer ovl_params = any, params = any

	function = NULL

	if( ovl_head_proc = NULL ) then
		exit function
	end if

	'' only one them is a property?
	if( (attrib and FB_SYMBATTRIB_PROPERTY) <> 0 ) then
    	if( symbIsProperty( ovl_head_proc ) = FALSE ) then
			exit function
    	end if

	elseif( symbIsProperty( ovl_head_proc ) ) then
		if( (attrib and FB_SYMBATTRIB_PROPERTY) = 0 ) then
			exit function
		end if
	end if

	'' not arg-less?
	params = symbGetProcParams( proc )
	if( (attrib and FB_SYMBATTRIB_METHOD) <> 0 ) then
		params -= 1
	end if

	if( params > 0 ) then
		'' can't be vararg..
		param = symbGetProcTailParam( proc )
		if( param->param.mode = FB_PARAMMODE_VARARG ) then
			exit function
		end if

		'' any AS ANY param?
		do while( param <> NULL )
			if( param->typ = FB_DATATYPE_VOID ) then
				exit function
			end if

			param = param->prev
		loop
	end if

	'' for each overloaded proc..
	ovl = ovl_head_proc
	do
		ovl_params = ovl->proc.params
		if( symbIsMethod( ovl ) ) then
			ovl_params -= 1
		end if

		'' property? handle get/set accessors dups
		if( (attrib and FB_SYMBATTRIB_PROPERTY) <> 0 ) then
			'' get?
			if( dtype <> FB_DATATYPE_VOID ) then
				'' don't check if it's set
				if( symbGetType( ovl ) = FB_DATATYPE_VOID ) then
					ovl_params = -1
				end if
			'' set..
			else
				'' don't check if it's get
				if( symbGetType( ovl ) <> FB_DATATYPE_VOID ) then
					ovl_params = -1
				end if
			end if
		end if

		'' same number of params?
		if( ovl_params = params ) then
			'' both arg-less?
			if( params = 0 ) then
				exit function
			end if

			'' for each arg..
			param = symbGetProcTailParam( proc )
			ovl_param = symbGetProcTailParam( ovl )

			do
				'' different modes?
				if( param->param.mode <> ovl_param->param.mode ) then
					'' one is by desc? allow byref and byval args
					'' with the same type or subtype
					if( param->param.mode = FB_PARAMMODE_BYDESC ) then
						exit do
					elseif( ovl_param->param.mode = FB_PARAMMODE_BYDESC ) then
						exit do
					end if
				end if

				dim as integer pdtype = param->typ
				dim as integer odtype = ovl_param->typ

				'' check the const qualifier
				if( (typeGetConstMask( pdtype ) or _
					typeGetConstMask( odtype )) <> 0 ) then

					'' both byref?
					if( (param->param.mode = FB_PARAMMODE_BYREF ) _
						and (ovl_param->param.mode = FB_PARAMMODE_BYREF )) then

						if( typeGetConstMask( pdtype ) <> _
							typeGetConstMask( odtype ) ) then
							exit do
						end if

					endif

					'' else only matters if it's a 'const ptr' (as in C++)
					if( typeGetPtrConstMask( pdtype ) <> _
						typeGetPtrConstMask( odtype ) ) then
						exit do
					end if

					pdtype = typeGetDtAndPtrOnly( pdtype )
					odtype = typeGetDtAndPtrOnly( odtype )
				end if

				'' not the same type? check next proc..
				if( pdtype <> odtype ) then

					'' handle special cases: zstring ptr and string args
					select case pdtype
					case typeAddrOf( FB_DATATYPE_CHAR )
						if( odtype <> FB_DATATYPE_STRING ) then
							exit do
						end if

					case FB_DATATYPE_STRING
						if( odtype <> typeAddrOf( FB_DATATYPE_CHAR ) ) then
							exit do
						end if

					case else
						exit do
					end select
				end if

				if( param->subtype <> ovl_param->subtype ) then
					exit do
				end if

				param = param->prev
				ovl_param = ovl_param->prev

				ovl_params -= 1
			loop while( ovl_params > 0 )

			'' all params equal? can't overload..
			if( ovl_params = 0 ) then
				exit function
			end if

		end if

		ovl = symbGetProcOvlNext( ovl )
	loop while( ovl <> NULL )

    if( symbIsLocal( ovl_head_proc ) ) then
    	attrib or= FB_SYMBATTRIB_LOCAL
    end if

    '' add the new proc symbol, w/o adding it to the hash table
	proc = symbNewSymbol( iif( preservecase, FB_SYMBOPT_PRESERVECASE, FB_SYMBOPT_NONE ), _
						  proc, _
						  symtb, hashtb, _
						  FB_SYMBCLASS_PROC, _
						  id, id_alias, _
					      dtype, subtype, _
					      attrib )

	if( proc = NULL ) then
		exit function
	end if

	'' add to hash chain list, as they share the same name
	if( id <> NULL ) then
		dim as FBSYMBOL ptr nxt = any

		proc->hash.index = ovl_head_proc->hash.index
		proc->hash.item = ovl_head_proc->hash.item

    	nxt = ovl_head_proc->hash.next
    	ovl_head_proc->hash.next = proc

		proc->hash.prev = ovl_head_proc
		proc->hash.next = nxt
		if( nxt <> NULL ) then
			nxt->hash.prev = proc
		end if
	end if

	function = proc

end function

'':::::
private function hAddOpOvlProc _
	( _
		byval proc as FBSYMBOL ptr, _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval symtb as FBSYMBOLTB ptr, _
		byval hashtb as FBHASHTB ptr, _
		byval op as AST_OP, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr ovl = any

	'' if it's not the type casting op, overloaded as an ordinary proc
	if( op <> AST_OP_CAST ) then
		return hAddOvlProc( proc, ovl_head_proc, _
							symtb, hashtb, _
							NULL, id_alias, _
							dtype, subtype, attrib, _
							FALSE )
	end if

	'' type casting, must check the return type, not the parameter..

	'' for each overloaded proc..
	ovl = ovl_head_proc
	do while( ovl <> NULL )

		'' same type?
		if( proc->typ = ovl->typ ) then
			'' and sub-type?
			if( proc->subtype = ovl->subtype ) then
				'' dup definition..
				return NULL
			end if
		end if

		'' next
		ovl = symbGetProcOvlNext( ovl )
	loop

	if( symbIsLocal( ovl_head_proc ) ) then
		attrib or= FB_SYMBATTRIB_LOCAL
	end if

    '' add it
	proc = symbNewSymbol( FB_SYMBOPT_NONE, _
						  proc, _
						  symtb, hashtb, _
						  FB_SYMBCLASS_PROC, _
						  NULL, id_alias, _
					      dtype, subtype, _
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
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr

    dim as integer stats = any, preserve_case = any
    dim as FBSYMBOL ptr proc = any, head_proc = any, parent = any
	dim as FBSYMBOLTB ptr symbtb = any
	dim as FBHASHTB ptr hashtb = any

    function = NULL

#if _SSE
	'dim as integer returnMethod = sym->proc.returnMethod
#endif

	attrib or= FB_SYMBATTRIB_SHARED

	''
	if( dtype = FB_DATATYPE_INVALID ) then
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
    	symbtb = @symbGetCompSymbTb( parent )
    	hashtb = @symbGetCompHashTb( parent )
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
				   	  	  	  	  FB_DATATYPE_VOID, NULL, _
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
							    FB_DATATYPE_VOID, NULL, _
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

        op = symbGetProcOpOvl( sym )

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
				   	  	  	  	  dtype, subtype, _
				   	  	  	  	  attrib )

        	symbSetCompOpOvlHead( parent, proc )

        '' otherwise, try to overload
        else
			proc = hAddOpOvlProc( sym, head_proc, _
								  symbtb, hashtb, _
								  op, id_alias, _
								  dtype, subtype, _
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
					   	  	  dtype, subtype, _
					   	  	  attrib )

		'' dup def?
		if( proc = NULL ) then
			'' is the dup a proc symbol?
			head_proc = symbLookupByNameAndClass( parent, _
										   	   	  id, _
										   	   	  FB_SYMBCLASS_PROC, _
										   	   	  preserve_case, _
										   	   	  FALSE )
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
								dtype, subtype, _
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

	'' if overloading, update the linked-list
	if( symbIsOverloaded( proc ) ) then
		dim as integer params = symbGetProcParams( proc )

		'' note: min and max params don't count the instance ptr
		if( symbIsMethod( proc ) ) then
			params -= 1
		end if

		if( head_proc <> NULL ) then
			proc->proc.ovl.next = head_proc->proc.ovl.next
			head_proc->proc.ovl.next = proc

			if( params < symGetProcOvlMinParams( head_proc ) ) then
				symGetProcOvlMinParams( head_proc ) = params
			end if

			if( params > symGetProcOvlMaxParams( head_proc ) ) then
				symGetProcOvlMaxParams( head_proc ) = params
			end if

		else
			proc->proc.ovl.next = NULL
			symGetProcOvlMinParams( proc ) = params
			symGetProcOvlMaxParams( proc ) = params
		end if
	end if

	proc->stats or= stats
#if _SSE
	'proc->proc.returnMethod = returnMethod
#endif


	function = proc

end function

'':::::
function symbAddPrototype _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr

    function = NULL

	proc = hSetupProc( proc, id, id_alias, dtype, subtype, attrib, mode, options )
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
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer, _
		byval mode as integer _
	) as FBSYMBOL ptr

    function = NULL

	proc = hSetupProc( proc, id, id_alias, dtype, subtype, _
	                   attrib, mode, FB_SYMBOPT_DECLARING )
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
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr sym = any

    function = NULL

	''
	if( proc->proc.ext = NULL ) then
		proc->proc.ext = symbAllocProcExt( )
	end if
	proc->proc.ext->opovl.op = op

	''
	sym = hSetupProc( proc, NULL, id_alias, dtype, subtype, _
	                  attrib, mode, options )

	if( sym = NULL ) then
		symbFreeProcExt( proc )
		exit function
	end if

	function = sym

end function

'':::::
function symbAddCtor _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id_alias as zstring ptr, _
		byval attrib as integer, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr sym = any, parent = any

    function = NULL

	sym = hSetupProc( proc, NULL, id_alias, FB_DATATYPE_VOID, NULL, _
	                  attrib, mode, options )

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
		byval mode as integer _
	) as FBSYMBOL ptr

	dim as zstring ptr id = any
	dim as FBSYMCHAIN ptr chain_ = any
	dim as FBSYMBOL ptr sym = any, parent = any
	dim as FB_SYMBOPT options = any

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
	'' prefixed with {fbsc}, there will be no clashes with func ptr mangled names)
    chain_ = symbLookupAt( parent, id, TRUE, FALSE )
	if( chain_ <> NULL ) then
		return chain_->sym
	end if

	'' create a new prototype
	sym = symbAddPrototype( proc, id, hMakeTmpStrNL(), dtype, subtype, _
	                        0, mode, options or FB_SYMBOPT_DECLARING or _
	                                 FB_SYMBOPT_PRESERVECASE )

	if( sym <> NULL ) then
		symbSetIsFuncPtr( sym )
	end if

	function = sym

end function

'':::::
function symbAddProcPtrFromFunction _
	( _
		byval base_proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	var proc = symbPreAddProc( NULL )

	proc->proc.returnMethod = base_proc->proc.returnMethod

	'' params
	var param = symbGetProcHeadParam( base_proc )
    do while( param <> NULL )
    	var p = symbAddProcParam( proc, _
    					  		  NULL, NULL, _
    					  		  symbGetFullType( param ), symbGetSubtype( param ), _
    					  		  symbGetLen( param ), symbGetParamMode( param ), _
    					  		  symbGetAttrib( param ), param->param.optexpr )

		if( symbGetDontInit( param ) ) then
			symbSetDontInit( p )
		end if

		param = param->next
    loop

	function = symbAddProcPtr( proc, _
							   symbGetFullType( base_proc ), _
							   symbGetSubtype( base_proc ), _
							   symbGetProcMode( base_proc ) )

end function

'':::::
function symbPreAddProc _
	( _
		byval symbol as zstring ptr _
	) as FBSYMBOL ptr

    dim as FBSYMBOL ptr proc = any

	proc = listNewNode( @symb.symlist )

	proc->class = FB_SYMBCLASS_PROC
	proc->proc.params = 0
	proc->proc.optparams = 0
	symbSymbTbInit( proc->proc.paramtb, proc )
	proc->id.name = symbol
	proc->proc.ext = NULL
	proc->attrib = 0
	proc->stats = 0

	proc->proc.returnMethod = FB_RETURN_FPU

    '' to allow getNamespace() and GetParent() to work
    proc->symtb = @symbGetCompSymbTb( symbGetCurrentNamespc( ) )
    proc->hash.tb = @symbGetCompHashTb( symbGetCurrentNamespc( ) )

	function = proc

end function

'':::::
function symbAddParam _
	( _
		byval symbol as zstring ptr, _
		byval param as FBSYMBOL ptr _
	) as FBSYMBOL ptr

    dim as FBARRAYDIM dTB(0) = any
    dim as FBSYMBOL ptr s = any
    dim as integer attrib = any, dtype = any

	function = NULL

	dtype = symbGetFullType( param )

	select case as const param->param.mode
    case FB_PARAMMODE_BYVAL
    	attrib = FB_SYMBATTRIB_PARAMBYVAL

    	select case symbGetType( param )
    	'' byval string? it's actually an pointer to a zstring
    	case FB_DATATYPE_STRING
    		attrib = FB_SYMBATTRIB_PARAMBYREF
    		dtype = typeJoin( dtype, FB_DATATYPE_CHAR )

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

	'' QB quirk..
	if( symbIsSuffixed( param ) ) then
		attrib or= FB_SYMBATTRIB_SUFFIXED
	end if

    s = symbAddVarEx( symbol, NULL, _
    				  dtype, param->subtype, 0, _
    				  0, dTB(), _
    				  attrib )

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
	) as FBSYMBOL ptr

    dim as FBARRAYDIM dTB(0) = any
    dim as FBSYMBOL ptr s = any
    static as string id

	'' UDT?
	if( proc->typ <> FB_DATATYPE_STRUCT ) then
		return NULL
	end if

	'' returns in a reg?
	if( typeGetDtAndPtrOnly( proc->proc.real_dtype ) <> typeAddrOf( FB_DATATYPE_STRUCT ) ) then
		return NULL
	end if

   	id = *hMakeTmpStrNL( )
    s = symbAddVarEx( id, NULL, _
    				  FB_DATATYPE_STRUCT, proc->subtype, FB_POINTERSIZE, _
    				  0, dTB(), _
    				  FB_SYMBATTRIB_PARAMBYREF, _
    				  FB_SYMBOPT_PRESERVECASE )


	if( proc->proc.ext = NULL ) then
		proc->proc.ext = symbAllocProcExt( )
	end if

	proc->proc.ext->res = s

	symbSetIsDeclared( s )

	function = s

end function

'':::::
function symbAddProcResult _
	( _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as FBARRAYDIM dTB(0) = any
	dim as FBSYMBOL ptr res = any

	'' UDT?
	if( proc->typ = FB_DATATYPE_STRUCT ) then
		'' returning a ptr? result is at the hidden arg
		if( typeGetDtAndPtrOnly( proc->proc.real_dtype ) = typeAddrOf( FB_DATATYPE_STRUCT ) ) then
			return symbGetProcResult( proc )
		end if
	end if

	dim as zstring ptr id = NULL
	if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
		id = @"fb$result"
	end if

	res = symbAddVarEx( id, NULL, _
						proc->typ, proc->subtype, 0, _
						0, dTB(), _
					  	FB_SYMBATTRIB_FUNCRESULT, _
					  	FB_SYMBOPT_PRESERVECASE )

	if( proc->proc.ext = NULL ) then
		proc->proc.ext = symbAllocProcExt( )
	end if

	proc->proc.ext->res = res

	'' clear up the result
	astAdd( astNewDECL( FB_SYMBCLASS_VAR, res, NULL ) )

	symbSetIsDeclared( res )

	function = res

end function

'':::::
function symAddProcInstancePtr _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as integer dtype = any
	select case symbGetClass( parent )
	case FB_SYMBCLASS_STRUCT
		dtype = FB_DATATYPE_STRUCT
	case FB_SYMBCLASS_CLASS
		'dtype = FB_DATATYPE_CLASS
	end select

	if( symbIsConstant( proc ) ) then
		dtype = typeSetIsConst( dtype )
	end if

    function = symbAddProcParam( proc, _
    							 FB_INSTANCEPTR, NULL, _
    					  		 dtype, parent, FB_POINTERSIZE, _
    					  		 FB_PARAMMODE_BYREF, _
    					  		 FB_SYMBATTRIB_PARAMINSTANCE, NULL )

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookup
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbFindOverloadProc _
	( _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval options as FB_SYMBLOOKUPOPT _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr ovl = any, ovl_param = any, param = any
	dim as FBSYMBOL ptr ovl_subtype = any, subtype = any
	dim as integer ovl_params = any, params = any, i = any

	''
	if( (ovl_head_proc = NULL) or (proc = NULL) ) then
		return NULL
	end if

	'' procs?
	if( (symbGetClass( ovl_head_proc ) <> FB_SYMBCLASS_PROC) or _
		(symbGetClass( proc ) <> FB_SYMBCLASS_PROC) ) then
		return NULL
	end if

	params = symbGetProcParams( proc )
	if( symbIsMethod( proc ) ) then
		params -= 1
	end if

	dim as integer is_property = symbIsProperty( ovl_head_proc )

	'' for each proc starting from parent..
	ovl = ovl_head_proc
	do

		ovl_params = ovl->proc.params
		if( symbIsMethod( ovl ) ) then
			ovl_params -= 1
		end if

		'' property? handle get/set accessors dups
		if( is_property ) then
			'' get?
			if( (options and FB_SYMBLOOKUPOPT_PROPGET) <> 0 ) then
				'' don't check if it's set
				if( symbGetType( ovl ) = FB_DATATYPE_VOID ) then
					ovl_params = -1
				end if
			'' set..
			else
				'' don't check if it's get
				if( symbGetType( ovl ) <> FB_DATATYPE_VOID ) then
					ovl_params = -1
				end if
			end if
		end if

		if( params = ovl_params ) then

			'' arg-less?
			if( params = 0 ) then
				return ovl
			end if

			'' for each arg..
			ovl_param = symbGetProcTailParam( ovl )
			param = symbGetProcTailParam( proc )
			do
				'' different modes?
				if( param->param.mode <> ovl_param->param.mode ) then
					'' one is by desc? can't be the same..
					if( param->param.mode = FB_PARAMMODE_BYDESC ) then
						exit do
					elseif( ovl_param->param.mode = FB_PARAMMODE_BYDESC ) then
						exit do
					end if
				end if

				'' not the same type? check next proc..
				if( param->typ <> ovl_param->typ ) then
					exit do
				end if

				if( param->subtype <> ovl_param->subtype ) then
					exit do
				end if

				param = param->prev
				ovl_param = ovl_param->prev

				ovl_params -= 1
			loop while( ovl_params > 0 )

			'' all args equal?
			if( ovl_params = 0 ) then
				return ovl
			end if

		end if

		ovl = symbGetProcOvlNext( ovl )
	loop while( ovl <> NULL )

	function = NULL

end function

'':::::
function symbFindOpOvlProc _
	( _
		byval op as AST_OP, _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr ovl = any

	'' if it's not type casting op, handle is as an ordinary proc
	if( op <> AST_OP_CAST ) then
		return symbFindOverloadProc( ovl_head_proc, proc )
	end if

	'' for each proc starting from parent..
	ovl = ovl_head_proc
	do while( ovl <> NULL )

		'' same return type?
		if( proc->typ = ovl->typ ) then
			if( proc->subtype = ovl->subtype ) then
				return ovl
			end if
		end if

		ovl = symbGetProcOvlNext( ovl )
	loop

	function = NULL

end function

'':::::
function symbFindCtorProc _
	( _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	'' dtor? can't overload..
	if( symbIsDestructor( ovl_head_proc ) ) then
		return ovl_head_proc
	else
		return symbFindOverloadProc( ovl_head_proc, proc )
	end if

end function


const FB_OVLPROC_HALFMATCH = FB_DATATYPES
const FB_OVLPROC_FULLMATCH = FB_OVLPROC_HALFMATCH * 2

'':::::
#macro hCheckCtorOvl _
	( _
		rec_cnt, _
		param_subtype, _
		arg_expr, _
		arg_mode _
	)

	if( rec_cnt = 0 ) then
		dim as integer err_num = any
		dim as FBSYMBOL ptr proc = any

		rec_cnt += 1
		proc = symbFindCtorOvlProc( param_subtype, arg_expr, arg_mode, @err_num )
		rec_cnt -= 1

		if( proc <> NULL ) then
			return FB_OVLPROC_HALFMATCH - FB_DATATYPE_STRUCT
		end if
	end if
#endmacro

#macro hCheckCastOvlEx _
	( _
		rec_cnt, _
		param_dtype, _
		param_subtype, _
		arg_expr _
	)

	if( rec_cnt = 0 ) then
		dim as integer err_num = any
		dim as FBSYMBOL ptr proc = any

		rec_cnt += 1
		proc = symbFindCastOvlProc( param_dtype, _
									param_subtype, _
									arg_expr, _
									@err_num )
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
	  	byval arg_expr as ASTNODE ptr, _
	  	byval mode as FB_PARAMMODE = 0 _
	) as integer

	dim as integer arg_dclass = any

    '' don't take the const qualifier into account
    param_dtype = typeGetDtAndPtrOnly( param_dtype )
    arg_dtype = typeGetDtAndPtrOnly( arg_dtype )

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
				case typeAddrOf( FB_DATATYPE_CHAR ), FB_DATATYPE_CHAR
					return FB_OVLPROC_FULLMATCH
				case typeAddrOf( FB_DATATYPE_WCHAR ), FB_DATATYPE_WCHAR
					return FB_OVLPROC_HALFMATCH
				end select

			case FB_DATATYPE_WCHAR
				select case param_dtype
				case typeAddrOf( FB_DATATYPE_WCHAR ), FB_DATATYPE_WCHAR
					return FB_OVLPROC_FULLMATCH
				case typeAddrOf( FB_DATATYPE_CHAR ), FB_DATATYPE_CHAR
					return FB_OVLPROC_HALFMATCH
				end select

			case FB_DATATYPE_BITFIELD, FB_DATATYPE_ENUM
				'' enum args can be passed to integer params (as in C++)
				arg_dtype = symbRemapType( arg_dtype, arg_subtype )

			end select

			'' check pointers..
			if( typeIsPtr( param_dtype ) ) then
				'' isn't arg a pointer too?
				if( typeIsPtr( arg_dtype ) = FALSE ) then
					'' not an expression?
					if( arg_expr = NULL ) then
						return 0
					end if

					'' not a numeric constant?
					if( astIsCONST( arg_expr ) = FALSE ) then
						return 0
					end if

					'' not 0 (NULL)?
					if( arg_dtype = FB_DATATYPE_INTEGER ) then
						if( astGetValInt( arg_expr ) <> 0 ) then
							return 0
						end if
					else
						if( astGetValLong( arg_expr ) <> 0 ) then
							return 0
						end if
					end if

					'' not native pointer width?
					if( symbGetDataSize( arg_dtype ) <> FB_POINTERSIZE ) then
						return 0
					end if

					return FB_OVLPROC_HALFMATCH
				end if

				'' param is an any ptr?
				if( param_dtype = typeAddrOf( FB_DATATYPE_VOID ) ) then

					'' we return a full match only if they're both any
					if( arg_dtype = typeAddrOf( FB_DATATYPE_VOID ) ) then
						return FB_OVLPROC_FULLMATCH

					'' other wise, it's a half match
					'' the arg indirection level shouldn't matter (as in g++)
					else
						return FB_OVLPROC_HALFMATCH
					end if
				end if

				'' arg is an any ptr?
				if( arg_dtype = typeAddrOf( FB_DATATYPE_VOID ) ) then
					'' not the same level of indirection?
					if( param_ptrcnt > 1 ) then
						return 0
					end if

					return FB_OVLPROC_FULLMATCH
				end if

				'' no match
				return 0

			'' param not a pointer, but is arg?
			elseif( typeIsPtr( arg_dtype ) ) then
				'' use an UINT instead or LONGINT will match if any..
				arg_dtype = FB_DATATYPE_UINT
			end if

			return FB_OVLPROC_HALFMATCH - abs( typeGet( param_dtype ) - typeGet( arg_dtype ) )

		'' float? (ok due the auto-coercion, unless it's a pointer)
		case FB_DATACLASS_FPOINT
			if( typeIsPtr( param_dtype ) ) then
				return 0
			end if

			return FB_OVLPROC_HALFMATCH - abs( typeGet( param_dtype ) - typeGet( arg_dtype ) )

		'' string? only if it's a w|zstring ptr arg
		case FB_DATACLASS_STRING
			select case param_dtype
			case typeAddrOf( FB_DATATYPE_CHAR )
				return FB_OVLPROC_FULLMATCH
			case typeAddrOf( FB_DATATYPE_WCHAR )
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
			if( typeIsPtr( arg_dtype ) ) then
				return 0
			end if

			'' remap to real type if it's a bitfield..
			select case arg_dtype
			case FB_DATATYPE_BITFIELD, FB_DATATYPE_ENUM
				'' enum args can be passed to fpoint params (as in C++)
				arg_dtype = symbRemapType( arg_dtype, arg_subtype )
			end select

			return FB_OVLPROC_HALFMATCH - abs( typeGet( param_dtype ) - typeGet( arg_dtype ) )

		'' or if another float..
		case FB_DATACLASS_FPOINT
			return FB_OVLPROC_HALFMATCH - abs( typeGet( param_dtype ) - typeGet( arg_dtype ) )

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
		byval parent as FBSYMBOL ptr, _
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

	param_dtype = symbGetFullType( param )
	param_subtype = symbGetSubType( param )
	param_ptrcnt = symbGetPtrCnt( param )

	arg_dtype = astGetFullType( arg_expr )
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
			param_dtype = typeAddrOf( param_dtype )
			param_ptrcnt += 1
		end if
	end select

	'' arg passed by descriptor? refuse..
	if( arg_mode = FB_PARAMMODE_BYDESC ) then
		return 0
	end if

	static as integer cast_rec_cnt = 0, ctor_rec_cnt = 0

	'' same types?
	if( typeGetDtAndPtrOnly( param_dtype ) = typeGetDtAndPtrOnly( arg_dtype ) ) then

		if( typeGetConstMask( param_dtype ) = typeGetConstMask( arg_dtype ) ) then

			'' same subtype? full match..
			if( param_subtype = arg_subtype ) then
				return FB_OVLPROC_FULLMATCH
			end if

		elseif( typeGetConstMask( param_dtype ) ) then

			'' same subtype? ..
			if( param_subtype = arg_subtype ) then

				'' param is const but arg isn't?
				if( symbCheckConstAssign( param_dtype, arg_dtype, param_subtype, arg_subtype ) ) then
					return FB_OVLPROC_HALFMATCH
				end if

			end if

		end if

		'' if it's rtl, only if explicitly set
	    if( (symbGetIsRTL( parent ) = FALSE) or (symbGetIsRTLConst( param )) ) then
			dim as integer const_matches = any
			if( symbCheckConstAssign( param_dtype, arg_dtype, param_subtype, arg_subtype, symbGetParamMode( param ), const_matches ) = FALSE ) then
				return 0
			else
				if( const_matches ) then
					dim as integer ptrcnt = typeGetPtrCnt( arg_dtype )
					return (FB_OVLPROC_HALFMATCH / (ptrcnt+2)) * const_matches
				end if
			end if
		end if

		'' pointer? check if valid (could be a NULL)
		if( typeIsPtr( param_dtype ) ) then
			if( astPtrCheck( param_dtype, _
				 			 param_subtype, _
				 			 arg_expr, _
				 			 TRUE ) ) then

				return FB_OVLPROC_FULLMATCH
			end if
			return 0
		end if
	end if

	'' different types..

	select case param_dtype
	'' UDT? try to find a ctor
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
        hCheckCtorOvl( ctor_rec_cnt, param_subtype, arg_expr, arg_mode )

        '' and at last, try implicit casting..
        hCheckCastOvlEx( cast_rec_cnt, param_dtype, param_subtype, arg_expr )
		return 0

	'' enum param? refuse any other argument type, even integers,
	'' or operator overloading wouldn't work (as in C++)
    case FB_DATATYPE_ENUM
       	return 0

    case else
		select case arg_dtype
		'' UDT arg? try implicit casting..
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			hCheckCastOvlEx( cast_rec_cnt, symbGetFullType( param ), param_subtype, arg_expr )
			return 0
		end select
    end select

	'' last resource, calc the differences
	function = hCalcTypesDiff( symbGetFullType( param ), _
						  	   param_subtype, _
						  	   param_ptrcnt, _
						  	   astGetFullType( arg_expr ), _
						  	   arg_subtype, _
						  	   arg_expr, _
						  	   symbGetParamMode( param ) )

end function

'':::::
function symbFindClosestOvlProc _
	( _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval args as integer, _
		byval arg_head as FB_CALL_ARG ptr, _
		byval err_num as FB_ERRMSG ptr, _
		byval options as FB_SYMBLOOKUPOPT _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr ovl = any, closest_proc = any, param = any
	dim as integer i = any, arg_matches = any, matches = any
	dim as integer max_matches = any, amb_cnt = any, exact_matches = any
	dim as FB_CALL_ARG ptr arg = any

	*err_num = FB_ERRMSG_OK

	if( ovl_head_proc = NULL ) then
		return NULL
	end if

	closest_proc = NULL
	max_matches = 0
	amb_cnt = 0

	dim as integer is_property = symbIsProperty( ovl_head_proc )

	'' for each proc..
	ovl = ovl_head_proc
	do
		dim as integer params = symbGetProcParams( ovl )
		if( symbIsMethod( ovl ) ) then
			params -= 1
		end if

		'' property? handle get/set accessors dups
		if( is_property ) then
			'' get?
			if( (options and FB_SYMBLOOKUPOPT_PROPGET) <> 0 ) then
				'' don't check if it's set
				if( symbGetType( ovl ) = FB_DATATYPE_VOID ) then
					params = -1
				end if
			'' set..
			else
				'' don't check if it's get
				if( symbGetType( ovl ) <> FB_DATATYPE_VOID ) then
					params = -1
				end if
			end if
		end if

		if( args <= params ) then
			'' arg-less? exit..
			if( params = 0 ) then
				return ovl
			end if

			param = symbGetProcLastParam( ovl )
			if( symbIsMethod( ovl ) ) then
				param = symbGetProcPrevParam( ovl, param )
			end if

			matches = 0
			exact_matches = 0

			'' for each arg..
			arg = arg_head
			for i = 0 to args-1

				arg_matches = hCheckOvlParam( ovl, param, arg->expr, arg->mode )
				if( arg_matches = 0 ) then
					matches = 0
					exit for
				end if

				'' exact checks are required for operator overload candidates
				if( options and FB_SYMBLOOKUPOPT_BOP_OVL ) then
					if( arg_matches = FB_OVLPROC_FULLMATCH ) then
						exact_matches += 1
					end if
				end if

				matches += arg_matches

               	'' next param
				param = symbGetProcPrevParam( ovl, param )
				arg = arg->next
			next

			'' fewer params? check if the ones missing are optional
			dim as integer total_args = args
			if( args < params ) then
				if( (matches > 0) or (args = 0) ) then
					do while( param <> NULL )
			    		'' not optional? exit
			    		if( symbGetIsOptional( param ) = FALSE ) then
			    			matches = 0
			    			exit do
			    		else
			    			matches += FB_OVLPROC_FULLMATCH
			    		end if
						total_args += 1
						'' next param
						param = symbGetProcPrevParam( ovl, param )
					loop
				end if
			end if
			matches /= total_args

		    '' closer?
		    if( matches > max_matches ) then

				dim as integer eligible = TRUE

				'' an operator overload candidate is only eligible if
				'' there is at least one exact arg match
				if( options and FB_SYMBLOOKUPOPT_BOP_OVL ) then
					if( exact_matches = 0 ) then
						eligible = FALSE
					end if
				end if

				'' it's eligible, update
				if( eligible ) then
				   	closest_proc = ovl
				   	max_matches = matches
				   	amb_cnt = 0
				end if

			'' same? ambiguity..
			elseif( matches = max_matches ) then
				if( max_matches > 0 ) then
					amb_cnt += 1
				end if
			end if

		end if

		'' next overloaded proc
		ovl = symbGetProcOvlNext( ovl )
	loop while( ovl <> NULL )

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

	dim as FB_CALL_ARG arg1 = any, arg2 = any
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
	arg1.expr = l
	arg1.mode = INVALID
	arg1.next = @arg2

	arg2.expr = r
	arg2.mode = INVALID
	arg2.next = NULL

	proc = symbFindClosestOvlProc( symb.globOpOvlTb(op).head, 2, @arg1, err_num, FB_SYMBLOOKUPOPT_BOP_OVL )

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

	dim as FB_CALL_ARG arg1 = any
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

	'' try (l, r) -- don't pass the instance ptr
	arg1.expr = r
	arg1.mode = INVALID
	arg1.next = NULL

	proc = symbFindClosestOvlProc( head_proc, 1, @arg1, err_num )

	if( proc = NULL ) then
		if( *err_num <> FB_ERRMSG_OK ) then
			errReport( *err_num, TRUE )
		end if

	else
    	'' check visibility
		if( symbCheckAccess( symbGetNamespace( proc ), proc ) = FALSE ) then
			*err_num = FB_ERRMSG_ILLEGALMEMBERACCESS
			errReportEx( FB_ERRMSG_ILLEGALMEMBERACCESS, _
						 symbGetFullProcName( proc ) )

			proc = NULL
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

	dim as FB_CALL_ARG arg1 = any
	dim as FBSYMBOL ptr proc = any

   	*err_num = FB_ERRMSG_OK

	'' arg must be an UDT
   	select case astGetDataType( l )
   	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

   	case else
   		'' note: the CAST op shouldn't be passed to this function
   		return NULL
   	end select

	arg1.expr = l
	arg1.mode = INVALID
	arg1.next = NULL

	proc = symbFindClosestOvlProc( symb.globOpOvlTb(op).head, 1, @arg1, err_num )

	if( proc = NULL ) then
		if( *err_num <> FB_ERRMSG_OK ) then
			errReport( *err_num, TRUE )
		end if
	end if

	function = proc

end function

'':::::
function symbFindSelfUopOvlProc _
	( _
		byval op as AST_OP, _
		byval l as ASTNODE ptr, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

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

	'' try (l) -- don't pass the instance ptr

	proc = symbFindClosestOvlProc( head_proc, 0, NULL, err_num )

	if( proc = NULL ) then
		if( *err_num <> FB_ERRMSG_OK ) then
			errReport( *err_num, TRUE )
		end if

	else
    	'' check visibility
		if( symbCheckAccess( symbGetNamespace( proc ), proc ) = FALSE ) then
			*err_num = FB_ERRMSG_ILLEGALMEMBERACCESS
			errReportEx( FB_ERRMSG_ILLEGALMEMBERACCESS, _
						 symbGetFullProcName( proc ) )

			proc = NULL
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

	proc_dtype = symbGetFullType( proc )
	proc_subtype = symbGetSubType( proc )

	'' same types?
	if( typeGetDtAndPtrOnly( proc_dtype ) = typeGetDtAndPtrOnly( to_dtype ) ) then
		'' same subtype?
		if( proc_subtype = to_subtype ) then
			return FB_OVLPROC_FULLMATCH
		end if

		if( typeIsPtr( proc_dtype ) ) then
			return 0
		end if
	end if

	'' different types..

	select case typeGet( proc_dtype )
	'' UDT or enum? can't be different (this is the last resource,
	'' don't try to do coercion inside a casting routine)
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS
		return 0

	case else
		select case typeGet( to_dtype )
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

	dim as FBSYMBOL ptr proc_head = any

   	*err_num = FB_ERRMSG_OK

	'' arg must be an UDT
   	select case astGetDataType( l )
   	case FB_DATATYPE_STRUCT
   		dim as FBSYMBOL ptr subtype = astGetSubType( l )
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

	if( typeGet( to_dtype ) <> FB_DATATYPE_VOID ) then
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
		closest_proc = NULL

	else
    	if( closest_proc <> NULL ) then
    		'' check visibility
			if( symbCheckAccess( symbGetNamespace( closest_proc ), _
								 closest_proc ) = FALSE ) then

				*err_num = FB_ERRMSG_ILLEGALMEMBERACCESS
				errReportEx( FB_ERRMSG_ILLEGALMEMBERACCESS, _
							 symbGetFullProcName( closest_proc ) )

				closest_proc = NULL
			end if
		end if
	end if

	function = closest_proc

end function

'':::::
function symbFindCtorOvlProc _
	( _
		byval sym as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval arg_mode as FB_PARAMMODE, _
		byval err_num as FB_ERRMSG ptr _
	) as FBSYMBOL ptr

 	dim as FB_CALL_ARG arg1 = any

 	'' don't pass the instance ptr
 	arg1.expr = expr
 	arg1.mode = arg_mode
 	arg1.next = NULL

 	function = symbFindClosestOvlProc( symbGetCompCtorHead( sym ), _
 								   	   1, _
 								   	   @arg1, _
 								   	   err_num )

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
		byval s as FBSYMBOL ptr, _
		byval is_tbdel as integer _
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
    	symbFreeProcExt( s )
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
	) as integer

    dim as FBSYMBOL ptr s = any
    dim as integer lgt = any
    dim as integer mask = any

    function = FALSE

    '' prepare mask (if the IR is HL, pass the local static vars too)
    if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
    	mask = FB_SYMBATTRIB_SHARED
    else
    	mask = FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
    end if

    s = symbGetProcSymbTbHead( proc )
    do while( s <> NULL )
    	'' variable?
    	if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared or static?
    		if( (s->attrib and mask) = 0 ) then

				'' not a parameter?
    			if( (s->attrib and (FB_SYMBATTRIB_PARAMBYDESC or _
    						   	    FB_SYMBATTRIB_PARAMBYVAL or _
    			  				   	FB_SYMBATTRIB_PARAMBYREF)) = 0 ) then

					lgt = s->lgt * symbGetArrayElements( s )
					s->ofs = irProcAllocLocal( parser.currproc, s, lgt )

				'' parameter..
				else
					lgt = iif( (s->attrib and FB_SYMBATTRIB_PARAMBYVAL), _
						   	   s->lgt, _
						   	   FB_POINTERSIZE )
					s->ofs = irProcAllocArg( parser.currproc, s, lgt )

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
	) as FBSYMBOL ptr

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
	) as integer

    dim as integer lgt = any

	select case mode
	case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
		lgt = FB_POINTERSIZE
	case else
		if( typeGet( dtype ) = FB_DATATYPE_STRING ) then
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
		p->proc.ext = symbAllocProcExt( )
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
	) as zstring ptr

    static as string id
    dim as integer i = any
    dim as FBSYMBOL ptr param = any

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
    		id += hex( param->typ ) + "M" + hex( cint(param->param.mode) )
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
	dim as FBSYMBOL ptr param = any

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

    '' method? skip the instance pointer
    if( param <> NULL ) then
    	if( symbIsMethod( proc ) ) then
    		param = symbGetParamNext( param )
    	end if
    end if

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
			res += *astGetOpId( symbGetProcOpOvl( proc ) )
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

'':::::
function symbGetDefaultCallConv _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	'' assumes dtype has const info stripped

	select case as const dtype
    case FB_DATATYPE_FWDREF, _
         FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, _
	     FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, _
         FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS

         return FB_PARAMMODE_BYREF

    case else
         return FB_PARAMMODE_BYVAL

    end select


end function


'':::::
function symbAllocOvlCallArg _
	( _
		byval list as TLIST ptr, _
		byval arg_list as FB_CALL_ARG_LIST ptr, _
		byval to_head as integer _
	) as FB_CALL_ARG ptr

	dim as FB_CALL_ARG ptr arg = listNewNode( list )

	if( to_head = FALSE ) then
		if( arg_list->head = NULL ) then
			arg_list->head = arg
		else
			arg_list->tail->next = arg
		end if

		arg->next = NULL
		arg_list->tail = arg

	else
		if( arg_list->tail = NULL ) then
			arg_list->tail = arg
		end if

		arg->next = arg_list->head
		arg_list->head = arg
	end if

	arg_list->args += 1

	function = arg

end function

'':::::
sub symbFreeOvlCallArgs _
	( _
		byval list as TLIST ptr, _
		byval arg_list as FB_CALL_ARG_LIST ptr _
	)

	dim as FB_CALL_ARG ptr arg, nxt

	arg = arg_list->head
	do while( arg <> NULL )
		nxt = arg->next
		symbFreeOvlCallArg( list, arg )
		arg = nxt
	loop

end sub

