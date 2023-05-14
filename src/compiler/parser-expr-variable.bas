'' variable parsing (scalars, arrays, fields and anything between)
''
'' chng: sep/2004 written [v1ctor]
''       oct/2004 arrays on fields [v1c]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

declare function cDynamicArrayIndex _
	( _
		byval sym as FBSYMBOL ptr, _
		byval descexpr as ASTNODE ptr _
	) as ASTNODE ptr

private function hIndexExpr( ) as ASTNODE ptr
	dim as ASTNODE ptr expr = any

	expr = cExpressionWithNIDXARRAY( FALSE )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: faken an expr
		expr = astNewCONSTi( 0 )
	end if

	function = expr
end function

private function hCheckIntegerIndex( byval expr as ASTNODE ptr ) as ASTNODE ptr
	'' if index isn't an integer, convert
	select case( typeGet( astGetDataType( expr ) ) )
	case FB_DATATYPE_INTEGER

	case FB_DATATYPE_POINTER
		'' Disallow pointers explicitly, because they can be converted
		'' to integer fine, but we don't want to allow pointers as indices.
		errReport( FB_ERRMSG_INVALIDARRAYINDEX, TRUE )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0 )

	case else
		expr = astNewCONV( FB_DATATYPE_INTEGER, NULL, expr )
		if( expr = NULL ) then
			errReport( FB_ERRMSG_INVALIDARRAYINDEX, TRUE )
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0 )
		end if
	end select

	function = expr
end function

