'' complex/compound/composite symbols helper functions
''
'' chng: sep/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "hash.bi"
#include once "list.bi"
#include once "ir.bi"

type FB_SYMBNEST
	sym				as FBSYMBOL ptr
	symtb			as FBSYMBOLTB ptr			'' prev symbol tb
	hashtb			as FBHASHTB ptr				'' prev hash tb
	ns				as FBSYMBOL ptr				'' prev namespace
end type

'':::::
sub symbCompInit
	dim as integer i

	for i = 0 to AST_OPCODES-1
		symb.globOpOvlTb(i).head = NULL
	next

	''
	stackNew( @symb.neststk, 16, len( FB_SYMBNEST ), FALSE )
	
end sub

'':::::
sub symbCompEnd

	stackFree( @symb.neststk )

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' default ctors
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hAddRhsParam _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) static

	dim as integer dtype

	select case symbGetClass( parent )
	case FB_SYMBCLASS_STRUCT
		dtype = FB_DATATYPE_STRUCT
	case FB_SYMBCLASS_CLASS
		'dtype = FB_DATATYPE_CLASS
	end select

	symbAddProcParam( proc, "__FB_RHS__", dtype, parent, FB_POINTERSIZE, _
	                  FB_PARAMMODE_BYREF, FB_SYMBATTRIB_NONE, NULL )

end sub

private function hProcBegin _
	( _
		byval parent as FBSYMBOL ptr, _
		byval op as AST_OP, _
		byval add_rhs as integer, _
		byval attrib as FB_SYMBATTRIB _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr proc = any

	symbNestBegin( parent, TRUE )

	proc = symbPreAddProc( NULL )

	'' add "this"
	symbAddProcInstancePtr( parent, proc )

	'' add right-side hand param?
	if( add_rhs ) then
		hAddRhsParam( parent, proc )
	end if

	'' cons|destructor?
	if( op = INVALID ) then
		proc = symbAddCtor( proc, NULL, _
		                    attrib or FB_SYMBATTRIB_METHOD or _
		                              FB_SYMBATTRIB_PRIVATE, _
		                    FB_FUNCMODE_CDECL, _
		                    FB_SYMBOPT_DECLARING )

	'' op..
	else
		proc = symbAddOperator( proc, op, NULL, FB_DATATYPE_VOID, NULL, _
		                        attrib or FB_SYMBATTRIB_METHOD or _
		                                  FB_SYMBATTRIB_PRIVATE, _
		                        FB_FUNCMODE_CDECL, _
		                        FB_SYMBOPT_DECLARING )
	end if

	astProcBegin( proc, FALSE )
    symbSetProcIncFile( proc, env.inf.incfile )
	astAdd( astNewLABEL( astGetProcInitlabel( ast.proc.curr ) ) )

	function = proc
end function

private sub hProcEnd( )
	'' end cons|destructor
	astProcEnd( FALSE )
	symbNestEnd( TRUE )
end sub

':::::
private sub hCopyCtorBody _
	( _
		byval proc as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr this_, src

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )
	src = symbGetParamVar( symbGetProcTailParam( proc ) )

    '' assign op overload will do the rest

    astAdd( astNewASSIGN( astBuildInstPtr( this_ ), astBuildInstPtr( src ) ) )

end sub

'':::::
private sub hAddCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval is_ctor as integer, _
		byval is_copyctor as integer _
	)

	dim as FBSYMBOL ptr proc = any

	proc = hProcBegin( sym, INVALID, is_copyctor, _
	                   iif( is_ctor, FB_SYMBATTRIB_OVERLOADED or FB_SYMBATTRIB_CONSTRUCTOR, _
	                                 FB_SYMBATTRIB_DESTRUCTOR ) )

	'' call to the static ctor will be added by the ast

	if( is_copyctor ) then
		hCopyCtorBody( proc )
	end if

	'' ditto for the dtor's

	hProcEnd( )

	'' hasC|Dtor flags will be set by symbAddCtor()

	symbSetCantUndef( sym )

end sub

