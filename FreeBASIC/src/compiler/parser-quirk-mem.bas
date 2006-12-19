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


'' memory operations
''
'' chng: nov/2006 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''cOperatorNew =     NEW DataType|Constructor()
''			   |	 NEW DataType[Expr] .
''
function cOperatorNew _
	( _
		byref funcexpr as ASTNODE ptr _
	) as integer

	dim as integer dtype = any, lgt = any, ptrcnt = any
	dim as FBSYMBOL ptr subtype = any, tmp = any
	dim as integer has_ctor = FALSE, do_clear = TRUE


	function = FALSE

	'' NEW
	lexSkipToken( )

	dim as AST_OP op = AST_OP_NEW
	dim as ASTNODE ptr elmts_expr = NULL

	'' DataType
	if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: fake an expr
    		funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		return TRUE
    	end if
	end if

	'' check for invalid types
	select case as const dtype
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
		 FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR

    	if( errReport( FB_ERRMSG_NEWCANTBEUSEDWITHSTRINGS, TRUE ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: fake an expr
    		funcexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		hSkipStmt( )
    		return TRUE
    	end if

	end select

	'' '['?
    if( lexGetToken( ) = CHAR_LBRACKET ) then
        lexSkipToken( )

        if( cExpression( elmts_expr ) = FALSE ) then
        	if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
        		exit function
        	end if
        else
        	op = AST_OP_NEW_VEC
        end if

        '' ']'
        if( lexGetToken( ) <> CHAR_RBRACKET ) then
        	if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
        		exit function
        	else
        		hSkipUntil( CHAR_RBRACKET )
        	end if
        else
        	lexSkipToken( )
        end if

		'' '{'?
		if( lexGetToken( ) = CHAR_LBRACE ) then
			lexSkipToken( )

			'' ANY?
			if( lexGetToken( ) = FB_TK_ANY ) then
				lexSkipToken( )
				do_clear = FALSE
			else
				if( errReport( FB_ERRMSG_VECTORCANTBEINITIALIZED ) = FALSE ) then
					exit function
				end if
			end if

			'' '}'
			if( lexGetToken( ) <> CHAR_RBRACE ) then
				if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
					exit function
				else
					'' error recovery: skip until next '}'
					hSkipUntil( CHAR_RBRACE, TRUE )
				end if
			else
				lexSkipToken( )
			end if
		end if

	end if

	'' not a vector?
	if( elmts_expr = NULL ) then
		elmts_expr = astNewCONSTi( 1, FB_DATATYPE_UINT )
	end if

	'' temp pointer
	tmp = symbAddTempVar( FB_DATATYPE_POINTER + dtype, subtype, , FALSE )

	'' Constructor?
	dim as ASTNODE ptr ctor_expr = NULL

	select case dtype
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		has_ctor = symbGetHasCtor( subtype )
	end select

	if( has_ctor ) then
		'' '('?
		if( lexGetToken( ) = CHAR_LPRNT ) then
			'' ctor + vector? not allowed..
			if( op = AST_OP_NEW_VEC ) then
				if( errReport( FB_ERRMSG_EXPLICITCTORCALLINVECTOR, TRUE ) = FALSE ) then
					exit function
				end if

			else
				if( cCtorCall( subtype, ctor_expr ) = FALSE ) then
					exit function
				end if
			end if

		else
			dim as FBSYMBOL ptr ctor = symbGetCompDefCtor( subtype )
			'' no default ctor?
			if( ctor = NULL ) then
				errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )

			else
				'' only if not a vector
				if( op <> AST_OP_NEW_VEC ) then
					if( cCtorCall( subtype, ctor_expr ) = FALSE ) then
						exit function
					end if
				else
					'' check visibility
					if( symbCheckAccess( subtype, ctor ) = FALSE ) then
						errReport( FB_ERRMSG_NOACCESSTODEFAULTCTOR )
					end if
				end if
			end if
		end if

	else
		'' '('?
		if( lexGetToken( ) = CHAR_LPRNT ) then
			'' vector? not allowed..
			if( op = AST_OP_NEW_VEC ) then
				if( errReport( FB_ERRMSG_VECTORCANTBEINITIALIZED, TRUE ) = FALSE ) then
					exit function
				end if
			end if

			'' ANY?
			if( lexGetLookAhead( 1 ) = FB_TK_ANY ) then
				lexSkipToken( )
				lexSkipToken( )

				do_clear = FALSE

				'' ')'
				if( lexGetToken( ) <> CHAR_RPRNT ) then
					if( errReport( FB_ERRMSG_EXPECTEDRPRNT ) = FALSE ) then
						exit function
					else
						'' error recovery: skip until next ')'
						hSkipUntil( CHAR_RPRNT, TRUE )
					end if
				else
					lexSkipToken( )
				end if

        	else
        		ctor_expr = cInitializer( tmp, FB_INIOPT_ISINI or FB_INIOPT_DODEREF )

        		symbGetStats( tmp ) and= not FB_SYMBSTATS_INITIALIZED

        		if( ctor_expr = NULL ) then
        			if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
        				exit function
        			end if
        		end if
        	end if
        end if

	end if

	''
	dim as ASTNODE ptr expr = any

	expr = astNewMEM( op, _
					  astNewVAR( tmp, _
						  		 0, _
						  		 FB_DATATYPE_POINTER + dtype, _
						  		 subtype ), _
					  elmts_expr, _
					  ctor_expr, _
					  dtype, _
					  subtype, _
					  do_clear )

	if( expr = NULL ) then
    	if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    		exit function
    	end if
	end if

	astAdd( expr )

	'' return the pointer
	funcexpr = astNewVAR( tmp, _
						  0, _
						  FB_DATATYPE_POINTER + dtype, _
						  subtype )

	function = TRUE

end function

'':::::
''cOperatorDelete =     DELETE expr
''				  |		DELETE[] expr .
''
function cOperatorDelete _
	( _
		_
	) as integer

	dim as AST_OP op = any
	dim as ASTNODE ptr expr = any, ptr_expr = any

	function = FALSE

	'' DELETE
	lexSkipToken( )

	op = AST_OP_DEL

	'' '[' ']'?
    if( lexGetToken( ) = CHAR_LBRACKET ) then
        lexSkipToken( )

        op = AST_OP_DEL_VEC

        if( lexGetToken( ) <> CHAR_RBRACKET ) then
       		if( errReport( FB_ERRMSG_EXPECTEDRBRACKET ) = FALSE ) then
       			exit function
       		else
       			hSkipUntil( CHAR_RBRACKET )
       			return TRUE
       		end if
        else
        	lexSkipToken( )
        end if
	end if

	if( cVarOrDeref( ptr_expr ) = FALSE ) then
       	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
       		exit function
       	else
       		hSkipStmt( )
       		return TRUE
       	end if
	end if

	dim as integer dtype = astGetDataType( ptr_expr )
	dim as FBSYMBOL ptr subtype = astGetSubType( ptr_expr )

	if( dtype < FB_DATATYPE_POINTER ) then
       	if( errReport( FB_ERRMSG_EXPECTEDPOINTER ) = FALSE ) then
       		exit function
       	else
       		hSkipStmt( )
       		return TRUE
       	end if
	end if

	dtype -= FB_DATATYPE_POINTER

	'' check visibility
	select case dtype
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		dim as FBSYMBOL ptr dtor = symbGetCompDtor( subtype )

		if( dtor <> NULL ) then
			if( symbCheckAccess( subtype, dtor ) = FALSE ) then
				errReport( FB_ERRMSG_NOACCESSTODTOR )
			end if
		end if
	end select

	expr = astNewMEM( op, _
					  ptr_expr, _
					  NULL, _
					  NULL, _
					  dtype, _
					  subtype, _
					  FALSE )

	if( expr = NULL ) then
    	if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    		exit function
    	end if
	end if

	astAdd( expr )

	function = TRUE

end function