''
'' FixedSizeArrayIndex = '(' Expression (',' Expression)* ')'
''
'' Difference to cDynamicArrayIndex(): Here for static (i.e. fixed-size) arrays
'' we can do compile-time bounds checking, and don't need to have an array
'' descriptor.
''
private function cFixedSizeArrayIndex( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
	dim as ASTNODE ptr expr = any, dimexpr = any
	dim as integer dimension = any
	dim as longint lower = any, upper = any

	dimension = -1
	expr = NULL
	do
		dimension += 1

		'' Too many indices given?
		if( dimension >= symbGetArrayDimensions( sym ) ) then
			errReport( FB_ERRMSG_WRONGDIMENSIONS )
			'' error recovery: fake an expr
			return astNewCONSTi( 0 )
		end if

		lower = symbArrayLbound( sym, dimension )
		upper = symbArrayUbound( sym, dimension )

		'' Expression
		dimexpr = hCheckIntegerIndex( hIndexExpr( ) )

		'' bounds checking
		if( env.clopt.arrayboundchk ) then
			dimexpr = astBuildBOUNDCHK( dimexpr, astNewCONSTi( lower ), astNewCONSTi( upper ) )
			if( dimexpr = NULL ) then
				errReport( FB_ERRMSG_ARRAYOUTOFBOUNDS )
				'' error recovery: fake an expr
				dimexpr = astNewCONSTi( lower )
			end if
		end if

		if( expr = NULL ) then
			expr = dimexpr
		else
			expr = astNewBOP( AST_OP_MUL, expr, astNewCONSTi( upper - lower + 1 ) )
			expr = astNewBOP( AST_OP_ADD, expr, dimexpr )
		end if

		'' ','?
	loop while( hMatch( CHAR_COMMA ) )

	'' Not enough indices given?
	if( dimension < (symbGetArrayDimensions( sym ) - 1) ) then
		errReport( FB_ERRMSG_WRONGDIMENSIONS )
	end if

	'' times length
	expr = astNewBOP( AST_OP_MUL, expr, astNewCONSTi( symbGetLen( sym ) ) )

	function = expr
end function

private function hBuildField _
	( _
		byval varexpr as ASTNODE ptr, _
		byval offsetexpr as ASTNODE ptr, _
		byval fld as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr _
	) as ASTNODE ptr

	varexpr = astNewBOP( AST_OP_ADD, varexpr, offsetexpr )
	varexpr = astNewDEREF( varexpr, dtype, subtype )
	varexpr = astNewFIELD( varexpr, fld )

	function = varexpr
end function

''
'' Plain field access (bitfields are handled later):
''    foo.bar     ->  *cptr( dtype ptr, @foo + offsetof(bar) )
''
'' Fixed-size array fields:
''    foo.bar(i)  ->  *cptr( dtype ptr, @foo + offsetof(bar) + ((i + diff) * sizeof(bar)) )
''
'' Dynamic array fields:
''    foo.bar(i)  ->  descexpr->data[i + descexpr->diff]
''    foo.bar(i)  ->  *cptr( dtype ptr,
''                            *cptr( FB_ARRAYDESC ptr, @foo + offsetof(bar) + offsetof(bar.data) ) +
''                       (i + *cptr( FB_ARRAYDESC ptr, @foo + offsetof(bar) + offsetof(bar.diff) )) )
''
private function hFieldAccess _
	( _
		byval varexpr as ASTNODE ptr, _
		byval fld as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr offsetexpr = any, indexexpr = any, tree = any
	dim as FBSYMBOL ptr desc = any

	offsetexpr = astNewCONSTi( symbGetOfs( fld ) )

	'' If it's an array, then either there must be an index that needs to
	'' be parsed, or we must return NIDXARRAY.
	if( symbGetArrayDimensions( fld ) <> 0 ) then
		'' No '('?
		if( (lexGetToken( ) <> CHAR_LPRNT) or fbGetIdxInParensOnly( ) ) then
			if( check_array ) then
				errReport( FB_ERRMSG_EXPECTEDINDEX )
			end if
			return astNewNIDXARRAY( hBuildField( varexpr, offsetexpr, fld, dtype, subtype ) )
		end if

		'' '()'?
		if( lexGetLookAhead( 1 ) = CHAR_RPRNT ) then
			return hBuildField( varexpr, offsetexpr, fld, dtype, subtype )
		end if

		'' '('
		lexSkipToken( )

		if( symbIsDynamic( fld ) ) then
			'' Dynamic array field; access the descriptor field (same offset)
			desc = symbGetArrayDescriptor( fld )
			varexpr = astNewBOP( AST_OP_ADD, varexpr, offsetexpr )
			varexpr = astNewCONV( typeAddrOf( symbGetFullType( desc ) ), symbGetSubtype( desc ), varexpr, AST_CONVOPT_DONTCHKPTR or AST_CONVOPT_DONTWARNCONST )

			tree = NULL
			if( astHasSideFx( varexpr ) ) then
				tree = astNewLINK( tree, astRemSideFx( varexpr ), AST_LINK_RETURN_RIGHT )
			end if

			indexexpr = cDynamicArrayIndex( fld, astNewDEREF( astCloneTree( varexpr ) ) )

			'' *cptr( dtype ptr, var->descriptor.data + index )
			varexpr = astNewBOP( AST_OP_ADD, varexpr, astNewCONSTi( symb.fbarray_data ) )
			varexpr = astNewCONV( typeMultAddrOf( dtype, 2 ), subtype, varexpr, AST_CONVOPT_DONTCHKPTR or AST_CONVOPT_DONTWARNCONST )
			varexpr = astNewDEREF( varexpr )
			varexpr = astNewBOP( AST_OP_ADD, varexpr, indexexpr )
			varexpr = astNewDEREF( varexpr )

			varexpr = astNewLINK( tree, varexpr, AST_LINK_RETURN_RIGHT )
		else
			'' index + diff
			indexexpr = cFixedSizeArrayIndex( fld )
			indexexpr = astNewBOP( AST_OP_ADD, indexexpr, astNewCONSTi( symbGetArrayDiff( fld ) ) )
			offsetexpr = astNewBOP( AST_OP_ADD, offsetexpr, indexexpr )

			varexpr = hBuildField( varexpr, offsetexpr, fld, dtype, subtype )
		end if

		'' ')'
		if( hMatch( CHAR_RPRNT ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
			'' error recovery: skip until next ')'
			hSkipUntil( CHAR_RPRNT, TRUE )
		end if
	else
		varexpr = hBuildField( varexpr, offsetexpr, fld, dtype, subtype )
	end if

	function = varexpr
end function

'':::::
'' MemberId       =   ID ArrayIdx?
''
private function hMemberId( byval parent as FBSYMBOL ptr, byval allow_inner as integer ) as FBSYMBOL ptr
	dim as FBSYMBOL ptr res = any

	if( parent = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDUDT, TRUE )
		'' no error recovery: caller will take care
		return NULL
	end if

	'' ID?
	select case as const lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' no error recovery: caller will take care
		return NULL
	end select

	res = NULL

	select case( lexGetToken( ) )
	case FB_TK_CONSTRUCTOR
		res = symbGetCompCtorHead( parent )
	case FB_TK_DESTRUCTOR
		res = symbGetCompDtor1( parent )
	end select

	if( res ) then
		return res
	end if

	dim as FBSYMCHAIN ptr chain_ = symbLookupCompField( parent, lexGetText( ) )
	if( chain_ = NULL ) then
		errReportUndef( FB_ERRMSG_ELEMENTNOTDEFINED, lexGetText( ) )
		'' no error recovery: caller will take care
		lexSkipToken( )
		return NULL
	end if

	'' symbLookupCompField()) which calls symbLookupAt() was
	'' called with an explicit parent, so we should expect
	'' that locals and params and any other symbols that shouldn't
	'' be access through parent are already filtered out.  So
	'' we can just return the first symbol found without searching
	'' through any extra symbols or chains.

	dim as FBSYMBOL ptr sym = chain_->sym

	select case as const symbGetClass( sym )
	'' field, static members, or inner types?
	case FB_SYMBCLASS_FIELD, FB_SYMBCLASS_VAR, _
	     FB_SYMBCLASS_CONST, FB_SYMBCLASS_ENUM

		'' Check visibility of member
		if( symbCheckAccess( sym ) = FALSE ) then
			errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
		end if

	case FB_SYMBCLASS_STRUCT, FB_SYMBCLASS_TYPEDEF, FB_SYMBCLASS_FWDREF
		if( allow_inner = FALSE ) then
			errReportUndef( FB_ERRMSG_ELEMENTNOTDEFINED, lexGetText( ) )
			'' no error recovery: caller will take care
			lexSkipToken( )
			return NULL
		end if

	'' method?
	case FB_SYMBCLASS_PROC

	case else
		errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
		return NULL
	end select

	return sym

end function

'':::::
'' UdtMember       =   MemberId ('.' MemberId)*
''
function cUdtMember _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval varexpr as ASTNODE ptr, _
		byval check_array as integer, _
		byval options as FB_PARSEROPT _
	) as ASTNODE ptr

	'' note: assuming a pointer is being passed to this function
	dim as integer is_ptr = TRUE, mask = typeGetConstMask( dtype )

	do
		dim as FBSYMBOL ptr fld = hMemberId( subtype, FALSE )
		if( fld = NULL ) then
			return NULL
		end if

		select case as const symbGetClass( fld )
		'' const? (enum elmts too), exit
		case FB_SYMBCLASS_CONST
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			astDeltree( varexpr )
			return astBuildConst( fld )

		'' enum?
		case FB_SYMBCLASS_ENUM
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			astDeltree( varexpr )
			varexpr = NULL

			'' '.'?
			if( lexGetToken( ) <> CHAR_DOT ) then
				return NULL
			end if

		'' field?
		case FB_SYMBCLASS_FIELD
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' make sure the field inherits the parent's constant mask
			dtype = symbGetFullType( fld ) or mask
			subtype = symbGetSubType( fld )

			if( is_ptr = FALSE ) then
				varexpr = astNewADDROF( varexpr )
			end if

			varexpr = hFieldAccess( varexpr, fld, dtype, subtype, check_array )

			'' Only continue if the field was an UDT and there's a '.' following
			if( (typeGetDtAndPtrOnly( dtype ) <> FB_DATATYPE_STRUCT) or _
			    (lexGetToken( ) <> CHAR_DOT) or _
			    astIsNIDXARRAY( varexpr ) ) then
				return varexpr
			end if

			is_ptr = FALSE

		'' static var?
		case FB_SYMBCLASS_VAR
			astDelTree( varexpr )
			varexpr = cVariableEx( fld, check_array )

			'' make sure the field inherits the parent's constant mask
			dtype = symbGetFullType( fld ) or mask
			subtype = symbGetSubType( fld )

			select case typeGet( dtype )
			case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
				if( lexGetToken( ) <> CHAR_DOT ) then
					return varexpr
				end if

			case else
				return varexpr
			end select

			is_ptr = FALSE

		'' method?
		case FB_SYMBCLASS_PROC
			if( is_ptr ) then
				varexpr = astNewDEREF( varexpr, dtype, subtype )
			end if

			return cMethodCall( fld, varexpr, options )

		case else
			errReportEx( FB_ERRMSG_INTERNAL, __FUNCTION__ )
			return NULL
		end select

		lexSkipToken( LEXCHECK_NOPERIOD or LEXCHECK_POST_SUFFIX )
	loop

	function = varexpr
end function

'':::::
'' UdtTypeMember       =   ('.' MemberId)*
''
sub cUdtTypeMember _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint, _
		byref is_fixlenstr as integer, _
		byref ret_sym as FBSYMBOL ptr = NULL _
	)

	'' UDT type followed by '.'?
	while( lexGetToken( ) = CHAR_DOT )
		if( typeGetDtOnly( dtype ) <> FB_DATATYPE_STRUCT ) then
			exit while
		end if

		'' '.'
		lexSkipToken( LEXCHECK_NOPERIOD )

		'' check member field, See also hLenSizeof()
		dim sym as FBSYMBOL ptr = hMemberId( subtype, TRUE )

		if( sym ) then
			'' ID
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			ret_sym = sym

			'' Struct? must be a type and could be followed by '.' member access
			if( symbGetClass( sym ) = FB_SYMBCLASS_STRUCT ) then
				subtype = sym
			else
				dtype = symbGetFullType( sym )
				subtype = symbGetSubType( sym )
			end if

			lgt = symbGetLen( sym )
			is_fixlenstr = symbGetIsFixLenStr( sym )

			'' const string? get the size from the constant string value
			if( symbGetClass( sym ) = FB_SYMBCLASS_CONST ) then
				select case( typeGetDtAndPtrOnly( dtype ) )
				case FB_DATATYPE_WCHAR, FB_DATATYPE_CHAR, FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR
					is_fixlenstr = TRUE
					lgt = symbGetLen( symbGetConstStr( sym ) )
					exit while
				end select
			end if
		else
			exit while

		end if
	wend
end sub

'':::::
function cMemberAccess _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr _
	) as ASTNODE ptr

	'' proc call?
	if( astIsCALL( expr ) ) then
		expr = astBuildCallResultUdt( expr )
	end if

	'' build: cast( udt ptr, (cast( byte ptr, @udt) + fldexpr))->field
	function = cUdtMember( dtype, subtype, astNewADDROF( expr ), TRUE )

