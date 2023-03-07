'' symbol table module for procedures
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "ast.bi"

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' init
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbProcInit( )

	symb.globctorlist.head = NULL
	symb.globctorlist.tail = NULL
	listInit( @symb.globctorlist.list, 8, len( FB_GLOBCTORLIST_ITEM ), LIST_FLAGS_NOCLEAR )

	symb.globdtorlist.head = NULL
	symb.globdtorlist.tail = NULL
	listInit( @symb.globdtorlist.list, 8, len( FB_GLOBCTORLIST_ITEM ), LIST_FLAGS_NOCLEAR )

end sub

'':::::
sub symbProcEnd( )

	listEnd( @symb.globdtorlist.list )
	listEnd( @symb.globctorlist.list )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' add
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

sub symbProcAllocExt( byval proc as FBSYMBOL ptr )
	assert( symbIsProc( proc ) )
	if( proc->proc.ext = NULL ) then
		proc->proc.ext = xcallocate( sizeof( FB_PROCEXT ) )
	end if
end sub

sub symbProcFreeExt( byval proc as FBSYMBOL ptr )
	if( proc->proc.ext ) then
		deallocate( proc->proc.ext )
		proc->proc.ext = NULL
	end if
end sub

function symbProcReturnsOnStack( byval proc as FBSYMBOL ptr ) as integer
	assert( symbIsProc( proc ) )

	'' BYREF result never is on stack, instead it's always a pointer,
	'' which will always be returned in registers
	if( symbIsReturnByRef( proc ) ) then
		exit function
	end if

	'' UDT result?
	if( symbGetType( proc ) = FB_DATATYPE_STRUCT ) then
		'' Real type is an UDT pointer (instead of INTEGER/LONGINT)?
		'' Then it's returned on stack (instead of in registers)

		'' was structure calculated to return in registers?
		'' - (gas64, calculated in hGetReturnTypeGas64Linux() )
		'' !!!TODO!!! - we probably need to check other ABI's too
		'' since they aren't all the same depending on target platform
		if( (proc->subtype <> NULL) andalso (proc->subtype->udt.retin2regs <> FB_STRUCT_NONE) ) then
			exit function
		end if

		function = (typeGetDtAndPtrOnly( symbGetProcRealType( proc ) ) = typeAddrOf( FB_DATATYPE_STRUCT ))
	end if
end function

private function hAlignToPow2 _
	( _
		byval value as longint, _
		byval align as integer _
	) as longint
	function = (value + (align-1)) and (not (align-1))
end function

function symbCalcArgLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as integer _
	) as longint

	select case( mode )
	case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
		return env.pointersize
	end select

	'' BYVAL/VARARG

	'' Byval non-trivial type? Implicitly passing a copy Byref.
	if( typeIsTrivial( dtype, subtype ) = FALSE ) then
		return env.pointersize
	end if

	function = hAlignToPow2( symbCalcLen( dtype, subtype ), env.pointersize )
end function

function symbCalcParamLen _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as FB_PARAMMODE _
	) as longint

	'' VARARG params have 0 length for now,
	'' only the VARARG args later have > 0 length...
	if( mode = FB_PARAMMODE_VARARG ) then
		function = 0
	else
		function = symbCalcArgLen( dtype, subtype, mode )
	end if

end function

'' Calculate the N for the @N stdcall suffix
function symbProcCalcStdcallSuffixN( byval proc as FBSYMBOL ptr ) as longint
	'' Calculate the sum of the on-stack sizes of all "normal" parameters,
	'' - ignoring any vararg param,
	'' - including THIS param,
	'' - excluding the hidden struct result param, if any
	'' - including sizeof(UDT) instead of sizeof(ptr) for Byval non-trivial
	''   UDT parameters, even though they are implicitly passed as pointer;
	''   following gcc's and MSVC's behaviour.
	''   The same should be done for our Byval Strings.

	dim as longint length = 0

	var param = symbGetProcHeadParam( proc )
	while( param )

		if( (symbGetParamMode( param ) = FB_PARAMMODE_BYVAL) and _
		    (not typeIsTrivial( param->typ, param->subtype )) ) then
			'' Byval non-trivial UDT parameters are an exception:
			'' Their size on stack is sizeof(ptr), but we want to
			'' add sizeof(UDT) to the @N suffix.
			length += symbCalcLen( param->typ, param->subtype )
		else
			'' Use param's size on stack
			'' VARARG params have 0 (unknown) length; they do not affect the sum.
			length += symbGetLen( param )
		end if

		param = param->next
	wend

	function = length
end function

'' Calculate the number of bytes the procedure needs to pop from stack when returning
function symbProcCalcBytesToPop( byval proc as FBSYMBOL ptr ) as longint
	dim as longint bytestopop = 0
	dim callee_cleanup as integer = FALSE

	assert( iif( (symbGetProcMode( proc ) = FB_FUNCMODE_THISCALL), _
		(env.clopt.backend = FB_BACKEND_GAS) and _
		(fbIs64bit( ) = FALSE) and _
		(fbGetCpuFamily( ) = FB_CPUFAMILY_X86), _
		TRUE ) )

	'' Need to pop parameters in case of thiscall/fastcall on win32, but not any other target
	select case symbGetProcMode( proc )
	case FB_FUNCMODE_THISCALL, FB_FUNCMODE_FASTCALL

		'' should never get here if "-z no-thiscall" is active
		assert( iif( symbGetProcMode( proc ) = FB_FUNCMODE_THISCALL, env.clopt.nothiscall = FALSE, TRUE ) )
		'' should never get here if "-z no-fastcall" is active
		assert( iif( symbGetProcMode( proc ) = FB_FUNCMODE_FASTCALL, env.clopt.nofastcall = FALSE, TRUE ) )

		if( fbIs64bit( ) = FALSE ) then
			if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
				callee_cleanup = TRUE
			end if
		end if

	'' Need to pop parameters in case of stdcall/pascal, but not for cdecl
	case else
		callee_cleanup = (symbGetProcMode( proc ) <> FB_FUNCMODE_CDECL)

	end select

	if( callee_cleanup ) then
		var param = symbGetProcHeadParam( proc )
		while( param )
			'' not in a register? then accumulate bytes passed on stack.
			if( param->param.regnum = 0 ) then
				'' Param symbols store their size on stack as their length.
				'' VARARG params have 0 (unknown) length; they do not affect the sum.
				bytestopop += symbGetLen( param )
			end if
			param = param->next
		wend
	end if

	'' Additionally pop the hidden struct result ptr param (if any) for stdcall/pascal,
	'' or even for cdecl if needed for the target.
	if( symbProcReturnsOnStack( proc ) ) then
		if( callee_cleanup or ((env.target.options and FB_TARGETOPT_CALLEEPOPSHIDDENPTR) <> 0) ) then
			bytestopop += env.pointersize
		end if
	end if

	function = bytestopop
end function

'':::::
function symbAddProcParam _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval dimensions as integer, _
		byval mode as integer, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr param = any

	function = NULL

	assert( (dimensions <> 0) = (mode = FB_PARAMMODE_BYDESC) )

	param = symbNewSymbol( FB_SYMBOPT_PRESERVECASE, NULL, _
	                       @proc->proc.paramtb, NULL, _
	                       FB_SYMBCLASS_PARAM, _
	                       id, NULL, dtype, subtype, attrib, FB_PROCATTRIB_NONE )
	if( param = NULL ) then
		exit function
	end if

	proc->proc.params += 1

	param->lgt = symbCalcParamLen( dtype, subtype, mode )

	'' assume that we won't pass parameter in a register
	'' this will be set later by hSetupProcRegisterParameters()
	param->param.regnum = 0

	param->param.mode = mode
	param->param.optexpr = NULL
	param->param.bydescdimensions = dimensions
	if( mode = FB_PARAMMODE_BYDESC ) then
		param->param.bydescrealsubtype = symbAddArrayDescriptorType( dimensions, dtype, subtype )
	else
		param->param.bydescrealsubtype = NULL
	end if

	'' for UDTs, check if not including a byval param to self
	if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
		if( mode = FB_PARAMMODE_BYVAL ) then
			if( symbIsParentNamespace( dtype, subtype ) ) then
				symbSetUdtHasRecByvalParam( subtype )
			end if
		end if
	end if

	function = param
end function

sub symbMakeParamOptional _
	( _
		byval proc as FBSYMBOL ptr, _
		byval param as FBSYMBOL ptr, _
		byval optexpr as ASTNODE ptr _
	)

	assert( symbIsProc( proc ) )
	assert( param->class = FB_SYMBCLASS_PARAM )

	if( optexpr = NULL ) then
		exit sub
	end if

	param->param.optexpr = optexpr
	proc->proc.optparams += 1

end sub

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

sub symbProcRecalcRealType( byval proc as FBSYMBOL ptr )
	dim as integer dtype = any
	dim as FBSYMBOL ptr subtype = any

	dtype = symbGetFullType( proc )
	subtype = symbGetSubtype( proc )

	if( symbIsReturnByRef( proc ) ) then
		dtype = typeAddrOf( dtype )
	end if

	select case( typeGetDtAndPtrOnly( dtype ) )
	'' string?
	case FB_DATATYPE_STRING, FB_DATATYPE_WCHAR
		'' It's actually a pointer to a string descriptor,
		'' or in case of wstring, a pointer to a wchar buffer.
		dtype = typeAddrOf( dtype )

	'' UDT? follow GCC 3.x's ABI
	case FB_DATATYPE_STRUCT
		'' still parsing the struct or any inner type? patch it later..
		if( symbIsParentNamespace( dtype, subtype ) ) then
			symbSetUdtHasRecByvalRes( subtype )
		else
			dtype = symbGetUDTRetType( subtype )

			'' symbStructEnd() should have set it by now, but there
			'' could be problems if symbUdtDeclareDefaultMembers()
			'' calls this before that.
			assert( dtype <> FB_DATATYPE_INVALID )

			'' If it became an integer or float, forget the subtype,
			'' that should only be preserved for UDTs and UDT ptrs.
			if( typeGetDtOnly( dtype ) <> FB_DATATYPE_STRUCT ) then
				subtype = NULL
			end if
		end if

	end select

	proc->proc.realdtype   = dtype
	proc->proc.realsubtype = subtype
end sub

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

private function hCanOverloadBydesc _
	( _
		byval a as FBSYMBOL ptr, _
		byval b as FBSYMBOL ptr _
	) as integer

	function = FALSE

	'' Any BYDESC?
	if( (a->param.mode = FB_PARAMMODE_BYDESC) or _
	    (b->param.mode = FB_PARAMMODE_BYDESC) ) then
		'' Both BYDESC?
		if( (a->param.mode = FB_PARAMMODE_BYDESC) and _
		    (b->param.mode = FB_PARAMMODE_BYDESC) ) then
			'' No unknown dimensions?
			if( (a->param.bydescdimensions > 0) and _
			    (b->param.bydescdimensions > 0) ) then
				'' Different dimension count?
				function = (a->param.bydescdimensions <> b->param.bydescdimensions)
			end if
		else
			'' Only one is BYDESC; can allow the overload
			function = TRUE
		end if
	end if

