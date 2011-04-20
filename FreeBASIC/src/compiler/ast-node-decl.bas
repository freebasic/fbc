''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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

'' AST decl nodes (VAR, CONST, etc)
''
'' chng: jun/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
private function hCtorList _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr cnt = any, label = any, this_ = any, subtype = any
	dim as ASTNODE ptr tree = NULL

	subtype = symbGetSubtype( sym )

    cnt = symbAddTempVar( FB_DATATYPE_INTEGER, NULL, FALSE, FALSE )
    label = symbAddLabel( NULL )
    this_ = symbAddTempVar( typeAddrOf( symbGetType( sym ) ), _
    					    subtype, _
    					    FALSE, _
    					    FALSE )

    '' fld = @sym(0)
    tree = astNewLINK( tree, _
    				   astBuildVarAssign( this_, _
    						   			  astNewADDROF( astNewVAR( sym, _
   											 		  		       0, _
   											 		  			   symbGetFullType( sym ), _
   											 		  			   subtype ) ) ) )

	'' for cnt = 0 to symbGetArrayElements( sym )-1
	tree = astBuildForBeginEx( tree, cnt, label, 0 )

    '' sym.constructor( )
	tree = astNewLINK( tree, _
					   astBuildCtorCall( symbGetSubtype( sym ), _
					   					  astBuildVarDeref( this_ ) ) )

	'' this_ += 1
    tree = astNewLINK( tree, astBuildVarInc( this_, 1 ) )

    '' next
    tree = astBuildForEndEx( tree, cnt, label, 1, symbGetArrayElements( sym ) )

	function = tree

end function

'':::::
private function hCallCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval no_ctorcall as integer _
	) as ASTNODE ptr

	dim as integer lgt = any
   	dim as FBSYMBOL ptr subtype = any

    function = NULL

    '' static, shared (includes extern/public) or common? do nothing..
    if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
       	 						   FB_SYMBATTRIB_SHARED or _
       	 						   FB_SYMBATTRIB_COMMON or _
       	 						   FB_SYMBATTRIB_DYNAMIC)) <> 0 ) then
    	exit function
    end if

    '' local..

   	'' initialized? do nothing..
   	if( initree <> NULL ) then
   		exit function
   	end if

   	'' not initialized..
   	subtype = symbGetSubtype( sym )

   	select case symbGetType( sym )
   	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
   		'' has a default ctor?
   		if( symbGetCompDefCtor( subtype ) <> NULL ) then
            '' Special case used by local UDT FOR iterators: They will already be
            '' initialized to the FOR start value using an appropriate constructor.
            if( no_ctorcall ) then
                exit function
            end if

   			'' proc result? astProcEnd() will take care of this
   			if( (symbGetAttrib( sym ) and FB_SYMBATTRIB_FUNCRESULT) <> 0 ) then
   				exit function
   			end if

   			'' scalar?
   			if( (symbGetArrayDimensions( sym ) = 0) or _
   				(symbGetArrayElements( sym ) = 1) ) then
   				'' sym.constructor( )
   				return astBuildCtorCall( subtype, _
   										 astNewVAR( sym, _
   											 		0, _
   											 		symbGetFullType( sym ), _
   											 		subtype ) )

   			'' array..
   			else
                return hCtorList( sym )
   			end if
   		end if
   	end select

   	'' do not clear?
   	if( symbGetDontInit( sym ) ) then
   		exit function
   	end if

    lgt = symbGetLen( sym ) * symbGetArrayElements( sym )

    function = astNewMEM( AST_OP_MEMCLEAR, _
    			  	  	  astNewVAR( sym, _
    			  		  	 	 	 0, _
    			   			 	 	 symbGetFullType( sym ), _
    			   			 	 	 subtype ), _
    			  	  	  astNewCONSTi( lgt ) )

end function

'':::::
function astNewDECL _
	( _
		byval symclass as FB_SYMBCLASS, _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval no_ctorcall as integer _
	) as ASTNODE ptr

    dim as ASTNODE ptr n = any

	'' alloc new node
	n = astNewNode( AST_NODECLASS_DECL, FB_DATATYPE_INVALID )
	if( n = NULL ) then
		return NULL
	end if

	select case symclass
	case FB_SYMBCLASS_VAR
		n->l = hCallCtor( sym, initree, no_ctorcall )
	end select

	function = n

end function

'':::::
function astLoadDECL _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	'' call ctor?
	if( n->l <> NULL ) then
		astLoad( n->l )
		astDelNode( n->l )
	end if

	function = NULL

end function


