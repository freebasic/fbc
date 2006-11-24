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


'' variable declarations (DIM, REDIM, COMMON, EXTERN or STATIC)
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private function hCheckScope( ) as integer

	if( parser.scope > FB_MAINSCOPE ) then
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
''                |   STATIC SymbolDef .
''
function cVariableDecl( ) as integer
	dim as integer attrib = any, dopreserve = any, tk = any

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
				attrib = FB_SYMBATTRIB_STATIC or _
						 FB_SYMBATTRIB_DYNAMIC
			end if

		else
			attrib = FB_SYMBATTRIB_COMMON or _
					 FB_SYMBATTRIB_STATIC or _
					 FB_SYMBATTRIB_DYNAMIC	'' this will be removed, if it's not a array
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
			attrib = FB_SYMBATTRIB_EXTERN or _
					 FB_SYMBATTRIB_SHARED or _
					 FB_SYMBATTRIB_STATIC
		end if

		lexSkipToken( )

	'' STATIC
	case FB_TK_STATIC
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
				attrib or= FB_SYMBATTRIB_SHARED or _
						   FB_SYMBATTRIB_STATIC
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
	if( symbIsStatic( parser.currproc ) ) then
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
private sub hVarExtToPub _
	( _
		byval sym as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB _
	) static

	dim as FBSYMBOL ptr desc

	'' remove the extern (or it won't be emitted), make it public (and shared for safety)
	symbSetAttrib( sym, (attrib and (not FB_SYMBATTRIB_EXTERN)) or _
    		            FB_SYMBATTRIB_PUBLIC or _
    			        FB_SYMBATTRIB_SHARED )

    '' array? update the descriptor attributes too
    if( symbGetArrayDimensions( sym ) <> 0 ) then
    	desc = symbGetArrayDescriptor( sym )

    	attrib = (symbGetAttrib( desc ) and (not FB_SYMBATTRIB_EXTERN)) or _
    	  	  	 FB_SYMBATTRIB_SHARED

    	'' not dynamic? descriptor can't be public
    	if( symbIsDynamic( sym ) = FALSE ) then
			attrib and= not FB_SYMBATTRIB_PUBLIC
		else
			attrib or= FB_SYMBATTRIB_PUBLIC
		end if

		symbSetAttrib( desc, attrib )
	end if

end sub

'':::::
private function hDeclExternVar _
	( _
		byval sym as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as integer, _
		byval addsuffix as integer, _
		byval dimensions as integer, _
		dTB() as FBARRAYDIM _
	) as FBSYMBOL ptr static

	dim as FBSYMBOL ptr desc
	dim as integer setattrib

    function = NULL

    if( sym = NULL ) then
    	exit function
    end if

    '' not extern?
    if( symbIsExtern( sym ) = FALSE ) then
    	exit function
    end if

    '' check type
	if( (dtype <> symbGetType( sym )) or _
		(subtype <> symbGetSubType( sym )) ) then
    	if( errReportEx( FB_ERRMSG_TYPEMISMATCH, *id ) = FALSE ) then
    		exit function
    	end if
	end if

	setattrib = TRUE

	'' dynamic?
	if( symbIsDynamic( sym ) ) then
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
    	return sym
    end if

    '' set type
    if( setattrib ) then
    	hVarExtToPub( sym, attrib )
	end if

	'' check dimensions
	if( symbGetArrayDimensions( sym ) <> 0 ) then
		if( dimensions <> symbGetArrayDimensions( sym ) ) then
    		if( errReportEx( FB_ERRMSG_WRONGDIMENSIONS, *id ) = FALSE ) then
    			exit function
    		end if

    	else
			'' set dims
			symbSetArrayDimTb( sym, dimensions, dTB() )
    	end if
	end if

    function = sym

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

    dim as FB_SYMBOPT options
    dim as integer is_extern

    '' any var already defined?
    if( sym <> NULL ) then
    	is_extern = symbIsExtern( sym )
    else
    	is_extern = FALSE
    end if

    '' remove attrib, because COMMON and $dynamic..
    attrib and= (not FB_SYMBATTRIB_DYNAMIC)

    '' new (or dup) var?
    if( is_extern = FALSE ) then
		options = FB_SYMBOPT_NONE

		if( addsuffix ) then
			options or= FB_SYMBOPT_ADDSUFFIX
		end if

		if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
			options or= FB_SYMBOPT_UNSCOPE
		end if

    	sym = symbAddVarEx( id, idalias, dtype, subtype, ptrcnt, _
    				  	  	lgt, dimensions, dTB(), _
    				  	  	attrib, options )

    '' already declared extern..
    else
    	sym = hDeclExternVar( sym, id, dtype, subtype, attrib, _
    		  			      addsuffix, dimensions, dTB() )
	end if

	if( sym = NULL ) then
    	errReportEx( FB_ERRMSG_DUPDEFINITION, id )
    	'' no error recovery: already parsed
    	return NULL
    end if

	function = sym

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
		byval is_typeless as integer, _
		byval lgt as integer, _
		byval addsuffix as integer, _
		byval attrib as integer, _
		byval dimensions as integer _
	) as FBSYMBOL ptr static

    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)		'' always 0
    dim as FBSYMBOL ptr desc
    dim as FB_SYMBOPT options

    function = NULL

    if( dimensions <> -1 ) then
		'' DIM'g dynamic arrays gens code, check if allowed
    	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_CODE ) = FALSE ) then
    		exit function
    	end if
	end if

    attrib or= FB_SYMBATTRIB_DYNAMIC

    '' any variable already defined?
    if( sym <> NULL ) then
   		'' typeless REDIM's?
   		if( is_typeless ) then
   			dtype = symbGetType( sym )
   			subtype = symbGetSubtype( sym )
   			ptrcnt = symbGetPtrCnt( sym )
   			lgt = symbGetLen( sym )
   		end if
    end if

    '' new var?
   	if( sym = NULL ) then
		options = FB_SYMBOPT_NONE

		if( addsuffix ) then
			options or= FB_SYMBOPT_ADDSUFFIX
		end if

		if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
			options or= FB_SYMBOPT_UNSCOPE
		end if

   		sym = symbAddVarEx( id, idalias, dtype, subtype, ptrcnt, _
   						    lgt, dimensions, dTB(), _
   						    attrib, options )

	'' check reallocation..
	else
		'' not dynamic?
		if( symbGetIsDynamic( sym ) = FALSE ) then
   			'' could be an external..
   			sym = hDeclExternVar( sym, id, dtype, subtype, attrib, addsuffix, _
   								  dimensions, dTB() )

		else
			'' external?
			if( symbIsExtern( sym ) ) then
				if( (attrib and FB_SYMBATTRIB_EXTERN) <> 0 ) then
   					sym = NULL
				else
					hVarExtToPub( sym, attrib )
				end if
			end if
		end if
	end if

   	if( sym = NULL ) then
   		errReportEx( FB_ERRMSG_DUPDEFINITION, *id )
		'' no error recovery, caller will take care of that
		exit function
	end if

	attrib = symbGetAttrib( sym )

	'' external? don't do any checks..
	if( (attrib and FB_SYMBATTRIB_EXTERN) <> 0 ) then
		return sym
	end if

	'' not an argument passed by descriptor or a common array?
	if( (attrib and (FB_SYMBATTRIB_PARAMBYDESC or FB_SYMBATTRIB_COMMON)) = 0 ) then

		if( (dtype <> symbGetType( sym )) or _
			(subtype <> symbGetSubType( sym )) ) then
    		errReportEx( FB_ERRMSG_DUPDEFINITION, *id )
    		'' no error recovery, caller will take care of that
    		exit function
		end if

		if( symbGetArrayDimensions( sym ) > 0 ) then
			if( dimensions <> symbGetArrayDimensions( sym ) ) then
    			errReportEx( FB_ERRMSG_WRONGDIMENSIONS, *id )
    			'' no error recovery, ditto
    			exit function
    		end if
		end if

	'' else, can't check it's dimensions at compile-time
	else
		if( (dtype <> symbGetType( sym )) or _
			(subtype <> symbGetSubType( sym )) ) then
    		errReportEx( FB_ERRMSG_DUPDEFINITION, *id )
    		'' no error recovery, ditto
    		exit function
		end if
	end if

	'' if COMMON, check for max dimensions used
	if( (attrib and FB_SYMBATTRIB_COMMON) <> 0 ) then
		if( dimensions > symbGetArrayDimensions( sym ) ) then
			symbSetArrayDimensions( sym, dimensions )
		end if

	'' or if dims = -1 (cause of "DIM|REDIM array()")
	elseif( symbGetArrayDimensions( sym ) = -1 ) then
		symbSetArrayDimensions( sym, dimensions )

	end if

    function = sym

