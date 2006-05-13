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


'' atomic and parentheses expression parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''ParentExpression=   '(' Expression ')' .
''
function cParentExpression _
	( _
		byref parexpr as ASTNODE ptr _
	) as integer

  	function = FALSE

  	'' '('
  	if( hMatch( CHAR_LPRNT ) = FALSE ) then
  		exit function
  	end if

  	'' ++parent cnt
  	env.prntcnt += 1

  	if( cExpression( parexpr ) = FALSE ) then
  		'' calling a SUB? it can be a BYVAL or nothing due the optional ()'s
  		if( env.prntopt = FALSE ) then
  			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
  			exit function
  		end if

  	else
  		'' ')'
  		if( hMatch( CHAR_RPRNT ) ) then
  			'' --parent cnt
  			env.prntcnt -= 1
  		else
  			'' not calling a SUB or parent cnt = 0?
  			if( (env.prntopt = FALSE) or (env.prntcnt = 0) ) then
  				hReportError( FB_ERRMSG_EXPECTEDRPRNT )
  				exit function
  			end if
  		end if

  		function = TRUE
  	end if

end function

'':::::
''Atom            =   Constant | Function | QuirkFunction | Variable | Literal .
''
function cAtom _
	( _
		byref atom as ASTNODE ptr _
	) as integer

  	atom = NULL

  	select case as const lexGetClass( )
  	case FB_TKCLASS_KEYWORD
  		return cQuirkFunction( cIdentifier( )->sym, atom )

  	case FB_TKCLASS_IDENTIFIER
    	dim as FBSYMBOL ptr sym
    	dim as FBSYMCHAIN ptr chain_

  		chain_ = cIdentifier( )
    	if( chain_ <> NULL ) then
    		do
    			sym = chain_->sym
    			select case symbGetClass( sym )
				case FB_SYMBCLASS_CONST
					return cConstantEx( sym, atom )

				case FB_SYMBCLASS_PROC
					return cFunctionEx( sym, atom )

				case FB_SYMBCLASS_VAR
                	return cVariableEx( chain_, atom, env.checkarray )

				case FB_SYMBCLASS_ENUM
					'' '.'?
					if( lexGetLookAhead( 1 ) = CHAR_DOT ) then
                		return cEnumConstant( sym, atom )
                	end if

				end select

    			chain_ = symbChainGetNext( chain_ )
    		loop while( chain_ <> NULL )

    	else
			if( hGetLastError( ) <> FB_ERRMSG_OK ) then
				return FALSE
			end if

  			return cVariableEx( NULL, atom, env.checkarray )
  		end if

	case FB_TKCLASS_NUMLITERAL
		return cNumLiteral( atom )

  	case FB_TKCLASS_STRLITERAL
        return cStrLiteral( atom, env.opt.escapestr )

  	case FB_TKCLASS_DELIMITER
		select case lexGetToken( )
		'' '.'?
		case CHAR_DOT
  			if( env.stmt.with.sym <> NULL ) then
  				return cWithVariable( env.stmt.with.sym, atom, env.checkarray )
  			end if

  		'' '$'?
  		case CHAR_DOLAR
  			'' literal string?
  			if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_STRLITERAL ) then
  				lexSkipToken( )
  				return cStrLiteral( atom, FALSE )
  			end if
  		end select
  	end select

  	function = FALSE

end function

