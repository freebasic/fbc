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


'' variable declarations (DIM, REDIM, COMMON, EXTERN or STATIC)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

declare function 	hVarDecl 				( _
												byval attrib as integer, _
												byval dopreserve as integer, _
                                              	byval token as integer _
											) as integer


'':::::
private function hCheckScope( ) as integer

	if( env.scope > FB_MAINSCOPE ) then
		if( fbIsModLevel( ) = FALSE ) then
			errReport( FB_ERRMSG_ILLEGALINSIDEASUB )
		else
			errReport( FB_ERRMSG_ILLEGALINSIDEASCOPE )
		end if

		return FALSE
	end if

	function = TRUE

end function

'':::::
''VariableDecl    =   (REDIM PRESERVE?|DIM|COMMON) SHARED? SymbolDef
''				  |   EXTERN IMPORT? SymbolDef ALIAS STR_LIT
''                |   STATIC SymbolDef .							// ambiguity w/ STATIC SUB|FUNCTION
''
function cVariableDecl( ) as integer
	dim as integer attrib, dopreserve, tk

	function = FALSE

	attrib = 0
	dopreserve = FALSE

	tk = lexGetToken( )
	select case as const tk
	'' REDIM
	case FB_TK_REDIM
		'' REDIM generates code, check if allowed
    	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    		exit function
    	end if

		lexSkipToken( )
		attrib or= FB_SYMBATTRIB_DYNAMIC

		'' PRESERVE?
		if( hMatch( FB_TK_PRESERVE ) ) then
			dopreserve = TRUE
		end if

	'' COMMON
	case FB_TK_COMMON
		'' can't use COMMON inside a proc or inside a scope block
		if( hCheckScope( ) = FALSE ) then
			if( errGetCount( ) >= env.clopt.maxerrors ) then
				exit function
			else
				'' error recovery: don't share it
				attrib = FB_SYMBATTRIB_DYNAMIC or FB_SYMBATTRIB_STATIC
			end if

		else
			attrib = FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_DYNAMIC or FB_SYMBATTRIB_STATIC
		end if

		lexSkipToken( )


	'' EXTERN
	case FB_TK_EXTERN
		'' ambiguity with EXTERN "mangling spec"
		if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_STRLITERAL ) then
			return FALSE
		end if

		'' can't use EXTERN inside a proc
		if( hCheckScope( ) = FALSE ) then
			if( errGetCount( ) >= env.clopt.maxerrors ) then
				exit function
			else
				'' error recovery: don't make it extern
				attrib = FB_SYMBATTRIB_STATIC
			end if

		else
			attrib = FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
		end if

		lexSkipToken( )

	'' STATIC
	case FB_TK_STATIC
		'' check ambiguity with STATIC SUB|FUNCTION
		select case lexGetLookAhead( 1 )
		case FB_TK_SUB, FB_TK_FUNCTION
			exit function
		end select

		lexSkipToken( )

		attrib = FB_SYMBATTRIB_STATIC

	case else
		lexSkipToken( )

	end select

	''
	if( env.opt.dynamic ) then
		if( (attrib and FB_SYMBATTRIB_STATIC) = 0 ) then
			attrib or= FB_SYMBATTRIB_DYNAMIC
		end if
	end if

	if( (attrib and FB_SYMBATTRIB_EXTERN) = 0 ) then
		'' SHARED?
		if( lexGetToken( ) = FB_TK_SHARED ) then
			'' can't use SHARED inside a proc
			if( hCheckScope( ) = FALSE ) then
				if( errGetCount( ) >= env.clopt.maxerrors ) then
					exit function
				else
					'' error recovery: don't make it shared
					attrib or= FB_SYMBATTRIB_STATIC
				end if

			else
				attrib or= FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
			end if

			lexSkipToken( )

		end if

	else
		'' IMPORT?
		if( lexGetToken( ) = FB_TK_IMPORT ) then
			lexSkipToken( )

			'' only if target is Windows
			select case env.clopt.target
			case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
				attrib or= FB_SYMBATTRIB_IMPORT
			end select

		end if
	end if

	''
	if( symbIsStatic( env.currproc ) ) then
		if( (attrib and FB_SYMBATTRIB_DYNAMIC) = 0 ) then
			attrib or= FB_SYMBATTRIB_STATIC
		end if
	end if

	''
	function = hVarDecl( attrib, dopreserve, tk )

