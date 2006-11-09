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


'' complex (scoped with namespace and/or class) identifiers parsing
''
'' chng: may/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
private sub hSkipSymbol( )

	do
		lexSkipToken( LEXCHECK_NOPERIOD )

    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		exit do
    	end if

    	select case as const lexGetClass()
    	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

    	case else
    		exit do
    	end select
	loop

end sub

'':::::
private function hGlobalId _
	( _
		byval options as FB_IDOPT = FB_IDOPT_SHOWERROR _
	) as FBSYMCHAIN ptr

	function = NULL

    '' another '.'?
    if( lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) = CHAR_DOT ) then
    	'' skip the first '.'
    	lexSkipToken( LEXCHECK_NOPERIOD )

    else
    	'' with inside a WITH block, a single '.' is ambiguous..
    	if( parser.stmt.with.sym <> NULL ) then
    		exit function
    	end if
    end if

    if( (options and FB_IDOPT_ISDECL) <> 0 ) then
    	'' different name spaces?
    	if( symbIsGlobalNamespc( ) = FALSE ) then
    		if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
    			exit function
    		end if
    	end if
    end if

    '' skip the '.'
    lexSkipToken( LEXCHECK_NOPERIOD )

    '' not an ID?
    select case lexGetClass( )
    case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

    case else
    	if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
    		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
    	end if
    	exit function
    end select

	function = symbLookupAt( @symbGetGlobalNamespc( ), lexGetText( ), FALSE )

end function

'':::::
#macro hCheckDecl( base_parent, options )
    '' declaration?
    if( (options and FB_IDOPT_ISDECL) <> 0 ) then
    	if( base_parent <> NULL ) then
    		'' different parents?
    		if( symbGetParent( base_parent ) <> symbGetCurrentNamespc( ) ) then
				if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
    				errReport( FB_ERRMSG_DECLOUTSIDENAMESPC )
    				return NULL
    			end if
			end if
		end if
    end if
#endmacro

'':::::
'' Identifier	= (ID{namespace|class} '.')* ID
''				|  ID ('.' ID)* .
''
function cIdentifier _
	( _
		byval options as FB_IDOPT _
	) as FBSYMCHAIN ptr static

    dim as FBSYMCHAIN ptr chain_
    dim as FBSYMBOL ptr parent, base_parent

    chain_ = lexGetSymChain( )

	if( fbLangOptIsSet( FB_LANG_OPT_NAMESPC ) = FALSE ) then
	    return chain_
	end if

    if( chain_ = NULL ) then
    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		return NULL
    	end if

    	chain_ = hGlobalId( options )
    	if( chain_ = NULL ) then
    		return NULL
    	end if
    end if

    base_parent = NULL

    do
    	parent = chain_->sym

    	select case as const symbGetClass( parent )
    	case FB_SYMBCLASS_NAMESPACE, FB_SYMBCLASS_CLASS

    	case FB_SYMBCLASS_STRUCT
    		if( (options and FB_IDOPT_ALLOWSTRUCT) = 0 ) then
    			exit do
    		end if

    		'' ordinary struct?
    		if( symbGetIsUnique( parent ) = FALSE ) then
    			exit do
    		end if

    	case FB_SYMBCLASS_TYPEDEF
    		if( (options and FB_IDOPT_ALLOWSTRUCT) = 0 ) then
    			exit do
    		end if

            '' typedef of a TYPE/CLASS?
            select case symbGetType( parent )
            case FB_DATATYPE_STRUCT
            	parent = symbGetSubtype( parent )

    			'' ordinary struct?
    			if( symbGetIsUnique( parent ) = FALSE ) then
    				exit do
    			end if

            'case FB_DATATYPE_CLASS
            	'' ...

            case else
            	exit do
            end select

    	case else
    		exit do
    	end select

    	'' '.'?
    	if( lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) <> CHAR_DOT ) then
    		'' if it's a namespace, the '.' is obligatory, the
    		'' namespace itself isn't a composite type
    		if( symbGetClass( parent ) = FB_SYMBCLASS_NAMESPACE ) then
    			'' skip id
    			lexSkipToken( LEXCHECK_NOPERIOD )

    			if( (options and FB_IDOPT_DONTCHKPERIOD) <> 0 ) then
    				exit do
    			end if

    			if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
    				if( errReport( FB_ERRMSG_EXPECTEDPERIOD ) = FALSE ) then
    					return NULL
    				end if
    			end if
    		end if

    		exit do
    	end if

    	'' skip id
    	lexSkipToken( LEXCHECK_NOPERIOD )

    	'' skip '.'
    	lexSkipToken( LEXCHECK_NOPERIOD )

    	if( base_parent = NULL ) then
    		base_parent = parent
    	end if

    	'' ID
    	select case as const lexGetClass( )
    	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

    	case FB_TKCLASS_OPERATOR, FB_TKCLASS_KEYWORD
    		if( (options and FB_IDOPT_ISOPERATOR ) <> 0 ) then
    			exit do
    		end if

    		if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
    			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		end if

    		return NULL

    	case else
    		if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
    			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		end if

    		return NULL
    	end select

    	chain_ = symbLookupAt( parent, lexGetText( ), FALSE )
    	if( chain_ = NULL ) then
          	if( (options and FB_IDOPT_SHOWERROR) <> 0 ) then
          		errReportUndef( FB_ERRMSG_UNDEFINEDSYMBOL, lexGetText( ) )
    		else
    			hSkipSymbol( )
           	end if

    	    return NULL
    	end if
    loop

	''
	hCheckDecl( base_parent, options )

	function = chain_

