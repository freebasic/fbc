''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2008 The FreeBASIC development team.
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


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

function cEqInParentsOnlyExpr _
	( _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any

	dim as integer eqinparentsonly = fbGetEqInParentsOnly( )
	fbSetEqInParentsOnly( TRUE )

	expr = cExpression( )

	fbSetEqInParentsOnly( eqinparentsonly )

	return expr

end function

'':::::
''ParentExpression=   '(' Expression ')' .
''
function cParentExpression _
	( _
		_
	) as ASTNODE ptr

	dim as ASTNODE ptr parexpr = any

  	'' '('
  	if( lexGetToken( ) <> CHAR_LPRNT ) then
  		return NULL
  	end if

  	lexSkipToken( )

  	'' ++parent cnt
  	parser.prntcnt += 1

  	dim as integer is_opt = fbGetPrntOptional( )
  	fbSetPrntOptional( FALSE )

  	parexpr = cExpression(  )

  	if( parexpr = NULL ) then
  		'' calling a SUB? it could be a BYVAL or nothing due the optional ()'s
  		if( is_opt ) then
  			return NULL
  		end if

  		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
  			return NULL
  		else
  			'' error recovery: skip until next ')', fake an expr
  			hSkipUntil( CHAR_RPRNT, TRUE )
  			return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
  		end if
    end if

  	'' ')'
  	if( lexGetToken( ) = CHAR_RPRNT ) then
  		lexSkipToken( )
  		'' --parent cnt
  		parser.prntcnt -= 1

  	else
  		'' not calling a SUB or parent cnt = 0?
  		if( (is_opt = FALSE) or (parser.prntcnt = 0) ) then
  			if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
  				return NULL
  			else
  				'' error recovery: skip until next ')'
  				hSkipUntil( CHAR_RPRNT, TRUE )
  			end if
  		end if
  	end if

  	function = parexpr

end function

'':::::
private function hFindId_QB _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr _
	) as ASTNODE ptr

    dim as zstring ptr id = lexGetText( )
    dim as integer suffix = lexGetType( )
    dim as integer defdtype = symbGetDefType( id )

    do
    	dim as FBSYMBOL ptr sym = chain_->sym
    	dim as FBSYMBOL ptr var_sym = NULL

    	'' no suffix?
    	if( suffix = FB_DATATYPE_INVALID ) then

    		do
    			dim as integer is_match = TRUE
    			'' is the original symbol suffixed?
    			if( symbIsSuffixed( sym ) ) then
    				'' if it's a VAR, lookup the default type (last DEF###) in
    				'' the case symbol could not be found..
    				if( symbGetClass( sym ) = FB_SYMBCLASS_VAR ) then
    					if( defdtype = FB_DATATYPE_STRING ) then
	          				select case as const symbGetType( sym )
	          				case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR

	          				case else
	          					is_match = FALSE
	          				end select
    					else
    						is_match = (symbGetType( sym ) = defdtype)
    					end if
    				end if
    			end if

				if( is_match ) then
    				select case as const symbGetClass( sym )
					case FB_SYMBCLASS_CONST
						return cConstantEx( sym )

					case FB_SYMBCLASS_PROC
  						'' if it's a RTL func, the suffix is obligatory
  						if( symbGetIsRTL( sym ) ) then
  							is_match = (symbIsSuffixed( sym ) = FALSE)
  						end if

						if( is_match ) then
							return cFunctionEx( base_parent, sym )
						end if

					case FB_SYMBCLASS_VAR
	           			if( var_sym = NULL ) then
	           				if( symbVarCheckAccess( sym ) ) then
	           					var_sym = sym
	           				end if
	           			end if

  					case FB_SYMBCLASS_KEYWORD
  						'' only if not suffixed
  						if( symbIsSuffixed( sym ) = FALSE ) then
  							return cQuirkFunction( sym )
  						end if

					end select
				end if

				sym = sym->hash.next
			loop while( sym <> NULL )

    	'' suffix..
    	else
    		do
	      		dim as integer is_match = any
	       		if( suffix = FB_DATATYPE_STRING ) then
	          		select case as const symbGetType( sym )
	          		case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR
	          			is_match = TRUE
	          		case else
	          			is_match = FALSE
	          		end select

	          	else
	          		is_match = (symbGetType( sym ) = suffix)

	          	end if

    			if( is_match ) then
    				select case as const symbGetClass( sym )
					case FB_SYMBCLASS_CONST
						return cConstantEx( sym )

					case FB_SYMBCLASS_PROC
						return cFunctionEx( base_parent, sym )

					case FB_SYMBCLASS_VAR
           				if( var_sym = NULL ) then
           					if( symbVarCheckAccess( sym ) ) then
           						var_sym = sym
           					end if
           				end if

  					case FB_SYMBCLASS_KEYWORD
  						return cQuirkFunction( sym )

					end select

				else

					'' Special case for INPUT$()
					if( symbGetClass( sym ) = FB_SYMBCLASS_KEYWORD ) then
						if( sym->key.id = FB_TK_INPUT ) then

							if( suffix = FB_DATATYPE_STRING ) then
								return cQuirkFunction( sym )
							end if

						end if

					end if

				end if

				sym = sym->hash.next
			loop while( sym <> NULL )
		end if

		'' vars have the less priority than keywords and rtl procs
		if( var_sym <> NULL ) then
			return cVariableEx( var_sym, fbGetCheckArray( ) )
		end if

    	chain_ = symbChainGetNext( chain_ )
    loop while( chain_ <> NULL )

    function = NULL