end function

'':::::
private function hIsConst _
	( _
		byval dimensions as integer, _
		exprTB() as ASTNODE ptr _
	) as integer

    dim as integer i

	for i = 0 to dimensions-1
		if( astIsCONST( exprTB(i, 0) ) = FALSE ) then
			return FALSE

		elseif( astIsCONST( exprTB(i, 1) ) = FALSE ) then
			return FALSE
		end if
	next

	function = TRUE

end function

'':::::
private function hDeclExternVar _
	( _
		byval ns as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer, _
		byval addsuffix as integer, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr s, desc
	dim as integer setattrib

    function = NULL

    s = symbLookupByNameAndSuffix( ns, id, dtype )
    if( s <> NULL ) then
    	'' no extern?
    	if( symbIsExtern( s ) = FALSE ) then
    		exit function
    	end if

    	'' check type
		if( (dtype <> symbGetType( s )) or _
			(subtype <> symbGetSubType( s )) ) then
    		if( errReportEx( FB_ERRMSG_TYPEMISMATCH, *id ) = FALSE ) then
    			exit function
    		end if
		end if

		setattrib = TRUE

		'' dynamic?
		if( symbIsDynamic( s ) ) then
			if( (attrib and FB_SYMBATTRIB_DYNAMIC) = 0 ) then
    			if( errReportEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, *id ) = FALSE ) then
    				exit function
    			end if
    		end if

    	'' static..
    	else
			if( (attrib and FB_SYMBATTRIB_DYNAMIC) <> 0 ) then
    			if( errReportEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, *id ) = FALSE ) then
    				exit function
    			end if
    		end if

    		'' no extern static as local
    		if( hCheckScope( ) = FALSE ) then
				if( errGetCount( ) >= env.clopt.maxerrors ) then
					exit function
				else
					'' error recovery: don't make it shared
					setattrib = FALSE
				end if
			end if
    	end if

    	'' dup extern?
    	if( (attrib and FB_SYMBATTRIB_EXTERN) <> 0 ) then
    		return s
    	end if

    	'' set type
    	if( setattrib ) then
    		symbSetAttrib( s, (attrib and (not FB_SYMBATTRIB_EXTERN)) or _
    					  	  FB_SYMBATTRIB_PUBLIC or _
    					  	  FB_SYMBATTRIB_SHARED )
		end if

		'' check dimensions
		if( symbGetArrayDimensions( s ) <> 0 ) then
			if( dimensions <> symbGetArrayDimensions( s ) ) then
    			if( errReportEx( FB_ERRMSG_WRONGDIMENSIONS, *id ) = FALSE ) then
    				exit function
    			end if

    		else
				'' set dims
				symbSetArrayDimTb( s, dimensions, dTB() )

				if( setattrib ) then
    				desc = symbGetArrayDescriptor( s )
    				symbSetAttrib( desc, _
    							   (symbGetAttrib( desc ) and (not FB_SYMBATTRIB_EXTERN)) or _
    					  	  	   FB_SYMBATTRIB_PUBLIC or _
    					  	  	   FB_SYMBATTRIB_SHARED )
				end if
    		end if
		end if

    else
    	'' dup extern?
    	if( (attrib and FB_SYMBATTRIB_EXTERN) <> 0 ) then
    		exit function
    	end if

    end if

    function = s

end function