private sub hAddRTTI _
	( _
		byval sym as FBSYMBOL ptr _ 
	)
	
	static as FBARRAYDIM dTB(0)
	
	var mname = *symbGetMangledName( sym )
	
	if( sym->udt.ext = NULL ) then
		sym->udt.ext = callocate( len( FB_STRUCTEXT ) )
	end if

	'' create a virtual-table struct (extends $fb_BaseVT)
	var sname = "_ZTV" + mname + "_type"
	var vtableType = symbStructBegin( NULL, sname, sname, FALSE, 0, symb.rtti.fb_baseVT )
		
	'' TODO: add this symbol's virtual methods as function pointers with "this" as the first param
	
	symbStructEnd( vtableType, TRUE )
	
	'' create the run-time info instance ($fb_RTTI)
	sname = "_ZTS" + *symbGetMangledName( sym )
	var rtti = symbAddVarEx( NULL, sname, _
						     FB_DATATYPE_STRUCT, symb.rtti.fb_rtti, _
						     symbGetLen( symb.rtti.fb_rtti ), _
						     0, dTB(), _
						     FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_STATIC or FB_SYMBATTRIB_SHARED, _
						     FB_SYMBOPT_PRESERVECASE )
	
	sym->udt.ext->rtti = rtti
	
	'' initialize..
	var initree = astTypeIniBegin( FB_DATATYPE_STRUCT, symb.rtti.fb_rtti, FALSE, 0 )	
		astTypeIniScopeBegin( initree, rtti )
	
			'' stdlistVT = NULL
			var elm = symbGetUDTFirstElm( symb.rtti.fb_rtti )
			astTypeIniAddAssign( initree, astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ), NULL ), elm )
			
			'' id = @"mangled name"
			elm = symbGetUDTNextElm( elm, FALSE )
			astTypeIniAddAssign( initree, astNewADDROF( astNewVAR( symbAllocStrConst( mname, len( mname ) ), 0, FB_DATATYPE_CHAR ) ), elm )
			
			'' pRTTIBase = @base's RTTI struct
			elm = symbGetUDTNextElm( elm, FALSE )
			astTypeIniAddAssign( initree, astNewADDROF( astNewVAR( symbGetSubtype( sym->udt.base )->udt.ext->rtti, 0 ) ), elm )
	
		astTypeIniScopeEnd( initree, rtti )
	astTypeIniEnd( initree, TRUE ) 
	
	symbSetTypeIniTree( rtti, initree )
	symbSetIsInitialized( rtti )
	

	'' create the vtable instance
	sname = "_ZTV" + mname

	var vtable = symbAddVarEx( NULL, sname, _
						       FB_DATATYPE_STRUCT, vtableType, _
						       symbGetLen( vtableType ), _
						       0, dTB(), _
						       FB_SYMBATTRIB_CONST or FB_SYMBATTRIB_STATIC or FB_SYMBATTRIB_SHARED, _
						       FB_SYMBOPT_PRESERVECASE )
	
	sym->udt.ext->vtable = vtable
	
	'' initialize..
	initree = astTypeIniBegin( FB_DATATYPE_STRUCT, vtableType, FALSE, 0 )	
		astTypeIniScopeBegin( initree, vtable )
			astTypeIniScopeBegin( initree, vtable )
		
				'' base.nullPtr = NULL	
				elm = symbGetUDTFirstElm( symb.rtti.fb_baseVT )
				astTypeIniAddAssign( initree, astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ), NULL ), elm )
			
				'' base.pRTTI = @rtti
				elm = symbGetUDTNextElm( elm, FALSE )
				astTypeIniAddAssign( initree, astNewADDROF( astNewVAR( rtti, 0 ) ), elm )

			astTypeIniScopeEnd( initree, vtable )
		astTypeIniScopeEnd( initree, vtable )
	astTypeIniEnd( initree, TRUE ) 
	
	symbSetTypeIniTree( vtable, initree )
	symbSetIsInitialized( vtable )
	
End Sub