end function

'':::::
private function hGetId _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byref suffix as integer _
	) as FBSYMCHAIN ptr static

	dim as FBSYMCHAIN ptr chain_

	'' no parent? read as-is
	if( parent = NULL ) then
		chain_ = lexGetSymChain( )
    else
		chain_ = symbLookupAt( parent, lexGetText( ), FALSE )
	end if

    '' ID
    select case lexGetClass( )
    case FB_TKCLASS_IDENTIFIER
		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
  				if( lexGetPeriodPos( ) > 0 ) then
  					if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
	 					return NULL
					end if
				end if
			end if
		end if

    	*id = *lexGetText( )
    	suffix = lexGetType( )
    	hCheckSuffix( suffix )

    	lexSkipToken( )

	case FB_TKCLASS_QUIRKWD
		'' only if inside a ns and if not local
		if( (parent = NULL) or (parser.scope > FB_MAINSCOPE) ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    			return NULL
    		else
    			'' error recovery: fake an id
    			*id = *hMakeTmpStr( )
    			suffix = INVALID
    		end if

    	else
    		*id = *lexGetText( )
    		suffix = lexGetType( )
    		hCheckSuffix( suffix )
    	end if

    	lexSkipToken( )

    case else
    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		return NULL
    	else
    		'' error recovery: fake an id
    		*id = *hMakeTmpStr( )
    		suffix = INVALID
    	end if
    end select

    function = chain_

end function

'':::::
private function hLookupVar _
	( _
		byval parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr, _
		byval is_typeless as integer, _
		byval dtype as integer, _
		byval suffix as integer, _
		byval options as FB_IDOPT _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr sym = any

    if( chain_ = NULL ) then
    	return NULL
    end if

    if( is_typeless ) then
    	if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) = FALSE ) then
    		sym = symbFindVarByDefType( chain_, dtype )
    	else
    		sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
    	end if
    elseif( suffix <> INVALID ) then
    	sym = symbFindVarBySuffix( chain_, suffix )
	else
    	sym = symbFindVarByType( chain_, dtype )
    end if

    if( sym = NULL ) then
    	return NULL
    end if

    '' different namespaces?
    if( symbGetNamespace( sym ) <> symbGetCurrentNamespc( ) ) then
    	'' redim? anything allowed..
    	if( (options and FB_IDOPT_ISDECL) = 0 ) then
    		return sym
    	end if

    	'' currently in the global ns?
    	if( symbIsGlobalNamespc( ) ) then
    		'' not extern?
    		if( symbIsExtern( sym ) = FALSE ) then
    			if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
    				exit function
    			end if
    		end if

    	'' inside another ns, allow dups..
    	else
    		return NULL
    	end if
    end if

    function = sym

