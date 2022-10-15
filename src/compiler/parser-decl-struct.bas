'' structures (TYPE or UNION) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

declare sub hTypeBody( byval s as FBSYMBOL ptr )

declare sub hPatchByvalParamsToSelf _
	( _
		byval parent as FBSYMBOL ptr _
	)

declare sub hPatchByvalResultToSelf _
	( _
		byval parent as FBSYMBOL ptr _
	)

private sub hBeginNesting( byval parent as FBSYMBOL ptr )
	if( symbGetIsUnique( parent ) = FALSE ) then
		'' must be unique
		symbSetIsUnique( parent )

		'' start nesting
		symbNestBegin( parent, FALSE )
	end if
end sub

''
'' TypeProtoDecl =
''    DECLARE
''    (STATIC?
''      | CONST? (VIRTUAL|ABSTRACT)?)
''    (CONSTRUCTOR|DESTRUCTOR CtorHeader
''      | OPERATOR OperatorHeader
''      | PROPERTY PropertyHeader
''      | SUB|FUNCTION ProcHeader)
''    .
''
private sub hTypeProtoDecl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB _
	)

	dim as integer is_nested = any, tk = any
	dim as FB_PROCATTRIB pattrib = FB_PROCATTRIB_NONE

	'' anon?
	if( symbGetUDTIsAnon( parent ) ) then
		errReport( FB_ERRMSG_METHODINANONUDT )
		'' error recovery: skip stmt
		hSkipStmt( )
		exit sub
	end if

	'' methods not allowed?
	if( fbLangOptIsSet( FB_LANG_OPT_CLASS ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_CLASS )
	end if

	hBeginNesting( parent )

	'' DECLARE
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	cMethodAttributes( parent, attrib, pattrib )

	tk = lexGetToken( )
	select case( tk )
	case FB_TK_CONSTRUCTOR
		hDisallowStaticAttrib( attrib, pattrib )
		hDisallowVirtualCtor( attrib, pattrib )
		hDisallowConstCtorDtor( tk, attrib, pattrib )
	case FB_TK_DESTRUCTOR
		hDisallowStaticAttrib( attrib, pattrib )
		hDisallowAbstractDtor( attrib, pattrib )
		hDisallowConstCtorDtor( tk, attrib, pattrib )
	case FB_TK_PROPERTY
		hDisallowStaticAttrib( attrib, pattrib )
	end select

	select case( tk )
	case FB_TK_SUB, FB_TK_FUNCTION, _
	     FB_TK_CONSTRUCTOR, FB_TK_DESTRUCTOR, _
	     FB_TK_OPERATOR, FB_TK_PROPERTY

		lexSkipToken( LEXCHECK_POST_SUFFIX )

		cProcHeader( attrib, pattrib, is_nested, _
		             FB_PROCOPT_ISPROTO or FB_PROCOPT_HASPARENT, tk )

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip stmt
		hSkipStmt( )
	end select
end sub

'' TypeEnumDecl  =  ENUM|CONST ...
private sub hTypeEnumDecl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval tk as integer, _
		byval attrib as integer _
	)

	'' anon?
	if( symbGetUDTIsAnon( parent ) ) then
		errReport( FB_ERRMSG_CONSTINANONUDT )
		'' error recovery: skip stmt
		hSkipStmt( )
		exit sub
	end if

	hBeginNesting( parent )

	if( tk = FB_TK_CONST ) then
		cConstDecl( attrib )
	else
		cEnumDecl( attrib )
	end if

end sub

private sub hSetFieldInitree( byval sym as FBSYMBOL ptr, byval initree as ASTNODE ptr )
	if( initree ) then
		'' Disallow references to local vars, except for temp vars/descriptors
		if( astTypeIniUsesLocals( initree, FB_SYMBATTRIB_TEMP or FB_SYMBATTRIB_DESCRIPTOR ) ) then
			errReport( FB_ERRMSG_INVALIDREFERENCETOLOCAL, TRUE )
			'' error recovery
			astDelTree( initree )
			initree = NULL
		end if
	end if

	'' No temp dtors should be left registered after the TYPEINI build-up
	assert( astDtorListIsEmpty( ) )

	'' Remove bitfields from the AST's bitfield counter - the field
	'' initializer will never be astAdd()ed itself, only cloned.
	astForgetBitfields( initree )

	if( initree ) then
		symbSetTypeIniTree( sym, initree )
	end if
end sub

