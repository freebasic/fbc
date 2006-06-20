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
    	if( errReport( FB_ERRMSG_EXPECTEDEXPRESSION ) = FALSE ) then
    		exit function
    	else
    		'' error recovery: fake an value
    		value = 0
    		return TRUE
    	end if

	else
		if( astIsCONST( expr ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDCONST ) = FALSE ) then
				exit function
    		else
    			'' error recovery: fake an value
    			astDelTree( expr )
    			value = 0
    			return TRUE
			end if
		end if
    end if

	value = astGetValueAsInt( expr )
  	astDelNode( expr )

  	function = TRUE

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
		if( errGetLast( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

    	if( lexGetToken( ) <> CHAR_RPRNT ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			else
				'' error recovery: skip until next ')'
				hSkipUntil( CHAR_RPRNT, TRUE )
			end if
		else
			lexSkipToken( )
		end if
	end if

	'' (AS SymbolType)?
	if( lexGetToken( ) = FB_TK_AS ) then
		lexSkipToken( )

		if( cSymbolType( dtype, subtype, lgt, ptrcnt ) = FALSE ) then
			if( errReport( FB_ERRMSG_EXPECTEDIDENTIFIER ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a type
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL
				ptrcnt = 0
			end if
		end if

    	'' check for invalid types
    	select case as const dtype
    	case FB_DATATYPE_FIXSTR, FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
    		if( errReport( FB_ERRMSG_CANNOTRETURNFIXLENFROMFUNCTS ) = FALSE ) then
    			exit function
			else
				'' error recovery: fake a type
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL
				ptrcnt = 0
			end if

    	case FB_DATATYPE_VOID
    		if( errReport( FB_ERRMSG_INVALIDDATATYPES ) = FALSE ) then
    			exit function
			else
				'' error recovery: fake a type
				dtype += FB_DATATYPE_POINTER
				subtype = NULL
				ptrcnt = 1
			end if
    	end select

	else
		'' if it's a function and type was not given, it can't be guessed
		if( isfunction ) then
			if( errReport( FB_ERRMSG_EXPECTEDRESTYPE ) = FALSE ) then
				exit function
			else
				'' error recovery: fake a type
				dtype = FB_DATATYPE_INTEGER
				subtype = NULL
				ptrcnt = 0
			end if

		else
			dtype = FB_DATATYPE_VOID
			subtype = NULL
			ptrcnt = 0
		end if
	end if

	sname = symbMangleFunctionPtr( proc, dtype, subtype, mode )

	'' already exists?
	sym = symbLookupByNameAndClass( symbGetCurrentNamespc( ), _
									sname, _
									FB_SYMBCLASS_PROC, _
									TRUE )
	if( sym <> NULL ) then
		return sym
	end if

	'' create a new prototype
	sym = symbAddPrototype( proc, sname, NULL, NULL, _
							dtype, subtype, ptrcnt, _
							0, mode, TRUE, TRUE )

	if( sym <> NULL ) then
		symbGetAttrib( sym ) or= FB_SYMBATTRIB_FUNCPTR
	end if

	function = sym

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
		if( lexGetLookAhead( 1 ) = CHAR_STAR ) then
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
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				else
					'' error recovery: fake a len
					lgt = 2
				end if
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
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				else
					'' error recovery: fake a len
					lgt = 1
				end if
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
			if( errGetLast( ) <> FB_ERRMSG_OK ) then
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
					lexSkipToken( )
					dtype = FB_DATATYPE_ENUM
					subtype = sym
					lgt = FB_INTEGERSIZE
					exit do

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
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				end if
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
				if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
					exit function
				else
					'' error recovery: remove pointers
					ptrcnt = 0
					dtype mod= FB_DATATYPE_POINTER
					lgt = symbGetDataSize( dtype )
				end if

			else
				lgt = FB_POINTERSIZE
			end if

		else
			'' can't have forward typedef's if they aren't pointers
			if( dtype = FB_DATATYPE_FWDREF ) then
				if( errReport( FB_ERRMSG_INCOMPLETETYPE ) = FALSE ) then
					exit function
				else
					'' error recovery: fake a type
					dtype = FB_DATATYPE_POINTER + FB_DATATYPE_VOID
					subtype = NULL
					ptrcnt = 1
				end if

			elseif( lgt <= 0 ) then
				select case dtype
				case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
					'' LEN() and SIZEOF() allow Z|WSTRING to be used w/o PTR
					if( checkptr ) then
						if( errReport( FB_ERRMSG_EXPECTEDPOINTER ) = FALSE ) then
							exit function
						else
							'' error recovery: make pointer
							dtype += FB_DATATYPE_POINTER
							lgt = FB_POINTERSIZE
						end if

					else
						lgt = symbGetDataSize( dtype )
					end if
				end select
			end if
		end if

		function = TRUE

	else
		if( isunsigned ) then
			if( errReport( FB_ERRMSG_SYNTAXERROR ) = FALSE ) then
				exit function
			else
				return TRUE
			end if
		end if
	end if

end function


