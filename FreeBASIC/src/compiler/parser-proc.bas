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


'' proc (SUB, FUNCTION, OPERATOR, CTOR/DTOR) header and body parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\rtl.bi"
#include once "inc\ast.bi"

'':::::
private function hParamError _
	( _
		byval proc as FBSYMBOL ptr, _
		byval argnum as integer, _
		byval errnum as integer = FB_ERRMSG_PARAMTYPEMISMATCHAT _
	) as integer

	function = errReportParam( proc, argnum, NULL, errnum )

end function

'':::::
private function hCheckPrototype _
	( _
		byval proto as FBSYMBOL ptr, _
		byval proc as FBSYMBOL ptr, _
		byval proc_dtype as integer, _
		byval proc_subtype as FBSYMBOL ptr _
	) as integer static

    dim as FBSYMBOL ptr proc_param, proto_param
    dim as integer paramc, dtype

	function = FALSE

	'' check arg count
	paramc = symbGetProcParams( proc )
	if( symbGetProcParams( proto ) <> paramc ) then
		errReport( FB_ERRMSG_ARGCNTMISMATCH, TRUE )
		'' no error recovery: caller will take care
		exit function
	end if

	'' check return type
	if( symbGetType( proto ) <> proc_dtype ) then
		errReport( FB_ERRMSG_TYPEMISMATCH, TRUE )
		'' no error recovery: ditto
		exit function
	end if

	'' and sub type
	if( symbGetSubtype( proto ) <> proc_subtype ) then
       	errReport( FB_ERRMSG_TYPEMISMATCH, TRUE )
       	'' no error recovery: ditto
       	exit function
    end if

	'' check each arg
	proto_param = symbGetProcTailParam( proto )
	proc_param = symbGetProcTailParam( proc )
	do while( proc_param <> NULL )
        dtype = symbGetType( proto_param )

    	'' convert any AS ANY arg to the final one
    	if( dtype = FB_DATATYPE_VOID ) then
    		proto_param->typ = proc_param->typ
    		proto_param->subtype = proc_param->subtype

    	'' check if types don't conflit
    	else
    		if( proc_param->typ <> dtype ) then
                hParamError( proc, paramc )
                '' no error recovery: caller will take care
                exit function

            elseif( proc_param->subtype <> symbGetSubtype( proto_param ) ) then
                hParamError( proc, paramc )
                '' no error recovery: ditto
                exit function
    		end if
    	end if

    	'' and mode
    	if( proc_param->param.mode <> symbGetParamMode( proto_param ) ) then
			hParamError( proc, paramc )
			'' no error recovery: ditto
            exit function
    	end if

    	'' check names and change to the new one if needed
    	if( proc_param->param.mode <> FB_PARAMMODE_VARARG ) then
    		symbSetName( proto_param, symbGetName( proc_param ) )

    		'' as both have the same type, re-set the suffix, because for example
    		'' "a as integer" on the prototype and "a%" or just "a" on the proc
    		'' declaration when in a defint context is allowed in QB
    		proto_param->param.suffix = proc_param->param.suffix
    	end if

    	'' prev arg
    	proto_param = proto_param->prev
    	proc_param = proc_param->prev
    	paramc -= 1
    loop

    ''
    function = TRUE

end function