end function

'':::::
'' ParentId		= ID{namespace|class} ('.' ID{namespace|class})* .
''
function cParentId _
	( _
		byval options as FB_IDOPT _
	) as FBSYMBOL ptr static

    dim as FBSYMCHAIN ptr chain_
    dim as FBSYMBOL ptr parent, base_parent

	if( fbLangOptIsSet( FB_LANG_OPT_NAMESPC ) = FALSE ) then
	    return NULL
	end if

    chain_ = lexGetSymChain( )
    if( chain_ = NULL ) then
    	'' '.'?
    	if( lexGetToken( ) = CHAR_DOT ) then
    		chain_ = hGlobalId( )
    	end if
    end if

    parent = NULL
    base_parent = NULL

    do while( chain_ <> NULL )

    	select case as const symbGetClass( chain_->sym )
    	case FB_SYMBCLASS_NAMESPACE, FB_SYMBCLASS_CLASS
    		parent = chain_->sym

    	case FB_SYMBCLASS_STRUCT
    		if( (options and FB_IDOPT_ALLOWSTRUCT) = 0 ) then
    			exit do
    		end if

    		'' ordinary struct?
    		if( symbGetIsUnique( chain_->sym ) = FALSE ) then
    			exit do
    		end if

    		parent = chain_->sym

    	case FB_SYMBCLASS_TYPEDEF
    		if( (options and FB_IDOPT_ALLOWSTRUCT) = 0 ) then
    			exit do
    		end if

            dim as FBSYMBOL ptr sym

            '' typedef of a TYPE/CLASS?
            select case symbGetType( chain_->sym )
            case FB_DATATYPE_STRUCT

    			sym = symbGetSubtype( chain_->sym )

    			'' ordinary struct?
    			if( symbGetIsUnique( sym ) = FALSE ) then
    				exit do
    			end if

			'case FB_DATATYPE_CLASS
				'' ...

    		case else
    			exit do
    		end select

    		parent = sym

    	case else
    		exit do
    	end select

    	'' '.'?
    	if( lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) <> CHAR_DOT ) then
    		'' skip id
    		lexSkipToken( LEXCHECK_NOPERIOD )

    		if( (options and FB_IDOPT_DONTCHKPERIOD) <> 0 ) then
    			exit do
    		end if

    		if( errReport( FB_ERRMSG_EXPECTEDPERIOD ) = FALSE ) then
    			return NULL
    		else
    			exit do
    		end if
    	end if

    	'' skip id
    	lexSkipToken( LEXCHECK_NOPERIOD )

    	'' skip '.'
    	lexSkipToken( LEXCHECK_NOPERIOD )

    	if( base_parent = NULL ) then
    		base_parent = parent
    	end if

    	'' ID
    	select case as const lexGetClass( )
    	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD

    	case FB_TKCLASS_OPERATOR, FB_TKCLASS_KEYWORD
    		if( (options and FB_IDOPT_ISOPERATOR ) <> 0 ) then
    			exit do
    		end if

    		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    			return NULL
    		else
    			exit do
    		end if

    	case else
    		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    			return NULL
    		else
    			exit do
    		end if
    	end select

    	chain_ = symbLookupAt( parent, lexGetText( ), FALSE )
    loop

	''
	hCheckDecl( base_parent, options )

	function = parent

end function


