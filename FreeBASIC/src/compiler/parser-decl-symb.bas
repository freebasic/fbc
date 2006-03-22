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


'' symbol declarations (DIM, REDIM, COMMON, EXTERN or STATIC)
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private function hCheckScope( ) as integer

	if( env.scope > FB_MAINSCOPE ) then
		if( fbIsModLevel( ) = FALSE ) then
			hReportError( FB_ERRMSG_ILLEGALINSIDEASUB )
		else
			hReportError( FB_ERRMSG_ILLEGALINSIDEASCOPE )
		end if

		return FALSE
	end if

	function = TRUE

end function

'':::::
''SymbolDecl      =   (REDIM PRESERVE?|DIM|COMMON) SHARED? SymbolDef
''				  |   EXTERN IMPORT? SymbolDef ALIAS STR_LIT
''                |   STATIC SymbolDef .							// ambiguity w/ STATIC SUB|FUNCTION
''
function cSymbolDecl as integer
	dim as integer attrib, dopreserve, tk

	function = FALSE

	tk = lexGetToken( )
	select case as const tk
	case FB_TK_DIM, FB_TK_REDIM, FB_TK_COMMON, FB_TK_EXTERN, _
		 FB_TK_STATIC

		attrib = 0
		dopreserve = FALSE

		select case as const lexGetToken( )
		'' REDIM
		case FB_TK_REDIM
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
				exit function
			end if

			''
			lexSkipToken( )

			attrib or= FB_SYMBATTRIB_COMMON or FB_SYMBATTRIB_DYNAMIC or FB_SYMBATTRIB_STATIC

		'' EXTERN
		case FB_TK_EXTERN
			'' can't use EXTERN inside a proc
			if( hCheckScope( ) = FALSE ) then
				exit function
			end if

			lexSkipToken( )

			attrib or= FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC

		'' STATIC
		case FB_TK_STATIC

			'' check ambiguity with STATIC SUB|FUNCTION
			select case lexGetLookAhead( 1 )
			case FB_TK_SUB, FB_TK_FUNCTION
				exit function
			end select

			lexSkipToken( )

			attrib or= FB_SYMBATTRIB_STATIC

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
					exit function
				end if

				lexSkipToken( )
				attrib or= FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
			end if

		else
			'' IMPORT?
			if( hMatch( FB_TK_IMPORT ) ) then
				'' only if target is Windows
				select case env.clopt.target
				case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
					attrib or= FB_SYMBATTRIB_IMPORT
				end select
			end if
		end if

		''
		if( env.isprocstatic ) then
			if( (attrib and FB_SYMBATTRIB_DYNAMIC) = 0 ) then
				attrib or= FB_SYMBATTRIB_STATIC
			end if
		end if

		''
		function = cSymbolDef( attrib, dopreserve, tk )

	end select

end function

'':::::
private function hIsDynamic( byval dimensions as integer, _
					 		 exprTB() as ASTNODE ptr ) as integer
    dim i as integer

	function = TRUE

	for i = 0 to dimensions-1
		if( astIsCONST( exprTB(i, 0) ) = FALSE ) then
			exit function
		elseif( astIsCONST( exprTB(i, 1) ) = FALSE ) then
			exit function
		end if
	next i

	function = FALSE

end function

''::::
private sub hMakeArrayDimTB( byval dimensions as integer, _
					 		 exprTB() as ASTNODE ptr, _
					 		 dTB() as FBARRAYDIM )
    static as integer i
    static as ASTNODE ptr expr

	if( dimensions = -1 ) then
		exit sub
	end if

	for i = 0 to dimensions-1
		'' lower bound
		expr = exprTB(i, 0)

		select case as const astGetDataType( expr )
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			dTB(i).lower = astGetValLong( expr )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			dTB(i).lower = astGetValFloat( expr )
		case else
			dTB(i).lower = astGetValInt( expr )
		end select

		astDelNode( expr )

		'' upper bound
		expr = exprTB(i, 1)

		select case as const astGetDataType( expr )
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			dTB(i).upper = astGetValLong( expr )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			dTB(i).upper = astGetValFloat( expr )
		case else
			dTB(i).upper = astGetValInt( expr )
		end select

		astDelNode( expr )
	next i