end function

''::::
private sub hMakeArrayDimTB _
	( _
		byval dimensions as integer, _
		exprTB() as ASTNODE ptr, _
		dTB() as FBARRAYDIM _
	) static

    dim as integer i
    dim as ASTNODE ptr expr

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

    	if( dTB(i).upper < dTB(i).lower ) then
			errReport( FB_ERRMSG_INVALIDSUBSCRIPT )
    	end if
	next

end sub

'':::::
private function hVarInit _
	( _
        byval sym as FBSYMBOL ptr, _
        byval isdecl as integer, _
        byval has_defctor as integer, _
        byval has_dtor as integer _
	) as ASTNODE ptr

    dim as integer attrib = any
	dim as ASTNODE ptr initree = any

	function = NULL

	if( sym <> NULL ) then
		attrib = symbGetAttrib( sym )
	else
		attrib = 0
	end if

	'' '=' | '=>' ?
	select case lexGetToken( )
	case FB_TK_DBLEQ, FB_TK_EQ

	case else
    	if( sym = NULL ) then
    		exit function
    	end if

    	'' ctor?
    	if( has_defctor ) then
			'' not already declared, extern, common or dynamic?
			if( isdecl = FALSE ) then
				if( ((attrib and (FB_SYMBATTRIB_EXTERN or _
								  FB_SYMBATTRIB_COMMON or _
								  FB_SYMBATTRIB_DYNAMIC)) = 0) ) then
					function = astBuildTypeIniCtorList( sym )
				end if
			end if

    	else
    		'' no default ctor but other ctors defined?
    		select case symbGetType( sym )
    		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    			if( symbGetHasCtor( symbGetSubtype( sym ) ) ) then
    				errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
    			end if
    		end select
    	end if

		exit function
	end select

	'' already declared, extern or common?
	if( isdecl or _
		((attrib and (FB_SYMBATTRIB_EXTERN or FB_SYMBATTRIB_COMMON)) <> 0) ) then

		if( errReport( FB_ERRMSG_CANNOTINITEXTERNORCOMMON ) ) then
			'' error recovery: skip
			hSkipUntil( FB_TK_EOL )
		end if

		exit function
	end if

	if( fbLangOptIsSet( FB_LANG_OPT_INITIALIZER ) = FALSE ) then
		if( errReportNotAllowed( FB_LANG_OPT_INITIALIZER )  ) then
			'' error recovery: skip
			hSkipUntil( FB_TK_EOL )
		end if
		exit function
	end if

	lexSkipToken( )

	if( sym = NULL ) then
		'' error recovery: skip until next ','
		hSkipUntil( CHAR_COMMA )
		exit function
	end if

    '' ANY?
	if( lexGetToken( ) = FB_TK_ANY ) then

		'' don't allow var-len strings
		if( symbGetType( sym ) = FB_DATATYPE_STRING ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )

		else
			if( has_defctor or has_dtor ) then
				errReportWarn( FB_WARNINGMSG_ANYINITHASNOEFFECT )
			else
				symbSetDontInit( sym )
			end if
		end if

		lexSkipToken( )

		exit function
	end if

	initree = cInitializer( sym, TRUE )
	if( initree = NULL ) then
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

	'' static or shared?
	if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
  						   	   	   FB_SYMBATTRIB_SHARED)) <> 0 ) then

    	dim as integer has_ctor = FALSE

    	select case symbGetType( sym )
    	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    		has_ctor = symbGetHasCtor( symbGetSubtype( sym ) )
    	end select

		'' only if it's not an object, static or global instances are allowed
		if( has_ctor = FALSE ) then
			if( astTypeIniIsConst( initree ) = FALSE ) then
				'' error recovery: discard the tree
				astDelTree( initree )
				initree = NULL
				symbGetStats( sym ) and= not FB_SYMBSTATS_INITIALIZED
			end if
		end if

	end if

	function = initree

