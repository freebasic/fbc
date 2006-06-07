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

'' AST declaration nodes (VAR, CONST, etc)
''
'' chng: jun/2006 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ir.bi"
#include once "inc\ast.bi"

'':::::
private function hClearVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr _
	) as ASTNODE ptr static

	dim as integer lgt

    '' static, shared (includes extern/public) or common? do nothing..
    if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
       	 						   FB_SYMBATTRIB_SHARED or _
       	 						   FB_SYMBATTRIB_COMMON or _
       	 						   FB_SYMBATTRIB_DYNAMIC)) <> 0 ) then

    	return NULL
    end if

    '' local..

   	'' initialized? do nothing..
   	if( initree <> NULL ) then
   		'' unless it's a var-len string..
   		if( symbGetType( sym ) <> FB_DATATYPE_STRING ) then
   			return NULL
   		end if
   	end if

   	'' not initialized..

   	'' don't clear?
   	if( symbGetDontClear( sym ) ) then
   		return NULL
   	end if

    '' clear..
    lgt = symbGetLen( sym ) * symbGetArrayElements( sym )

    function = astNewMEM( AST_OP_MEMCLEAR, _
    				  	  astNewVAR( sym, _
    				  		  	 	 0, _
    				   			 	 symbGetType( sym ), _
    				   			 	 symbGetSubtype( sym ) ), _
    				  	  NULL, _
    				  	  lgt )

end function

'':::::
function astNewDECL _
	( _
		byval symclass as FB_SYMBCLASS, _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr _
	) as ASTNODE ptr static

    dim as ASTNODE ptr n

	'' alloc new node
	n = astNewNode( AST_NODECLASS_DECL, INVALID )
	if( n = NULL ) then
		return NULL
	end if

	select case symclass
	case FB_SYMBCLASS_VAR
		n->l = hClearVar( sym, initree )
	end select

	function = n

end function

'':::::
function astLoadDECL _
	( _
		byval n as ASTNODE ptr _
	) as IRVREG ptr

	'' do clean up?
	if( n->l <> NULL ) then
		astLoad( n->l )
		astDelNode( n->l )
	end if

	function = NULL

end function


