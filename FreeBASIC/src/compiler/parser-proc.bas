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
private function hIsClass _
	( _
		byval parent as FBSYMBOL ptr _
	) as integer

    select case symbGetClass( parent )
    case FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_CLASS
    	return TRUE
    case else
    	return FALSE
    end select

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
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dtype as integer ptr, _
		byval is_sub as integer _
	) as FBSYMBOL ptr static

	dim as FBSYMCHAIN ptr chain_
	dim as FBSYMBOL ptr sym

	function = NULL

	'' no parent? read as-is
	if( parent = NULL ) then
		chain_ = lexGetSymChain( )
    else
		chain_ = symbLookupAt( parent, lexGetText( ), FALSE )
	end if

    '' any symbol found?
    if( chain_ <> NULL ) then
    	'' same class?
    	sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
    else
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
		if( (parent = NULL) or (parser.scope > FB_MAINSCOPE) ) then
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
		byref attrib as FB_SYMBATTRIB, _
		byval stats as FB_SYMBSTATS, _
		byref priority as integer _
	) as integer

	function = FALSE

	priority = 0

	'' Priority?
	if( lexGetClass( ) = FB_TKCLASS_NUMLITERAL ) then

		'' not ctor or dtor?
		if( (stats and (FB_SYMBSTATS_GLOBALCTOR or FB_SYMBSTATS_GLOBALDTOR)) = 0 ) then

    		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: skip token
    			lexSkipToken( )
    		end if

		'' not an integer
		elseif( lexGetType( ) <> FB_DATATYPE_INTEGER ) then

    		if( errReport( FB_ERRMSG_INVALIDPRIORITY ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: skip token
    			lexSkipToken( )
    		end if

		else

			priority = valint( *lexGetText() )

			if priority < 101 or priority > 65535 then
    			if( errReport( FB_ERRMSG_INVALIDPRIORITY ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: skip token
    				lexSkipToken( )
    			end if
			else
				priority and= &hffff
   				lexSkipToken( )
			end if

		end if

	end if

    '' STATIC?
    if( lexGetToken( ) = FB_TK_STATIC ) then
    	lexSkipToken( )
    	attrib or= FB_SYMBATTRIB_STATIC
    end if

    '' EXPORT?
    if( lexGetToken( ) = FB_TK_EXPORT ) then
		'' ctor or dtor?
		if( (stats and (FB_SYMBSTATS_GLOBALCTOR or FB_SYMBSTATS_GLOBALCTOR)) <> 0 ) then
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
function cProcCallingConv _
	( _
		byval default as FB_FUNCMODE _
	) as FB_FUNCMODE

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
		select case as const parser.mangling
		case FB_MANGLING_BASIC
			function = default

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
private function hDoNesting _
	( _
		byval ns as FBSYMBOL ptr _
	) as integer static

	'' proc body can be declared outside the original namespace
	'' if the prototype was declared inside one (as in C++), so
	'' change the hashtb too

	if( ns = symbGetCurrentNamespc( ) ) then
		return FALSE
	end if

	symbNestBegin( ns, TRUE )

	function = TRUE

end function

'':::::
''ProcHeader   		=  ID CallConvention? OVERLOAD? (ALIAS LIT_STRING)?
''                     Parameters? ((AS SymbolType)? | CONSTRUCTOR|DESTRUCTOR)?
''					   Priority? STATIC? EXPORT?
''
function cProcHeader _
	( _
		byval is_sub as integer, _
		byval is_prototype as integer, _
		byval attrib as integer, _
		byref is_nested as integer _
	) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 id, aliasid, libname
    dim as integer dtype, mode, lgt, ptrcnt, is_extern, priority
    dim as FBSYMBOL ptr head_proc, proc, subtype, parent
    dim as zstring ptr palias, plib
    dim as FB_SYMBSTATS stats

	function = NULL

	is_nested = FALSE
	is_extern = FALSE

	'' ID
	if( (attrib and FB_SYMBATTRIB_METHOD) <> 0 ) then
		parent = symbGetCurrentNamespc( )

		attrib or= FB_SYMBATTRIB_OVERLOADED

	else
		parent = cParentId( FB_IDOPT_ISDECL or _
							FB_IDOPT_SHOWERROR or _
							FB_IDOPT_ALLOWSTRUCT )
		if( parent = NULL ) then
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

			if( symbGetCurrentNamespc( ) <> @symbGetGlobalNamespc( ) ) then
				parent = symbGetCurrentNamespc( )
			end if

		else
			'' ns used in a prototype?
			if( is_prototype ) then
				if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
					exit function
				end if
        	end if

        	if( hIsClass( parent ) ) then
        		attrib or= FB_SYMBATTRIB_METHOD or FB_SYMBATTRIB_OVERLOADED
        	end if

			is_extern = TRUE
		end if
	end if

	head_proc = hGetId( parent, @id, @dtype, is_sub )
	if( head_proc = NULL ) then
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
    end if

	hCheckSuffix( dtype )

	subtype = NULL
	ptrcnt = 0
	stats = 0

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

	'' extern implementation?
	if( is_prototype = FALSE ) then
		'' must be done before parsing the params
		if( parent <> NULL ) then
			is_nested = hDoNesting( parent )
		end if
	end if

	'' Parameters?
	if( cParameters( parent, proc, mode, is_prototype ) = NULL ) then
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

    select case as const lexGetToken( )
    '' (CONSTRUCTOR | DESTRUCTOR)?
    case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR

        '' method?
        if( (attrib and FB_SYMBATTRIB_METHOD) <> 0) then
        	if( errReport( FB_ERRMSG_SYNTAXERROR, TRUE ) = FALSE ) then
        		exit function
        	end if

        else
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
				stats or= FB_SYMBSTATS_GLOBALCTOR
			else
				stats or= FB_SYMBSTATS_GLOBALDTOR
			end if

			lexSkipToken( )

			''
		end if

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
    	proc = symbAddPrototype( proc, @id, palias, plib, _
    						 	 dtype, subtype, ptrcnt, _
    					     	 attrib, mode )
    	if( proc = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    			exit function
    		end if
    	end if

    	return proc
    end if

	'' function body..

	if( hParseAttributes( attrib, stats, priority ) = FALSE ) then
		exit function
	end if

    '' no preview proc or proto with the same name?
    if( head_proc = NULL ) then
    	'' extern decl but no prototype?
    	if( is_extern ) then
			if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
				exit function
			end if
    	end if

    	head_proc = symbAddProc( proc, @id, palias, NULL, _
    					   		 dtype, subtype, ptrcnt, _
    					   		 attrib, mode )

    	if( head_proc = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			proc = CREATEFAKEID( proc )
    		end if

    	else
    		proc = head_proc
    	end if

    '' another proc or proto defined already..
    else
		'' property?
		if( symbIsProperty( head_proc ) ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
		end if

    	'' overloaded?
    	if( symbGetProcIsOverloaded( head_proc ) ) then

            '' try to find a prototype with the same signature
    		head_proc = symbFindOverloadProc( head_proc, proc )

    		'' none found? then try to overload..
    		if( head_proc = NULL ) then
    			head_proc = symbAddProc( proc, @id, palias, NULL, _
    							   		 dtype, subtype, ptrcnt, _
    							   		 attrib, mode )
    			'' dup def?
    			if( head_proc = NULL ) then
    				if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    					exit function
    				else
    					'' error recovery: create a fake symbol
    					return CREATEFAKEID( proc )
    				end if
    			else
    				return head_proc
    			end if

    		end if

    		attrib or= FB_SYMBATTRIB_OVERLOADED
    	end if

    	'' already parsed?
    	if( symbGetIsDeclared( head_proc ) ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' there's already a prototype for this proc, check for
    	'' declaration conflits and fix up the arguments
    	if( hCheckPrototype( head_proc, proc, dtype, subtype ) = FALSE ) then
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' check calling convention
    	if( symbGetProcMode( head_proc ) <> mode ) then
    		if( errReport( FB_ERRMSG_ILLEGALPARAMSPEC, TRUE ) = FALSE ) then
    			exit function
    		end if
    	end if

    	'' use the prototype
    	proc = head_proc

    	''
    	symbSetIsDeclared( proc )

    	symbSetAttrib( proc, attrib )
    end if

	'' ctor or dtor?
	if( (stats and FB_SYMBSTATS_GLOBALCTOR) <> 0 ) then
    	symbAddGlobalCtor( proc )
		if( proc->proc.ext = NULL ) then
			proc->proc.ext = callocate( len( FB_PROCEXT ) )
		end if
		symbSetProcPriority( proc, priority )

    elseif( (stats and FB_SYMBSTATS_GLOBALDTOR) <> 0 ) then
    	symbAddGlobalDtor( proc )
		if( proc->proc.ext = NULL ) then
			proc->proc.ext = callocate( len( FB_PROCEXT ) )
		end if
		symbSetProcPriority( proc, priority )

    end if

    ''
    symbSetProcIncFile( proc, env.inf.incfile )

    function = proc

end function

'':::::
private function hCheckOpOvlParams _
	( _
		byval parent as FBSYMBOL ptr, _
		byval op as integer, _
		byval proc as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB _
	) as integer

    dim as integer is_method = (attrib and FB_SYMBATTRIB_METHOD) <> 0

	function = FALSE

	'' 1st) check the number of params
    dim as integer params = any
    select case astGetOpClass( op )
    case AST_NODECLASS_UOP, AST_NODECLASS_CONV
    	params = 1

    '' bop or assign..
    case else
    	params = 2
    end select

    if( symbGetProcParams( proc ) <> params ) then
    	errReport( FB_ERRMSG_ARGCNTMISMATCH, TRUE )
    	exit function
    end if

    '' 2nd) check method-only ops
    select case astGetOpClass( op )
    case AST_NODECLASS_CONV, AST_NODECLASS_ASSIGN
    	if( is_method = FALSE ) then
    		errReport( FB_ERRMSG_OPMUSTBEAMETHOD, TRUE )
    	end if

    case AST_NODECLASS_BOP
    	if( is_method or astGetOpIsSelf( op ) ) then
    		if( parent = NULL ) then
    			errReport( FB_ERRMSG_OPMUSTBEAMETHOD, TRUE )
    		end if
    	else
    		if( parent <> NULL ) then
    			errReport( FB_ERRMSG_OPCANNOTBEAMETHOD, TRUE )
    		end if
    	end if

    case else
    	if( is_method ) then
    		errReport( FB_ERRMSG_OPCANNOTBEAMETHOD, TRUE )
    	end if
    end select

    '' 3rd) check the params, at least one param must be an
    ''      user-defined type (struct, enum or class)
    dim as FBSYMBOL ptr param = symbGetProcHeadParam( proc )

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

    select case astGetOpClass( op )
    '' unary?
    case AST_NODECLASS_UOP, AST_NODECLASS_CONV
    	'' is the param an UDT?
    	select case symbGetType( param )
    	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS

    	case else
    		errReport( FB_ERRMSG_ATLEASTONEPARAMMUSTBEANUDT, TRUE )
    		exit function
    	end select

    '' binary?
    case AST_NODECLASS_BOP, AST_NODECLASS_ASSIGN

    	dim as FBSYMBOL ptr nxtparam = param->next

    	'' vararg?
    	if( symbGetParamMode( nxtparam ) = FB_PARAMMODE_VARARG ) then
    		hParamError( proc, 2, FB_ERRMSG_VARARGPARAMNOTALLOWED )
    		exit function
    	end if

    	'' optional?
    	if( symbGetIsOptional( nxtparam ) ) then
    		hParamError( proc, 2, FB_ERRMSG_PARAMCANTBEOPTIONAL )
    		exit function
    	end if

    	'' is the 1st param an UDT?
    	select case symbGetType( param )
    	case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS

    	case else
    		'' try the 2nd one..
    		select case symbGetType( nxtparam )
    		case FB_DATATYPE_STRUCT, FB_DATATYPE_ENUM ', FB_DATATYPE_CLASS

    		case else
    			errReport( FB_ERRMSG_ATLEASTONEPARAMMUSTBEANUDT, TRUE )
    			exit function
    		end select
    	end select

    end select

    '' 4th) check the result

    select case astGetOpClass( op )
    case AST_NODECLASS_CONV
    	'' return and param types can't be the same
    	if( symbGetSubtype( proc ) = parent ) then
    		errReport( FB_ERRMSG_SAMEPARAMANDRESULTTYPES, TRUE )
    		exit function
    	end if

    	'' return type can't be a void
    	if( symbGetType( proc ) = FB_DATATYPE_VOID ) then
    		errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
    		exit function
    	end if

    '' unary?
    case AST_NODECLASS_UOP
    	'' return type can't be a void
    	if( symbGetType( proc ) = FB_DATATYPE_VOID ) then
    		errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
    		exit function
    	end if

    '' assignment?
    case AST_NODECLASS_ASSIGN
    	'' it must be a SUB
    	if( symbGetType( proc ) <> FB_DATATYPE_VOID ) then
    		errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
    		exit function
    	end if

    '' binary..
    case else

   		select case as const op
   		'' relational? it must return an integer
   		case AST_OP_EQ, AST_OP_NE, AST_OP_GT, AST_OP_LT, AST_OP_GE, AST_OP_LE
   			if( symbGetType( proc ) <> FB_DATATYPE_INTEGER ) then
   				errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
   				exit function
   			end if

   		'' self? must be a SUB
   		case else
   			if( astGetOpIsSelf( op ) ) then
    			if( symbGetType( proc ) <> FB_DATATYPE_VOID ) then
    				errReport( FB_ERRMSG_INVALIDRESULTTYPEFORTHISOP, TRUE )
    				exit function
    			end if

   			'' anything else, it can't be a void
   			else
    			if( symbGetType( proc ) = FB_DATATYPE_VOID ) then
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
''                     Parameters? (AS SymbolType)? STATIC? EXPORT?
''
function cOperatorHeader _
	( _
		byval is_prototype as integer, _
		byval attrib as integer, _
		byref is_nested as integer _
	) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 aliasid, libname
    dim as integer op, dtype, mode, lgt, ptrcnt, is_extern
    dim as FBSYMBOL ptr proc, subtype, parent
    dim as zstring ptr palias, plib

	function = NULL

	is_nested = FALSE
	is_extern = FALSE

	attrib or= FB_SYMBATTRIB_OPERATOR or FB_SYMBATTRIB_OVERLOADED

	if( (attrib and FB_SYMBATTRIB_METHOD) <> 0 ) then
		parent = symbGetCurrentNamespc( )

	else
		parent = cParentId( FB_IDOPT_ISOPERATOR or _
							FB_IDOPT_ISDECL or _
							FB_IDOPT_SHOWERROR or _
							FB_IDOPT_ALLOWSTRUCT )
		if( parent = NULL ) then
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

		else
			'' ns used in a prototype?
			if( is_prototype ) then
				if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
					exit function
				end if
        	end if

        	if( hIsClass( parent ) ) then
        		attrib or= FB_SYMBATTRIB_METHOD
        	end if

			is_extern = TRUE
		end if
	end if

	'' Operator
	op = cOperator( )
	if( op = INVALID ) then
		if( errReport( FB_ERRMSG_EXPECTEDOPERATOR ) = FALSE ) then
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

	'' extern implementation?
	if( is_prototype = FALSE ) then
		'' must be done before parsing the params
		if( parent <> NULL ) then
			is_nested = hDoNesting( parent )
		end if
	end if

	'' Parameters?
	if( cParameters( parent, proc, mode, is_prototype ) = NULL ) then
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

    '' convert op to op= if this is a method
    if( (attrib and FB_SYMBATTRIB_METHOD) <> 0 ) then
    	if( symbGetProcParams( proc ) = 1 + 1 ) then
    		if( astGetOpIsSelf( op ) = FALSE ) then
    			if( astGetOpSelfVer( op ) <> 0 ) then
    				op = astGetOpSelfVer( op )
    			end if
    		end if
    	end if
    end if

    '' self? (but type casting)
    if( astGetOpIsSelf( op ) and (op <> AST_OP_CAST) ) then
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

    '' needed to allow CAST to be checked
    symbGetType( proc ) = dtype
    symbGetSubtype( proc ) = subtype
    symbGetAttrib( proc ) = attrib

	''
	if( hCheckOpOvlParams( parent, op, proc, attrib ) = FALSE ) then
		if( is_prototype ) then
			hSkipStmt( )
		else
			'' error recovery: skip the whole compound stmt
    		hSkipCompound( FB_TK_OPERATOR )
    	end if

		exit function
	end if

	if( is_prototype ) then
    	proc = symbAddOperator( proc, op, palias, plib, _
    						    dtype, subtype, ptrcnt, _
    					        attrib, mode )
    	if( proc = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    			exit function
    		end if
    	end if

    	return proc
	end if

	''
	if( hParseAttributes( attrib, 0, 0 ) = FALSE ) then
		exit function
	end if

    dim as FBSYMBOL ptr head_proc

    '' no preview proc or proto for this operator?
    head_proc = symbGetCompOpOvlHead( parent, op )
    if( head_proc = NULL ) then
    	'' extern decl but no prototype?
    	if( is_extern ) then
			if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
				exit function
			end if
    	end if

    	head_proc = symbAddOperator( proc, op, palias, NULL, _
    					   		  	 dtype, subtype, ptrcnt, _
	    					   	  	 attrib, mode, _
    					   		  	 FB_SYMBOPT_DECLARING )

    	if( head_proc = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			proc = CREATEFAKEID( proc )
    		end if

    	else
    		proc = head_proc
    	end if

    '' another proc or proto defined already..
    else
		'' try to find a prototype with the same signature
    	head_proc = symbFindOpOvlProc( op, head_proc, proc )

		'' none found? then try to overload..
    	if( head_proc = NULL ) then
    		'' extern decl but no prototype?
    		if( is_extern ) then
				if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
					exit function
				end if
    		end if

    		head_proc = symbAddOperator( proc, op, palias, NULL, _
    						   		  	 dtype, subtype, ptrcnt, _
    						   		  	 attrib, mode, _
    						   		  	 FB_SYMBOPT_DECLARING )

    		'' dup def?
    		if( head_proc = NULL ) then
    			if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: create a fake symbol
    				return CREATEFAKEID( proc )
    			end if
    		else
    			return head_proc
    		end if
    	end if

    	'' already parsed?
    	if( symbGetIsDeclared( head_proc ) ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' there's already a prototype for this operator, check for
    	'' declaration conflits and fix up the arguments
    	if( hCheckPrototype( head_proc, proc, dtype, subtype ) = FALSE ) then
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' check calling convention
    	if( symbGetProcMode( head_proc ) <> mode ) then
    		if( errReport( FB_ERRMSG_ILLEGALPARAMSPEC, TRUE ) = FALSE ) then
    			exit function
    		end if
    	end if

    	'' use the prototype
    	proc = head_proc

    	''
    	symbSetIsDeclared( proc )

    	symbSetAttrib( proc, attrib )
	end if

    ''
    symbSetProcIncFile( proc, env.inf.incfile )

    function = proc

end function

'':::::
private function hCheckParent _
	( _
		byval parent as FBSYMBOL ptr, _
		byval is_prototype as integer, _
		byval tk as FB_TOKEN _
	) as integer

	function = FALSE

	if( parent = NULL ) then
		if( errReport( FB_ERRMSG_EXPECTEDCLASSID ) <> FALSE ) then
		    if( is_prototype ) then
		    	hSkipStmt( )
		    else
		     	'' error recovery: skip the whole compound stmt
    			hSkipCompound( tk )
    		end if
    	end if

		exit function
	end if

    if( symbGetParent( parent ) <> symbGetCurrentNamespc( ) ) then
    	if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) <> FALSE ) then
		    if( is_prototype ) then
		    	hSkipStmt( )
		    else
		     	'' error recovery: skip the whole compound stmt
    			hSkipCompound( tk )
    		end if
    	end if

    	exit function
	end if

	'' ns used in a prototype?
	if( is_prototype ) then
		if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
			exit function
		end if
    end if

    select case symbGetClass( parent )
	case FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_CLASS

	case else
		if( errReport( FB_ERRMSG_PARENTISNOTACLASS ) <> FALSE ) then
		    if( is_prototype ) then
		    	hSkipStmt( )
		    else
		     	'' error recovery: skip the whole compound stmt
    			hSkipCompound( tk )
    		end if
    	end if

		exit function
	end select

	function = TRUE

end function

'':::::
''ProcHeader   		=  ID CallConvention? (ALIAS LIT_STRING)?
''                     Parameters? (AS SymbolType)? STATIC? EXPORT?
''
function cPropertyHeader _
	( _
		byval is_prototype as integer, _
		byval attrib as integer, _
		byref is_nested as integer _
	) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 id, aliasid, libname
    dim as integer dtype, mode, lgt, ptrcnt, is_extern, is_propset
    dim as FBSYMBOL ptr head_proc, proc, subtype, parent
    dim as zstring ptr palias, plib
    dim as FB_SYMBSTATS stats

	function = NULL

	is_nested = FALSE
	is_extern = FALSE

	attrib or= FB_SYMBATTRIB_PROPERTY or FB_SYMBATTRIB_OVERLOADED

	'' parent
	if( (attrib and FB_SYMBATTRIB_METHOD) <> 0 ) then
		parent = symbGetCurrentNamespc( )

	else
		parent = cParentId( FB_IDOPT_ISDECL or _
							FB_IDOPT_SHOWERROR or _
							FB_IDOPT_ALLOWSTRUCT )

        if( hCheckParent( parent, is_prototype, FB_TK_CONSTRUCTOR ) = FALSE ) then
        	exit function
        end if

		attrib or= FB_SYMBATTRIB_METHOD

		is_extern = TRUE
	end if

	'' id
	head_proc = hGetId( parent, @id, @dtype, TRUE )
	if( head_proc = NULL ) then
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
    end if

	hCheckSuffix( dtype )

	subtype = NULL
	ptrcnt = 0
	stats = 0

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

	proc = symbPreAddProc( @id )

	'' extern implementation?
	if( is_prototype = FALSE ) then
		'' must be done before parsing the params
		if( parent <> NULL ) then
			is_nested = hDoNesting( parent )
		end if
	end if

	'' Parameters?
	if( cParameters( parent, proc, mode, is_prototype ) = NULL ) then
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

	symbGetAttrib( proc ) = attrib

	is_propset = symbGetProcParams( proc ) <> 1

	if( is_propset ) then
		'' not a single param?
		if( symbGetProcParams( proc ) <> 1+1 ) then
			if( errReport( FB_ERRMSG_PROPSETHASONLYONEPARAM, TRUE ) = FALSE ) then
				exit function
			end if
		end if

		'' optional?
		dim as FBSYMBOL ptr param
		param = symbGetProcTailParam( proc )
		if( symbGetIsOptional( param ) ) then
    		if( hParamError( proc, 2, FB_ERRMSG_PARAMCANTBEOPTIONAL ) = FALSE ) then
    			exit function
    		end if
		end if
	end if

    '' (AS SymbolType)?
    if( lexGetToken( ) = FB_TK_AS ) then

    	if( is_propset ) then
    		if( errReport( FB_ERRMSG_PROPSETCANTHAVERESULT ) = FALSE ) then
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

	else
        if( is_propset = FALSE ) then
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
    end if

    if( is_propset ) then
    	dtype = FB_DATATYPE_VOID
    	subtype = NULL
    else
		if( dtype = INVALID ) then
			dtype = symbGetDefType( id )
		end if
    end if

	'' prototype?
	if( is_prototype ) then
    	proc = symbAddPrototype( proc, @id, palias, plib, _
    						     dtype, subtype, ptrcnt, _
    					         attrib, mode )
    	if( proc = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    			exit function
    		end if
    	end if

    	return proc
    end if

	'' function body..

	if( hParseAttributes( attrib, stats, 0 ) = FALSE ) then
		exit function
	end if

    '' no preview proc or proto with the same name?
    if( head_proc = NULL ) then
    	'' extern decl but no prototype?
    	if( is_extern ) then
			if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
				exit function
			end if
    	end if

    	head_proc = symbAddProc( proc, @id, palias, NULL, _
    					   		 dtype, subtype, ptrcnt, _
    					   		 attrib, mode )

    	if( head_proc = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			proc = CREATEFAKEID( proc )
    		end if

    	else
    		proc = head_proc
    	end if

    '' another proc or proto defined already..
    else
		'' not a property?
		if( symbIsProperty( head_proc ) = FALSE ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
		end if

		'' try to find a prototype with the same signature
    	head_proc = symbFindOverloadProc( head_proc, proc )

    	'' none found? then try to overload..
    	if( head_proc = NULL ) then
    		head_proc = symbAddProc( proc, @id, palias, NULL, _
    						   		 dtype, subtype, ptrcnt, _
    						   		 attrib, mode )
    		'' dup def?
    		if( head_proc = NULL ) then
    			if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: create a fake symbol
    				return CREATEFAKEID( proc )
    			end if
    		else
    			return head_proc
    		end if

    	end if

    	'' already parsed?
    	if( symbGetIsDeclared( head_proc ) ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' there's already a prototype for this proc, check for
    	'' declaration conflits and fix up the arguments
    	if( hCheckPrototype( head_proc, proc, dtype, subtype ) = FALSE ) then
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
    		else
    			'' error recovery: create a fake symbol
    			return CREATEFAKEID( proc )
    		end if
    	end if

    	'' check calling convention
    	if( symbGetProcMode( head_proc ) <> mode ) then
    		if( errReport( FB_ERRMSG_ILLEGALPARAMSPEC, TRUE ) = FALSE ) then
    			exit function
    		end if
    	end if

    	'' use the prototype
    	proc = head_proc

    	''
    	symbSetIsDeclared( proc )

    	symbSetAttrib( proc, attrib )
    end if

    ''
    symbSetProcIncFile( proc, env.inf.incfile )

    function = proc

end function

'':::::
''CtorHeader   		=  (ALIAS LIT_STRING)? Parameters? STATIC? EXPORT?
''
function cCtorHeader _
	( _
		byval is_prototype as integer, _
		byval attrib as integer, _
		byref is_nested as integer _
	) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 aliasid, libname
    dim as integer mode, lgt, is_extern, is_ctor
    dim as FBSYMBOL ptr proc, parent
    dim as zstring ptr palias, plib

	function = NULL

	is_nested = FALSE
	is_ctor = (attrib and FB_SYMBATTRIB_CONSTRUCTOR) <> 0
	is_extern = FALSE

	if( is_ctor ) then
		attrib or= FB_SYMBATTRIB_OVERLOADED
	end if

	if( (attrib and FB_SYMBATTRIB_METHOD) <> 0 ) then
		parent = symbGetCurrentNamespc( )

	else
		parent = cParentId( FB_IDOPT_DONTCHKPERIOD or _
							FB_IDOPT_ISDECL or _
							FB_IDOPT_SHOWERROR or _
							FB_IDOPT_ALLOWSTRUCT )

        if( hCheckParent( parent, is_prototype, FB_TK_CONSTRUCTOR ) = FALSE ) then
        	exit function
        end if

		attrib or= FB_SYMBATTRIB_METHOD

		is_extern = TRUE
	end if

	'' CallConvention?
	'' ctors and dtors must be always CDECL if passed to REDIM
	mode = cProcCallingConv( FB_FUNCMODE_CDECL )

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

	'' extern implementation?
	if( is_prototype = FALSE ) then
		'' must be done before parsing the params
		if( parent <> NULL ) then
			is_nested = hDoNesting( parent )
		end if
	end if

	'' Parameters?
	if( cParameters( parent, proc, mode, is_prototype ) = NULL ) then
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

	'' dtor?
	if( is_ctor = FALSE ) then
		if( symbGetProcParams( proc ) > 1 ) then
			if( errReport( FB_ERRMSG_DTORCANTCONTAINPARAMS ) = FALSE ) then
				exit function
			end if
		end if
	else
    	'' vararg?
    	if( symbGetParamMode( symbGetProcTailParam( proc ) ) = FB_PARAMMODE_VARARG ) then
    		if( hParamError( proc, 0, FB_ERRMSG_VARARGPARAMNOTALLOWED ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: remove the param
    			dim as FBSYMBOL ptr param
    			param = symbGetProcTailParam( proc )
    			symbGetProcTailParam( proc ) = param->prev
    			if( param->prev <> NULL ) then
    				param->prev->next = NULL
    			end if
    			symbGetProcParams( proc ) -= 1
    			symbFreeSymbol( param )
    		end if
    	end if
	end if

	if( is_prototype ) then
    	proc = symbAddCtor( proc, palias, plib, _
    						attrib, mode )
    	if( proc = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    			exit function
    		end if
    	end if

    	return proc
	end if

	''
	if( hParseAttributes( attrib, 0, 0 ) = FALSE ) then
		exit function
	end if

    dim as FBSYMBOL ptr head_proc

    '' no preview proc or proto?
    if( is_ctor ) then
    	head_proc = symbGetCompCtorHead( parent )
    else
    	head_proc = symbGetCompDtor( parent )
    end if

    if( head_proc = NULL ) then
    	'' extern decl but no prototype?
    	if( is_extern ) then
			if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
				exit function
			end if
    	end if

    	head_proc = symbAddCtor( proc, palias, NULL, _
	    					   	 attrib, mode, _
    					   		 FB_SYMBOPT_DECLARING )

    	if( head_proc = NULL ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			proc = symbAddProc( proc, hMakeTmpStr( ), NULL, NULL, FB_DATATYPE_VOID, NULL, 0, attrib, mode )
    		end if

    	else
    		proc = head_proc
    	end if

    '' another proc or proto defined already..
    else
		'' try to find a prototype with the same signature
    	head_proc = symbFindCtorProc( head_proc, proc )

		'' none found? then try to overload..
    	if( head_proc = NULL ) then
    		'' extern decl but no prototype?
    		if( is_extern ) then
				if( errReport( FB_ERRMSG_DECLOUTSIDECLASS ) = FALSE ) then
					exit function
				end if
    		end if

    		head_proc = symbAddCtor( proc, palias, NULL, _
    						   		 attrib, mode, _
    						   		 FB_SYMBOPT_DECLARING )

    		'' dup def?
    		if( head_proc = NULL ) then
    			if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    				exit function
    			else
    				'' error recovery: create a fake symbol
    				return symbAddProc( proc, hMakeTmpStr( ), NULL, NULL, FB_DATATYPE_VOID, NULL, 0, attrib, mode )
    			end if
    		else
    			return head_proc
    		end if
    	end if

    	'' already parsed?
    	if( symbGetIsDeclared( head_proc ) ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: create a fake symbol
    			return symbAddProc( proc, hMakeTmpStr( ), NULL, NULL, FB_DATATYPE_VOID, NULL, 0, attrib, mode )
    		end if
    	end if

    	'' there's already a prototype for this operator, check for
    	'' declaration conflits and fix up the arguments
    	if( hCheckPrototype( head_proc, proc, FB_DATATYPE_VOID, NULL ) = FALSE ) then
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
				exit function
    		else
    			'' error recovery: create a fake symbol
    			return symbAddProc( proc, hMakeTmpStr( ), NULL, NULL, FB_DATATYPE_VOID, NULL, 0, attrib, mode )
    		end if
    	end if

    	'' check calling convention
    	if( symbGetProcMode( head_proc ) <> mode ) then
    		if( errReport( FB_ERRMSG_ILLEGALPARAMSPEC, TRUE ) = FALSE ) then
    			exit function
    		end if
    	end if

    	'' use the prototype
    	proc = head_proc

    	''
    	symbSetIsDeclared( proc )

    	symbSetAttrib( proc, attrib )
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

	dim as integer tkn, attrib, is_nested
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

	case FB_TK_CONSTRUCTOR
   		if( fbLangOptIsSet( FB_LANG_OPT_CLASS ) = FALSE ) then
       		if( errReportNotAllowed( FB_LANG_OPT_CLASS ) = FALSE ) then
        		exit function
        	end if
        else
			attrib or= FB_SYMBATTRIB_CONSTRUCTOR
	    end if

	case FB_TK_DESTRUCTOR
   		if( fbLangOptIsSet( FB_LANG_OPT_CLASS ) = FALSE ) then
       		if( errReportNotAllowed( FB_LANG_OPT_CLASS ) = FALSE ) then
        		exit function
        	end if
        else
			attrib or= FB_SYMBATTRIB_DESTRUCTOR
		end if

	case FB_TK_OPERATOR
        if( fbLangOptIsSet( FB_LANG_OPT_OPEROVL ) = FALSE ) then
        	if( errReportNotAllowed( FB_LANG_OPT_OPEROVL ) = FALSE ) then
        		exit function
        	end if
        else
			attrib or= FB_SYMBATTRIB_OPERATOR or FB_SYMBATTRIB_OVERLOADED
		end if

	case FB_TK_PROPERTY
   		if( fbLangOptIsSet( FB_LANG_OPT_CLASS ) = FALSE ) then
       		if( errReportNotAllowed( FB_LANG_OPT_CLASS ) = FALSE ) then
        		exit function
        	end if
        else
			attrib or= FB_SYMBATTRIB_PROPERTY or FB_SYMBATTRIB_OVERLOADED
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
		proc = cProcHeader( tkn = FB_TK_SUB, FALSE, attrib, is_nested )

	case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR
		proc = cCtorHeader( FALSE, attrib, is_nested )

	case FB_TK_OPERATOR
        proc = cOperatorHeader( FALSE, attrib, is_nested )

	case FB_TK_PROPERTY
        proc = cPropertyHeader( FALSE, attrib, is_nested )

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
	stk->proc.is_nested = is_nested

	parser.stmt.proc.cmplabel = NULL
	parser.stmt.proc.endlabel = astGetProcExitlabel( procnode )

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
		case FB_TK_PROPERTY
			errReport( FB_ERRMSG_EXPECTEDENDPROPERTY )
		end select
	end if

	'' function and the result wasn't set?
	dim as FBSYMBOL ptr proc_res

	proc_res = symbGetProcResult( parser.currproc )
	if( proc_res <> NULL ) then
		if( symbGetIsAccessed( proc_res ) = FALSE ) then
			errReportWarn( FB_WARNINGMSG_NOFUNCTIONRESULT )
		end if
	end if

    '' always finish
	function = astProcEnd( stk->proc.node, FALSE )

	'' was the namespace changed?
	if( stk->proc.is_nested ) then
		symbNestEnd( TRUE )
	end if

	'' pop from stmt stack
	cCompStmtPop( stk )

	if( res = FALSE ) then
		function = FALSE
	end if

end function


