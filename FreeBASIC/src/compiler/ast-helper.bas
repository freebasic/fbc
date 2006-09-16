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

'' AST misc helpers/builders
''
'' chng: sep/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

''
'' vars
''

'':::::
function astBuildVarAssign _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer _
	) as ASTNODE ptr

	function = astNewASSIGN( astNewVAR( lhs, _
            							0, _
            							symbGetType( lhs ), _
            							symbGetSubtype( lhs ) ), _
            				 astNewCONSTi( rhs, _
            				 			   FB_DATATYPE_INTEGER ) )

end function

'':::::
function astBuildVarAssign _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as ASTNODE ptr _
	) as ASTNODE ptr

	function = astNewASSIGN( astNewVAR( lhs, _
            							0, _
            							symbGetType( lhs ), _
            							symbGetSubtype( lhs ) ), _
            				 rhs )

end function

'':::::
function astBuildVarInc _
	( _
		byval lhs as FBSYMBOL ptr, _
		byval rhs as integer _
	) as ASTNODE ptr static

	dim as AST_OPOPT options
	dim as AST_OP op

	options = AST_OPOPT_DEFAULT
	if( symbGetType( lhs ) >= FB_DATATYPE_POINTER ) then
		options or= AST_OPOPT_LPTRARITH
	end if

	if( rhs > 0 ) then
		op = AST_OP_ADD_SELF
	else
		op = AST_OP_SUB_SELF
		rhs = -rhs
	end if

	function = astNewSelfBOP( op, _
						   	  astNewVAR( lhs, _
						   	  			 0, _
						   	  			 symbGetType( lhs ), _
						   	  			 symbGetSubtype( lhs ) ), _
            			   	  astNewCONSTi( rhs, _
            			   	  				FB_DATATYPE_INTEGER ), _
            			   	  NULL, _
            			   	  options )

end function

'':::::
function astBuildVarDeref _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	function = astNewPTR( 0, _
            			  astNewVAR( sym, _
            						 0, _
            						 symbGetType( sym ), _
            						 symbGetSubtype( sym ) ), _
            			  symbGetType( sym ) - FB_DATATYPE_POINTER, _
            			  symbGetSubtype( sym ) )

end function

'':::::
function astBuildVarAddrof _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	function = astNewADDR( AST_OP_ADDROF, _
            			   astNewVAR( sym, _
            						  0, _
            						  symbGetType( sym ), _
            						  symbGetSubtype( sym ) ) )

end function

'':::::
function astBuildVarDtorCall _
	( _
		byval s as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as integer do_free = any
	dim as ASTNODE ptr expr = any

	'' assuming conditions were checked already
	function = NULL

	'' array? dims can be -1 with "DIM foo()" arrays..
	if( symbGetArrayDimensions( s ) <> 0 ) then
		do_free = FALSE

		'' dynamic?
		if( symbIsDynamic( s ) ) then
			do_free = TRUE

		else
		     '' has dtor?
		     select case symbGetType( s )
		     case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			 	do_free = symbGetHasDtor( symbGetSubtype( s ) )
			 end select
		end if

		if( do_free ) then
			expr = astNewVAR( s, 0, symbGetType( s ), symbGetSubtype( s ) )

			if( symbIsDynamic( s ) ) then
				function = rtlArrayErase( expr )
			else
				function = rtlArrayClear( expr, FALSE )
			end if

		'' array of dyn strings?
		elseif( symbGetType( s ) = FB_DATATYPE_STRING ) then
			function = rtlArrayStrErase( astNewVAR( s, 0, FB_DATATYPE_STRING ) )
		end if

	else
		select case symbGetType( s )
		'' dyn string?
		case FB_DATATYPE_STRING
			'' temp strings are deleted right-after the call, to not run out
			'' of temporary string descriptors (that are allocated at runtime)
			if( symbIsTemp( s ) ) then
				exit function
			end if

			function = rtlStrDelete( astNewVAR( s, 0, FB_DATATYPE_STRING ) )

		'' struct or class?
		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
			'' has dtor?
			if( symbGetHasDtor( symbGetSubtype( s ) ) ) then
                function = astBuildDtorCall( symbGetSubtype( s ), _
                							 astNewVAR( s, _
                							 			0, _
                							 			symbGetType( s ), _
                							 			symbGetSubtype( s ) ) )

			end if

		end select
	end if

end function

'':::::
function astBuildVarField _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr, _
		byval ofs as integer _
	) as ASTNODE ptr static

	dim as ASTNODE ptr expr

	if( fld <> NULL ) then
		ofs += symbGetOfs( fld )
	end if

	expr = astNewVAR( sym, ofs, symbGetType( sym ), symbGetSubtype( sym ) )

	if( fld <> NULL ) then
		expr = astNewFIELD( expr, fld, symbGetType( fld ), symbGetSubtype( fld ) )
	end if

	function = expr

