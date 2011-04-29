''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
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


'' structures (TYPE or UNION) declarations
''
'' chng: sep/2004 written [v1ctor]


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

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
		if( errReport( FB_ERRMSG_MEMBERCANTBESTATIC ) = FALSE ) then
			exit function
		else
			attrib and= not FB_SYMBATTRIB_STATIC
		end if
	end if
#endmacro

	'' anon?
	if( symbGetUDTIsAnon( parent ) ) then
		if( errReport( FB_ERRMSG_METHODINANONUDT ) = FALSE ) then
			return FALSE
		else
			'' error recovery: skip stmt
			hSkipStmt( )
			return TRUE
		end if
	end if

   	'' methods not allowed?
   	if( fbLangOptIsSet( FB_LANG_OPT_CLASS ) = FALSE ) then
    	if( errReportNotAllowed( FB_LANG_OPT_CLASS ) = FALSE ) then
       		exit function
       	end if
	end if

	''
	if( symbGetIsUnique( parent ) = FALSE ) then
		'' must be unique
		symbSetIsUnique( parent )

		'' start nesting
		symbNestBegin( parent, FALSE )
		
	end if

	'' DECLARE
	lexSkipToken( )

	'' STATIC?
	if( lexGetToken( ) = FB_TK_STATIC ) then
		lexSkipToken( )
		attrib or= FB_SYMBATTRIB_STATIC
	end if
    
    '' CONST?
	if( lexGetToken( ) = FB_TK_CONST ) then
		'' STATIC + CONST makes no sense
		if( attrib and FB_SYMBATTRIB_STATIC ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
			lexSkipToken( )
		else
			lexSkipToken( )
			if( lexGetToken( ) = FB_TK_STATIC ) then
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				end if
				lexSkipToken( )
			else
				attrib or= FB_SYMBATTRIB_CONST
			end if
		end if
	end if
	
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

		if( cProcHeader( attrib, _
						 is_nested, _
						 FB_PROCOPT_ISPROTO or _
						 FB_PROCOPT_HASPARENT or _
						 FB_PROCOPT_ISSUB ) = NULL ) then
			res = FALSE
		end if

	case FB_TK_FUNCTION
		lexSkipToken( )

		if( (attrib and FB_SYMBATTRIB_STATIC) = 0 ) then
			attrib or= FB_SYMBATTRIB_METHOD
		end if

		if( cProcHeader( attrib, _
						 is_nested, _
						 FB_PROCOPT_ISPROTO or _
						 FB_PROCOPT_HASPARENT ) = NULL ) then
			res = FALSE
		end if

	case else
		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
			res = FALSE
		else
			'' error recovery: skip stmt
			hSkipStmt( )
		end if
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
		if( errReport( FB_ERRMSG_METHODINANONUDT ) = FALSE ) then
			return FALSE
		else
			'' error recovery: skip stmt
			hSkipStmt( )
			return TRUE
		end if
	end if

	''
	if( symbGetIsUnique( parent ) = FALSE ) then
		'' must be unique
		symbSetIsUnique( parent )

		'' start nesting
		symbNestBegin( parent, FALSE )
	end if

	if( is_const ) then
		res = cConstDecl( attrib )
	else
		res = cEnumDecl( attrib )
	end if

	function = res

end function

'':::::
private function hFieldInit _
	( _
        byval parent as FBSYMBOL ptr, _
        byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr initree = any

	function = NULL

	'' '=' | '=>' ?
	select case lexGetToken( )
	case FB_TK_DBLEQ, FB_TK_EQ

	case else
    	if( sym <> NULL ) then
    		select case symbGetType( sym )
    		case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
    			'' has ctors?
    			if( symbGetHasCtor( symbGetSubtype( sym ) ) ) then
    				'' but no default ctor defined?
    				if( symbGetCompDefCtor( symbGetSubtype( sym ) ) = NULL ) then
    					errReport( FB_ERRMSG_NODEFAULTCTORDEFINED )
    				end if
    			end if
    		end select
    	end if

		exit function
	end select

	if( fbLangOptIsSet( FB_LANG_OPT_INITIALIZER ) = FALSE ) then
		if( errReportNotAllowed( FB_LANG_OPT_INITIALIZER )  ) then
			'' error recovery: skip
			hSkipUntil( FB_TK_EOL )
		end if
		exit function
	end if

	if( sym <> NULL ) then
		'' union or anon?
		if( (parent->udt.options and (FB_UDTOPT_ISUNION or _
									  FB_UDTOPT_ISANON)) <> 0 ) then

		    if( errReport( FB_ERRMSG_CTORINUNION ) ) then
				'' error recovery: skip
				hSkipUntil( FB_TK_EOL )
			end if

			exit function
		end if
	end if

	lexSkipToken( )

	if( sym = NULL ) then
		'' error recovery: skip stmt
		hSkipStmt( )
		exit function
	end if

    '' ANY?
	if( lexGetToken( ) = FB_TK_ANY ) then

		'' don't allow var-len strings
		if( symbGetType( sym ) = FB_DATATYPE_STRING ) then
			errReport( FB_ERRMSG_INVALIDDATATYPES )

		else
   			select case symbGetType( sym )
   			case FB_DATATYPE_STRUCT ', FB_DATATYPE_CLASS
				'' has a default ctor?
				if( symbGetCompDefCtor( symbGetSubtype( sym ) ) <> NULL ) then
					errReportWarn( FB_WARNINGMSG_ANYINITHASNOEFFECT )
				end if
			end select

			symbSetDontInit( sym )
		end if

		lexSkipToken( )

		exit function
	end if

	''
	if( symbGetIsUnique( parent ) = FALSE ) then
		'' must be unique
		symbSetIsUnique( parent )

		'' start nesting
		symbNestBegin( parent, FALSE )
	end if

	initree = cInitializer( sym, FB_INIOPT_ISINI )
	if( initree = NULL ) then
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

	else
    	'' don't allow references to local symbols
    	dim as FBSYMBOL ptr s = astFindLocalSymbol( initree )
    	if( s <> NULL ) then
    		if( errReport( FB_ERRMSG_INVALIDREFERENCETOLOCAL, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery
    			astDelTree( initree )
    			initree = NULL
    		end if
    	end if
	end if

	'' remove the temps from the dtors list if any was added
	astDtorListClear( )

	'' make sure a default ctor is added
	symbSetUDTHasCtorField( parent )

	function = initree

end function

'':::::
''TypeMultElementDecl =   AS SymbolType ID (ArrayDecl | ':' NUMLIT)? ('=' Expression)?
''							 (',' ID (ArrayDecl | ':' NUMLIT)? ('=' Expression)?)*
''
private function hTypeMultElementDecl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval attrib as integer _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr sym, subtype
    dim as integer dims, dtype, lgt, bits
    dim as ASTNODE ptr initree

    function = FALSE

    '' SymbolType
    if( hSymbolType( dtype, subtype, lgt ) = FALSE ) then
    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: create a fake type
    		dtype = FB_DATATYPE_INTEGER
    		subtype = NULL
    		lgt = FB_INTEGERSIZE
    	end if
    end if

	do
		'' allow keywords as field names
		select case as const lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD
    		'' contains a period?
    		if( lexGetPeriodPos( ) > 0 ) then
    			if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
    				exit function
    			end if
    		end if

    		'' but don't allow keywords if it's an object (because the implicit inst. ptr)
    		if( lexGetClass( ) = FB_TKCLASS_KEYWORD ) then
    			if( symbGetIsUnique( parent ) ) then
    				if( errReport( FB_ERRMSG_KEYWORDFIELDSNOTALLOWEDINCLASSES ) = FALSE ) then
    					exit function
    				end if
    			else
    				symbSetUDTHasKwdField( parent )
    			end if
    		end if

			id = *lexGetText( )
			lexSkipToken( )

		case else
    		if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake an id
    			id = *hMakeTmpStr( )
    		end if
    	end select

	    bits = 0

		'' ArrayDecl?
		if( cStaticArrayDecl( dims, dTB(), , FALSE ) = FALSE ) then

    		if( errGetLast( ) <> FB_ERRMSG_OK ) then
    			exit function
    		end if

			'' ':' NUMLIT?
			if( lexGetToken( ) = FB_TK_STMTSEP ) then
				if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_NUMLITERAL ) then
					lexSkipToken( )
					bits = valint( *lexGetText( ) )
					lexSkipToken( )

					if( symbCheckBitField( parent, dtype, lgt, bits ) = FALSE ) then
						if( errReport( FB_ERRMSG_INVALIDBITFIELD, TRUE ) = FALSE ) then
							exit function
						else
							'' error recovery: no bits
							bits = 0
						end if
					end if
				end if

			end if

		end if

		'' ref to self?
		if( typeGet( dtype ) = FB_DATATYPE_STRUCT ) then
			if( subtype = parent ) then
				if( errReport( FB_ERRMSG_RECURSIVEUDT ) = FALSE ) then
					exit function
				else
    				'' error recovery: fake type
					dtype = FB_DATATYPE_INTEGER
					subtype = NULL
					lgt = FB_INTEGERSIZE
				end if
			end if
		end if

        ''
		sym = symbAddField( parent, @id, _
						  	dims, dTB(), _
						  	dtype, subtype, _
						  	lgt, bits )
		if( sym = NULL ) then
			if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
				exit function
			end if

		else
			symbGetAttrib( sym ) or= attrib

			initree = hFieldInit( parent, sym )
			if( initree = NULL ) then
    			if( errGetLast( ) <> FB_ERRMSG_OK ) then
    				exit function
    			end if
    		else
    			symbSetTypeIniTree( sym, initree )
    		end if
    	end if

		'' ','?
	    if( lexGetToken( ) <> CHAR_COMMA ) then
	    	exit do
	    end if

	    lexSkipToken( )
	loop

	function = TRUE

end function

'':::::
'' TypeElementDecl	= ID (ArrayDecl| ':' NUMLIT)? AS SymbolType ('=' Expression)?
''
private function hTypeElementDecl _
	( _
		byval parent as FBSYMBOL ptr, _
		byval attrib as integer _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr sym, subtype
    dim as integer dims, dtype, lgt, bits
    dim as ASTNODE ptr initree

	function = FALSE

	'' allow keywords as field names
	select case as const lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD, FB_TKCLASS_QUIRKWD

		'' ID
		id = *lexGetText( )

    	if( lexGetType( ) <> FB_DATATYPE_INVALID ) then
    		if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    			exit function
    		end if
    	end if

    	'' contains a period?
    	if( lexGetPeriodPos( ) > 0 ) then
    		if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
    			exit function
    		end if
    	end if

    	'' but don't allow keywords if it's an object (because the implicit inst. ptr)
    	if( lexGetClass( ) = FB_TKCLASS_KEYWORD ) then
    		if( symbGetIsUnique( parent ) ) then
    			if( errReport( FB_ERRMSG_KEYWORDFIELDSNOTALLOWEDINCLASSES ) = FALSE ) then
    				exit function
    			end if
    		else
    			symbSetUDTHasKwdField( parent )
    		end if
    	end if

		lexSkipToken( )

    case else
    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: fake an id
    		id = *hMakeTmpStr( )
    		dtype = FB_DATATYPE_INVALID
    	end if
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
    				if( errReport( FB_ERRMSG_SYNTAXERROR, TRUE ) ) then
    					exit function
    				else
    					'' error recovery: no bits
    					bits = 0
    				end if
    			end if
			end if
		end if
	end if

    '' AS
    if( lexGetToken( ) <> FB_TK_AS ) then
    	if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    		exit function
    	end if

    else
    	lexSkipToken( )
    end if

    '' SymbolType
    if( hSymbolType( dtype, subtype, lgt ) = FALSE ) then
    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		exit function
		else
			'' error recovery: create a fake type
			dtype = FB_DATATYPE_INTEGER
			subtype = NULL
			lgt = FB_INTEGERSIZE
		end if
    end if

	''
	if( bits <> 0 ) then
		if( symbCheckBitField( parent, dtype, lgt, bits ) = FALSE ) then
    		if( errReport( FB_ERRMSG_INVALIDBITFIELD, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: no bits
    			bits = 0
    		end if
		end if
	end if

	'' ref to self?
	if( dtype = FB_DATATYPE_STRUCT ) then
		if( subtype = parent ) then
			if( errReport( FB_ERRMSG_RECURSIVEUDT ) = FALSE ) then
				exit function
			else
    			'' error recovery: fake type
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL
				lgt = FB_INTEGERSIZE
			end if
		end if
	end if

	''
	sym = symbAddField( parent, @id, _
					  	dims, dTB(), _
					  	dtype, subtype, _
					  	lgt, bits )

	if( sym = NULL ) then
		if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
			exit function
		else
			'' error recovery: pretend the field was added
			return TRUE
		end if
	end if
	sym->attrib or= attrib

	'' initializer
	initree = hFieldInit( parent, sym )
	if( initree = NULL ) then
    	if( errGetLast( ) <> FB_ERRMSG_OK ) then
    		exit function
    	end if
    else
    	symbSetTypeIniTree( sym, initree )
    end if

	function = TRUE

end function

'':::::
private function hTypeAdd _
	( _
		byval parent as FBSYMBOL ptr, _
		byval id as zstring ptr, _
		byval id_alias as zstring ptr, _
		byval isunion as integer, _
		byval align as integer _
	) as FBSYMBOL ptr

	dim as FBSYMBOL ptr s = any

	function = NULL

	s = symbStructBegin( parent, id, id_alias, isunion, align )
	if( s = NULL ) then
    	if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: create a fake symbol
    		s = symbStructBegin( parent, hMakeTmpStr( ), NULL, isunion, align )
    	end if
	end if

	'' Comment? SttSeparator
	cComment( )

	'' emit the current line in text form
	hEmitCurrLine( )

	if( cStmtSeparator( ) = FALSE ) then
    	if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip until next line or stmt
    		hSkipUntil( INVALID, TRUE )
    	end if
	end if

	'' TypeBody
	dim as integer res = hTypeBody( s )

	'' end nesting
	if( symbGetIsUnique( s ) ) then
		symbNestEnd( FALSE )
	end if

	if( res = FALSE ) then
		exit function
	else
		if( errGetLast() <> FB_ERRMSG_OK ) then
			exit function
		end if
	end if

	'' finalize
	symbStructEnd( s )

	'' END TYPE|UNION
	if( lexGetToken( ) <> FB_TK_END ) then
    	if( errReport( FB_ERRMSG_EXPECTEDENDTYPE ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip until next stmt
    		hSkipStmt( )
    	end if

	else
		lexSkipToken( )

		if( lexGetToken( ) <> iif( isunion, FB_TK_UNION, FB_TK_TYPE ) ) then
			if( errReport( FB_ERRMSG_EXPECTEDENDTYPE ) = FALSE ) then
				exit function
			else
    			'' error recovery: skip until next stmt
    			hSkipStmt( )
    		end if

		else
			lexSkipToken( )
		end if
	end if

	function = s

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
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				end if
			end if

			select case lexGetToken( )
			case FB_TK_PUBLIC
				attrib = FB_SYMBATTRIB_VIS_PUBLIC
			case FB_TK_PRIVATE
				attrib = FB_SYMBATTRIB_VIS_PRIVATE
			case FB_TK_PROTECTED
				attrib = FB_SYMBATTRIB_VIS_PROTECTED
			end select

			lexSkipToken( )

			'' ':'
			if( lexGetToken( ) <> FB_TK_STMTSEP ) then
				if( errReport( FB_ERRMSG_EXPECTEDSTMTSEP ) = FALSE ) then
					exit function
				end if
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
				if( hTypeElementDecl( s, attrib ) = FALSE ) then
					exit function
				end if

			'' it's not a field, exit
			case else
				exit do

			end select

		'' (TYPE|UNION)?
		case FB_TK_TYPE, FB_TK_UNION
			'' isn't it a field called TYPE|UNION?
			select case as const lexGetLookAhead( 1 )
			case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENT, FB_TK_REM

decl_inner:		'' it's an anonymous inner UDT
				isunion = lexGetToken( ) = FB_TK_UNION
				if( isunion = FALSE ) then
					if( symbGetUDTIsUnion( s ) = FALSE ) then
						if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
							exit function
						else
							'' error recovery: fake type
							isunion = TRUE
						end if
					end if
				else
					if( symbGetUDTIsUnion( s ) ) then
						if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
							exit function
						else
							'' error recovery: fake type
							isunion = FALSE
						end if
					end if
				end if

				lexSkipToken( )

				'' create a "temp" one
				inner = hTypeAdd( s, NULL, NULL, isunion, symbGetUDTAlign( s ) )
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
				if( hTypeElementDecl( s, attrib ) = FALSE ) then
					exit function
				end if

			'' it's a field, parse it
			case else
				if( hTypeElementDecl( s, attrib ) = FALSE ) then
					exit function
				end if

			end select

		'' AS?
		case FB_TK_AS
			'' it's a multi-declaration
			lexSkipToken( )

			if( hTypeMultElementDecl( s, attrib ) = FALSE ) then
				exit function
			end if

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

				if( hTypeMultElementDecl( s, attrib ) = FALSE ) then
					exit function
				end if

			else
				if( hTypeElementDecl( s, attrib ) = FALSE ) then
					exit function
				end if
			end if

		case FB_TK_STATIC
			lexSkipToken( )

			'' !!!WRITEME!! it's var, but it can't be initialized

		'' anything else, must be a field
		case else
			if( hTypeElementDecl( s, attrib ) = FALSE ) then
				exit function
			end if

		end select

		'' Comment?
		cComment( )

		'' emit the current line in text form
		hEmitCurrLine( )

	    if( cStmtSeparator( ) = FALSE ) then
	    	if( errReport( FB_ERRMSG_EXPECTEDEOL ) = FALSE ) then
	    		exit function
    		else
    			'' error recovery: skip until next line or stmt
    			hSkipUntil( INVALID, TRUE )
    		end if
		end if

	loop

	'' nothing added?
	if( symbGetUDTElements( s ) = 0 ) then
		if( errReport( FB_ERRMSG_NOELEMENTSDEFINED ) = FALSE ) then
			exit function
		end if
	end if

    function = TRUE

end function

function hCheckForCDtorOrMethods _
	( _
		byval sym as FBSYMBOL ptr _
	) as integer

	'' inside a proc?
	if( fbIsModLevel( ) = FALSE ) then

		'' we can't allow objects (or their children) with c/dtor
		if( symbGetUDTHasCtorField( sym ) ) then
			if( errReportEx( FB_ERRMSG_NOOOPINFUNCTIONS, symbGetName( sym ) ) = FALSE ) then
				exit function
			end if
		end if

		'' can't allow methods either...
		dim as FBSYMBOL ptr walk = symbGetUDTFirstElm( sym )
		do while( walk <> NULL )
			if( symbIsMethod( walk ) ) then
				if( errReportEx( FB_ERRMSG_NOOOPINFUNCTIONS, symbGetName( walk ) ) = FALSE ) then
					exit function
				end if
			end if
			walk = walk->next
		loop

	end if

	function = TRUE

end function

'':::::
''TypeDecl        =   (TYPE|UNION) ID (ALIAS LITSTR)? (FIELD '=' Expression)? Comment? SttSeparator
''						TypeLine+
''					  END (TYPE|UNION) .
function cTypeDecl _
	( _
		byval attrib as FB_SYMBATTRIB _
	) as integer

    static as zstring * FB_MAXNAMELEN+1 id, id_alias
    dim as zstring ptr palias = any
    dim as ASTNODE ptr expr = any
    dim as integer align, isunion, checkid = any
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
    			return cTypedefMultDecl( )
    		end if
    	end if

    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		exit function
    	else
 			'' error recovery: fake an ID
 			checkid = FALSE
 		end if

	case FB_TKCLASS_QUIRKWD

    case else
    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		exit function
    	else
 			'' error recovery: fake an ID
 			checkid = FALSE
 		end if
    end select

	if( checkid ) then
		'' don't allow explicit namespaces
		dim as FBSYMBOL ptr parent = cParentId( )
    	if( parent <> NULL ) then
			if( hDeclCheckParent( parent ) = FALSE ) then
				exit function
    		end if
    	else
    		if( errGetLast( ) <> FB_ERRMSG_OK ) then
    			exit function
    		end if
    	end if

		if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
			'' if inside a namespace, symbols can't contain periods (.)'s
			if( symbIsGlobalNamespc( ) = FALSE ) then
  				if( lexGetPeriodPos( ) > 0 ) then
  					if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
	  					exit function
					end if
				end if
			end if
		end if

		lexEatToken( @id )

	else
		id = *hMakeTmpStrNL( )
	end if

	palias = NULL

	''
	select case lexGetToken( )
	'' AS?
	case FB_TK_AS
		if( isunion ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
		end if

        '' (Note: the typedef parser will skip the AS)
		return cTypedefSingleDecl( id )

	'' (ALIAS LITSTR)?
	case FB_TK_ALIAS
    	lexSkipToken( )

		if( lexGetClass( ) <> FB_TKCLASS_STRLITERAL ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
        else
			lexEatToken( @id_alias )
			palias = @id_alias
		end if

	end select

	'' (FIELD '=' Expression)?
    if( lexGetToken( ) = FB_TK_FIELD ) then
		lexSkipToken( )

		if( hMatch( FB_TK_ASSIGN ) = FALSE ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			end if
		end if

    	expr = cExpression( )
    	if( expr = NULL ) then
    		if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: fake an expr
    			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		end if
    	end if

		if( astIsCONST( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
				exit function
			else
    			'' error recovery: fake an expr
    			astDelTree( expr )
    			expr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    		end if
		end if

  		'' follow the GCC 3.x ABI
  		align = astGetValueAsInt( expr )
  		astDelNode( expr )
  		if( align < 0 ) then
  			align = 0
  		elseif( align > FB_INTEGERSIZE ) then
  			align = 0
  		elseif( align = 3 ) then
  			align = 2
  		end if

	else
		align = 0
	end if

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

	sym = hTypeAdd( NULL, id, palias, isunion, align )

	'' restore the context
	ast.proc.curr = currproc
	ast.currblock = currblock

	parser.currproc = currprocsym
	parser.currblock = currblocksym
	parser.scope = scope_depth

	if( hCheckForCDtorOrMethods( sym ) = FALSE ) then
		exit function
	end if

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
    			if( errReportEx( FB_ERRMSG_STRUCTISNOTUNIQUE, id ) = FALSE ) then
	   				exit function
    			end if
    		end if
		end if

    	'' don't allow field named as keywords
    	if( symbGetUDTHasKwdField( sym ) ) then
    		if( errReport( FB_ERRMSG_KEYWORDFIELDSNOTALLOWEDINCLASSES ) = FALSE ) then
    			exit function
    		end if
    	end if
	end if

	'' byval params to self?
	if( symbGetUdtHasRecByvalParam( sym ) ) then
		if( symbIsTrivial( sym ) = FALSE ) then
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
