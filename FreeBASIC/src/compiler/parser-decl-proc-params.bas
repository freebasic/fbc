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


'' proc parameters list declarations (called "arg" by mistake)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

declare function 	hParamDecl			( byval proc as FBSYMBOL ptr, _
				   			 			  byval procmode as integer, _
				   			 			  byval isproto as integer ) as FBSYMBOL ptr

'':::::
''Parameters=   ParamDecl (',' ParamDecl)* .
''
function cParameters( byval proc as FBSYMBOL ptr, _
					  byval procmode as integer, _
					  byval isproto as integer _
				    ) as FBSYMBOL ptr

	dim as FBSYMBOL ptr n

	do
		n = hParamDecl( proc, procmode, isproto )
		if( n = NULL ) then
			return NULL
		end if

		'' vararg?
		if( n->param.mode = FB_PARAMMODE_VARARG ) then
			exit do
		end if

	'' ','
	loop while( hMatch( CHAR_COMMA ) )

	function = n

end function

'':::::
private sub hParamError( byval proc as FBSYMBOL ptr, _
						 byval argnum as integer, _
						 byval argid as zstring ptr )

	hReportParamError( proc, argnum+1, argid, FB_ERRMSG_ILLEGALPARAMSPECAT )

end sub

'':::::
private function cOptionalExpr( byval mode as FB_PARAMMODE, _
								byval dtype as FB_DATATYPE, _
								byval subtype as FBSYMBOL ptr _
					   		  ) as ASTNODE ptr

    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr sym

    function = NULL

    '' not byval or byref?
    if( (mode <> FB_PARAMMODE_BYVAL) and (mode <> FB_PARAMMODE_BYREF) ) then
    	exit function
    end if

    '' anything but an UDT?
    if( dtype <> FB_DATATYPE_USERDEF ) then
    	if( cExpression( expr ) = FALSE ) then
    		exit function
    	end if

    	'' check for invalid types..
    	static as ASTNODE lside

    	astBuildVAR( @lside, NULL, 0, dtype, subtype )

    	if( astCheckASSIGN( @lside, expr ) = FALSE ) then
        	exit function
		end if

    '' UDT, let SymbolInit() build a tree..
    else
    	sym = symbAddTempVar( dtype, subtype, FALSE, FALSE )

    	expr = cSymbolInit( sym, TRUE )
    	if( expr = NULL ) then
    		exit function
    	end if

    	symbDelVar( sym, FALSE )
    end if

	function = expr

end function