'':::::
private sub hAssignList _
	( _
		byval fld as FBSYMBOL ptr, _
		byval dstexpr as ASTNODE ptr, _
		byval srcexpr as ASTNODE ptr _
	) static

	dim as FBSYMBOL ptr cnt, label, dst, src, subtype

	subtype = symbGetSubtype( fld )

    cnt = symbAddTempVar( FB_DATATYPE_INTEGER, NULL )
    label = symbAddLabel( NULL )
    dst = symbAddTempVar( typeAddrOf( symbGetType( fld ) ), subtype )
    src = symbAddTempVar( typeAddrOf( symbGetType( fld ) ), subtype )

    '' dst = @this.dst(0)
    astAdd( astBuildVarAssign( dst, astNewADDROF( dstexpr ) ) )
    '' src = @this.src(0)
    astAdd( astBuildVarAssign( src, astNewADDROF( srcexpr ) ) )

	'' for cnt = 0 to symbGetArrayElements( dst )-1
	astAdd( astBuildForBegin( NULL, cnt, label, 0 ) )

    '' *dst = *src
    astAdd( astNewASSIGN( astBuildVarDeref( dst ), astBuildVarDeref( src ) ) )

	'' dst += 1
    astAdd( astBuildVarInc( dst, 1 ) )
	'' src += 1
    astAdd( astBuildVarInc( src, 1 ) )

	'' next
	astAdd( astBuildForEnd( NULL, cnt, label, 1, astNewCONSTi( symbGetArrayElements( fld ) ) ) )

end sub

'':::::
private function hCopyUnionFields _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval rhs as FBSYMBOL ptr, _
		byval base_fld as FBSYMBOL ptr _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr fld = any
	dim as integer bytes = any, lgt = any, base_ofs = any

	'' merge all union fields
	fld = base_fld
	bytes = 0
	base_ofs = symbGetOfs( base_fld )

	do
		lgt = (symbGetLen( fld ) * symbGetArrayElements( fld )) + _
			  (symbGetOfs( fld ) - base_ofs)
		if( lgt > bytes ) then
			bytes = lgt
		end if

		fld = fld->next
		if( fld = NULL ) then
			exit do
		end if
	loop while( symbGetIsUnionField( fld ) )

    '' copy all them at once
	astAdd( astNewMEM( AST_OP_MEMMOVE, _
    	  	  		   astBuildInstPtr( this_, base_fld ), _
    	  	  		   astBuildInstPtr( rhs, base_fld ), _
    	  	  		   bytes ) )

	function = fld

end function

':::::
private sub hCloneBody _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr fld, this_, rhs
	dim as ASTNODE ptr dstexpr, srcexpr

	this_ = symbGetParamVar( symbGetProcHeadParam( proc ) )
	rhs = symbGetParamVar( symbGetProcTailParam( proc ) )

    '' for each field
    fld = symbGetCompSymbTb( parent ).head
    do while( fld <> NULL )

		if( symbIsField( fld ) ) then

			'' part of an union?
			if( symbGetIsUnionField( fld ) ) then
				fld = hCopyUnionFields( this_, rhs, fld )
				continue do

			else
				dstexpr = astBuildInstPtr( this_, fld )
				srcexpr = astBuildInstPtr( rhs, fld )

            	'' not an array?
            	if( (symbGetArrayDimensions( fld ) = 0) or _
            		(symbGetArrayElements( fld ) = 1) ) then

					'' this.field = rhs.field
            		astAdd( astNewASSIGN( dstexpr, srcexpr ) )

            	'' array..
            	else
            		hAssignList( fld, dstexpr, srcexpr )
            	end if
            end if
		end if

		fld = fld->next
	loop

end sub

private sub hAddClone( byval sym as FBSYMBOL ptr )
	dim as FBSYMBOL ptr proc = any
	proc = hProcBegin( sym, AST_OP_ASSIGN, TRUE, _
	                   FB_SYMBATTRIB_OVERLOADED or FB_SYMBATTRIB_OPERATOR )
	hCloneBody( sym, proc )
	hProcEnd( )
	symbSetCantUndef( sym )
