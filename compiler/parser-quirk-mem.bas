'' memory operations
''
'' chng: nov/2006 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

'':::::
''cOperatorNew =     NEW DataType|Constructor()
''			   |	 NEW DataType[Expr] .
''
function cOperatorNew _
	( _
		_
	) as ASTNODE ptr

	dim as integer dtype = any, lgt = any
	dim as FBSYMBOL ptr subtype = any, tmp = any
	dim as integer do_clear = TRUE

	'' NEW
	lexSkipToken( )

	dim as AST_OP op = AST_OP_NEW
	dim as ASTNODE ptr elmts_expr = NULL, placement_expr = NULL, i_expr = NULL

	'' '('?
	if( lexGetToken( ) = CHAR_LPRNT ) then
		'' placement new
		placement_expr = cExpression( )
		if( placement_expr = NULL ) then
			return NULL
		end if
	end if

	'' DataType
	hSymbolType( dtype, subtype, lgt )

	'' check for invalid types
	select case as const typeGet( dtype )
	case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
	     FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
		errReport( FB_ERRMSG_NEWCANTBEUSEDWITHSTRINGS, TRUE )
		'' error recovery: fake an expr
		hSkipStmt( )
		return astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end select

	dim as integer has_ctor = FALSE, has_defctor = FALSE

	select case typeGet( dtype )
	case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
		has_ctor = symbGetHasCtor( subtype )
		has_defctor = (symbGetCompDefCtor( subtype ) <> NULL)
	end select

	'' '['?
    if( lexGetToken( ) = CHAR_LBRACKET ) then
        lexSkipToken( )

        elmts_expr = cExpression(  )
        if( elmts_expr = NULL ) then
			errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
        else
        	op = AST_OP_NEW_VEC
        end if

        '' ']'
        if( lexGetToken( ) <> CHAR_RBRACKET ) then
			errReport( FB_ERRMSG_EXPECTEDRBRACKET )
			hSkipUntil( CHAR_RBRACKET )
        else
        	lexSkipToken( )
        end if

		'' '{'?
		if( lexGetToken( ) = CHAR_LBRACE ) then
			lexSkipToken( )

			'' ANY?
			if( lexGetToken( ) = FB_TK_ANY ) then
				if( has_defctor ) then
					errReportWarn( FB_WARNINGMSG_ANYINITHASNOEFFECT )
				end if
				lexSkipToken( )
				do_clear = FALSE
			else
				errReport( FB_ERRMSG_VECTORCANTBEINITIALIZED )
			end if

			'' '}'
			if( lexGetToken( ) <> CHAR_RBRACE ) then
				errReport( FB_ERRMSG_EXPECTEDRBRACKET )
				'' error recovery: skip until next '}'
				hSkipUntil( CHAR_RBRACE, TRUE )
			else
				lexSkipToken( )
			end if
		end if
	end if

	'' not a vector?
	if( elmts_expr = NULL ) then
		elmts_expr = astNewCONSTi( 1, FB_DATATYPE_UINT )
	else
		'' hack(?): make sure it's a uinteger, otherwise it may crash later, fixes bug #2533376 (counting_pine)
		i_expr = astNewCONV( FB_DATATYPE_UINT, NULL, elmts_expr )
		if( i_expr <> NULL ) Then
			elmts_expr = i_expr
		else
			errReport( FB_ERRMSG_TYPEMISMATCH, TRUE )
			elmts_expr = astNewCONSTi( 1, FB_DATATYPE_UINT )
		end if
	end if

	dim as integer is_addr

	if( dtype = FB_DATATYPE_STRUCT ) then
		tmp = symbAddTempVar( typeAddrOf( dtype ), subtype, , FALSE )
		is_addr = TRUE
	else
		'' temp pointer
		tmp = symbAddTempVar( dtype, subtype, , FALSE )
	end if

	'' Constructor?
	dim as ASTNODE ptr ctor_expr = NULL

	if( has_ctor ) then
		'' '('?
		if( lexGetToken( ) = CHAR_LPRNT ) then
			'' ctor + vector? not allowed..
			if( op = AST_OP_NEW_VEC ) then
				errReport( FB_ERRMSG_EXPLICITCTORCALLINVECTOR, TRUE )
			else
				ctor_expr = cCtorCall( subtype )
				if( ctor_expr = NULL ) then
					return NULL
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
					ctor_expr = cCtorCall( subtype )
					if( ctor_expr = NULL ) then
						return NULL
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
				errReport( FB_ERRMSG_VECTORCANTBEINITIALIZED, TRUE )
			end if

			'' ANY?
			if( lexGetLookAhead( 1 ) = FB_TK_ANY ) then
				lexSkipToken( )
				lexSkipToken( )

				do_clear = FALSE

				'' ')'
				if( lexGetToken( ) <> CHAR_RPRNT ) then
					errReport( FB_ERRMSG_EXPECTEDRPRNT )
					'' error recovery: skip until next ')'
					hSkipUntil( CHAR_RPRNT, TRUE )
				else
					lexSkipToken( )
				end if
        	else
				if( is_addr ) then
					ctor_expr = cInitializer( tmp, FB_INIOPT_ISINI or FB_INIOPT_DODEREF )
				else
					ctor_expr = cInitializer( tmp, FB_INIOPT_ISINI )
				end if

        		symbGetStats( tmp ) and= not FB_SYMBSTATS_INITIALIZED

        		if( ctor_expr = NULL ) then
					errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
        		end if
        	end if
        end if

	end if

	''
	dim as ASTNODE ptr expr = any

	expr = astNewMEM( op, _
					  astNewVAR( tmp, _
						  		 0, _
						  		 typeAddrOf( dtype ), _
						  		 subtype ), _
					  elmts_expr, _
					  ctor_expr, _
					  dtype, _
					  subtype, _
					  do_clear, _
					  placement_expr )

	if( expr = NULL ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
	end if

	'' return the pointer
	function = astNewLINK( expr, astNewVAR( tmp, _
	                                        0, _
	                                        typeAddrOf( dtype ), _
	                                        subtype ), FALSE )

end function

'' DELETE ['[]'] expr
sub cOperatorDelete()
	dim as AST_OP op = any
	dim as ASTNODE ptr expr = any, ptr_expr = any

	'' DELETE
	lexSkipToken( )

	op = AST_OP_DEL

	'' '[' ']'?
	if( lexGetToken( ) = CHAR_LBRACKET ) then
		lexSkipToken( )
		op = AST_OP_DEL_VEC
		if( lexGetToken( ) <> CHAR_RBRACKET ) then
			errReport( FB_ERRMSG_EXPECTEDRBRACKET )
			hSkipUntil( CHAR_RBRACKET )
			return
		end if
		lexSkipToken( )
	end if

	ptr_expr = cVarOrDeref( FB_VAREXPROPT_ISEXPR )
	if( ptr_expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		hSkipStmt( )
		return
	end if

	dim as integer dtype = astGetFullType( ptr_expr )
	dim as FBSYMBOL ptr subtype = astGetSubType( ptr_expr )

	'' not a ptr?
	if( typeGet( dtype ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDPOINTER )
		hSkipStmt( )
		return
	end if

	dtype = typeDeref( dtype )

	'' check for ANY ptr
	if( typeGet( dtype ) = FB_DATATYPE_VOID ) then
		errReportWarn( FB_WARNINGMSG_DELETEANYPTR )
	end if

	'' check visibility
	select case typeGet( dtype )
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
		errReport( FB_ERRMSG_INVALIDDATATYPES )
	end if

	astAdd( expr )
end sub
