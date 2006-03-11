''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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


'' symbol table module for scopes
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\list.bi"
#include once "inc\ast.bi"
#include once "inc\emit.bi"
#include once "inc\rtl.bi"

'':::::
private sub hAddScopeToProcList( byval s as FBSYMBOL ptr ) static
    dim as FB_PROCEXT ptr ext

	ext = env.currproc->proc.ext

	if( ext->scptb.head = NULL ) then
		ext->scptb.head = s
	else
		ext->scptb.tail->scp.next = s
	end if

	ext->scptb.tail = s
	s->scp.next = NULL

end sub

'':::::
function symbAddScope( ) as FBSYMBOL ptr
    dim as FBSYMBOL ptr s

    s = symbNewSymbol( NULL, symb.loctb, TRUE, FB_SYMBCLASS_SCOPE, FALSE, NULL, NULL )

    s->scp.loctb.head = NULL
    s->scp.loctb.tail = NULL

    ''
    if( env.scope = iif( fbIsModLevel( ), FB_MAINSCOPE, FB_MAINSCOPE+1 ) ) then
    	hAddScopeToProcList( s )
    end if

	function = s

end function

'':::::
sub symbDelScope( byval scp as FBSYMBOL ptr )
	dim as FBSYMBOL ptr s, nxt

    if( scp = NULL ) then
    	exit sub
    end if

    '' del all symbols inside the scope block
    do
		s = scp->scp.loctb.head
		if( s = NULL ) then
			exit do
		end if

		symbDelSymbol( s )
	loop

	'' del the scope node
	symbFreeSymbol( scp )

end sub

'':::::
sub symbDelScopeTb( byval scp as FBSYMBOL ptr ) static
    dim as FBSYMBOL ptr s

	'' for each symbol declared inside the SCOPE block..
	s = scp->scp.loctb.head
    do while( s <> NULL )
    	'' remove from hash only
    	symbDelFromHash( s )
    	s = s->next
    loop

end sub

'':::::
function symbScopeAllocLocals( byval scp as FBSYMBOL ptr ) as integer
    dim as integer lgt
    dim as FBSYMBOL ptr s

    function = FALSE

    scp->scp.baseofs = emitGetLocalOfs( env.currproc )

    s = symbGetScopeTbHead( scp )
    do while( s <> NULL )
    	select case s->class
		'' scope? recurse..
		case FB_SYMBCLASS_SCOPE
			symbScopeAllocLocals( s )

    	'' variable?
    	case FB_SYMBCLASS_VAR
    		'' not shared, static?
    		if( (s->attrib and (FB_SYMBATTRIB_SHARED or _
    			 				FB_SYMBATTRIB_STATIC)) = 0 ) then

					lgt = s->lgt * symbGetArrayElements( s )
					ZstrAssign( @s->alias, emitAllocLocal( env.currproc, lgt, s->ofs ) )

				symbSetIsAllocated( s )

			end if

		end select

    	s = s->next
    loop

    scp->scp.bytes = emitGetLocalOfs( env.currproc ) - scp->scp.baseofs

    emitSetLocalOfs( env.currproc, scp->scp.baseofs )

    function = TRUE

end function

'':::::
sub symbFreeScopeDynVars( byval scp as FBSYMBOL ptr ) static

    dim as FBSYMBOL ptr s
    dim as ASTNODE ptr strg

	'' for each symbol declared inside the SCOPE block..
	s = scp->scp.loctb.head
    do while( s <> NULL )
    	'' variable?
    	if( s->class = FB_SYMBCLASS_VAR ) then
    		'' not shared or static (for locals)
    		if( (s->attrib and (FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC)) = 0 ) then
                '' array?
				if( s->var.array.dims > 0 ) then
					'' dynamic?
					if( symbIsDynamic( s ) ) then
						rtlArrayErase( astNewVAR( s, 0, s->typ ) )
					'' array of dyn strings?
					elseif( s->typ = FB_DATATYPE_STRING ) then
						rtlArrayStrErase( s )
					end if

				'' dyn string?
				elseif( s->typ = FB_DATATYPE_STRING ) then
					strg = astNewVAR( s, 0, FB_DATATYPE_STRING )
					astAdd( rtlStrDelete( strg ) )
				end if
    		end if
    	end if

    	s = s->next
    loop

end sub


