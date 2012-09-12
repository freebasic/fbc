'' structures (TYPE or UNION) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"

declare function hTypeBody _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

declare sub hPatchByvalParamsToSelf _
	( _
		byval parent as FBSYMBOL ptr _
	)

declare sub hPatchByvalResultToSelf _
	( _
		byval parent as FBSYMBOL ptr _
	)

'':::::
''TypeProtoDecl 	=	DECLARE ( CONSTRUCTOR Params
''								| DESTRUCTOR
''								| OPERATOR Op Params
''								| PROPERTY Params
''								| (STATIC|CONST)? SUB|FUNCTION Params ) .
''
private function hTypeProtoDecl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval attrib as FB_SYMBATTRIB _
	) as integer

	dim as integer res = any, is_nested = any

#macro hCheckStatic( attrib )
	if( (attrib and FB_SYMBATTRIB_STATIC) <> 0 ) then
		errReport( FB_ERRMSG_MEMBERCANTBESTATIC )
		attrib and= not FB_SYMBATTRIB_STATIC
	end if
#endmacro

	'' anon?
	if( symbGetUDTIsAnon( parent ) ) then
		errReport( FB_ERRMSG_METHODINANONUDT )
		'' error recovery: skip stmt
		hSkipStmt( )
		return TRUE
	end if

	'' methods not allowed?
	if( fbLangOptIsSet( FB_LANG_OPT_CLASS ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_CLASS )
	end if

	if( symbGetIsUnique( parent ) = FALSE ) then
		'' must be unique
		symbSetIsUnique( parent )

		'' start nesting
		symbNestBegin( parent, FALSE )
	end if

	'' DECLARE
	lexSkipToken( )

	cConstOrStaticAttribute( @attrib )

	res = TRUE

	select case as const lexGetToken( )
	case FB_TK_CONSTRUCTOR
        hCheckStatic( attrib )

		lexSkipToken( )

		if( cCtorHeader( attrib or FB_SYMBATTRIB_METHOD or FB_SYMBATTRIB_CONSTRUCTOR, _
						 is_nested, _
						 TRUE ) = NULL ) then
			res = FALSE
		end if

	case FB_TK_DESTRUCTOR
        hCheckStatic( attrib )

		lexSkipToken( )

		if( cCtorHeader( attrib or FB_SYMBATTRIB_METHOD or FB_SYMBATTRIB_DESTRUCTOR, _
						 is_nested, _
						 TRUE ) = NULL ) then
			res = FALSE
		end if

	case FB_TK_OPERATOR
		lexSkipToken( )

		if( cOperatorHeader( attrib or FB_SYMBATTRIB_METHOD, _
							 is_nested, _
							 FB_PROCOPT_ISPROTO or FB_PROCOPT_HASPARENT ) = NULL ) then
			res = FALSE
		end if

	case FB_TK_PROPERTY
        hCheckStatic( attrib )

		lexSkipToken( )

		if( cPropertyHeader( attrib or FB_SYMBATTRIB_METHOD, _
						 	 is_nested, _
						 	 TRUE ) = NULL ) then
			res = FALSE
		end if

	case FB_TK_SUB
		lexSkipToken( )

		if( (attrib and FB_SYMBATTRIB_STATIC) = 0 ) then
			attrib or= FB_SYMBATTRIB_METHOD
		end if

		cProcHeader( attrib, is_nested, _
		             FB_PROCOPT_ISPROTO or FB_PROCOPT_HASPARENT or _
		             FB_PROCOPT_ISSUB )

	case FB_TK_FUNCTION
		lexSkipToken( )

		if( (attrib and FB_SYMBATTRIB_STATIC) = 0 ) then
			attrib or= FB_SYMBATTRIB_METHOD
		end if

		cProcHeader( attrib, is_nested, _
		             FB_PROCOPT_ISPROTO or FB_PROCOPT_HASPARENT )

	case else
		errReport( FB_ERRMSG_SYNTAXERROR )
		'' error recovery: skip stmt
		hSkipStmt( )
	end select

	function = res

end function

'':::::
''TypeEnumDecl 	=	ENUM|CONST ...
''
private function hTypeEnumDecl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval is_const as integer, _
		byval attrib as integer _
	) as integer

	dim as integer res = any

	'' anon?
	if( symbGetUDTIsAnon( parent ) ) then
		errReport( FB_ERRMSG_METHODINANONUDT )
		'' error recovery: skip stmt
		hSkipStmt( )
		return TRUE
	end if

	if( symbGetIsUnique( parent ) = FALSE ) then
		'' must be unique
		symbSetIsUnique( parent )

		'' start nesting
		symbNestBegin( parent, FALSE )
	end if

	if( is_const ) then
		res = cConstDecl( attrib )
	else
		cEnumDecl( attrib )
		res = TRUE
	end if

	function = res