end function

'':::::
private sub hCallStaticCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval has_dtor as integer _
	) static

	dim as FBARRAYDIM dTB(0)
	dim as FBSYMBOL ptr flag, label

	if( (initree = NULL) and (has_dtor = FALSE) ) then
		exit sub
	end if

	'' create a static flag
	flag = symbAddVarEx( hMakeTmpStr(), NULL, _
					  	 FB_DATATYPE_INTEGER, NULL, 0, _
					  	 0, 0, dTB(), _
					     FB_SYMBATTRIB_STATIC )

	astAdd( astNewDECL( FB_SYMBCLASS_VAR, flag, NULL ) )

	'' if flag = 0 then
	label = symbAddLabel( NULL, TRUE )

    astAdd( astUpdComp2Branch( astNewBOP( AST_OP_EQ, _
    									  astNewVAR( flag, _
            										 0, _
            										 FB_DATATYPE_INTEGER ), _
            							  astNewCONSTi( 0, _
            											FB_DATATYPE_INTEGER ) ), _
            				   label, _
            				   FALSE ) )

	'' flag = 1
	astAdd( astBuildVarAssign( flag, 1 ) )

	if( initree <> NULL ) then
		'' initialize it
		astAdd( astTypeIniFlush( initree, sym, FALSE, TRUE ) )
	end if

	'' has a dtor?
	if( has_dtor ) then
	    dim as FBSYMBOL ptr proc
	    proc = astProcAddStaticInstance( sym )

	    '' atexit( @static_proc )
	    astAdd( rtlAtExit( astBuildProcAddrof( proc ) ) )
	end if

	'' end if
	astAdd( astNewLABEL( label ) )

