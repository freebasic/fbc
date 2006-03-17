''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
function cConstExprValue( byref value as integer ) as integer
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
  	astDel( expr )

  	function = TRUE

end function

'':::::
function hMangleFuncPtrName( byval proc as FBSYMBOL ptr, _
							 byval typ as integer, _
							 byval subtype as FBSYMBOL ptr, _
					    	 byval mode as integer ) as zstring ptr static

    static as zstring * FB_MAXINTNAMELEN+1 mname
    dim as FBSYMBOL ptr p
    dim as integer i

    mname = "{fbfp}"

    p = symbGetProcHeadParam( proc )
    for i = 0 to symbGetProcParams( proc )-1
    	mname += "_"

    	if( p->subtype = NULL ) then
    		mname += hex( p->typ * cint(p->param.mode) )
    	else
    		mname += hex( p->subtype )
    	end if

    	p = symbGetParamNext( p )
    next

    mname += "@"

	if( subtype = NULL ) then
		mname += hex( typ )
	else
		mname += hex( subtype )
	end if

    mname += "@"

    mname += hex( mode )

	function = @mname

end function

'':::::
function cSymbolTypeFuncPtr( byval isfunction as integer ) as FBSYMBOL ptr
	dim as integer typ, lgt, mode, ptrcnt
	dim as FBSYMBOL ptr proc, sym, subtype
	static as zstring ptr sname

	function = NULL

	'' mode
	mode = cFunctionMode( )

	proc = symbPreAddProc( NULL )

	'' ('(' Parameters? ')')
	if( hMatch( CHAR_LPRNT ) ) then

		cParameters( proc, mode, TRUE )
		if( hGetLastError( ) <> FB_ERRMSG_OK ) then
			exit function
		end if

    	if( hMatch( CHAR_RPRNT ) = FALSE ) then
			hReportError( FB_ERRMSG_SYNTAXERROR )
			exit function
		end if
	end if

	'' (AS SymbolType)?
	if( hMatch( FB_TK_AS ) ) then
		if( cSymbolType( typ, subtype, lgt, ptrcnt ) = FALSE ) then
			exit function
		end if

	else
		'' if it's a function and type was not given, it can't be guessed
		if( isfunction ) then
			hReportError( FB_ERRMSG_EXPECTEDRESTYPE )
			exit function
		end if

		subtype = NULL
		typ = FB_DATATYPE_VOID
		ptrcnt = 0
	end if

	sname = hMangleFuncPtrName( proc, typ, subtype, mode )

	'' already exists?
	sym = symbFindByNameAndClass( sname, FB_SYMBCLASS_PROC, TRUE )
	if( sym <> NULL ) then
		return sym
	end if

	'' create a new prototype
	function = symbAddPrototype( proc, sname, NULL, NULL, _
							     typ, subtype, ptrcnt, _
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
function cSymbolType( byref typ as integer, _
					  byref subtype as FBSYMBOL ptr, _
					  byref lgt as integer, _
					  byref ptrcnt as integer, _
					  byval checkptr as integer = TRUE _
					) as integer

    dim as integer isunsigned, isfunction, allowptr
    dim s as FBSYMBOL ptr

	function = FALSE

	lgt 	= 0
	typ 	= INVALID
	subtype = NULL
	ptrcnt	= 0

	allowptr = TRUE

	'' UNSIGNED?
	isunsigned = hMatch( FB_TK_UNSIGNED )

	''
	select case as const lexGetToken( )
	case FB_TK_ANY
		lexSkipToken( )
		typ = FB_DATATYPE_VOID
		lgt = 0

	case FB_TK_BYTE
		lexSkipToken( )
		typ = FB_DATATYPE_BYTE
		lgt = 1
	case FB_TK_UBYTE
		lexSkipToken( )
		typ = FB_DATATYPE_UBYTE
		lgt = 1

	case FB_TK_SHORT
		lexSkipToken( )
		typ = FB_DATATYPE_SHORT
		lgt = 2

	case FB_TK_USHORT
		lexSkipToken( )
		typ = FB_DATATYPE_USHORT
		lgt = 2

	case FB_TK_INTEGER, FB_TK_LONG
		lexSkipToken( )
		typ = FB_DATATYPE_INTEGER
		lgt = FB_INTEGERSIZE

	case FB_TK_UINT
		lexSkipToken( )
		typ = FB_DATATYPE_UINT
		lgt = FB_INTEGERSIZE

	case FB_TK_LONGINT
		lexSkipToken( )
		typ = FB_DATATYPE_LONGINT
		lgt = FB_INTEGERSIZE*2

	case FB_TK_ULONGINT
		lexSkipToken( )
		typ = FB_DATATYPE_ULONGINT
		lgt = FB_INTEGERSIZE*2

	case FB_TK_SINGLE
		lexSkipToken( )
		typ = FB_DATATYPE_SINGLE
		lgt = 4

	case FB_TK_DOUBLE
		lexSkipToken( )
		typ = FB_DATATYPE_DOUBLE
		lgt = 8

	case FB_TK_STRING
		'' fixed-len?
		if( lexGetLookAhead(1) = CHAR_STAR ) then
			lexSkipToken( )
			lexSkipToken( )
			typ = FB_DATATYPE_FIXSTR
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
			typ = FB_DATATYPE_STRING
			lgt = FB_STRDESCLEN
			lexSkipToken( )
		end if

	case FB_TK_ZSTRING, FB_TK_WSTRING

		if( lexGetToken( ) = FB_TK_ZSTRING ) then
			typ = FB_DATATYPE_CHAR
		else
			typ = FB_DATATYPE_WCHAR
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
			if( typ = FB_DATATYPE_WCHAR ) then
				lgt *= symbGetDataSize( FB_DATATYPE_WCHAR )
			end if

		'' pointer..
		else
    		lgt = 0
		end if

	case FB_TK_FUNCTION, FB_TK_SUB
	    isfunction = (lexGetToken( ) = FB_TK_FUNCTION)
	    lexSkipToken( )

		typ = FB_DATATYPE_POINTER + FB_DATATYPE_FUNCTION
		lgt = FB_POINTERSIZE
		ptrcnt = 1

		subtype = cSymbolTypeFuncPtr( isfunction )
		if( subtype = NULL ) then
			exit function
		end if

	case else
		s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_UDT )
		if( s <> NULL ) then
			lexSkipToken( )
			typ 	= FB_DATATYPE_USERDEF
			subtype = s
			lgt 	= symbGetLen( s )
		else
			s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_ENUM )
			if( s <> NULL ) then
				lexSkipToken( )
				typ 	= FB_DATATYPE_ENUM
				subtype = s
				lgt 	= FB_INTEGERSIZE
			else
				s = symbFindByClass( lexGetSymbol( ), FB_SYMBCLASS_TYPEDEF )
				if( s <> NULL ) then
					lexSkipToken( )
					typ 	= symbGetType( s )
					subtype = symbGetSubtype( s )
					lgt 	= symbGetLen( s )
					ptrcnt	= s->ptrcnt
			    end if
			end if
		end if
	end select

	''
	if( typ <> INVALID ) then

		if( isunsigned ) then
			select case as const typ
			case FB_DATATYPE_BYTE
				typ = FB_DATATYPE_UBYTE
			case FB_DATATYPE_SHORT
				typ = FB_DATATYPE_USHORT
			case FB_DATATYPE_INTEGER
				typ = FB_DATATYPE_UINT
			case FB_DATATYPE_LONGINT
				typ = FB_DATATYPE_ULONGINT
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
				typ += FB_DATATYPE_POINTER
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
			if( typ = FB_DATATYPE_FWDREF ) then
				hReportError( FB_ERRMSG_INCOMPLETETYPE )
				exit function

			elseif( lgt <= 0 ) then
				select case typ
				case FB_DATATYPE_CHAR, FB_DATATYPE_WCHAR
					'' LEN() and SIZEOF() allow Z|WSTRING to be used w/o PTR
					if( checkptr ) then
						hReportError( FB_ERRMSG_EXPECTEDPOINTER )
						exit function
					else
						lgt = symbGetDataSize( typ )
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