end sub

'':::::
private function hDeclExternVar( byval id as zstring ptr, _
						 		 byval typ as integer, _
						 		 byval subtype as FBSYMBOL ptr, _
						 		 byval attrib as integer, _
						 		 byval addsuffix as integer, _
						 		 byval dimensions as integer, _
					   	 		 dTB() as FBARRAYDIM _
					   	 	   ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr s

    function = NULL

    s = symbFindByNameAndSuffix( id, typ )
    if( s <> NULL ) then

    	'' no extern?
    	if( symbIsExtern( s ) = FALSE ) then
    		exit function
    	end if

    	'' check type
		if( (typ <> symbGetType( s )) or _
			(subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
    		exit function
		end if

		'' dynamic?
		if( symbIsDynamic( s ) ) then
			if( (attrib and FB_SYMBATTRIB_DYNAMIC) = 0 ) then
    			hReportErrorEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, *id )
    			exit function
    		end if
    	else
			if( (attrib and FB_SYMBATTRIB_DYNAMIC) > 0 ) then
    			hReportErrorEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, *id )
    			exit function
    		end if

    		'' no static as local
    		if( hCheckScope( ) = FALSE ) then
				exit function
			end if
    	end if

    	'' dup extern?
    	if( (attrib and FB_SYMBATTRIB_EXTERN) > 0 ) then
    		return s
    	end if

    	'' set type
    	symbSetAttrib( s, (attrib and not FB_SYMBATTRIB_EXTERN) or _
    					      FB_SYMBATTRIB_PUBLIC or _
    					      FB_SYMBATTRIB_SHARED )

		'' check dimensions
		if( symbGetArrayDimensions( s ) <> 0 ) then
			if( dimensions <> symbGetArrayDimensions( s ) ) then
    			hReportErrorEx( FB_ERRMSG_WRONGDIMENSIONS, *id )
    			exit function
    		end if

			'' set dims
			symbSetArrayDims( s, dimensions, dTB() )

		end if

    else
    	'' dup extern?
    	if( (attrib and FB_SYMBATTRIB_EXTERN) > 0 ) then
    		exit function
    	end if

    end if

    function = s

end function

'':::::
private function hStaticSymbDef( byval id as zstring ptr, _
					     		 byval dotpos as integer, _
					     		 byval idalias as zstring ptr, _
					     		 byval typ as integer, _
					     		 byval subtype as FBSYMBOL ptr, _
					     		 byval ptrcnt as integer, _
					     		 byval lgt as integer, _
					     		 byval addsuffix as integer, _
					     		 byval attrib as integer, _
					     		 byval dimensions as integer, _
					     		 exprTB() as ASTNODE ptr _
					     	   ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s
    dim as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)

    hMakeArrayDimTB( dimensions, exprTB(), dTB() )

    attrib and= (not FB_SYMBATTRIB_DYNAMIC)

    '' symbol with periods? double-check..
    if( dotpos > 0 ) then
    	'' any UDT var already allocated?
    	if( symbLookupUDTVar( id, dotpos ) <> NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
    		exit function
    	end if
    end if

    ''
    s = symbAddVarEx( id, idalias, typ, subtype, ptrcnt, _
    				  lgt, dimensions, dTB(), _
    				  attrib, addsuffix, FALSE, TRUE )

    if( s = NULL ) then
    	s = hDeclExternVar( id, typ, subtype, attrib, _
    						addsuffix, dimensions, dTB() )

		if( s = NULL ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
    		return NULL
    	end if

	end if

	'' another quirk: if array is local (ie, inside a proc) and it's not dynamic, it's
	'' descriptor won't will be filled ever, so a call to another rtl routine is needed,
	'' or that array coulnd't be passed by descriptor to other procs (allocating a static
	'' descriptor won't help, as that would break recursion)
	if( dimensions > 0 ) then
		if( (attrib and (FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC)) = 0 ) then
			if( rtlArraySetDesc( s, lgt, dimensions, dTB() ) = FALSE ) then
				return NULL
			end if
		end if
	end if

	function = s

end function

'':::::
private function hDynArrayDef( byval id as zstring ptr, _
							   byval dotpos as integer, _
					   		   byval idalias as zstring ptr, _
					   		   byval typ as integer, _
					   		   byval subtype as FBSYMBOL ptr, _
					   		   byval ptrcnt as integer, _
					   		   byval istypeless as integer, _
					   		   byval lgt as integer, _
					   		   byval addsuffix as integer, _
					   		   byval attrib as integer, _
					   		   byval dopreserve as integer, _
					   		   byval dimensions as integer, _
					   		   exprTB() as ASTNODE ptr _
					   		 ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s
    dim as integer isrealloc
    dim as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)

    function = NULL

    attrib or= FB_SYMBATTRIB_DYNAMIC

    '' symbol with periods? double-check..
    if( dotpos > 0 ) then
    	'' any UDT var already allocated?
    	if( symbLookupUDTVar( id, dotpos ) <> NULL ) then
    		hReportErrorEx( FB_ERRMSG_CANTREDIMARRAYFIELDS, *id )
    		exit function
    	end if
    end if

    ''
  	isrealloc = TRUE
  	s = symbFindByNameAndSuffix( id, typ )
   	if( s = NULL ) then

   		'' typeless REDIM's?
   		if( istypeless ) then
   			'' try to find a var with the same name
   			s = symbFindByNameAndClass( id, FB_SYMBCLASS_VAR )
   			'' copy type
   			if( s <> NULL ) then
   				typ 	= symbGetType( s )
   				subtype = symbGetSubtype( s )
   				lgt		= symbGetLen( s )
   			end if
   		end if

   		if( s = NULL ) then
   			isrealloc = FALSE
   			s = symbAddVarEx( id, idalias, typ, subtype, ptrcnt, _
   							  lgt, dimensions, dTB(), _
   							  attrib, addsuffix, FALSE, TRUE )
   			if( s = NULL ) then
   				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
   				exit function
   			end if
   		end if

   	end if

	'' check reallocation
	if( isrealloc ) then
		'' not dynamic?
		if( symbGetIsDynamic( s ) = FALSE ) then

   			'' could be an external..
   			s = hDeclExternVar( id, typ, subtype, attrib, addsuffix, _
   								dimensions, dTB() )
   			if( s = NULL ) then
   				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
				exit function
			end if

		else

			'' external?
			if( symbIsExtern( s ) ) then
				if( (attrib and FB_SYMBATTRIB_EXTERN) > 0 ) then
   					hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
					exit function
				end if

				symbSetAttrib( s, (attrib and not FB_SYMBATTRIB_EXTERN) or _
    					             FB_SYMBATTRIB_PUBLIC or _
    					             FB_SYMBATTRIB_SHARED )
			end if
		end if
	end if

	attrib = symbGetAttrib( s )

	'' external? don't do any checks
	if( (attrib and FB_SYMBATTRIB_EXTERN) > 0 ) then
		return s
	end if

	'' not an argument passed by descriptor or a common array?
	if( (attrib and (FB_SYMBATTRIB_PARAMBYDESC or FB_SYMBATTRIB_COMMON)) = 0 ) then

		if( (typ <> symbGetType( s )) or (subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
    		exit function
		end if

		if( symbGetArrayDimensions( s ) > 0 ) then
			if( dimensions <> symbGetArrayDimensions( s ) ) then
    			hReportErrorEx( FB_ERRMSG_WRONGDIMENSIONS, *id )
    			exit function
    		end if
		end if

	'' else, can't check it's dimensions at compile-time
	else
		if( (typ <> symbGetType( s )) or (subtype <> symbGetSubType( s )) ) then
    		hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
    		exit function
		end if
	end if

	'' if dimensions not -1 (COMMON or DIM|REDIM array()), redim it
	if( dimensions > 0 ) then
		if( rtlArrayRedim( s, lgt, dimensions, exprTB(), dopreserve ) = FALSE ) then
			exit function
		end if

	else
		'' otherwise if it's a local array, the descriptor must be
		'' initialized, or passing it to another proc by desc will
		'' cause errors if the called proc tries to redim the array
		if( (attrib and (FB_SYMBATTRIB_SHARED or _
						 FB_SYMBATTRIB_COMMON or _
						 FB_SYMBATTRIB_STATIC or _
						 FB_SYMBATTRIB_PARAMBYDESC)) = 0 ) then

			rtlArraySetDesc( s, symbGetLen( s ), 0, dTB() )

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

'':::::
''SymbolDef       =   ID ('(' ArrayDecl? ')')? (AS SymbolType)? ('=' VarInitializer)?
''                       (',' SymbolDef)* .
''
function cSymbolDef( byval attrib as integer, _
					 byval dopreserve as integer, _
                     byval token as integer _
                   ) as integer static

    static as zstring * FB_MAXNAMELEN+1 id, idalias
    dim as FBSYMBOL ptr symbol, subtype, test_symbol
    dim as integer addsuffix, isdynamic, ismultdecl, istypeless
    dim as integer typ, lgt, ofs, ptrcnt, dotpos
    dim as integer dimensions
    dim as ASTNODE ptr exprTB(0 to FB_MAXARRAYDIMS-1, 0 to 1)
    dim as zstring ptr palias

    function = FALSE

    '' (AS SymbolType)?
    ismultdecl = FALSE
    if( lexGetToken( ) = FB_TK_AS ) then
    	lexSkipToken( )

    	if( cSymbolType( typ, subtype, lgt, ptrcnt ) = FALSE ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		exit function
    	end if

    	'' ANY?
    	if( typ = FB_DATATYPE_VOID ) then
    		hReportError( FB_ERRMSG_INVALIDDATATYPES )
    		exit function
    	end if

    	addsuffix = FALSE

    	ismultdecl = TRUE
    end if

    do
    	'' ID
    	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		exit function
    	end if

    	if( ismultdecl = FALSE ) then
    		typ 		= lexGetType( )
    		subtype 	= NULL
    		lgt			= 0
    		addsuffix 	= TRUE
    	else
    		if( lexGetType( ) <> INVALID ) then
    			hReportError( FB_ERRMSG_SYNTAXERROR )
    			exit function
    		end if
    	end if

    	dotpos = lexGetPeriodPos( )
    	lexEatToken( id )
    	palias = NULL
    	istypeless	= FALSE

    	'' ('(' ArrayDecl? ')')?
		dimensions = 0
		if( hMatch( CHAR_LPRNT ) ) then
			isdynamic = (attrib and FB_SYMBATTRIB_DYNAMIC) > 0

			if( lexGetToken( ) = CHAR_RPRNT ) then
				dimensions = INVALID 				'' fake it
				isdynamic = TRUE
    		else
    			'' only allow indexes if not COMMON
    			if( (attrib and FB_SYMBATTRIB_COMMON) = 0 ) then
    				if( cArrayDecl( dimensions, exprTB() ) = FALSE ) then
    					exit function
    				end if

					'' STATIC and the indexes are not constants? not valid..
					if( hIsDynamic( dimensions, exprTB() )) then
						if( token = FB_TK_STATIC ) then
    						hReportError( FB_ERRMSG_EXPECTEDCONST )
    						exit function
						end if

						isdynamic = TRUE
					end if
    			end if
    		end if

			'' ')'
    		if( hMatch( CHAR_RPRNT ) = FALSE ) then
    			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
    			exit function
    		end if

            '' QB quirk:
            '' when the symbol was defined already by a preceeding COMMON
            '' statement, then a DIM will work the same way as a REDIM
            if( token = FB_TK_DIM ) then
                test_symbol = symbFindByNameAndClass( @id, FB_SYMBCLASS_VAR )
                if( test_symbol <> NULL ) then
                    if( (symbGetArrayDimensions( test_symbol ) <> 0) and _
                      	symbIsCommon( test_symbol ) ) then
                        isdynamic = TRUE
                    end if
                end if
            end if

    	'' scalar..
    	else
    		'' REDIM and scalar passed?
    		if( token = FB_TK_REDIM ) then
    			hReportErrorEx( FB_ERRMSG_EXPECTEDARRAY, @id )
    			exit function
    		end if

    		isdynamic = FALSE
    	end if

		'' ALIAS LIT_STR
		if( (attrib and (FB_SYMBATTRIB_PUBLIC or FB_SYMBATTRIB_EXTERN)) > 0 ) then
			if( hMatch( FB_TK_ALIAS ) ) then
				if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
					hReportError( FB_ERRMSG_SYNTAXERROR )
					exit function
				end if
				lexEatToken( idalias )
				idalias = hCreateDataAlias( idalias, (attrib and FB_SYMBATTRIB_IMPORT) > 0 )
				palias = @idalias
			end if
		end if

    	if( ismultdecl = FALSE ) then
    		'' (AS SymbolType)?
    		if( lexGetToken( ) = FB_TK_AS ) then

    			if( typ <> INVALID ) then
    				hReportError( FB_ERRMSG_SYNTAXERROR )
    				exit function
    			end if

    			lexSkipToken( )

    			if( cSymbolType( typ, subtype, lgt, ptrcnt ) = FALSE ) then
    				hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    				exit function
    			end if

    			'' ANY?
    			if( typ = FB_DATATYPE_VOID ) then
    				hReportError( FB_ERRMSG_INVALIDDATATYPES )
    				exit function
    			end if

    			addsuffix = FALSE

    		else

				if( typ = INVALID ) then
					istypeless = TRUE
					typ = hGetDefType( id )
				end if
    			lgt	= symbCalcLen( typ, subtype )

    		end if
    	end if

    	'' contains a period?
    	if( dotpos > 0 ) then
    		if( typ = FB_DATATYPE_USERDEF ) then
    			hReportErrorEx( FB_ERRMSG_CANTINCLUDEPERIODS, id )
    			exit function
    		end if
    	end if

    	''
    	if( isdynamic ) then
    		symbol = hDynArrayDef( id, dotpos, palias, _
    							   typ, subtype, ptrcnt, istypeless, _
    							   lgt, addsuffix, attrib, dopreserve, _
    							   dimensions, exprTB() )
    	else
			symbol = hStaticSymbDef( id, dotpos, palias, _
									 typ, subtype, ptrcnt, _
    							     lgt, addsuffix, attrib, _
    							     dimensions, exprTB() )
		end if

    	if( symbol = NULL ) then
    		exit function
    	end if

		'' ('=' SymbolInitializer)?
		select case lexGetToken( )
		case FB_TK_DBLEQ, FB_TK_EQ
			lexSkipToken( )

        	dim as ASTNODE ptr tree
        	tree = cSymbolInit( symbol, TRUE )
        	if( tree = NULL ) then
        		exit function
        	end if

        	'' not static or shared?
        	if( (symbGetAttrib( symbol ) and _
        		 (FB_SYMBATTRIB_STATIC or FB_SYMBATTRIB_SHARED)) = 0 ) then

        		astTypeIniFlush( tree, symbol, FALSE, TRUE )

        	'' static or shared (includes extern/public), let emit flush it..
        	else
        		if( astTypeIniIsConst( tree ) = FALSE ) then
        			exit function
        		end if

        		symbSetTypeIniTree( symbol, tree )
        	end if
		end select

		'' (DECL_SEPARATOR SymbolDef)*
		if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
			exit do
		end if

		lexSkipToken( )

    loop

    function = TRUE

end function

'':::::
''ArrayDecl       =   '(' Expression (TO Expression)?
''                             (DECL_SEPARATOR Expression (TO Expression)?)*
''				      ')' .
''
function cStaticArrayDecl( byref dimensions as integer, _
						   dTB() as FBARRAYDIM ) as integer

    static as integer i
    static as ASTNODE ptr expr

    function = FALSE

    dimensions = 0

    '' IDX_OPEN
    if( hMatch( CHAR_LPRNT ) = FALSE ) then
    	exit function
    end if

    i = 0
    do
    	'' Expression
		if( cExpression( expr ) = FALSE ) then
			hReportError FB_ERRMSG_EXPECTEDCONST
			exit function
		else
			if( astIsCONST( expr ) = FALSE ) then
				hReportError FB_ERRMSG_EXPECTEDCONST
				exit function
			end if
		end if

		select case as const astGetDataType( expr )
		case FB_DATATYPE_LONGINT, FB_DATATYPE_ULONGINT
			dTB(i).lower = astGetValLong( expr )
		case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
			dTB(i).lower = astGetValFloat( expr )
		case else
			dTB(i).lower = astGetValInt( expr )
		end select

		astDelNode( expr )

        '' TO
    	if( lexGetToken( ) = FB_TK_TO ) then
    		lexSkipToken( )

    		'' Expression
			if( cExpression( expr ) = FALSE ) then
				hReportError FB_ERRMSG_EXPECTEDCONST
				exit function
			else
				if( astIsCONST( expr ) = FALSE ) then
					hReportError FB_ERRMSG_EXPECTEDCONST
					exit function
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
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if

		if( i >= FB_MAXARRAYDIMS ) then
			hReportError FB_ERRMSG_TOOMANYDIMENSIONS
			exit function
		end if
	loop

	'' IDX_CLOSE
    if( hMatch( CHAR_RPRNT ) = FALSE ) then
    	hReportError FB_ERRMSG_EXPECTEDRPRNT
    	exit function
    end if

	function = TRUE

end function

'':::::
''ArrayDecl    	  =   '(' Expression (TO Expression)?
''                             (DECL_SEPARATOR Expression (TO Expression)?)*
''				      ')' .
''
function cArrayDecl( byref dimensions as integer, _
					 exprTB() as ASTNODE ptr ) as integer

    dim as integer i
    dim as ASTNODE ptr expr

    function = FALSE

    dimensions = 0

    i = 0
    do
    	'' Expression
		if( cExpression( expr ) = FALSE ) then
			hReportError FB_ERRMSG_EXPECTEDEXPRESSION
			exit function
		end if

    	'' check if non-numeric
    	if( astGetDataClass( expr ) >= FB_DATACLASS_STRING ) then
    		hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
    		exit function
    	end if

		exprTB(i,0) = expr

        '' TO
    	if( lexGetToken( ) = FB_TK_TO ) then
    		lexSkipToken( )

    		'' Expression
			if( cExpression( expr ) = FALSE ) then
				hReportError FB_ERRMSG_EXPECTEDEXPRESSION
				exit function
			end if

    		'' check if non-numeric
    		if( astGetDataClass( expr ) >= FB_DATACLASS_STRING ) then
    			hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
    			exit function
    		end if

			exprTB(i,1) = expr

    	else
    	    exprTB(i,1) = exprTB(i,0)
    		exprTB(i,0) = astNewCONSTi( env.opt.base, FB_DATATYPE_INTEGER )
    	end if

    	dimensions += 1
    	i += 1

    	'' separator
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	else
    		lexSkipToken( )
    	end if

		if( i >= FB_MAXARRAYDIMS ) then
			hReportError FB_ERRMSG_TOOMANYDIMENSIONS
			exit function
		end if
	loop

	function = TRUE

end function

