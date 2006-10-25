''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

declare function 	hParamDecl			( _
											byval proc as FBSYMBOL ptr, _
				   			 			  	byval procmode as integer, _
				   			 			  	byval isproto as integer _
				   			 			) as FBSYMBOL ptr

declare function 	hParamDeclInstPtr 	( _
											byval parent as FBSYMBOL ptr, _
											byval proc as FBSYMBOL ptr _
										) as FBSYMBOL ptr

'':::::
''Parameters=   '(' ParamDecl (',' ParamDecl)* ')' .
''
function cParameters _
	( _
		byval parent as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval procmode as integer, _
		byval isproto as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr param = any

    '' method? add the instance pointer (must be done here
    '' to check for dups)
    param = NULL
    if( parent <> NULL ) then
    	if( symbIsNamespace( parent ) = FALSE ) then
    		param = symAddProcInstancePtr( parent, proc )
    	end if
    end if

	'' '('?
	if( lexGetToken( ) <> CHAR_LPRNT ) then
		return param
	end if

	lexSkipToken( )

	'' ')'?
	if( lexGetToken( ) = CHAR_RPRNT ) then
		lexSkipToken( )
		return param
	end if

	do
		param = hParamDecl( proc, procmode, isproto )
		if( param = NULL ) then
			exit do
		end if

		'' vararg?
		if( param->param.mode = FB_PARAMMODE_VARARG ) then
			exit do
		end if

		'' ','
	   	if( lexGetToken( ) <> CHAR_COMMA ) then
	   		exit do
	   	end if

		lexSkipToken( )
	loop

	'' ')'?
	if( lexGetToken( ) <> CHAR_RPRNT ) then
		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	else
		lexSkipToken( )
	end if

	function = param

end function

'':::::
private function hParamError _
	( _
		byval proc as FBSYMBOL ptr, _
		byval pid as zstring ptr _
	) as integer

	function = errReportParam( proc, _
							   symbGetProcParams( proc )+1, _
							   pid, _
							   FB_ERRMSG_ILLEGALPARAMSPECAT _
							 )

end function

'':::::
private sub hParamWarning _
	( _
		byval proc as FBSYMBOL ptr, _
		byval pid as zstring ptr, _
		byval msgnum as integer _
	)

	errReportParamWarn( proc, _
						symbGetProcParams( proc )+1, _
						pid, _
						msgnum )

end sub

'':::::
private function hOptionalExpr _
	( _
		byval mode as FB_PARAMMODE, _
		byval dtype as FB_DATATYPE, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

    dim as ASTNODE ptr expr = any
    dim as FBSYMBOL ptr sym = any

    function = NULL

    '' not byval or byref?
    if( mode <> FB_PARAMMODE_BYVAL ) then
    	if( mode <> FB_PARAMMODE_BYREF ) then
    		exit function
    	end if
    end if

    select case dtype
    '' UDT? let SymbolInit() build a tree..
    case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    	sym = symbAddTempVar( dtype, subtype, FALSE, FALSE )

    	expr = cInitializer( sym, TRUE )

    	symbDelVar( sym )

    '' anything else..
	case else
    	if( cExpression( expr ) = FALSE ) then
    		exit function
    	end if

    	'' check for invalid types..
    	static as ASTNODE lside

    	astBuildVAR( @lside, NULL, 0, dtype, subtype )

    	if( astCheckASSIGN( @lside, expr ) = FALSE ) then
        	exit function
		end if

    end select

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
    		plen = symbCalcLen( dtype, NULL )
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
					  	  0, NULL )

	symbSetIsMock( s )

	function = s

end function

'':::::
'' ParamDecl      =   (BYVAL|BYREF)? ID (('(' ')')? (AS SymbolType)?)? ('=" (NUM_LIT|STR_LIT))? .
''
private function hParamDecl _
	( _
		byval proc as FBSYMBOL ptr, _
		byval proc_mode as integer, _
		byval isproto as integer _
	) as FBSYMBOL ptr

	static as zstring * FB_MAXNAMELEN+1 idTB(0 to FB_MAXARGRECLEVEL-1)
	static as integer param_level = 0
	dim as zstring ptr param_id = any
	dim as ASTNODE ptr optval = any
	dim as integer param_dtype = any, param_mode = any, param_len = any
	dim as integer param_suffix = any, param_ptrcnt = any, attrib = any
	dim as integer readid = any, dotpos = any, doskip = any, dontinit = any
	dim as FBSYMBOL ptr param_subtype = any, s = any

	function = NULL

	'' '...'?
	if( lexGetToken( ) = CHAR_DOT ) then
		if( lexGetLookAhead( 1 ) = CHAR_DOT ) then
		    lexSkipToken( )
		    lexSkipToken( )

		    ''
		    if( lexGetToken( ) <> CHAR_DOT ) then
		    	if( hParamError( proc, "..." ) = FALSE ) then
		    		exit function
		    	else
		    		'' error recovery: skip until next ')', this is the last param
		    		hSkipUntil( CHAR_RPRNT )
		    		hMockParam( proc, FB_PARAMMODE_VARARG )
		    	end if
			else
				lexSkipToken( )
		    end if

			'' not cdecl or is it the first arg?
			if( (proc_mode <> FB_FUNCMODE_CDECL) or _
				(symbGetProcParams( proc ) = 0) ) then
				if( hParamError( proc, "..." ) = FALSE ) then
					exit function
				else
					return hMockParam( proc, FB_PARAMMODE_VARARG )
				end if
			end if

			return symbAddProcParam( proc, NULL, _
						   	     	 INVALID, NULL, 0, _
						   	     	 0, FB_PARAMMODE_VARARG, INVALID, _
						   	      	 0, NULL )

		'' syntax error..
		else
		    if( hParamError( proc, "..." ) = FALSE ) then
		    	exit function
		    else
		    	'' error recovery: skip until next ')', this is the last param
		    	hSkipUntil( CHAR_RPRNT )
		    	return hMockParam( proc, FB_PARAMMODE_VARARG )
		    end if
		end if
	end if

	'' (BYVAL|BYREF)?
	select case lexGetToken( )
	case FB_TK_BYVAL
		param_mode = FB_PARAMMODE_BYVAL
		lexSkipToken( )
	case FB_TK_BYREF
		param_mode = FB_PARAMMODE_BYREF
		lexSkipToken( )
	case else
		param_mode = INVALID
	end select

	'' only allow keywords as param names on prototypes
	readid = TRUE
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then

		select case lexGetClass( )
		case FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
			if( isproto = FALSE ) then
				if( hParamError( proc, lexGetText( ) ) = FALSE ) then
					exit function
				else
					'' error recovery: skip until next ',' or ')' and return a mock param
					hSkipUntil( CHAR_COMMA )
					return hMockParam( proc, param_mode )
				end if

			else
				'' AS?
				if( lexGetToken( ) = FB_TK_AS ) then
					readid = FALSE
				end if
			end if

		case else
			if( symbGetProcParams( proc ) > 0 ) then
				if( hParamError( proc, lexGetText( ) ) = FALSE ) then
					exit function
				else
					'' error recovery: skip until next ',' or ')' and return a mock param
					hSkipUntil( CHAR_COMMA )
					return hMockParam( proc, param_mode )
				end if
			end if
			exit function
		end select

	end if

	''
	if( param_level >= FB_MAXARGRECLEVEL ) then
		if( errReport( FB_ERRMSG_RECLEVELTOODEEP ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until next ',' or ')' and return a mock param
			hSkipUntil( CHAR_COMMA )
			return hMockParam( proc, param_mode )
		end if
	end if

	param_id = @idTB(param_level)

	''
	if( readid ) then
		'' ID
		*param_id = *lexGetText( )
		dotpos = lexGetPeriodPos( )

		param_dtype = lexGetType( )
		hCheckSuffix( param_dtype )

		lexSkipToken( )

		'' ('('')')
		if( lexGetToken( ) = CHAR_LPRNT ) then
			lexSkipToken( )
			if( (param_mode <> INVALID) or _
				(hMatch( CHAR_RPRNT ) = FALSE) ) then
				if( hParamError( proc, param_id ) = FALSE ) then
					exit function
				end if
			end if

			param_mode = FB_PARAMMODE_BYDESC
		end if

	'' no id
	else
		param_dtype  = INVALID
	end if

	if( param_mode = INVALID ) then
		param_mode = env.opt.parammode
    	if( fbPdCheckIsSet( FB_PDCHECK_PARAMMODE ) ) then
    		hParamWarning( proc, param_id, FB_WARNINGMSG_NOEXPLICITPARAMMODE )
    	end if
	end if

    '' (AS SymbolType)?
    doskip = FALSE
    if( lexGetToken( ) = FB_TK_AS ) then
    	lexSkipToken( )
    	if( param_dtype <> INVALID ) then
    		if( hParamError( proc, param_id ) ) then
    			exit function
    		else
    			param_dtype = INVALID
    		end if
    	end if

    	param_level += 1

    	'' if it's a proto, allow forward types in byref params
    	dim as integer options = FB_SYMBTYPEOPT_DEFAULT

    	if( param_mode = FB_PARAMMODE_BYREF ) then
			if( isproto ) then
				options or= FB_SYMBTYPEOPT_ALLOWFORWARD
			end if
		end if

    	if( cSymbolType( param_dtype, param_subtype, _
    					 param_len, param_ptrcnt, options ) = FALSE ) then
    		if( hParamError( proc, param_id ) = FALSE ) then
    			param_level -= 1
    			exit function
    		else
    			'' error recovery: fake type
    			param_dtype = FB_DATATYPE_INTEGER
    			param_subtype = NULL
    			param_ptrcnt = 0
    			doskip = TRUE
    		end if
    	end if
    	param_level -= 1

    	param_suffix = INVALID

    else
        if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) = FALSE ) then
        	if( errReportNotAllowed( FB_LANG_OPT_DEFTYPE, _
        							 FB_ERRMSG_DEFTYPEONLYVALIDINLANG ) = FALSE ) then
				exit function
			else
				doskip = TRUE
			end if
        else
    		if( readid = FALSE ) then
    			if( hParamError( proc, NULL ) = FALSE ) then
    				exit function
    			else
    				doskip = TRUE
    			end if
    		end if
    	end if

    	param_subtype = NULL
    	param_suffix = param_dtype
    	param_ptrcnt = 0
    end if

    ''
    if( param_dtype = INVALID ) then
        param_dtype = symbGetDefType( param_id )
        param_suffix = param_dtype
    end if

	if( doskip ) then
		hSkipUntil( CHAR_COMMA )
	end if

    '' check for invalid args
    select case as const param_dtype
    '' can't be a fixed-len string
    case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    	if( hParamError( proc, param_id ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: fake correct type
    		param_dtype += FB_DATATYPE_POINTER
    	end if

	'' can't be as ANY on non-prototypes
    case FB_DATATYPE_VOID
    	if( isproto = FALSE ) then
    		if( hParamError( proc, param_id ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake correct type
    			param_dtype += FB_DATATYPE_POINTER
    		end if

    	else
    		if( param_mode = FB_PARAMMODE_BYVAL ) then
    			if( hParamError( proc, param_id ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: fake correct param
    				param_dtype += FB_DATATYPE_POINTER
    			end if
    		end if
    	end if

    case FB_DATATYPE_STRUCT
    	if( isproto = FALSE ) then
    		'' contains a period?
    		if( dotpos > 0 ) then
    			if( hParamError( proc, param_id ) = FALSE ) then
    				exit function
    			end if
    		end if
    	end if
    end select

    '' calc len
   	param_len = symbCalcProcParamLen( param_dtype, param_subtype, param_mode )
   	if( isproto = FALSE ) then
   		if( param_len > (FB_INTEGERSIZE * 4) ) then
   			if( fbPdCheckIsSet( FB_PDCHECK_PARAMSIZE ) ) then
   				hParamWarning( proc, param_id, FB_WARNINGMSG_PARAMSIZETOOBIG )
   			end if
   		end if
   	end if

    '' default values
    attrib = 0
   	optval = NULL
   	dontinit = FALSE

    '' ('=' (expr | ANY))?
    if( lexGetToken( ) = FB_TK_ASSIGN ) then
    	lexSkipToken( )

    	if( param_mode = FB_PARAMMODE_BYDESC ) then
    		'' ANY?
    		if( lexGetToken( ) = FB_TK_ANY ) then
            	lexSkipToken( )

				dontinit = TRUE

    		else
 	   			if( hParamError( proc, param_id ) = FALSE ) then
 	   				exit function
 	   			else
 	   				'' error recovery: skip until next ',' or ')'
 	   				hSkipUntil( CHAR_COMMA )
 	   			end if
    		end if

    	else
        	attrib or= FB_SYMBATTRIB_OPTIONAL
			optval = hOptionalExpr( param_mode, param_dtype, param_subtype )

			if( optval = NULL ) then
 	   			if( hParamError( proc, param_id ) = FALSE ) then
 	   				exit function
 	   			else
 	   				'' error recovery: skip until next ',' or ')' and create a def value
 	   				hSkipUntil( CHAR_COMMA )
					if( param_dtype <> FB_DATATYPE_STRUCT ) then
						optval = astNewCONSTz( param_dtype )
					else
						attrib and= not FB_SYMBATTRIB_OPTIONAL
					end if
 	   			end if
 	   		end if
    	end if

    end if

    if( isproto ) then
    	param_id = NULL
    end if

    s = symbAddProcParam( proc, param_id, _
    					  param_dtype, param_subtype, param_ptrcnt, _
    					  param_len, param_mode, param_suffix, _
    					  attrib, optval )

	if( s <> NULL ) then
		if( dontinit ) then
			symbSetDontInit( s )
		end if
	end if

	function = s

end function

