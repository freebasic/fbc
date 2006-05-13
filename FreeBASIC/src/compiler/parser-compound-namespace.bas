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


'' NAMESPACE..END NAMESPACE compound statement parsing
''
'' chng: may/2006 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''NamespaceStmtBegin  =   NAMESPACE ID .
''
function cNamespaceStmtBegin( ) as integer
    dim as zstring ptr id
    dim as FBSYMBOL ptr sym
    dim as FBSYMCHAIN ptr chain_
    dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_NAMESPC ) = FALSE ) then
    	exit function
    end if

	if( env.namespcrec >= FB_MAXNAMEPSPACEDEPTH ) then
		hReportError( FB_ERRMSG_RECLEVELTOODEEP )
		exit function
	end if

	'' NAMESPACE
	lexSkipToken( )

	'' ID
	if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
		hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
		exit function
	end if

    '' contains a period?
    if( lexGetPeriodPos( ) > 0 ) then
    	hReportError( FB_ERRMSG_CANTINCLUDEPERIODS )
    	exit function
    end if

	id = lexGetText( )

	chain_ = lexGetSymChain( )
	if( chain_ <> NULL ) then
		sym = chain_->sym

		'' not a namespace?
		if( symbIsNamespace( sym ) = FALSE ) then
			hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
			exit function
		end if

		'' not the same hash tb?
		if( symbGetHashTb( sym ) <> symbGetCurrentHashTb( ) ) then
			'' then it's an inner ns with the same name as an outer one..
			sym = NULL
		end if

	else
		sym = NULL
	end if

	if( sym = NULL ) then
		sym = symbAddNamespace( id )
		if( sym = NULL ) then
			hReportErrorEx( FB_ERRMSG_DUPDEFINITION, id )
			exit function
		end if
	end if

	lexSkipToken( )

	''
	stk = cCompStmtPush( FB_TK_NAMESPACE, _
						 FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
						 					 and (not FB_CMPSTMT_MASK_EXTERN) _
						 					 and (not FB_CMPSTMT_MASK_DATA) )

	stk->nspc.lastsymtb = symbGetCurrentSymTb( )
	symbSetCurrentSymTb( @sym->nspc.symtb )

	stk->nspc.lasthashtb = symbGetCurrentHashTb( )
	symbSetCurrentHashTb( @sym->nspc.hashtb )

	stk->nspc.lastns = symbGetCurrentNamespc( )
	symbSetCurrentNamespc( sym )

	symbHashListAdd( @symbGetNamespaceHashTb( sym ) )

	env.namespcrec += 1

	function = TRUE

end function

'':::::
''NamespaceStmtEnd  =     END NAMESPACE .
''
function cNamespaceStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_NAMESPACE )
	if( stk = NULL ) then
		exit function
	end if

	'' END NAMESPACE
	lexSkipToken( )
	lexSkipToken( )

	'' back to parent
	symbHashListDel( @symbGetNamespaceHashTb( symbGetCurrentNamespc( ) ) )
	symbSetCurrentHashTb( stk->nspc.lasthashtb )
	symbSetCurrentSymTb( stk->nspc.lastsymtb )
	symbSetCurrentNamespc( stk->nspc.lastns )

	'' pop from stmt stack
	cCompStmtPop( stk )

	env.namespcrec -= 1

	function = TRUE

end function

'':::::
''Usingtmt  =     USING ID (',' ID)*
''
function cUsingStmt as integer
    dim as FBSYMBOL ptr sym
    dim as FBSYMCHAIN ptr chain_

    function = FALSE

    '' USING
    lexSkipToken( )

    do
    	'' ID
    	if( lexGetToken( ) <> FB_TK_ID ) then
			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
			exit function
		end if

    	chain_ = cIdentifier( )
    	if( chain_ = NULL ) then
    		hReportError( FB_ERRMSG_UNDEFINEDSYMBOL )
    		exit function
    	end if

    	sym = chain_->sym

		'' not a namespace?
		if( symbIsNamespace( sym ) = FALSE ) then
			hReportError( FB_ERRMSG_TYPEMISMATCH )
			exit function
		end if

    	if( symbNamespaceImport( sym ) = FALSE ) then
    		exit function
    	end if

    '' ','?
    loop while( hMatch( CHAR_COMMA ) )

    function = TRUE

end function
