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


'' proc (SUB and FUNCTION) body parsing
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
private sub hParamError( byval proc as FBSYMBOL ptr, _
						 byval argnum as integer, _
						 byval errnum as integer = FB_ERRMSG_PARAMTYPEMISMATCHAT )

	hReportParamError( proc, argnum, NULL, errnum )

end sub

'':::::
private function hCheckPrototype( byval proto as FBSYMBOL ptr, _
								  byval proc as FBSYMBOL ptr, _
								  byval proc_typ as integer, _
								  byval proc_subtype as FBSYMBOL ptr ) as integer static

    dim as FBSYMBOL ptr proc_arg, proto_arg
    dim as integer argc, typ

	function = FALSE

	'' check arg count
	argc = symbGetProcArgs( proc )
	if( symbGetProcArgs( proto ) <> argc ) then
		hReportError( FB_ERRMSG_ARGCNTMISMATCH, TRUE )
		exit function
	end if

	'' check return type
	if( symbGetType( proto ) <> proc_typ ) then
		hReportError( FB_ERRMSG_TYPEMISMATCH, TRUE )
		exit function
	end if

	'' and sub type
	if( symbGetSubtype( proto ) <> proc_subtype ) then
        hReportError( FB_ERRMSG_TYPEMISMATCH, TRUE )
        exit function
    end if

	'' check each arg
	proto_arg = symbGetProcTailArg( proto )
	proc_arg = symbGetProcTailArg( proc )
	do while( proc_arg <> NULL )
        typ = symbGetType( proto_arg )

    	'' convert any AS ANY arg to the final one
    	if( typ = FB_DATATYPE_VOID ) then
    		proto_arg->typ = proc_arg->typ
    		proto_arg->subtype = proc_arg->subtype

    	'' check if types don't conflit
    	else
    		if( proc_arg->typ <> typ ) then
                hParamError( proc, argc )
                exit function

            elseif( proc_arg->subtype <> symbGetSubtype( proto_arg ) ) then
                hParamError( proc, argc )
                exit function
    		end if
    	end if

    	'' and mode
    	if( proc_arg->arg.mode <> symbGetArgMode( proto_arg ) ) then
			hParamError( proc, argc )
            exit function
    	end if

    	'' check names and change to the new one if needed
    	if( proc_arg->arg.mode <> FB_ARGMODE_VARARG ) then
    		ZstrAssign( @symbGetName( proto_arg ),  symbGetName( proc_arg ) )

    		'' as both have the same type, re-set the suffix, because for example
    		'' "a as integer" on the prototype and "a%" or just "a" on the proc
    		'' declaration when in a defint context is allowed in QB
    		proto_arg->arg.suffix = proc_arg->arg.suffix
    	end if

    	'' prev arg
    	proto_arg = proto_arg->prev
    	proc_arg = proc_arg->prev
    	argc -= 1
    loop

    ''
    function = TRUE

end function