'':::::
private function hGetId _
	( _
		byval id as zstring ptr, _
		byval dtype as integer ptr, _
		byval is_sub as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMCHAIN ptr chain_
	dim as FBSYMBOL ptr sym

	function = NULL

	'' ID
	chain_ = cIdentifier( TRUE )

    '' symbol found?
    if( chain_ <> NULL ) then
    	'' proc?
    	sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
    	if( sym <> NULL ) then
    		'' from a different namespace?
    		if( symbGetNamespace( sym ) <> symbGetCurrentNamespc( ) ) then
    			'' allow dups if not the global ns
    			if( symbIsGlobalNamespc( ) = FALSE ) then
    				sym = NULL
    			end if
    		end if
    	end if

    else
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
    	sym = NULL
    end if

	select case lexGetClass( )
	case FB_TKCLASS_IDENTIFIER
		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
  				if( lexGetPeriodPos( ) > 0 ) then
  					if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
		  				exit function
					end if
				end if
			end if
		end if

	case FB_TKCLASS_QUIRKWD
		'' only if inside a ns and if not local
		if( (symbIsGlobalNamespc( )) or (env.scope > FB_MAINSCOPE) ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    			exit function
    		else
				'' error recovery: fake an id, skip until next '('
				*id = *hMakeTmpStr( )
				*dtype = INVALID
				hSkipUntil( CHAR_LPRNT )
				return NULL
			end if
		end if

	case else
		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
			exit function
		else
			'' error recovery: fake an id, skip until next '('
			*id = *hMakeTmpStr( )
			*dtype = INVALID
			hSkipUntil( CHAR_LPRNT )
			return NULL
		end if
	end select

	*id = *lexGetText( )
	*dtype = lexGetType( )

	if( is_sub ) then
		if( *dtype <> INVALID ) then
    		if( errReport( FB_ERRMSG_INVALIDCHARACTER ) = FALSE ) then
    			exit function
    		else
    			*dtype = INVALID
    		end if
    	end if
	end if

	lexSkipToken( )

	function = sym

end function

'':::::
private function hCheckRetType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref ptrcnt as integer _
	) as integer

   	function = FALSE

   	'' check for invalid types
   	select case as const dtype
   	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
   		if( errReport( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS ) = FALSE ) then
   			exit function
   		else
    		'' error recovery: fake a type
    		dtype = FB_DATATYPE_STRING
    		subtype = NULL
    		ptrcnt = 0
    	end if

    case FB_DATATYPE_VOID
    	if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: fake a type
    		dtype += FB_DATATYPE_POINTER
    		subtype = NULL
    		ptrcnt = 1
    	end if
    end select

	function = TRUE

end function

'':::::
private function hParseAttributes _
	( _
		byref attrib as integer _
	) as integer

	function = FALSE

    '' STATIC?
    if( lexGetToken( ) = FB_TK_STATIC ) then
    	lexSkipToken( )
    	attrib or= FB_SYMBATTRIB_STATIC
    end if

    '' EXPORT?
    if( lexGetToken( ) = FB_TK_EXPORT ) then
		'' ctor or dtor?
		if( (attrib and (FB_SYMBATTRIB_CONSTRUCTOR or FB_SYMBATTRIB_DESTRUCTOR)) <> 0 ) then
    		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: skip token
    			lexSkipToken( )
    			return TRUE
    		end if
    	end if

    	'' private?
    	if( (attrib and FB_SYMBATTRIB_PRIVATE) > 0 ) then
    		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: make it public
    			attrib and= not FB_SYMBATTRIB_PRIVATE
    		end if
    	end if

    	lexSkipToken( )

    	fbSetOption( FB_COMPOPT_EXPORT, TRUE )
    	'''''if( fbGetOption( FB_COMPOPT_EXPORT ) = FALSE ) then
    	'''''	errReportWarn( FB_WARNINGMSG_CANNOTEXPORT )
    	'''''end if
    	attrib or= FB_SYMBATTRIB_EXPORT or FB_SYMBATTRIB_PUBLIC
    end if

    function = TRUE

end function

'':::::
function cProcCallingConv as integer

	'' (CDECL|STDCALL|PASCAL)?
	select case as const lexGetToken( )
	case FB_TK_CDECL
		function = FB_FUNCMODE_CDECL
		lexSkipToken( )

	case FB_TK_STDCALL
		function = FB_FUNCMODE_STDCALL
		lexSkipToken( )

	case FB_TK_PASCAL
		function = FB_FUNCMODE_PASCAL
		lexSkipToken( )

	case else
		select case as const env.mangling
		case FB_MANGLING_BASIC
			function = FB_DEFAULT_FUNCMODE

		case FB_MANGLING_CDECL, FB_MANGLING_CPP
			function = FB_FUNCMODE_CDECL

		case FB_MANGLING_STDCALL
			function = FB_FUNCMODE_STDCALL
		end select
	end select

end function

#define CREATEFAKEID( proc ) _
	symbAddProc( proc, hMakeTmpStr( ), NULL, NULL, dtype, subtype, ptrcnt, attrib, mode )

'':::::
''ProcHeader   		=  ID CallConvention? OVERLOAD? (ALIAS LIT_STRING)?
''                     ('(' Parameters? ')')? ((AS SymbolType)? | CONSTRUCTOR|DESTRUCTOR)?
''					   STATIC? EXPORT?
''
function cProcHeader _
	( _
		byval is_sub as integer, _
		byval is_prototype as integer, _
		byval attrib as integer _
	) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 id, aliasid, libname
    dim as integer dtype, mode, lgt, ptrcnt
    dim as FBSYMBOL ptr sym, proc, subtype
    dim as zstring ptr palias, plib

	function = NULL

	'' ID
	sym = hGetId( @id, @dtype, is_sub )
	if( sym = NULL ) then
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
    end if

	subtype = NULL
	ptrcnt = 0

	'' CallConvention?
	mode = cProcCallingConv( )

	'' OVERLOAD?
	if( lexGetToken( ) = FB_TK_OVERLOAD ) then
        if( fbLangOptIsSet( FB_LANG_OPT_FUNCOVL ) = FALSE ) then
        	if( errReportNotAllowed( FB_LANG_OPT_FUNCOVL ) = FALSE ) then
        		exit function
        	end if
        else
        	attrib or= FB_SYMBATTRIB_OVERLOADED
        end if

		lexSkipToken( )
	end if

	plib = NULL
	if( is_prototype ) then
		'' (LIB STR_LIT)?
		if( lexGetToken( ) = FB_TK_LIB ) then
			lexSkipToken( )
			if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				end if

			else
				lexEatToken( libname )
				plib = @libname
			end if
		end if
	end if

	'' (ALIAS LIT_STRING)?
	palias = NULL
	if( lexGetToken( ) = FB_TK_ALIAS ) then
		lexSkipToken( )

		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if

		else
			lexEatToken( aliasid )
			palias = @aliasid
		end if
	end if

	proc = symbPreAddProc( @id )

	'' ('(' Parameters? ')')?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )

		cParameters( proc, mode, is_prototype )

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
	end if

    select case as const lexGetToken( )
    '' (CONSTRUCTOR | DESTRUCTOR)?
    case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR

        '' not a sub?
        if( is_sub = FALSE ) then
        	if( errReport( FB_ERRMSG_SYNTAXERROR, TRUE ) = FALSE ) then
        		exit function
        	end if
        end if

        '' not argless?
        if( symbGetProcParams( proc ) <> 0 ) then
        	if( errReport( FB_ERRMSG_ARGCNTMISMATCH, TRUE ) = FALSE ) then
        		exit function
        	end if
        end if

		if( lexGetToken( ) = FB_TK_CONSTRUCTOR ) then
			attrib or= FB_SYMBATTRIB_CONSTRUCTOR
		else
			attrib or= FB_SYMBATTRIB_DESTRUCTOR
		end if

		lexSkipToken( )

    '' (AS SymbolType)?
    case FB_TK_AS
    	if( (dtype <> INVALID) or (is_sub) ) then
    		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    			exit function
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
    			ptrcnt = 0
    		end if

    	else
    		if( hCheckRetType( dtype, subtype, ptrcnt ) = FALSE ) then
    			exit function
    		end if
    	end if

	case else
        if( is_sub = FALSE ) then
        	if( fbLangOptIsSet( FB_LANG_OPT_DEFTYPE ) = FALSE ) then
        		if( errReportNotAllowed( FB_LANG_OPT_DEFTYPE, _
         		 					 	 FB_ERRMSG_DEFTYPEONLYVALIDINLANG ) = FALSE ) then
					exit function
				else
					'' error recovery: fake a type
					dtype = FB_DATATYPE_INTEGER
				end if
			end if
		end if
    end select

    if( is_sub ) then
    	dtype = FB_DATATYPE_VOID
    	subtype = NULL
    end if

	''
	if( dtype = INVALID ) then
		dtype = symbGetDefType( id )
	end if

	'' prototype?
	if( is_prototype ) then
    	sym = symbAddPrototype( proc, @id, palias, plib, _
    						 	dtype, subtype, ptrcnt, _
    					     	attrib, mode )
    	if( sym = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    			exit function
    		end if
    	end if

    	return sym
    end if

	'' function body..

	if( hParseAttributes( attrib ) = FALSE ) then
		exit function
	end if

    '' no preview proc or proto with the same name?
    if( sym = NULL ) then
    	sym = symbAddProc( proc, @id, palias, NULL, _
    					   dtype, subtype, ptrcnt, _
    					   attrib, mode )

    	if( sym = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			proc = CREATEFAKEID( proc )
    		end if

    	else
    		proc = sym
    	end if

    '' another proc or proto defined already..
    else
    	'' overloaded?
    	if( symbGetProcIsOverloaded( sym ) ) then

            '' try to find a prototype with the same signature
    		sym = symbFindOverloadProc( sym, proc )

    		'' none found? then try to overload..
    		if( sym = NULL ) then
    			sym = symbAddProc( proc, @id, palias, NULL, _
    							   dtype, subtype, ptrcnt, _
    							   attrib, mode )
    			'' dup def?
    			if( sym = NULL ) then
    				if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    					exit function
    				else
    					'' error recovery: create a fake symbol
    					return CREATEFAKEID( proc )
    				end if
    			else
    				return sym
    			end if
    		end if

    		attrib or= FB_SYMBATTRIB_OVERLOADED
    	end if

    	'' already parsed?
    	if( symbGetIsDeclared( sym ) ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' there's already a prototype for this proc, check for
    	'' declaration conflits and fix up the arguments
    	if( hCheckPrototype( sym, proc, dtype, subtype ) = FALSE ) then
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' check calling convention
    	if( symbGetProcMode( sym ) <> mode ) then
    		if( errReport( FB_ERRMSG_ILLEGALPARAMSPEC, TRUE ) = FALSE ) then
    			exit function
    		end if
    	end if

    	''
    	symbSetIsDeclared( sym )

    	symbSetAttrib( sym, attrib )

    	'' return the prototype
    	proc = sym
    end if

	'' ctor or dtor? even if private it should be always emitted
	if( (attrib and (FB_SYMBATTRIB_CONSTRUCTOR or FB_SYMBATTRIB_DESTRUCTOR)) <> 0 ) then
    	symbSetIsCalled( proc )
    end if

    ''
    symbSetProcIncFile( proc, env.inf.incfile )

    function = proc

end function

'':::::
private function hCheckOpOvlParams _
	( _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval proc_dtype as integer, _
		byval proc_subtype as FBSYMBOL ptr _
	) as integer

	function = FALSE

	'' 1st) check the number of params
    dim as integer params = iif( astGetOpClass( op ) = AST_NODECLASS_UOP, 1, 2 )
    if( symbGetProcParams( proc ) <> params ) then
    	errReport( FB_ERRMSG_ARGCNTMISMATCH, TRUE )
    	exit function
    end if

    '' 2nd) check the params, at least one param must be an
    ''      user-defined type (struct, enum or class)
    dim as FBSYMBOL ptr param = symbGetProcHeadParam( proc )

    '' unary?
    if( astGetOpClass( op ) = AST_NODECLASS_UOP ) then

    	'' vararg?
    	if( symbGetParamMode( param ) = FB_PARAMMODE_VARARG ) then
    		hParamError( proc, 1, FB_ERRMSG_VARARGPARAMNOTALLOWED )
    		exit function
    	end if

    	'' optional?
    	if( symbGetIsOptional( param ) ) then
    		hParamError( proc, 1, FB_ERRMSG_PARAMCANTBEOPTIONAL )
    		exit function
    	end if

    	'' is the param an UDT?
    	select case symbGetType( param )
    	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

    	case else
    		errReport( FB_ERRMSG_ATLEASTONEPARAMMUSTBEANUDT, TRUE )
    		exit function
    	end select

    '' binary or assignment..
    else
    	dim as FBSYMBOL ptr nxtparam = param->next

    	'' vararg?
    	if( (symbGetParamMode( param ) = FB_PARAMMODE_VARARG) or _
    		(symbGetParamMode( nxtparam ) = FB_PARAMMODE_VARARG) ) then
    		errReport( FB_ERRMSG_VARARGPARAMNOTALLOWED, TRUE )
    		exit function
    	end if

    	'' optional?
    	if( (symbGetIsOptional( param ) = FB_PARAMMODE_VARARG) or _
    		(symbGetIsOptional( nxtparam ) = FB_PARAMMODE_VARARG) ) then
    		errReport( FB_ERRMSG_PARAMCANTBEOPTIONAL, TRUE )
    		exit function
    	end if

    	'' is the 1st param an UDT?
    	select case symbGetType( param )
    	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

    	case else
    		'' self? the 1st param must be an UDT
    		if( astGetOpIsSelf( op ) ) then
    			hParamError( proc, 1, FB_ERRMSG_INVALIDDATATYPES )
    			exit function

    		else
    			'' try the 2nd one..
    			select case symbGetType( nxtparam )
    			case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM

    			case else
    				errReport( FB_ERRMSG_ATLEASTONEPARAMMUSTBEANUDT, TRUE )
    				exit function
    			end select
    		end if
    	end select

    end if

    '' 3rd) check the result

    select case astGetOpClass( op )
    '' unary?
    case AST_NODECLASS_UOP
    	'' casting? special case..
    	if( op = AST_OP_CAST ) then

    		'' return and param types can't be the same
    		if( proc_dtype = symbGetType( param ) ) then
    			if( proc_subtype = symbGetSubType( param ) ) then
    				errReport( FB_ERRMSG_SAMEPARAMANDRESULTTYPES, TRUE )
    				exit function
    			end if
    		end if
    	end if

    	'' return type can't be a void
    	if( proc_dtype = FB_DATATYPE_VOID ) then
    		errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
    		exit function
    	end if

    '' assignment?
    case AST_NODECLASS_ASSIGN

    	'' it must be a SUB
    	if( proc_dtype <> FB_DATATYPE_VOID ) then
    		errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
    		exit function
    	end if

    '' binary..
    case else

   		select case as const op
   		'' relational? it must return an integer
   		case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
   			if( proc_dtype <> FB_DATATYPE_INTEGER ) then
   				errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
   				exit function
   			end if

   		'' self? must be a SUB
   		case else
   			if( astGetOpIsSelf( op ) ) then
    			if( proc_dtype <> FB_DATATYPE_VOID ) then
    				errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
    				exit function
    			end if

   			'' anything else, it can't be a void
   			else
    			if( proc_dtype = FB_DATATYPE_VOID ) then
    				errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
    				exit function
    			end if

   			end if
   		end select

    end select

	function = TRUE

end function

'':::::
''OperatorHeader   	=  Operator CallConvention? (ALIAS LIT_STRING)?
''                     '(' Parameters ')' (AS SymbolType)? STATIC? EXPORT?
''
''
function cOperatorHeader _
	( _
		byval is_prototype as integer, _
		byval attrib as integer _
	) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 aliasid, libname
    dim as integer op, dtype, mode, lgt, ptrcnt
    dim as FBSYMBOL ptr proc, subtype, sym
    dim as zstring ptr palias, plib

	function = NULL

	attrib or= FB_SYMBATTRIB_OPERATOR or FB_SYMBATTRIB_OVERLOADED

	'' Operator
	op = cOperator( )
	if( op = INVALID ) then
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			exit function
		else
			'' error recovery: fake an op
			op = AST_OP_ADD
		end if
    end if

	subtype = NULL
	ptrcnt = 0

	'' CallConvention?
	mode = cProcCallingConv( )

	plib = NULL
	if( is_prototype ) then
		'' (LIB STR_LIT)?
		if( lexGetToken( ) = FB_TK_LIB ) then
			lexSkipToken( )
			if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				end if

			else
				lexEatToken( libname )
				plib = @libname
			end if
		end if
	end if

	'' (ALIAS LIT_STRING)?
	palias = NULL
	if( lexGetToken( ) = FB_TK_ALIAS ) then
		lexSkipToken( )

		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if

		else
			lexEatToken( aliasid )
			palias = @aliasid
		end if
	end if

	proc = symbPreAddProc( NULL )

	'' '(' Parameters ')'
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )

		if( cParameters( proc, mode, is_prototype ) = NULL ) then
			if( errReport( FB_ERRMSG_ARGCNTMISMATCH ) = FALSE ) then
				exit function
			end if
		end if

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

	else
		if( errReport( FB_ERRMSG_ARGCNTMISMATCH ) = FALSE ) then
			exit function
		end if
	end if

    '' LET or self?
    if( (op = AST_OP_ASSIGN) or (astGetOpIsSelf( op )) ) then
    	dtype = FB_DATATYPE_VOID
    	subtype = NULL

    else
    	'' AS SymbolType
    	if( lexGetToken( ) <> FB_TK_AS ) then
			if( errReport( FB_ERRMSG_EXPECTEDRESTYPE ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a type
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL
				ptrcnt = 0
			end if

		else
			lexSkipToken( )

    		if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
    			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: fake a type
    				dtype = FB_DATATYPE_INTEGER
    				subtype = NULL
    				ptrcnt = 0
    			end if

    		else
    			if( hCheckRetType( dtype, subtype, ptrcnt ) = FALSE ) then
    				exit function
    			end if
    		end if
    	end if
    end if

    '' special cases, '-' or '+' with just one param are actually unary ops
    select case op
    case AST_OP_SUB
    	if( symbGetProcParams( proc ) = 1 ) then
    		op = AST_OP_NEG
    	end if

    case AST_OP_ADD
    	if( symbGetProcParams( proc ) = 1 ) then
    		op = AST_OP_PLUS
    	end if
    end select

	''
	if( hCheckOpOvlParams( op, proc, dtype, subtype ) = FALSE ) then
		exit function
	end if

	if( is_prototype ) then
    	sym = symbAddOpOvlPrototype( proc, op, palias, plib, _
    						 		 dtype, subtype, ptrcnt, _
    					     		 attrib, mode )
    	if( sym = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    			exit function
    		end if
    	end if

    	return sym
	end if

	''
	if( hParseAttributes( attrib ) = FALSE ) then
		exit function
	end if

    '' no preview proc or proto for this operator?
    sym = symbGetGlobOpOvlParent( op, symbGetProcHeadParam( proc ) )
    if( sym = NULL ) then
    	sym = symbAddOpOvlProc( proc, op, palias, NULL, _
    					   		dtype, subtype, ptrcnt, _
    					   		attrib, mode )

    	if( sym = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			proc = CREATEFAKEID( proc )
    		end if

    	else
    		proc = sym
    	end if

    '' another proc or proto defined already..
    else
		'' try to find a prototype with the same signature
    	sym = symbFindOpOvlProc( op, sym, proc )

		'' none found? then try to overload..
    	if( sym = NULL ) then
    		sym = symbAddOpOvlProc( proc, op, palias, NULL, _
    						   		dtype, subtype, ptrcnt, _
    						   		attrib, mode )

    		'' dup def?
    		if( sym = NULL ) then
    			if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: create a fake symbol
    				return CREATEFAKEID( proc )
    			end if
    		else
    			return sym
    		end if
    	end if

    	'' already parsed?
    	if( symbGetIsDeclared( sym ) ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' there's already a prototype for this operator, check for
    	'' declaration conflits and fix up the arguments
    	if( hCheckPrototype( sym, proc, dtype, subtype ) = FALSE ) then
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' check calling convention
    	if( symbGetProcMode( sym ) <> mode ) then
    		if( errReport( FB_ERRMSG_ILLEGALPARAMSPEC, TRUE ) = FALSE ) then
    			exit function
    		end if
    	end if

    	''
    	symbSetIsDeclared( sym )

    	symbSetAttrib( sym, attrib )

    	'' return the prototype
    	proc = sym
	end if

    ''
    symbSetProcIncFile( proc, env.inf.incfile )

    function = proc

end function

'':::::
''ProcStmtBegin	  =	  (PRIVATE|PUBLIC)?
''						(SUB|FUNCTION|CONSTRUCTOR|DESTRUCTOR|OPERATOR) ProcHeader .
''
function cProcStmtBegin _
	( _
		_
	) as integer static

	dim as integer tkn, attrib
    dim as FBSYMBOL ptr proc
    dim as ASTNODE ptr expr, procnode
    dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	'' (PRIVATE|PUBLIC)?
	select case lexGetToken( )
	case FB_TK_PRIVATE
		lexSkipToken( )
		attrib = FB_SYMBATTRIB_PRIVATE

	case FB_TK_PUBLIC
		lexSkipToken( )
		attrib = FB_SYMBATTRIB_PUBLIC

	case else
		if( env.opt.procpublic ) then
			attrib = FB_SYMBATTRIB_PUBLIC
		else
			attrib = FB_SYMBATTRIB_PRIVATE
		end if
	end select

	'' SUB | FUNCTION
	tkn = lexGetToken( )
	select case as const tkn
	case FB_TK_SUB, FB_TK_FUNCTION

/'
	case FB_TK_CONSTRUCTOR
	     attrib or= FB_SYMBATTRIB_CONSTRUCTOR

	case FB_TK_DESTRUCTOR
		attrib or= FB_SYMBATTRIB_DESTRUCTOR
'/

	case FB_TK_OPERATOR
        if( fbLangOptIsSet( FB_LANG_OPT_OPEROVL ) = FALSE ) then
        	if( errReportNotAllowed( FB_LANG_OPT_OPEROVL ) = FALSE ) then
        		exit function
        	end if
        else
			attrib or= FB_SYMBATTRIB_OPERATOR or FB_SYMBATTRIB_OVERLOADED
		end if

	case else
		exit function
	end select

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_PROC ) = FALSE ) then
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( tkn )
		exit function
	end if

	lexSkipToken( )

	'' ProcHeader
	select case as const tkn
	case FB_TK_SUB, FB_TK_FUNCTION
		proc = cProcHeader( tkn = FB_TK_SUB, FALSE, attrib )

/'
	case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
		proc = cCtorHeader( attrib )
'/

	case FB_TK_OPERATOR
        proc = cOperatorHeader( FALSE, attrib )

	end select

	if( proc = NULL ) then
		exit function
	end if

	'' emit proc setup
	procnode = astProcBegin( proc, FALSE )
	if( procnode = NULL ) then
		exit function
	end if

	'' push to stmt stack
	stk = cCompStmtPush( FB_TK_FUNCTION, _
						 FB_CMPSTMT_MASK_DEFAULT or FB_CMPSTMT_MASK_DATA )

	stk->proc.tkn = tkn
	stk->proc.node = procnode

	env.stmt.proc.cmplabel = NULL
	env.stmt.proc.endlabel = astGetProcExitlabel( procnode )

	'' init
	astAdd( astNewLABEL( astGetProcInitlabel( procnode ) ) )

	function = TRUE

end function

'':::::
''ProcStmtEnd	  =	  END (SUB | FUNCTION) .
''
function cProcStmtEnd _
	( _
		_
	) as integer static

	dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_FUNCTION )
	if( stk = NULL ) then
		exit function
	end if

	'' END
	lexSkipToken( )

	dim as integer res

	res = hMatch( stk->proc.tkn )
	if( res = FALSE ) then
		select case stk->proc.tkn
		case FB_TK_SUB
			errReport( FB_ERRMSG_EXPECTEDENDSUB )
		case FB_TK_FUNCTION
			errReport( FB_ERRMSG_EXPECTEDENDFUNCTION )
		case FB_TK_CONSTRUCTOR
			errReport( FB_ERRMSG_EXPECTEDENDCTOR )
		case FB_TK_DESTRUCTOR
			errReport( FB_ERRMSG_EXPECTEDENDDTOR )
		case FB_TK_OPERATOR
			errReport( FB_ERRMSG_EXPECTEDENDOPERATOR )
		end select
	end if

	'' function and the result wasn't set?
	dim as FBSYMBOL ptr proc_res

	proc_res = symbGetProcResult( env.currproc )
	if( proc_res <> NULL ) then
		if( symbGetIsAccessed( proc_res ) = FALSE ) then
			errReportWarn( FB_WARNINGMSG_NOFUNCTIONRESULT )
		end if
	end if

    '' always finish
	function = astProcEnd( stk->proc.node, FALSE )

	'' pop from stmt stack
	cCompStmtPop( stk )

	if( res = FALSE ) then
		function = FALSE
	end if

end function


