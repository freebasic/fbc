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


'' intrinsic runtime lib profiling functions
''
'' chng: oct/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\ast.bi"
#include once "inc\rtl.bi"

'' name, alias, _
'' type, mode, _
'' callback, checkerror, overloaded, _
'' args, _
'' [arg typ,mode,optional[,value]]*args
funcdata:

'' fb_ProfileBeginCall ( byval procname as zstring ptr ) as any ptr
data @FB_RTL_PROFILEBEGINCALL, "", _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_CHAR,FB_PARAMMODE_BYVAL, FALSE

'' fb_ProfileEndCall ( byval call as any ptr ) as void
data @FB_RTL_PROFILEENDCALL, "", _
	 FB_DATATYPE_VOID,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_POINTER+FB_DATATYPE_VOID,FB_PARAMMODE_BYVAL, FALSE

'' fb_EndProfile ( byval errlevel as integer ) as integer
data @FB_RTL_PROFILEEND, "", _
	 FB_DATATYPE_INTEGER,FB_FUNCMODE_STDCALL, _
	 NULL, FALSE, FALSE, _
	 1, _
	 FB_DATATYPE_INTEGER,FB_PARAMMODE_BYVAL, FALSE

'' EOL
data NULL

'':::::
sub rtlProfileModInit( )

	restore funcdata
	rtlAddIntrinsicProcs( )

end sub

'':::::
sub rtlProfileModEnd( )

	'' procs will be deleted when symbEnd is called

end sub


'':::::
private function hGetProcName( byval proc as FBSYMBOL ptr ) as ASTNODE ptr
	dim as string procname
	dim as FBSYMBOL ptr s
	dim as ASTNODE ptr expr
	dim as integer at

	if( proc = NULL ) then
		s = symbAllocStrConst( "(??)", -1 )

	else
		procname = *symbGetName( proc )

		select case env.clopt.target
        case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
			procname = mid( procname, 2)
			at = instr( procname, "@" )
			if( at ) then
				procname = mid( procname, 1, at - 1 )
			end if
        end select

		if( len( procname ) and 3 ) then
			procname += string( 4 - ( len( procname ) and 3 ), 32 )
		end if

		s = symbAllocStrConst( procname, -1 )
	end if

	expr = astNewADDR( AST_OP_ADDROF, astNewVAR( s, 0, FB_DATATYPE_CHAR ) )

	function = expr

end function

'':::::
function rtlProfileBeginCall( byval symbol as FBSYMBOL ptr ) as ASTNODE ptr
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