'':::::
''SubOrFuncHeader   =  ID (STDCALL|CDECL|PASCAL) OVERLOAD? (ALIAS LIT_STRING)?
''                     ('(' Arguments? ')')? (AS SymbolType)? (CONSTRUCTOR|DESTRUCTOR)? STATIC? EXPORT?
''
function cSubOrFuncHeader( byval issub as integer, _
						   byref attrib as integer _
						 ) as FBSYMBOL ptr static

    static as zstring * FB_MAXNAMELEN+1 id, aliasid
    dim as integer typ, mode, lgt, ptrcnt
    dim as FBSYMBOL ptr sym, proc, subtype
    dim as zstring ptr palias

	function = NULL

	'' ID
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

	typ 	= lexGetType( )
	sym     = lexGetSymbol( )
	lexEatToken( id )
	subtype = NULL
	ptrcnt  = 0

	if( (isSub) and (typ <> INVALID) ) then
    	hReportError( FB_ERRMSG_INVALIDCHARACTER )
    	exit function
	end if

	'' (CDECL|STDCALL|PASCAL)?
	select case as const lexGetToken( )
	case FB_TK_CDECL
		mode = FB_FUNCMODE_CDECL
		lexSkipToken( )
	case FB_TK_STDCALL
		mode = FB_FUNCMODE_STDCALL
		lexSkipToken( )
	case FB_TK_PASCAL
		mode = FB_FUNCMODE_PASCAL
		lexSkipToken( )
	case else
		mode = FB_DEFAULT_FUNCMODE
	end select

	'' OVERLOAD?
	if( lexGetToken( ) = FB_TK_OVERLOAD ) then
		lexSkipToken( )
		attrib or= FB_SYMBATTRIB_OVERLOADED
	end if

	'' (ALIAS LIT_STRING)?
	if( lexGetToken( ) = FB_TK_ALIAS ) then
		lexSkipToken( )
		lexEatToken( aliasid )
		palias = @aliasid
	else
		palias = NULL
	end if

	proc = symbPreAddProc( @id )

	'' ('(' Arguments? ')')?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		lexSkipToken( )

		cArguments( proc, mode, FALSE )

		if( (hMatch( CHAR_RPRNT ) = FALSE) or (hGetLastError( ) <> FB_ERRMSG_OK) ) then
			hReportError( FB_ERRMSG_EXPECTEDRPRNT )
			exit function
		end if
	end if

    '' (CONSTRUCTOR | DESTRUCTOR)?
    select case lexGetToken( )
    case FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR

        '' not a sub?
        if( isSub = FALSE ) then
        	hReportError( FB_ERRMSG_SYNTAXERROR, TRUE )
        	exit function
        end if

        '' not argless?
        if( symbGetProcArgs( proc ) <> 0 ) then
        	hReportError( FB_ERRMSG_ARGCNTMISMATCH, TRUE )
        	exit function
        end if

		if( lexGetToken( ) = FB_TK_CONSTRUCTOR ) then
			attrib or= FB_SYMBATTRIB_CONSTRUCTOR
		else
			attrib or= FB_SYMBATTRIB_DESTRUCTOR
		end if

		lexSkipToken( )
    end select

    '' (AS SymbolType)?
    if( lexGetToken( ) = FB_TK_AS ) then
    	lexSkipToken( )

    	if( (typ <> INVALID) or (isSub) ) then
    		hReportError( FB_ERRMSG_SYNTAXERROR )
    		exit function
    	end if

    	if( cSymbolType( typ, subtype, lgt, ptrcnt ) = FALSE ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		exit function
    	end if

    	'' check for invalid types
    	select case typ
    	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		hReportError( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS )
    		exit function
    	case FB_DATATYPE_VOID
    		hReportError( FB_ERRMSG_INVALIDDATATYPES )
    		exit function
    	end select
    end if

    if( issub ) then
    	typ = FB_DATATYPE_VOID
    	subtype = NULL
    end if

    if( (attrib and FB_SYMBATTRIB_STATIC) = 0 ) then
    	'' STATIC?
    	if( hMatch( FB_TK_STATIC ) ) then
    		attrib or= FB_SYMBATTRIB_STATIC
    	end if
    end if

    '' EXPORT?
    if( hMatch( FB_TK_EXPORT ) ) then
    	'' private?
    	if( (attrib and FB_SYMBATTRIB_PRIVATE) > 0 ) then
    		hReportError( FB_ERRMSG_SYNTAXERROR )
    		exit function
    	end if

    	fbSetOption( FB_COMPOPT_EXPORT, TRUE )
    	'''''if( fbGetOption( FB_COMPOPT_EXPORT ) = FALSE ) then
    	'''''	hReportWarning( FB_WARNINGMSG_CANNOTEXPORT )
    	'''''end if
    	attrib or= FB_SYMBATTRIB_EXPORT or FB_SYMBATTRIB_PUBLIC
    end if

	''
	if( typ = INVALID ) then
		typ = hGetDefType( id )
	end if

    '' symbol found?
    if( sym <> NULL ) then
    	'' any proc?
    	sym = symbFindByClass( sym, FB_SYMBCLASS_PROC )
    end if

    if( sym = NULL ) then
    	proc = symbAddProc( proc, @id, palias, NULL, _
    						typ, subtype, ptrcnt, _
    						attrib, mode )
    	if( proc = NULL ) then
    		hReportError( FB_ERRMSG_DUPDEFINITION, TRUE )
    		exit function
    	end if

    else
    	'' overloaded?
    	if( symbGetProcIsOverloaded( sym ) ) then

            '' try to find a prototype with the same signature
    		sym = symbFindOverloadProc( sym, proc )

    		'' none found? try to overload..
    		if( sym = NULL ) then
    			proc = symbAddProc( proc, @id, palias, NULL, _
    								typ, subtype, ptrcnt, _
    								attrib, mode )
    			'' dup def?
    			if( proc = NULL ) then
    				hReportError( FB_ERRMSG_DUPDEFINITION, TRUE )
    				exit function
    			else
    				return proc
    			end if
    		end if

    		attrib or= FB_SYMBATTRIB_OVERLOADED
    	end if

    	'' already parsed?
    	if( symbGetIsDeclared( sym ) ) then
    		hReportError( FB_ERRMSG_DUPDEFINITION, TRUE )
    		exit function
    	end if

    	'' there's already a prototype for this proc, check for
    	'' declaretion conflits and fix up the arguments
    	if( hCheckPrototype( sym, proc, typ, subtype ) = FALSE ) then
    		exit function
    	end if

    	'' check calling convention
    	if( symbGetFuncMode( sym ) <> mode ) then
    		hReportError( FB_ERRMSG_ILLEGALPARAMSPEC, TRUE )
    		exit function
    	end if

    	''
    	symbSetIsDeclared( sym )

    	symbSetAttrib( sym, attrib )

		'' ctor or dtor? even if private it should be always emitted
		if( (attrib and (FB_SYMBATTRIB_CONSTRUCTOR or FB_SYMBATTRIB_DESTRUCTOR)) > 0 ) then
    		symbSetIsCalled( sym )
    	end if

    	'' return the prototype
    	proc = sym
    end if

    ''
    symbSetProcIncFile( proc, env.inf.incfile )

    function = proc

end function

'':::::
''ProcStatement	  =	  (PRIVATE|PUBLIC)? STATIC? ((SUB SubDecl) | (FUNCTION FuncDecl)) Comment? SttSeparator
''					  SimpleLine*
''				      END (SUB | FUNCTION)
''
function cProcStatement static
	dim as integer res, issub, attrib
    dim as FBCMPSTMT oldprocstmt
    dim as FBSYMBOL ptr proc
    dim as ASTNODE ptr expr
    dim as ASTPROCNODE ptr procnode

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

    '' STATIC?
    if( hMatch( FB_TK_STATIC ) ) then
    	attrib = attrib or FB_SYMBATTRIB_STATIC
    end if

	'' SUB | FUNCTION
	select case lexGetToken( )
	case FB_TK_SUB
		issub = TRUE
	case FB_TK_FUNCTION
		issub = FALSE
	case else
		exit function
	end select

	lexSkipToken( )

	''
	if( env.scope > FB_MAINSCOPE ) then
		if( fbIsModLevel( ) = FALSE ) then
        	hReportError( FB_ERRMSG_INNERPROCNOTALLOWED )
		else
        	hReportError( FB_ERRMSG_ILLEGALINSIDEASCOPE )
        end if
        exit function
	end if

	'' SubDecl | FuncDecl
	proc = cSubOrFuncHeader( issub, attrib )
	if( proc = NULL  ) then
		exit function
	end if

	''
	env.compoundcnt += 1

	if( (attrib and FB_SYMBATTRIB_STATIC) > 0 ) then
		env.isprocstatic = TRUE
	else
		env.isprocstatic = FALSE
	end if

	'' emit proc setup
	procnode = astProcBegin( proc, FALSE )
	if( procnode = NULL ) then
		exit function
	end if

	'' save old proc stmt info
	oldprocstmt = env.procstmt

	env.procstmt.cmplabel = NULL
	env.procstmt.endlabel = procnode->exitlabel

	'' restore error old handle if any was set
	env.procerrorhnd = NULL


	'' Comment?
	cComment( )

	'' SttSeparator
	if( cStmtSeparator( ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDEOL )
		exit function
	end if

	'' init
	astAdd( astNewLABEL( procnode->initlabel ) )

	'' proc body
	do
		if( cSimpleLine( ) = FALSE ) then
			exit do
		end if
	loop while( lexGetToken( ) <> FB_TK_EOF )

	'' END (SUB | FUNCTION)
	if( hMatch( FB_TK_END ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDENDSUBORFUNCT )
		exit function
	else
		res = FALSE
		if( hMatch( FB_TK_SUB ) ) then
			if( issub ) then
				res = TRUE
			end if
		elseif( hMatch( FB_TK_FUNCTION ) ) then
			if( issub = FALSE ) then
				res = TRUE
			end if
		end if

		if( res = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDENDSUBORFUNCT )
			exit function
		end if
	end if

	'' exit
	astAdd( astNewLABEL( procnode->exitlabel ) )

	'' restore old error handler if any was set
	if( env.procerrorhnd <> NULL ) then
        expr = astNewVAR( env.procerrorhnd, 0, FB_DATATYPE_POINTER+FB_DATATYPE_VOID )
        rtlErrorSetHandler( expr, FALSE )
	end if

	'' check undefined local labels
	function = (symbCheckLocalLabels( ) = 0)

	'' end
	astProcEnd( procnode, FALSE )

	'' back to old state
	env.procerrorhnd = NULL
	env.compoundcnt -= 1
	env.isprocstatic = FALSE
	env.procstmt.cmplabel = NULL
	env.procstmt.endlabel = NULL

end function


