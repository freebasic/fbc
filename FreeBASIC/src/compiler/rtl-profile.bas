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


'' intrinsic runtime lib profiling functions
''
'' chng: oct/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 11 ) = _
	{ _
		/' fb_ProfileBeginCall ( byval procname as zstring ptr ) as any ptr '/ _
		( _
			@FB_RTL_PROFILEBEGINCALL, NULL, _
			FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_POINTER+FB_DATATYPE_CHAR, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_ProfileEndCall ( byval call as any ptr ) as void '/ _
		( _
			@FB_RTL_PROFILEENDCALL, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_POINTER+FB_DATATYPE_VOID, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
		), _
		/' fb_EndProfile ( byval errlevel as integer ) as integer '/ _
		( _
			@FB_RTL_PROFILEEND, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_STDCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
	 			) _
	 		} _
	 	), _
	 	/' EOL '/ _
	 	( _
	 		NULL _
	 	) _
	 }

'':::::
sub rtlProfileModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlProfileModEnd( )

	'' procs will be deleted when symbEnd is called

end sub


'':::::
private function hGetProcName _
	( _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr static

	dim as string procname
	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr
	dim as integer at, lgt, i

	if( proc = NULL ) then
		s = symbAllocStrConst( "(??)", -1 )

	else
		procname = *symbGetDBGName( proc )

		lgt = len( procname )
		if( lgt and 3 ) then
			for i = 1 to 4 - ( lgt and 3 )
				procname += chr( FB_INTSCAPECHAR, CHAR_0 )
			next
			lgt += 4 - ( lgt and 3 )
		end if

		s = symbAllocStrConst( procname, lgt )
	end if

	expr = astNewADDR( AST_OP_ADDROF, astNewVAR( s, 0, FB_DATATYPE_CHAR ) )

	function = expr

end function

'':::::
function rtlProfileBeginCall _
	( _
		byval symbol as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc, expr

	function = NULL

	'' don't add profiling inside a ctor or dtor
	if( (symbGetAttrib( env.currproc ) and _
		(FB_SYMBATTRIB_CONSTRUCTOR or FB_SYMBATTRIB_DESTRUCTOR)) <> 0 ) then
		exit function
	end if

	proc = astNewCALL( PROCLOOKUP( PROFILEBEGINCALL ), NULL, TRUE )

	expr = hGetProcName( symbol )
	if( astNewARG( proc, expr, INVALID, FB_PARAMMODE_BYVAL ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlProfileEndCall( ) as ASTNODE ptr
    dim as ASTNODE ptr proc

	function = NULL

    proc = astNewCALL( PROCLOOKUP( PROFILEENDCALL ), NULL, TRUE )

  	function = proc

end function
