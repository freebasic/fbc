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
''SymbolDecl      =   (REDIM PRESERVE?|DIM|COMMON) SHARED? SymbolDef
''				  |   EXTERN IMPORT? SymbolDef ALIAS STR_LIT
''                |   STATIC SymbolDef .							// ambiguity w/ STATIC SUB|FUNCTION
''
function cSymbolDecl as integer
	dim alloctype as integer
	dim dopreserve as integer
    dim is_dim as integer

	function = FALSE

	select case as const lexGetToken( )
	case FB_TK_DIM, FB_TK_REDIM, FB_TK_COMMON, FB_TK_EXTERN

		alloctype = 0
		dopreserve = FALSE

		select case as const lexGetToken( )
		'' REDIM
		case FB_TK_REDIM
			lexSkipToken( )
			alloctype or= FB_ALLOCTYPE_DYNAMIC

			'' PRESERVE?
			if( hMatch( FB_TK_PRESERVE ) ) then
				dopreserve = TRUE
			end if

		'' COMMON
		case FB_TK_COMMON
			'' can't use COMMON inside a proc or inside a scope block
			if( env.scope > 0 ) then
    			if( fbIsLocal( ) ) then
    				hReportError( FB_ERRMSG_ILLEGALINSIDEASUB )
    			else
    				hReportError( FB_ERRMSG_ILLEGALINSIDEASCOPE )
    			end if
    			exit function
			end if

			''
			lexSkipToken( )

			alloctype or= FB_ALLOCTYPE_COMMON or FB_ALLOCTYPE_DYNAMIC

		'' EXTERN
		case FB_TK_EXTERN
			'' can't use EXTERN inside a proc
			if( env.scope > 0 ) then
    			if( fbIsLocal( ) ) then
    				hReportError( FB_ERRMSG_ILLEGALINSIDEASUB )
    			else
    				hReportError( FB_ERRMSG_ILLEGALINSIDEASCOPE )
    			end if
    			exit function
			end if

			lexSkipToken( )

			alloctype or= FB_ALLOCTYPE_EXTERN or FB_ALLOCTYPE_SHARED

		case else
			lexSkipToken( )
            is_dim = TRUE

		end select

		''
		if( env.opt.dynamic ) then
			alloctype or= FB_ALLOCTYPE_DYNAMIC
		end if

		if( (alloctype and FB_ALLOCTYPE_EXTERN) = 0 ) then
			'' SHARED?
			if( lexGetToken( ) = FB_TK_SHARED ) then
				'' can't use SHARED inside a proc
				if( env.scope > 0 ) then
					if( fbIsLocal( ) ) then
    					hReportError( FB_ERRMSG_ILLEGALINSIDEASUB )
    				else
    					hReportError( FB_ERRMSG_ILLEGALINSIDEASCOPE )
    				end if
    				exit function
				end if

				lexSkipToken( )
				alloctype or= FB_ALLOCTYPE_SHARED
			end if

		else
			'' IMPORT?
			if( hMatch( FB_TK_IMPORT ) ) then
				'' only if target is Windows
				select case env.clopt.target
				case FB_COMPTARGET_WIN32, FB_COMPTARGET_CYGWIN
					alloctype or= FB_ALLOCTYPE_IMPORT
				end select
			end if
		end if

		''
		if( env.isprocstatic ) then
			if( (alloctype and FB_ALLOCTYPE_DYNAMIC) = 0 ) then
				alloctype or= FB_ALLOCTYPE_STATIC
			end if
		end if

		''
		function = cSymbolDef( alloctype, dopreserve, is_dim )

	'' STATIC
	case FB_TK_STATIC

		'' check ambiguity with STATIC SUB|FUNCTION
		select case lexGetLookAhead( 1 )
		case FB_TK_SUB, FB_TK_FUNCTION
			exit function
		end select

		'' can't use STATIC outside a proc
		if( not fbIsLocal( ) ) then
   			hReportError( FB_ERRMSG_ILLEGALOUTSIDEASUB )
   			exit function
		end if

		lexSkipToken( )

		function = cSymbolDef( FB_ALLOCTYPE_STATIC )

	end select

end function