end function

'':::::
private sub hFieldInit( byval parent as FBSYMBOL ptr, byval sym as FBSYMBOL ptr )
	dim as FBSYMBOL ptr defctor = any, subtype = any

	'' '=' | '=>' ?
	select case lexGetToken( )
	case FB_TK_DBLEQ, FB_TK_EQ

	case else
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
						'' Check whether we have access
						if( symbCheckAccess( defctor ) = FALSE ) then
							errReport( FB_ERRMSG_NOACCESSTODEFAULTCTOR )
						end if
					else
						'' It has constructors, but no default one -- we cannot initialize it
						errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
					end if
				end if

				'' Does it have a destructor?
				defctor = symbGetCompDtor( subtype )
				if( defctor ) then
					'' Check whether we have access
					if( symbCheckAccess( defctor ) = FALSE ) then
						errReport( FB_ERRMSG_NOACCESSTODTOR )
					end if
				end if
			end if
		end if

		exit sub
	end select

	if( fbLangOptIsSet( FB_LANG_OPT_INITIALIZER ) = FALSE ) then
		errReportNotAllowed( FB_LANG_OPT_INITIALIZER )
		'' error recovery: skip
		hSkipUntil( FB_TK_EOL )
		exit sub
	end if

	if( sym <> NULL ) then
		'' union or anon?
		if( (parent->udt.options and (FB_UDTOPT_ISUNION or _
									  FB_UDTOPT_ISANON)) <> 0 ) then
			errReport( FB_ERRMSG_CTORINUNION )
			'' error recovery: skip
			hSkipUntil( FB_TK_EOL )
			exit sub
		end if
	end if

	lexSkipToken( )

	if( sym = NULL ) then
		'' error recovery: skip stmt
		hSkipStmt( )
		exit sub
	end if

    '' ANY?
	if( lexGetToken( ) = FB_TK_ANY ) then
		'' don't allow var-len strings
		if( symbGetType( sym ) = FB_DATATYPE_STRING ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )
		else
			symbSetDontInit( sym )
		end if

		lexSkipToken( )
		exit sub
	end if

	if( symbGetIsUnique( parent ) = FALSE ) then
		'' must be unique
		symbSetIsUnique( parent )

		'' start nesting
		symbNestBegin( parent, FALSE )
	end if

	dim as ASTNODE ptr initree = cInitializer( sym, FB_INIOPT_ISINI )
	if( initree ) then
		'' don't allow references to local symbols
		dim as FBSYMBOL ptr s = astFindLocalSymbol( initree )
		if( s <> NULL ) then
			errReport( FB_ERRMSG_INVALIDREFERENCETOLOCAL, TRUE )
			'' error recovery
			astDelTree( initree )
			initree = NULL
		end if
	end if

	'' remove the temps from the dtors list if any was added
	astDtorListClear( )

	'' Field initializers are only used in constructors (replacing the
	'' implicit default initialization), so we make sure to add a default
	'' constructor, if no constructor was specified.
	symbSetUDTHasInitedField( parent )

	if( initree ) then
		symbSetTypeIniTree( sym, initree )
	end if
end sub