end function

private function hAddOvlProc _
	( _
		byval proc as FBSYMBOL ptr, _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval symtb as FBSYMBOLTB ptr, _
		byval hashtb as FBHASHTB ptr, _
		byval id as const zstring ptr, _
		byval id_alias as const zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB, _
		byval preservecase as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr ovl = any, ovl_param = any, param = any
	dim as integer ovl_params = any, params = any

	function = NULL

	if( ovl_head_proc = NULL ) then
		exit function
	end if

	'' only one them is a property?
	if( ((pattrib and FB_PROCATTRIB_PROPERTY) <> 0) <> symbIsProperty( ovl_head_proc ) ) then
		exit function
	end if

	'' not arg-less?
	params = symbGetProcParams( proc )
	if( (pattrib and FB_PROCATTRIB_METHOD) <> 0 ) then
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
		if( (pattrib and FB_PROCATTRIB_PROPERTY) <> 0 ) then
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
			'' (note: cycling backwards, starting with the tail param,
			'' because a THIS instance param may have been removed from
			'' the ovl_params count above)
			param = symbGetProcTailParam( proc )
			ovl_param = symbGetProcTailParam( ovl )

			do
				'' We can allow overloads to have a param with the same dtype,
				'' where one is BYDESC and the other is BYREF/BYVAL, because the
				'' overload resolution can disambiguate based on whether an array
				'' was given or not.
				''
				'' If both are BYDESC though, then it depends on the dimension count
				'' and/or on the dtype. We can allow the overload if the two array
				'' parameters have different dimension counts, because the overload
				'' resolution can disambiguate based on that. But we can't allow
				'' overloading if there's a '()' array involved (unknown dimensions),
				'' because then the overload resolution wouldn't know which one to use.
				''
				'' If both overloads are BYREF/BYVAL though, then only the dtype
				'' matters.

				if( hCanOverloadBydesc( param, ovl_param ) ) then
					exit do
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
					exit do
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

	'' add the new proc symbol, w/o adding it to the hash table
	proc = symbNewSymbol( iif( preservecase, FB_SYMBOPT_PRESERVECASE, FB_SYMBOPT_NONE ), _
	                      proc, symtb, hashtb, FB_SYMBCLASS_PROC, id, id_alias, dtype, subtype, attrib, pattrib )
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
		byval id_alias as const zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr ovl = any

	'' if it's not the type casting op, overloaded as an ordinary proc
	if( op <> AST_OP_CAST ) then
		return hAddOvlProc( proc, ovl_head_proc, symtb, hashtb, NULL, id_alias, _
		                    dtype, subtype, attrib, pattrib, FALSE )
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

	'' add it
	proc = symbNewSymbol( FB_SYMBOPT_NONE, proc, symtb, hashtb, _
	                      FB_SYMBCLASS_PROC, NULL, id_alias, dtype, subtype, attrib, pattrib )

	'' there's no id so it can't be added to the chain list

	function = proc

end function

private sub hSetupProcRegisterParameters _
	( _
		byval proc as FBSYMBOL ptr _
	)

	assert( proc <> NULL )
	dim regnum as integer = 1
	dim maxregnum as integer = 0

	select case proc->proc.mode
	case FB_FUNCMODE_THISCALL
		'' should never get here if "-z no-thiscall" is active
		assert( env.clopt.nothiscall = FALSE )
		maxregnum = 1
	case FB_FUNCMODE_FASTCALL
		'' should never get here if "-z no-fastcall" is active
		assert( env.clopt.nofastcall = FALSE )
		maxregnum = 2
	end select

	if( maxregnum > 0 ) then
		'' pass the first integer sized argument in ECX
		'' pass the second integer size argument in EDX

		'' Allow:
		''   - instance params
		''   - pointers
		''   - integers where (symbGetLen() <= env.pointersize)
		''   - byref parameters

		var param = symbGetProcHeadParam( proc )

		if( symbIsInstanceParam( param ) ) then
			'' pass argument in ECX register
			param->param.regnum = regnum
			regnum += 1
			param = symbGetParamNext( param )
		end if

		while( (param <> NULL) and (regnum <= maxregnum) )
			if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
				param->param.regnum = regnum
				regnum += 1
			elseif( typeGetClass( symbGetType( param ) ) = FB_DATACLASS_INTEGER ) then
				if( symbGetLen( param ) <= env.pointersize ) then
					'' pass argument in ECX/EDX register
					param->param.regnum = regnum
					regnum += 1
				end if
			end if
			param = symbGetParamNext( param )
		wend

	end if

end sub

private function hSetupProc _
	( _
		byval sym as FBSYMBOL ptr, _
		byval parent as FBSYMBOL ptr, _
		byval symtb as FBSYMBOLTB ptr, _
		byval hashtb as FBHASHTB ptr, _
		byval id as const zstring ptr, _
		byval id_alias as const zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr

	dim as integer stats = any, preserve_case = any, lookupoptions = any
	dim as FBSYMBOL ptr proc = any, head_proc = any, overridden = any

	function = NULL

#if __FB_DEBUG__
	'' Member procs generally must have either STATIC or METHOD attributes,
	'' and cannot have both, but there can be proc symbols added to an
	'' UDT namespace that have neither, for example proc symbols backing
	'' procptrs or the dtor call wrapper procs created for static vars
	'' declared inside methods.
	if( pattrib and FB_PROCATTRIB_METHOD ) then
		assert( (attrib and FB_SYMBATTRIB_STATIC) = 0 )
		assert( symbIsStruct( parent ) )
	elseif( attrib and FB_SYMBATTRIB_STATIC ) then
		assert( (pattrib and FB_PROCATTRIB_METHOD) = 0 )
		assert( symbIsStruct( parent ) )
	end if
#endif

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

	head_proc = NULL

	'' ctor/dtor?
	if( (pattrib and (FB_PROCATTRIB_CONSTRUCTOR or _
	                  FB_PROCATTRIB_DESTRUCTOR1 or FB_PROCATTRIB_DESTRUCTOR0)) <> 0 ) then

		assert( pattrib and FB_PROCATTRIB_METHOD )

		'' ctors/dtors don't have THIS CONSTness, disable the checks
		'' We can't just rely on the ctor/dtor flags for this because those
		'' can't be propagated to procptrs currently (e.g. here we assume any
		'' PROC with these flags is a proper proc, not a procptr)
		pattrib or= FB_PROCATTRIB_NOTHISCONSTNESS

		'' ctor?
		if( (pattrib and FB_PROCATTRIB_CONSTRUCTOR) <> 0 ) then
			head_proc = symbGetCompCtorHead( parent )
		elseif( (pattrib and FB_PROCATTRIB_DESTRUCTOR1) <> 0 ) then
			head_proc = symbGetCompDtor1( parent )
		else
			head_proc = symbGetCompDtor0( parent )
		end if

		'' not overloaded yet? just add it
		if( head_proc = NULL ) then
			proc = symbNewSymbol( FB_SYMBOPT_NONE, sym, symtb, hashtb, _
			                      FB_SYMBCLASS_PROC, NULL, id_alias, _
			                      FB_DATATYPE_VOID, NULL, attrib, pattrib )

			'' ctor?
			if( (pattrib and FB_PROCATTRIB_CONSTRUCTOR) <> 0 ) then
				symbSetCompCtorHead( parent, proc )

			'' complete dtor?
			elseif( (pattrib and FB_PROCATTRIB_DESTRUCTOR1) <> 0 ) then
				symbSetCompDtor1( parent, proc )

			'' deleting dtor
			else
				symbSetCompDtor0( parent, proc )
			end if
		'' otherwise, try to overload
		else
			'' dtor?
			if( (pattrib and (FB_PROCATTRIB_DESTRUCTOR1 or FB_PROCATTRIB_DESTRUCTOR0)) <> 0 ) then
				'' can't overload
				return NULL
			end if

			proc = hAddOvlProc( sym, head_proc, symtb, hashtb, NULL, id_alias, _
			                    FB_DATATYPE_VOID, NULL, attrib, pattrib, FALSE )
			if( proc = NULL ) then
				exit function
			end if
		end if

		'' ctor? check for special ctors..
		if( (pattrib and FB_PROCATTRIB_CONSTRUCTOR) <> 0 ) then
			symbCheckCompCtor( parent, proc )
		end if

	'' operator?
	elseif( (pattrib and FB_PROCATTRIB_OPERATOR) <> 0 ) then

		'' op not set? (because error recovery)
		if( sym->proc.ext = NULL ) then
			goto add_proc
		end if

		dim as AST_OP op

		op = symbGetProcOpOvl( sym )

		head_proc = symbGetCompOpOvlHead( parent, op )

		'' not overloaded yet? just add it
		if( head_proc = NULL ) then
			proc = symbNewSymbol( FB_SYMBOPT_NONE, sym, symtb, hashtb, _
			                      FB_SYMBCLASS_PROC, NULL, id_alias, _
			                      dtype, subtype, attrib, pattrib )

			symbSetCompOpOvlHead( parent, proc )

		'' otherwise, try to overload
		else
			proc = hAddOpOvlProc( sym, head_proc, symtb, hashtb, op, id_alias, _
			                      dtype, subtype, attrib, pattrib )
			if( proc = NULL ) then
				exit function
			end if

			'' assign? could be a clone..
			if( op = AST_OP_ASSIGN ) then
				symbCheckCompLetOp( parent, proc )
			end if
		end if

	'' ordinary proc..
	else
add_proc:

		preserve_case = (options and FB_SYMBOPT_PRESERVECASE) <> 0

		proc = symbNewSymbol( options or FB_SYMBOPT_DOHASH, sym, symtb, hashtb, _
		                      FB_SYMBCLASS_PROC, id, id_alias, dtype, subtype, attrib, pattrib )

		'' dup def?
		if( proc = NULL ) then
			'' is the dup a proc symbol?
			head_proc = symbLookupByNameAndClass( parent, id, FB_SYMBCLASS_PROC, preserve_case, FALSE )
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
			proc = hAddOvlProc( sym, head_proc, symtb, hashtb, id, id_alias, _
			                    dtype, subtype, attrib, pattrib, preserve_case )
			if( proc = NULL ) then
				exit function
			end if

			proc->pattrib or= FB_PROCATTRIB_OVERLOADED

		else
			'' only if not the RTL
			if( (options and FB_SYMBOPT_RTL) = 0 ) then
				'' check overloading
				if( (pattrib and FB_PROCATTRIB_OVERLOADED) <> 0 ) then
					if( hCanOverload( sym ) = FALSE ) then
						exit function
					end if

				elseif( fbLangOptIsSet( FB_LANG_OPT_ALWAYSOVL ) ) then
					if( hCanOverload( sym ) ) then
						proc->pattrib or= FB_PROCATTRIB_OVERLOADED
					end if
				end if
			end if
		end if

	end if

	if( (options and FB_SYMBOPT_RTL) <> 0 ) then
		stats or= FB_SYMBSTATS_RTL
	end if

	''
	proc->proc.mode = mode

	'' last compound was an EXTERN?
	if( fbGetCompStmtId( ) = FB_TK_EXTERN ) then
		'' don't add parent when mangling, even if inside an UDT, unless
		'' it's in "c++" mode or "rtlib" mode
		if(( parser.mangling <> FB_MANGLING_CPP ) and ( parser.mangling <> FB_MANGLING_RTLIB )) then
			stats or= FB_SYMBSTATS_EXCLPARENT
		end if
	end if

	symbProcRecalcRealType( proc )

	if( (options and FB_SYMBOPT_DECLARING) <> 0 ) then
		stats or= FB_SYMBSTATS_DECLARED
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

	'' Adding method to UDT?
	if( symbIsMethod( proc ) ) then
		assert( symbIsStruct( parent ) )

		'' Adding an ABSTRACT? Increase ABSTRACT count
		if( symbIsAbstract( proc ) ) then
			parent->udt.ext->abstractcount += 1
		end if

		'' Only check if this really is a derived UDT
		overridden = NULL
		if( parent->udt.base ) then
			'' Destructor?
			if( symbIsDestructor1( proc ) ) then
				'' There can always only be one complete dtor, so there is no
				'' need to do a lookup and/or overload checks.
				overridden = symbGetCompDtor1( parent->udt.base->subtype )
			elseif( symbIsDestructor0( proc ) ) then
				'' There can always only be deleting dtor, so there is no
				'' need to do a lookup and/or overload checks.
				overridden = symbGetCompDtor0( parent->udt.base->subtype )
			elseif( symbIsOperator( proc ) ) then
				'' Get the corresponding operator from the base
				'' (actually a chain of overloads for that particular operator)
				overridden = symbGetCompOpOvlHead( parent->udt.base->subtype, _
				                                   symbGetProcOpOvl( proc ) )

				'' Find the overload with the exact same signature
				overridden = symbFindOpOvlProc( symbGetProcOpOvl( proc ), overridden, proc )
			elseif( id ) then
				'' If this method has the same id and signature as
				'' a virtual derived from some base, it overrides that
				'' virtual, by being assigned the same vtable index.

				'' Find a method in the base with the same name
				overridden = symbLookupByNameAndClass( _
					parent->udt.base->subtype, _
					id, FB_SYMBCLASS_PROC, _
					((options and FB_SYMBOPT_PRESERVECASE) <> 0), _
					TRUE )  '' search NSIMPORTs (bases)

				'' Property getters need this special flag to be looked up
				lookupoptions = 0
				if( symbIsProperty( proc ) ) then
					'' Not a sub?
					if( symbGetType( proc ) <> FB_DATATYPE_VOID ) then
						'' then it's a getter
						lookupoptions = FB_SYMBFINDOPT_PROPGET
					end if
				end if

				'' Find the overload with the exact same signature
				overridden = symbFindOverloadProc( overridden, proc, lookupoptions )
			end if

			'' Found anything?
			if( overridden ) then
				'' Only override if the found overload really is a virtual
				if( symbIsVirtual( overridden ) = FALSE ) then
					overridden = NULL
				end if
			end if
		end if

		if( overridden ) then
			'' Overriding an ABSTRACT? Decrease ABSTRACT count
			if( symbIsAbstract( overridden ) ) then
				parent->udt.ext->abstractcount -= 1
			end if

			'' Use the same vtable slot as the virtual that's being overridden
			symbProcSetVtableIndex( proc, symbProcGetVtableIndex( overridden ) )
			proc->proc.ext->overridden = overridden
		else
			'' Allocate a *new* vtable slot, but only if this is a virtual,
			'' and it didn't override anything (thus doesn't reuse a vtable slot).
			if( symbIsVirtual( proc ) ) then
				symbProcSetVtableIndex( proc, symbCompAddVirtual( parent ) )
			end if
		end if
	end if

	hSetupProcRegisterParameters( proc )

	function = proc
