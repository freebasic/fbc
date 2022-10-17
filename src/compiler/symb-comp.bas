'' complex/compound/composite symbols helper functions
''
'' chng: sep/2006 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "rtl.bi"

declare function symbGetCompCopyCtor( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr

type FB_SYMBNEST
	sym             as FBSYMBOL ptr
	symtb           as FBSYMBOLTB ptr           '' prev symbol tb
	hashtb          as FBHASHTB ptr             '' prev hash tb
	ns              as FBSYMBOL ptr             '' prev namespace
end type

sub symbCompInit( )
	for i as integer = 0 to AST_OPCODES-1
		symb.globOpOvlTb(i).head = NULL
	next

	stackNew( @symb.neststk, 16, len( FB_SYMBNEST ), FALSE )
end sub

sub symbCompEnd( )
	stackFree( @symb.neststk )
end sub

sub symbUdtAllocExt( byval udt as FBSYMBOL ptr )
	assert( symbIsStruct( udt ) )
	if( udt->udt.ext = NULL ) then
		udt->udt.ext = xcallocate( sizeof( FB_STRUCTEXT ) )
	end if
end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' default ctors
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private function hDeclareProc _
	( _
		byval udt as FBSYMBOL ptr, _
		byval op as AST_OP, _
		byval rhsdtype as integer, _
		byval attrib as FB_SYMBATTRIB, _
		byval pattrib as FB_PROCATTRIB, _
		byval mode as FB_FUNCMODE _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr proc = any

	'' Into the UDT namespace
	symbNestBegin( udt, TRUE )

	proc = symbPreAddProc( NULL )

	'' add "this"
	symbAddProcInstanceParam( udt, proc )

	'' add right-side hand param?
	if( rhsdtype <> FB_DATATYPE_INVALID ) then
		'' byref __FB_RHS__ as const UDT
		'' (must be CONST to allow const objects to be passed)
		assert( symbIsStruct( udt ) )
		symbAddProcParam( proc, "__FB_RHS__", rhsdtype, udt, _
		                  0, FB_PARAMMODE_BYREF, FB_SYMBATTRIB_NONE, FB_PROCATTRIB_NONE )
	end if

	attrib or= FB_SYMBATTRIB_PRIVATE
	pattrib or= FB_PROCATTRIB_METHOD

	'' cons|destructor?
	if( op = INVALID ) then
		proc = symbAddCtor( proc, NULL, attrib, pattrib, _
		                    mode, FB_SYMBOPT_DECLARING )
	'' op..
	else
		proc = symbAddOperator( proc, op, NULL, FB_DATATYPE_VOID, NULL, attrib, pattrib, _
		                        mode, FB_SYMBOPT_DECLARING )
	end if

	'' Close the namespace again
	symbNestEnd( TRUE )

	function = proc
end function

private sub hSetMinimumVtableSize( byval udt as FBSYMBOL ptr )
	'' vtables always have at least 2 elements (following GCC):
	''    index 0: a NULL pointer
	''    index 1: the pointer to this type's RTTI table
	'' Slots for the pointers for virtual methods start at index 2.
	''
	'' Note: A vtable must be generated even if there are no virtuals,
	'' to support RTTI. In that case it will only have the first two
	'' elements (null and rtti pointers).

	if( udt->udt.ext->vtableelements = 0 ) then
		udt->udt.ext->vtableelements = 2
	end if
end sub

private sub hBuildRtti( byval udt as FBSYMBOL ptr )
	static as FBARRAYDIM dTB(0)
	dim as ASTNODE ptr initree = any, rttibase = any
	dim as FBSYMBOL ptr rtti = any, fld = any

	'' static shared UDT.rtti as fb_RTTI$
	'' (real identifier given later during mangling)
	symbNestBegin( udt, TRUE )
	rtti = symbAddVar( NULL, NULL, FB_DATATYPE_STRUCT, symb.rtti.fb_rtti, 0, 0, dTB(), _
	                   FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_STATIC or FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_INTERNAL, _
	                   FB_SYMBOPT_PRESERVECASE )
	rtti->stats or= FB_SYMBSTATS_RTTITABLE
	symbNestEnd( TRUE )
	udt->udt.ext->rtti = rtti

	'' initializer
	initree = astTypeIniBegin( FB_DATATYPE_STRUCT, symb.rtti.fb_rtti, FALSE, 0 )
	astTypeIniScopeBegin( initree, rtti, FALSE )

		'' stdlibvtable = NULL
		fld = symbUdtGetFirstField( symb.rtti.fb_rtti )
		astTypeIniAddAssign( initree, astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ), NULL ), fld )

		'' id = @"mangled name"
		fld = symbUdtGetNextInitableField( fld )
		astTypeIniAddAssign( initree, astNewADDROF( astNewVAR( symbAllocStrConst( symbGetMangledName( udt ), -1 ) ) ), fld )

		'' rttibase = @(base's RTTI data) or NULL if there is no base
		fld = symbUdtGetNextInitableField( fld )
		if( udt->udt.base ) then
			rttibase = astNewADDROF( astNewVAR( udt->udt.base->subtype->udt.ext->rtti ) )
		else
			rttibase = astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ) )
		end if
		astTypeIniAddAssign( initree, rttibase, fld )

	astTypeIniScopeEnd( initree, rtti )
	astTypeIniEnd( initree, TRUE )

	symbSetTypeIniTree( rtti, initree )
end sub

