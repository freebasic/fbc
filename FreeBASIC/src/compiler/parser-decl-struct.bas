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


'' structures (TYPE or UNION) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

declare function cTypeBody					( _
												byval s as FBSYMBOL ptr _
											) as integer

'':::::
''TypeMultElementDecl =   AS SymbolType ID (ArrayDecl | ':' NUMLIT)?
''							 (',' ID (ArrayDecl | ':' NUMLIT)?)*
''
function cTypeMultElementDecl _
	( _
		byval s as FBSYMBOL ptr _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr subtype
    dim as integer dims, dtype, lgt, ptrcnt, bits

    function = FALSE

    '' SymbolType
    if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
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
		select case lexGetClass( )
		case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD
    		'' contains a period?
    		if( lexGetPeriodPos( ) > 0 ) then
    			if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
    				exit function
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
		if( cStaticArrayDecl( dims, dTB() ) = FALSE ) then

    		if( errGetLast( ) <> FB_ERRMSG_OK ) then
    			exit function
    		end if

			'' ':' NUMLIT?
			if( lexGetToken( ) = CHAR_COLON ) then
				if( lexGetLookAheadClass( 1 ) = FB_TKCLASS_NUMLITERAL ) then
					lexSkipToken( )
					bits = valint( *lexGetText( ) )
					lexSkipToken( )
				end if

				if( symbCheckBitField( s, dtype, lgt, bits ) = FALSE ) then
    				if( errReport( FB_ERRMSG_INVALIDBITFIELD, TRUE ) = FALSE ) then
    					exit function
    				else
    					'' error recovery: no bits
    					bits = 0
    				end if
				end if

			end if

		end if

        ''
		if( symbAddUDTElement( s, @id, _
							   dims, dTB(), _
							   dtype, subtype, ptrcnt, _
							   lgt, bits ) = NULL ) then
			if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
				exit function
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
'' TypeElementDecl	= ID (ArrayDecl| ':' NUMLIT)? AS SymbolType
''
function cTypeElementDecl _
	( _
		byval s as FBSYMBOL ptr _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id
    static as FBARRAYDIM dTB(0 to FB_MAXARRAYDIMS-1)
    dim as FBSYMBOL ptr subtype
    dim as integer dims, dtype, lgt, ptrcnt, bits

	function = FALSE

	'' allow keywords as field names
	select case lexGetClass( )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD
		'' ID
		id = *lexGetText( )

    	if( lexGetType( ) <> INVALID ) then
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

		lexSkipToken( )

    case else
    	if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: fake an id
    		id = *hMakeTmpStr( )
    		dtype = INVALID
    	end if
    end select

	subtype = NULL
	bits = 0

	'' ArrayDecl?
	if( cStaticArrayDecl( dims, dTB() ) = FALSE ) then
		'' ':' NUMLIT?
		if( lexGetToken( ) = CHAR_COLON ) then
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
    if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
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
		if( symbCheckBitField( s, dtype, lgt, bits ) = FALSE ) then
    		if( errReport( FB_ERRMSG_INVALIDBITFIELD, TRUE ) = FALSE ) then
    			exit function
    		else
    			'' error recovery: no bits
    			bits = 0
    		end if
		end if
	end if

	'' ref to self?
	if( dtype = FB_DATATYPE_USERDEF ) then
		if( subtype = s ) then
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

	if( symbAddUDTElement( s, @id, _
						   dims, dTB(), _
						   dtype, subtype, ptrcnt, _
						   lgt, bits ) = NULL ) then

		if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
			exit function
		end if

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

	dim as FBSYMBOL ptr s

	function = NULL

	s = symbAddUDT( parent, id, id_alias, isunion, align )
	if( s = NULL ) then
    	if( errReportEx( FB_ERRMSG_DUPDEFINITION, id ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: create a fake symbol
    		s = symbAddUDT( parent, hMakeTmpStr( ), NULL, isunion, align )
    	end if
	end if

	'' Comment? SttSeparator
	cComment( )

	if( cStmtSeparator( ) = FALSE ) then
    	if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: skip until next line or stmt
    		hSkipUntil( INVALID, TRUE )
    	end if
	end if

	'' TypeBody
	if( cTypeBody( s ) = FALSE ) then
		exit function
	end if

	if( errGetLast() <> FB_ERRMSG_OK ) then
		exit function
	end if

	'' pad the UDT if needed
	symbRoundUDTSize( s )

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
function cTypeBody _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

	dim as integer istype
	dim as FBSYMBOL ptr inner

	function = FALSE

	do
		'' Comment? SttSeparator?
		do while( cComment( ) or cStmtSeparator( ) )
		loop

		select case as const lexGetToken( )
		'' EOF?
		case FB_TK_EOF
			exit do

		'' END?
		case FB_TK_END
			'' isn't it a field called "end"?
			select case lexGetLookAhead( 1 )
			case FB_TK_AS, CHAR_LPRNT, CHAR_COLON
				if( cTypeElementDecl( s ) = FALSE ) then
					exit function
				end if

			'' it's not a field, exit
			case else
				exit do

			end select

		'' (TYPE|UNION)?
		case FB_TK_TYPE, FB_TK_UNION
			'' isn't it a field called TYPE|UNION?
			select case lexGetLookAhead( 1 )
			case FB_TK_EOL, FB_TK_EOF, FB_TK_COMMENTCHAR, FB_TK_REM

decl_inner:		'' it's an anonymous inner UDT
				istype = lexGetToken( ) = FB_TK_TYPE
				if( istype ) then
					if( symbGetUDTIsUnion( s ) = FALSE ) then
						if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
							exit function
						else
							'' error recovery: fake type
							istype = FALSE
						end if
					end if
				else
					if( symbGetUDTIsUnion( s ) ) then
						if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
							exit function
						else
							'' error recovery: fake type
							istype = TRUE
						end if
					end if
				end if

				lexSkipToken( )

				'' create a "temp" one
				inner = hTypeAdd( s, hMakeTmpStr( ), NULL, not istype, symbGetUDTAlign( s ) )
				if( inner = NULL ) then
					exit function
				end if

				'' insert it into the parent UDT
				symbInsertInnerUDT( s, inner )

			'' ambiguity: can be a stmt separator or bitfield
			case CHAR_COLON
				'' not a bitfield? separator..
				if( lexGetLookAheadClass( 2 ) <> FB_TKCLASS_NUMLITERAL ) then
					goto decl_inner
				end if

				'' bitfield..
				if( cTypeElementDecl( s ) = FALSE ) then
					exit function
				end if

			'' it's a field, parse it
			case else
				if( cTypeElementDecl( s ) = FALSE ) then
					exit function
				end if

			end select

		'' AS?
		case FB_TK_AS
			'' isn't it a field called "as"?
			select case lexGetLookAhead( 1 )
			case FB_TK_AS, CHAR_LPRNT, CHAR_COLON
				if( cTypeElementDecl( s ) = FALSE ) then
					exit function
				end if

			'' it's a multi-declaration
			case else
				lexSkipToken( )

				if( cTypeMultElementDecl( s ) = FALSE ) then
					exit function
				end if
			end select

		'' anything else, must be a field
		case else
			if( cTypeElementDecl( s ) = FALSE ) then
				exit function
			end if

		end select

		'' Comment? SttSeparator
		cComment( )

	    if( cStmtSeparator( ) = FALSE ) then
	    	if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
	    		exit function
    		else
    			'' error recovery: skip until next line or stmt
    			hSkipUntil( INVALID, TRUE )
    		end if
		end if

	loop

	'' nothing added?
	if( symbGetUDTElements( s ) = 0 ) then
		if( errReport( FB_ERRMSG_ELEMENTNOTDEFINED ) = FALSE ) then
			exit function
		end if
	end if

    function = TRUE

end function

'':::::
''TypeDecl        =   (TYPE|UNION) ID (ALIAS LITSTR)? (FIELD '=' Expression)? Comment? SttSeparator
''						TypeLine+
''					  END (TYPE|UNION) .
function cTypeDecl _
	( _
	) as integer static

    static as zstring * FB_MAXNAMELEN+1 id, id_alias
    dim as zstring ptr palias
    dim as ASTNODE ptr expr
    dim as FBSYMBOL ptr ns, s
    dim as integer align, isunion, checkid

	function = FALSE

    if( cCompStmtIsAllowed( FB_CMPSTMT_MASK_DECL ) = FALSE ) then
    	exit function
    end if

	'' TYPE | UNION
	select case lexGetToken( )
	case FB_TK_TYPE
		isunion = FALSE
		lexSkipToken( )

	case FB_TK_UNION
		isunion = TRUE
		lexSkipToken( )

	case else
		exit function
	end select

	'' ID
	checkid = TRUE
	select case lexGetClass( )
	case FB_TKCLASS_IDENTIFIER

	case FB_TKCLASS_KEYWORD
    	if( isunion = FALSE ) then
    		'' AS?
    		if( lexGetToken( ) = FB_TK_AS ) then
    			lexSkipToken( )
    			return cTypedefDecl( NULL )
    		end if
    	end if

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
		ns = cNamespace( )
    	if( ns <> NULL ) then
			if( ns <> symbGetCurrentNamespc( ) ) then
				if( errReport( FB_ERRMSG_DECLOUTSIDENAMESPC ) = FALSE ) then
					exit function
				end if
    		end if
    	else
    		if( errGetLast( ) <> FB_ERRMSG_OK ) then
    			exit function
    		end if
    	end if

    	'' if inside a namespace, symbols can't contain periods (.)'s
    	if( symbIsGlobalNamespc( ) = FALSE ) then
    		if( lexGetPeriodPos( ) > 0 ) then
	    		if( errReport( FB_ERRMSG_CANTINCLUDEPERIODS ) = FALSE ) then
    				exit function
    			end if
    		end if
    	end if

		lexEatToken( @id )

	else
		id = *hMakeTmpStr( FALSE )
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

		lexSkipToken( )

		return cTypedefDecl( id )

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

    	if( cExpression( expr ) = FALSE ) then
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

	function = (hTypeAdd( NULL, id, palias, isunion, align ) <> NULL)

end function