end function

''
'' loops
''

'':::::
sub astBuildForBegin _
	( _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval inivalue as integer _
	)

	'' cnt = 0
    astAdd( astBuildVarAssign( cnt, inivalue ) )

    '' do
    astAdd( astNewLABEL( label ) )

end sub

'':::::
sub astBuildForEnd _
	( _
		byval cnt as FBSYMBOL ptr, _
		byval label as FBSYMBOL ptr, _
		byval stepvalue as integer, _
		byval endvalue as integer _
	)

	'' next
    astAdd( astBuildVarInc( cnt, stepvalue ) )

    '' next
    astAdd( astUpdComp2Branch( astNewBOP( AST_OP_EQ, _
    									  astNewVAR( cnt, _
            										 0, _
            										 FB_DATATYPE_INTEGER ), _
            							  astNewCONSTi( endvalue, _
            											FB_DATATYPE_INTEGER ) ), _
            				   label, _
            				   FALSE ) )

end sub

''
'' calls
''

'':::::
function astBuildCall cdecl _
	( _
		byval proc as FBSYMBOL ptr, _
		byval args as integer, _
		... _
	) as ASTNODE ptr static

    dim as ASTNODE ptr p
    dim as any ptr arg
    dim as integer i

    p = astNewCALL( proc )

    arg = va_first( )
    for i = 0 to args-1
    	if( astNewARG( p, va_arg( arg, ASTNODE ptr ) ) = NULL ) then
    		'' ...
    	end if

    	arg = va_next( arg, ASTNODE ptr )
    next

    function = p

end function

'':::::
function astBuildCtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr static

    dim as FBSYMBOL ptr ctor
    dim as ASTNODE ptr proc
    dim as integer params

    ctor = symbGetCompDefCtor( sym )
    if( ctor = NULL ) then
    	return NULL
    end if

    proc = astNewCALL( ctor )

    astNewARG( proc, thisexpr )

    '' add the optional params, if any
    params = symbGetProcParams( ctor ) - 1
    do while( params > 0 )
    	astNewARG( proc, NULL )
    	params -= 1
    loop

    function = proc

end function