end sub

sub symbCompAddDefDtor( byval sym as FBSYMBOL ptr )
	hAddCtor( sym, FALSE, FALSE )
end sub

sub symbCompAddDefCtor( byval sym as FBSYMBOL ptr )
	hAddCtor( sym, TRUE, FALSE )
end sub

sub symbCompAddDefMembers( byval sym as FBSYMBOL ptr )
	'' RTTI?
	if( symbGetHasRTTI( sym ) ) then
		'' only if it isn't FB's own Object base super class
		if( sym <> symb.rtti.fb_object ) then
			hAddRTTI( sym )
		end if
	end if

	'' has fields with ctors?
	if( symbGetUDTHasCtorField( sym ) ) then
		'' any ctor explicitly defined?
		if( symbGetHasCtor( sym ) = FALSE ) then
			'' no default ctor?
			if( symbGetCompDefCtor( sym ) = NULL ) then
				hAddCtor( sym, TRUE, FALSE )
			end if
		end if

		'' must be defined before the copy ctor
		if( symbGetCompCloneProc( sym ) = NULL ) then
			hAddClone( sym )
		end if

		if( symbGetCompCopyCtor( sym ) = NULL ) then
			hAddCtor( sym, TRUE, TRUE )
		end if
	end if

	'' has fields with dtors?
	if( symbGetUDTHasDtorField( sym ) ) then
		'' no default dtor explicitly defined?
		if( symbGetCompDtor( sym ) = NULL ) then
			hAddCtor( sym, FALSE, FALSE )
		end if
	end if
end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' getters/setters
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hIsLhsEqRhs _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as integer static

	dim as FBSYMBOL ptr param, subtype

	function = FALSE

	param = symbGetProcTailParam( proc )
	if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
		subtype = symbGetSubtype( param )

		if( subtype = NULL ) then
			return FALSE
		end if

		'' forward?
		if( symbGetClass( subtype ) = FB_SYMBCLASS_FWDREF ) then
			'' not a pointer?
			if( symbGetType( param ) = FB_DATATYPE_FWDREF ) then
				'' same name?
				if( subtype->hash.index = parent->hash.index ) then
					return TRUE
				end if
			end if

			return FALSE
		end if

		if( subtype = parent ) then
			select case symbGetClass( parent )
			case FB_SYMBCLASS_STRUCT
				function = ( symbGetType( param ) = FB_DATATYPE_STRUCT )

			case FB_SYMBCLASS_CLASS
				'...
			end select
		end if
	end if

end function

'':::::
function symbGetCompCtorHead _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

    if( sym = NULL ) then
    	return NULL
    end if

    select case symbGetClass( sym )
    case FB_SYMBCLASS_STRUCT
    	if( sym->udt.ext = NULL ) then
    		return NULL
    	else
    		return sym->udt.ext->anon.ctor_head
    	end if

    case FB_SYMBCLASS_CLASS
    	'return ...

    case else
    	return NULL
    end select

end function

'':::::
sub symbSetCompCtorHead _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) static

  	select case symbGetClass( sym )
   	case FB_SYMBCLASS_STRUCT
		if( sym->udt.ext = NULL ) then
			sym->udt.ext = xcallocate( len( FB_STRUCTEXT ) )
		end if

		sym->udt.ext->anon.ctor_head = proc

   	case FB_SYMBCLASS_CLASS
    	'' ...

   	end select

end sub

'':::::
sub symbCheckCompCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) static

  	select case symbGetClass( sym )
   	case FB_SYMBCLASS_STRUCT
		select case symbGetProcParams( proc )
		'' default?
		case 1
			sym->udt.ext->anon.defctor = proc

		'' copy?
		case 2
			if( sym->udt.ext->anon.copyctor = NULL ) then
				if( hIsLhsEqRhs( sym, proc ) ) then
					sym->udt.ext->anon.copyctor = proc
				end if
			end if
		end select

		'' if all params are default/optional, it's a default ctor
		if( sym->udt.ext->anon.defctor = NULL ) then
           	if( symbGetProcOptParams( proc ) = _
           		symbGetProcParams( proc ) - 1 ) then
           		sym->udt.ext->anon.defctor = proc
           	end if
		end if

   	case FB_SYMBCLASS_CLASS
    	'' ...

   	end select

