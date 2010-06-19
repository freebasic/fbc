''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2010 The FreeBASIC development team.
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


'' SCOPE..END SCOPE compound statement parsing
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''ScopeStmtBegin  =   SCOPE .
''
function cScopeStmtBegin as integer
    dim as ASTNODE ptr n = any
    dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

    if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) = FALSE ) then
    	errReportNotAllowed( FB_LANG_OPT_SCOPE )
    	'' error recovery: skip the whole compound stmt
    	hSkipCompound( FB_TK_SCOPE )
    	exit function
    end if

	'' SCOPE
	lexSkipToken( )

	n = astScopeBegin( )
	if( n = NULL ) then
		if( errReport( FB_ERRMSG_RECLEVELTOODEEP ) = FALSE ) then
			exit function
		end if
	end if

	''
	stk = cCompStmtPush( FB_TK_SCOPE )
	stk->scopenode = n

	'' deprecated quirk: implicit vars inside implicit scope blocks
	'' must be allocated in the function scope
	stk->scp.lastis_scope = fbGetIsScope( )
	fbSetIsScope( TRUE )

	function = TRUE

end function

'':::::
''ScopeStmtEnd  =     END SCOPE .
''
function cScopeStmtEnd as integer
	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	stk = cCompStmtGetTOS( FB_TK_SCOPE )
	if( stk = NULL ) then
		exit function
	end if

	'' END SCOPE
	lexSkipToken( )
	lexSkipToken( )

	fbSetIsScope( stk->scp.lastis_scope )

	''
	if( stk->scopenode <> NULL ) then
		astScopeEnd( stk->scopenode )
	end if

	'' pop from stmt stack
	cCompStmtPop( stk )

	function = TRUE

end function