'':::::
function astBuildDtorCall _
	( _
		byval sym as FBSYMBOL ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr proc

    proc = astNewCALL( symbGetCompDtor( sym ) )

    astNewARG( proc, thisexpr )

    function = proc

end function

'':::::
function astBuildCopyCtorCall _
	( _
		byval dst as ASTNODE ptr, _
		byval src as ASTNODE ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr proc
    dim as FBSYMBOL ptr copyctor

	copyctor = symbGetCompCopyCtor( astGetSubtype( dst ) )

	'' no copy ctor? do a shallow copy..
	if( copyctor = NULL ) then
    	return astNewASSIGN( dst, src, FALSE )
    end if

    '' call the copy ctor
    proc = astNewCALL( copyctor )

    astNewARG( proc, dst )
    astNewARG( proc, src )

    function = proc

end function

'':::::
function astPatchCtorCall _
	( _
		byval procexpr as ASTNODE ptr, _
		byval thisexpr as ASTNODE ptr _
	) as ASTNODE ptr

	'' replace the instance pointer
	astReplaceARG( procexpr, 0, thisexpr )

	function = procexpr

end function

'':::::
function astCallCtorToCall _
	( _
		byval n as ASTNODE ptr _
	) as ASTNODE ptr static

	dim as FBSYMBOL ptr sym
	dim as ASTNODE ptr procexpr

	sym = astGetSymbol( n->r )

	'' the function call is in the left leaf
	procexpr = n->l

	'' remove right leaf
	astDelTree( n->r )

	'' remove anon symbol
	symbDelSymbol( sym )

	'' remove the node
	astDelNode( n )

	function = procexpr

end function

''
'' procs
''

'':::::
function astBuildProcAddrof _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	function = astNewADDR( AST_OP_ADDROF, _
						   astNewVAR( sym, _
						   			  0, _
						   			  FB_DATATYPE_FUNCTION, _
						   			  sym ) )

end function

'':::::
function astBuildProcBegin _
	( _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr n = any

	n = astProcBegin( proc, FALSE )

    symbSetProcIncFile( proc, env.inf.incfile )

   	astAdd( astNewLABEL( astGetProcInitlabel( n ) ) )

   	function = n

end function

'':::::
sub astBuildProcEnd _
	( _
		byval n as ASTNODE ptr _
	)

	astProcEnd( n, FALSE )

end sub

'':::::
function astBuildProcResultVar _
	( _
		byval proc as FBSYMBOL ptr, _
		byval res as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE PTR lhs = any

    lhs = astNewVAR( res, 0, symbGetType( res ), symbGetSubtype( res ) )

	'' proc returns an UDT?
    select case symbGetType( proc )
    case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		'' pointer? deref
		if( symbGetProcRealType( proc ) = FB_DATATYPE_POINTER + FB_DATATYPE_STRUCT ) then
			lhs = astNewPTR( 0, lhs, FB_DATATYPE_STRUCT, symbGetSubtype( res ) )
		end if
	end select

	function = lhs

end function

''
'' instance ptr
''

'':::::
function astBuildInstPtr _
	( _
		byval sym as FBSYMBOL ptr, _
		byval fld as FBSYMBOL ptr, _
		byval idxexpr as ASTNODE ptr, _
		byval ofs as integer _
	) as ASTNODE ptr static

	dim as ASTNODE ptr expr
	dim as integer dtype
	dim as FBSYMBOL ptr subtype

	dtype = symbGetType( sym )
	subtype = symbGetSubtype( sym )

	expr = astNewVAR( sym, 0, FB_DATATYPE_POINTER + dtype, subtype )

	if( fld <> NULL ) then
		dtype = symbGetType( fld )
		subtype = symbGetSubtype( fld )

		'' build sym.field( index )

		ofs += symbGetOfs( fld )
		if( ofs <> 0 ) then
			expr = astNewBOP( AST_OP_ADD, _
						  	  expr, _
						  	  astNewCONSTi( ofs, FB_DATATYPE_INTEGER ) )
		end if

		'' array access?
	   	if( idxexpr <> NULL ) then
			'' times length
			expr = astNewBOP( AST_OP_ADD, _
						  	  expr, _
						  	  astNewBOP( AST_OP_MUL, _
						     		 	 idxexpr, _
						  	 		 	 astNewCONSTi( symbGetLen( fld ), _
						  	 		 	 			   FB_DATATYPE_INTEGER ) ) )
		end if

    else
		if( ofs <> 0 ) then
			expr = astNewBOP( AST_OP_ADD, _
						  	  expr, _
						  	  astNewCONSTi( ofs, FB_DATATYPE_INTEGER ) )
		end if
	end if

	expr = astNewPTR( 0, expr, dtype, subtype )

	if( fld <> NULL ) then
	    expr = astNewFIELD( expr, fld, dtype, subtype )
	end if

	function = expr

end function

'':::::
function astBuildMockInstPtr _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	function = astNewCONSTi( 0, _
							 FB_DATATYPE_POINTER + symbGetType( sym ), _
							 sym )

end function

''
'' misc
''

'':::::
function astBuildTypeIniCtorList _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tree

	tree = astTypeIniBegin( symbGetType( sym ), symbGetSubtype( sym ) )

	astTypeIniAddCtorList( tree, sym, symbGetArrayElements( sym ) )

	astTypeIniEnd( tree, TRUE )

	function = tree

end function


