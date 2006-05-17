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
    	return NULL
    end if

    do while( symbGetClass( chain_->sym ) = FB_SYMBCLASS_NAMESPACE )

    	ns = chain_->sym

    	'' declaration?
    	if( isdecl ) then
    		'' different name spaces?
    		if( ns <> symbGetCurrentNamespc( ) ) then
    			'' anything but the global one? (same as in C++)
    			if( symbIsGlobalNamespc( ) = FALSE ) then
    				hReportError( FB_ERRMSG_DECLOUTSIDENAMESPC )
    				exit function
    			end if
    		end if

    		'' check only the base ns
    		isdecl = FALSE
    	end if

    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		exit do
    	end if

    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' ID
    	if( lexGetToken( ) <> FB_TK_ID ) then
    		if( showerror ) then
    			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		end if

    		return NULL
    	end if

    	chain_ = symbLookupAt( ns, lexGetText( ) )
    	if( chain_ = NULL ) then
           	if( showerror ) then
           		hReportError( FB_ERRMSG_UNDEFINEDSYMBOL )
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
		_
	) as FBSYMBOL ptr static

    dim as FBSYMCHAIN ptr chain_
    dim as FBSYMBOL ptr ns

    ns = NULL

    chain_ = lexGetSymChain( )
    do while( chain_ <> NULL )

    	if( symbGetClass( chain_->sym ) <> FB_SYMBCLASS_NAMESPACE ) then
    		exit do
    	end if
    	ns = chain_->sym

    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		hReportError( FB_ERRMSG_EXPECTEDPERIOD )
    		return NULL
    	end if

    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' ID
    	if( lexGetToken( ) <> FB_TK_ID ) then
    		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		return NULL
    	end if

    	chain_ = symbLookupAt( chain_->sym, lexGetText( ) )
    loop

	function = ns

end function