'':::::
''TypeMultElementDecl =   AS SymbolType ID (ArrayDecl | ':' NUMLIT)? ('=' Expression)?
''							 (',' ID (ArrayDecl | ':' NUMLIT)? ('=' Expression)?)*
''
private sub hTypeMultElementDecl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval attrib as integer _
	) static

    static as zstring * FB_MAXNAMELEN+1 id
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr sym, subtype
    dim as integer dims, dtype, lgt, bits

	'' SymbolType
	hSymbolType( dtype, subtype, lgt )

	do
		'' allow keywords as field names
		select case as const lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
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
			lexSkipToken( )

		case else
			errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
			'' error recovery: fake an id
			id = *hMakeTmpStr( )
		end select

	    bits = 0

		'' ArrayDecl?
		if( cStaticArrayDecl( dims, dTB(), , FALSE ) = FALSE ) then
			'' ':' NUMLIT?
			if( lexGetToken( ) = FB_TK_STMTSEP ) then
				if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_NUMLITERAL ) then
					lexSkipToken( )
					bits = valint( *lexGetText( ) )
					lexSkipToken( )

					if( symbCheckBitField( parent, dtype, lgt, bits ) = FALSE ) then
						errReport( FB_ERRMSG_INVALIDBITFIELD, TRUE )
						'' error recovery: no bits
						bits = 0
					end if
				end if
			end if
		end if

		'' array?
		if( dims > 0 ) then
			'' "array too big" check
			if( symbCheckArraySize( dims, dTB(), lgt, FALSE, FALSE ) = FALSE ) then
				errReport( FB_ERRMSG_ARRAYTOOBIG )
				'' error recovery: use small array
				dims = 1
				dTB(0).lower = 0
				dTB(0).upper = 0
			end if
		end if

		'' ref to self?
		if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
			if( subtype = parent ) then
				errReport( FB_ERRMSG_RECURSIVEUDT )
				'' error recovery: fake type
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL
				lgt = FB_INTEGERSIZE
			end if
		end if

        ''
		sym = symbAddField( parent, @id, _
						  	dims, dTB(), _
						  	dtype, subtype, _
						  	lgt, bits )
		if( sym = NULL ) then
			errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		else
			symbGetAttrib( sym ) or= attrib
			hFieldInit( parent, sym )
		end if

		'' ','?
	    if( lexGetToken( ) <> CHAR_COMMA ) then
	    	exit do
	    end if

	    lexSkipToken( )
	loop
end sub