private sub hFieldInit _
	( _
		byval parent as FBSYMBOL ptr, _
		byval sym as FBSYMBOL ptr, _
		byval boundstypeini as ASTNODE ptr _
	)

	dim as FBSYMBOL ptr defctor = any, subtype = any

	'' '=' | '=>' ?
	if( hIsAssignToken( lexGetToken( ) ) = FALSE ) then
		'' No initializer

		'' Check ctors/dtors
		if( sym ) then
			if( symbGetType( sym ) = FB_DATATYPE_STRUCT ) then
				subtype = symbGetSubtype( sym )

				'' Does it have any constructors? (Then we must call one to initialize this field)
				if( symbGetCompCtorHead( subtype ) ) then
					'' Does it have a default constructor?
					defctor = symbGetCompDefCtor( subtype )
					if( defctor ) then
						'' Check visibility of the default constructor
						if( symbCheckAccess( defctor ) = FALSE ) then
							errReport( FB_ERRMSG_NOACCESSTODEFAULTCTOR )
						end if
					else
						'' It has constructors, but no default one -- we cannot initialize it
						errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
					end if
				end if

				'' Does it have a destructor?
				defctor = symbGetCompDtor1( subtype )
				if( defctor ) then
					'' Check visibility of the default constructor
					if( symbCheckAccess( defctor ) = FALSE ) then
						errReport( FB_ERRMSG_NOACCESSTODTOR )
					end if
				end if
			end if
		end if

		if( boundstypeini ) then
			symbSetUDTHasInitedField( parent )
			hBeginNesting( parent )
			hSetFieldInitree( sym, boundstypeini )
		end if

		exit sub
	end if

	if( fbLangOptIsSet( FB_LANG_OPT_INITIALIZER ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_INITIALIZER )
		'' error recovery: skip
		hSkipUntil( FB_TK_EOL )
		exit sub
	end if

	if( sym <> NULL ) then
		'' union or anon?
		if( symbGetUDTIsUnionOrAnon( parent ) ) then
			errReport( FB_ERRMSG_CTORINUNION )
			'' error recovery: skip
			hSkipUntil( FB_TK_EOL )
			exit sub
		end if
	end if

	'' '=' | '=>'
	lexSkipToken( )

	if( sym = NULL ) then
		'' error recovery: skip stmt
		hSkipStmt( )
		exit sub
	end if

	'' Field initializers are only used in constructors (replacing the
	'' implicit default initialization), so we make sure to add a default
	'' constructor, if no constructor was specified.
	symbSetUDTHasInitedField( parent )

	'' ANY?
	if( lexGetToken( ) = FB_TK_ANY ) then
		'' don't allow var-len strings
		if( symbGetType( sym ) = FB_DATATYPE_STRING ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
		else
			symbSetDontInit( sym )
		end if

		lexSkipToken( LEXCHECK_POST_SUFFIX )
		exit sub
	end if

	hBeginNesting( parent )
	hSetFieldInitree( sym, cInitializer( sym, FB_INIOPT_ISINI ) )
end sub

private sub hFieldType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as longint _
	)

	'' SymbolType
	hSymbolType( dtype, subtype, lgt )

	'' check that field type is not a parent struct namespace
	if( symbIsParentNamespace( dtype, subtype ) ) then
		errReport( FB_ERRMSG_INVALIDDATATYPES )
		'' error recovery: fake a type
		dtype = FB_DATATYPE_INTEGER
		subtype = NULL
		lgt = typeGetSize( dtype )
	end if

	'' Disallow creating objects of abstract classes
	hComplainIfAbstractClass( dtype, subtype )

end sub

private sub hArrayOrBitfield _
	( _
		byval token as integer, _
		byref attrib as integer, _
		byref bits as integer, _
		byref dims as integer, _
		dTB() as FBARRAYDIM, _
		byref boundstypeini as ASTNODE ptr _
	)

	static as ASTNODE ptr exprTB(0 to FB_MAXARRAYDIMS-1, 0 to 1)
	dim as integer have_bounds = any

	bits = 0
	dims = 0
	have_bounds = FALSE
	boundstypeini = NULL

	'' '('? (array dimensions)
	if( hMatch( CHAR_LPRNT ) ) then
		'' Note: '()' only is not allowed for fields; '(any)' or
		'' '(any, any)' etc should be used instead. '()' is only needed
		'' for variables due to backwards compatibility.

		'' For dynamic array fields, there may be initial bounds given
		'' in the field declaration. We want to REDIM the field to those
		'' initial dimensions, which must be done in the UDT's
		'' constructor(s), just like with other field initializers.
		'' Because the bound expressions may be complex (not just
		'' constants), we need to use a temp scope to capture temp vars
		'' etc., as done for normal field initializers, and the bound
		'' expressions and their temp vars must be duplicated into every
		'' constructor body (astTypeIniClone()).
		''
		'' Thus, we're building a TYPEINI tree that takes care of the
		'' temp scope stuff, and then use that to hold the expressions
		'' from the exprTB(), such that hCallFieldCtors() can build the
		'' REDIM CALL from that later.
		''
		'' How about building the REDIM here?
		'' - We can't build the REDIM right here because it requires the
		''   field symbol which isn't created yet.
		'' - We could build it in hFieldInit(), but then we'd have to
		''   build an empty TYPEINI here or insert some kind of
		''   place-holder expression, and then insert the REDIM CALL
		''   into the TYPEINI later.
		'' - When building the REDIM here, we'd have to use a fake field
		''   access, because only hCallFieldCtors() can build the full
		''   array field access based on the constructor's THIS pointer.
		''   It'd have to replace the fake arg with the real one. We'd
		''   also have to separate the REDIM CALL build-up from the
		''   rtlErrorCheck() it uses, so that hCallFieldCtors() could
		''   more easily find the REDIM CALL in the expression tree.
		''
		'' If it turns out that this is not a dynamic array, we simply
		'' delete the TYPEINI.

		boundstypeini = astTypeIniBegin( FB_DATATYPE_INTEGER, NULL, FALSE, 0 )

		cArrayDecl( dims, have_bounds, exprTB() )

		if( have_bounds ) then
			'' No ellipsis allowed, neither fixed-size nor dynamic array fields
			hComplainAboutEllipsis( dims, exprTB(), FB_ERRMSG_ARRAYFIELDWITHELLIPSIS )

			hMaybeConvertExprTb2DimTb( attrib, dims, exprTB(), dTB() )

			'' Not using the dTB()? (still dynamic?)
			if( attrib and FB_SYMBATTRIB_DYNAMIC ) then
				'' Store the bounds into the TYPEINI
				for i as integer = 0 to dims - 1
					astTypeIniAddAssign( boundstypeini, exprTB(i,0), NULL, FB_DATATYPE_INTEGER )
					astTypeIniAddAssign( boundstypeini, exprTB(i,1), NULL, FB_DATATYPE_INTEGER )
				next
			end if
		else
			'' No bounds
			attrib or= FB_SYMBATTRIB_DYNAMIC
		end if

		astTypeIniEnd( boundstypeini, TRUE )

		if( (not have_bounds) or ((attrib and FB_SYMBATTRIB_DYNAMIC) = 0) ) then
			astDelTree( boundstypeini )
			boundstypeini = NULL
		end if

		'' ')'
		if( lexGetToken( ) <> CHAR_RPRNT ) then
			errReport( FB_ERRMSG_EXPECTEDRPRNT )
		else
			lexSkipToken( )
		end if
	else
		'' REDIM? Must have array dimensions
		if( token = FB_TK_REDIM ) then
			errReport( FB_ERRMSG_EXPECTEDARRAY )
			dims = -1
		end if
	end if

	'' ':' NUMLIT? (bitfield size)
	if( lexGetToken( ) = FB_TK_STMTSEP ) then
		if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_NUMLITERAL ) then
			lexSkipToken( )
			bits = clng( *lexGetText( ) )
			lexSkipToken( )

			if( (bits <= 0) or (dims <> 0) ) then
				errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
				'' error recovery: no bits
				bits = 0
			end if
		end if
	end if