end function

'':::::
private function hStrIndexing _
	( _
		byval dtype as integer, _
		byval varexpr as ASTNODE ptr, _
		byval idxexpr as ASTNODE ptr _
	) as ASTNODE ptr

	'' string concatenation is delayed because optimizations..
	varexpr = astUpdStrConcat( varexpr )

	'' function deref?
	if( astIsCALL( varexpr ) ) then
		'' not allowed, STRING and WCHAR results are temporary
		errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
	end if

	if( typeGet( dtype ) = FB_DATATYPE_STRING ) then
		'' deref
		varexpr = astBuildStrPtr( varexpr )
	else
		'' address of
		varexpr = astNewADDROF( varexpr )
	end if

	'' add index
	if( typeGet( dtype ) = FB_DATATYPE_WCHAR ) then
		'' times sizeof( wchar ) if it's wstring
		idxexpr = astNewBOP( AST_OP_MUL, idxexpr, _
		                     astNewCONSTi( typeGetSize( FB_DATATYPE_WCHAR ) ) )
	end if

	'' null pointer checking
	if( env.clopt.arrayboundchk ) then
		varexpr = astBuildPTRCHK( varexpr )
	end if

	varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )

	'' wstring?
	if( typeGet( dtype ) = FB_DATATYPE_WCHAR ) then
		dtype = typeJoin( dtype, env.target.wchar )
	else
		dtype = typeJoin( dtype, FB_DATATYPE_UBYTE )
	end if

	'' make a pointer
	function = astNewDEREF( varexpr, dtype, NULL )

end function

'' '*'*
private function hMultiDeref( ) as integer
	dim as integer derefs
	while( lexGetToken( ) = FB_TK_DEREFCHAR )
		lexSkipToken( LEXCHECK_NOPERIOD )
		derefs += 1
	wend
	function = derefs
end function

