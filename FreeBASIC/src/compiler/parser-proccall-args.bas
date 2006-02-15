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


'' function call's arguments list (called "param" by mistake)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
private function hCreateOptArg( byval arg as FBSYMBOL ptr _
							  ) as ASTNODE ptr

	'' create an arg
	select case as const symbGetType( arg )
  	case FB_DATATYPE_ENUM
  		function = astNewENUM( symbGetArgOptValInt( arg ), symbGetSubType( arg ) )

	case FB_DATATYPE_FIXSTR, FB_DATATYPE_STRING, FB_DATATYPE_CHAR
		function = astNewVAR( symbGetArgOptValStr( arg ), 0, FB_DATATYPE_CHAR )

	case FB_DATATYPE_WCHAR
		function = astNewVAR( symbGetArgOptValStr( arg ), 0, FB_DATATYPE_WCHAR )

	case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
		function = astNewCONST64( symbGetArgOptValLong( arg ), symbGetType( arg ) )

	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
		function = astNewCONSTf( symbGetArgOptValFloat( arg ), symbGetType( arg ) )

	case else
		function = astNewCONSTi( symbGetArgOptValInt( arg ), _
								 symbGetType( arg ), symbGetSubType( arg ) )
	end select

end function


'':::::
''ProcParam         =   BYVAL? (ID(('(' ')')? | Expression) .
''
function cProcParam( byval proc as FBSYMBOL ptr, _
					 byval arg as FBSYMBOL ptr, _
					 byval param as integer, _
					 byref expr as ASTNODE ptr, _
					 byref pmode as integer, _
					 byval isfunc as integer, _
					 byval optonly as integer ) as integer

	dim as integer amode
	dim as FBSYMBOL ptr oldsym

	function = FALSE

	amode = symbGetArgMode( arg )

	pmode = INVALID
	expr = NULL

	if( optonly = FALSE ) then
		'' BYVAL?
		if( hMatch( FB_TK_BYVAL ) ) then
			pmode = FB_ARGMODE_BYVAL
		end if

		oldsym = env.ctxsym
		env.ctxsym = symbGetSubType( arg )

		'' Expression
		if( cExpression( expr ) = FALSE ) then

			'' error?
			if( hGetLastError( ) <> FB_ERRMSG_OK ) then
				env.ctxsym = oldsym
				exit function
			end if

			if( isfunc ) then
				expr = NULL

			else
				'' failed and expr not null?
				if( expr <> NULL ) then
					env.ctxsym = oldsym
					exit function
				end if

				'' check for BYVAL if it's the first param, due the optional ()'s
				if( (param = 0) and (pmode = INVALID) ) then
					'' BYVAL?
					if( hMatch( FB_TK_BYVAL ) ) then
						pmode = FB_ARGMODE_BYVAL
						if( cExpression( expr ) = FALSE ) then
							expr = NULL
						end if
					end if
				end if
			end if

		end if

		env.ctxsym = oldsym
	end if

	if( expr = NULL ) then

		'' check if argument is optional
		if( symbGetArgOptional( arg ) = FALSE ) then
			if( amode <> FB_ARGMODE_VARARG ) then
				hReportError( FB_ERRMSG_ARGCNTMISMATCH )
			end if
			exit function
		end if

		expr = hCreateOptArg( arg )

	else

		'' '('')'?
		if( amode = FB_ARGMODE_BYDESC ) then
			if( lexGetToken( ) = CHAR_LPRNT ) then
				if( lexGetLookAhead(1) = CHAR_RPRNT ) then
					if( pmode <> INVALID ) then
						hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
						exit function
					end if
					lexSkipToken( )
					lexSkipToken( )
					pmode = FB_ARGMODE_BYDESC
				end if
			end if
    	end if

    end if

	''
	if( pmode <> INVALID ) then
		if( amode <> pmode ) then
            if( amode <> FB_ARGMODE_VARARG ) then
            	'' allow BYVAL params passed to BYREF/BYDESC args
            	'' (to pass NULL to pointers and so on)
            	if( pmode <> FB_ARGMODE_BYVAL ) then
					if( amode <> pmode ) then
						hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
						exit function
					end if
				end if
			end if
		end if
	end if

	function = TRUE

end function

'':::::
''ProcParam         =   BYVAL? (ID(('(' ')')? | Expression) .
''
private function cOvlProcParam( byval param as integer, _
					    		byref expr as ASTNODE ptr, _
					    		byref pmode as integer, _
					    		byval isfunc as integer _
					  		  ) as integer

	dim as FBSYMBOL ptr oldsym

	function = FALSE

	pmode = INVALID
	expr = NULL

	'' BYVAL?
	if( hMatch( FB_TK_BYVAL ) ) then
		pmode = FB_ARGMODE_BYVAL
	end if

	oldsym = env.ctxsym
	env.ctxsym = NULL

	'' Expression
	if( cExpression( expr ) = FALSE ) then

		'' error?
		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			env.ctxsym = oldsym
			exit function
		end if

		'' function? assume as optional..
		if( isfunc ) then
			expr = NULL

		else
			'' failed and expr not null?
			if( expr <> NULL ) then
				env.ctxsym = oldsym
				exit function
			end if

			'' check for BYVAL if it's the first param, due the optional ()'s
			if( (param = 0) and (pmode = INVALID) ) then
				'' BYVAL?
				if( hMatch( FB_TK_BYVAL ) ) then
					pmode = FB_ARGMODE_BYVAL
					if( cExpression( expr ) = FALSE ) then
						expr = NULL
					end if
				end if
			end if
		end if

	end if

	env.ctxsym = oldsym

	'' not optional?
	if( expr <> NULL ) then
		'' '('')'?
		if( lexGetToken( ) = CHAR_LPRNT ) then
			if( lexGetLookAhead(1) = CHAR_RPRNT ) then
				if( pmode <> INVALID ) then
					hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
					exit function
				end if
				lexSkipToken( )
				lexSkipToken( )
				pmode = FB_ARGMODE_BYDESC
			end if
		end if

    end if

	function = TRUE

end function

'':::::
''ProcParamList     =    ProcParam (DECL_SEPARATOR ProcParam)* .
''
private function hOvlProcParamList( byval proc as FBSYMBOL ptr, _
									byval ptrexpr as ASTNODE ptr, _
									byval isfunc as integer, _
									byval optonly as integer ) as ASTNODE ptr

    dim as integer args, p, params, modeTB(0 to FB_MAXPROCARGS-1)
    dim as ASTNODE ptr procexpr, exprTB(0 to FB_MAXPROCARGS-1)
    dim as FBSYMBOL ptr arg, ovlproc

	function = NULL

	params = 0
	args = symGetProcOvlMaxArgs( proc )

	'' no args? (could happen by mistake..)
	if( args = 0 ) then
		'' sub? check the optional parentheses
		if( isfunc = FALSE ) then
			'' '('
			if( hMatch( CHAR_LPRNT ) ) then
				'' ')'
				if( hMatch( CHAR_RPRNT ) = FALSE ) then
					hReportError( FB_ERRMSG_EXPECTEDRPRNT )
					exit function
				end if
			end if
		end if

		return astNewFUNCT( proc, ptrexpr )
	end if

	if( optonly = FALSE ) then
		do
			'' count mismatch?
			if( params >= args ) then
				hReportError( FB_ERRMSG_ARGCNTMISMATCH )
				exit function
			end if

			'' too many?
			if( params >= FB_MAXPROCARGS ) then
				hReportError( FB_ERRMSG_TOOMANYPARAMS )
				exit function
			end if

			if( cOvlProcParam( params, _
							   exprTB(params), _
							   modeTB(params), _
							   isfunc ) = FALSE ) then
				'' not an error? (could be an optional)
				if( hGetLastError( ) <> FB_ERRMSG_OK ) then
					exit function
				end if
			end if

			'' ','?
			if( hMatch( CHAR_COMMA ) = FALSE ) then
				'' if last arg was optional, don't count it
				if( exprTB(params) <> NULL ) then
					params += 1
				end if
				exit do
			end if

			'' next
			params += 1
		loop
	end if

	'' try finding the closest overloaded proc
	ovlproc = symbFindClosestOvlProc( proc, params, exprTB(), modeTB() )

	if( ovlproc = NULL ) then
		hReportParamError( proc, 0, NULL, FB_ERRMSG_AMBIGUOUSCALLTOPROC )
		exit function
	else
		proc = ovlproc
	end if

	procexpr = astNewFUNCT( proc, ptrexpr )

    '' add to tree
	arg = symbGetProcLastArg( proc )
	for p = 0 to params-1

		'' optional arg not at end of list? fill it..
		if( exprTB(p) = NULL ) then
			exprTB(p) = hCreateOptArg( arg )
			modeTB(p) = INVALID
		end if

		if( astNewPARAM( procexpr, exprTB(p), INVALID, modeTB(p) ) = NULL ) then
			hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
			exit function
		end if

		'' next
		arg = symbGetProcPrevArg( proc, arg )
	next

	'' add the end-of-list optional args, if any
	args = symbGetProcArgs( proc )
	if( params < args ) then
        do while( params < args )
			astNewPARAM( procexpr, hCreateOptArg( arg ), INVALID, INVALID )

			'' next
			params += 1
			arg = symbGetProcPrevArg( proc, arg )
		loop
	end if

	function = procexpr

end function

'':::::
''ProcParamList     =    ProcParam (DECL_SEPARATOR ProcParam)* .
''
function cProcParamList( byval proc as FBSYMBOL ptr, _
						 byval ptrexpr as ASTNODE ptr, _
						 byval isfunc as integer, _
						 byval optonly as integer ) as ASTNODE ptr

    dim as integer args, params, mode
    dim as FBSYMBOL ptr arg
    dim as ASTNODE ptr procexpr, expr

	'' overloaded?
	if( symbGetProcIsOverloaded( proc ) ) then
		return hOvlProcParamList( proc, ptrexpr, isfunc, optonly )
	end if

	function = NULL

    procexpr = astNewFUNCT( proc, ptrexpr )

	'' proc has no args?
	args = symbGetProcArgs( proc )
	if( args = 0 ) then
		'' sub? check the optional parentheses
		if( isfunc = FALSE ) then
			'' '('
			if( hMatch( CHAR_LPRNT ) ) then
				'' ')'
				if( hMatch( CHAR_RPRNT ) = FALSE ) then
					hReportError( FB_ERRMSG_EXPECTEDRPRNT )
					exit function
				end if
			end if
		end if

		return procexpr
	end if

	params = 0
	arg = symbGetProcLastArg( proc )

	if( optonly = FALSE ) then
		do
			'' count mismatch?
			if( params >= args ) then
				if( arg->arg.mode <> FB_ARGMODE_VARARG ) then
					hReportError( FB_ERRMSG_ARGCNTMISMATCH )
					exit function
				end if
			end if

			'' too many?
			if( params >= FB_MAXPROCARGS ) then
				hReportError( FB_ERRMSG_TOOMANYPARAMS )
				exit function
			end if

			if( cProcParam( proc, arg, params, _
							expr, mode, _
							isfunc, FALSE ) = FALSE ) then
				'' not an error? (could be an optional)
				if( hGetLastError( ) <> FB_ERRMSG_OK ) then
					exit function
				else
					exit do
				end if
			end if

			'' add to tree
			if( astNewPARAM( procexpr, expr, INVALID, mode ) = NULL ) then
				exit function
			end if

			'' next
			params += 1
			if( params < args ) then
				arg = symbGetProcPrevArg( proc, arg )
			end if

		'' ','?
		loop while( hMatch( CHAR_COMMA ) )
	end if

	'' if not all params were given, check for the optional ones
	do while( params < args )
		'' var-arg? can't be optional..
		if( arg->arg.mode = FB_ARGMODE_VARARG ) then
			exit do
		end if

		'' too many?
		if( params >= FB_MAXPROCARGS ) then
			hReportError( FB_ERRMSG_TOOMANYPARAMS )
			exit function
		end if

		'' not optional?
		if( cProcParam( proc, arg, params, _
						expr, mode, _
						isfunc, TRUE ) = FALSE ) then
			exit function
		end if

		'' add to tree
		if( astNewPARAM( procexpr, expr, INVALID, mode ) = NULL ) then
			exit function
		end if

		'' next
		params += 1
		arg = symbGetProcPrevArg( proc, arg )
	loop

	function = procexpr

end function

