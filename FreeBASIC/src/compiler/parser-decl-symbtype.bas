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


'' symbol type (BYTE, INTEGER, STRING, ...) declarations
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

''::::
function cConstExprValue _
	( _
		byref value as integer _
	) as integer

    dim as ASTNODE ptr expr

    function = FALSE

    if( cExpression( expr ) = FALSE ) then
    	hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
    	exit function
    end if

	if( astIsCONST( expr ) = FALSE ) then
		hReportError( FB_ERRMSG_EXPECTEDCONST )
		exit function
	end if

	value = astGetValueAsInt( expr )
  	astDelNode( expr )

  	function = TRUE

end function

'':::::
function hMangleFuncPtrName _
	( _
		byval proc as FBSYMBOL ptr, _
		byval dtype as integer, _
		byval subtype as FBSYMBOL ptr, _
		byval mode as integer _
	) as zstring ptr static

    static as zstring * FB_MAXINTNAMELEN+1 id
    dim as FBSYMBOL ptr p
    dim as integer i

    id = "{fbfp}"

    p = symbGetProcHeadParam( proc )
    for i = 0 to symbGetProcParams( proc )-1
    	id += "_"

    	if( p->subtype = NULL ) then
    		id += hex( p->typ * cint(p->param.mode) )
    	else
    		id += hex( p->subtype )
    	end if

    	p = symbGetParamNext( p )
    next

    id += "@"

	if( subtype = NULL ) then
		id += hex( dtype )
	else
		id += hex( subtype )
	end if

    id += "@"

    id += hex( mode )

	function = @id

end function