end function

function symbAddProc _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id as const zstring ptr, _
		byval id_alias as const zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr parent = any
	dim as FBSYMBOLTB ptr symtb = any
	dim as FBHASHTB ptr hashtb = any

	'' Procedure prototypes are always added to the current namespace,
	'' the current scope is ignored here -- they're not allowed inside
	'' scopes anyways.
	parent = symbGetCurrentNamespc( )
	symtb = @symbGetCompSymbTb( parent )
	hashtb = @symbGetCompHashTb( parent )

	'' Procedures are always "globals", assuming that local/nested
	'' procedures aren't allowed
	attrib or= FB_SYMBATTRIB_SHARED
	assert( (proc->attrib and FB_SYMBATTRIB_LOCAL) = 0 )
	assert( (attrib and FB_SYMBATTRIB_LOCAL) = 0 )

	function = hSetupProc( proc, parent, symtb, hashtb, id, id_alias, _
	                       dtype, subtype, attrib, pattrib, mode, options )

end function

function symbAddOperator _
	( _
		byval proc as FBSYMBOL ptr, _
		byval op as AST_OP, _
		byval id_alias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

	symbProcAllocExt( proc )
	proc->proc.ext->opovl.op = op

	sym = symbAddProc( proc, NULL, id_alias, dtype, subtype, attrib, pattrib, mode, options )
	if( sym = NULL ) then
		symbProcFreeExt( proc )
		exit function
	end if

	function = sym
end function

function symbAddCtor _
	( _
		byval proc as FBSYMBOL ptr, _
		byval id_alias as zstring ptr, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB, _
		byval mode as integer, _
		byval options as FB_SYMBOPT _
	) as FBSYMBOL ptr
	function = symbAddProc( proc, NULL, id_alias, FB_DATATYPE_VOID, NULL, attrib, pattrib, mode, options )
end function

function symbLookupInternallyMangledSubtype _
	( _
		byval id as zstring ptr, _
		byval proc as FBSYMBOL ptr, _
		byref attrib as FB_SYMBATTRIB, _
		byref pattrib as FB_PROCATTRIB, _
		byref parent as FBSYMBOL ptr, _
		byref symtb as FBSYMBOLTB ptr, _
		byref hashtb as FBHASHTB ptr _
	) as FBSYMBOL ptr

	dim as FBSYMCHAIN ptr chain_ = any

	if( (parser.scope = FB_MAINSCOPE) or (symbGetCurrentNamespc( ) = @symbGetGlobalNamespc( )) ) then
		'' When outside scopes, it's a global, because whichever symbol
		'' uses this procptr proto/descriptor type can be globally
		'' visible (global vars, procs, etc.)
		parent = @symbGetGlobalNamespc( )
		symtb = @symbGetCompSymbTb( parent )
		hashtb = @symbGetCompHashTb( parent )

		attrib or= FB_SYMBATTRIB_SHARED
		assert( (attrib and FB_SYMBATTRIB_LOCAL) = 0 )
	else
		'' If inside a scope, make the procptr proto/descriptor type
		'' local too, because it could use local symbols, while it
		'' itself can only be used by local symbols, not by globals
		'' (globals cannot be declared inside scopes).
		parent = symbGetCurrentNamespc( )
		symtb = symb.symtb                    '' symtb of current scope
		hashtb = @symbGetCompHashTb( parent ) '' hashtb of current namespace
		assert( hashtb = symb.hashtb )

		attrib or= FB_SYMBATTRIB_LOCAL
		assert( (attrib and FB_SYMBATTRIB_SHARED) = 0 )
	end if

	'' already exists? (it's ok to use LookupAt, literal str's are always
	'' prefixed with {fbsc}, there will be no clashes with func ptr mangled names)
	chain_ = symbLookupAt( parent, id, TRUE, FALSE )
	if( chain_ <> NULL ) then

		'' not a procedure pointer, return the first symbol
		if( proc = NULL ) then
			return chain_->sym
		end if

		'' for procedure pointers, the parameters types are encoded in the
		'' mangled name, but the optional parameters are stored with the
		'' procedure declaration.  Search all symbols in the chain to check
		'' if there is match on number / position of optional parameters.

		do
			dim as FBSYMBOL ptr sym = chain_->sym
			dim as FBSYMBOL ptr lookup_param = any
			dim as FBSYMBOL ptr proc_param = any
			do
				lookup_param = symbGetProcHeadParam( sym )
				proc_param = symbGetProcHeadParam( proc )
				while( (lookup_param <> NULL) and (proc_param <> NULL) )
					if astIsEqualParamInit( symbGetParamOptExpr( lookup_param ), symbGetParamOptExpr( proc_param ) ) = FALSE then
						exit while
					end if
					lookup_param = symbGetParamNext( lookup_param )
					proc_param = symbGetParamNext( proc_param )
				wend

				'' no differences? return the symbol
				if( (lookup_param = NULL) and (proc_param = NULL) ) then
					return sym
				end if

				sym = sym->hash.next
			loop while( sym )

			chain_ = symbChainGetNext( chain_ )
		loop while( chain_ )
	end if

	'' not found - or has different combination of optional parameters
	return NULL
end function

function symbAddProcPtr _
	( _
		byval proc as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB, _
		byval mode as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any, parent = any
	dim as FBSYMBOLTB ptr symtb = any
	dim as FBHASHTB ptr hashtb = any
	dim as string id

	''
	'' The procptr prototypes are mangled, allowing them to be re-used.
	''
	'' This must be done in order to make equal procptrs use the same proto
	'' symbol for their subtype, because we're doing type equality checks
	'' via "dtype = dtype" and "subtype = subtype". There is no special
	'' equality check for procptrs, hence this mangling must ensure that
	'' equal procptrs re-use the same proto symbols.
	''
	'' New procptr PROC symbols should be added to the current scope,
	'' because they themselves may reference symbols from the current scope,
	'' e.g. UDTs used in parameters/result type. It wouldn't be safe to
	'' add them to the global namespace in this case, because the symbols
	'' in a scope do not live as long as those from the global namespace.
	''
	'' Besides that, the mangling below doesn't differentiate between two
	'' UDTs with the same name but from different scopes, so it may produce
	'' the same mangled id for two procptrs that have different type. This
	'' also requires them to be scoped locally.
	''

	'' Add information to the prototype so we can pass the PROC subtype to
	'' C++ mangling functions directly (instead of having to encode
	'' parameters & function result manually).
	proc->attrib or= attrib
	proc->pattrib or= pattrib

	assert( proc->typ = FB_DATATYPE_INVALID )
	proc->typ = dtype
	proc->subtype = subtype

	id = "{fbfp}"

	'' Must encode the parameter/function result mode & dtype uniquely
	'' - Cannot just encoded hex( param->typ ) because a BYVAL parameter
	''   that is CONST is the same type as a non-CONST BYVAL parameter; to
	''   achieve this they must be encoded the same.
	'' - Cannot just encode hex( param->subtype ) because if it's
	''   a forward reference symbol it may be removed, the encoded
	''   address may then be that of another symbol.
	'' - UDT namespace must be encoded, because UDT name itself is
	''   not enough (same UDT may exist in separate namespaces)
	'' - Bydesc dimensions must be encoded
	'' - BYVAL/BYREF function result and its CONSTness (even if BYVAL, as
	''   with C++ mangling)
	symbMangleType( id, FB_DATATYPE_FUNCTION, proc )
	symbMangleResetAbbrev( )

	'' Calling convention, must be encoded manually as it's not encoded in
	'' the C++ mangling. We want function pointers with different calling
	'' conventions to be seen as different types though, even though that's
	'' not encoded in the C++ mangling, as with g++/clang++.
	id += "$"
	id += hex( mode )

	sym = symbLookupInternallyMangledSubtype( id, proc, attrib, pattrib, parent, symtb, hashtb )
	if( sym ) then
		return sym
	end if

	'' create a new prototype
	sym = hSetupProc( proc, parent, symtb, hashtb, id, symbUniqueId( ), _
	                  dtype, subtype, attrib, pattrib, mode, _
	                  FB_SYMBOPT_DECLARING or FB_SYMBOPT_PRESERVECASE or FB_SYMBOPT_NODUPCHECK )

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
		var p = symbAddProcParam( proc, NULL, param->typ, param->subtype, _
		                          param->param.bydescdimensions, param->param.mode, param->attrib, param->pattrib )

		if( symbGetDontInit( param ) ) then
			symbSetDontInit( p )
		end if

		symbMakeParamOptional( proc, p, param->param.optexpr )

		param = param->next
	loop

	'' attribs to copy from the proc to the procptr
	'' (anything needed for procptr call checking)

	var attribmask = FB_SYMBATTRIB_CONST '' THIS CONSTness, needed for symbCalcProcMatch() type checking

	var pattribmask = FB_PROCATTRIB_RETURNBYREF '' return byref
	pattribmask or = FB_PROCATTRIB_NOTHISCONSTNESS '' method call THIS CONSTness checking

	function = _
		symbAddProcPtr( proc, _
			symbGetFullType( base_proc ), symbGetSubtype( base_proc ), _
			base_proc->attrib and attribmask, base_proc->pattrib and pattribmask, _
			symbGetProcMode( base_proc ) )

end function

function symbPreAddProc( byval symbol as zstring ptr ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr proc = any

	proc = listNewNode( @symb.symlist )

	proc->class = FB_SYMBCLASS_PROC
	proc->attrib = FB_SYMBATTRIB_NONE
	proc->pattrib = FB_PROCATTRIB_NONE
	proc->stats = 0
	proc->id.name = symbol
	proc->id.alias = NULL
	proc->id.mangled = NULL
	proc->typ = FB_DATATYPE_INVALID
	proc->subtype = NULL
	proc->scope = 0
	proc->mangling = FB_MANGLING_BASIC
	proc->lgt = 0
	proc->ofs = 0

	proc->proc.params = 0
	proc->proc.optparams = 0
	symbSymbTbInit( proc->proc.paramtb, proc )
	proc->proc.mode = env.target.fbcall
	proc->proc.realdtype = FB_DATATYPE_INVALID
	proc->proc.realsubtype = NULL
	proc->proc.returnMethod = FB_RETURN_FPU
	proc->proc.rtl.callback = NULL
	proc->proc.ovl.minparams = 0
	proc->proc.ovl.maxparams = 0
	proc->proc.ovl.next = NULL
	proc->proc.ext = NULL

	'' to allow getNamespace() and GetParent() to work
	proc->symtb = @symbGetCompSymbTb( symbGetCurrentNamespc( ) )
	proc->hash.tb = @symbGetCompHashTb( symbGetCurrentNamespc( ) )
	proc->hash.item = NULL
	proc->hash.index = 0
	proc->hash.prev = NULL
	proc->hash.next = NULL

	proc->parent = NULL
	proc->prev = NULL
	proc->next = NULL

	function = proc
end function

sub symbGetRealParamDtype overload _
	( _
		byval parammode as integer, _
		byval bydescrealsubtype as FBSYMBOL ptr, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	)

	select case( parammode )
	case FB_PARAMMODE_BYVAL
		'' Byval non-trivial type? Passed Byref implicitly.
		if( typeIsTrivial( dtype, subtype ) = FALSE ) then
			dtype = typeAddrOf( dtype )
		end if

	case FB_PARAMMODE_BYREF
		dtype = typeAddrOf( dtype )

	case FB_PARAMMODE_BYDESC
		dtype = typeAddrOf( FB_DATATYPE_STRUCT )
		assert( symbIsDescriptor( bydescrealsubtype ) )
		subtype = bydescrealsubtype
	end select

end sub

sub symbGetRealParamDtype overload _
	( _
		byval param as FBSYMBOL ptr, _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	)

	assert( param->class = FB_SYMBCLASS_PARAM )

	dtype = symbGetFullType( param )
	subtype = param->subtype

	symbGetRealParamDtype( param->param.mode, param->param.bydescrealsubtype, dtype, subtype )

end sub

function symbAddVarForParam( byval param as FBSYMBOL ptr ) as FBSYMBOL ptr
	dim as FBARRAYDIM dTB(0) = any
	dim as FBSYMBOL ptr s = any
	dim as integer attrib = any, dtype = any, dimensions = any

	function = NULL

	dtype = symbGetFullType( param )

	select case as const param->param.mode
	case FB_PARAMMODE_BYVAL
		attrib = FB_SYMBATTRIB_PARAMVARBYVAL

		'' Byval non-trivial type? Passed Byref implicitly.
		if( typeIsTrivial( dtype, param->subtype ) = FALSE ) then
			attrib = FB_SYMBATTRIB_PARAMVARBYREF
		end if

	case FB_PARAMMODE_BYREF
		attrib = FB_SYMBATTRIB_PARAMVARBYREF

	case FB_PARAMMODE_BYDESC
		attrib = FB_SYMBATTRIB_PARAMVARBYDESC

	case else
		exit function
	end select

	'' QB quirk..
	if( symbIsSuffixed( param ) ) then
		attrib or= FB_SYMBATTRIB_SUFFIXED
	end if

	s = symbAddVar( symbGetName( param ), NULL, dtype, param->subtype, 0, param->param.bydescdimensions, dTB(), attrib )
	if( s = NULL ) then
		exit function
	end if

	assert( s->var_.array.desc = NULL )
	assert( s->var_.array.desctype = NULL )
	s->var_.array.desctype = param->param.bydescrealsubtype

	'' declare it or arrays passed by descriptor will be initialized when REDIM'd
	symbSetIsDeclared( s )

	if( symbGetDontInit( param ) ) then
		symbSetDontInit( s )
	end if

	if( param->stats and FB_SYMBSTATS_ARGV ) then
		s->stats or= FB_SYMBSTATS_ARGV
	end if

	function = s
end function

function symbAddVarForProcResultParam( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr
	dim as FBARRAYDIM dTB(0) = any
	dim as FBSYMBOL ptr s = any

	if( symbProcReturnsOnStack( proc ) = FALSE ) then
		return NULL
	end if

	s = symbAddVar( symbUniqueId( ), NULL, FB_DATATYPE_STRUCT, proc->subtype, 0, _
	                0, dTB(), FB_SYMBATTRIB_PARAMVARBYREF, FB_SYMBOPT_PRESERVECASE )

	symbProcAllocExt( proc )
	proc->proc.ext->res = s

	symbSetIsDeclared( s )
	symbSetIsImplicit( s )

	function = s
end function

function symbAddProcResultVar( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr
	dim as FBARRAYDIM dTB(0) = any
	dim as FBSYMBOL ptr res = any
	dim as integer dtype = any
	dim as const zstring ptr id = any

	'' UDT on stack? No local result var needs to be added;
	'' the hidden result param is used instead.
	if( symbProcReturnsOnStack( proc ) ) then
		return symbGetProcResult( proc )
	end if

	dtype = proc->typ

	'' Returning byref? Then the implicit result var is actually a pointer.
	if( symbIsReturnByRef( proc ) ) then
		dtype = typeAddrOf( dtype )
	end if

	res = symbAddVar( @"fb$result", NULL, dtype, proc->subtype, 0, _
	                  0, dTB(), FB_SYMBATTRIB_FUNCRESULT, FB_SYMBOPT_PRESERVECASE )

	symbProcAllocExt( proc )

	proc->proc.ext->res = res

	'' clear up the result
	astAdd( astNewDECL( res, TRUE ) )

	symbSetIsDeclared( res )
	symbSetIsImplicit( res )

	function = res
end function

'':::::
sub symbAddProcInstanceParam _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

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

	symbAddProcParam( proc, FB_INSTANCEPTR, dtype, parent, 0, _
	                  FB_PARAMMODE_BYREF, FB_SYMBATTRIB_INSTANCEPARAM, FB_PROCATTRIB_NONE )
end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookup
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbFindOverloadProc _
	( _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval options as FB_SYMBFINDOPT _
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
			if( (options and FB_SYMBFINDOPT_PROPGET) <> 0 ) then
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
			'' (Note: cycling backwards, ditto)
			ovl_param = symbGetProcTailParam( ovl )
			param = symbGetProcTailParam( proc )
			do
				if( hCanOverloadBydesc( param, ovl_param ) ) then
					exit do
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
	if( symbIsDestructor1( ovl_head_proc ) or symbIsDestructor0( ovl_head_proc ) ) then
		return ovl_head_proc
	else
		return symbFindOverloadProc( ovl_head_proc, proc )
	end if

end function

'':::::
#macro hCheckCtorOvl _
	( _
		param_subtype, _
		arg_expr, _
		arg_mode, _
		options _
	)

	if( (options and FB_SYMBFINDOPT_NO_CTOR) = 0 ) then
		dim as integer err_num = any
		dim as FBSYMBOL ptr proc = any

		proc = symbFindCtorOvlProc( param_subtype, _
		                            arg_expr, _
		                            arg_mode, _
		                            @err_num, _
		                            FB_SYMBFINDOPT_NO_CTOR )

		if( proc <> NULL ) then
			return FB_OVLPROC_HALFMATCH - OvlMatchScore( FB_DATATYPE_STRUCT, 0 )
		end if
	end if
#endmacro

#macro hCheckCastOvlEx _
	( _
		param_mode, _
		param_dtype, _
		param_subtype, _
		arg_expr, _
		options _
	)

	if( (options and FB_SYMBFINDOPT_NO_CAST) = 0 ) then
		dim as integer err_num = any
		dim as FBSYMBOL ptr proc = any

		proc = symbFindCastOvlProc( param_dtype, _
		                            param_subtype, _
		                            arg_expr, _
		                            @err_num, _
		                            options or FB_SYMBFINDOPT_NO_CAST )

		if( proc <> NULL ) then
			'' calculate a new match score based on the CAST() return type rank
			'' we can't keep the FB_OVLPROC_TYPEMATCH and FB_OVLPROC_HALFMATCH
			'' level of match scores because we don't want the score to interfere
			'' with non-cast and non-conversion scores.  Instead, reduce the scores:
			'' FB_OVLPROC_TYPEMATCH => FB_OVLPROC_CASTMATCH
			'' FB_OVLPROC_HALFMATCH => FB_OVLPROC_CONVMATCH

			var match = hCalcTypesDiff( param_dtype, _
			                            param_subtype, _
			                            symbGetPtrCnt( proc ), _
			                            symbGetFullType( proc ), _
			                            symbGetSubType( proc ), _
			                            NULL, _
			                            param_mode )

			if( match >= FB_OVLPROC_TYPEMATCH ) then
				match = match - FB_OVLPROC_TYPEMATCH + FB_OVLPROC_CASTMATCH
			elseif( match >= FB_OVLPROC_HALFMATCH ) then
				match = match - FB_OVLPROC_TYPEMATCH + FB_OVLPROC_CONVMATCH
			else
				match = FB_OVLPROC_CONVMATCH - OvlMatchScore( FB_DATATYPE_STRUCT, 0 )
			end if

			return match
		end if
	end if
#endmacro

'':::::
private function hCalcTypesDiff _
	( _
		byval param_dtype_in as integer, _
		byval param_subtype as FBSYMBOL ptr, _
		byval param_ptrcnt as integer, _
		byval arg_dtype_in as integer, _
		byval arg_subtype as FBSYMBOL ptr, _
		byval arg_expr as ASTNODE ptr, _
		byval mode as FB_PARAMMODE = 0 _
	) as FB_OVLPROC_MATCH_SCORE

	dim as integer arg_dclass = any, param_dt = any, arg_dt = any
	dim as integer param_dtype, arg_dtype

	function = FB_OVLPROC_NO_MATCH

	'' don't take the const qualifier into account

	param_dtype = typeGetDtAndPtrOnly( param_dtype_in )
	arg_dtype = typeGetDtAndPtrOnly( arg_dtype_in )

	arg_dclass = typeGetClass( arg_dtype )

	'' STRING MATCHING
	'' (F=FB_OVLPROC_FULLMATCH, H=FB_OVLPROC_HALFMATCH)
	''
	'' from / to -> string      zstring     zstring ptr wstring     wstring ptr
	'' ------------ ----------- ----------- ----------- ----------- -----------
	'' string       F-0         F-1         F-2         H-3         H-4
	'' zstring      F-2         F-0         F-1         H-3         H-4
	'' zstring ptr  F-2         F-1         F-0         H-3         H-4
	'' wstring      H-2         H-3         H-4         F-0         F-1
	'' wstring ptr  H-2         H-3         H-4         F-1         F-0

	'' check classes
	select case as const typeGetClass( param_dtype )
	'' integer?
	case FB_DATACLASS_INTEGER

		select case as const arg_dclass
		'' another integer..
		case FB_DATACLASS_INTEGER

			'' z/wstring param:
			'' - allow any z/wstring arg, doesn't matter whether
			''   it's a DEREF or not (it can all be treated as string)
			'' - disallow other args (passing BYVAL explicitly
			''   should be handled by caller already)
			select case( param_dtype )
			case FB_DATATYPE_CHAR
				select case( arg_dtype )
				case FB_DATATYPE_CHAR
					'' zstring => zstring
					return FB_OVLPROC_FULLMATCH - OvlMatchScore( 0, 0 )
				case FB_DATATYPE_WCHAR
					'' wstring => zstring
					return FB_OVLPROC_HALFMATCH - OvlMatchScore( 0, 3 )
				end select
				return FB_OVLPROC_NO_MATCH
			case FB_DATATYPE_WCHAR
				select case( arg_dtype )
				case FB_DATATYPE_CHAR
					'' zstring => wstring
					return FB_OVLPROC_HALFMATCH - OvlMatchScore( 0, 3 )
				case FB_DATATYPE_WCHAR
					'' wstring => wstring
					return FB_OVLPROC_FULLMATCH - OvlMatchScore( 0, 0 )
				end select
				return FB_OVLPROC_NO_MATCH

			'' z/wstring ptr params:
			'' - allow z/wstring or z/wstring ptr args, corresponding
			''   to hStrArgToStrPtrParam(), explicitly here
			'' - leave rest to pointer checks below
			case typeAddrOf( FB_DATATYPE_CHAR )
				select case( arg_dtype )
				case FB_DATATYPE_CHAR
					'' zstring => zstring ptr
					return FB_OVLPROC_FULLMATCH - OvlMatchScore( 0, 1 )
				case FB_DATATYPE_WCHAR
					'' wstring => zstring ptr
					return FB_OVLPROC_HALFMATCH - OvlMatchScore( 0, 4 )
				end select
			case typeAddrOf( FB_DATATYPE_WCHAR )
				select case( arg_dtype )
				case FB_DATATYPE_CHAR
					'' zstring => wstring ptr
					return FB_OVLPROC_HALFMATCH - OvlMatchScore( 0, 4 )
				case FB_DATATYPE_WCHAR
					'' wstring => wstring ptr
					return FB_OVLPROC_FULLMATCH - OvlMatchScore( 0, 1 )
				end select

			'' Any other non-z/wstring param from FB_DATACLASS_INTEGER:
			'' - Only allow z/wstring arg if it's a DEREF that can
			''   be treated as integer
			case else
				select case( arg_dtype )
				case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
					if( arg_expr = NULL ) then
						return FB_OVLPROC_NO_MATCH
					end if

					if( astIsDEREF( arg_expr ) = FALSE ) then
						return FB_OVLPROC_NO_MATCH
					end if
				end select
			end select

			'' Remap enums
			if( arg_dtype = FB_DATATYPE_ENUM ) then
				'' enum args can be passed to integer params (as in C++)
				arg_dtype = typeRemap( arg_dtype )
			end if

			'' check pointers..
			if( typeIsPtr( param_dtype ) ) then
				'' isn't arg a pointer too?
				if( typeIsPtr( arg_dtype ) = FALSE ) then
					'' not an expression?
					if( arg_expr = NULL ) then
						return FB_OVLPROC_NO_MATCH
					end if

					'' Allow passing literal 0 (with some non-ptr integer type) to the ptr
					if( astCheckConvNonPtrToPtr( param_dtype, arg_dtype, arg_expr, 0 ) <> FB_ERRMSG_OK ) then
						return FB_OVLPROC_NO_MATCH
					end if

					'' Allow passing a literal 0 integer to a pointer parameter,
					'' but give it a very low score, such that we will prefer passing
					'' the literal 0 integer to actual integer parameters (which are
					'' scored based on FB_OVLPROC_HALFMATCH - symb_dtypeMatchTB...,
					'' which is why we have to choose something that's hopefully lower
					'' but still > FB_OVLPROC_NO_MATCH here).
					return FB_OVLPROC_LOWEST_MATCH
				end if

				'' Any Ptr parameters can accept all pointer arguments, as in C++.
				'' Additionally we also allow Any Ptr arguments to match all
				'' pointer parameters, because we also allow such assignments,
				'' unlike C++.
				if( (param_dtype = typeAddrOf( FB_DATATYPE_VOID )) or _
				    (arg_dtype = typeAddrOf( FB_DATATYPE_VOID )) ) then
					return FB_OVLPROC_HALFMATCH
				end if

				return typeCalcMatch( param_dtype, param_subtype, mode, arg_dtype, arg_subtype )

			elseif( typeIsPtr( arg_dtype ) ) then
				'' Param isn't a pointer, but arg is:
				'' no match -- pointers don't match integers
				return FB_OVLPROC_NO_MATCH
			end if

			return FB_OVLPROC_HALFMATCH - symb_dtypeMatchTB( typeGet( arg_dtype ), typeGet( param_dtype ) )

		'' float? (ok due the auto-coercion, unless it's a pointer)
		case FB_DATACLASS_FPOINT
			if( typeIsPtr( param_dtype ) ) then
				return FB_OVLPROC_NO_MATCH
			end if

			return FB_OVLPROC_HALFMATCH - symb_dtypeMatchTB( typeGet( arg_dtype ), typeGet( param_dtype ) )

		'' string arg to integer param? only if the param is a w|zstring
		'' (treated as strings) or w|zstring ptr (auto string to ptr conversion,
		'' corresponding to hStrArgToStrPtrParam())
		case FB_DATACLASS_STRING
			select case param_dtype
			case FB_DATATYPE_CHAR
				'' string => zstring
				return FB_OVLPROC_FULLMATCH - OvlMatchScore( 0, 1 )
			case typeAddrOf( FB_DATATYPE_CHAR )
				'' string => zstring ptr
				return FB_OVLPROC_FULLMATCH - OvlMatchScore( 0, 2 )
			case FB_DATATYPE_WCHAR
				'' string => wstring
				return FB_OVLPROC_HALFMATCH - OvlMatchScore( 0, 3 )
			case typeAddrOf( FB_DATATYPE_WCHAR )
				'' string => wstring ptr
				return FB_OVLPROC_HALFMATCH - OvlMatchScore( 0, 4 )
			end select

		end select

	'' floating-point?
	case FB_DATACLASS_FPOINT

		select case as const arg_dclass
		'' only accept if it's an integer (but pointers)
		case FB_DATACLASS_INTEGER
			if( typeIsPtr( arg_dtype ) ) then
				return FB_OVLPROC_NO_MATCH
			end if

			if( arg_dtype = FB_DATATYPE_ENUM ) then
				'' enum args can be passed to fpoint params (as in C++)
				arg_dtype = typeRemap( arg_dtype )
			end if

			return FB_OVLPROC_HALFMATCH - symb_dtypeMatchTB( typeGet( arg_dtype ), typeGet( param_dtype ) )

		'' or if another float..
		case FB_DATACLASS_FPOINT
			return FB_OVLPROC_HALFMATCH - symb_dtypeMatchTB( typeGet( arg_dtype ), typeGet( param_dtype ) )

		end select

	'' string?
	case FB_DATACLASS_STRING

		select case arg_dclass
		'' okay if it's a fixed-len string
		case FB_DATACLASS_STRING
			function = FB_OVLPROC_FULLMATCH

		'' integer if it's a z/wstring (no matter whether a
		'' variable/literal or DEREF, it can all be treated as string)
		case FB_DATACLASS_INTEGER
			select case arg_dtype
			case FB_DATATYPE_CHAR
				'' zstring => string
				function = FB_OVLPROC_FULLMATCH - OvlMatchScore( 0, 2 )
			case FB_DATATYPE_WCHAR
				'' wstring => string
				function = FB_OVLPROC_HALFMATCH - OvlMatchScore( 0, 2 )
			end select

		end select

	end select

end function

'':::::
private function hCheckOvlParam _
	( _
		byval parent as FBSYMBOL ptr, _
		byval param as FBSYMBOL ptr, _
		byval arg_expr as ASTNODE ptr, _
		byval arg_mode as integer, _
		byval err_num as FB_ERRMSG ptr, _
		byval options as FB_SYMBFINDOPT _
	) as FB_OVLPROC_MATCH_SCORE

	dim as integer param_dtype = any, arg_dtype = any, param_ptrcnt = any
	dim as integer const_matches = any
	dim as FBSYMBOL ptr param_subtype = any, arg_subtype = any, array = any
	dim as FB_PARAMMODE param_mode = any

	'' arg not passed?
	if( arg_expr = NULL ) then
		'' is param optional?
		if( symbParamIsOptional( param ) ) then
			return FB_OVLPROC_FULLMATCH
		else
			return FB_OVLPROC_NO_MATCH
		end if
	end if

	param_dtype = symbGetFullType( param )
	param_subtype = symbGetSubType( param )
	param_ptrcnt = symbGetPtrCnt( param )
	param_mode = symbGetParamMode( param )

	arg_dtype = astGetFullType( arg_expr )
	arg_subtype = astGetSubType( arg_expr )

	select case param_mode
	'' by descriptor param?
	case FB_PARAMMODE_BYDESC
		'' but arg isn't?
		if( arg_mode <> FB_PARAMMODE_BYDESC ) then
			return FB_OVLPROC_NO_MATCH
		end if

		var match = typeCalcMatch( param_dtype, param_subtype, param_mode, arg_dtype, arg_subtype )

		'' not same type?
		if( match < FB_OVLPROC_TYPEMATCH ) then
			return FB_OVLPROC_NO_MATCH
		end if

		assert( astIsVAR( arg_expr ) or astIsFIELD( arg_expr ) )
		array = arg_expr->sym
		assert( symbIsArray( array ) )


		'' If the BYDESC parameter has unknown dimensions, any array can be passed.
		'' Otherwise, only arrays with unknown or matching dimensions can be passed.
		if( param->param.bydescdimensions > 0 ) then
			if( (param->param.bydescdimensions <> symbGetArrayDimensions( array )) and _
			    (symbGetArrayDimensions( array ) > 0) ) then
				return FB_OVLPROC_NO_MATCH
			end if
		end if

		return match

	'' byref param?
	case FB_PARAMMODE_BYREF
		'' arg being passed by value? and not a UDT?
		'' - fall through for UDTs because they will be handled below by
		''   trying to find a ctor / cast operation that satisfies the call
		if( (arg_mode = FB_PARAMMODE_BYVAL) and (typeGetClass( arg_dtype ) <> FB_DATACLASS_UDT) ) then

			'' invalid type? refuse..
			if( (typeGetClass( arg_dtype ) <> FB_DATACLASS_INTEGER) or _
				(typeGetSize( arg_dtype ) <> env.pointersize) ) then
				return FB_OVLPROC_NO_MATCH
			end if

			'' pretend param is a pointer
			param_dtype = typeAddrOf( param_dtype )
			param_ptrcnt += 1

		end if
	end select

	'' arg passed by descriptor? refuse..
	if( arg_mode = FB_PARAMMODE_BYDESC ) then
		return FB_OVLPROC_NO_MATCH
	end if

	'' same types?
	if( typeGetDtAndPtrOnly( param_dtype ) = typeGetDtAndPtrOnly( arg_dtype ) ) then
		''
		'' The argument is compatible to the parameter if it's the same
		'' type, or if it's being up-casted. Up-casting can apply to UDT
		'' aswell as UDT pointer parameters.
		''
		'' When up-casting, the level must be calculated into the match
		'' score, such that we prefer passing arguments to the parameter
		'' with the closest base type.
		''
		var baselevel = 0
		dim match as FB_OVLPROC_MATCH_SCORE = FB_OVLPROC_NO_MATCH
		if( param_subtype = arg_subtype ) then
			match = FB_OVLPROC_FULLMATCH
		else
			select case( typeGetDtOnly( param_dtype ) )
			case FB_DATATYPE_STRUCT
				var baselevel = symbGetUDTBaseLevel( arg_subtype, param_subtype )
				if( baselevel > 0 ) then
					match = FB_OVLPROC_FULLMATCH - OvlMatchScore( baselevel, 0 )
				end if
			case FB_DATATYPE_FUNCTION
				match = symbCalcProcMatch( param_subtype, arg_subtype, 0 )
			end select
		end if

		if( match > FB_OVLPROC_NO_MATCH ) then
			'' In either case, we still have to check CONSTness (no point choosing a
			'' BYREF AS CONST FOO overload parameter for a non-const FOO argument,
			'' because it couldn't be passed anyways)

			'' Exact same CONSTs? Then there's no point in calling symbCheckConstAssignTopLevel().
			if( typeGetConstMask( param_dtype ) = typeGetConstMask( arg_dtype ) ) then
				return match
			end if

			'' Check whether CONSTness allows passing the arg to the param.
			if( symbCheckConstAssignTopLevel( param_dtype, arg_dtype, param_subtype, arg_subtype, param_mode, const_matches ) ) then
				'' They're compatible despite having different CONSTs -- e.g. "non-const Foo" passed to "Byref As Const Foo".
				'' Treat it as lower score match than an exact match.
				if( match > FB_OVLPROC_TYPEMATCH ) then
					match -= OvlMatchScore( FB_DATATYPES, 0 )
				end if
				match += OvlMatchScore( const_matches, 0 )
				return match
			end if

			'' Same/compatible type, but mismatch due to CONSTness
			return FB_OVLPROC_NO_MATCH
		end if
	end if

	'' different types..

	select case param_dtype
	'' UDT? try to find a ctor
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		hCheckCtorOvl( param_subtype, _
		               arg_expr, _
		               arg_mode, _
		               options )

		'' and at last, try implicit casting..
		hCheckCastOvlEx( param_mode, _
		                 param_dtype, _
		                 param_subtype, _
		                 arg_expr, _
		                 options )

		return FB_OVLPROC_NO_MATCH

	'' enum param? refuse any other argument type, even integers,
	'' or operator overloading wouldn't work (as in C++)
	case FB_DATATYPE_ENUM
		return FB_OVLPROC_NO_MATCH

	case else
		select case arg_dtype
		'' UDT arg? try implicit casting..
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			hCheckCastOvlEx( param_mode, _
			                 param_dtype, _
			                 param_subtype, _
			                 arg_expr, _
			                 options )

			return FB_OVLPROC_NO_MATCH
		end select
	end select

	'' last resource, calc the differences
	function = hCalcTypesDiff( param_dtype, _
	                           param_subtype, _
	                           param_ptrcnt, _
	                           arg_dtype, _
	                           arg_subtype, _
	                           arg_expr, _
	                           param_mode )

end function

'':::::
private function hCheckOvlProc _
	( _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval args as integer, _
		byval arg_head as FB_CALL_ARG ptr, _
		byval err_num as FB_ERRMSG ptr, _
		byval options as FB_SYMBFINDOPT, _
		byval ovl as FBSYMBOL ptr, _
		byref exact_matches as integer, _
		byref is_match as integer _
	) as integer

	dim as FBSYMBOL ptr param = any
	dim as FB_OVLPROC_MATCH_SCORE arg_matchscore = any, matchscore = any
	dim as integer matchcount = any
	dim as FB_CALL_ARG ptr arg = any

	dim as integer is_property = symbIsProperty( ovl_head_proc )

	is_match = FALSE

	dim as integer params = symbGetProcParams( ovl )
	if( symbIsMethod( ovl ) ) then
		params -= 1
	end if

	'' property? handle get/set accessors dups
	if( is_property ) then
		'' get?
		if( (options and FB_SYMBFINDOPT_PROPGET) <> 0 ) then
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

	'' Only consider overloads with enough params
	if( args <= params ) then
		param = symbGetProcHeadParam( ovl )
		if( symbIsMethod( ovl ) ) then
			param = param->next
		end if

		matchscore = FB_OVLPROC_NO_MATCH
		exact_matches = 0

		'' for each arg..
		arg = arg_head
		for i as integer = 0 to args-1

			'' Check for matching parameter.
			arg_matchscore = hCheckOvlParam( _
				ovl, _
				param, _
				arg->expr, _
				arg->mode, _
				err_num, _
				options )

			if( arg_matchscore = FB_OVLPROC_NO_MATCH ) then
				matchscore = FB_OVLPROC_NO_MATCH
				exit for
			end if

			'' exact checks are required for operator overload candidates
			if( arg_matchscore >= FB_OVLPROC_TYPEMATCH ) then
				exact_matches += 1
			end if

			matchscore += arg_matchscore

			'' next param
			param = param->next
			arg = arg->next
		next

		'' If there were no args, then assume it's a match and
		'' then check the remaining params, if any.
		is_match = (args = 0) or (matchscore > FB_OVLPROC_NO_MATCH)

		'' Fewer args than params? Check whether the missing ones are optional.
		for i as integer = args to params-1
			'' not optional? exit
			if( symbParamIsOptional( param ) = FALSE ) then
				'' Missing arg for this param - not a match afterall.
				is_match = FALSE
				exit for
			end if

			'' next param
			param = param->next
		next

	end if

	return matchscore

end function

'':::::
function symbFindClosestOvlProc _
	( _
		byval ovl_head_proc as FBSYMBOL ptr, _
		byval args as integer, _
		byval arg_head as FB_CALL_ARG ptr, _
		byval err_num as FB_ERRMSG ptr, _
		byval options as FB_SYMBFINDOPT _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr ovl = any, closest_proc = any
	dim as FB_OVLPROC_MATCH_SCORE matchscore = any, max_matchscore = any
	dim as integer exact_matches = any, matchcount = any, is_match = any

	*err_num = FB_ERRMSG_OK

	if( ovl_head_proc = NULL ) then
		return NULL
	end if

	closest_proc = NULL
	matchcount = 0       '' number of matching procedures found
	is_match = FALSE
	max_matchscore = FB_OVLPROC_NO_MATCH

	'' for each proc..
	ovl = ovl_head_proc
	do
		matchscore = hCheckOvlProc( _
			ovl_head_proc, _
			args, _
			arg_head, _
			err_num, _
			options or FB_SYMBFINDOPT_NO_ERROR, _
			ovl, _
			exact_matches, _
			is_match )

		if( is_match ) then
			'' First match, or better match than any previous overload?
			if( (matchcount = 0) or (matchscore > max_matchscore) ) then
				dim as integer eligible = TRUE
				'' an operator overload candidate is only eligible if
				'' there is at least one exact arg match
				if( options and FB_SYMBFINDOPT_BOP_OVL ) then
					eligible = (exact_matches >= 1)
				end if

				'' it's eligible, update
				if( eligible ) then
					closest_proc = ovl
					max_matchscore = matchscore
					matchcount = 1
				end if

			'' Same score as best previous overload?
			elseif( matchscore = max_matchscore ) then
				matchcount += 1
			end if
		end if

		'' next overloaded proc
		ovl = symbGetProcOvlNext( ovl )
	loop while( ovl <> NULL )

	'' more than one possibility?
	if( matchcount > 1 ) then
		*err_num = FB_ERRMSG_AMBIGUOUSCALLTOPROC
		function = NULL
	else
		if( closest_proc ) then
			matchscore = hCheckOvlProc( _
				ovl_head_proc, _
				args, _
				arg_head, _
				err_num, _
				options, _
				closest_proc, _
				exact_matches, _
				is_match )

			if( is_match = FALSE ) then
				function = NULL
			else
				function = closest_proc
			end if
		else
			function = NULL
		end if
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

	proc = symbFindClosestOvlProc( symb.globOpOvlTb(op).head, 2, @arg1, err_num, FB_SYMBFINDOPT_BOP_OVL )

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
		'' Check visibility of the operator
		if( symbCheckAccess( proc ) = FALSE ) then
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
		'' Check visibility of the operator
		if( symbCheckAccess( proc ) = FALSE ) then
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
		byval to_subtype as FBSYMBOL ptr, _
		byval options as FB_SYMBFINDOPT = FB_SYMBFINDOPT_NONE _
	) as FB_OVLPROC_MATCH_SCORE

	dim as integer proc_dtype = any
	dim as FBSYMBOL ptr proc_subtype = any

	proc_dtype = symbGetFullType( proc )
	proc_subtype = symbGetSubType( proc )

	'' same types?
	if( typeGetDtAndPtrOnly( proc_dtype ) = typeGetDtAndPtrOnly( to_dtype ) ) then

		'' same subtype?
		if( proc_subtype = to_subtype ) then

			'' same const?
			if( proc_dtype = to_dtype ) then
				return FB_OVLPROC_FULLMATCH
			end if

			return FB_OVLPROC_TYPEMATCH
		end if

		if( typeIsPtr( proc_dtype ) ) then
			return FB_OVLPROC_NO_MATCH
		end if
	end if

	'' different types..
	if( (options and FB_SYMBFINDOPT_EXPLICIT) <> 0 ) then
		return FB_OVLPROC_NO_MATCH
	end if

	select case typeGet( proc_dtype )
	'' UDT or enum? can't be different (this is the last resource,
	'' don't try to do coercion inside a casting routine)
	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS
		return FB_OVLPROC_NO_MATCH

	case else
		select case typeGet( to_dtype )
		'' UDT arg? refuse
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			return FB_OVLPROC_NO_MATCH
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
		byval err_num as FB_ERRMSG ptr, _
		byval options as FB_SYMBFINDOPT = FB_SYMBFINDOPT_NONE _
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
	dim as FB_OVLPROC_MATCH_SCORE matchscore = any, max_matchscore = any
	dim as integer matchcount = any

	'' must check the return type, not the parameter..
	closest_proc = NULL
	max_matchscore = FB_OVLPROC_NO_MATCH
	matchcount = FB_OVLPROC_NO_MATCH

	if( typeGet( to_dtype ) <> FB_DATATYPE_VOID ) then
		'' for each overloaded proc..
		proc = proc_head
		do while( proc <> NULL )

			matchscore = hCheckCastOvl( proc, to_dtype, to_subtype, options )
			if( matchscore > max_matchscore ) then
				closest_proc = proc
				max_matchscore = matchscore
				matchcount = 1

			'' same? ambiguity..
			elseif( matchscore = max_matchscore ) then
				if( max_matchscore > 0 ) then
					matchcount += 1
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
	if( matchcount > 1 ) then
		*err_num = FB_ERRMSG_AMBIGUOUSCALLTOPROC
		if( (options and FB_SYMBFINDOPT_NO_ERROR) = 0 ) then
			errReportParam( proc_head, 0, NULL, FB_ERRMSG_AMBIGUOUSCALLTOPROC )
		end if
		closest_proc = NULL
	else
		if( closest_proc <> NULL ) then
			'' Check visibility of cast operator
			if( symbCheckAccess( closest_proc ) = FALSE ) then
				*err_num = FB_ERRMSG_ILLEGALMEMBERACCESS
				if( (options and FB_SYMBFINDOPT_NO_ERROR) = 0 ) then
					errReportEx( FB_ERRMSG_ILLEGALMEMBERACCESS, _
					             symbGetFullProcName( closest_proc ) )
				end if
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
		byval err_num as FB_ERRMSG ptr, _
		byval options as FB_SYMBFINDOPT = FB_SYMBFINDOPT_NONE _
	) as FBSYMBOL ptr

	dim as FB_CALL_ARG arg1 = any

	'' don't pass the instance ptr
	arg1.expr = expr
	arg1.mode = arg_mode
	arg1.next = NULL

	function = symbFindClosestOvlProc _
		( _
			symbGetCompCtorHead( sym ), _
			1, _
			@arg1, _
			err_num, _
			options _
		)
end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' del
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private sub hDelParams( byval proc as FBSYMBOL ptr )
	dim as FBSYMBOL ptr param = any, nxt = any

	param = proc->proc.paramtb.head
	while( param )
		nxt = param->next

		'' Note: astEnd() will already free the optexpr
		symbFreeSymbol( param )

		param = nxt
	wend
end sub

sub symbDelPrototype( byval s as FBSYMBOL ptr )
	'' del args..
	if( s->proc.params > 0 ) then
		hDelParams( s )
	end if

	symbProcFreeExt( s )

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

function symbAddGlobalCtor( byval proc as FBSYMBOL ptr ) as FB_GLOBCTORLIST_ITEM ptr
	symbSetIsGlobalCtor( proc )
	function = hAddToGlobCtorList( @symb.globctorlist, proc )
end function

function symbAddGlobalDtor( byval proc as FBSYMBOL ptr ) as FB_GLOBCTORLIST_ITEM ptr
	symbSetIsGlobalDtor( proc )
	function = hAddToGlobCtorList( @symb.globdtorlist, proc )
end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' misc
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private function symbCalcParamMatch _
	( _
		byval l as FBSYMBOL ptr, _
		byval r as FBSYMBOL ptr _
	) as FB_OVLPROC_MATCH_SCORE

	assert( l->class = FB_SYMBCLASS_PARAM )
	assert( r->class = FB_SYMBCLASS_PARAM )

	var match = typeCalcMatch( l->typ, l->subtype, l->param.mode, r->typ, r->subtype )
	if( match = FB_OVLPROC_NO_MATCH ) then
		return FB_OVLPROC_NO_MATCH
	end if

	if( l->param.mode <> r->param.mode ) then
		return FB_OVLPROC_NO_MATCH
	end if

	'' Check Bydesc dimensions
	if( l->param.mode = FB_PARAMMODE_BYDESC ) then
		if( l->param.bydescdimensions <> r->param.bydescdimensions ) then
			return FB_OVLPROC_NO_MATCH
		end if
	end if

	function = match
end function

''
'' Checking procedure signature compatibility for procedure pointer
'' "assignments" such as:
''
''    lhs = rhs
''        (lhs = proc to check against)
''        (rhs = proc to check)
''
'' Such assignments are safe if the lhs can safely be used to call the rhs.
'' This could mean that lhs and rhs have the exact same signature, or that there
'' are slight differences, but they're still ABI-compatible.
''
'' Often it's commutative, but sometimes (e.g. due to CONSTs) we allow
'' "lhs = rhs" but not "rhs = lhs".
''
'' Examples:
''
'' Same signature, safe:
''    dim rhs as sub(as integer)
''    dim lhs as sub(as integer) = rhs
''
'' Integer type size. Different signature, but safe on 32bit (but not on 64bit):
''    dim rhs as sub(as long)
''    dim lhs as sub(as integer) = rhs
''
'' Result/parameter type covariance. Different signature, but still safe:
''    type Base extends object : end type
''    type Derived extends Parent : end type
''    dim rhs as function() as Derived
''    dim lhs as function() as Base = rhs
''    (lhs expects to return a Base, so we can assign anything that returns
''    a Base, including things that return a Derived, because a Derived also is
''    a Base. The opposite would not be safe though.)
''
'' CONSTness. Different signature, but still safe:
''    dim rhs as sub(byref as const integer)
''    dim lhs as sub(byref as integer) = rhs
''
function symbCalcProcMatch _
	( _
		byval l as FBSYMBOL ptr, _
		byval r as FBSYMBOL ptr, _
		byref errmsg as integer _
	) as FB_OVLPROC_MATCH_SCORE

	assert( symbIsProc( l ) )
	assert( symbIsProc( r ) )

	'' Different result type?
	'' - It must be the exact same (even CONSTs), as for procedure pointers
	'' - This isn't checked already when searching the overridden method,
	''   because that search is just based on finding compatible overloads
	''   which doesn't take result type into account.
	'' - SUBs have VOID result type and will be handled here too
	var match = typeCalcMatch( l->typ, l->subtype, _
	                           iif( symbIsReturnByRef( l ), FB_PARAMMODE_BYREF, FB_PARAMMODE_BYVAL ), _
	                           r->typ, r->subtype )
	if( match = FB_OVLPROC_NO_MATCH ) then
		errmsg = FB_ERRMSG_OVERRIDERETTYPEDIFFERS
		return FB_OVLPROC_NO_MATCH
	end if

	'' Does one have a BYREF result, but not the other?
	if( symbIsReturnByRef( l ) <> symbIsReturnByRef( r ) ) then
		errmsg = FB_ERRMSG_OVERRIDERETTYPEDIFFERS
		return FB_OVLPROC_NO_MATCH
	end if

	'' Different calling convention?
	if( symbAreProcModesEqual( l, r ) = FALSE ) then
		errmsg = FB_ERRMSG_OVERRIDECALLCONVDIFFERS
		return FB_OVLPROC_NO_MATCH
	end if

	'' If one is a CONST member method, the other must be too
	'' (matters only for virtuals/overrides, not procptrs in general)
	if( symbIsConstant( l ) <> symbIsConstant( r ) ) then
		if( symbIsConstant( l ) ) then
			errmsg = FB_ERRMSG_OVERRIDEISNTCONSTMEMBER
		else
			errmsg = FB_ERRMSG_OVERRIDEISCONSTMEMBER
		end if
		return FB_OVLPROC_NO_MATCH
	end if

	'' Different parameter count?
	if( symbGetProcParams( l ) <> symbGetProcParams( r ) ) then
		errmsg = FB_ERRMSG_OVERRIDEPARAMSDIFFER
		return FB_OVLPROC_NO_MATCH
	end if

	'' Check each parameter's mode and type
	var lparam = symbGetProcHeadParam( l )
	var rparam = symbGetProcHeadParam( r )

	'' When overriding a virtual, we have to ignore the This parameters though.
	'' The virtual's This will have the base as type, the override will have the
	'' derived UDT as type. This would cause us to think the override is incompatible,
	'' because normally passing an object of the base type doesn't guarantee that it's
	'' also an object of the derived UDT. However, in case of virtuals we know that
	'' the override will only be called with a proper object, and we can ignore the
	'' possible type mismatch.
	if( symbIsVirtual( l ) and symbIsMethod( l ) and symbIsMethod( r ) ) then
		if( (lparam <> NULL) and (rparam <> NULL) ) then
			if( symbIsInstanceParam( lparam ) and symbIsInstanceParam( rparam ) ) then
				lparam = lparam->next
				rparam = rparam->next
			end if
		end if
	end if

	while( lparam )

		'' lparam/rparam swapped here, because in case of params we have
		'' to check whether the lparam could be passed to the rparam,
		'' when calling r through l.
		var parammatch = symbCalcParamMatch( rparam, lparam )
		if( parammatch = FB_OVLPROC_NO_MATCH ) then
			errmsg = FB_ERRMSG_OVERRIDEPARAMSDIFFER
			return FB_OVLPROC_NO_MATCH
		end if

		'' Decrease overall match if a single param scored lower
		if( match > parammatch ) then
			match = parammatch
		end if

		lparam = lparam->next
		rparam = rparam->next
	wend

	function = match
end function

sub symbProcCheckOverridden _
	( _
		byval proc as FBSYMBOL ptr, _
		byval is_implicit as integer _
	)

	dim as FBSYMBOL ptr overridden = any

	overridden = symbProcGetOverridden( proc )

	'' Overriding anything?
	if( overridden ) then
		'' Check whether override and overridden have different return
		'' type or calling convention etc., this must be disallowed
		'' (unlike with overloading) because the function signatures
		'' aren't really compatible (e.g. return on stack vs. return
		'' in registers).

		dim errmsg as integer
		if( symbCalcProcMatch( overridden, proc, errmsg ) = FB_OVLPROC_NO_MATCH ) then
			if( is_implicit and _
			    (errmsg = FB_ERRMSG_OVERRIDECALLCONVDIFFERS) ) then
				'' symbUdtDeclareDefaultMembers() uses this to check
				'' implicit dtors and LET overloads. Since they
				'' are not visible in the original code,
				'' the error message must have more info.
				if( symbIsDestructor1( proc ) ) then
					errmsg = FB_ERRMSG_IMPLICITDTOROVERRIDECALLCONVDIFFERS
				else
					errmsg = FB_ERRMSG_IMPLICITLETOVERRIDECALLCONVDIFFERS
				end if
			end if

			errReport( errmsg )
		end if
	end if

end sub

sub symbProcSetVtableIndex( byval proc as FBSYMBOL ptr, byval i as integer )
	symbProcAllocExt( proc )
	proc->proc.ext->vtableindex = i
end sub

function symbProcGetVtableIndex( byval proc as FBSYMBOL ptr ) as integer
	if( proc->proc.ext ) then
		function = proc->proc.ext->vtableindex
	end if
end function

function symbProcGetOverridden( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr
	if( proc->proc.ext ) then
		function = proc->proc.ext->overridden
	end if
end function

function symbGetProcResult( byval proc as FBSYMBOL ptr ) as FBSYMBOL ptr
	if( proc->proc.ext ) then
		function = proc->proc.ext->res
	end if
end function

function symbProcHasFwdRefInSignature( byval proc as FBSYMBOL ptr ) as integer
	dim as FBSYMBOL ptr param = any

	assert( symbIsProc( proc ) )

	'' Check result type
	if( typeHasFwdRefInSignature( proc->typ, proc->subtype ) ) then
		return TRUE
	end if

	'' Check each parameter
	param = symbGetProcHeadParam( proc )
	while( param )

		if( typeHasFwdRefInSignature( param->typ, param->subtype ) ) then
			return TRUE
		end if

		param = symbGetParamNext( param )
	wend

	function = FALSE
end function

private sub hSubOrFuncToStr( byref s as string, byval proc as FBSYMBOL ptr )
	if( symbGetType( proc ) = FB_DATATYPE_VOID ) then
		s += "sub"
	else
		s += "function"
	end if
end sub

'' Append calling convention, if it differs from the default
private sub hProcModeToStr( byref s as string, byval proc as FBSYMBOL ptr )
	'' Ctors/Dtors currently always default to CDECL, see cProcHeader()
	if( symbIsConstructor( proc ) or symbIsDestructor1( proc ) or symbIsDestructor0( proc ) ) then
		select case( symbGetProcMode( proc ) )
		case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS
			s += " stdcall"
		case FB_FUNCMODE_THISCALL
			s += " thiscall"
		case FB_FUNCMODE_FASTCALL
			s += " fastcall"
		case FB_FUNCMODE_PASCAL
			s += " pascal"
		end select
	else
		'' Others default to FBCALL
		select case( symbGetProcMode( proc ) )
		case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS
			select case( env.target.fbcall )
			case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS

			case else
				s += " stdcall"
			end select
		case FB_FUNCMODE_THISCALL
			s += " thiscall"
		case FB_FUNCMODE_FASTCALL
			s += " fastcall"
		case FB_FUNCMODE_PASCAL
			if( env.target.fbcall <> FB_FUNCMODE_PASCAL ) then
				s += " pascal"
			end if
		case FB_FUNCMODE_CDECL
			if( env.target.fbcall <> FB_FUNCMODE_CDECL ) then
				s += " cdecl"
			end if
		end select
	end if
end sub

function hDumpDynamicArrayDimensions( byval dimensions as integer ) as string
	dim s as string

	s += "("
	for i as integer = 1 to dimensions
		if( i > 1 ) then
			s += ", "
		end if
		s += "any"
	next
	s += ") "

	function = s
end function

private sub hParamsToStr( byref s as string, byval proc as FBSYMBOL ptr )
	s += "("

	var param = symbGetProcHeadParam( proc )

	'' Method? Skip the instance pointer
	if( (param <> NULL) and symbIsMethod( proc ) ) then
		param = symbGetParamNext( param )
	end if

	while( param )
		var parammode = symbGetParamMode( param )

		select case( parammode )
		case FB_PARAMMODE_BYVAL, FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
			select case( parammode )
			case FB_PARAMMODE_BYVAL, FB_PARAMMODE_BYREF
				'' Byval/Byref, if different from default, at least in -lang fb.
				'' In other -langs it depends on OPTION BYVAL, and it seems best to
				'' always include Byval/Byref in that case, otherwise it'd depend on
				'' source code context.
				if( fbLangIsSet( FB_LANG_FB ) and _
				    (symbGetDefaultParamMode( param->typ, param->subtype ) <> parammode) ) then
					if( parammode = FB_PARAMMODE_BYVAL ) then
						s += "byval "
					else
						s += "byref "
					end if
				end if

			case FB_PARAMMODE_BYDESC
				s += hDumpDynamicArrayDimensions( param->param.bydescdimensions )
			end select

			'' Parameter's data type
			s += "as " + symbTypeToStr( param->typ, param->subtype )

		case FB_PARAMMODE_VARARG
			s += "..."
		end select

		param = symbGetParamNext( param )
		if( param ) then
			s += ", "
		end if
	wend

	s += ")"
end sub

private sub hResultToStr( byref s as string, byval proc as FBSYMBOL ptr )
	'' Function result
	if( symbGetType( proc ) <> FB_DATATYPE_VOID ) then
		if( symbIsReturnByRef( proc ) ) then
			s += " byref"
		end if
		s += " as " + symbTypeToStr( proc->typ, proc->subtype )
	end if
end sub

function symbProcPtrToStr( byval proc as FBSYMBOL ptr ) as string
	dim s as string

	hSubOrFuncToStr( s, proc )
	hProcModeToStr( s, proc )
	hParamsToStr( s, proc )
	hResultToStr( s, proc )

	function = s
end function

function symbGetFullProcName( byval proc as FBSYMBOL ptr ) as zstring ptr
	static as string res

	res = ""

	dim as FBSYMBOL ptr ns = symbGetNamespace( proc )

	do while( ns <> @symbGetGlobalNamespc( ) )
		res = *symbGetName( ns ) + "." + res
		ns = symbGetNamespace( ns )
	loop

	if( symbIsConstructor( proc ) ) then
		res += "constructor"
	elseif( symbIsDestructor1( proc ) ) then
		res += "destructor"
	elseif( symbIsDestructor0( proc ) ) then
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

function symbMethodToStr( byval proc as FBSYMBOL ptr ) as string
	var s = *symbGetFullProcName( proc )
	hProcModeToStr( s, proc )
	hParamsToStr( s, proc )
	hResultToStr( s, proc )
	function = s
end function

function symbGetDefaultParamMode _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	select case as const( typeGetDtAndPtrOnly( dtype ) )
	case FB_DATATYPE_FWDREF, _
	     FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, _
	     FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR, _
	     FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		return FB_PARAMMODE_BYREF
	case else
		return FB_PARAMMODE_BYVAL
	end select

end function

'' Check whether the procedures' calling conventions are compatible
function symbAreProcModesEqual _
	( _
		byval proca as FBSYMBOL ptr, _
		byval procb as FBSYMBOL ptr _
	) as integer

	dim as integer a = any, b = any

	a = symbGetProcMode( proca )
	b = symbGetProcMode( procb )

	'' STDCALL and STDCALL_MS are technically compatible, only the mangling
	'' is different - but that doesn't concern function pointers.
	select case( a )
	case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS
		select case( b )
		case FB_FUNCMODE_STDCALL, FB_FUNCMODE_STDCALL_MS
			return TRUE
		end select
	end select

	function = (a = b)
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