'':::::
''MemberDeref   =   (('->' DREF* | '[' Expression ']' '.'?) UdtMember)* .
''
function cMemberDeref _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval varexpr as ASTNODE ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	dim as integer derefcnt = any
	dim as longint lgt = any
	dim as ASTNODE ptr idxexpr = any

	function = NULL

	do
		idxexpr = NULL

		select case( lexGetToken( ) )
		'' ('->' DREF* UdtMember)*
		case FB_TK_FIELDDEREF
			derefcnt = 0

			if( typeIsPtr( dtype ) ) then
				'' '->'
				lexSkipToken( LEXCHECK_NOPERIOD )
				dtype = typeDeref( dtype )

				select case( typeGetDtAndPtrOnly( dtype ) )
				'' incomplete type?
				case FB_DATATYPE_VOID, FB_DATATYPE_FWDREF
					errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE )
					dtype = FB_DATATYPE_INTEGER
					subtype = NULL

				case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS

				case else
					errReport( FB_ERRMSG_INVALIDDATATYPES, TRUE )
					dtype = FB_DATATYPE_INTEGER
					subtype = NULL
				end select

				if( env.clopt.nullptrchk ) then
					varexpr = astBuildPTRCHK( varexpr )
				end if

				'' DREF*
				derefcnt += hMultiDeref( )

				'' UdtMember
				varexpr = cUdtMember( dtype, subtype, varexpr, check_array )
			else
				'' check op overloading
				if( symb.globOpOvlTb(AST_OP_FLDDEREF).head = NULL ) then
					errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
					exit do
				end if

				dim as FBSYMBOL ptr proc = any
				dim as FB_ERRMSG err_num = any

				proc = symbFindUopOvlProc( AST_OP_FLDDEREF, varexpr, @err_num )
				if( proc = NULL ) then
					errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
					exit do
				end if

				'' build a proc call
				varexpr = astBuildCall( proc, varexpr )
				if( varexpr = NULL ) then
					exit function
				end if

				'' '->'
				lexSkipToken( LEXCHECK_NOPERIOD )

				'' DREF*
				derefcnt += hMultiDeref( )

				'' MemberAccess
				varexpr = cMemberAccess( astGetFullType( varexpr ), _
				                         astGetSubType( varexpr ), varexpr )
			end if

			if( varexpr = NULL ) then
				exit function
			end if

			'' non-indexed array?
			if( astIsNIDXARRAY( varexpr ) ) then
				if( derefcnt > 0 ) then
					errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
				end if

				exit do
			end if

			dtype = astGetFullType( varexpr )
			subtype = astGetSubType( varexpr )

			if( derefcnt > 0 ) then
				varexpr = astBuildMultiDeref( derefcnt, varexpr, dtype, subtype )
				if( varexpr = NULL ) then
					exit function
				end if

				dtype = astGetFullType( varexpr )
				subtype = astGetSubType( varexpr )
			end if

		'' '['
		case CHAR_LBRACKET
			lexSkipToken( )

			'' Expression
			idxexpr = hIndexExpr( )

			'' ']'
			if( lexGetToken( ) <> CHAR_RBRACKET ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
				'' error recovery: skip until next ']'
				hSkipUntil( CHAR_RBRACKET, TRUE )
			else
				lexSkipToken( )
			end if

			select case( typeGetDtAndPtrOnly( dtype ) )
			'' string, fixstr, w|zstring? In that case '[]' means string indexing, not MemberDeref.
			case FB_DATATYPE_STRING, FB_DATATYPE_FIXSTR, _
			     FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
				varexpr = hStrIndexing( dtype, varexpr, hCheckIntegerIndex( idxexpr ) )
				idxexpr = NULL

				dtype = astGetFullType( varexpr )
				subtype = astGetSubType( varexpr )

			'' [] overloaded for UDT?
			case FB_DATATYPE_STRUCT
				dim as FB_ERRMSG err_num = any
				var proc = symbFindSelfBopOvlProc( AST_OP_PTRINDEX, varexpr, idxexpr, @err_num )
				if( proc ) then
					varexpr = astBuildCall( proc, varexpr, idxexpr )
					if( varexpr = NULL ) then
						exit function
					end if
				else
					if( err_num = FB_ERRMSG_OK ) then
						errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
					end if
				end if

				'' '.'?
				if( lexGetToken( ) = CHAR_DOT ) then
					lexSkipToken( LEXCHECK_NOPERIOD )

					'' member access on overloaded []'s return type must be UDT
					if( astGetDataType( varexpr ) <> FB_DATATYPE_STRUCT ) then
						errReport( FB_ERRMSG_EXPECTEDUDT, TRUE )
						exit function
					end if

					'' MemberAccess
					varexpr = cMemberAccess( astGetFullType( varexpr ), _
					                         astGetSubType( varexpr ), varexpr )
					if( varexpr = NULL ) then
						exit function
					end if

					'' non-indexed array?
					if( astIsNIDXARRAY( varexpr ) ) then
						exit do
					end if
				end if

				dtype = astGetFullType( varexpr )
				subtype = astGetSubType( varexpr )

			case else
				select case( typeGetDtAndPtrOnly( dtype ) )
				'' Incomplete type? (nicer error message)
				case FB_DATATYPE_VOID, FB_DATATYPE_FWDREF
					errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE )
					dtype = typeAddrOf( FB_DATATYPE_INTEGER )
					subtype = NULL

				case else
					if( typeIsPtr( dtype ) = FALSE ) then
						errReport( FB_ERRMSG_EXPECTEDPOINTER, TRUE )
						exit do
					end if
				end select

				'' Determine sizeof(...)
				dtype = typeDeref( dtype )
				lgt = symbCalcLen( dtype, subtype )
				if( lgt = 0 ) then
					errReport( FB_ERRMSG_INCOMPLETETYPE, TRUE )
					dtype = FB_DATATYPE_INTEGER
					subtype = NULL
					lgt = typeGetSize( FB_DATATYPE_INTEGER )
				end if

				'' For the normal ptr[index] operation, the index must be an INTEGER
				idxexpr = hCheckIntegerIndex( idxexpr )

				'' null pointer checking
				if( env.clopt.nullptrchk ) then
					varexpr = astBuildPTRCHK( varexpr )
				end if

				'' ptr[index]  =>  ptr + (index * sizeof(*ptr))
				'' (DEREF added later below, so we can pass the pointer to cUdtMember() first if needed)
				varexpr = astNewBOP( AST_OP_ADD, varexpr, _
				                     astNewBOP( AST_OP_MUL, idxexpr, astNewCONSTi( lgt ) ) )

				'' '.'?
				if( lexGetToken( ) = CHAR_DOT ) then
					'' A . member access can only follow a [] ptr index operation if the type now is a UDT
					if( typeGetDtAndPtrOnly( dtype ) <> FB_DATATYPE_STRUCT ) then
						errReport( FB_ERRMSG_INVALIDDATATYPES )
						exit do
					end if
					lexSkipToken( LEXCHECK_NOPERIOD )

					varexpr = cUdtMember( dtype, subtype, varexpr, check_array )
					if( varexpr = NULL ) then
						exit function
					end if

					'' non-indexed array?
					if( astIsNIDXARRAY( varexpr ) ) then
						exit do
					end if

					dtype = astGetFullType( varexpr )
					subtype = astGetSubType( varexpr )
				else
					varexpr = astNewDEREF( varexpr, dtype, subtype )
				end if

			end select

		'' '.'?
		case CHAR_DOT
			if( typeIsPtr( dtype ) ) then
				errReport( FB_ERRMSG_EXPECTEDUDT, TRUE )
			end if

			exit do

		'' Only processing -> and [] here...
		case else
			exit do
		end select
	loop

	function = varexpr
