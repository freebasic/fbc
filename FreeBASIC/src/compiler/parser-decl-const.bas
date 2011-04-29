''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


'' constant (CONST) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

''::::
private function hGetType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr _
	) as integer

	function = FALSE

	'' (AS SymbolType)?
	if( lexGetToken( ) = FB_TK_AS ) then
		lexSkipToken( )

		dim as integer lgt = any

		if( cSymbolType( dtype, subtype, lgt ) = FALSE ) then
			exit function
		end if

		'' check for invalid types
		if( subtype <> NULL ) then
			'' only allow if it's an enum
			if( dtype <> FB_DATATYPE_ENUM ) then
				if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
					exit function
				else
					'' error recovery: discard type
					dtype = FB_DATATYPE_INVALID
					subtype = NULL
				end if
			end if
		end if

		select case as const typeGet( dtype )
		case FB_DATATYPE_VOID, FB_DATATYPE_FIXSTR, _
			 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

			if( errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE ) = FALSE ) then
				exit function
			else
				'' error recovery: discard type
				dtype = FB_DATATYPE_INVALID
				subtype = NULL
			end if

		end select

	else
		dtype = FB_DATATYPE_INVALID
		subtype = NULL
	end if

	function = TRUE

end function

'':::
''ConstAssign     =   ID (AS SymbolType)? '=' ConstExpression .
''
function cConstAssign _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

    static as zstring * FB_MAXNAMELEN+1 id
    dim as integer doskip = any
    dim as ASTNODE ptr expr = any
    dim as FBSYMBOL ptr parent = any, litsym = any
    dim as FBVALUE value = any

	function = FALSE

	'' don't allow explicit namespaces
	parent = cParentId( )
    if( parent <> NULL ) then
		if( hDeclCheckParent( parent ) = FALSE ) then
			exit function
    	end if
    else
    	if( errGetLast( ) <> FB_ERRMSG_OK ) then
    		exit function
    	end if
    end if

	dim as integer suffix = lexGetType( )
	hCheckSuffix( suffix )

	'' ID
	select case as const lexGetClass( )
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
		if( env.clopt.lang <> FB_LANG_QB ) then
			'' only if inside a ns and if not local
			if( (symbIsGlobalNamespc( )) or (parser.scope > FB_MAINSCOPE) ) then
    			if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    				exit function
    			else
					'' error recovery: skip until next stmt or const decl
					hSkipUntil( FB_TK_DECLSEPCHAR )
					return TRUE
    			end if
    		end if
    	end if

	case FB_TKCLASS_KEYWORD, FB_TKCLASS_OPERATOR
		if( env.clopt.lang <> FB_LANG_QB ) then
    		if( errReport( FB_ERRMSG_DUPDEFINITION ) = FALSE ) then
    			exit function
			else
				'' error recovery: skip until next stmt or const decl
				hSkipUntil( FB_TK_DECLSEPCHAR )
				return TRUE
			end if
		end if

	case else
		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
			exit function
		else
			'' error recovery: skip until next stmt or const decl
			hSkipUntil( FB_TK_DECLSEPCHAR )
			return TRUE
		end if
	end select

	id = *lexGetText( )
	lexSkipToken( )

	'' not multiple?
	if( dtype = FB_DATATYPE_INVALID ) then
		'' (AS SymbolType)?
		if( hGetType( dtype, subtype ) = FALSE ) then
			exit function
		end if
	end if

	'' both suffix and type given?
	if( suffix <> FB_DATATYPE_INVALID ) then
		if( dtype <> FB_DATATYPE_INVALID ) then
			if( errReportEx( FB_ERRMSG_SYNTAXERROR, id ) = FALSE ) then
				exit function
			end if
		end if

		dtype = suffix
		subtype = NULL

		attrib or= FB_SYMBATTRIB_SUFFIXED
	end if

	'' '='
	doskip = FALSE
	if( lexGetToken( ) <> FB_TK_ASSIGN ) then
		if( errReport( FB_ERRMSG_EXPECTEDEQ ) = FALSE ) then
			exit function
		else
			doskip = TRUE
		end if

	else
		lexSkipToken( )
	end if

	'' ConstExpression
	expr = cExpression( )
	if( expr = NULL ) then
		if( errReportEx( FB_ERRMSG_EXPECTEDCONST, id ) = FALSE ) then
			exit function
		else
			doskip = TRUE
			expr = NULL
		end if
	end if

	if( expr = NULL ) then
		'' error recovery: create a fake node
		expr = astNewCONSTz( dtype )
	end if

	'' check if it's an string
	dim as integer exprdtype = astGetDataType( expr )
	litsym = NULL
	select case exprdtype
	case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		litsym = astGetStrLitSymbol( expr )
	end select

	'' string?
	if( litsym <> NULL ) then

		if( dtype <> FB_DATATYPE_INVALID ) then
			'' not a string?
			if( dtype <> FB_DATATYPE_STRING ) then
				if( errReportEx( FB_ERRMSG_INVALIDDATATYPES, id ) = FALSE ) then
					exit function
				end if
			end if
		end if

		value.str = litsym

		if( symbAddConst( @id, exprdtype, NULL, @value, attrib ) = NULL ) then
    		if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
    			exit function
    		end if
		end if

	'' anything else..
	else

		'' not a constant?
		if( astIsCONST( expr ) = FALSE ) then
			if( errReportEx( FB_ERRMSG_EXPECTEDCONST, id ) = FALSE ) then
				exit function
			else
				'' error recovery: create a fake node
				astDelTree( expr )
				expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
				exprdtype = FB_DATATYPE_INTEGER
			end if
		end if

		if( dtype <> FB_DATATYPE_INVALID ) then
			'' string?
			if( typeGet( dtype ) = FB_DATATYPE_STRING ) then
				if( errReportEx( FB_ERRMSG_INVALIDDATATYPES, id ) = FALSE ) then
					exit function
				else
					'' error recovery: create a fake node
					astDelTree( expr )
					exprdtype = dtype
					subtype = NULL
					expr = astNewCONSTstr( NULL )
				end if
			end if

			'' convert if needed
			if( (dtype <> exprdtype) or _
				(subtype <> astGetSubtype( expr )) ) then

				expr = astNewCONV( dtype, subtype, expr )
				if( expr = NULL ) then
					if( errReportEx( FB_ERRMSG_INVALIDDATATYPES, id ) = FALSE ) then
						exit function
					else
						'' error recovery: create a fake node
						expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
						dtype = FB_DATATYPE_INTEGER
						subtype = NULL
					end if
				end if
			end if

		else
			dtype = exprdtype
			subtype = astGetSubtype( expr )
		end if

		''
		if( symbAddConst( @id, _
						  dtype, _
						  subtype, _
						  @astGetValue( expr ), _
						  attrib ) = NULL ) then
    		if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
    			exit function
    		end if
		end if

    end if

	''
	astDelNode( expr )

	if( doskip ) then
		'' error recovery: skip until next stmt or const decl
		hSkipUntil( FB_TK_DECLSEPCHAR )
	end if

	function = TRUE

end function

'':::::
''ConstDecl       =   CONST (AS SymbolType)? ConstAssign (DECL_SEPARATOR ConstAssign)* .
''
function cConstDecl _
	( _
		byval attrib as FB_SYMBATTRIB = FB_SYMBATTRIB_NONE _
	) as integer

    dim as integer dtype = any
    dim as FBSYMBOL ptr subtype = any

    function = FALSE

    '' CONST
    lexSkipToken( )

	'' (AS SymbolType)?
	if( hGetType( dtype, subtype ) = FALSE ) then
		exit function
	end if

	do
		'' ConstAssign
		if( cConstAssign( dtype, subtype, attrib ) = FALSE ) then
			exit function
		end if

    	'' ','?
    	if( lexGetToken( ) <> FB_TK_DECLSEPCHAR ) then
    		exit do
    	end if

    	lexSkipToken( )
	loop

	function = TRUE

end function


