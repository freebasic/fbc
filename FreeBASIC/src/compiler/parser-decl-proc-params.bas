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


'' proc parameters list declarations (called "arg" by mistake)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

declare function 	hParamDecl			( _
											byval proc as FBSYMBOL ptr, _
				   			 			  	byval procmode as integer, _
				   			 			  	byval isproto as integer _
				   			 			) as FBSYMBOL ptr

'':::::
''Parameters=   ParamDecl (',' ParamDecl)* .
''
function cParameters _
	( _
		byval proc as FBSYMBOL ptr, _
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
	    if( lexGetToken( ) <> CHAR_COMMA ) then
	    	exit do
	    end if

		lexSkipToken( )
	loop

	function = n

end function

'':::::
private function hParamError _
	( _
		byval proc as FBSYMBOL ptr, _
		byval argnum as integer, _
		byval argid as zstring ptr _
	) as integer

	function = hReportParamError( proc, argnum+1, argid, FB_ERRMSG_ILLEGALPARAMSPECAT )

end function

'':::::
private function cOptionalExpr _
	( _
		byval mode as FB_PARAMMODE, _
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

    	expr = cVariableInit( sym, TRUE )
    	symbDelVar( sym )
    end if

	function = expr

end function

'':::::
private function hMockParam _
	( _
		byval proc as FBSYMBOL ptr, _
		byval pmode as integer = INVALID _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s
	dim as integer dtype, plen

	if( pmode = INVALID ) then
		pmode = env.opt.parammode
	end if

    dtype = FB_DATATYPE_INTEGER

    select case pmode
    case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
    	plen = FB_POINTERSIZE

    case FB_PARAMMODE_BYVAL
    	if( dtype = FB_DATATYPE_STRING ) then
    		plen = FB_POINTERSIZE
    	else
    		plen = symbCalcLen( dtype, NULL, TRUE )
    	end if

    case FB_PARAMMODE_VARARG
    	dtype = INVALID
    	plen = 0
    end select

	s = symbAddProcParam( proc, _
						  NULL, _
						  dtype, NULL, 0, plen, _
					  	  pmode, _
					  	  INVALID, _
					  	  FALSE, NULL )

	symbSetIsMock( s )

	function = s

end function

'':::::
'' ParamDecl      =   (BYVAL|BYREF)? ID (('(' ')')? (AS SymbolType)?)? ('=" (NUM_LIT|STR_LIT))? .
''
private function hParamDecl _
	( _
		byval proc as FBSYMBOL ptr, _
		byval procmode as integer, _
		byval isproto as integer _
	) as FBSYMBOL ptr

	static as zstring * FB_MAXNAMELEN+1 idTB(0 to FB_MAXARGRECLEVEL-1)
	static as integer arglevel = 0
	dim as zstring ptr pid
	dim as ASTNODE ptr optval
	dim as integer ptype, pmode, plen, psuffix, optional, ptrcnt
	dim as integer readid, mode, dotpos, doskip
	dim as FBSYMBOL ptr subtype

	function = NULL

	'' '...'?
	if( lexGetToken( ) = CHAR_DOT ) then
		if( lexGetLookAhead( 1 ) = CHAR_DOT ) then
		    lexSkipToken( )
		    lexSkipToken( )

		    ''
		    if( lexGetToken( ) <> CHAR_DOT ) then
		    	if( hParamError( proc, symbGetProcParams( proc ), "..." ) = FALSE ) then
		    		exit function
		    	else
		    		'' error recovery: skip until next ')', this is the last param
		    		cSkipUntil( CHAR_RPRNT )
		    		hMockParam( proc, FB_PARAMMODE_VARARG )
		    	end if
			else
				lexSkipToken( )
		    end if

			'' not cdecl or is it the first arg?
			if( (procmode <> FB_FUNCMODE_CDECL) or _
				(symbGetProcParams( proc ) = 0) ) then
				if( hParamError( proc, symbGetProcParams( proc ), "..." ) = FALSE ) then
					exit function
				else
					return hMockParam( proc, FB_PARAMMODE_VARARG )
				end if
			end if

			return symbAddProcParam( proc, NULL, _
						   	     	 INVALID, NULL, 0, _
						   	     	 0, FB_PARAMMODE_VARARG, INVALID, _
						   	      	 FALSE, NULL )

		'' syntax error..
		else
		    if( hParamError( proc, symbGetProcParams( proc ), "..." ) = FALSE ) then
		    	exit function
		    else
		    	'' error recovery: skip until next ')', this is the last param
		    	cSkipUntil( CHAR_RPRNT )
		    	return hMockParam( proc, FB_PARAMMODE_VARARG )
		    end if
		end if
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
				if( hParamError( proc, symbGetProcParams( proc ), lexGetText( ) ) = FALSE ) then
					exit function
				else
					'' error recovery: skip until next ',' or ')' and return a mock param
					cSkipUntil( CHAR_COMMA )
					return hMockParam( proc, mode )
				end if
			end if
		end if

		if(	lexGetClass( ) <> FB_TKCLASS_KEYWORD ) then
			if( symbGetProcParams( proc ) > 0 ) then
				if( hParamError( proc, symbGetProcParams( proc ), lexGetText( ) ) = FALSE ) then
					exit function
				else
					'' error recovery: skip until next ',' or ')' and return a mock param
					cSkipUntil( CHAR_COMMA )
					return hMockParam( proc, mode )
				end if
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
		if( hReportError( FB_ERRMSG_RECLEVELTOODEEP ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until next ',' or ')' and return a mock param
			cSkipUntil( CHAR_COMMA )
			return hMockParam( proc, mode )
		end if
	end if

	pid = @idTB(arglevel)

	''
	if( readid ) then
		'' ID
		*pid = *lexGetText( )
		ptype = lexGetType( )
		lexSkipToken( )

		'' ('('')')
		if( lexGetToken( ) = CHAR_LPRNT ) then
			lexSkipToken( )
			if( (mode <> INVALID) or _
				(hMatch( CHAR_RPRNT ) = FALSE) ) then
				if( hParamError( proc, symbGetProcParams( proc ), pid ) = FALSE ) then
					exit function
				end if
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

		if( mode = INVALID ) then
			pmode = env.opt.parammode
		else
			pmode = mode
		end if
	end if

    '' (AS SymbolType)?
    doskip = FALSE
    if( lexGetToken( ) = FB_TK_AS ) then
    	lexSkipToken( )
    	if( ptype <> INVALID ) then
    		if( hParamError( proc, symbGetProcParams( proc ), pid ) ) then
    			exit function
    		else
    			ptype = INVALID
    		end if
    	end if

    	arglevel += 1
    	if( cSymbolType( ptype, subtype, plen, ptrcnt ) = FALSE ) then
    		if( hParamError( proc, symbGetProcParams( proc ), pid ) = FALSE ) then
    			arglevel -= 1
    			exit function
    		else
    			'' error recovery: fake type
    			ptype = FB_DATATYPE_INTEGER
    			subtype = NULL
    			ptrcnt = 0
    			doskip = TRUE
    		end if
    	end if
    	arglevel -= 1

    	psuffix = INVALID

    else
    	if( readid = FALSE ) then
    		if( hParamError( proc, symbGetProcParams( proc ), "" ) = FALSE ) then
    			exit function
    		else
    			doskip = TRUE
    		end if
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

	if( doskip ) then
		cSkipUntil( CHAR_COMMA )
	end if

    '' check for invalid args
    select case as const ptype
    '' can't be a fixed-len string
    case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    	if( hParamError( proc, symbGetProcParams( proc ), pid ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: fake correct type
    		ptype += FB_DATATYPE_POINTER
    	end if

	'' can't be as ANY on non-prototypes
    case FB_DATATYPE_VOID
    	if( isproto = FALSE ) then
    		if( hParamError( proc, symbGetProcParams( proc ), pid ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake correct type
    			ptype += FB_DATATYPE_POINTER
    		end if
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
    			if( hParamError( proc, symbGetProcParams( proc ), pid ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: fake correct param
    				ptype += FB_DATATYPE_POINTER
    			end if
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
    			if( hParamError( proc, symbGetProcParams( proc ), pid ) = FALSE ) then
    				exit function
    			end if
    		end if
    	end if
    end if

    '' ('=' (NUM_LIT|STR_LIT))?
    if( lexGetToken( ) = FB_TK_ASSIGN ) then
    	lexSkipToken( )
        optional = TRUE

		optval = cOptionalExpr( pmode, ptype, subtype )
		if( optval = NULL ) then
 	   		if( hParamError( proc, symbGetProcParams( proc ), pid ) = FALSE ) then
 	   			exit function
 	   		else
 	   			'' error recovery: skip until next ',' or ')' and create a def value
 	   			cSkipUntil( CHAR_COMMA )
				if( ptype <> FB_DATATYPE_USERDEF ) then
					optval = astNewCONSTz( ptype )
				else
					optional = FALSE
				end if
 	   		end if
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