private sub hBuildVtable( byval udt as FBSYMBOL ptr )
	static as FBARRAYDIM dTB(0)
	dim as ASTNODE ptr initree = any, basevtableinitree = any
	dim as FBSYMBOL ptr member = any, rtti = any, vtable = any
	dim as integer i = any, basevtableelements = any

	'' The vtable is an array of pointers:
	''    0. null pointer (why? just following GCC...)
	''    1. rtti pointer
	''    2. and following: procptrs corresponding to virtual methods
	''                      in the order they were parsed.

	assert( udt->udt.ext->vtableelements >= 2 )

	'' static shared UDT.vtable(0 to elements-1) as any ptr
	'' (real identifier given later during mangling)
	symbNestBegin( udt, TRUE )
	dTB(0).upper = udt->udt.ext->vtableelements - 1
	vtable = symbAddVar( NULL, NULL, typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 1, dTB(), _
	                     FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_STATIC or FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_INTERNAL, _
	                     FB_SYMBOPT_PRESERVECASE )
	vtable->stats or= FB_SYMBSTATS_VTABLE
	symbNestEnd( TRUE )

	'' Find information about the base UDT's vtable:
	''    the number of elements,
	''    and the initree (so it can be copied into the new vtable)
	''
	'' - If the base has no virtuals, vtableelements will be 2
	''   (due to hSetMinimumVtableSize())
	'' - If the base is OBJECT, the vtable is hidden in the rtlib,
	''   thus there is no initree for us to use. Luckily we don't need it
	''   anyways, since OBJECT doesn't have any virtuals.
	assert( symbIsField( udt->udt.base ) )
	assert( symbGetType( udt->udt.base ) = FB_DATATYPE_STRUCT )
	assert( symbIsStruct( udt->udt.base->subtype ) )
	basevtableelements = udt->udt.base->subtype->udt.ext->vtableelements
	'' Any virtuals (more than the default 2 elements)?
	if( basevtableelements > 2 ) then
		assert( symbIsVar( udt->udt.base->subtype->udt.ext->vtable ) )
		basevtableinitree = udt->udt.base->subtype->udt.ext->vtable->var_.initree
	else
		basevtableinitree = NULL
	end if

	'' {
	initree = astTypeIniBegin( typeAddrOf( FB_DATATYPE_VOID ), NULL, FALSE, 0 )
	astTypeIniScopeBegin( initree, vtable, TRUE )

	'' 0. null pointer = NULL
	astTypeIniAddAssign( initree, astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ) ), vtable )

	'' 1. rtti pointer = @rtti
	rtti = udt->udt.ext->rtti
	astTypeIniAddAssign( initree, astNewADDROF( astNewVAR( rtti ) ), vtable )

	'' initialize inherited procptrs, to the same expression as in the
	'' base vtable's initializer
	i = 2
	if( basevtableinitree ) then
		'' Copy the typeini assigns from the base vtable's initializer,
		'' except the first 2 (they are set above already)
		astTypeIniCopyElements( initree, basevtableinitree, 2 )
		assert( basevtableelements > 2 )
		i += (basevtableelements - 2)
	end if

	'' Fill new vtable entries with NULLs first, to be safe, and also to
	'' initialize any new unimplemented pure-virtual slots.
	'' We could let them point to __cxa_pure_virtual() like gcc,
	'' but with a NULL pointer crash instead of the abort() we'll actually
	'' get a more useful run-time error under -exx.
	while( i <= dTB(0).upper )
		astTypeIniAddAssign( initree, astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ) ), vtable )
		i += 1
	wend

	'' }
	astTypeIniScopeEnd( initree, vtable )
	astTypeIniEnd( initree, TRUE )

	symbSetTypeIniTree( vtable, initree )

	'' 1. new (and not inherited) entries for ...
	''  - virtuals: must be set to point to their bodies for now.
	''    (not yet overridden)
	''  - abstracts: are set to NULL, so if they're not overridden, a NULL
	''    pointer crash will happen when they're called, which is handled by
	''    -exx error checking (see also astBuildVtableLookup()).
	''    (GCC sets it to point to __cxa_pure_virtual(), which shows a
	''    run-time error message and aborts the program)
	''
	'' 2. any entries for inherited virtuals/abstracts that were overridden
	''    by a normal method must be updated to point to the normal method.

	'' For each member of this UDT (does not include inherited members)
	member = symbGetCompSymbTb( udt ).head
	while( member )
		'' procedure?
		if( symbIsProc( member ) ) then
			i = symbProcGetVtableIndex( member )
			if( (i > 0) and (not symbIsAbstract( member )) ) then
				astTypeIniReplaceElement( initree, i, astBuildProcAddrof( member ) )
			end if
		end if
		member = member->next
	wend

	udt->udt.ext->vtable = vtable
end sub

private sub hProcBegin( byval udt as FBSYMBOL ptr, byval proc as FBSYMBOL ptr )
	'' constructor|destructor|operator parent[.let]( ... )
	symbNestBegin( udt, TRUE )
	astProcBegin( proc, FALSE )
end sub

private sub hProcEnd( )
	'' end constructor|destructor|operator
	astProcEnd( FALSE )
	symbNestEnd( TRUE )
end sub

private sub hAddCtorBody _
	( _
		byval udt as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval is_copyctor as integer _
	)

	'' The AST will add any implicit base/field construction/destruction
	'' code automatically
	hProcBegin( udt, proc )

	if( is_copyctor ) then
		'' assign op overload will do the rest
		astAdd( astNewASSIGN( _
			astBuildVarField( symbGetParamVar( symbGetProcHeadParam( proc ) ) ), _
			astBuildVarField( symbGetParamVar( symbGetProcTailParam( proc ) ) ) ) )
	end if

	hProcEnd( )

	symbSetCantUndef( udt )
end sub

