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


'' complex/compound/composite symbols helper functions
''
'' chng: sep/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\hash.bi"
#include once "inc\list.bi"
#include once "inc\ir.bi"

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

	symbAddProcParam( proc, "{rhs}", _
    				  dtype, parent, 0, _
    				  FB_POINTERSIZE, FB_PARAMMODE_BYREF, INVALID, _
    				  FB_SYMBATTRIB_NONE, NULL )

end sub

'':::::
private function hProcBegin _
	( _
		byval parent as FBSYMBOL ptr, _
		byval op as AST_OP, _
		byval attrib as FB_SYMBATTRIB, _
		byval add_rhs as integer, _
		byref proc as FBSYMBOL ptr _
	) as ASTNODE ptr static

	dim as ASTNODE ptr node

	symbNestBegin( parent, TRUE )

	proc = symbPreAddProc( NULL )

	'' add "this"
	symAddProcInstancePtr( parent, proc )

	'' add right-side hand param?
	if( add_rhs ) then
		hAddRhsParam( parent, proc )
	end if

	'' cons|destructor?
	if( op = INVALID ) then
		proc = symbAddCtor( proc, _
							NULL, _
							NULL, 	_
							attrib or FB_SYMBATTRIB_METHOD or FB_SYMBATTRIB_PRIVATE, _
							FB_FUNCMODE_CDECL, _
							FB_SYMBOPT_DECLARING )

	'' op..
	else
		proc = symbAddOperator( proc, _
								op, _
								NULL, _
								NULL, _
								FB_DATATYPE_VOID, NULL, 0, _
								attrib or FB_SYMBATTRIB_METHOD or FB_SYMBATTRIB_PRIVATE, _
								FB_FUNCMODE_CDECL, _
								FB_SYMBOPT_DECLARING )
	end if

    ''
	node = astProcBegin( proc, FALSE )

    symbSetProcIncFile( proc, env.inf.incfile )

   	astAdd( astNewLABEL( astGetProcInitlabel( node ) ) )

	function = node

end function

'':::::
private sub hProcEnd _
	( _
		byval parent as FBSYMBOL ptr, _
		byval node as ASTNODE ptr _
	)

	'' end cons|destructor
	astProcEnd( node, FALSE )

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
	) static

	dim as ASTNODE ptr proc_node
	dim as FBSYMBOL ptr proc

   	'' if the UDT has no ctors fields, don't add a copy or default ctor
   	select case symbGetClass( sym )
   	case FB_SYMBCLASS_STRUCT
   		if( symbGetUDTHasCtorField( sym ) = FALSE ) then
   			exit sub
   		end if

   	case FB_SYMBCLASS_CLASS
   		'' ...

   	end select

    proc_node = hProcBegin( sym, _
    						INVALID, _
    						iif( is_ctor, _
    							 FB_SYMBATTRIB_OVERLOADED or FB_SYMBATTRIB_CONSTRUCTOR, _
    							 FB_SYMBATTRIB_DESTRUCTOR ), _
    						is_copyctor, _
    						proc )


	'' call to the static ctor will be added by the ast

	if( is_copyctor ) then
		hCopyCtorBody( proc )
	end if

	'' ditto for the dtor's

	hProcEnd( sym, proc_node )

	'' hasC|Dtor flags will be set by symbAddCtor()

	symbSetCantUndef( sym )

end sub

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
    label = symbAddLabel( NULL, TRUE )
    dst = symbAddTempVar( FB_DATATYPE_POINTER + symbGetType( fld ), subtype )
    src = symbAddTempVar( FB_DATATYPE_POINTER + symbGetType( fld ), subtype )

    '' dst = @this.dst(0)
    astAdd( astBuildVarAssign( dst, astNewADDR( AST_OP_ADDROF, dstexpr ) ) )
    '' src = @this.src(0)
    astAdd( astBuildVarAssign( src, astNewADDR( AST_OP_ADDROF, srcexpr ) ) )

	'' for cnt = 0 to symbGetArrayElements( dst )-1
	astBuildForBegin( cnt, label, 0 )

    '' *dst = *src
    astAdd( astNewASSIGN( astBuildVarDeref( dst ), astBuildVarDeref( src ) ) )

	'' dst += 1
    astAdd( astBuildVarInc( dst, 1 ) )
	'' src += 1
    astAdd( astBuildVarInc( src, 1 ) )

    '' next
    astBuildForEnd( cnt, label, 1, symbGetArrayElements( fld ) )

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
    fld = symbGetCompSymbTb( parent )->head
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