'':::::
private function hDeclStaticVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval idalias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval lgt as integer, _
		byval addsuffix as integer, _
		byval attrib as integer, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s, ns
    dim as integer isextern

    isextern = FALSE

    '' any var already defined?
    if( sym <> NULL ) then
		ns = symbGetNamespace( sym )
        '' different namespaces?
    	if( ns <> symbGetCurrentNamespc( ) ) then
    		'' not extern?
    		if( symbIsExtern( sym ) = FALSE ) then
    			if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
    				exit function
    			end if
    		end if
    		isextern = TRUE
    	end if

	else
		ns = @symbGetGlobalNamespc( )
    end if

    '' remove attrib, because COMMON and $dynamic..
    attrib and= (not FB_SYMBATTRIB_DYNAMIC)

    ''
    if( isextern = FALSE ) then
    	s = symbAddVarEx( id, idalias, dtype, subtype, ptrcnt, _
    				  	  lgt, dimensions, dTB(), _
    				  	  attrib, addsuffix, FALSE )
	else
		s = NULL
	end if

    if( s = NULL ) then
    	'' check if it's not an extern been declared
    	s = hDeclExternVar( ns, id, dtype, subtype, attrib, _
    		  			    addsuffix, dimensions, dTB() )

		if( s = NULL ) then
    		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
    		'' no error recovery: already parsed
    		return NULL
    	end if

	end if

	function = s

end function

'':::::
private function hDeclDynArray _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval idalias as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval ptrcnt as integer, _
		byval istypeless as integer, _
		byval lgt as integer, _
		byval addsuffix as integer, _
		byval attrib as integer, _
		byval dimensions as integer _
	) as FBSYMBOL ptr static

    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)		'' always 0
    dim as FBSYMBOL ptr s, ns
    dim as integer isrealloc

    function = NULL

    if( dimensions <> -1 ) then
		'' DIM'g dynamic arrays gens code, check if allowed
    	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    		exit function
    	end if
	end if

    attrib or= FB_SYMBATTRIB_DYNAMIC

	if( sym <> NULL ) then
		ns = symbGetNamespace( sym )
	else
		ns = @symbGetGlobalNamespc( )
	end if

    ''
  	isrealloc = TRUE
  	s = symbLookupByNameAndSuffix( ns, id, dtype )
   	if( s = NULL ) then

   		'' typeless REDIM's?
   		if( istypeless ) then
   			'' try to find a var with the same name
   			s = symbLookupByNameAndClass( ns, id, FB_SYMBCLASS_VAR )
   			'' copy type
   			if( s <> NULL ) then
   				dtype = symbGetType( s )
   				subtype = symbGetSubtype( s )
   				lgt = symbGetLen( s )
   			end if
   		end if

   		if( s = NULL ) then
   			isrealloc = FALSE
   			s = symbAddVarEx( id, idalias, dtype, subtype, ptrcnt, _
   							  lgt, dimensions, dTB(), _
   							  attrib, addsuffix, FALSE )
   			if( s = NULL ) then
   				errReportEx( FB_ERRMSG_DUPDEFINITION, *id )
   				'' no error recovery, caller will take care of that
   				exit function
   			end if
   		end if

   	end if

	'' check reallocation
	if( isrealloc ) then
		'' not dynamic?
		if( symbGetIsDynamic( s ) = FALSE ) then

   			'' could be an external..
   			s = hDeclExternVar( ns, id, dtype, subtype, attrib, addsuffix, _
   								dimensions, dTB() )
   			if( s = NULL ) then
   				errReportEx( FB_ERRMSG_DUPDEFINITION, *id )
				'' no error recovery, caller will take care of that
				exit function
			end if

		else

			'' external?
			if( symbIsExtern( s ) ) then
				if( (attrib and FB_SYMBATTRIB_EXTERN) <> 0 ) then
   					errReportEx( FB_ERRMSG_DUPDEFINITION, *id )
   					'' no error recovery, ditto
					exit function
				end if

				symbSetAttrib( s, (attrib and _
								   (not FB_SYMBATTRIB_EXTERN)) or _
    					           FB_SYMBATTRIB_PUBLIC or _
    					           FB_SYMBATTRIB_SHARED )
			end if
		end if
	end if

	attrib = symbGetAttrib( s )

	'' external? don't do any checks
	if( (attrib and FB_SYMBATTRIB_EXTERN) <> 0 ) then
		return s
	end if

	'' not an argument passed by descriptor or a common array?
	if( (attrib and (FB_SYMBATTRIB_PARAMBYDESC or FB_SYMBATTRIB_COMMON)) = 0 ) then

		if( (dtype <> symbGetType( s )) or _
			(subtype <> symbGetSubType( s )) ) then
    		errReportEx( FB_ERRMSG_DUPDEFINITION, *id )
    		'' no error recovery, caller will take care of that
    		exit function
		end if

		if( symbGetArrayDimensions( s ) > 0 ) then
			if( dimensions <> symbGetArrayDimensions( s ) ) then
    			errReportEx( FB_ERRMSG_WRONGDIMENSIONS, *id )
    			'' no error recovery, ditto
    			exit function
    		end if
		end if

	'' else, can't check it's dimensions at compile-time
	else
		if( (dtype <> symbGetType( s )) or _
			(subtype <> symbGetSubType( s )) ) then
    		errReportEx( FB_ERRMSG_DUPDEFINITION, *id )
    		'' no error recovery, ditto
    		exit function
		end if
	end if

	'' if COMMON, check for max dimensions used
	if( (attrib and FB_SYMBATTRIB_COMMON) <> 0 ) then
		if( dimensions > symbGetArrayDimensions( s ) ) then
			symbSetArrayDimensions( s, dimensions )
		end if

	'' or if dims = -1 (cause of "DIM|REDIM array()")
	elseif( symbGetArrayDimensions( s ) = -1 ) then
		symbSetArrayDimensions( s, dimensions )

	end if

    function = s