private function hArrayDescPtr _
	( _
		byval descexpr as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	descexpr = astNewADDROF( descexpr )
	descexpr = astNewBOP( AST_OP_ADD, descexpr, astNewCONSTi( symb.fbarray_ptr ) )
	descexpr = astNewCONV( typeMultAddrOf( dtype, 2 ), subtype, descexpr, AST_CONVOPT_DONTCHKPTR )
	descexpr = astNewDEREF( descexpr )

	function = descexpr
end function

'' Copying over a dynamic array, needed for the automatically-generated implicit
'' LET overloads for UDTs containing dynamic array fields.
private sub hAssignDynamicArray _
	( _
		byval fld as FBSYMBOL ptr, _
		byval this_ as FBSYMBOL ptr, _
		byval rhs as FBSYMBOL ptr _
	)

	dim as integer dtype = any
	dim as FBSYMBOL ptr dst = any, src = any, limit = any
	dim as FBSYMBOL ptr looplabel = any, exitlabel = any

	'' 1. REDIM dest to same size as source (will call dtors/ctors as needed)
	dtype = fld->typ
	astAdd( rtlArrayRedimTo( astBuildVarField( this_, fld ), _
	                         astBuildVarField( rhs  , fld ), _
	                         dtype, fld->subtype ) )

	'' 2. Loop over all elements (if any) and copy them over 1 by 1, using
	''    astNewASSIGN(), that will call let overloads as needed, and handle
	''    strings.
	dtype = typeAddrOf( dtype )
	looplabel = symbAddLabel( NULL )
	exitlabel = symbAddLabel( NULL )
	dst = symbAddTempVar( dtype, fld->subtype )
	src = symbAddTempVar( dtype, fld->subtype )
	limit = symbAddTempVar( dtype, fld->subtype )

	'' dst   = this.arraydesc.ptr
	'' src   = rhs.arraydesc.ptr
	'' limit = src + rhs.arraydesc.size
	astAdd( astBuildVarAssign( dst, astBuildDerefAddrOf( astBuildVarField( this_, fld ), symb.fbarray_ptr, dtype, fld->subtype ), AST_OPOPT_ISINI ) )
	astAdd( astBuildVarAssign( src, astBuildDerefAddrOf( astBuildVarField( rhs  , fld ), symb.fbarray_ptr, dtype, fld->subtype ), AST_OPOPT_ISINI ) )
	astAdd( astBuildVarAssign( _
		limit, _
		astNewBOP( AST_OP_ADD, _
			astNewVAR( src ), _
			astBuildDerefAddrOf( astBuildVarField( rhs, fld ), symb.fbarray_size, FB_DATATYPE_UINT, NULL ) ), _
		AST_OPOPT_ISINI ) )

	'' looplabel:
	astAdd( astNewLABEL( looplabel ) )

	'' if src >= limit then goto exitlabel
	astAdd( astBuildBranch( astNewBOP( AST_OP_GE, astNewVAR( src ), astNewVAR( limit ) ), exitlabel, TRUE ) )

	'' *dst = *src
	astAdd( astNewASSIGN( astBuildVarDeref( dst ), astBuildVarDeref( src ) ) )

	'' dst += 1  (astBuildVarInc() does pointer arithmetic)
	'' src += 1
	astAdd( astBuildVarInc( dst, 1 ) )
	astAdd( astBuildVarInc( src, 1 ) )

	'' goto looplabel
	astAdd( astNewBRANCH( AST_OP_JMP, looplabel ) )

	'' exitlabel:
	astAdd( astNewLABEL( exitlabel ) )

end sub

'':::::
private sub hAssignList _
	( _
		byval fld as FBSYMBOL ptr, _
		byval this_ as FBSYMBOL ptr, _
		byval rhs as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr cnt, label, dst, src, subtype

	subtype = symbGetSubtype( fld )

	cnt = symbAddTempVar( FB_DATATYPE_INTEGER )
	label = symbAddLabel( NULL )
	dst = symbAddTempVar( typeAddrOf( symbGetType( fld ) ), subtype )
	src = symbAddTempVar( typeAddrOf( symbGetType( fld ) ), subtype )

	'' dst = @this.arrayfield(0)
	astAdd( astBuildVarAssign( dst, astNewADDROF( astBuildVarField( this_, fld ) ), AST_OPOPT_ISINI ) )
	'' src = @rhs.arrayfield(0)
	astAdd( astBuildVarAssign( src, astNewADDROF( astBuildVarField( rhs, fld ) ), AST_OPOPT_ISINI ) )

	'' for cnt = 0 to symbGetArrayElements( dst )-1
	astAdd( astBuildForBegin( NULL, cnt, label, 0 ) )

	'' *dst = *src
	astAdd( astNewASSIGN( astBuildVarDeref( dst ), astBuildVarDeref( src ) ) )

	'' dst += 1
	astAdd( astBuildVarInc( dst, 1 ) )
	'' src += 1
	astAdd( astBuildVarInc( src, 1 ) )

	'' next
	astAdd( astBuildForEnd( NULL, cnt, label, astNewCONSTi( symbGetArrayElements( fld ) ) ) )

end sub

'':::::
private function hCopyUnionFields _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval rhs as FBSYMBOL ptr, _
		byval base_fld as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr fld = any
	dim as longint bytes = any, lgt = any, base_ofs = any

	'' merge all union fields
	fld = base_fld
	bytes = 0
	base_ofs = symbGetOfs( base_fld )

	do
		lgt = symbGetRealSize( fld ) + (symbGetOfs( fld ) - base_ofs)
		if( lgt > bytes ) then
			bytes = lgt
		end if

		'' Visit following union fields (but not any methods/static member vars/etc.)
		fld = fld->next
	loop while( fld andalso symbIsField( fld ) andalso symbGetIsUnionField( fld ) )

	'' copy all them at once
	astAdd( astNewMEM( AST_OP_MEMMOVE, _
				astBuildVarField( this_, base_fld ), _
				astBuildVarField( rhs, base_fld ), _
				bytes ) )

	function = fld
end function

private sub hAddLetOpBody _
	( _
		byval udt as FBSYMBOL ptr, _
		byval letproc as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr fld = any, this_ = any, rhs = any
	dim as integer do_copy = any

	hProcBegin( udt, letproc )

	this_ = symbGetParamVar( symbGetProcHeadParam( letproc ) )
	rhs = symbGetParamVar( symbGetProcTailParam( letproc ) )

	''
	'' Copy each field
	''
	'' - except dynamic array field descriptors. Instead, the fake dynamic
	''   array field will be handled in order to copy the dynamic array.
	''
	'' - except the OBJECT base class containing the vptr, because we don't
	''   want to overwrite this.vptr with rhs.vptr. The this object doesn't
	''   change its type or size, so its vptr must stay the same.
	''
	''   This only applies if this UDT actually is directly derived from
	''   OBJECT. For UDTs that are only indirectly derived from OBJECT, we
	''   do want to copy the base. Doing so will call the base's Let
	''   overload, which then takes care of not overwriting the vptr.
	''
	fld = symbGetCompSymbTb( udt ).head
	while( fld )
		do_copy = symbIsField( fld ) and (not symbIsDescriptor( fld ))
		if( udt->udt.base ) then
			do_copy and= (fld <> udt->udt.base) or _
				(udt->udt.base->subtype <> symb.rtti.fb_object)
		end if

		if( do_copy ) then
			'' part of an union?
			if( symbGetIsUnionField( fld ) ) then
				fld = hCopyUnionFields( this_, rhs, fld )
				continue while
			end if

			'' Dynamic array field?
			if( symbIsDynamic( fld ) ) then
				hAssignDynamicArray( fld, this_, rhs )
			else
				if( symbGetArrayDimensions( fld ) = 0 ) then
					'' this.field = rhs.field
					astAdd( astNewASSIGN( astBuildVarField( this_, fld ), astBuildVarField( rhs, fld ) ) )
				else
					hAssignList( fld, this_, rhs )
				end if
			end if
		end if

		fld = fld->next
	wend

	hProcEnd( )

	symbSetCantUndef( udt )

end sub

'' Declare any implicit/default UDT members without implementing them.
sub symbUdtDeclareDefaultMembers _
	( _
		byref default as SYMBDEFAULTMEMBERS, _
		byval udt as FBSYMBOL ptr, _
		byval mode as FB_FUNCMODE _
	)

	dim as integer missing_base_defctor = any

	''
	'' If this UDT has fields with ctors, we have to make sure to add
	'' default and copy ctors aswell as a dtor and a Let operator to the
	'' parent, if the user didn't do that yet. This ensures the fields'
	'' ctors/dtors will be called and also that they will be copied
	'' correctly: In case they have Let overloads themselves, we can't just
	'' do the default memcpy(). (If the parent already has a Let overload,
	'' we can assume it's correct already)
	''
	'' Besides that, in case there were any field initializers specified,
	'' we want to add a default constructor if there isn't any constructor
	'' yet, to ensure the field initializers are getting used.
	''
	'' For the copy constructors and Let overloads, we usually only need to
	'' add BYREF AS CONST UDT versions. That allows copying from const or
	'' non-const objects.
	''
	'' For backwards compatibility we may need to add a BYREF AS UDT copy
	'' constructor though: In case the user created only a non-const LET
	'' overload, and we need to create a copy constructor that's going to
	'' call that LET overload. Since it's non-const, the copy constructor's
	'' parameter must be non-const aswell.
	''

	'' Derived?
	if( udt->udt.base ) then
		assert( symbIsField( udt->udt.base ) )
		assert( symbGetType( udt->udt.base ) = FB_DATATYPE_STRUCT )
		assert( symbIsStruct( udt->udt.base->subtype ) )
		'' No default ctor, but others? Then the base needs to be
		'' initialized with a manual constructor call. In user-defined
		'' constructors this is done by using the BASE() initializer
		'' syntax, but in our implicitly generated constructors we can't
		'' do that because we don't know what arguments to supply.
		missing_base_defctor = _
			(symbGetCompDefCtor( udt->udt.base->subtype ) = NULL) and _
			(symbGetCompCtorHead( udt->udt.base->subtype ) <> NULL)
	else
		missing_base_defctor = FALSE
	end if

	default.defctor = NULL
	default.copyctor = NULL
	default.copyctorconst = NULL
	default.copyletopconst = NULL
	default.dtor1 = NULL
	default.dtor0 = NULL

	'' Ctor/inited fields and no ctor yet?
	if( (symbGetUDTHasCtorField( udt ) or symbGetUDTHasInitedField( udt )) and _
	    (symbGetCompCtorHead( udt ) = NULL) ) then
		if( missing_base_defctor ) then
			'' Cannot implicitly generate a default ctor,
			'' show a nicer error message than astProcEnd() would.
			'' It would report the missing BASE() initializer,
			'' but from here we can show a more useful error.
			errReport( FB_ERRMSG_NEEDEXPLICITDEFCTOR )
		else
			'' Add default ctor
			default.defctor = hDeclareProc _
				( _
					udt, _
					INVALID, _
					FB_DATATYPE_INVALID, _
					FB_SYMBATTRIB_INTERNAL, _
					FB_PROCATTRIB_OVERLOADED or FB_PROCATTRIB_CONSTRUCTOR, _
					mode _
				)
		end if
	end if

	if( symbGetUDTHasCtorField( udt ) ) then
		symbUdtAllocExt( udt )

		'' LET overloads must be declared before the copy ctors because
		'' they're called by the current copy ctor implementation.

		if( udt->udt.ext->copyletopconst = NULL ) then
			'' declare operator let( byref rhs as const UDT )
			default.copyletopconst = hDeclareProc _
				( _
					udt, _
					AST_OP_ASSIGN, _
					typeSetIsConst( FB_DATATYPE_STRUCT ), _
					FB_SYMBATTRIB_INTERNAL, _
					FB_PROCATTRIB_OVERLOADED or FB_PROCATTRIB_OPERATOR, _
					mode _
				)
			symbProcCheckOverridden( default.copyletopconst, TRUE )
		end if

		if( udt->udt.ext->copyctorconst = NULL ) then
			'' declare constructor( byref rhs as const UDT )
			if( missing_base_defctor ) then
				'' Cannot implicitly generate a copy ctor,
				'' same as with default ctor above.
				errReport( FB_ERRMSG_NEEDEXPLICITCOPYCTORCONST )
			else
				default.copyctorconst = hDeclareProc _
					( _
						udt, _
						INVALID, _
						typeSetIsConst( FB_DATATYPE_STRUCT ), _
						FB_SYMBATTRIB_INTERNAL, _
						FB_PROCATTRIB_OVERLOADED or FB_PROCATTRIB_CONSTRUCTOR, _
						mode _
					)
			end if
		end if

		'' Add a non-const copy ctor for backwards compatibility,
		'' if the user provided a non-const LET overload (see above).
		if( (udt->udt.ext->copyletop <> NULL) and (udt->udt.ext->copyctor = NULL) ) then
			'' declare constructor( byref rhs as UDT )
			if( missing_base_defctor ) then
				'' Cannot implicitly generate a copy ctor,
				'' same as with default ctor above.
				errReport( FB_ERRMSG_NEEDEXPLICITCOPYCTOR )
			else
				default.copyctor = hDeclareProc _
					( _
						udt, _
						INVALID, _
						FB_DATATYPE_STRUCT, _
						FB_SYMBATTRIB_INTERNAL, _
						FB_PROCATTRIB_OVERLOADED or FB_PROCATTRIB_CONSTRUCTOR, _
						mode _
					)
			end if
		end if
	end if

	'' has fields with dtors?
	if( symbGetUDTHasDtorField( udt ) ) then
		symbUdtAllocExt( udt )

		'' no default dtor explicitly defined?
		if( udt->udt.ext->dtor1 = NULL ) then

			'' if we didn't have the complete dtor then we shouln't have the deleting dtor either
			'' because there is no way to explicitly define the deleting dtor
			assert( udt->udt.ext->dtor0 = NULL )

			'' Complete dtor
			default.dtor1 = hDeclareProc _
				( _
					udt, _
					INVALID, _
					FB_DATATYPE_INVALID, _
					FB_SYMBATTRIB_INTERNAL, _
					FB_PROCATTRIB_DESTRUCTOR1, _
					mode _
				)

			'' c++? we may need other dtors too...
			if( symbGetMangling( udt ) = FB_MANGLING_CPP ) then
				'' Deleting dtor
				default.dtor0 = hDeclareProc _
					( _
						udt, _
						INVALID, _
						FB_DATATYPE_INVALID, _
						FB_SYMBATTRIB_INTERNAL, _
						FB_PROCATTRIB_DESTRUCTOR0, _
						mode _
					)
			end if

			'' Don't allow the implicit dtor to override a FINAL dtor from the base
			symbProcCheckOverridden( default.dtor1, TRUE )

		end if

	end if

end sub

'' Implement the implicit members declared by symbUdtDeclareDefaultMembers(),
'' add other implicit code (vtable/rtti global vars).
sub symbUdtImplementDefaultMembers _
	( _
		byref default as SYMBDEFAULTMEMBERS, _
		byval udt as FBSYMBOL ptr _
	)

	''
	'' Add vtable and rtti global variables
	''
	'' - The vtable can only be created once all methods are known,
	''   how many virtuals there are, which method overrides virtuals
	''   from the base, etc.
	''   Even the implicit destructor (if any) must be declared before
	''   the vtable is added, in case it should override a virtual dtor.
	''
	'' - Creating the vtable depends on FBSYMBOL.udt.ext->rtti being set,
	''   because the vtable includes a pointer to the rtti table,
	''   thus the rtti table should be added before the vtable.
	''
	'' - Any constructor body depends on FBSYMBOL.udt.ext->vtable being set,
	''   so the vtable must be added before any constructor bodies.
	''
	if( symbGetHasRTTI( udt ) ) then
		symbUdtAllocExt( udt )
		hSetMinimumVtableSize( udt )

		'' only if it isn't FB's own Object base super class
		'' (for which the rtlib already contains these declarations)
		if( udt <> symb.rtti.fb_object ) then
			hBuildRtti( udt )
			hBuildVtable( udt )
		end if
	end if

	''
	'' Add bodies if any implicit ctor/dtor/let procs were declared above
	''

	if( default.defctor ) then
		hAddCtorBody( udt, default.defctor, FALSE )
	end if

	if( default.copyletopconst ) then
		hAddLetOpBody( udt, default.copyletopconst )
	end if

	if( default.copyctorconst ) then
		hAddCtorBody( udt, default.copyctorconst, TRUE )
	end if

	if( default.copyctor ) then
		hAddCtorBody( udt, default.copyctor, TRUE )
	end if

	if( default.dtor1 ) then
		hAddCtorBody( udt, default.dtor1, FALSE )
	end if

	if( default.dtor0 ) then
		hAddCtorBody( udt, default.dtor0, FALSE )
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' getters/setters
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

private function hHasByrefSelfParam _
	( _
		byval proc as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as integer

	dim as FBSYMBOL ptr param = any

	function = FALSE
	param = symbGetProcTailParam( proc )

	if( symbGetParamMode( param ) <> FB_PARAMMODE_BYREF ) then
		exit function
	end if

	'' HACK: Allow forward references with the same name
	'' (but CONSTs must still match)
	if( param->typ = typeJoin( dtype, FB_DATATYPE_FWDREF ) ) then
		assert( param->subtype->class = FB_SYMBCLASS_FWDREF )
		if( param->subtype->hash.index = subtype->hash.index ) then
			if( *param->subtype->hash.item->name = *subtype->hash.item->name ) then
				return TRUE
			end if
		end if
	end if

	function = (param->typ = dtype) and (param->subtype = subtype)
end function

'' Check whether UDT doesn't have either of dtor/copy ctor/virtual methods
'' (UDTs that have any of these are handled specially by BYVAL params and
'' function results. For example, BYVAL params do copy construction, and use
'' this function to check whether there is a copyctor and whether a temp copy
'' to be passed byref must be used or not)
function symbCompIsTrivial( byval sym as FBSYMBOL ptr ) as integer
	assert( symbIsStruct( sym ) )
	function = ((symbGetCompCopyCtor( sym ) = NULL) and _
	            (symbGetCompDtor1( sym ) = NULL) and _
	            (not symbGetHasRTTI( sym )))
end function

sub symbSetCompCtorHead( byval sym as FBSYMBOL ptr, byval proc as FBSYMBOL ptr )
	if( symbIsStruct( sym ) ) then
		assert( symbIsConstructor( proc ) )

		symbUdtAllocExt( sym )
		if( sym->udt.ext->ctorhead = NULL ) then
			'' Add ctor head (first overload)
			sym->udt.ext->ctorhead = proc
		end if
	end if
end sub

sub symbCheckCompCtor( byval sym as FBSYMBOL ptr, byval proc as FBSYMBOL ptr )
	if( symbIsStruct( sym ) ) then
		select case( symbGetProcParams( proc ) )
		'' default?
		case 1
			'' only the THIS param  - it's a default ctor
			'' (this takes precedence over other ctors with all optional params)
			sym->udt.ext->defctor = proc

		'' copy?
		case 2
			'' 2 params - it could be a copy ctor
			if( sym->udt.ext->copyctor = NULL ) then
				if( hHasByrefSelfParam( proc, FB_DATATYPE_STRUCT, sym ) ) then
					sym->udt.ext->copyctor = proc
				end if
			end if

			if( sym->udt.ext->copyctorconst = NULL ) then
				if( hHasByrefSelfParam( proc, typeSetIsConst( FB_DATATYPE_STRUCT ), sym ) ) then
					sym->udt.ext->copyctorconst = proc
				end if
			end if
		end select

		'' all params optional? then it can be used as default ctor
		if( sym->udt.ext->defctor = NULL ) then
			if( symbGetProcOptParams( proc ) = symbGetProcParams( proc ) - 1 ) then
				sym->udt.ext->defctor = proc
			end if
		end if
	end if
end sub

sub symbSetCompDtor1( byval sym as FBSYMBOL ptr, byval proc as FBSYMBOL ptr )
	if( symbIsStruct( sym ) ) then
		assert( symbIsDestructor1( proc ) )
		symbUdtAllocExt( sym )
		if( sym->udt.ext->dtor1 = NULL ) then
			'' Add deleting dtor (D1)
			sym->udt.ext->dtor1 = proc
		end if
	end if
end sub

sub symbSetCompDtor0( byval sym as FBSYMBOL ptr, byval proc as FBSYMBOL ptr )
	if( symbIsStruct( sym ) ) then
		assert( symbIsDestructor0( proc ) )
		symbUdtAllocExt( sym )
		if( sym->udt.ext->dtor0 = NULL ) then
			'' Add complete dtor (D0)
			sym->udt.ext->dtor0 = proc
		end if
	end if
end sub

function symbGetCompCtorHead( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	if( sym ) then
		if( symbIsStruct( sym ) ) then
			if( sym->udt.ext ) then
				function = sym->udt.ext->ctorhead
			end if
		end if
	end if
end function

function symbGetCompDefCtor( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	if( sym ) then
		if( symbIsStruct( sym ) ) then
			if( sym->udt.ext ) then
				function = sym->udt.ext->defctor
			end if
		end if
	end if
end function

private function symbGetCompCopyCtor( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	assert( symbIsStruct( sym ) )
	if( sym->udt.ext ) then
		function = sym->udt.ext->copyctor
	end if
end function

function symbGetCompDtor1( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	if( sym ) then
		if( symbIsStruct( sym ) ) then
			if( sym->udt.ext ) then
				function = sym->udt.ext->dtor1
			end if
		end if
	end if
end function

function symbGetCompDtor0( byval sym as FBSYMBOL ptr ) as FBSYMBOL ptr
	if( sym ) then
		if( symbIsStruct( sym ) ) then
			if( sym->udt.ext ) then
				function = sym->udt.ext->dtor0
			end if
		end if
	end if
end function

sub symbCheckCompLetOp( byval sym as FBSYMBOL ptr, byval proc as FBSYMBOL ptr )
	if( symbIsStruct( sym ) ) then
		if( hHasByrefSelfParam( proc, FB_DATATYPE_STRUCT, sym ) ) then
			symbUdtAllocExt( sym )
			sym->udt.ext->copyletop = proc
		end if

		if( hHasByrefSelfParam( proc, typeSetIsConst( FB_DATATYPE_STRUCT ), sym ) ) then
			symbUdtAllocExt( sym )
			sym->udt.ext->copyletopconst = proc
		end if
	end if
end sub

function symbCompHasCopyLetOps( byval udt as FBSYMBOL ptr ) as integer
	assert( symbIsStruct( udt ) )
	if( udt->udt.ext ) then
		function = (udt->udt.ext->copyletop <> NULL) or _
		           (udt->udt.ext->copyletopconst <> NULL)
	end if
end function

'':::::
function symbGetCompOpOvlHead _
	( _
		byval sym as FBSYMBOL ptr, _
		byval op as AST_OP _
	) as FBSYMBOL ptr

	'' self?
	if( astGetOpIsSelf( op ) ) then
		select case symbGetClass( sym )
		case FB_SYMBCLASS_STRUCT
			if( sym->udt.ext = NULL ) then
				return NULL
			end if

			function = symbGetUDTOpOvlTb(sym)(op - AST_OP_SELFBASE)

		case FB_SYMBCLASS_ENUM
			function = NULL

		case FB_SYMBCLASS_CLASS
			'' ...

		end select

	'' not self..
	else
		function = symb.globOpOvlTb(op).head
	end if

end function

'':::::
sub symbSetCompOpOvlHead _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

	dim as AST_OP op = symbGetProcOpOvl( proc )

	'' self?
	if( astGetOpIsSelf( op ) ) then
		if( symbIsStruct( sym ) ) then
			symbUdtAllocExt( sym )
			symbGetUDTOpOvlTb(sym)(op - AST_OP_SELFBASE) = proc
		end if

		'' assign?
		if( op = AST_OP_ASSIGN ) then
			symbCheckCompLetOp( sym, proc )
		end if
	'' not self..
	else
		symb.globOpOvlTb(op).head = proc
	end if

end sub

'' Returns vtable index for new virtual method
function symbCompAddVirtual( byval udt as FBSYMBOL ptr ) as integer
	'' Virtuals require the vptr, i.e. the UDT must extend OBJECT
	assert( symbGetHasRTTI( udt ) )

	symbUdtAllocExt( udt )

	hSetMinimumVtableSize( udt )

	function = udt->udt.ext->vtableelements
	udt->udt.ext->vtableelements += 1
end function

function symbCompGetAbstractCount( byval udt as FBSYMBOL ptr ) as integer
	assert( symbIsStruct( udt ) )
	if( udt->udt.ext ) then
		function = udt->udt.ext->abstractcount
	end if
end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' nesting
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

/'private sub hDumpHashTb
	dim as FBHASHTB ptr hashtb = symb.hashlist.tail
	do
		dim as zstring ptr id = symbGetName( hashtb->owner )
		hashtb = hashtb->prev

		print *iif( id, id, @"main" );
		if( hashtb = NULL ) then
			exit do
		end if
		print ,
	loop

	print
end sub'/

'':::::
private sub hInsertNested _
	( _
		byval sym as FBSYMBOL ptr, _
		byval lasttb as FBHASHTB ptr, _
		byval base_ns as FBSYMBOL ptr _
	)

	dim as FBHASHTB ptr hashtb = any

	'' add all parents to hash list, but the base one

	dim as FBSYMBOL ptr ns = symbGetNamespace( sym )
	do until( ns = base_ns )
		hashtb = @symbGetCompHashTb( ns )

		if( symbGetCompExt( ns ) = NULL ) then
			symbGetCompExt( ns ) = symbCompAllocExt( )
		end if

		symbGetCompExt( ns )->cnt += 1
		if( symbGetCompExt( ns )->cnt <> 1 ) then
			'' remove from import hash tb list
			symbHashListRemoveNamespace( ns )
		end if

		'' add to nested hash tb list
		'' (in reverse other, child ns must be the tail, parents follow)
		symbHashListAddBefore( lasttb, hashtb )

		lasttb = hashtb

		ns = symbGetNamespace( ns )
	loop

end sub

'':::::
private sub hRemoveNested _
	( _
		byval sym as FBSYMBOL ptr, _
		byval base_ns as FBSYMBOL ptr _
	)

	'' remove all parents from the hash list, but the base one

	dim as FBSYMBOL ptr ns = symbGetNamespace( sym )
	do until( ns = base_ns )
		symbGetCompExt( ns )->cnt -= 1

		'' remove from nested hash tb list
		symbHashListDel( @symbGetCompHashTb( ns ) )

		if( symbGetCompExt( ns )->cnt <> 0 ) then
			'' add to import hash tb list
			symbHashListInsertNamespace( ns, _
				symbGetCompSymbTb( ns ).head )
		end if

		ns = symbGetNamespace( ns )
	loop

end sub

'':::::
private sub hInsertImported _
	( _
		byval sym as FBSYMBOL ptr _
	)

	if( symbGetCompExt( sym ) = NULL ) then
		exit sub
	end if

	dim as FBSYMBOL ptr imp_ = symbGetCompImportHead( sym )
	do while( imp_ <> NULL )
		dim as FBSYMBOL ptr ns = symbGetImportNamespc( imp_ )

		if( ns <> NULL ) then
			symbGetCompExt( ns )->cnt += 1
			if( symbGetCompExt( ns )->cnt = 1 ) then
				'' add to import hash tb list
				symbHashListInsertNamespace( ns, _
					symbGetCompSymbTb( ns ).head )
			end if
		end if

		imp_ = symbGetImportNext( imp_ )
	loop

end sub

'':::::
private sub hRemoveImported _
	( _
		byval sym as FBSYMBOL ptr _
	)

	if( symbGetCompExt( sym ) = NULL ) then
		exit sub
	end if

	dim as FBSYMBOL ptr imp_ = symbGetCompImportHead( sym )
	do while( imp_ <> NULL )
		dim as FBSYMBOL ptr ns = symbGetImportNamespc( imp_ )

		if( ns <> NULL ) then
			symbGetCompExt( ns )->cnt -= 1
			if( symbGetCompExt( ns )->cnt = 0 ) then
				'' remove from import hash tb list
				symbHashListRemoveNamespace( ns )
			end if
		end if

		imp_ = symbGetImportNext( imp_ )
	loop

end sub

'':::::
sub symbNestBegin _
	( _
		byval sym as FBSYMBOL ptr, _
		byval insert_chain as integer _
	)

	dim as FB_SYMBNEST ptr n = any
	dim as FBHASHTB ptr hashtb = any
	dim as FBSYMBOLTB ptr symbtb = any

	n = stackPush( @symb.neststk )

	n->sym = sym
	n->symtb = symbGetCurrentSymTb( )
	n->hashtb = symbGetCurrentHashTb( )

	if( symbGetClass( sym ) = FB_SYMBCLASS_PROC ) then
		symbtb = @symbGetProcSymbTb( sym )
		hashtb = NULL
	else
		symbtb = @symbGetCompSymbTb( sym )
		hashtb = @symbGetCompHashTb( sym )
	end if

	symbSetCurrentSymTb( symbtb )

	if( hashtb <> NULL ) then
		n->ns = symbGetCurrentNamespc( )
		symbSetCurrentNamespc( sym )

		symbSetCurrentHashTb( hashtb )

		if( symbGetCompExt( sym ) = NULL ) then
			symbGetCompExt( sym ) = symbCompAllocExt( )
		end if

		symbGetCompExt( sym )->cnt += 1
		if( symbGetCompExt( sym )->cnt <> 1 ) then
			'' remove from import hash tb list
			symbHashListRemoveNamespace( sym )
		end if

		'' add to the nested hash tb list
		symbHashListAdd( hashtb )

		if( insert_chain ) then
			hInsertNested( sym, hashtb, n->ns )
		end if

		'' add all USING's
		hInsertImported( sym )
	end if

end sub

'':::::
sub symbNestEnd _
	( _
		byval remove_chain as integer _
	)

	dim as FB_SYMBNEST ptr n = any
	dim as FBHASHTB ptr hashtb = any
	dim as FBSYMBOL ptr sym = any

	n = stackGetTOS( @symb.neststk )

	sym = n->sym

	if( symbGetClass( sym ) = FB_SYMBCLASS_PROC ) then
		hashtb = NULL
	else
		hashtb = @symbGetCompHashTb( sym )
	end if

	symbSetCurrentSymTb( n->symtb )

	if( hashtb <> NULL ) then
		'' removed all USING's
		hRemoveImported( sym )

		if( remove_chain ) then
			hRemoveNested( sym, n->ns )
		end if

		symbGetCompExt( sym )->cnt -= 1

		'' remove from nested hash tb list
		symbHashListDel( hashtb )

		if( symbGetCompExt( sym )->cnt <> 0 ) then
			'' add to import hash tb list
			symbHashListInsertNamespace( sym, _
				symbGetCompSymbTb( sym ).head )
		end if

		symbSetCurrentHashTb( n->hashtb )

		symbSetCurrentNamespc( n->ns )
	end if

	stackPop( @symb.neststk )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' import and export lists (USING stuff)
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub symbCompAddToImportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr ns = symbGetExportNamespc( imp_ )

	if( symbGetCompExt( ns ) = NULL ) then
		symbGetCompExt( ns ) = symbCompAllocExt( )
	end if

	if( symbGetCompExt( ns )->implist.tail <> NULL ) then
		symbGetCompExt( ns )->implist.tail->nsimp.imp_next = imp_
	else
		symbGetCompExt( ns )->implist.head = imp_
	end if

	imp_->nsimp.imp_prev = symbGetCompExt( ns )->implist.tail
	imp_->nsimp.imp_next = NULL

	symbGetCompExt( ns )->implist.tail = imp_

end sub

'':::::
sub symbCompDelFromImportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr ns = symbGetExportNamespc( imp_ )

	if( imp_->nsimp.imp_prev = NULL ) then
		symbGetCompExt( ns )->implist.head = imp_->nsimp.imp_next
	else
		imp_->nsimp.imp_prev->nsimp.imp_next = imp_->nsimp.imp_next
	end if

	if( imp_->nsimp.imp_next = NULL ) then
		symbGetCompExt( ns )->implist.tail = imp_->nsimp.imp_prev
	else
		imp_->nsimp.imp_next->nsimp.imp_prev = imp_->nsimp.imp_prev
	end if

end sub

'':::::
sub symbCompAddToExportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr ns = symbGetImportNamespc( imp_ )

	if( symbGetCompExt( ns ) = NULL ) then
		symbGetCompExt( ns ) = symbCompAllocExt( )
	end if

	if( symbGetCompExt( ns )->explist.tail <> NULL ) then
		symbGetCompExt( ns )->explist.tail->nsimp.exp_next = imp_
	else
		symbGetCompExt( ns )->explist.head = imp_
	end if

	imp_->nsimp.exp_prev = symbGetCompExt( ns )->explist.tail
	imp_->nsimp.exp_next = NULL

	symbGetCompExt( ns )->explist.tail = imp_

end sub

'':::::
sub symbCompDelFromExportList _
	( _
		byval imp_ as FBSYMBOL ptr _
	)

	dim as FBSYMBOL ptr ns = symbGetImportNamespc( imp_ )

	if( imp_->nsimp.exp_prev = NULL ) then
		symbGetCompExt( ns )->explist.head = imp_->nsimp.exp_next
	else
		imp_->nsimp.exp_prev->nsimp.exp_next = imp_->nsimp.exp_next
	end if

	if( imp_->nsimp.exp_next = NULL ) then
		symbGetCompExt( ns )->explist.tail = imp_->nsimp.exp_prev
	else
		imp_->nsimp.exp_next->nsimp.exp_prev = imp_->nsimp.exp_prev
	end if

end sub

'':::::
sub symbCompDelImportList _
	( _
		byval sym as FBSYMBOL ptr _
	)

	if( symbGetCompExt( sym ) = NULL ) then
		exit sub
	end if

	'' for each namespace importing this ns (because one ns, when
	'' re-implemented, can include another ns that will be removed
	'' first)
	dim as FBSYMBOL ptr exp_ = symbGetCompExportHead( sym )
	do while( exp_ <> NULL )

		symbCompDelFromImportList( exp_ )

		dim as FBSYMBOL ptr nxt = symbGetExportNext( exp_ )
		symbCompDelFromExportList( exp_ )

		'' not a type, that's to tell NamespaceRemove() to not remove the same ns again
		symbGetImportNamespc( exp_ ) = NULL

		exp_ = nxt
	loop

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' RTTI
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

sub symbCompRTTIInit( )
	dim as FBSYMBOL ptr rttitype = any, objtype = any, objrtti = any, ctor = any

	static as FBARRAYDIM dTB(0)

	'' type fb_RTTI$
	'' (using fb_RTTI$ instead of $fb_RTTI to prevent gdb/stabs confusion,
	'' where leading $ has special meaning)
	rttitype = symbStructBegin( NULL, NULL, NULL, "fb_RTTI$", "fb_RTTI$", FALSE, 0, FALSE, 0, 0 )
	symb.rtti.fb_rtti = rttitype

	'' stdlibvtable as any ptr
	symbAddField( rttitype, "stdlibvtable", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

	'' dim id as zstring ptr
	symbAddField( rttitype, "id", 0, dTB(), typeAddrOf( FB_DATATYPE_CHAR ), NULL, 0, 0, 0 )

	'' dim rttibase as fb_RTTI$ ptr
	symbAddField( rttitype, "rttibase", 0, dTB(), typeAddrOf( FB_DATATYPE_STRUCT ), rttitype, 0, 0, 0 )

	'' end type
	symbStructEnd( rttitype )

	'' type object
	dim as const zstring ptr ptypename = any
	if( fbLangIsSet( FB_LANG_QB ) ) then
		ptypename = @"__OBJECT"
	else
		ptypename = @"OBJECT"
	end if
	'' (using fb_Object$ instead of $fb_Object - ditto)
	objtype = symbStructBegin( NULL, NULL, NULL, ptypename, "fb_Object$", FALSE, 0, FALSE, 0, 0 )
	symb.rtti.fb_object = objtype
	symbSetHasRTTI( objtype )
	symbSetIsUnique( objtype )
	symbNestBegin( objtype, FALSE )

	'' vptr as any ptr
	'' (using vptr$ instead of $vptr - ditto)
	symbAddField( objtype, "vptr$", 0, dTB(), typeAddrOf( FB_DATATYPE_VOID ), NULL, 0, 0, 0 )

	dim mode as FB_FUNCMODE = FB_FUNCMODE_CDECL

	'' !!!TODO!!! is this required for OBJECT and RTTI?
	''if( parser.mangling = FB_MANGLING_CPP ) then
	''  if( env.clopt.target = FB_COMPTARGET_WIN32 ) then
	''      if( fbIs64bit( ) = FALSE ) then
	''          if( env.clopt.nothiscall = FALSE ) then
	''              mode = FB_FUNCMODE_THISCALL
	''          end if
	''      end if
	''  end if
	''end if

	'' declare constructor( )
	ctor = symbPreAddProc( NULL )
	symbAddProcInstanceParam( objtype, ctor )
	symbAddCtor( ctor, NULL, FB_SYMBATTRIB_NONE, _
	                         FB_PROCATTRIB_METHOD or FB_PROCATTRIB_CONSTRUCTOR or FB_PROCATTRIB_OVERLOADED, _
	                         mode )

	'' declare constructor( byref __FB_RHS__ as const object )
	'' (must have a BYREF AS CONST parameter so it can copy from CONST objects too)
	ctor = symbPreAddProc( NULL )
	symbAddProcInstanceParam( objtype, ctor )
	symbAddProcParam( ctor, "__FB_RHS__", typeSetIsConst( FB_DATATYPE_STRUCT ), objtype, _
			0, FB_PARAMMODE_BYREF, FB_SYMBATTRIB_NONE, FB_PROCATTRIB_NONE )
	symbAddCtor( ctor, NULL, FB_SYMBATTRIB_NONE, _
	                         FB_PROCATTRIB_METHOD or FB_PROCATTRIB_CONSTRUCTOR or FB_PROCATTRIB_OVERLOADED, _
	                         mode )

	'' end type
	symbStructEnd( objtype, TRUE )

	'' declare extern shared as fb_RTTI$ __fb_ZTS6Object (the Object class RTTI instance created in C)
	objrtti = symbAddVar( NULL, "__fb_ZTS6Object", FB_DATATYPE_STRUCT, symb.rtti.fb_rtti, 0, 0, dTB(), _
	                      FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_SHARED, FB_SYMBOPT_PRESERVECASE )

	'' update the obj struct RTTI (used to create the link with base classes)
	symbUdtAllocExt( objtype )
	objtype->udt.ext->rtti = objrtti
end sub

sub symbCompRTTIEnd()
end sub