'':::::
private sub hAddClone _
	( _
		byval sym as FBSYMBOL ptr _
	) static

	dim as ASTNODE ptr proc_node
	dim as FBSYMBOL ptr proc

    '' if the UDT has no ctors fields, don't add a clone
    select case symbGetClass( sym )
    case FB_SYMBCLASS_STRUCT
    	if( symbGetUDTHasCtorField( sym ) = FALSE ) then
    		exit sub
    	end if

    case FB_SYMBCLASS_CLASS
    	'' ...

    end select

    proc_node = hProcBegin( sym, _
    						AST_OP_ASSIGN, _
    						FB_SYMBATTRIB_OVERLOADED or FB_SYMBATTRIB_OPERATOR, _
    						TRUE, _
    						proc )

	hCloneBody( sym, proc )

	hProcEnd( sym, proc_node )

	symbSetCantUndef( sym )

end sub

'':::::
sub symbCompAddDefMembers _
	( _
		byval sym as FBSYMBOL ptr _
	) static

	'' has a ctor?
	if( symbGetHasCtor( sym ) ) then
		if( symbGetCompDefCtor( sym ) = NULL ) then
			hAddCtor( sym, TRUE, FALSE )
		end if

		'' must be defined before the copy ctor
		if( symbGetCompCloneProc( sym ) = NULL ) then
			hAddClone( sym )
		end if

		if( symbGetCompCopyCtor( sym ) = NULL ) then
			hAddCtor( sym, TRUE, TRUE )
		end if
	end if

	'' has a dtor?
	if( symbGetHasDtor( sym ) ) then
		if( symbGetCompDtor( sym ) = NULL ) then
			hAddCtor( sym, FALSE, FALSE )
		end if
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' lookup
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
function symbLookupCompField _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr _
	) as FBSYMBOL ptr static

	static as zstring * FB_MAXNAMELEN+1 fname
	dim as FBHASHTB ptr hashtb
	dim as FBSYMCHAIN ptr chain_
	dim as FBSYMBOL ptr sym

	if( parent = NULL ) then
		return NULL
	end if

    hUcase( id, fname )

    hashtb = symbGetCompHashTb( parent )

    chain_ = hashLookup( @hashtb->tb, fname )

    '' since methods don't start a new hash, params and local
    '' symbol dups will also be found
    do while( chain_ <> NULL )
    	sym = chain_->sym
    	if( symbGetParent( sym ) = parent ) then
    		return sym
    	end if

    	chain_ = chain_->next
    loop

    function = NULL

end function

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' getters/setters
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hIsLhsEqRhs _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	) as integer static

	dim as FBSYMBOL ptr param

	function = FALSE

	param = symbGetProcTailParam( proc )
	if( symbGetParamMode( param ) = FB_PARAMMODE_BYREF ) then
		if( symbGetSubtype( param ) = parent ) then
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
function symbGetCompSymbTb _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBSYMBOLTB ptr static

    if( sym = NULL ) then
    	return NULL
    end if

	select case as const symbGetClass( sym )
	case FB_SYMBCLASS_NAMESPACE
		return @symbGetNamespaceSymbTb( sym )

	case FB_SYMBCLASS_STRUCT
		return @symbGetUdtSymbTb( sym )

	case FB_SYMBCLASS_CLASS
		'return @symbGetClassSymbTb( sym )

    case else
    	return NULL
	end select

end function