end function

'':::::
''FuncPtrOrDeref    =   FuncPtr '(' Args? ')'
''                  |   MemberDeref .
''
function cFuncPtrOrMemberDeref _
	( _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval expr as ASTNODE ptr, _
		byval isfuncptr as integer, _
		byval checkarray as integer _
	) as ASTNODE ptr

	function = NULL

	''
	if( isfuncptr = FALSE ) then
		'' MemberDeref?
		expr =  cMemberDeref( dtype, subtype, expr, checkarray )
		if( expr = NULL ) then
			exit function
		end if

		dtype = astGetDataType( expr )
		subtype = astGetSubType( expr )

		'' check for functions called through pointers
		if( lexGetToken( ) = CHAR_LPRNT ) then
			if( dtype = typeAddrOf( FB_DATATYPE_FUNCTION ) ) then
				isfuncptr = TRUE
			end if
		end if
	end if

	'' function pointer dref? call it
	if( isfuncptr = FALSE ) then
		return expr
	end if

	'' null pointer checking
	if( env.clopt.nullptrchk ) then
		expr = astBuildPTRCHK( expr )
	end if

	'' function?
	if( symbGetType( subtype ) <> FB_DATATYPE_VOID ) then
		expr = cFunctionCall( NULL, subtype, expr )
		if( expr = NULL ) then
			exit function
		end if

	'' sub..
	else
		if( fbGetIsExpression( ) = FALSE ) then
			expr = cProcCall( NULL, subtype, expr )
		else
			errReport( FB_ERRMSG_SYNTAXERROR )
			'' error recovery: fake an expr
			expr = astNewCONSTi( 0 )
		end if
	end if

	function = expr

end function

