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


'' intrinsic runtime lib profiling functions
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 2 ) = _
	{ _
		/' mcount ( void ) as void'/ _
		( _
			@FB_RTL_PROFILEMCOUNT, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
	 	), _
		/' _monstartup CDECL ( ) as void '/ _
		( _
			@FB_RTL_PROFILEMONSTARTUP, NULL, _
	 		FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
	 		NULL, FB_RTL_OPT_NONE, _
	 		0 _
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
function rtlProfileCall_mcount( ) as ASTNODE ptr
    dim as ASTNODE ptr proc

	function = NULL

    proc = astNewCALL( PROCLOOKUP( PROFILEMCOUNT ), NULL )

  	function = proc

end function

'':::::
function rtlProfileCall_monstartup( ) as ASTNODE ptr
    dim as ASTNODE ptr proc

	function = NULL

	'' on mingw monstartup has two flavours 'monstartup(2)' and '_monstartup(0)'
	'' we are using the _monstartup(0) taking 0 arguments.

    proc = astNewCALL( PROCLOOKUP( PROFILEMONSTARTUP ), NULL )

  	function = proc

end function
