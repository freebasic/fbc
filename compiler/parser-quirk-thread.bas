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


'' quick threadcall implementation
''
'' chng: oct/2011 written [jofers]

#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"

#include once "ast.bi"
#include once "rtl.bi"

'':::::
'' ThreadCallFunc =   THREADCALL proc_call
''
function cThreadCallFunc _
	( _
        byref funcexpr as ASTNODE ptr _
	) as integer
    
    dim as FBSYMBOL ptr sym, result
    dim as FBSYMCHAIN ptr chain_
    dim as integer check_paren
    dim as FB_CALL_ARG_LIST arg_list = ( 0, NULL, NULL )
    dim as ASTNODE ptr childcall 
    
    function = FALSE
    
    '' THREADCALL
    lexSkipToken( )
    
    '' proc 
    dim class_ as integer
    chain_ = cIdentifier( NULL, FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )
    if( chain_ = NULL ) then
        exit function
    end if

    '' get symbol
    sym = symbFindByClass( chain_, FB_SYMBCLASS_PROC )
    if sym = NULL then
        errReport( FB_ERRMSG_EXPECTEDSUB )
        exit function
    end if
    
    '' must be a sub
    result = symbGetProcResult( sym )
    if( result <> NULL ) then
        if( symbGetType( result ) <> FB_DATATYPE_VOID ) then
            errReport( FB_ERRMSG_EXPECTEDSUB )
            exit function
        end if
    end if

    lexSkipToken( )
    
    '' '('?
    if( hMatch( CHAR_LPRNT ) = FALSE ) then
        dim params as integer
        params = symbGetProcParams( sym )
        if( params > 0 ) then
            errReport( FB_ERRMSG_EXPECTEDLPRNT )
            exit function
        end if
    else
        check_paren = TRUE
    end if
    
    '' arg_list
    childcall = cProcArgList( NULL, sym, NULL, @arg_list, 0 )

    '' ')'?
    if( check_paren = TRUE ) then
        if( lexGetToken( ) <> CHAR_RPRNT ) then
            errReport( FB_ERRMSG_EXPECTEDRPRNT )
            exit function
        end if
        lexSkipToken( )
    end if

    '' transform the call into a threadcall
    if( rtlThreadCall( childcall, funcexpr ) = FALSE ) then
        exit function
    end if
    
    function = TRUE
end function