'' DynamicArrayIndex = '(' Expression (',' Expression)* ')'
private function cDynamicArrayIndex _
	( _
		byval sym as FBSYMBOL ptr, _
		byval descexpr as ASTNODE ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr expr = any, dimexpr = any
	dim as integer dimension = any
	dim as longint dimoffset = any

	assert( astHasSideFx( descexpr ) = FALSE )

	dimension = -1
	expr = NULL
	do
		dimension += 1
		dimoffset = symb.fbarray_dimtb + (dimension * symbGetLen( symb.fbarraydim ))

		'' Expression
		dimexpr = hCheckIntegerIndex( hIndexExpr( ) )

		'' bounds checking
		if( env.clopt.arrayboundchk ) then
			dimexpr = astBuildBOUNDCHK( dimexpr, _
			                            astBuildDerefAddrOf( astCloneTree( descexpr ), dimoffset + symb.fbarraydim_lbound, FB_DATATYPE_INTEGER, NULL ), _
			                            astBuildDerefAddrOf( astCloneTree( descexpr ), dimoffset + symb.fbarraydim_ubound, FB_DATATYPE_INTEGER, NULL ) )
			assert( dimexpr )
		end if

		if( expr = NULL ) then
			expr = dimexpr
		else
			'' times desc(i).elements
			expr = astNewBOP( AST_OP_MUL, expr, astBuildDerefAddrOf( astCloneTree( descexpr ), dimoffset, FB_DATATYPE_INTEGER, NULL ) )
			expr = astNewBOP( AST_OP_ADD, expr, dimexpr )
		end if

		'' ','?
	loop while( hMatch( CHAR_COMMA ) )

	'' times length
	expr = astNewBOP( AST_OP_MUL, expr, astNewCONSTi( symbGetLen( sym ) ) )

	'' No longer needed, all places using it should have cloned
	astDelTree( descexpr )

	if( symbGetIsDynamic( sym ) ) then
		symbCheckDynamicArrayDimensions( sym, dimension + 1 )
	end if

	function = expr
end function

'':::::
private function hVarAddUndecl _
	( _
		byval id as zstring ptr, _
		byval dtype as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any
	dim as FBARRAYDIM dTB(0) = any
	dim as integer attrib = any, options = any
	dim as ASTNODE ptr var_ = any

	function = NULL

	if( symbGetProcStaticLocals( parser.currproc ) ) then
		attrib = FB_SYMBATTRIB_STATIC
	else
		attrib = 0

		'' inside a namespace but outside a proc?
		if( symbIsGlobalNamespc( ) = FALSE ) then
			if( fbIsModLevel( ) ) then
				if( (attrib and (FB_SYMBATTRIB_SHARED or _
				                 FB_SYMBATTRIB_COMMON or _
				                 FB_SYMBATTRIB_PUBLIC or _
				                 FB_SYMBATTRIB_EXTERN)) = 0 ) then

					'' they are never allocated on stack..
					attrib or= FB_SYMBATTRIB_STATIC
				end if
			end if
		end if

	end if

	'' no suffix?
	if( dtype = FB_DATATYPE_INVALID ) then
		dtype = symbGetDefType( id )
	else
		attrib or= FB_SYMBATTRIB_SUFFIXED
	end if

	options = 0

	'' respect scopes?
	if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
		'' deprecated quirk: not inside an explicit SCOPE .. END SCOPE block?
		if( fbGetIsScope( ) = FALSE ) then
			options or= FB_SYMBOPT_UNSCOPE
		end if

	'' no scopes..
	else
		options or= FB_SYMBOPT_UNSCOPE
	end if

	s = symbAddVar( id, NULL, dtype, NULL, 0, 0, dTB(), attrib, options )
	if( s = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		'' error recovery: fake an id
		s = symbAddVar( symbUniqueLabel( ), NULL, dtype, NULL, 0, 0, dTB(), attrib, options )
	else
		var_ = astNewDECL( s, TRUE )

		'' move to function scope?
		if( (options and FB_SYMBOPT_UNSCOPE) <> 0 ) then
			astAddUnscoped( var_ )
		'' respect the scope..
		else
			astAdd( var_ )
		end if
	end if

	function = s
end function

private function hMakeArrayIdx( byval sym as FBSYMBOL ptr ) as ASTNODE ptr
	'' argument passed by descriptor?
	if( symbIsParamVarByDesc( sym ) ) then
		'' return descriptor->data
		return astNewDEREF( astNewVAR( sym, 0, FB_DATATYPE_INTEGER ), _
		                    FB_DATATYPE_INTEGER, NULL, symb.fbarray_data )
	end if

	'' dynamic array? (this will handle common's too)
	if( symbIsDynamic( sym ) ) then
		'' return descriptor.data
		return astNewVAR( symbGetArrayDescriptor( sym ), _
		                  symb.fbarray_data, FB_DATATYPE_INTEGER )
	end if

	'' static array, return lbound( array )
	assert( symbGetArrayDimensions( sym ) > 0 )
	function = astNewCONSTi( symbArrayLbound( sym, 0 ) )
end function

'':::::
''Variable        =   ID ArrayIdx? UdtMember? FuncPtrOrMemberDeref? .
''
function cVariableEx overload _
	( _
		byval sym as FBSYMBOL ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	dim as ASTNODE ptr varexpr = any, idxexpr = any, descexpr = any
	dim as integer is_byref = any, is_funcptr = any, is_array = any

	function = NULL

	assert( symbIsVar( sym ) )

	'' Check visibility of the variable
	if( symbCheckAccess( sym ) = FALSE ) then
		errReport( FB_ERRMSG_ILLEGALMEMBERACCESS )
	end if

	'' ID
	lexSkipToken( LEXCHECK_POST_LANG_SUFFIX )

	is_byref = symbIsParamVarByRef( sym ) or symbIsImport( sym ) or symbIsRef( sym )
	is_array = symbIsArray( sym )
	is_funcptr = FALSE

	varexpr = NULL
	idxexpr = NULL

	dim as integer check_fields = TRUE, is_nidxarray = FALSE

	'' check for '()', it's not an array, just passing bydesc
	if( (lexGetToken( ) = CHAR_LPRNT) and (not fbGetIdxInParensOnly( )) ) then
		if( lexGetLookAhead( 1 ) <> CHAR_RPRNT ) then
			'' ArrayIdx?
			if( is_array ) then
				'' '('
				lexSkipToken( )

				'' dynamic/bydescparam array var?
				if( symbGetIsDynamic( sym ) ) then
					if( symbIsParamVarBydesc( sym ) ) then
						'' Build a VAR access with the BYDESC param's real dtype
						descexpr = astNewVAR( sym )
						assert( symbIsStruct( sym->var_.array.desctype ) and symbIsDescriptor( sym->var_.array.desctype ) )
						astSetType( descexpr, typeAddrOf( FB_DATATYPE_STRUCT ), sym->var_.array.desctype )

						'' And DEREF to get to the descriptor
						descexpr = astNewDEREF( descexpr )
					else
						descexpr = astNewVAR( symbGetArrayDescriptor( sym ) )
					end if

					idxexpr = cDynamicArrayIndex( sym, astCloneTree( descexpr ) )

					'' plus desc.data (= ptr + diff)
					idxexpr = astNewBOP( AST_OP_ADD, idxexpr, _
					                     astBuildDerefAddrOf( descexpr, symb.fbarray_data, FB_DATATYPE_INTEGER, NULL ) )
				else
					idxexpr = cFixedSizeArrayIndex( sym )
				end if

				'' ')'
				if( hMatch( CHAR_RPRNT ) = FALSE ) then
					errReport( FB_ERRMSG_EXPECTEDRPRNT )
					'' error recovery: skip until next ')'
					hSkipUntil( CHAR_RPRNT, TRUE )
				end if
			else
				'' check if calling functions through pointers
				is_funcptr = (symbGetType( sym ) = typeAddrOf( FB_DATATYPE_FUNCTION ))

				'' using (...) with scalars?
				if( (is_array = FALSE) and (is_funcptr = FALSE) ) then
					errReport( FB_ERRMSG_ARRAYNOTALLOCATED, TRUE )
					'' error recovery: skip the index
					lexSkipToken( )
					hSkipUntil( CHAR_RPRNT, TRUE )
				end if
			end if
		else
			'' array? could be a func ptr call too..
			if( is_array ) then
				check_fields = FALSE
			end if
		end if
	else
		'' array and no index?
		if( is_array ) then
			if( check_array ) then
				errReport( FB_ERRMSG_EXPECTEDINDEX, TRUE )
				'' error recovery: fake an index
				idxexpr = hMakeArrayIdx( sym )
			else
				check_fields = FALSE
				is_nidxarray = TRUE
			end if
		end if
	end if

	varexpr = astNewVAR( sym )

	assert( varexpr->dtype = iif( is_byref, typeAddrOf( sym->typ ), sym->typ ) )
	assert( varexpr->subtype = sym->subtype )

	'' array or index?
	if( idxexpr <> NULL ) then
		'' byref or imports are already pointers
		if( is_byref ) then
			varexpr = astNewBOP( AST_OP_ADD, varexpr, idxexpr )
		else
			varexpr = astNewIDX( varexpr, idxexpr )
		end if
	end if

	'' check arguments passed by reference (implicit pointers)
	if( is_byref ) then
		varexpr = astNewDEREF( varexpr )
	end if

	assert( varexpr->dtype = sym->typ )
	assert( varexpr->subtype = sym->subtype )

	if( is_funcptr = FALSE ) then
		if( check_fields ) then
			'' ('.' UdtMember)?
			if( lexGetToken( ) = CHAR_DOT ) then

				if( astGetDataType( varexpr ) <> FB_DATATYPE_STRUCT ) then
					errReport( FB_ERRMSG_EXPECTEDUDT, TRUE )
					hSkipStmt( )
					return varexpr
				end if

				lexSkipToken( LEXCHECK_NOPERIOD )

				varexpr = cUdtMember( varexpr->dtype, varexpr->subtype, astNewADDROF( varexpr ), check_array )
				if( varexpr = NULL ) then
					exit function
				end if

				'' non-indexed array?
				if( astIsNIDXARRAY( varexpr ) ) then
					return varexpr
				end if

				'' check if calling functions through pointers
				if( lexGetToken( ) = CHAR_LPRNT ) then
					is_funcptr = (astGetDataType( varexpr ) = typeAddrOf( FB_DATATYPE_FUNCTION ))
				end if

			end if
		end if
	end if

	if( check_fields ) then
		'' FuncPtrOrMemberDeref?
		varexpr = cFuncPtrOrMemberDeref( varexpr->dtype, varexpr->subtype, varexpr, is_funcptr, check_array )
	else
		if( is_nidxarray ) then
			varexpr = astNewNIDXARRAY( varexpr )
		end if
	end if

	function = varexpr

end function

'':::::
''Variable        =   ID .
''
function cVariableEx _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	dim as zstring ptr id = any
	dim as integer suffix = any
	dim as FBSYMBOL ptr sym = any

	id = lexGetText( )
	suffix = lexGetType( )

	if( env.clopt.lang = FB_LANG_QB ) then
		'' keyword with no suffix?  Then it can't be a variable
		if( lexGetClass( ) = FB_TKCLASS_KEYWORD ) then
			if( suffix = FB_DATATYPE_INVALID ) then
				return NULL
			end if
		end if
	end if

	if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) ) then
		'' no suffix? lookup the default type (last DEF###) in the
		'' case symbol could not be found..
		if( suffix = FB_DATATYPE_INVALID ) then
			sym = symbFindVarByDefType( chain_, symbGetDefType( id ) )
		else
			sym = symbFindVarBySuffix( chain_, suffix )
		end if

	else
		if( suffix <> FB_DATATYPE_INVALID ) then
			lexCheckToken( LEXCHECK_POST_LANG_SUFFIX )
			suffix = lexGetType()
		end if

		sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
	end if

	if( sym = NULL ) then
		if( env.opt.explicit ) then
			errReportUndef( FB_ERRMSG_VARIABLENOTDECLARED, id )
			'' Error recovery in -lang fb: don't declare the variable implicitly;
			'' hVarAddUndecl() assumes other dialects by using FB_SYMBOPT_UNSCOPE.
			return NULL
		end if

		'' don't allow explicit namespaces
		if( chain_ <> NULL ) then
			if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) ) then
				'' variable?
				sym = symbFindByClass( chain_, FB_SYMBCLASS_VAR )
				if( sym <> NULL ) then
					'' from a different namespace?
					if( symbGetNamespace( sym ) <> symbGetCurrentNamespc( ) ) then
						errReport( FB_ERRMSG_DECLOUTSIDENAMESPC )
					end if
				end if
			end if
		end if

		'' add undeclared variable
		sym = hVarAddUndecl( id, suffix )
		if( sym = NULL ) then
			return NULL
		end if

		'' show warning if inside an expression (ie: var was never set)
		if( fbGetIsExpression( ) ) then
			if( fbLangOptIsSet( FB_LANG_OPT_SCOPE ) ) then
				if( env.opt.explicit = FALSE ) then
					errReportWarn( FB_WARNINGMSG_IMPLICITALLOCATION, id )
				end if
			end if
		end if

	end if

	function = cVariableEx( sym, check_array )

end function

private function hImpField _
	( _
		byval this_ as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval check_array as integer, _
		byval is_ptr as integer, _
		byval options as FB_PARSEROPT _
	) as ASTNODE ptr

	dim as ASTNODE ptr varexpr = any

	if( is_ptr ) then
		varexpr = astNewVAR( this_, , typeAddrOf( dtype ), subtype )
	else
		varexpr = astNewADDROF( astNewVAR( this_, , dtype, subtype ) )
	end if

	varexpr = cUdtMember( dtype, subtype, varexpr, check_array, options )

	if( varexpr = NULL ) then
		return NULL
	end if

	'' non-indexed array?
	if( astIsNIDXARRAY( varexpr ) ) then
		return varexpr
	end if

	dtype = astGetFullType( varexpr )
	subtype = astGetSubType( varexpr )

	'' check if calling functions through pointers
	dim as integer is_funcptr = FALSE
	if( lexGetToken( ) = CHAR_LPRNT ) then
		is_funcptr = (typeGetDtAndPtrOnly( dtype ) = typeAddrOf( FB_DATATYPE_FUNCTION ))
	end if

	'' FuncPtrOrMemberDeref?
	function = cFuncPtrOrMemberDeref( dtype, subtype, varexpr, is_funcptr, check_array )

end function

''  WithVariable  = '.' UdtMember FuncPtrOrMemberDeref? .
function cWithVariable( byval check_array as integer ) as ASTNODE ptr
	dim as FBSYMBOL ptr sym = any
	dim as integer dtype = any

	'' '.'
	lexSkipToken( LEXCHECK_NOPERIOD )

	sym = parser.stmt.with->with.sym
	dtype = symbGetFullType( sym )
	if( parser.stmt.with->with.is_ptr ) then
		dtype = typeDeref( dtype )
	end if

	function = hImpField( sym, dtype, symbGetSubtype( sym ), check_array, _
	                      parser.stmt.with->with.is_ptr, 0 )
end function

'':::::
''Variable        =   '.'? ID ArrayIdx? UdtMember? FuncPtrOrMemberDeref? .
''
function cVariable _
	( _
		byval chain_ as FBSYMCHAIN ptr, _
		byval check_array as integer _
	) as ASTNODE ptr

	'' ID
	select case lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD
		return cVariableEx( chain_, check_array )

	case else
		if( parser.stmt.with = NULL ) then
			return NULL
		end if

		'' '.'?
		if( lexGetToken( ) <> CHAR_DOT ) then
			return NULL
		end if

		return cWithVariable( check_array )
	end select

end function

'':::::
''ImplicitDataMember    =   UdtMember? FuncPtrOrMemberDeref? .
''
function cImplicitDataMember _
	( _
		byval base_parent as FBSYMBOL ptr, _
		byval chain_ as FBSYMCHAIN ptr, _
		byval check_array as integer, _
		byval options as FB_PARSEROPT _
	) as ASTNODE ptr

	dim as FBSYMBOL ptr this_ = NULL

	dim as FBSYMBOL ptr param = symbGetProcHeadParam( parser.currproc )
	if( symbIsMethod( parser.currproc ) and (param <> NULL) ) then
		this_ = symbGetParamVar( param )
	end if

	if( this_ = NULL ) then
		errReport( FB_ERRMSG_STATICMEMBERHASNOINSTANCEPTR )
		return NULL
	end if

	if( base_parent = NULL ) then
		base_parent = symbGetSubtype( this_ )
	End If

	function = hImpField( this_, symbGetFullType( this_ ), base_parent, _
	                      check_array, TRUE, options )

end function

'' cVarOrDeref = Deref | PtrTypeCasting | AddrOf | Variable
function cVarOrDeref _
	( _
		byval options as FB_VAREXPROPT _
	) as ASTNODE ptr

	dim as integer last_isexpr = any, check_array = any

	if( options and FB_VAREXPROPT_ISEXPR ) then
		last_isexpr = fbGetIsExpression( )
		fbSetIsExpression( TRUE )
	end if
	check_array = fbGetCheckArray( )
	fbSetCheckArray( ((options and FB_VAREXPROPT_NOARRAYCHECK) = 0) )

	dim as ASTNODE ptr expr = cHighestPrecExpr( NULL, NULL )

	fbSetCheckArray( check_array )
	if( options and FB_VAREXPROPT_ISEXPR ) then
		fbSetIsExpression( last_isexpr )
	end if

	if( expr <> NULL ) then
		dim as ASTNODE ptr t = any
		if( options and FB_VAREXPROPT_ALLOWALLCASTS ) then
			'' Allow all casts - used for function calls where result is ignored
			t = astSkipCASTs( expr )
		else
			'' Allow noconv casts on the lhs of assignments.
			t = astSkipNoConvCAST( expr )
		end if

		dim as integer complain = TRUE

		select case as const astGetClass( t )
		case AST_NODECLASS_VAR, AST_NODECLASS_IDX, _
		     AST_NODECLASS_FIELD, AST_NODECLASS_DEREF
			complain = FALSE

		case AST_NODECLASS_CALL, AST_NODECLASS_NIDXARRAY
			complain = ((options and FB_VAREXPROPT_ISASSIGN) <> 0)

		end select

		if( complain ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
			astDelTree( expr )
			expr = NULL
			'' no error recovery: caller will take care
		end if
	end if

	function = expr

end function