end sub

'':::::
function symbGetCompDefCtor _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr proc

    if( sym = NULL ) then
    	return NULL
    end if

    select case symbGetClass( sym )
    case FB_SYMBCLASS_STRUCT
    	if( sym->udt.ext = NULL ) then
    		return NULL
    	else
    		return sym->udt.ext->anon.defctor
    	end if

    case FB_SYMBCLASS_CLASS
    	'return ...

    case else
    	return NULL
    end select

end function

'':::::
function symbGetCompCopyCtor _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr proc

    if( sym = NULL ) then
    	return NULL
    end if

    select case symbGetClass( sym )
    case FB_SYMBCLASS_STRUCT
    	if( sym->udt.ext = NULL ) then
    		return NULL
    	else
    		return sym->udt.ext->anon.copyctor
    	end if

    case FB_SYMBCLASS_CLASS
    	'return ...

    case else
    	return NULL
    end select

end function

'':::::
function symbGetCompDtor _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

    if( sym = NULL ) then
    	return NULL
    end if

    select case symbGetClass( sym )
    case FB_SYMBCLASS_STRUCT
    	if( sym->udt.ext = NULL ) then
    		return NULL
    	else
    		return sym->udt.ext->anon.dtor
    	end if

    case FB_SYMBCLASS_CLASS
    	'return ...

    case else
    	return NULL
    end select

end function

'':::::
sub symbSetCompDtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) static

  	select case symbGetClass( sym )
   	case FB_SYMBCLASS_STRUCT
		if( sym->udt.ext = NULL ) then
			sym->udt.ext = xcallocate( len( FB_STRUCTEXT ) )
		end if

		sym->udt.ext->anon.dtor = proc

   	case FB_SYMBCLASS_CLASS
    	'' ...

   	end select

end sub

'':::::
function symbGetCompCloneProc _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOL ptr static

    if( sym = NULL ) then
    	return NULL
    end if

    select case symbGetClass( sym )
    case FB_SYMBCLASS_STRUCT
   		if( sym->udt.ext = NULL ) then
   			return NULL
   		end if

    	return sym->udt.ext->anon.clone

    case FB_SYMBCLASS_CLASS
    	'return ...

    case else
    	return NULL
    end select

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
sub symbCheckCompClone _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) static

  	'' clone?
  	if( hIsLhsEqRhs( sym, proc ) ) then
  		select case symbGetClass( sym )
   		case FB_SYMBCLASS_STRUCT
   			sym->udt.ext->anon.clone = proc

   		case FB_SYMBCLASS_CLASS
   	 		'' ...

   		end select
   	end if

end sub

'':::::
sub symbSetCompOpOvlHead _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

	dim as AST_OP op = symbGetProcOpOvl( proc )

   	'' self?
   	if( astGetOpIsSelf( op ) ) then
  		select case symbGetClass( sym )
   		case FB_SYMBCLASS_STRUCT
			if( sym->udt.ext = NULL ) then
				sym->udt.ext = xcallocate( len( FB_STRUCTEXT ) )
			end if

			symbGetUDTOpOvlTb(sym)(op - AST_OP_SELFBASE) = proc

   		case FB_SYMBCLASS_ENUM

		case FB_SYMBCLASS_CLASS
   			'' ...

   		end select

    	'' assign?
    	if( op = AST_OP_ASSIGN ) then
    		symbCheckCompClone( sym, proc )
    	end if

    '' not self..
    else
   		symb.globOpOvlTb(op).head = proc
   	end if

end sub

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