end sub

'':::::
private sub hCallGlobalCtor _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval has_dtor as integer _
	) static

	if( (initree = NULL) and (has_dtor = FALSE) ) then
		exit sub
	end if

	astProcAddGlobalInstance( sym, initree, has_dtor )

end sub

'':::::
private sub hFlushInitializer _
	( _
		byval sym as FBSYMBOL ptr, _
		byval initree as ASTNODE ptr, _
		byval has_defctor as integer, _
		byval has_dtor as integer _
	) static

	'' no initializer?
	if( initree = NULL ) then
		'' static or shared?
        if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
        						   	   FB_SYMBATTRIB_SHARED or _
        						   	   FB_SYMBATTRIB_COMMON)) <> 0 ) then
			'' object?
        	if( has_dtor ) then
        		'' local?
           		if( symbIsLocal( sym ) ) then
           			hCallStaticCtor( sym, NULL, TRUE )

           		'' global..
          		else
        			hCallGlobalCtor( sym, NULL, TRUE )
           		end if
			end if
		end if

		exit sub
	end if

	'' not static or shared?
    if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
    							   FB_SYMBATTRIB_SHARED or _
    							   FB_SYMBATTRIB_COMMON)) = 0 ) then

		astAdd( astTypeIniFlush( initree, sym, FALSE, TRUE ) )

		exit sub
	end if

    dim as integer has_ctor = FALSE
    select case symbGetType( sym )
    case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    	has_ctor = symbGetHasCtor( symbGetSubtype( sym ) )
    end select

	'' not an object?
    if( has_ctor = FALSE ) then
    	'' let emit flush it..
    	symbSetTypeIniTree( sym, initree )

    	'' no dtor?
    	if( has_dtor = FALSE ) then
    		exit sub
    	end if

    	'' must be added to the dtor list..
    	initree = NULL
    end if

    '' don't let emit handle this global/static symbol
    symbGetStats( sym ) and= not FB_SYMBSTATS_INITIALIZED

    '' local?
    if( symbIsLocal( sym ) ) then
       	'' the only possibility is static, SHARED can't be
        '' used in -lang fb..
        hCallStaticCtor( sym, initree, has_dtor )

	'' global.. add to the list, to be emitted later
    else
    	hCallGlobalCtor( sym, initree, has_dtor )
	end if

end sub

