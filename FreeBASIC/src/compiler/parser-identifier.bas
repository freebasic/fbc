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


'' complex (scoped with namespace and/or class) identifiers parsing
''
'' chng: may/2006 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"

'':::::
private sub hSkipSymbol( )

	do
		lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		exit do
    	end if

    	select case lexGetClass()
    	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD

    	case else
    		exit do
    	end select
	loop

end sub

'':::::
private function hGlobalId _
	( _
		byval isdecl as integer = FALSE, _
		byval showerror as integer = TRUE _
	) as FBSYMCHAIN ptr

	function = NULL

    '' another '.'?
    if( lexGetLookAhead( 1, LEXCHECK_NOLOOKUP ) = CHAR_DOT ) then
    	'' skip the first '.'
    	lexSkipToken( LEXCHECK_NOLOOKUP )

    else
    	'' with inside a WITH block, a single '.' is ambiguous..
    	if( env.stmt.with.sym <> NULL ) then
    		exit function
    	end if
    end if

    if( isdecl ) then
    	'' different name spaces?
    	if( symbIsGlobalNamespc( ) = FALSE ) then
    		if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
    			exit function
    		end if
    	end if
    end if

    '' skip the '.'
    lexSkipToken( LEXCHECK_NOLOOKUP )

    '' not an ID?
    if( lexGetToken( ) <> FB_TK_ID ) then
    	if( showerror ) then
    		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
    	end if
    	exit function
    end if

	function = symbLookupAt( @symbGetGlobalNamespc( ), lexGetText( ), FALSE )

end function

'':::::
'' Identifier	= (ID{namespace} '.')* ID
''				|  ID ('.' ID)* .
''
function cIdentifier _
	( _
		byval isdecl as integer, _
		byval showerror as integer _
	) as FBSYMCHAIN ptr static

    dim as FBSYMCHAIN ptr chain_
    dim as FBSYMBOL ptr ns

    chain_ = lexGetSymChain( )

    if( chain_ = NULL ) then
    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		return NULL
    	end if

    	chain_ = hGlobalId( isdecl, showerror )
    	if( chain_ = NULL ) then
    		return NULL
    	end if
    end if

    do while( symbGetClass( chain_->sym ) = FB_SYMBCLASS_NAMESPACE )

    	ns = chain_->sym

    	'' declaration?
    	if( isdecl ) then
    		'' different name spaces?
    		if( ns <> symbGetCurrentNamespc( ) ) then
    			'' anything but the global one? (same as in C++)
    			if( symbIsGlobalNamespc( ) = FALSE ) then
    				if( showerror ) then
    					if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
    						exit function
    					end if
    				end if
    			end if
    		end if

    		'' check only the base ns
    		isdecl = FALSE
    	end if

    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		if( showerror ) then
    			if( errReport( FB_ERRMSG_EXPECTEDPERIOD ) = FALSE ) then
    				return NULL
    			else
    				exit do
    			end if
    		else
    			exit do
    		end if
    	end if

    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' ID
    	if( lexGetToken( ) <> FB_TK_ID ) then
    		if( showerror ) then
    			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		end if

    		return NULL
    	end if

    	chain_ = symbLookupAt( ns, lexGetText( ), FALSE )
    	if( chain_ = NULL ) then
           	if( showerror ) then
           		errReportUndef( FB_ERRMSG_UNDEFINEDSYMBOL, lexGetText( ) )
    		else
    			hSkipSymbol( )
           	end if

           	return NULL
    	end if
    loop

	function = chain_

end function

'':::::
'' Identifier	= ID{namespace} ('.' ID{namespace})* .
''
function cNamespace _
	( _
		byval checkdot as integer _
	) as FBSYMBOL ptr static

    dim as FBSYMCHAIN ptr chain_
    dim as FBSYMBOL ptr ns

    ns = NULL

    chain_ = lexGetSymChain( )
    if( chain_ = NULL ) then
    	'' '.'?
    	if( lexGetToken( ) = CHAR_DOT ) then
    		chain_ = hGlobalId( )
    	end if
    end if

    do while( chain_ <> NULL )

    	if( symbGetClass( chain_->sym ) <> FB_SYMBCLASS_NAMESPACE ) then
    		exit do
    	end if
    	ns = chain_->sym

    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		if( checkdot = FALSE ) then
    			exit do
    		end if

    		if( errReport( FB_ERRMSG_EXPECTEDPERIOD ) = FALSE ) then
    			return NULL
    		else
    			exit do
    		end if
    	end if

    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' ID
    	if( lexGetToken( ) <> FB_TK_ID ) then
    		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    			return NULL
    		else
    			exit do
    		end if
    	end if

    	chain_ = symbLookupAt( chain_->sym, lexGetText( ), FALSE )
    loop

	function = ns

end function


