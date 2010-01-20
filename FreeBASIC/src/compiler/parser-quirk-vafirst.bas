''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''cVAFunct =     VA_FIRST ('(' ')')? .
''
function cVAFunct( byref funcexpr as ASTNODE ptr ) as integer
    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr param, proc, sym

	function = FALSE

	if( fbIsModLevel( ) ) then
		exit function
	end if

	proc = parser.currproc

	if( proc->proc.mode <> FB_FUNCMODE_CDECL ) then
		exit function
	end if

	param = symbGetProcTailParam( proc )
	if( param = NULL ) then
		exit function
	end if

	if( symbGetParamMode( param ) <> FB_PARAMMODE_VARARG ) then
		exit function
	end if

	param = symbGetProcNextParam( proc, param )
	if( param = NULL ) then
		exit function
	end if

	sym = symbGetParamVar( param )
	if( sym = NULL ) then
		exit function
	end if

	'' VA_FIRST
	lexSkipToken( )

	'' ('(' ')')?
	if( hMatch( CHAR_LPRNT ) ) then
		hMatchRPRNT( )
	end if

	'' high-level IR? va_* not supported
	if( irGetOption( IR_OPT_HIGHLEVEL ) ) then
		if( errReport( FB_ERRMSG_STMTUNSUPPORTEDINGCC, TRUE ) = FALSE ) then
			exit function
		end if

		'' error recovery: fake an expr
		funcexpr = astNewCONSTi( 0 )

	else
		'' @param
		expr = astNewVAR( sym, 0, symbGetFullType( sym ), NULL )
		expr = astNewADDROF( expr )

		'' + paramlen( param )
		funcexpr = astNewBOP( AST_OP_ADD, _
						  	  expr, _
						  	  astNewCONSTi( symbCalcparamLen( param->typ, _
						  								  	  param->subtype, _
						  								  	  param->param.mode ), _
						  					FB_DATATYPE_UINT ) )
	end if

	function = TRUE

end function

