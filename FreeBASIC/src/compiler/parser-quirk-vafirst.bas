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


'' quirk varargs function (VA_FIRST) parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''cVAFunct =     VA_FIRST ('(' ')')? .
''
function cVAFunct( byref funcexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr arg, proc, sym

	function = FALSE

	if( fbIsModLevel( ) ) then
		exit function
	end if

	proc = env.currproc

	if( proc->proc.mode <> FB_FUNCMODE_CDECL ) then
		exit function
	end if

	arg = symbGetProcTailArg( proc )
	if( arg = NULL ) then
		exit function
	end if

	if( symbGetArgMode( arg ) <> FB_ARGMODE_VARARG ) then
		exit function
	end if

	arg = symbGetProcNextArg( proc, arg )
	if( arg = NULL ) then
		exit function
	end if

	sym = symbFindByNameAndClass( symbGetName( arg ), FB_SYMBCLASS_VAR )
	if( sym = NULL ) then
		exit function
	end if

	'' VA_FIRST
	lexSkipToken( )

	'' ('(' ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		hMatchRPRNT( )
	end if

	'' @arg
	expr = astNewVAR( sym, 0, symbGetType( sym ), NULL )
	expr = astNewADDR( AST_OP_ADDROF, expr )

	'' + arglen( arg )
	funcexpr = astNewBOP( AST_OP_ADD, _
						  expr, _
						  astNewCONSTi( symbCalcArgLen( arg->typ, _
						  								arg->subtype, _
						  								arg->arg.mode ), _
						  				FB_DATATYPE_UINT ) )



	function = TRUE

end function