'':::::
function cSymbolTypeFuncPtr _
	( _
		byval isfunction as integer _
	) as FBSYMBOL ptr

	dim as integer dtype, lgt, mode, ptrcnt
	dim as FBSYMBOL ptr proc, sym, subtype
	static as zstring ptr sname

	function = NULL

	'' mode
	mode = cFunctionMode( )

	proc = symbPreAddProc( NULL )

	'' ('(' Parameters? ')')
	if( lexGetToken( ) = CHAR_LPRNT ) then
        lexSkipToken( )

		cParameters( proc, mode, TRUE )
		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

    	if( lexGetToken( ) <> CHAR_RPRNT ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if

		lexSkipToken( )
	end if

	'' (AS SymbolType)?
	if( lexGetToken( ) = FB_TK_AS ) then
		lexSkipToken( )

		if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
			exit function
		end if

    	'' check for invalid types
    	select case as const dtype
    	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		hReportError( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS )
    		exit function

    	case FB_DATATYPE_VOID
    		hReportError( FB_ERRMSG_INVALIDDATATYPES )
    		exit function
    	end select

	else
		'' if it's a function and type was not given, it can't be guessed
		if( isfunction ) then
			hReportError( FB_ERRMSG_EXPECTEDRESTYPE )
			exit function
		end if

		subtype = NULL
		dtype = FB_DATATYPE_VOID
		ptrcnt = 0
	end if

	sname = hMangleFuncPtrName( proc, dtype, subtype, mode )

	'' already exists?
	sym = symbFindByNameAndClass( sname, FB_SYMBCLASS_PROC, TRUE )
	if( sym <> NULL ) then
		return sym
	end if

	'' create a new prototype
	function = symbAddPrototype( proc, sname, NULL, NULL, _
							     dtype, subtype, ptrcnt, _
							     0, mode, TRUE, TRUE )

end function


'':::::
''SymbolType      =   UNSIGNED? (
''				      ANY
''				  |   CHAR|BYTE
''				  |	  SHORT|WORD
''				  |	  INTEGER|LONG|DWORD
''				  |   SINGLE
''				  |   DOUBLE
''                |   STRING ('*' NUM_LIT)?
''                |   USERDEFTYPE
''				  |   (FUNCTION|SUB) ('(' args ')') (AS SymbolType)?
''				      (PTR|POINTER)* .
''
function cSymbolType _
	( _
		byref dtype as integer, _
		byref subtype as FBSYMBOL ptr, _
		byref lgt as integer, _
		byref ptrcnt as integer, _
		byval checkptr as integer = TRUE _
	) as integer

    dim as integer isunsigned, isfunction, allowptr

	function = FALSE

	lgt 	= 0
	dtype 	= INVALID
	subtype = NULL
	ptrcnt	= 0

	allowptr = TRUE

	'' UNSIGNED?
	isunsigned = hMatch( FB_TK_UNSIGNED )

	''
	select case as const lexGetToken( )
	case FB_TK_ANY
		lexSkipToken( )
		dtype = FB_DATATYPE_VOID
		lgt = 0

	case FB_TK_BYTE
		lexSkipToken( )
		dtype = FB_DATATYPE_BYTE
		lgt = 1
	case FB_TK_UBYTE
		lexSkipToken( )
		dtype = FB_DATATYPE_UBYTE
		lgt = 1

	case FB_TK_SHORT
		lexSkipToken( )
		dtype = FB_DATATYPE_SHORT
		lgt = 2

	case FB_TK_USHORT
		lexSkipToken( )
		dtype = FB_DATATYPE_USHORT
		lgt = 2

	case FB_TK_INTEGER, FB_TK_LONG
		lexSkipToken( )
		dtype = FB_DATATYPE_INTEGER
		lgt = FB_INTEGERSIZE

	case FB_TK_UINT
		lexSkipToken( )
		dtype = FB_DATATYPE_UINT
		lgt = FB_INTEGERSIZE

	case FB_TK_LONGINT
		lexSkipToken( )
		dtype = FB_DATATYPE_LONGINT
		lgt = FB_INTEGERSIZE*2

	case FB_TK_ULONGINT
		lexSkipToken( )
		dtype = FB_DATATYPE_ULONGINT
		lgt = FB_INTEGERSIZE*2

	case FB_TK_SINGLE
		lexSkipToken( )
		dtype = FB_DATATYPE_SINGLE
		lgt = 4

	case FB_TK_DOUBLE
		lexSkipToken( )
		dtype = FB_DATATYPE_DOUBLE
		lgt = 8

	case FB_TK_STRING
		'' fixed-len?
		if( lexGetLookAhead(1) = CHAR_STAR ) then
			lexSkipToken( )
			lexSkipToken( )
			dtype = FB_DATATYPE_FIXSTR
			if( cConstExprValue( lgt ) = FALSE ) then
				exit function
			end if

			'' plus the null-term
			lgt += 1

			'' min 1 char (+ null-term)
			if( lgt <= 1 ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end if
			allowptr = FALSE

		'' var-len string..
		else
			dtype = FB_DATATYPE_STRING
			lgt = FB_STRDESCLEN
			lexSkipToken( )
		end if

	case FB_TK_ZSTRING, FB_TK_WSTRING

		if( lexGetToken( ) = FB_TK_ZSTRING ) then
			dtype = FB_DATATYPE_CHAR
		else
			dtype = FB_DATATYPE_WCHAR
		end if

		lexSkipToken( )

		'' fixed-len?
		if( lexGetToken( ) = CHAR_STAR ) then
			lexSkipToken( )
			if( cConstExprValue( lgt ) = FALSE ) then
				exit function
			end if

			'' min 1 char
			if( lgt < 1 ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end if
			allowptr = FALSE

			'' note: len of "wstring * expr" symbols will be actually
			''       the number of chars times sizeof(wstring), so
			''		 always use symbGetWstrLen( ) to retrieve the
			''       len in characters, not the bytes
			if( dtype = FB_DATATYPE_WCHAR ) then
				lgt *= symbGetDataSize( FB_DATATYPE_WCHAR )
			end if

		'' pointer..
		else
    		lgt = 0
		end if

	case FB_TK_FUNCTION, FB_TK_SUB
	    isfunction = (lexGetToken( ) = FB_TK_FUNCTION)
	    lexSkipToken( )

		dtype = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION
		lgt = FB_POINTERSIZE
		ptrcnt = 1

		subtype = cSymbolTypeFuncPtr( isfunction )
		if( subtype = NULL ) then
			exit function
		end if

	case else
		dim as FBSYMBOL ptr sym
		dim as FBSYMCHAIN ptr chain_

		chain_ = cIdentifier( )
		if( chain_ = NULL ) then
			if( hGetLastError( ) <> FB_ERRMSG_OK ) then
				exit function
			end if

		else
			do
				sym = chain_->sym
				select case symbGetClass( sym )
				case FB_SYMBCLASS_UDT
					lexSkipToken( )
					dtype = FB_DATATYPE_USERDEF
					subtype = sym
					lgt = symbGetLen( sym )
					exit do

			    case FB_SYMBCLASS_ENUM
					'' handle len( id{enum} '.' id{const} )
					if( lexGetLookAhead( 1 ) <> CHAR_DOT ) then
						lexSkipToken( )
						dtype = FB_DATATYPE_ENUM
						subtype = sym
						lgt = FB_INTEGERSIZE
						exit do
					end if

				case FB_SYMBCLASS_TYPEDEF
					lexSkipToken( )
					dtype = symbGetType( sym )
					subtype = symbGetSubtype( sym )
					lgt = symbGetLen( sym )
					ptrcnt = sym->ptrcnt
					exit do
				end select

				chain_ = symbChainGetNext( chain_ )
			loop while( chain_ <> NULL )
		end if
	end select

	''
	if( dtype <> INVALID ) then

		if( isunsigned ) then
			select case as const dtype
			case FB_DATATYPE_BYTE
				dtype = FB_DATATYPE_UBYTE
			case FB_DATATYPE_SHORT
				dtype = FB_DATATYPE_USHORT
			case FB_DATATYPE_INTEGER
				dtype = FB_DATATYPE_UINT
			case FB_DATATYPE_LONGINT
				dtype = FB_DATATYPE_ULONGINT
			case else
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end select
		end if

		'' (PTR|POINTER)*
		do
			select case lexGetToken( )
			case FB_TK_PTR, FB_TK_POINTER
				lexSkipToken( )
				dtype += FB_DATATYPE_POINTER
				ptrcnt += 1
			case else
				exit do
			end select
		loop

        if( ptrcnt > 0 ) then
			if( allowptr = FALSE ) then
				hReportError( FB_ERRMSG_SYNTAXERROR )
				exit function
			end if

			lgt = FB_POINTERSIZE

		else
			'' can't have forward typedef's if they aren't pointers
			if( dtype = FB_DATATYPE_FWDREF ) then
				hReportError( FB_ERRMSG_INCOMPLETETYPE )
				exit function

			elseif( lgt <= 0 ) then
				select case dtype
				case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
					'' LEN() and SIZEOF() allow Z|WSTRING to be used w/o PTR
					if( checkptr ) then
						hReportError( FB_ERRMSG_EXPECTEDPOINTER )
						exit function
					else
						lgt = symbGetDataSize( dtype )
					end if
				end select
			end if
		end if

		function = TRUE

	else
		if( isunsigned ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
	end if

end function

'':::::
private sub hSkipSymbol( )

	do
		lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		exit do
    	end if

    	select case lexGetClass()
    	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_KEYWORD

    	case else
    		exit do
    	end select
	loop

end sub

'':::::
'' Identifier	= (ID{namespace} '.')* ID
''				|  ID ('.' ID)* .
''
function cIdentifier _
	( _
		byval showerror as integer _
	) as FBSYMCHAIN ptr

    dim as FBSYMCHAIN ptr chain_

    chain_ = lexGetSymChain( )

    if( chain_ = NULL ) then
    	return NULL
    end if

    do while( symbGetClass( chain_->sym ) = FB_SYMBCLASS_NAMESPACE )
    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' '.'?
    	if( lexGetToken( ) <> CHAR_DOT ) then
    		exit do
    	end if

    	lexSkipToken( LEXCHECK_NOLOOKUP )

    	'' ID
    	if( lexGetToken( ) <> FB_TK_ID ) then
    		if( showerror ) then
    			hReportError( FB_ERRMSG_EXPECTEDIDENTIFIER )
    		end if

    		return NULL
    	end if

    	chain_ = symbLookupAt( chain_->sym, lexGetText( ) )
    	if( chain_ = NULL ) then
           	if( showerror ) then
           		hReportError( FB_ERRMSG_UNDEFINEDSYMBOL )
    		else
    			hSkipSymbol( )
           	end if

           	return NULL
    	end if
    loop

	function = chain_

end function