end sub

private function hAddAndInitField _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval dims as integer, _
		dTB() as FBARRAYDIM, _
		byval boundstypeini as ASTNODE ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval lgt as longint, _
		byval bits as integer, _
		byval attrib as FB_SYMBATTRIB _
	) as integer

	dim as FBSYMBOL ptr sym = any

	function = FALSE

	'' array?
	if( dims > 0 ) then
		'' "array too big" check
		if( symbCheckArraySize( dims, @dTB(0), lgt, FALSE ) = FALSE ) then
			errReport( FB_ERRMSG_ARRAYTOOBIG )
			'' error recovery: use small array
			dims = 1
			dTB(0).lower = 0
			dTB(0).upper = 0
		end if
	end if

	if( bits > 0 ) then
		if( symbCheckBitField( parent, dtype, lgt, bits ) = FALSE ) then
			errReport( FB_ERRMSG_INVALIDBITFIELD, TRUE )
			'' error recovery: no bits
			bits = 0
		end if
	end if

	'' ref to self?
	if( dtype = FB_DATATYPE_STRUCT ) then
		if( subtype = parent ) then
			errReport( FB_ERRMSG_RECURSIVEUDT )
			'' error recovery: fake type
			dtype = FB_DATATYPE_INTEGER
			subtype = NULL
			lgt = 0
		end if
	end if

	sym = symbAddField( parent, id, dims, dTB(), dtype, subtype, lgt, bits, attrib )
	if( sym = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		exit function
	end if

	if( attrib and FB_SYMBATTRIB_DYNAMIC ) then
		hComplainAboutConstDynamicArray( sym )
	end if

	'' Initializer?
	hFieldInit( parent, sym, boundstypeini )

	function = TRUE
end function

private function hFieldId( byval parent as FBSYMBOL ptr ) as zstring ptr
	static as zstring * FB_MAXNAMELEN+1 id

	'' allow keywords as field names
	select case( lexGetClass( ) )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
		'' Disallow type suffixes on fields
		if( lexGetType( ) <> FB_DATATYPE_INVALID ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if

		'' contains a period?
		if( lexGetPeriodPos( ) > 0 ) then
			errReport( FB_ERRMSG_CANTINCLUDEPERIODS )
		end if

		'' but don't allow keywords if it's an object (because the implicit inst. ptr)
		if( lexGetClass( ) = FB_TKCLASS_KEYWORD ) then
			if( symbGetIsUnique( parent ) ) then
				errReport( FB_ERRMSG_KEYWORDFIELDSNOTALLOWEDINCLASSES )
			else
				symbSetUDTHasKwdField( parent )
			end if
		end if

		id = *lexGetText( )
		'' don't report on suffix, was already checked above
		lexSkipToken( )

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake an id
		id = *symbUniqueLabel( )
	end select

	function = @id
end function

''
'' FieldSymbol =
''    Identifier [ArrayDimensions | ':' BitfieldSize] ['=' InitializerExpression]
''
'' TypeMultElementDecl =
''    AS SymbolType FieldSymbol (',' FieldSymbol)*
''
private sub hTypeMultElementDecl _
	( _
		byval token as integer, _
		byval parent as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB _
	)

	static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
	dim as zstring ptr id = any
	dim as FBSYMBOL ptr subtype = any
	dim as integer dtype = any, bits = any, dims = any, fieldattrib = any
	dim as longint lgt = any
	dim as ASTNODE ptr boundstypeini = any

	'' AS SymbolType
	lexSkipToken( LEXCHECK_POST_SUFFIX )
	hFieldType( dtype, subtype, lgt )

	do
		fieldattrib = attrib

		'' Identifier
		id = hFieldId( parent )

		'' [ArrayDimensions | ':' BitfieldSize]
		hArrayOrBitfield( token, fieldattrib, bits, dims, dTB(), boundstypeini )

		'' symbAddField()
		'' ['=' InitializerExpression]
		hAddAndInitField( parent, id, dims, dTB(), boundstypeini, dtype, subtype, lgt, bits, fieldattrib )

		'' ','?
	loop while( hMatch( CHAR_COMMA ) )

end sub

''
'' TypeElementDecl =
''    Identifier [ArrayDimensions | ':' BitfieldSize] AS SymbolType ['=' InitializerExpression]
''
private sub hTypeElementDecl _
	( _
		byval token as integer, _
		byval parent as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB _
	)

	static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
	dim as zstring ptr id = any
	dim as FBSYMBOL ptr subtype = any
	dim as integer dtype = any, bits = any, dims = any
	dim as longint lgt = any
	dim as ASTNODE ptr boundstypeini = any

	'' Identifier
	id = hFieldId( parent )

	'' [ArrayDimensions | ':' BitfieldSize]
	hArrayOrBitfield( token, attrib, bits, dims, dTB(), boundstypeini )

	'' AS SymbolType
	if( lexGetToken( ) <> FB_TK_AS ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
	else
		lexSkipToken( LEXCHECK_POST_SUFFIX )
	end if
	hFieldType( dtype, subtype, lgt )

	'' symbAddField()
	'' ['=' InitializerExpression]
	hAddAndInitField( parent, id, dims, dTB(), boundstypeini, dtype, subtype, lgt, bits, attrib )
end sub

private sub hFieldDeclWithExplicitDim _
	( _
		byval token as integer, _
		byval s as FBSYMBOL ptr, _
		byval attrib as integer _
	)

	'' DIM|REDIM
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' multi-decl?
	if( lexGetToken( ) = FB_TK_AS ) then
		hTypeMultElementDecl( token, s, attrib )
	else
		hTypeElementDecl( token, s, attrib )
	end if

end sub

sub hTypeStaticVarDecl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval attrib as integer _
	)

	'' Disallow Static member vars inside anonymous UDTs
	if( symbGetUDTIsAnon( parent ) ) then
		errReport( FB_ERRMSG_STATICVARINANONUDT )
		'' error recovery: skip stmt
		hSkipStmt( )
		exit sub
	end if

	'' The UDT becomes a "class"
	hBeginNesting( parent )

	symbSetUdtHasStaticVar( parent )

	'' Static member variables are really EXTERNs,
	'' the corresponding DIM must be present in one (and only one) module.
	''
	'' This is necessary to avoid duplicating the static var in every
	'' module that sees the UDT declaration, otherwise the static var
	'' wouldn't be shared between different modules, and each had its own.
	''
	'' Unfortunately this means the static var cannot be initialized
	'' at its declaration in the TYPE compound, only at the DIM later.

	attrib or= FB_SYMBATTRIB_EXTERN or _
	           FB_SYMBATTRIB_SHARED or _
	           FB_SYMBATTRIB_STATIC

	cVarDecl( attrib, FALSE, FB_TK_EXTERN, FALSE )

end sub

private function hTypeAdd _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval isunion as integer, _
		byval align as integer, _
		byval baseDType as integer = 0, _
		byval baseSubtype as FBSYMBOL ptr = NULL, _
		byval baseStringType as integer = 0 _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any

	s = symbStructBegin( NULL, NULL, parent, id, id_alias, isunion, align, (baseSubtype <> NULL), 0, 0 )
	if( s = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		'' error recovery: create a fake symbol
		s = symbStructBegin( NULL, NULL, parent, symbUniqueLabel( ), NULL, isunion, align, (baseSubtype <> NULL), 0, 0 )
	end if

	select case baseStringType
	case FB_DATATYPE_CHAR
		symbSetUdtIsZstring( s )
	case FB_DATATYPE_WCHAR
		symbSetUdtIsWstring( s )
	end select

	if( baseSubtype ) then
		symbStructAddBase( s, baseSubtype )
	end if

	'' Comment? SttSeparator
	cComment( )

	'' emit the current line in text form
	hEmitCurrLine( )

	if( cStmtSeparator( ) = FALSE ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip until next line or stmt
		hSkipUntil( INVALID, TRUE )
	end if

	'' TypeBody
	hTypeBody( s )

	'' finalize
	symbStructEnd( s, symbGetIsUnique( s ) )

	'' END TYPE|UNION
	if( lexGetToken( ) <> FB_TK_END ) then
		errReport( FB_ERRMSG_EXPECTEDENDTYPE )
		'' error recovery: skip until next stmt
		hSkipStmt( )
	else
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		if( lexGetToken( ) <> iif( isunion, FB_TK_UNION, FB_TK_TYPE ) ) then
			errReport( FB_ERRMSG_EXPECTEDENDTYPE )
			'' error recovery: skip until next stmt
			hSkipStmt( )
		else
			lexSkipToken( LEXCHECK_POST_SUFFIX )
		end if
	end if

	function = s
end function

'' [FIELD '=' ConstExpression]
private function cFieldAlignmentAttribute( ) as integer
	'' FIELD
	if( lexGetToken( ) <> FB_TK_FIELD ) then
		return 0
	end if

	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' '='
	if( cAssignToken( ) = FALSE ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
	end if

	'' ConstExpression
	dim as ASTNODE ptr expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0 )
	end if

	if( astIsCONST( expr ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDCONST )
		'' error recovery: fake an expr
		astDelTree( expr )
		expr = astNewCONSTi( 0 )
	end if

	'' follow the GCC 3.x ABI
	var align = astConstFlushToInt( expr )
	if( align < 0 ) then
		align = 0
	elseif( align > env.pointersize ) then
		align = 0
	elseif( align = 3 ) then
		align = 2
	end if

	function = align
end function

'' TypeBody  =
''  (     (UNION|TYPE Comment? SttSeparator
''             ElementDecl
''         END UNION|TYPE)
''     |  ElementDecl
''     |  AS AsElementDecl )+ .
''
private sub hTypeBody( byval s as FBSYMBOL ptr )
	dim as integer isunion = any
	dim as FB_SYMBATTRIB attrib = any
	dim as FBSYMBOL ptr inner = any

	attrib = FB_SYMBATTRIB_NONE  '' Used to hold visibility attributes

	do
		select case as const lexGetToken( )
		'' visibility?
		case FB_TK_PRIVATE, FB_TK_PUBLIC, FB_TK_PROTECTED
			if( symbGetUDTIsUnion( s ) ) then
				errReport( FB_ERRMSG_SYNTAXERROR )
			end if

			select case lexGetToken( )
			case FB_TK_PUBLIC
				attrib = FB_SYMBATTRIB_NONE
			case FB_TK_PRIVATE
				attrib = FB_SYMBATTRIB_VIS_PRIVATE
			case FB_TK_PROTECTED
				attrib = FB_SYMBATTRIB_VIS_PROTECTED
			end select

			lexSkipToken( LEXCHECK_POST_SUFFIX )

			'' ':'
			if( lexGetToken( ) <> FB_TK_STMTSEP ) then
				errReport( FB_ERRMSG_EXPECTEDSTMTSEP )
			end if

			'' ':' will be skipped bellow to allow stmt separators

		'' single-line comment?
		case FB_TK_COMMENT, FB_TK_REM
			cComment( )

		'' newline?
		case FB_TK_EOL
			lexSkipToken( )
			continue do

		'' EOF?
		case FB_TK_EOF
			exit do

		'' END?
		case FB_TK_END
			'' isn't it a field called "end"?
			select case lexGetLookAhead( 1 )
			case FB_TK_AS, CHAR_LPRNT, FB_TK_STMTSEP
				hTypeElementDecl( FB_TK_DIM, s, attrib )

			'' it's not a field, exit
			case else
				exit do

			end select

		'' (TYPE|UNION)?
		case FB_TK_TYPE, FB_TK_UNION
			'' isn't it a field called TYPE|UNION?
			select case as const lexGetLookAhead( 1 )
			case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENT, FB_TK_REM, _
			     FB_TK_FIELD

decl_inner:
				'' it's an anonymous inner UDT
				isunion = lexGetToken( ) = FB_TK_UNION
				if( symbGetUDTIsUnion( s ) = isunion ) then
					errReport( FB_ERRMSG_SYNTAXERROR )
					'' error recovery: fake type
					isunion = not isunion
				end if

				lexSkipToken( LEXCHECK_POST_SUFFIX )

				'' [FIELD '=' ConstExpression]
				dim as integer align = cFieldAlignmentAttribute( )
				if( align = 0 ) then
					align = symbGetUDTAlign( s )
				end if

				'' create a "temp" one
				inner = hTypeAdd( s, symbUniqueId( ), NULL, isunion, align )

				if( isunion ) then
					symbSetUDTIsUnion( inner )
					symbSetUDTHasAnonUnion( s )
				end if

				'' walk through all the anon UDT's symbols, and
				'' promote their attributes from the root
				dim as FBSYMBOL ptr walkSymbols = symbGetUDTSymbTbHead( inner )
				do while( walkSymbols <> NULL )
					symbGetAttrib( walkSymbols ) or= attrib
					walkSymbols = symbGetNext( walkSymbols )
				loop

				'' insert it into the parent UDT
				symbInsertInnerUDT( s, inner )

			'' ambiguity: can be a stmt separator or bitfield
			case FB_TK_STMTSEP
				'' not a bitfield? separator..
				if( lexGetLookAheadClass( 2 ) <> FB_TKCLASS_NUMLITERAL ) then
					goto decl_inner
				end if

				'' bitfield..
				hTypeElementDecl( FB_TK_DIM, s, attrib )

			'' it's a field, parse it, 'AS' is a reserved word
			'' so it's probably OK we don't allow 'TYPE AS' to start
			'' an inner type declaration and instead expect this is
			'' going to be 'TYPE AS <datatype>'
			case FB_TK_AS
				hTypeElementDecl( FB_TK_DIM, s, attrib )

			'' Otherwise TYPE|UNION maybe starts an inner declaration
			case else
				'' Inside an anonymous type|union?  Don't allow named types
				if( symbIsStruct( s ) andalso symbGetUDTIsAnon( s ) ) then
					hTypeElementDecl( FB_TK_DIM, s, attrib )

				'' allow named UNION|TYPE to be nested in another UNION|TYPE
				else
					hBeginNesting( s )
					symbSetUdtHasNested( s )
					cTypeDecl( attrib )

				end if

			end select

		'' AS?
		case FB_TK_AS
			'' it's a multi-declaration
			hTypeMultElementDecl( FB_TK_DIM, s, attrib )

		case FB_TK_DECLARE
			hTypeProtoDecl( s, attrib )

		case FB_TK_ENUM, FB_TK_CONST
			hTypeEnumDecl( s, lexGetToken( ), attrib )

		case FB_TK_DIM
			hFieldDeclWithExplicitDim( FB_TK_DIM, s, attrib )

		case FB_TK_REDIM
			hFieldDeclWithExplicitDim( FB_TK_REDIM, s, attrib or FB_SYMBATTRIB_DYNAMIC )

		case FB_TK_STATIC
			'' Static member variable
			lexSkipToken( LEXCHECK_POST_SUFFIX )

			hTypeStaticVarDecl( s, attrib )

		'' anything else, must be a field
		case else
			hTypeElementDecl( FB_TK_DIM, s, attrib )

		end select

		'' Comment?
		cComment( )

		'' emit the current line in text form
		hEmitCurrLine( )

		if( cStmtSeparator( ) = FALSE ) then
			errReport( FB_ERRMSG_EXPECTEDEOL )
			'' error recovery: skip until next line or stmt
			hSkipUntil( INVALID, TRUE )
		end if
	loop

	'' no fields added?
	if( symbUdtGetFirstField( s ) = NULL ) then
		errReport( FB_ERRMSG_NOELEMENTSDEFINED )
	end if
end sub

private sub hDisallowNestedClasses( byval sym as FBSYMBOL ptr )
	dim as FBSYMBOL ptr member = any
	'' Not at module level?
	if( parser.scope > FB_MAINSCOPE ) then
		'' Shouldn't allow any member procedures - they couldn't be
		'' implemented since we don't allow nested procedures.
		'' (Note: assuming symbStructEnd() was already called,
		'' thus any implicit members were already added by
		'' symbUdtDeclareDefaultMembers())
		'' Similar for static member variables (really Externs); normal
		'' Externs aren't allowed in scopes either.
		member = symbGetCompSymbTb( sym ).head
		while( member )
			if( symbIsProc( member ) ) then
				errReportEx( FB_ERRMSG_NOOOPINFUNCTIONS, symbGetName( member ) )
			elseif( symbIsVar( member ) and symbIsExtern( member ) ) then
				errReportEx( FB_ERRMSG_NOSTATICMEMBERVARINNESTEDUDT, symbGetName( member ) )
			end if
			member = member->next
		wend
	end if
end sub

'' TypeDecl  =
''  TYPE|UNION ID (ALIAS LITSTR)? (EXTENDS SymbolType)? (FIELD '=' Expression)?
''      TypeLine+
''  END (TYPE|UNION) .
sub cTypeDecl( byval attrib as FB_SYMBATTRIB )

	dim as zstring * FB_MAXNAMELEN+1 id
	dim as integer isunion = any, checkid = any
	dim as FBSYMBOL ptr sym = any
	dim as FB_CMPSTMTSTK ptr stk = any

	isunion = (lexGetToken( ) = FB_TK_UNION)

	'' TYPE|UNION
	lexSkipToken( LEXCHECK_POST_SUFFIX )

	'' ID
	checkid = TRUE
	select case as const lexGetClass( )
	case FB_TKCLASS_IDENTIFIER

	case FB_TKCLASS_KEYWORD
		if( isunion = FALSE ) then
			'' AS?
			if( lexGetToken( ) = FB_TK_AS ) then
				'' (Note: the typedef parser will skip the AS)
				cTypedefMultDecl( attrib )
				exit sub
			end if
		end if

		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake an ID
		checkid = FALSE

	case FB_TKCLASS_QUIRKWD

	case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake an ID
		checkid = FALSE
	end select

	if( checkid ) then
		'' Namespace identifier if it matches the current namespace
		cCurrentParentId()

		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
				if( lexGetPeriodPos( ) > 0 ) then
					errReport( FB_ERRMSG_CANTINCLUDEPERIODS )
				end if
			end if
		end if

		lexEatToken( @id )
	else
		id = *symbUniqueId( )
	end if

	'' AS?
	if (lexGetToken() = FB_TK_AS) then
		if( isunion ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if

		'' (Note: the typedef parser will skip the AS)
		cTypedefSingleDecl( attrib, id )
		exit sub
	end if

	if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL or FB_CMPSTMT_MASK_CODE ) = FALSE ) then
		hSkipCompound( FB_TK_TYPE )
		exit sub
	end if

	'' [ALIAS "id"]
	dim as zstring ptr palias = cAliasAttribute()

	'' (EXTENDS SymbolType)?
	dim as FBSYMBOL ptr baseSubtype = NULL
	dim as integer baseDType = 0
	dim as integer stringType = 0

	if( lexGetToken( ) = FB_TK_EXTENDS ) then
		lexSkipToken( LEXCHECK_POST_SUFFIX )

		'' SymbolType
		'' - on error hSymbolType() will return [integer] in baseDType
		hSymbolType( baseDType, baseSubtype, 0, FALSE, TRUE )

		'' is the base type a zstring, wstring, or something else (error)?
		if( baseDType <> FB_DATATYPE_STRUCT ) then

			'' allow extending WSTRING and ZSTRING, the UDT
			'' will use different rules for conversions,
			if (baseDType = FB_DATATYPE_WCHAR) or (baseDType = FB_DATATYPE_CHAR) then
				stringType = baseDType
				baseDType = 0
				assert( baseSubtype = NULL )

			'' anything else? don't allow
			else
				errReport( FB_ERRMSG_EXPECTEDCLASSTYPE )
				'' error recovery: skip
				baseSubtype = NULL
			end if
		end if

		'' got a string type?  check for another base type
		if( stringType <> 0 ) then

			'' ','?
			if( lexGetToken( ) = CHAR_COMMA ) then
				lexSkipToken( )

				'' SymbolType
				hSymbolType( baseDType, baseSubtype, 0, FALSE, TRUE )

				'' is the base type a struct?
				if( baseDType <> FB_DATATYPE_STRUCT ) then
					errReport( FB_ERRMSG_EXPECTEDCLASSTYPE )
					'' error recovery: skip
					baseSubtype = NULL
				end if
			end if
		end if

		'' check that the base type is not a parent struct namespace
		if( symbIsParentNamespace( baseDType, baseSubtype ) ) then
			baseDType = 0
			baseSubtype = NULL
			errReport( FB_ERRMSG_INVALIDDATATYPES )
		end if

		'' base type? check if z|wstring was already extended
		if( baseSubType ) then
			select case stringType
			case FB_DATATYPE_CHAR
				'' can't extend zstring if inheriting from wstring
				if( symbGetUdtIsWstring( baseSubtype ) ) then
					errReport( FB_ERRMSG_INVALIDDATATYPES )
					stringType = FB_DATATYPE_WCHAR
				end if
			case FB_DATATYPE_WCHAR
				'' can't extend wstring if inheriting from zstring
				if( symbGetUdtIsZstring( baseSubtype ) ) then
					errReport( FB_ERRMSG_INVALIDDATATYPES )
					stringType = FB_DATATYPE_CHAR
				end if
			case else
				'' inherit from base type
				if( symbGetUdtIsZstring( baseSubtype ) ) then
					stringType = FB_DATATYPE_CHAR
				elseif( symbGetUdtIsWstring( baseSubtype ) ) then
					stringType = FB_DATATYPE_WCHAR
				end if
			end select
		end if
	end if

	'' [FIELD '=' ConstExpression]
	dim as integer align = cFieldAlignmentAttribute( )

	'' start a new compound, or any EXTERN..END EXTERN used around this struct
	'' would turn-off function mangling depending on the mode passed
	cCompStmtPush( FB_TK_TYPE, _
	               FB_CMPSTMT_MASK_ALL and (not FB_CMPSTMT_MASK_CODE) _
	               and (not FB_CMPSTMT_MASK_DATA) )

	'' we have to store some contextual information,
	'' while there's no proper scope stack

	dim as ASTNODE ptr currproc = ast.proc.curr, currblock = ast.currblock
	dim as FBSYMBOL ptr currprocsym = parser.currproc, currblocksym = parser.currblock
	dim as integer scope_depth = parser.scope

	sym = hTypeAdd( NULL, id, palias, isunion, align, baseDType, baseSubtype, stringType )

	'' set visibility flags
	sym->attrib or= (attrib and FB_SYMBATTRIB_VIS_PRIVATE)
	sym->attrib or= (attrib and FB_SYMBATTRIB_VIS_PROTECTED)

	'' restore the context
	ast.proc.curr = currproc
	ast.currblock = currblock

	parser.currproc = currprocsym
	parser.currblock = currblocksym
	parser.scope = scope_depth

	hDisallowNestedClasses( sym )

	'' end the compound
	stk = cCompStmtGetTOS( FB_TK_TYPE )
	if( stk <> NULL ) then
		cCompStmtPop( stk )
	end if

	'' has methods? must be unique..
	if( symbGetIsUnique( sym ) ) then
		'' any preview declaration than itself?
		dim as FBSYMCHAIN ptr chain_ = _
			symbLookupAt( _
				symbGetCurrentNamespc( ), _
				id, _
				FALSE, _
				FALSE _
			)
		'' could be NULL, because error recovery
		if( chain_ <> NULL ) then
			if( chain_->sym <> sym ) then
				errReportEx( FB_ERRMSG_STRUCTISNOTUNIQUE, id )
			end if
		end if

		'' don't allow field named as keywords
		if( symbGetUDTHasKwdField( sym ) ) then
			errReport( FB_ERRMSG_KEYWORDFIELDSNOTALLOWEDINCLASSES )
		end if
	end if

	'' byval params to self?
	if( symbGetUdtHasRecByvalParam( sym ) ) then
		if( symbCompIsTrivial( sym ) = FALSE ) then
			hPatchByvalParamsToSelf( sym )
		end if
	end if

	'' byval results or static vars using this UDT as data type?
	if( symbGetUdtHasRecByvalRes( sym ) ) then
		hPatchByvalResultToSelf( sym )
	end if
end sub

private sub hPatchByvalParamsToSelf( byval parent as FBSYMBOL ptr )
	dim as FBSYMBOL ptr sym = any, param = any

	'' For each method...
	sym = symbGetUDTSymbtb( parent ).head
	while( sym )
		if( symbIsProc( sym ) ) then
			'' For each param...
			param = symbGetProcHeadParam( sym )
			while( param )
				'' BYVAL AS ParentUDT?
				if( symbGetParamMode( param ) = FB_PARAMMODE_BYVAL ) then
					if( symbIsParentNamespace( symbGetType( param ), symbGetSubtype( param ), parent) ) then
						symbRecalcLen( param )
					end if
				end if

				param = param->next
			wend
		end if

		sym = sym->next
	wend

	'' recurse in to nested types only if the type
	'' is expected to have nested types
	if( symbGetUdtHasNested( parent ) ) then
		sym = symbGetUDTSymbtb( parent ).head
		while( sym )
			if( symbIsStruct( sym ) ) then
				hPatchByvalParamsToSelf( sym )
			end if
			sym = sym->next
		wend
	end if

end sub

private sub hPatchByvalResultToSelf( byval parent as FBSYMBOL ptr )
	dim as FBSYMBOL ptr sym = any

	sym = symbGetUDTSymbtb( parent ).head
	while( sym )

		'' Function or static variable? Using parent UDT as Byval (result) data type?
		if( not symbIsRef( sym ) ) then
			if( symbIsParentNamespace( symbGetType( sym ), symbGetSubtype( sym ), parent ) ) then
				if( symbIsProc( sym ) ) then
					symbProcRecalcRealType( sym )
					'' (FBSYMBOL->lgt is 0 for procedures anyways, no need to update)
				elseif( symbIsVar( sym ) ) then
					symbRecalcLen( sym )
				end if
			end if
		end if

		sym = sym->next
	wend

	'' recurse in to nested types only if the type
	'' is expected to have nested types
	if( symbGetUdtHasNested( parent ) ) then
		sym = symbGetUDTSymbtb( parent ).head
		while( sym )
			if( symbIsStruct( sym ) ) then
				hPatchByvalResultToSelf( sym )
			end if
			sym = sym->next
		wend
	end if

end sub