'':::::
private function hIsDynamic( byval dimensions as integer, _
					 		 exprTB() as ASTNODE ptr ) as integer
    dim i as integer

	function = TRUE

	if( dimensions = -1 ) then
		exit function
	end if

	for i = 0 to dimensions-1
		if( not astIsCONST( exprTB(i, 0) ) ) then
			exit function
		elseif( not astIsCONST( exprTB(i, 1) ) ) then
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
		exit function
	end if

	for i = 0 to dimensions-1
		'' lower bound
		expr = exprTB(i, 0)

		select case as const astGetDataType( expr )
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			dTB(i).lower = astGetValLong( expr )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			dTB(i).lower = astGetValFloat( expr )
		case else
			dTB(i).lower = astGetValInt( expr )
		end select

		astDel( expr )

		'' upper bound
		expr = exprTB(i, 1)

		select case as const astGetDataType( expr )
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			dTB(i).upper = astGetValLong( expr )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			dTB(i).upper = astGetValFloat( expr )
		case else
			dTB(i).upper = astGetValInt( expr )
		end select

		astDel( expr )
	next i

end sub

'':::::
private function hDeclExternVar( byval id as zstring ptr, _
						 		 byval typ as integer, _
						 		 byval subtype as FBSYMBOL ptr, _
						 		 byval alloctype as integer, _
						 		 byval addsuffix as integer, _
						 		 byval dimensions as integer, _
					   	 		 dTB() as FBARRAYDIM ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr s

    function = NULL

    s = symbFindByNameAndSuffix( id, typ )
    if( s <> NULL ) then

    	'' no extern?
    	if( not symbIsExtern( s ) ) then
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
			if( (alloctype and FB_ALLOCTYPE_DYNAMIC) = 0 ) then
    			hReportErrorEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, *id )
    			exit function
    		end if
    	else
			if( (alloctype and FB_ALLOCTYPE_DYNAMIC) > 0 ) then
    			hReportErrorEx( FB_ERRMSG_EXPECTEDDYNAMICARRAY, *id )
    			exit function
    		end if

    		'' no static as local
    		if( env.scope > 0 ) then
    			if( fbIsLocal( ) ) then
    				hReportErrorEx( FB_ERRMSG_ILLEGALINSIDEASUB, *id )
    			else
    				hReportErrorEx( FB_ERRMSG_ILLEGALINSIDEASCOPE, *id )
    			end if
    			exit function
    		end if
    	end if

    	'' dup extern?
    	if( (alloctype and FB_ALLOCTYPE_EXTERN) > 0 ) then
    		return s
    	end if

    	'' set type
    	symbSetAllocType( s, (alloctype and not FB_ALLOCTYPE_EXTERN) or _
    					      FB_ALLOCTYPE_PUBLIC or _
    					      FB_ALLOCTYPE_SHARED )

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
    	if( (alloctype and FB_ALLOCTYPE_EXTERN) > 0 ) then
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
					     		 byval alloctype as integer, _
					     		 byval dimensions as integer, _
					     		 exprTB() as ASTNODE ptr ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s
    dim as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)

    hMakeArrayDimTB( dimensions, exprTB(), dTB() )

    alloctype and= (not FB_ALLOCTYPE_DYNAMIC)

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
    				  alloctype, addsuffix, FALSE, TRUE )

    if( s = NULL ) then
    	s = hDeclExternVar( id, typ, subtype, alloctype, _
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
	if( fbIsLocal( ) ) then
		if( dimensions > 0 ) then
			if( (alloctype and (FB_ALLOCTYPE_SHARED or FB_ALLOCTYPE_STATIC)) = 0 ) then
				if( not rtlArraySetDesc( s, lgt, dimensions, dTB() ) ) then
					return NULL
				end if
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
					   		   byval alloctype as integer, _
					   		   byval dopreserve as integer, _
					   		   byval dimensions as integer, _
					   		   exprTB() as ASTNODE ptr ) as FBSYMBOL ptr static

    dim as FBSYMBOL ptr s
    dim as integer atype, isrealloc
    dim as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)

    function = NULL

    atype = (alloctype or FB_ALLOCTYPE_DYNAMIC) and (not FB_ALLOCTYPE_STATIC)

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
   							  atype, addsuffix, FALSE, TRUE )
   			if( s = NULL ) then
   				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
   				exit function
   			end if
   		end if

   	end if

	'' check reallocation
	if( isrealloc ) then
		'' not dynamic?
		if( not symbGetIsDynamic( s ) ) then

   			'' could be an external..
   			s = hDeclExternVar( id, typ, subtype, atype, addsuffix, _
   								dimensions, dTB() )
   			if( s = NULL ) then
   				hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
				exit function
			end if

		else

			'' external?
			if( symbIsExtern( s ) ) then
				if( (atype and FB_ALLOCTYPE_EXTERN) > 0 ) then
   					hReportErrorEx( FB_ERRMSG_DUPDEFINITION, *id )
					exit function
				end if

				symbSetAllocType( s, (atype and not FB_ALLOCTYPE_EXTERN) or _
    					             FB_ALLOCTYPE_PUBLIC or _
    					             FB_ALLOCTYPE_SHARED )
			end if
		end if
	end if

	alloctype = symbGetAllocType( s )

	'' external? don't do any checks
	if( (alloctype and FB_ALLOCTYPE_EXTERN) > 0 ) then
		return s
	end if

	'' not an argument passed by descriptor or a common array?
	if( (alloctype and (FB_ALLOCTYPE_ARGUMENTBYDESC or FB_ALLOCTYPE_COMMON)) = 0 ) then

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

	'' if dimensions not = -1 (COMMON or DIM|REDIM array()), redim it
	if( dimensions > 0 ) then
		if( not rtlArrayRedim( s, lgt, dimensions, exprTB(), dopreserve ) ) then
			exit function
		end if
	end if

	'' if COMMON, check for max dimensions used
	if( (alloctype and FB_ALLOCTYPE_COMMON) > 0 ) then
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
function cSymbolDef( byval alloctype as integer, _
					 byval dopreserve as integer = FALSE, _
                     byval is_dim as integer = FALSE ) as integer static

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

    	if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		exit function
    	end if

    	'' ANY?
    	if( typ = FB_SYMBTYPE_VOID ) then
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

    	if( not ismultdecl ) then
    		typ 		= lexGetType
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

			if( lexGetToken( ) = CHAR_RPRNT ) then
				'' can't predict the size needed by the descriptor on stack
				if( fbIsLocal( ) ) then
					hReportError( FB_ERRMSG_ILLEGALINSIDEASUB, true )
					exit function
				end if

				dimensions = -1 				'' fake it
    		else
    			'' only allow indexes if not COMMON
    			if( (alloctype and FB_ALLOCTYPE_COMMON) = 0 ) then
    				if( not cArrayDecl( dimensions, exprTB() ) ) then
    					exit function
    				end if
    			end if
    		end if

			'' ')'
    		if( not hMatch( CHAR_RPRNT ) ) then
    			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
    			exit function
    		end if

            '' QB quirk:
            '' when the symbol was defined already by a preceeding COMMON
            '' statement, then a DIM will work the same way as a REDIM
            if( is_dim ) then
                test_symbol = symbFindByNameAndClass( @id, FB_SYMBCLASS_VAR )
                if( test_symbol <> NULL ) then
                    if( symbGetArrayDimensions(test_symbol) <> 0 ) and _
                      ( (symbGetAllocType(test_symbol) and FB_ALLOCTYPE_COMMON) <> 0 ) _
                    then
                        alloctype and= not FB_ALLOCTYPE_STATIC
                        alloctype or= FB_ALLOCTYPE_DYNAMIC
                    end if
                end if
            end if

    	end if

		'' ALIAS LIT_STR
		if( (alloctype and (FB_ALLOCTYPE_PUBLIC or FB_ALLOCTYPE_EXTERN)) > 0 ) then
			if( hMatch( FB_TK_ALIAS ) ) then
				if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
					hReportError( FB_ERRMSG_SYNTAXERROR )
					exit function
				end if
				lexEatToken( idalias )
				idalias = hCreateDataAlias( idalias, (alloctype and FB_ALLOCTYPE_IMPORT) > 0 )
				palias = @idalias
			end if
		end if

    	'' dynamic?
    	isdynamic = FALSE
    	if( dimensions <> 0 ) then
			if( (alloctype and FB_ALLOCTYPE_DYNAMIC) > 0 ) then
				isdynamic = TRUE
			else
				if( (dimensions = -1) or hIsDynamic( dimensions, exprTB() ) ) then
    				isdynamic = TRUE
				end if
			end if
		end if

    	if( not ismultdecl ) then
    		'' (AS SymbolType)?
    		if( lexGetToken( ) = FB_TK_AS ) then

    			if( typ <> INVALID ) then
    				hReportError( FB_ERRMSG_SYNTAXERROR )
    				exit function
    			end if

    			lexSkipToken( )

    			if( not cSymbolType( typ, subtype, lgt, ptrcnt ) ) then
    				hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    				exit function
    			end if

    			'' ANY?
    			if( typ = FB_SYMBTYPE_VOID ) then
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
    		if( typ = FB_SYMBTYPE_USERDEF ) then
    			hReportErrorEx( FB_ERRMSG_CANTINCLUDEPERIODS, id )
    			exit function
    		end if
    	end if

    	''
    	if( isdynamic ) then
    		symbol = hDynArrayDef( id, dotpos, palias, _
    							   typ, subtype, ptrcnt, istypeless, _
    							   lgt, addsuffix, alloctype, dopreserve, _
    							   dimensions, exprTB() )
    	else
			symbol = hStaticSymbDef( id, dotpos, palias, _
									 typ, subtype, ptrcnt, _
    							     lgt, addsuffix, alloctype, _
    							     dimensions, exprTB() )
		end if

    	if( symbol = NULL ) then
    		exit function
    	end if

		'' ('=' SymbolInitializer)?
		select case lexGetToken( )
		case FB_TK_DBLEQ, FB_TK_EQ
			lexSkipToken( )
        	if( not cSymbolInit( symbol ) ) then
        		exit function
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
    if( not hMatch( CHAR_LPRNT ) ) then
    	exit function
    end if

    i = 0
    do
    	'' Expression
		if( not cExpression( expr ) ) then
			hReportError FB_ERRMSG_EXPECTEDCONST
			exit function
		else
			if( not astIsCONST( expr ) ) then
				hReportError FB_ERRMSG_EXPECTEDCONST
				exit function
			end if
		end if

		select case as const astGetDataType( expr )
		case IR_DATATYPE_LONGINT, IR_DATATYPE_ULONGINT
			dTB(i).lower = astGetValLong( expr )
		case IR_DATATYPE_SINGLE, IR_DATATYPE_DOUBLE
			dTB(i).lower = astGetValFloat( expr )
		case else
			dTB(i).lower = astGetValInt( expr )
		end select

		astDel( expr )

        '' TO
    	if( lexGetToken( ) = FB_TK_TO ) then
    		lexSkipToken( )

    		'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB_ERRMSG_EXPECTEDCONST
				exit function
			else
				if( not astIsCONST( expr ) ) then
					hReportError FB_ERRMSG_EXPECTEDCONST
					exit function
				end if
			end if

			dTB(i).upper = astGetValueAsInt( expr )
			astDel( expr )

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
    if( not hMatch( CHAR_RPRNT ) ) then
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
		if( not cExpression( expr ) ) then
			hReportError FB_ERRMSG_EXPECTEDEXPRESSION
			exit function
		end if

    	'' check if non-numeric
    	if( astGetDataClass( expr ) >= IR_DATACLASS_STRING ) then
    		hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
    		exit function
    	end if

		exprTB(i,0) = expr

        '' TO
    	if( lexGetToken( ) = FB_TK_TO ) then
    		lexSkipToken( )

    		'' Expression
			if( not cExpression( expr ) ) then
				hReportError FB_ERRMSG_EXPECTEDEXPRESSION
				exit function
			end if

    		'' check if non-numeric
    		if( astGetDataClass( expr ) >= IR_DATACLASS_STRING ) then
    			hReportError( FB_ERRMSG_INVALIDDATATYPES, TRUE )
    			exit function
    		end if

			exprTB(i,1) = expr

    	else
    	    exprTB(i,1) = exprTB(i,0)
    		exprTB(i,0) = astNewCONSTi( env.opt.base, IR_DATATYPE_INTEGER )
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

