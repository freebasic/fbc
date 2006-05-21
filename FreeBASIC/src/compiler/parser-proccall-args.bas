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
private function hCreateOptArg _
	( _
		byval param as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr tree

	'' make a clone
	tree = astCloneTree( symbGetParamOptExpr( param ) )

	'' UDT?
	if( symbGetType( param ) = FB_DATATYPE_USERDEF ) then
		'' update the counters
		astTypeIniUpdCnt( tree )
	end if

	function = tree

end function

'':::::
''ProcArg        =   BYVAL? (ID(('(' ')')? | Expression) .
''
private function hProcArg _
	( _
		byval proc as FBSYMBOL ptr, _
		byval param as FBSYMBOL ptr, _
		byval argnum as integer, _
		byref expr as ASTNODE ptr, _
		byref amode as integer, _
		byval isfunc as integer _
	) as integer

	dim as integer pmode
	dim as FBSYMBOL ptr oldsym

	function = FALSE

	pmode = symbGetParamMode( param )
	amode = INVALID
	expr = NULL

	'' BYVAL?
	if( hMatch( FB_TK_BYVAL ) ) then
		amode = FB_PARAMMODE_BYVAL
	end if

	oldsym = env.ctxsym
	env.ctxsym = symbGetSubType( param )

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
			if( (argnum = 0) and (amode = INVALID) ) then
				'' BYVAL?
				if( hMatch( FB_TK_BYVAL ) ) then
					amode = FB_PARAMMODE_BYVAL
					if( cExpression( expr ) = FALSE ) then
						expr = NULL
					end if
				end if
			end if
		end if

	end if

	env.ctxsym = oldsym

	if( expr = NULL ) then

		'' check if argument is optional
		if( symbGetParamOptional( param ) = FALSE ) then
			if( pmode <> FB_PARAMMODE_VARARG ) then
				hReportError( FB_ERRMSG_ARGCNTMISMATCH )
			end if
			exit function
		end if

		expr = hCreateOptArg( param )

	else

		'' '('')'?
		if( pmode = FB_PARAMMODE_BYDESC ) then
			if( lexGetToken( ) = CHAR_LPRNT ) then
				if( lexGetLookAhead(1) = CHAR_RPRNT ) then
					if( amode <> INVALID ) then
						hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
						exit function
					end if
					lexSkipToken( )
					lexSkipToken( )
					amode = FB_PARAMMODE_BYDESC
				end if
			end if
    	end if

    end if

	''
	if( amode <> INVALID ) then
		if( amode <> pmode ) then
            if( pmode <> FB_PARAMMODE_VARARG ) then
            	'' allow BYVAL params passed to BYREF/BYDESC args
            	'' (to pass NULL to pointers and so on)
            	if( amode <> FB_PARAMMODE_BYVAL ) then
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
private function cOvlProcParam _
	( _
		byval argnum as integer, _
		byref expr as ASTNODE ptr, _
		byref amode as integer, _
		byval isfunc as integer _
	) as integer

	dim as FBSYMBOL ptr oldsym

	function = FALSE

	amode = INVALID
	expr = NULL

	'' BYVAL?
	if( hMatch( FB_TK_BYVAL ) ) then
		amode = FB_PARAMMODE_BYVAL
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
			if( (argnum = 0) and (amode = INVALID) ) then
				'' BYVAL?
				if( hMatch( FB_TK_BYVAL ) ) then
					amode = FB_PARAMMODE_BYVAL
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
				if( amode <> INVALID ) then
					hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
					exit function
				end if
				lexSkipToken( )
				lexSkipToken( )
				amode = FB_PARAMMODE_BYDESC
			end if
		end if

    end if

	function = TRUE

end function

'':::::
''ProcArgList     =    ProcArg (DECL_SEPARATOR ProcArg)* .
''
private function hOvlProcArgList _
	( _
		byval proc as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval isfunc as integer, _
		byval optonly as integer _
	) as ASTNODE ptr

    dim as integer args, p, params, modeTB(0 to FB_MAXPROCARGS-1)
    dim as ASTNODE ptr procexpr, exprTB(0 to FB_MAXPROCARGS-1)
    dim as FBSYMBOL ptr param, ovlproc

	function = NULL

	args = 0
	params = symGetProcOvlMaxParams( proc )

	'' no parms? (could happen by mistake..)
	if( params = 0 ) then
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

		return astNewCALL( proc, ptrexpr )
	end if

	if( optonly = FALSE ) then
		do
			'' count mismatch?
			if( args >= params ) then
				hReportError( FB_ERRMSG_ARGCNTMISMATCH )
				exit function
			end if

			'' too many?
			if( args >= FB_MAXPROCARGS ) then
				hReportError( FB_ERRMSG_TOOMANYPARAMS )
				exit function
			end if

			if( cOvlProcParam( args, exprTB(args), modeTB(args), isfunc ) = FALSE ) then
				'' not an error? (could be an optional)
				if( hGetLastError( ) <> FB_ERRMSG_OK ) then
					exit function
				end if
			end if

			'' ','?
			if( hMatch( CHAR_COMMA ) = FALSE ) then
				'' if last arg was optional, don't count it
				if( exprTB(args) <> NULL ) then
					args += 1
				end if
				exit do
			end if

			'' next
			args += 1
		loop
	end if

	'' try finding the closest overloaded proc
	ovlproc = symbFindClosestOvlProc( proc, args, exprTB(), modeTB() )
	if( ovlproc = NULL ) then
		exit function
	end if

	proc = ovlproc

	procexpr = astNewCALL( proc, ptrexpr )

    '' add to tree
	param = symbGetProcLastParam( proc )
	for p = 0 to args-1

		'' optional arg not at end of list? fill it..
		if( exprTB(p) = NULL ) then
			exprTB(p) = hCreateOptArg( param )
			modeTB(p) = INVALID
		end if

		if( astNewARG( procexpr, exprTB(p), INVALID, modeTB(p) ) = NULL ) then
			hReportError( FB_ERRMSG_PARAMTYPEMISMATCH )
			exit function
		end if

		'' next
		param = symbGetProcPrevParam( proc, param )
	next

	'' add the end-of-list optional args, if any
	params = symbGetProcParams( proc )
    do while( args < params )
		astNewARG( procexpr, hCreateOptArg( param ), INVALID, INVALID )

		'' next
		args += 1
		param = symbGetProcPrevParam( proc, param )
	loop

	function = procexpr

end function

'':::::
''ProcArgList     =    ProcArg (DECL_SEPARATOR ProcArg)* .
''
function cProcArgList _
	( _
		byval proc as FBSYMBOL ptr, _
		byval ptrexpr as ASTNODE ptr, _
		byval isfunc as integer, _
		byval optonly as integer _
	) as ASTNODE ptr

    dim as integer args, params, mode
    dim as FBSYMBOL ptr param
    dim as ASTNODE ptr procexpr, expr

	'' overloaded?
	if( symbGetProcIsOverloaded( proc ) ) then
		return hOvlProcArgList( proc, ptrexpr, isfunc, optonly )
	end if

	function = NULL

    procexpr = astNewCALL( proc, ptrexpr )

	'' proc has no args?
	params = symbGetProcParams( proc )
	if( params = 0 ) then
		'' sub? check the optional parentheses
		if( isfunc = FALSE ) then
			'' '('
			if( lexGetToken( ) = CHAR_LPRNT ) then
				lexSkipToken( )
				'' ')'
				if( lexGetToken( ) <> CHAR_RPRNT ) then
					if( hReportError( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
						exit function
					else
						'' error recovery: skip until next ')'
						cSkipUntil( CHAR_RPRNT, TRUE )
					end if
				else
					lexSkipToken( )
				end if
			end if
		end if

		return procexpr
	end if

	args = 0
	param = symbGetProcLastParam( proc )

	if( optonly = FALSE ) then
		do
			'' count mismatch?
			if( args >= params ) then
				if( param->param.mode <> FB_PARAMMODE_VARARG ) then
					hReportError( FB_ERRMSG_ARGCNTMISMATCH )
					exit function
				end if
			end if

			'' too many?
			if( args >= FB_MAXPROCARGS ) then
				hReportError( FB_ERRMSG_TOOMANYPARAMS )
				exit function
			end if

			if( hProcArg( proc, param, args, expr, mode, isfunc ) = FALSE ) then
				'' not an error? (could be an optional)
				if( hGetLastError( ) <> FB_ERRMSG_OK ) then
					exit function
				else
					exit do
				end if
			end if

			'' add to tree
			if( astNewARG( procexpr, expr, INVALID, mode ) = NULL ) then
				exit function
			end if

			'' next
			args += 1
			if( args < params ) then
				param = symbGetProcPrevParam( proc, param )
			end if

		'' ','?
		loop while( hMatch( CHAR_COMMA ) )
	end if

	'' if not all args were given, check for the optional ones
	do while( args < params )
		'' var-arg? can't be optional..
		if( param->param.mode = FB_PARAMMODE_VARARG ) then
			exit do
		end if

		'' too many?
		if( args >= FB_MAXPROCARGS ) then
			hReportError( FB_ERRMSG_TOOMANYPARAMS )
			exit function
		end if

		'' not optional?
		if( symbGetParamOptional( param ) = FALSE ) then
			hReportError( FB_ERRMSG_ARGCNTMISMATCH )
			exit function
		end if

		'' add to tree
		if( astNewARG( procexpr, hCreateOptArg( param ), INVALID, INVALID ) = NULL ) then
			exit function
		end if

		'' next
		args += 1
		param = symbGetProcPrevParam( proc, param )
	loop

	function = procexpr

end function