sub symbCompRTTIInit()
	static as FBARRAYDIM dTB(0)

    '' create the $fb_RTTI struct
    var rtti = symbStructBegin( NULL, "$fb_RTTI", "$fb_RTTI", FALSE, 0 )
	symb.rtti.fb_rtti = rtti

	'' stdlibVT as any ptr
	symbAddField( rtti, _
				  "stdlibVT", _
				  0, dTB(), _
				  typeAddrOf( FB_DATATYPE_VOID ), NULL, _
				  FB_POINTERSIZE, 0 )

	'' dim id as zstring ptr 
	symbAddField( rtti, _
				  "id", _
				  0, dTB(), _
				  typeAddrOf( FB_DATATYPE_CHAR ), NULL, _
				  FB_POINTERSIZE, 0 )

	'' dim pRTTIBase as $fb_RTTI ptr
	symbAddField( rtti, _
				  "pRTTIBase", _
				  0, dTB(), _
				  typeAddrOf( FB_DATATYPE_STRUCT ), rtti, _
				  FB_POINTERSIZE, 0 )

	symbStructEnd( rtti )

	'' create the $fb_BaseVT struct
    var baseVT = symbStructBegin( NULL, "$fb_BaseVT", "$fb_BaseVT", FALSE, 0 )
	symb.rtti.fb_baseVT = baseVT
    
	'' dim nullPtr as any ptr
	symbAddField( baseVT, _
				  "nullPtr", _
				  0, dTB(), _
				  typeAddrOf( FB_DATATYPE_VOID ), NULL, _
				  FB_POINTERSIZE, 0 )

	'' dim pRTTIBase as $fb_RTTI ptr
	symbAddField( baseVT, _
				  "pRTTI", _
				  0, dTB(), _
				  typeAddrOf( FB_DATATYPE_STRUCT ), rtti, _
				  FB_POINTERSIZE, 0 )

	symbStructEnd( baseVT )

	'' create the $fb_ObjectVT struct (extends $fb_BaseVT)
	var objVT = symbStructBegin( NULL, "$fb_ObjectVT", "$fb_ObjectVT", FALSE, 0, baseVT )

	symbStructEnd( objVT, TRUE )

	'' create the $fb_Object struct (the built-in type called [__]OBJECT)
	dim as const zstring ptr ptypename = any
	if( fbLangIsSet( FB_LANG_QB ) ) then
		ptypename = @"__OBJECT"
	else
		ptypename = @"OBJECT"
	end if

	var obj = symbStructBegin( NULL, ptypename, "$fb_Object", FALSE, 0 )
    symb.rtti.fb_object = obj

	symbSetHasRTTI( obj )
	symbSetIsUnique( obj )
	symbNestBegin( obj, FALSE )

	'' dim pvt as as $fb_BaseVT ptr
	symbAddField( obj, _
				  "$fb_pvt", _
				  0, dTB(), _
				  typeAddrOf( FB_DATATYPE_STRUCT ), baseVT, _
				  FB_POINTERSIZE, 0 )

    '' declare constructor( )
	var ctor = symbPreAddProc( NULL )    

	symbAddProcInstancePtr( obj, ctor )

	symbAddCtor( ctor, NULL, _
	             FB_SYMBATTRIB_METHOD or FB_SYMBATTRIB_CONSTRUCTOR _
	                                  or FB_SYMBATTRIB_OVERLOADED, _
	             FB_FUNCMODE_CDECL )

	symbStructEnd( obj, TRUE )
	
    '' declare extern shared as $fb_RTTI __fb_ZTS6Object (the Object class RTTI instance created in C)
    var objRTTI = symbAddVarEx( NULL, "__fb_ZTS6Object", _
    							FB_DATATYPE_STRUCT, symb.rtti.fb_rtti, _
    							symbGetLen( symb.rtti.fb_rtti ), 0, dTB(), _
    							FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_SHARED, _ 
    							FB_SYMBOPT.FB_SYMBOPT_PRESERVECASE )

	'' update the obj struct RTTI (used to create the link with base classes)
	if( obj->udt.ext = NULL ) then
		obj->udt.ext = callocate( sizeof( FB_STRUCTEXT ) )
	end if

	obj->udt.ext->rtti = objRTTI     
end sub

sub symbCompRTTIEnd()
end sub