'':::::
'' ParamDecl      =   (BYVAL|BYREF)? ID (('(' ')')? (AS SymbolType)?)? ('=" (NUM_LIT|STR_LIT))? .
''
private function hParamDecl( byval proc as FBSYMBOL ptr, _
				   			 byval procmode as integer, _
				   			 byval isproto as integer _
				 		   ) as FBSYMBOL ptr

	static as zstring * FB_MAXNAMELEN+1 idTB(0 to FB_MAXARGRECLEVEL-1)
	static as integer arglevel = 0
	dim as zstring ptr pid
	dim as ASTNODE ptr optval
	dim as integer ptype, pmode, plen, psuffix, optional, ptrcnt, readid, mode, dotpos
	dim as FBSYMBOL ptr subtype

	function = NULL

	'' "..."?
	if( lexGetToken( ) = FB_TK_VARARG ) then
		'' not cdecl or is it the first arg?
		if( (procmode <> FB_FUNCMODE_CDECL) or _
			(symbGetProcParams( proc ) = 0) ) then
			hParamError( proc, symbGetProcParams( proc ), *lexGetText( ) )
			exit function
		end if

		lexSkipToken( )

		return symbAddProcParam( proc, NULL, _
						   	     INVALID, NULL, 0, _
						   	     0, FB_PARAMMODE_VARARG, INVALID, _
						   	     FALSE, NULL )
	end if

	'' (BYVAL|BYREF)?
	select case lexGetToken( )
	case FB_TK_BYVAL
		mode = FB_PARAMMODE_BYVAL
		lexSkipToken( )
	case FB_TK_BYREF
		mode = FB_PARAMMODE_BYREF
		lexSkipToken( )
	case else
		mode = INVALID
	end select

	'' only allow keywords as arg names on prototypes
	readid = TRUE
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		if( isproto = FALSE ) then
			'' anything but keywords will be catch by parser (could be a ')' too)
			if( lexGetClass( ) = FB_TKCLASS_KEYWORD ) then
				hParamError( proc, symbGetProcParams( proc ), *lexGetText( ) )
				exit function
			end if
		end if

		if(	lexGetClass( ) <> FB_TKCLASS_KEYWORD ) then
			if( symbGetProcParams( proc ) > 0 ) then
				hParamError( proc, symbGetProcParams( proc ), *lexGetText( ) )
			end if
			exit function
		end if

		if( isproto ) then
			'' AS?
			if( lexGetToken( ) = FB_TK_AS ) then
				readid = FALSE
			end if
		end if
	end if

	''
	if( arglevel >= FB_MAXARGRECLEVEL ) then
		hReportError( FB_ERRMSG_RECLEVELTOODEPTH )
		exit function
	end if

	pid = @idTB(arglevel)

	''
	if( readid ) then
		'' ID
		ptype  = lexGetType( )
		dotpos = lexGetPeriodPos( )
		lexEatToken( pid )

		'' ('('')')
		if( hMatch( CHAR_LPRNT ) ) then
			if( (mode <> INVALID) or _
				(hMatch( CHAR_RPRNT ) = FALSE) ) then
				hParamError( proc, symbGetProcParams( proc ), *pid )
				exit function
			end if

			pmode = FB_PARAMMODE_BYDESC

		else
			if( mode = INVALID ) then
				pmode = env.opt.parammode
			else
				pmode = mode
			end if
		end if

	'' no id
	else
		ptype  = INVALID
		dotpos = 0

		if( mode = INVALID ) then
			pmode = env.opt.parammode
		else
			pmode = mode
		end if
	end if

    '' (AS SymbolType)?
    if( hMatch( FB_TK_AS ) ) then
    	if( ptype <> INVALID ) then
    		hParamError( proc, symbGetProcParams( proc ), *pid )
    		exit function
    	end if

    	arglevel += 1
    	if( cSymbolType( ptype, subtype, plen, ptrcnt ) = FALSE ) then
    		hParamError( proc, symbGetProcParams( proc ), *pid )
    		arglevel -= 1
    		exit function
    	end if
    	arglevel -= 1

    	psuffix = INVALID

    else
    	if( readid = FALSE ) then
    		hParamError( proc, symbGetProcParams( proc ), "" )
    		exit function
    	end if

    	subtype = NULL
    	psuffix = ptype
    	ptrcnt = 0
    end if

    ''
    if( ptype = INVALID ) then
        ptype = hGetDefType( pid )
        psuffix = ptype
    end if

    '' check for invalid args
    select case as const ptype
    '' can't be a fixed-len string
    case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    	hParamError( proc, symbGetProcParams( proc ), *pid )
    	exit function

	'' can't be as ANY on non-prototypes
    case FB_DATATYPE_VOID
    	if( isproto = FALSE ) then
    		hParamError( proc, symbGetProcParams( proc ), *pid )
    		exit function
    	end if
    end select

    ''
    select case pmode
    case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
    	plen = FB_POINTERSIZE

    case FB_PARAMMODE_BYVAL

    	'' check for invalid args
    	if( isproto ) then
    		select case ptype
    		case FB_DATATYPE_VOID
    			hParamError( proc, symbGetProcParams( proc ), *pid )
    			exit function
    		end select
    	end if

    	if( ptype = FB_DATATYPE_STRING ) then
    		plen = FB_POINTERSIZE
    	else
    		plen = symbCalcLen( ptype, subtype, TRUE )
    	end if
    end select

    if( isproto = FALSE ) then
    	'' contains a period?
    	if( dotpos > 0 ) then
    		if( ptype = FB_DATATYPE_USERDEF ) then
    			hParamError( proc, symbGetProcParams( proc ), *pid )
    			exit function
    		end if
    	end if
    end if

    '' ('=' (NUM_LIT|STR_LIT))?
    if( hMatch( FB_TK_ASSIGN ) ) then
        optional = TRUE

		optval = cOptionalExpr( pmode, ptype, subtype )
		if( optval = NULL ) then
 	   		hParamError( proc, symbGetProcParams( proc ), *pid )
 	   	end if

    else
    	optional = FALSE
    	optval = NULL
    end if

    if( isproto ) then
    	pid = NULL
    end if

    function = symbAddProcParam( proc, pid, _
    					         ptype, subtype, ptrcnt, _
    					   	     plen, pmode, psuffix, _
    					   	     optional, optval )

end function


