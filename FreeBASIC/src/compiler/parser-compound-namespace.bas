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
''NamespaceStmtBegin  =   NAMESPACE (ID (ALIAS LITSTR)?)? .
''
function cNamespaceStmtBegin _
	( _
		_
	) as integer

    static as zstring * FB_MAXNAMELEN+1 id, id_alias
    dim as zstring ptr palias
    dim as FBSYMBOL ptr sym
    dim as FBSYMCHAIN ptr chain_
    dim as FB_CMPSTMTSTK ptr stk

	function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_NAMESPC ) = FALSE ) then
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_NAMESPACE )
    	exit function
    end if

	'' NAMESPACE
	lexSkipToken( )

	'' ID?
	palias = NULL

	select case lexGetToken( )
	'' COMMENT|NEWLINE?
	case FB_TK_COMMENTCHAR, FB_TK_REM, FB_TK_EOL, FB_TK_EOF, FB_TK_STATSEPCHAR

		'' anonymous namespace..
		sym = symbAddNamespace( hMakeTmpStr( ), NULL )

	case else

    	if( lexGetToken( ) <> FB_TK_ID ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a symbol
				sym = symbAddNamespace( hMakeTmpStr( ), NULL )
				exit select
			end if
		end if

    	'' contains a period?
    	if( lexGetPeriodPos( ) > 0 ) then
    		if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
    			exit function
    		end if
    	end if

		id = *lexGetText( )

		chain_ = lexGetSymChain( )
		if( chain_ <> NULL ) then
			sym = chain_->sym

			'' not a namespace?
			if( symbIsNamespace( sym ) = FALSE ) then
				if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an id
					id = *hMakeTmpStr( )
					sym = NULL
				end if

            else
				'' not the same hash tb?
				if( symbGetHashTb( sym ) <> symbGetCurrentHashTb( ) ) then
					'' then it's an inner ns with the same name as an outer one..
					sym = NULL
				end if
			end if


		else
			sym = NULL
		end if

		lexSkipToken( )

		if( sym = NULL ) then
			'' (ALIAS LITSTR)?
			if( lexGetToken( ) = FB_TK_ALIAS ) then
    			lexSkipToken( )

				if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
					if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
						exit function
					end if

				else
					lexEatToken( @id_alias )
					palias = @id_alias
				end if
			end if

			sym = symbAddNamespace( @id, palias )
			if( sym = NULL ) then
				if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
					exit function
				else
					'' error recovery: fake an id
					sym = symbAddNamespace( hMakeTmpStr( ), NULL )
				end if
			end if
		end if

	end select

	''
	stk = cCompStmtPush( FB_TK_NAMESPACE, _
						 FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
						 					 and (not FB_CMPSTMT_MASK_EXTERN) _
						 					 and (not FB_CMPSTMT_MASK_DATA) )

	stk->nspc.lastsymtb = symbGetCurrentSymTb( )
	symbSetCurrentSymTb( @symbGetNamespaceTb( sym ) )

	stk->nspc.lasthashtb = symbGetCurrentHashTb( )
	symbSetCurrentHashTb( @symbGetNamespaceHashTb( sym ) )

	stk->nspc.lastns = symbGetCurrentNamespc( )
	symbSetCurrentNamespc( sym )

	symbHashListAdd( @symbGetNamespaceHashTb( sym ) )

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
    	chain_ = cIdentifier( )
    	if( chain_ = NULL ) then
    		if( lexGetToken( ) <> FB_TK_ID ) then
				if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
					exit function
				else
					'' error recovery: skip until next ','
					hSkipUntil( CHAR_COMMA )
				end if

    		else
    			if( errReport( FB_ERRMSG_UNDEFINEDSYMBOL ) = FALSE ) then
    				exit function
				else
					'' error recovery: skip until next ','
					hSkipUntil( CHAR_COMMA )
				end if
			end if

    	else
    		sym = chain_->sym

			'' not a namespace?
			if( symbIsNamespace( sym ) = FALSE ) then
				if( errReport( FB_ERRMSG_TYPEMISMATCH ) = FALSE ) then
					exit function
				end if

			else
    			if( symbNamespaceImport( sym ) = FALSE ) then
	   				exit function
    			end if
			end if
		end if

    '' ','?
    loop while( hMatch( CHAR_COMMA ) )

    function = TRUE

end function