'':::::
'' TypeElementDecl	= ID (ArrayDecl| ':' NUMLIT)? AS SymbolType ('=' Expression)?
''
private sub hTypeElementDecl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval attrib as integer _
	) static

    static as zstring * FB_MAXNAMELEN+1 id
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr sym, subtype
    dim as integer dims, dtype, lgt, bits

	'' allow keywords as field names
	select case as const lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

		'' ID
		id = *lexGetText( )

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

		lexSkipToken( )

    case else
		errReport( FB_ERRMSG_EXPECTEDIDENTIFIER )
		'' error recovery: fake an id
		id = *hMakeTmpStr( )
		dtype = FB_DATATYPE_INVALID
    end select

	subtype = NULL
	bits = 0

	'' ArrayDecl?
	if( cStaticArrayDecl( dims, dTB(), , FALSE ) = FALSE ) then
		'' ':' NUMLIT?
		if( lexGetToken( ) = FB_TK_STMTSEP ) then
			if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_NUMLITERAL ) then
				lexSkipToken( )
				bits = valint( *lexGetText( ) )
				lexSkipToken( )
				if( bits <= 0 ) then
					errReport( FB_ERRMSG_SYNTAXERROR, TRUE )
					'' error recovery: no bits
					bits = 0
				end if
			end if
		end if
	end if

    '' AS
    if( lexGetToken( ) <> FB_TK_AS ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
    else
    	lexSkipToken( )
    end if

	'' SymbolType
	hSymbolType( dtype, subtype, lgt )

	'' array?
	if( dims > 0 ) then
		'' "array too big" check
		if( symbCheckArraySize( dims, dTB(), lgt, FALSE, FALSE ) = FALSE ) then
			errReport( FB_ERRMSG_ARRAYTOOBIG )
			'' error recovery: use small array
			dims = 1
			dTB(0).lower = 0
			dTB(0).upper = 0
		end if
	end if

	''
	if( bits <> 0 ) then
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
			lgt = FB_INTEGERSIZE
		end if
	end if

	''
	sym = symbAddField( parent, @id, _
					  	dims, dTB(), _
					  	dtype, subtype, _
					  	lgt, bits )

	if( sym = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		'' error recovery: pretend the field was added
		return
	end if
	sym->attrib or= attrib

	'' initializer
	hFieldInit( parent, sym )
end sub

'':::::
private function hTypeAdd _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval isunion as integer, _
		byval align as integer, _
		byval baseSubtype as FBSYMBOL ptr = NULL _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any

	function = NULL

	s = symbStructBegin( parent, id, id_alias, isunion, align, baseSubtype )
	if( s = NULL ) then
		errReportEx( FB_ERRMSG_DUPDEFINITION, id )
		'' error recovery: create a fake symbol
		s = symbStructBegin( parent, hMakeTmpStr( ), NULL, isunion, align )
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
	dim as integer res = hTypeBody( s )

	if( res = FALSE ) then
		exit function
	end if

	'' finalize
	symbStructEnd( s, symbGetIsUnique( s ) )

	'' END TYPE|UNION
	if( lexGetToken( ) <> FB_TK_END ) then
		errReport( FB_ERRMSG_EXPECTEDENDTYPE )
		'' error recovery: skip until next stmt
		hSkipStmt( )
	else
		lexSkipToken( )

		if( lexGetToken( ) <> iif( isunion, FB_TK_UNION, FB_TK_TYPE ) ) then
			errReport( FB_ERRMSG_EXPECTEDENDTYPE )
			'' error recovery: skip until next stmt
			hSkipStmt( )
		else
			lexSkipToken( )
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

	lexSkipToken( )

	'' '='
	if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
		errReport( FB_ERRMSG_SYNTAXERROR )
	end if

	'' ConstExpression
	dim as ASTNODE ptr expr = cExpression( )
	if( expr = NULL ) then
		errReport( FB_ERRMSG_EXPECTEDEXPRESSION )
		'' error recovery: fake an expr
		expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	if( astIsCONST( expr ) = FALSE ) then
		errReport( FB_ERRMSG_EXPECTEDCONST )
		'' error recovery: fake an expr
		astDelTree( expr )
		expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
	end if

	'' follow the GCC 3.x ABI
	dim as integer align = astGetValueAsInt( expr )
	astDelNode( expr )
	if( align < 0 ) then
		align = 0
	elseif( align > FB_INTEGERSIZE ) then
		align = 0
	elseif( align = 3 ) then
		align = 2
	end if

	return align
end function

'':::::
''TypeBody      =   ( (UNION|TYPE Comment? SttSeparator
''					   ElementDecl
''					  END UNION|TYPE)
''                  | ElementDecl
''				    | AS AsElementDecl )+ .
''
private function hTypeBody _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

	dim as integer isunion = any
	dim as FB_SYMBATTRIB attrib = FB_SYMBATTRIB_NONE
	dim as FBSYMBOL ptr inner = any

	function = FALSE

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

			lexSkipToken( )

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
				hTypeElementDecl( s, attrib )

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

decl_inner:		'' it's an anonymous inner UDT
				isunion = lexGetToken( ) = FB_TK_UNION
				if( isunion = FALSE ) then
					if( symbGetUDTIsUnion( s ) = FALSE ) then
						errReport( FB_ERRMSG_SYNTAXERROR )
						'' error recovery: fake type
						isunion = TRUE
					end if
				else
					if( symbGetUDTIsUnion( s ) ) then
						errReport( FB_ERRMSG_SYNTAXERROR )
						'' error recovery: fake type
						isunion = FALSE
					end if
				end if

				lexSkipToken( )

				'' [FIELD '=' ConstExpression]
				dim as integer align = cFieldAlignmentAttribute( )
				if( align = 0 ) then
					align = symbGetUDTAlign( s )
				end if

				'' create a "temp" one
				inner = hTypeAdd( s, NULL, NULL, isunion, align )
				if( inner = NULL ) then
					exit function
				end if

				inner->udt.options or= iif( isunion, FB_UDTOPT_ISUNION, 0 )

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
				hTypeElementDecl( s, attrib )

			'' it's a field, parse it
			case else
				hTypeElementDecl( s, attrib )

			end select

		'' AS?
		case FB_TK_AS
			'' it's a multi-declaration
			lexSkipToken( )
			hTypeMultElementDecl( s, attrib )

		case FB_TK_DECLARE
			if( hTypeProtoDecl( s, attrib ) = FALSE ) then
				hSkipStmt( )
			end if

		case FB_TK_ENUM
			if( hTypeEnumDecl( s, FALSE, attrib ) = FALSE ) then
				exit function
			end if

		case FB_TK_CONST
			if( hTypeEnumDecl( s, TRUE, attrib ) = FALSE ) then
				exit function
			end if

		case FB_TK_DIM
			lexSkipToken( )

			'' multi-decl?
			if( lexGetToken( ) = FB_TK_AS ) then
				lexSkipToken( )
				hTypeMultElementDecl( s, attrib )
			else
				hTypeElementDecl( s, attrib )
			end if

		case FB_TK_STATIC
			lexSkipToken( )

			'' !!!WRITEME!! it's var, but it can't be initialized

		'' anything else, must be a field
		case else
			hTypeElementDecl( s, attrib )

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

	'' nothing added?
	if( symbGetUDTElements( s ) = 0 ) then
		errReport( FB_ERRMSG_NOELEMENTSDEFINED )
	end if

    function = TRUE

end function

private sub hCheckForCDtorOrMethods(byval sym as FBSYMBOL ptr)
	'' Not at module level?
	if( parser.scope > FB_MAINSCOPE ) then
		'' we can't allow objects (or their children) with c/dtor
		if( symbGetUDTHasCtorField( sym ) ) then
			errReportEx( FB_ERRMSG_NOOOPINFUNCTIONS, symbGetName( sym ) )
		end if

		'' can't allow methods either...
		dim as FBSYMBOL ptr walk = symbGetUDTFirstElm( sym )
		do while( walk <> NULL )
			if( symbIsMethod( walk ) ) then
				errReportEx( FB_ERRMSG_NOOOPINFUNCTIONS, symbGetName( walk ) )
			end if
			walk = walk->next
		loop
	end if
end sub

'':::::
''TypeDecl        =   (TYPE|UNION) ID (ALIAS LITSTR)? (EXTENDS SymbolType)? (FIELD '=' Expression)? Comment? SttSeparator
''						TypeLine+
''					  END (TYPE|UNION) .
function cTypeDecl _
	( _
		byval attrib as FB_SYMBATTRIB _
	) as integer

	static as zstring * FB_MAXNAMELEN+1 id
	dim as integer isunion = any, checkid = any
	dim as FBSYMBOL ptr sym = any
	dim as FB_CMPSTMTSTK ptr stk = any

	function = FALSE

	isunion = (lexGetToken( ) = FB_TK_UNION)

	'' skip TYPE | UNION
	lexSkipToken( )

	'' ID
	checkid = TRUE
	select case as const lexGetClass( )
	case FB_TKCLASS_IDENTIFIER

	case FB_TKCLASS_KEYWORD
    	if( isunion = FALSE ) then
    		'' AS?
    		if( lexGetToken( ) = FB_TK_AS ) then
				'' (Note: the typedef parser will skip the AS)
				cTypedefMultDecl()
				return TRUE
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
		id = *hMakeTmpStrNL( )
	end if

	'' AS?
	if (lexGetToken() = FB_TK_AS) then
		if( isunion ) then
			errReport( FB_ERRMSG_SYNTAXERROR )
		end if

		'' (Note: the typedef parser will skip the AS)
		cTypedefSingleDecl( id )
		return TRUE
	end if

	'' [ALIAS "id"]
	dim as zstring ptr palias = cAliasAttribute()

	'' (EXTENDS SymbolType)?
	dim as FBSYMBOL ptr baseSubtype = NULL
	if( lexGetToken( ) = FB_TK_EXTENDS ) then
		lexSkipToken( )

		'' SymbolType
		dim as integer baseDtype, baseLgt
		hSymbolType( baseDtype, baseSubtype, baseLgt )

		'' is the base type a struct?
		if( baseDType <> FB_DATATYPE_STRUCT ) then
			errReport( FB_ERRMSG_EXPECTEDCLASSTYPE )
			'' error recovery: skip
			baseSubtype = NULL
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

	sym = hTypeAdd( NULL, id, palias, isunion, align, baseSubtype )

	'' restore the context
	ast.proc.curr = currproc
	ast.currblock = currblock

	parser.currproc = currprocsym
	parser.currblock = currblocksym
	parser.scope = scope_depth

	hCheckForCDtorOrMethods(sym)

	'' end the compound
	stk = cCompStmtGetTOS( FB_TK_TYPE )
	if( stk <> NULL ) then
		cCompStmtPop( stk )
	end if

	if( sym = NULL ) then
		return FALSE
	end if

	'' has methods? must be unique..
	if( symbGetIsUnique( sym ) ) then
		'' any preview declaration than itself?
		dim as FBSYMCHAIN ptr chain_ = symbLookupAt( symbGetCurrentNamespc( ), _
													 id, _
													 FALSE, _
													 FALSE )
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

	'' byval results to self?
	if( symbGetUdtHasRecByvalRes( sym ) ) then
		hPatchByvalResultToSelf( sym )
	end if

	function = TRUE

end function

'':::::
private sub hPatchByvalParamsToSelf _
	( _
		byval parent as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr sym, param
	dim as integer do_recalc

	'' for each method..
	sym = symbGetUDTSymbtb( parent ).head
	do while( sym <> NULL )
		if( symbIsProc( sym ) ) then
			do_recalc = FALSE

			'' for each param..
			param = symbGetProcHeadParam( sym )
			do while( param <> NULL )
				'' byval to self? recalc..
				if( symbGetSubtype( param ) = parent ) then
					if( symbGetParamMode( param ) = FB_PARAMMODE_BYVAL ) then
						param->lgt = symbCalcProcParamLen( FB_DATATYPE_STRUCT, _
														   parent, _
														   FB_PARAMMODE_BYVAL )
						do_recalc = TRUE
					end if
				end if

				param = param->next
			loop

			'' recalc total len?
			if( do_recalc ) then
            	symbGetProcParamsLen( sym ) = symbCalcProcParamsLen( sym )
			end if
		end if

		sym = sym->next
	loop

end sub

'':::::
private sub hPatchByvalResultToSelf _
	( _
		byval parent as FBSYMBOL ptr _
	) static

	dim as FBSYMBOL ptr sym
	dim as integer do_recalc

	'' for each method..
	sym = symbGetUDTSymbtb( parent ).head
	do while( sym <> NULL )
		if( symbIsProc( sym ) ) then

			'' byval result to self? reset..
			if( symbGetSubtype( sym ) = parent ) then
				'' follow the GCC 3.x ABI
				symbGetProcRealType( sym ) = symbGetUDTRetType( parent )

            	'' recalc params len (we don't know if the hidden param was added or
            	'' not in the time it was parsed, so we can't do any assumption here)
            	symbGetProcParamsLen( sym ) = symbCalcProcParamsLen( sym )
			end if

		end if

		sym = sym->next
	loop

end sub