end function

''::::
private sub hMakeArrayDimTB _
	( _
		byval dimensions as integer, _
		exprTB() as ASTNODE ptr, _
		dTB() as FBARRAYDIM _
	)

    static as integer i
    static as ASTNODE ptr expr

	if( dimensions = -1 ) then
		exit sub
	end if

	for i = 0 to dimensions-1
		'' lower bound
		expr = exprTB(i, 0)
		dTB(i).lower = astGetValueAsInt( expr )
		astDelNode( expr )

		'' upper bound
		expr = exprTB(i, 1)
		dTB(i).upper = astGetValueAsInt( expr )
		astDelNode( expr )
	next

end sub

'':::::
''VarDecl         =   ID ('(' ArrayDecl? ')')? (AS SymbolType)? ('=' VarInitializer)?
''                       (',' SymbolDef)* .
''
private function hVarDecl _
	( _
		byval attrib as integer, _
		byval dopreserve as integer, _
        byval token as integer _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id, idalias
    static as ASTNODE ptr exprTB(0 to FB_MAXARRAYDIMS-1, 0 to 1)
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr sym, subtype, ns
    dim as FBSYMCHAIN ptr chain_
    dim as ASTNODE ptr initree
    dim as integer addsuffix, isdynamic, ismultdecl, istypeless, suffix
    dim as integer dtype, lgt, ofs, ptrcnt, dimensions, isdecl
    dim as zstring ptr palias

    function = FALSE

    '' (AS SymbolType)?
    ismultdecl = FALSE
    if( lexGetToken( ) = FB_TK_AS ) then
    	lexSkipToken( )

    	if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
    		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a type
    			dtype = FB_DATATYPE_INTEGER
    			subtype = NULL
    			lgt = FB_INTEGERSIZE
    			ptrcnt = 0
    		end if
    	end if

    	'' ANY?
    	if( dtype = FB_DATATYPE_VOID ) then
    		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake a type
    			dtype += FB_DATATYPE_POINTER
    			subtype = NULL
    			lgt = FB_POINTERSIZE
    			ptrcnt = 1
    		end if
    	end if

    	addsuffix = FALSE

    	ismultdecl = TRUE
    end if

    do
    	chain_ = cIdentifier( TRUE )
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

    	'' symbol found?
    	if( chain_ <> NULL ) then
    		'' any var?
    		sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
    		if( sym <> NULL ) then
    			'' from a different namespace? (because USING)
    			if( symbGetNamespace( sym ) <> symbGetCurrentNamespc( ) ) then
    				'' allow dup, unless it's the global ns (same as in C++)
    				if( symbIsGlobalNamespc( ) = FALSE ) then
    					sym = NULL
    				end if
    			end if
    		end if
    	else
    		sym = NULL
    	end if

    	'' ID
    	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
    		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake an id
    			id = *hMakeTmpStr( )
    			suffix = INVALID
    		end if

    	else
    		'' if inside a namespace, symbols can't contain periods (.)'s
    		if( symbIsGlobalNamespc( ) = FALSE ) then
    			if( lexGetPeriodPos( ) > 0 ) then
    				if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
    					exit function
    				end if
    			end if
    		end if

    		id = *lexGetText( )
    		suffix = lexGetType( )
    		lexSkipToken( )
    	end if

    	istypeless = FALSE

    	if( ismultdecl = FALSE ) then
    		dtype = suffix
    		subtype	= NULL
    		lgt	= 0
    		addsuffix = TRUE
    	else
    		if( suffix <> INVALID ) then
    			if( errReportEx( FB_ERRMSG_SYNTAXERROR, @id ) = FALSE ) then
    				exit function
    			end if
    		end if
    	end if

    	'' ('(' ArrayDecl? ')')?
		dimensions = 0
		if( lexGetToken( ) = CHAR_LPRNT ) then
			lexSkipToken( )

			isdynamic = (attrib and FB_SYMBATTRIB_DYNAMIC) <> 0

            '' QB quirk:
            '' when the symbol was defined already by a preceeding COMMON
            '' statement, then a DIM will work the same way as a REDIM
            if( token = FB_TK_DIM ) then
                if( sym <> NULL ) then
                    if( isdynamic = FALSE ) then
                    	if( symbIsCommon( sym ) ) then
                    		if( symbGetArrayDimensions( sym ) <> 0 ) then
                        		isdynamic = TRUE
                        	end if
                        end if
                    end if
                end if
            end if

			if( lexGetToken( ) = CHAR_RPRNT ) then
				dimensions = -1 				'' fake it
				isdynamic = TRUE

    		else
    			'' only allow subscripts if not COMMON
    			if( (attrib and FB_SYMBATTRIB_COMMON) = 0 ) then
					'' static?
					if( token = FB_TK_STATIC ) then
    					if( cStaticArrayDecl( dimensions, dTB(), FALSE ) = FALSE ) then
	    					exit function
    					end if

    					isdynamic = FALSE

					'' can be static or dynamic..
					else
    					if( cArrayDecl( dimensions, exprTB() ) = FALSE ) then
	    					exit function
    					end if

						'' if subscripts are constants, convert exprTB to dimTB
						if( hIsConst( dimensions, exprTB() ) ) then
							'' only if not explicitly dynamic (ie: not REDIM, COMMON)
							if( isdynamic = FALSE ) then
								hMakeArrayDimTB( dimensions, exprTB(), dTB() )
						    end if
						else
							isdynamic = TRUE
						end if
					end if

    			'' COMMON.. no subscripts
    			else
    				if( lexGetToken( ) <> CHAR_RPRNT ) then
    					if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    						exit function
    					else
    						'' error recovery: skip until next ')'
    						hSkipUntil( CHAR_RPRNT )
    					end if
    				end if
    			end if
    		end if

			'' ')'
    		if( lexGetToken( ) <> CHAR_RPRNT ) then
    			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
    				exit function
    			end if
    		else
    			lexSkipToken( )
    		end if


    	'' scalar..
    	else
    		'' REDIM and scalar passed?
    		if( token = FB_TK_REDIM ) then
    			if( errReportEx( FB_ERRMSG_EXPECTEDARRAY, @id ) = FALSE ) then
    				exit function
    			end if
    		end if

    		isdynamic = FALSE
    	end if

		'' ALIAS LIT_STR?
		palias = NULL
		if( (attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN)) > 0 ) then
			if( lexGetToken( ) = FB_TK_ALIAS ) then
				lexSkipToken( )

				if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
					if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
						exit function
					end if
				else
					lexEatToken( idalias )
					palias = @idalias
				end if
			end if
		end if

    	if( ismultdecl = FALSE ) then
    		'' (AS SymbolType)?
    		if( lexGetToken( ) = FB_TK_AS ) then

    			if( dtype <> INVALID ) then
    				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    					exit function
    				else
    					dtype = INVALID
    				end if
    			end if

    			lexSkipToken( )

    			if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
    				if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    					exit function
    				else
    					'' error recovery: fake a type
    					dtype = FB_DATATYPE_INTEGER
    					subtype = NULL
    					lgt = FB_INTEGERSIZE
    					ptrcnt = 0
    				end if
    			end if

    			'' ANY?
    			if( dtype = FB_DATATYPE_VOID ) then
    				if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    					exit function
    				else
    					'' error recovery: fake a type
    					dtype += FB_DATATYPE_POINTER
    					subtype = NULL
    					lgt = FB_POINTERSIZE
    					ptrcnt = 1
    				end if
    			end if

    			addsuffix = FALSE

    		'' no explicit type..
    		else
				if( dtype = INVALID ) then
					istypeless = TRUE
					dtype = hGetDefType( id )
				end if
    			lgt	= symbCalcLen( dtype, subtype )

    		end if
    	end if

    	''
    	if( isdynamic ) then
    		sym = hDeclDynArray( sym, id, palias, _
    							 dtype, subtype, ptrcnt, istypeless, _
    							 lgt, addsuffix, attrib, _
    							 dimensions )
    	else
			sym = hDeclStaticVar( sym, id, palias, _
								  dtype, subtype, ptrcnt, _
    							  lgt, addsuffix, attrib, _
    							  dimensions, dTB() )
		end if

    	if( sym = NULL ) then
    		if( errGetCount( ) >= env.clopt.maxerrors ) then
    			exit function
    		end if

    		isdecl = FALSE

    	else
    		isdecl = symbGetIsDeclared( sym )
    	end if

		initree = NULL

		'' if not declared yet and not Extern, check for initializers
		if( (isdecl = FALSE) and (token <> FB_TK_EXTERN) ) then

			'' ('=' SymbolInitializer | ANY)?
			select case lexGetToken( )
			case FB_TK_DBLEQ, FB_TK_EQ
				lexSkipToken( )

        		if( sym = NULL ) then
        			'' error recovery: skip until next ','
        			hSkipUntil( CHAR_COMMA )

				else
                	'' ANY?
					if( lexGetToken( ) = FB_TK_ANY ) then

						'' don't allow var-len strings
						select case dtype
						case FB_DATATYPE_STRING
							errReport( FB_ERRMSG_INVALIDDATATYPES )

						case FB_DATATYPE_USERDEF
            				if( symbGetUDTDynCnt( subtype ) <> 0 ) then
            					errReport( FB_ERRMSG_INVALIDDATATYPES )
            				end if

						case else
							symbSetDontInit( sym )
						end select

						lexSkipToken( )

        			else
        				initree = cVariableInit( sym, TRUE )
        				if( initree = NULL ) then
        					if( errGetLast( ) <> FB_ERRMSG_OK ) then
        						exit function
        					end if

        				else
        					'' static or shared?
        					if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
        				  						   	   	   FB_SYMBATTRIB_SHARED)) <> 0 ) then
        						if( astTypeIniIsConst( initree ) = FALSE ) then
	        						if( errGetLast( ) <> FB_ERRMSG_OK ) then
	        							exit function
	        						else
	        							'' error recovery: discard the tree
	        							astDelTree( initree )
	        							initree = NULL
	        						end if
        						end if
        					end if
        				end if

        			end if
        		end if
			end select

		end if

		'' add to AST
		if( sym <> NULL ) then

			dim as FBSYMBOL ptr desc = NULL

			'' not declared already?
    		if( isdecl = FALSE ) then
    			astAdd( astNewDECL( FB_SYMBCLASS_VAR, sym, initree ) )

				desc = symbGetArrayDescriptor( sym )
				if( desc <> NULL ) then
					astAdd( astNewDECL( FB_SYMBCLASS_VAR, _
										desc, _
										symbGetTypeIniTree( desc ) ) )
				end if

    		end if

			'' handle arrays (must be done after adding the decl node)

			'' do nothing if it's EXTERN
			if( token <> FB_TK_EXTERN ) then

				'' array?
				if( isdynamic or (dimensions > 0) ) then
					'' not declared yet?
					if( isdecl = FALSE ) then
						'' local?
						if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
												   	   FB_SYMBATTRIB_SHARED)) = 0 ) then

							'' bydesc array params have no descriptor
							if( desc <> NULL ) then
								astTypeIniFlush( symbGetTypeIniTree( desc ), _
											 	 desc, _
											 	 FALSE, _
											  	 TRUE )

								symbSetTypeIniTree( desc, NULL )
							end if
						end if
					end if
				end if

				'' dynamic? if the dimensions are known, redim it
				if( isdynamic ) then
					if( dimensions > 0 ) then
						rtlArrayRedim( sym, _
									   symbGetLen( sym ), _
									   dimensions, _
									   exprTB(), _
									   dopreserve, _
									   symbGetDontInit( sym ) = FALSE )
					end if
				end if

				'' all set as declared
				symbSetIsDeclared( sym )
			end if

			'' handle ini trees (ditto)
			if( initree <> NULL ) then
				'' not static or shared?
        		if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
        									   FB_SYMBATTRIB_SHARED or _
        									   FB_SYMBATTRIB_COMMON)) = 0 ) then

					astTypeIniFlush( initree, sym, FALSE, TRUE )

				else
                	'' let emit flush it..
       				symbSetTypeIniTree( sym, initree )
				end if
			end if

		end if

		'' (',' SymbolDef)*
		if( lexGetToken( ) <> CHAR_COMMA ) then
			exit do
		end if

		lexSkipToken( )
    loop

    function = TRUE