'':::::
''VarDecl         =   ID ('(' ArrayDecl? ')')? (AS SymbolType)? ('=' VarInitializer)?
''                       (',' SymbolDef)* .
''
function hVarDecl _
	( _
		byval attrib as integer, _
		byval dopreserve as integer, _
        byval token as integer, _
        byval isForDecl as integer = FALSE, _
        byref forVar as FBSYMBOL ptr = 0 _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id, idalias
    static as ASTNODE ptr exprTB(0 to FB_MAXARRAYDIMS-1, 0 to 1)
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr sym, subtype
    dim as ASTNODE ptr initree
    dim as integer addsuffix, is_dynamic, is_multdecl, is_typeless, is_decl, check_exprtb
    dim as integer dtype, lgt, ofs, ptrcnt, dimensions, suffix
    dim as zstring ptr palias

    function = FALSE

	'' inside a namespace but outside a proc?
	if( symbIsGlobalNamespc( ) = FALSE ) then
		if( fbIsModLevel( ) ) then
			'' variables will be always shared..
			attrib or= FB_SYMBATTRIB_SHARED or FB_SYMBATTRIB_STATIC
		end if
	end if

    '' (AS SymbolType)?
    is_multdecl = FALSE
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

    	is_multdecl = TRUE
    end if

    dim as FB_IDOPT options
    options = FB_IDOPT_DEFAULT

    if( (token <> FB_TK_REDIM) or (options and FB_SYMBATTRIB_SHARED) ) then
    	options or= FB_IDOPT_ISDECL
    end if

    do
    	dim as FBSYMBOL ptr parent
		parent = cParentId( options )

		dim as FBSYMCHAIN ptr chain_
		chain_ = hGetId( parent, @id, suffix )

    	is_typeless = FALSE

    	if( is_multdecl = FALSE ) then
    		dtype = suffix
    		subtype	= NULL
    		ptrcnt = 0
    		lgt	= 0
    		addsuffix = TRUE
    	else
    		if( suffix <> INVALID ) then
    			if( errReportEx( FB_ERRMSG_SYNTAXERROR, @id ) = FALSE ) then
    				exit function
    			else
    				'' error recovery
    				suffix = INVALID
    			end if
    		end if
    	end if

    	'' ('(' ArrayDecl? ')')?
		dimensions = 0
		check_exprtb = FALSE
		if( lexGetToken( ) = CHAR_LPRNT ) then
			
			lexSkipToken( )

			is_dynamic = (attrib and FB_SYMBATTRIB_DYNAMIC) <> 0

			if( lexGetToken( ) = CHAR_RPRNT ) then
				dimensions = -1 				'' fake it
				is_dynamic = TRUE

    		else
    			'' only allow subscripts if not COMMON
    			if( (attrib and FB_SYMBATTRIB_COMMON) = 0 ) then
					'' static?
					if( token = FB_TK_STATIC ) then
    					if( cStaticArrayDecl( dimensions, dTB(), FALSE ) = FALSE ) then
	    					exit function
    					end if

    					is_dynamic = FALSE

					'' can be static or dynamic..
					else
    					if( cArrayDecl( dimensions, exprTB() ) = FALSE ) then
	    					exit function
    					end if

						check_exprtb = TRUE
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

    		is_dynamic = FALSE
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

    	if( is_multdecl = FALSE ) then
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
        		if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) = FALSE ) then
        			'' it's not an error if REDIM'g an already declared array
        			if( (chain_ = NULL) or (token <> FB_TK_REDIM) ) then
        				if( errReportNotAllowed( FB_LANG_OPT_DEFTYPE, _
        							 		 	 FB_ERRMSG_DEFTYPEONLYVALIDINLANG ) = FALSE ) then
							exit function
						else
							'' error recovery: fake a type
							dtype = FB_DATATYPE_INTEGER
						end if
					end if
    			end if

				if( dtype = INVALID ) then
					is_typeless = TRUE
					dtype = symbGetDefType( id )
				end if

    			lgt	= symbCalcLen( dtype, subtype )
    		end if
    	end if

		''
		sym = hLookupVar( parent, chain_, is_typeless, dtype, suffix, options )

    	if( sym = NULL ) then
    		'' no symbol was found, check if an explicit namespace was given
    		if( parent <> NULL ) then
    			if( parent <> symbGetCurrentNamespc( ) ) then
    				if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC, TRUE ) = FALSE ) then
    					exit function
    				end if
    			end if
    		end if
    	end if

		''
		if( dimensions > 0 ) then
			'' QB quirk: when the symbol was defined already by a preceeding COMMON
        	'' statement, then a DIM will work the same way as a REDIM
        	if( token = FB_TK_DIM ) then
				if( is_dynamic = FALSE ) then
            		if( sym <> NULL ) then
						if( symbIsCommon( sym ) ) then
                    		is_dynamic = (symbGetArrayDimensions( sym ) <> 0)
						end if
					end if
				end if
			end if

			if( check_exprtb ) then
				'' if subscripts are constants, convert exprTB to dimTB
				if( hIsConst( dimensions, exprTB() ) ) then
					'' only if not explicitly dynamic (ie: not REDIM, COMMON)
					if( is_dynamic = FALSE ) then
						hMakeArrayDimTB( dimensions, exprTB(), dTB() )
		    		end if
				else
					is_dynamic = TRUE
				end if
			end if
		end if

    	''
    	if( is_dynamic ) then
    		sym = hDeclDynArray( sym, id, palias, _
    							 dtype, subtype, ptrcnt, is_typeless, _
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

    		is_decl = FALSE

    	else
    		is_decl = symbGetIsDeclared( sym )
    	end if

   		''
   		dim as integer has_defctor, has_dtor
   		has_defctor = FALSE
   		has_dtor = FALSE
   		if( sym <> NULL ) then
   			select case symbGetType( sym )
   			case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
				'' has a default ctor?
				has_defctor = symbGetCompDefCtor( symbGetSubtype( sym ) ) <> NULL
				'' dtor?
				has_dtor = symbGetCompDtor( symbGetSubtype( sym ) ) <> NULL
			end select
		end if
        
        '' not "for i as integer..."?
        if isForDecl = FALSE then
			'' check for an initializer
			initree = hVarInit( sym, is_decl, has_defctor, has_dtor )
	
			if( initree = NULL ) then
	    		if( errGetLast( ) <> FB_ERRMSG_OK ) then
	    			exit function
	    		end if
	    	end if
	    end if

		'' add to AST
		if( sym <> NULL ) then

			dim as FBSYMBOL ptr desc
			desc = NULL

			'' not declared already?
    		if( is_decl = FALSE ) then
    			dim as ASTNODE ptr var
    			
    			'' don't init it if it's a temp FOR var, it
    			'' will have the start condition put into it...
    			'' set if not a struct
    			if isForDecl then 
    				if symbGetType( sym ) <> FB_DATATYPE_STRUCT then
    					symbSetDontInit( sym )
    				end if
    			end if
    			
				var = astNewDECL( FB_SYMBCLASS_VAR, sym, initree )

				'' respect scopes?
				if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
					astAdd( var )
				'' move to function scope..
				else
					astAddUnscoped( var )
				end if

				'' add the descriptor too, if any
				desc = symbGetArrayDescriptor( sym )
				if( desc <> NULL ) then
					var = astNewDECL( FB_SYMBCLASS_VAR, _
									  desc, _
									  symbGetTypeIniTree( desc ) )

					'' see above
					if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
						astAdd( var )
					else
						astAddUnscoped( var )
					end if
				end if

    		end if
            
            if isForDecl = TRUE then
            	forVar = sym
            	return TRUE
           	end if
			'' handle arrays (must be done after adding the decl node)

			'' do nothing if it's EXTERN
			if( token <> FB_TK_EXTERN ) then

				'' array?
				if( is_dynamic or (dimensions > 0) ) then
					'' not declared yet?
					if( is_decl = FALSE ) then
						'' local?
						if( (symbGetAttrib( sym ) and (FB_SYMBATTRIB_STATIC or _
												   	   FB_SYMBATTRIB_SHARED or _
												   	   FB_SYMBATTRIB_COMMON)) = 0 ) then

							'' bydesc array params have no descriptor
							if( desc <> NULL ) then
								astAdd( astTypeIniFlush( symbGetTypeIniTree( desc ), _
											 	 		 desc, _
											 	 		 FALSE, _
											  	 		 TRUE ) )

								symbSetTypeIniTree( desc, NULL )
							end if
						end if
					end if
				end if

				'' dynamic? if the dimensions are known, redim it
				if( is_dynamic ) then
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

				'' not declared already?
    			if( is_decl = FALSE ) then
            		'' flush the init tree (must be done after adding the decl node)
					hFlushInitializer( sym, initree, has_defctor, has_dtor )
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

    dim as integer i = any
    dim as ASTNODE ptr expr = any

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

    	if( dTB(i).upper < dTB(i).lower ) then
			if( errReport( FB_ERRMSG_INVALIDSUBSCRIPT ) = FALSE ) then
				exit function
			end if
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

    dim as integer i = any
    dim as ASTNODE ptr expr = any

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
    		select case as const astGetDataType( expr )
    		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    			if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: fake an expr
    				astDelTree( expr )
    				expr = astNewCONSTi( env.opt.base, FB_DATATYPE_INTEGER )
    			end if
    		end select
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
    			select case as const astGetDataType( expr )
    			case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    				if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
    					exit function
    				else
    					'' error recovery: fake an expr
    					expr = astCloneTree( exprTB(i,0) )
    				end if
    			end select
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