end function

'':::::
private function hFindId _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr _
	) as ASTNODE ptr

    '' QB mode?
    if( env.clopt.lang = FB_LANG_QB ) then
    	return hFindId_QB( base_parent, chain_ )
    end if

    do
    	dim as FBSYMBOL ptr sym = chain_->sym
    	do
    		select case as const symbGetClass( sym )
			case FB_SYMBCLASS_CONST
    			'' check visibility
				if( base_parent <> NULL ) then
					if( symbCheckAccess( base_parent, sym ) = FALSE ) then
						if( errReport( FB_ERRMSG_ILLEGALMEMBERACCESS ) = FALSE ) then
							return astNewCONSTi( 0 )
						end if
					end if
				end if

				return cConstantEx( sym )

			case FB_SYMBCLASS_PROC
				return cFunctionEx( base_parent, sym )

			case FB_SYMBCLASS_VAR
	      		return cVariableEx( chain_, fbGetCheckArray( ) )

       		case FB_SYMBCLASS_FIELD
       			return cImplicitDataMember( chain_, fbGetCheckArray( ) )

  			'' quirk-keyword?
  			case FB_SYMBCLASS_KEYWORD
  				return cQuirkFunction( sym )

			case FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_CLASS
				if( symbGetHasCtor( sym ) ) then
					'' skip ID, ctorCall() is also used by type<>(...)
					lexSkipToken( )
					return cCtorCall( sym )
				end if

			case FB_SYMBCLASS_TYPEDEF
           		'' typedef of a TYPE/CLASS?
           		select case symbGetType( sym )
           		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
					if( symbGetHasCtor( symbGetSubtype( sym ) ) ) then
						'' skip ID, ctorCall() is also used by type<>(...)
						lexSkipToken( )
						return cCtorCall( symbGetSubtype( sym ) )
					end if
           		end select

			end select

			sym = sym->hash.next
		loop while( sym <> NULL )

    	chain_ = symbChainGetNext( chain_ )
    loop while( chain_ <> NULL )

    function = NULL

end function

'':::::
''Atom            =   Constant | Function | QuirkFunction | Variable | Literal .
''
function cAtom _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr _
	) as ASTNODE ptr

  	dim as integer tk_class = any

 	if( chain_ = NULL ) then
  		tk_class = lexGetClass( )
  	else
  		tk_class = FB_TKCLASS_IDENTIFIER
  	end if

  	select case as const tk_class
  	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD, FB_TKCLASS_KEYWORD
  		if( chain_ = NULL ) then
  			chain_ = cIdentifier( base_parent, FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )
  		end if

check_id:
    	'' declared id?
    	if( chain_ <> NULL ) then
    		dim as ASTNODE ptr expr = hFindId( base_parent, chain_ )
    		if( expr <> NULL ) then
    			return expr
    		end if
        end if

		'' error?
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			return NULL
		end if

  		'' try to alloc an implicit variable..
    	if( env.clopt.lang <> FB_LANG_QB ) then
    		if( lexGetClass( ) <> FB_TKCLASS_IDENTIFIER ) then
  				return NULL
  			end if
  		end if

  		if( fbLangOptIsSet( FB_LANG_OPT_IMPLICIT = FALSE ) ) then
  			errReportNotAllowed( FB_LANG_OPT_IMPLICIT, _
  								 FB_ERRMSG_IMPLICITVARSONLYVALIDINLANG )
  			return NULL
  		end if

  		return cVariableEx( cast( FBSYMCHAIN ptr, NULL ), fbGetCheckArray( ) )

  	case FB_TKCLASS_OPERATOR
  		'' QB quirks..
  		if( env.clopt.lang = FB_LANG_QB ) then
  			chain_ = lexGetSymChain( )
  			goto check_id
  		end if

	case FB_TKCLASS_NUMLITERAL
		return cNumLiteral( )

  	case FB_TKCLASS_STRLITERAL
        return cStrLiteral( )

  	case FB_TKCLASS_DELIMITER
		'' '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			return FALSE
		end if

  		'' inside a WITH block?
  		if( parser.stmt.with.sym <> NULL ) then
			'' not '..'?
			if( lexGetLookAhead( 1, LEXCHECK_NOPERIOD ) <> CHAR_DOT ) then
  				return cWithVariable( parser.stmt.with.sym, fbGetCheckArray( ) )
  			end if
  		end if

  		'' global namespace access..
  		chain_ = cIdentifier( base_parent, FB_IDOPT_DEFAULT or FB_IDOPT_ALLOWSTRUCT )
  		if( chain_ <> NULL ) then
  			return hFindId( base_parent, chain_ )
  		end if

  	end select

  	function = NULL

end function