end function

'':::::
''ArrayDecl       =   '(' Expression (TO Expression)?
''                             (',' Expression (TO Expression)?)*
''				      ')' .
''
function cStaticArrayDecl _
	( _
		byref dimensions as integer, _
		dTB() as FBARRAYDIM, _
		byval checkprnts as integer _
	) as integer

    static as integer i
    static as ASTNODE ptr expr

    function = FALSE

    dimensions = 0

    if( checkprnts ) then
    	'' '('
    	if( lexGetToken() <> CHAR_LPRNT ) then
    		exit function
    	end if

    	lexSkipToken( )
    end if

    i = 0
    do
    	'' Expression
		if( cExpression( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				if( lexGetToken( ) <> FB_TK_TO ) then
					hSkipUntil( CHAR_COMMA )
				end if
				expr = astNewCONSTi( env.opt.base, FB_DATATYPE_INTEGER )
			end if
		else
			if( astIsCONST( expr ) = FALSE ) then
				if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an expr
					astDelTree( expr )
					expr = astNewCONSTi( env.opt.base, FB_DATATYPE_INTEGER )
				end if
			end if
		end if

		dTB(i).lower = astGetValueAsInt( expr )
		astDelNode( expr )

        '' TO
    	if( lexGetToken( ) = FB_TK_TO ) then
    		lexSkipToken( )

    		'' Expression
			if( cExpression( expr ) = FALSE ) then
				if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
					exit function
				else
					'' error recovery: skip to next ',' and fake an expr
					hSkipUntil( CHAR_COMMA )
					expr = astNewCONSTi( dTB(i).lower, FB_DATATYPE_INTEGER )
				end if
			else
				if( astIsCONST( expr ) = FALSE ) then
					if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
						exit function
					else
						'' error recovery: fake an expr
						astDelTree( expr )
						expr = astNewCONSTi( dTB(i).lower, FB_DATATYPE_INTEGER )
					end if
				end if
			end if

			dTB(i).upper = astGetValueAsInt( expr )
			astDelNode( expr )

    	else
    	    dTB(i).upper = dTB(i).lower
    		dTB(i).lower = env.opt.base
    	end if

    	dimensions += 1
    	i += 1

    	'' separator
    	if( lexGetToken( ) <> CHAR_COMMA ) then
    		exit do
    	end if

    	lexSkipToken( )

		if( i >= FB_MAXARRAYDIMS ) then
			if( errReport( FB_ERRMSG_TOOMANYDIMENSIONS ) = FALSE ) then
				exit function
			else
				'' error recovery: skip to next ')'
				hSkipUntil( CHAR_RPRNT )
				exit do
			end if
		end if
	loop

	if( checkprnts ) then
		'' ')'
    	if( lexGetToken( ) <> CHAR_RPRNT ) then
    		if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
    			exit function
    		end if
    	else
    		lexSkipToken( )
    	end if
    end if

	function = TRUE

end function

'':::::
''ArrayDecl    	  =   '(' Expression (TO Expression)?
''                             (',' Expression (TO Expression)?)*
''				      ')' .
''
function cArrayDecl _
	( _
		byref dimensions as integer, _
		exprTB() as ASTNODE ptr _
	) as integer

    dim as integer i
    dim as ASTNODE ptr expr

    function = FALSE

    dimensions = 0

    i = 0
    do
    	'' Expression
		if( cExpression( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
				exit function
			else
				'' error recovery: fake an expr
				if( lexGetToken( ) <> FB_TK_TO ) then
					hSkipUntil( CHAR_COMMA )
				end if
				expr = astNewCONSTi( env.opt.base, FB_DATATYPE_INTEGER )
			end if

		else
    		'' check if non-numeric
    		if( astGetDataClass( expr ) >= FB_DATACLASS_STRING ) then
    			if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: fake an expr
    				astDelTree( expr )
    				expr = astNewCONSTi( env.opt.base, FB_DATATYPE_INTEGER )
    			end if
    		end if
		end if

		exprTB(i,0) = expr

        '' TO
    	if( lexGetToken( ) = FB_TK_TO ) then
    		lexSkipToken( )

    		'' Expression
			if( cExpression( expr ) = FALSE ) then
				if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
					exit function
				else
					'' error recovery: skip to next ',' and fake an expr
					hSkipUntil( CHAR_COMMA )
					expr = astCloneTree( exprTB(i,0) )
				end if

    		else
    			'' check if non-numeric
    			if( astGetDataClass( expr ) >= FB_DATACLASS_STRING ) then
    				if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
    					exit function
    				else
    					'' error recovery: fake an expr
    					expr = astCloneTree( exprTB(i,0) )
    				end if
    			end if
			end if

			exprTB(i,1) = expr

    	else
    	    exprTB(i,1) = exprTB(i,0)
    		exprTB(i,0) = astNewCONSTi( env.opt.base, FB_DATATYPE_INTEGER )
    	end if

    	dimensions += 1
    	i += 1

    	'' separator
    	if( lexGetToken( ) <> CHAR_COMMA ) then
    		exit do
    	end if

    	lexSkipToken( )

		if( i >= FB_MAXARRAYDIMS ) then
			if( errReport( FB_ERRMSG_TOOMANYDIMENSIONS ) = FALSE ) then
				exit function
			else
				'' error recovery: skip to next ')'
				hSkipUntil( CHAR_RPRNT )
				exit do
			end if
		end if
	loop

	function = TRUE

end function

