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


'' intrinsic runtime lib OOP functions (is operator, dynamic cast, ...)
''
'' chng: apr/2011 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 3 ) = _
	{ _
		/' fb_IsTypeOf ( byref obj as any, byref rtti as $fb_RTTI ) as integer '/ _
		( _
			@FB_RTL_ISTYPEOF, NULL, _
	 		FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
	 		NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			), _
	 			( _
					FB_DATATYPE_VOID,FB_PARAMMODE_BYREF, FALSE _
	 			) _
	 		} _
		), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

'':::::
sub rtlOOPModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlOOPModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlOOPIsTypeOf _
	( _
		byval inst as ASTNODE ptr, _
		byval rtti as ASTNODE ptr _
	) as ASTNODE ptr
	
    
    var proc = astNewCALL( PROCLOOKUP( ISTYPEOF ) )

    '' byref obj as any ptr
    if( astNewARG( proc, inst ) = NULL ) then
    	exit function
    end if

    '' byref rtti as any ptr
    if( astNewARG( proc, rtti ) = NULL ) then
    	exit function
    end if

    function = proc

end function