'':::::
function symbGetCompHashTb _
	( _
		byval sym as FBSYMBOL ptr _
	) as FBHASHTB ptr static

    if( sym = NULL ) then
    	return NULL
    end if

	select case as const symbGetClass( sym )
	case FB_SYMBCLASS_NAMESPACE
		return @symbGetNamespaceHashTb( sym )

	case FB_SYMBCLASS_STRUCT
		return @symbGetUdtHashTb( sym )

	case FB_SYMBCLASS_CLASS
		'return @symbGetClassHashTb( sym )

    case else
    	return NULL
	end select

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
			sym->udt.ext = callocate( len( FB_STRUCTEXT ) )
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
			sym->udt.ext = callocate( len( FB_STRUCTEXT ) )
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
sub symbSetCompOpOvlHead _
	( _
		byval sym as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr _
	)

	dim as AST_OP op = proc->proc.ext->opovl.op

   	'' self?
   	if( astGetOpIsSelf( op ) ) then
  		select case symbGetClass( sym )
   		case FB_SYMBCLASS_STRUCT
			if( sym->udt.ext = NULL ) then
				sym->udt.ext = callocate( len( FB_STRUCTEXT ) )
			end if

			symbGetUDTOpOvlTb(sym)(op - AST_OP_SELFBASE) = proc

   		case FB_SYMBCLASS_ENUM

		case FB_SYMBCLASS_CLASS
   			'' ...

   		end select

    	'' assign?
    	if( op = AST_OP_ASSIGN ) then
  			'' clone?
  			if( hIsLhsEqRhs( sym, proc ) ) then
  				select case symbGetClass( sym )
   				case FB_SYMBCLASS_STRUCT
   					sym->udt.ext->anon.clone = proc

   				case FB_SYMBCLASS_CLASS
   			 		'' ...

   				end select
   			end if
    	end if

    '' not self..
    else
   		symb.globOpOvlTb(op).head = proc
   	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' nesting
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private sub hInsertHashTbChain _
	( _
		byval sym as FBSYMBOL ptr, _
		byval lasttb as FBHASHTB ptr, _
		byval base_ns as FBSYMBOL ptr _
	) static

	dim as FBHASHTB ptr hashtb

	'' add all parents to hash list, but the base one

	sym = symbGetNamespace( sym )
	do until( sym = base_ns )

		hashtb = symbGetCompHashTb( sym )

		'' in reverse other, child ns must be the tail, parents follow
		symbHashListAddBefore( lasttb, hashtb )

		lasttb = hashtb
		sym = symbGetNamespace( sym )
	loop

end sub

'':::::
private sub hRemoveHashTbChain _
	( _
		byval sym as FBSYMBOL ptr, _
		byval base_ns as FBSYMBOL ptr _
	) static

	'' remove all parents from the hash list, but the base one

	sym = symbGetNamespace( sym )

	do until( sym = base_ns )
		symbHashListDel( symbGetCompHashTb( sym ) )

		sym = symbGetNamespace( sym )
	loop

end sub
'':::::
sub symbNestBegin _
	( _
		byval sym as FBSYMBOL ptr, _
		byval insert_chain as integer _
	) static

	dim as FB_SYMBNEST ptr n
	dim as FBHASHTB ptr hashtb
	dim as FBSYMBOLTB ptr symbtb

	n = stackPush( @symb.neststk )

	n->sym = sym
	n->symtb = symbGetCurrentSymTb( )
	n->hashtb = symbGetCurrentHashTb( )

	select case as const symbGetClass( sym )
	case FB_SYMBCLASS_NAMESPACE
        symbtb = @symbGetNamespaceSymbTb( sym )
        hashtb = @symbGetNamespaceHashTb( sym )

	case FB_SYMBCLASS_PROC
		symbtb = @symbGetProcSymbTb( sym )
		hashtb = NULL

	case FB_SYMBCLASS_STRUCT
		symbtb = @symbGetUdtSymbTb( sym )
		hashtb = @symbGetUdtHashTb( sym )

	case FB_SYMBCLASS_CLASS
		'symbtb = @symbGetClassSymbTb( sym )
		'hashtb = @symbGetClassHashTb( sym )

	end select

	symbSetCurrentSymTb( symbtb )

	if( hashtb <> NULL ) then
		n->ns = symbGetCurrentNamespc( )
		symbSetCurrentNamespc( sym )

		symbSetCurrentHashTb( hashtb )
		symbHashListAdd( hashtb )

		if( insert_chain ) then
			hInsertHashTbChain( sym, hashtb, n->ns )
		end if
	end if

end sub

'':::::
sub symbNestEnd _
	( _
		byval remove_chain as integer _
	) static

	dim as FB_SYMBNEST ptr n
	dim as FBHASHTB ptr hashtb
	dim as FBSYMBOL ptr sym

	n = stackGetTOS( @symb.neststk )

	sym = n->sym

	select case as const symbGetClass( sym )
	case FB_SYMBCLASS_NAMESPACE
        hashtb = @symbGetNamespaceHashTb( sym )

	case FB_SYMBCLASS_PROC
		hashtb = NULL

	case FB_SYMBCLASS_STRUCT
		hashtb = @symbGetUdtHashTb( sym )

	case FB_SYMBCLASS_CLASS
		'hashtb = @symbGetClassHashTb( sym )

	end select

	symbSetCurrentSymTb( n->symtb )

	if( hashtb <> NULL ) then
		if( remove_chain ) then
			hRemoveHashTbChain( sym, n->ns )
		end if

		symbHashListDel( hashtb )
		symbSetCurrentHashTb( n->hashtb )

		symbSetCurrentNamespc( n->ns )
	end if

    stackPop( @symb.neststk )

end sub


