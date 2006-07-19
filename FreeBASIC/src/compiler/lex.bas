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


'' lexical scanner
''
''
'' chng: sep/2004 written [v1ctor]
''       nov/2005 unicode support added [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"
#include once "inc\pp.bi"
#include once "inc\ast.bi"

declare sub 		lexReadUTF8				( )

declare sub 		lexReadUTF16LE			( )

declare sub 		lexReadUTF16BE			( )

declare sub 		lexReadUTF32LE			( )

declare sub 		lexReadUTF32BE			( )

declare sub 		hMultiLineComment		( )

const UINVALID as uinteger = cuint( INVALID )

'' globals
	dim shared as LEX_CTX ctxTB( 0 TO FB_MAXINCRECLEVEL-0 )
	dim shared as LEX_CTX ptr lex
	dim shared as string curline
	dim shared as integer insidemacro

'':::::
'' only update the line count if not inside a multi-line macro
#define UPDATE_LINENUM( ) 		_
	if( lex->deflen = 0 ) then 	:_
		lex->linenum += 1 		:_
	end if

'':::::
sub lexPushCtx( )

	lex += 1

end sub

'':::::
sub lexPopCtx( )

	'' free dynamic strings used in macro expansions
	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
		DZstrAllocate( lex->deftext, 0 )
	else
		DWstrAllocate( lex->deftextw, 0 )
	end if

	lex -= 1

end sub


'':::::
sub lexInit _
	( _
		byval isinclude as integer _
	)

    dim as integer i
    dim as FBTOKEN ptr n

	if( env.includerec = 0 ) then
		lex = @ctxTB(0)
	end if

	'' create a circular list
	lex->k = 0

	lex->head = @lex->tokenTB(0)
	lex->tail = lex->head

	n = lex->head
	for i = 0 to FB_LEX_MAXK-1
		n->next = @lex->tokenTB(i+1)
		n = n->next
	next
	n->next = lex->head

	''
	for i = 0 to FB_LEX_MAXK
		lex->tokenTB(i).id = INVALID
	next

	lex->currchar = UINVALID
	lex->lahdchar = UINVALID

	lex->linenum = 1
	lex->lasttk_id = INVALID

	lex->reclevel = 0
	lex->currmacro = NULL

	''
	lex->bufflen = 0
	lex->deflen	= 0

	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
		lex->buffptr = NULL
		lex->defptr = NULL
		DZstrAllocate( lex->deftext, 0 )
	else
		lex->buffptrw = NULL
		lex->defptrw = NULL
		DWstrAllocate( lex->deftextw, 0 )
	end if

	''
	lex->filepos = 0
	lex->lastfilepos = 0

	'' only if it's not on an inc file
	if( env.includerec = 0 ) then
		curline = ""
		insidemacro = FALSE
	end if

	if( isinclude = FALSE ) then
		ppInit( )
	end if

end sub

'':::::
sub lexEnd( )

	if( env.includerec = 0 ) then
		curline = ""
	end if

	ppEnd( )

end sub

'':::::
private function hReadChar as uinteger static
    dim as uinteger char

	'' any #define'd text?
	if( lex->deflen > 0 ) then

		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
			char = *lex->defptr
		else
			char = *lex->defptrw
		end if

		if( env.clopt.debug ) then
			if( env.includerec = 0 ) then
				if( insidemacro = FALSE ) then
					insidemacro = TRUE
					curline += " [Macro Expansion: "
				end if

				select case as const char
				case 0, CHAR_CR, CHAR_LF

				case else
					curline += chr( char )
				end select
			end if
		end if

	else

		'' buffer empty?
		if( lex->bufflen = 0 ) then
			if( eof( env.inf.num ) = FALSE ) then
				lex->filepos = seek( env.inf.num )

				select case as const env.inf.format
				case FBFILE_FORMAT_ASCII
					if( get( #env.inf.num, , lex->buff ) = 0 ) then
						lex->bufflen = seek( env.inf.num ) - lex->filepos
						lex->buffptr = @lex->buff
					end if

				case FBFILE_FORMAT_UTF8
					lexReadUTF8( )

				case FBFILE_FORMAT_UTF16LE
				    lexReadUTF16LE( )

				case FBFILE_FORMAT_UTF16BE
					lexReadUTF16BE( )

				case FBFILE_FORMAT_UTF32LE
					lexReadUTF32LE( )

				case FBFILE_FORMAT_UTF32BE
					lexReadUTF32BE( )

				end select

			end if
		end if

		''
		if( lex->bufflen > 0 ) then
			if( env.inf.format = FBFILE_FORMAT_ASCII ) then
				char = *lex->buffptr
			else
				char = *lex->buffptrw
			end if

		else
			char = 0
		end if

		'' only save current src line if it's not on an inc file
		if( env.clopt.debug ) then
			if( env.includerec = 0 ) then
				if( insidemacro ) then
					insidemacro = FALSE
					curline += " ] "
				end if

				select case as const char
				case 0, CHAR_CR, CHAR_LF

				case else
					curline += chr( char )
				end select
			end if
		end if

	end if

	function = char

end function

'':::::
function lexEatChar as uinteger static

    ''
    function = lex->currchar

	'' update if a look ahead char wasn't read already
	if( lex->lahdchar = UINVALID ) then

		'' #define'd text?
		if( lex->deflen > 0 ) then
			lex->deflen -= 1

			if( env.inf.format = FBFILE_FORMAT_ASCII ) then
				lex->defptr += 1
			else
				lex->defptrw += 1
			end if

		'' input stream (not EOF?)
		elseif( lex->currchar <> 0 ) then
			lex->bufflen -= 1

			if( env.inf.format = FBFILE_FORMAT_ASCII ) then
				lex->buffptr += 1
			else
				lex->buffptrw += 1
			end if

		end if

    	lex->currchar = UINVALID

    '' current= lookahead; lookhead = INVALID
    else
    	lex->currchar = lex->lahdchar
    	lex->lahdchar = UINVALID
	end if

end function

'':::::
private sub hSkipChar static

	'' #define'd text?
	if( lex->deflen > 0 ) then
		lex->deflen -= 1

		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
			lex->defptr += 1
		else
			lex->defptrw += 1
		end if

	'' input stream (not EOF?)
	elseif( lex->currchar <> 0 ) then
		lex->bufflen -= 1

		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
			lex->buffptr += 1
		else
			lex->buffptrw += 1
		end if

	end if

end sub

'':::::
function lexCurrentChar _
	( _
		byval skipwhitespc as integer = FALSE _
	) as uinteger static

    if( lex->currchar = UINVALID ) then
    	lex->currchar = hReadChar( )
    end if

    if( skipwhitespc ) then
    	do while( (lex->currchar = CHAR_TAB) or (lex->currchar = CHAR_SPACE) )
    		lexEatChar( )
    		lex->currchar = hReadChar( )
    	loop
    end if

    function = lex->currchar

end function

'':::::
function lexGetLookAheadChar _
	( _
		byval skipwhitespc as integer = FALSE _
	) as uinteger

	if( lex->lahdchar = UINVALID ) then
		hSkipChar( )
		lex->lahdchar = hReadChar( )
	end if

    if( skipwhitespc ) then
    	do while( (lex->lahdchar = CHAR_TAB) or (lex->lahdchar = CHAR_SPACE) )
    		hSkipChar( )
    		lex->lahdchar = hReadChar( )
    	loop
    end if

	function = lex->lahdchar

end function

''
''char classes:
''
''ALPHA          'A' - 'Z'
''DIGIT          '0' - '9'
''HEXDIG         'A' - 'F' | DIGIT
''OCTDIG         '0' - '7'
''BINDIG         '0' | '1'
''ALPHADIGIT     ALPHA | DIGIT
''ISUFFIX        '%' | '&'
''FSUFFIX        '!' | '#'
''SUFFIX         ISUFFIX | FSUFFIX | '$'
''
''EXPCHAR        'D' | 'E'
''
''OPERATOR       '=' | '<' | '>' | '+' | '-' | '*' | '/' | '\' | '^'
''DELIMITER      '.' | ':' | ',' | ';' | '"' | '''
''

'':::::
''indentifier    = (ALPHA | '_') { [ALPHADIGIT | '_' ] } [SUFFIX].
''
private sub hReadIdentifier _
	( _
		byval pid as zstring ptr, _
		byref tlen as integer, _
		byref typ as integer, _
		byval flags as LEXCHECK _
	) static

	dim as uinteger c
	dim as integer skipchar

	'' (ALPHA | '_' )
	*pid = lexEatChar( )
	pid += 1
	tlen += 1

	skipchar = FALSE

	'' { [ALPHADIGIT | '_' ] }
	do
		c = lexCurrentChar( )
		select case as const c
		case CHAR_AUPP to CHAR_ZUPP, _
			 CHAR_ALOW to CHAR_ZLOW, _
			 CHAR_0 to CHAR_9, _
			 CHAR_UNDER

		case CHAR_DOT
			if( (flags and LEXCHECK_IDPERIOD) = 0 ) then
				exit do
			end if

		case else
			exit do
		end select

		lexEatChar( )

		if( skipchar = FALSE ) then
			'' no more room?
			if( tlen = FB_MAXNAMELEN ) then
 				'' show warning?
 				if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
					'' just once..
					flags or= LEXCHECK_NOLINECONT
	 				errReportWarn( FB_WARNINGMSG_IDNAMETOOBIG )
 				end if

				skipchar = TRUE

			else
				*pid = c
				pid += 1
				tlen += 1
			end if
		end if

	loop

	'' null-term
	*pid = 0

	'' [SUFFIX]
	typ = INVALID

	if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then
		select case as const lexCurrentChar( )
		'' '%' or '&'?
		case FB_TK_INTTYPECHAR, FB_TK_LNGTYPECHAR
			typ = FB_DATATYPE_INTEGER

		'' '!'?
		case FB_TK_SGNTYPECHAR
			typ = FB_DATATYPE_SINGLE

		'' '#'?
		case FB_TK_DBLTYPECHAR
			'' isn't it a '##'?
			if( lexGetLookAheadChar( ) <> FB_TK_DBLTYPECHAR ) then
				typ = FB_DATATYPE_DOUBLE
			end if

		'' '$'?
		case FB_TK_STRTYPECHAR
			typ = FB_DATATYPE_STRING
		end select

		if( typ <> INVALID ) then
			c = lexEatChar( )
		end if

	end if

end sub

''::::
''hex_oct_bin     = 'H' HEXDIG+
''                | 'O' OCTDIG+
''                | 'B' BINDIG+
''
private function hReadNonDecNumber _
	( _
		byref pnum as zstring ptr, _
		byref tlen as integer, _
		byref islong as integer, _
		byval flags as LEXCHECK _
	) as ulongint static

	dim as uinteger value, c, first_c
	dim as ulongint value64
	dim as integer lgt
	dim as integer skipchar

	islong = FALSE
	value = 0
	lgt = 0
	skipchar = FALSE

	select case as const lexCurrentChar( )
	'' hex
	case CHAR_HUPP, CHAR_HLOW
		pnum[0] = CHAR_AMP
		pnum[1] = CHAR_HLOW
		pnum += 2
		tlen += 2
		lexEatChar( )

		'' skip trailing zeroes
		while( lexCurrentChar( ) = CHAR_0 )
			*pnum = CHAR_0
			pnum += 1
			tlen += 1
			lexEatChar( )
		wend

		do
			select case lexCurrentChar( )
			case CHAR_ALOW to CHAR_FLOW, CHAR_AUPP to CHAR_FUPP, CHAR_0 to CHAR_9
				c = lexEatChar( )
				if( skipchar = FALSE ) then
                	*pnum = c
                	pnum += 1
                	tlen += 1

                	c -= CHAR_0
                	if( c > 9 ) then
						c -= (CHAR_AUPP - CHAR_9 - 1)
                	end if
                	if( c > 16 ) then
                  		c -= (CHAR_ALOW - CHAR_AUPP)
                	end if

					lgt += 1
					if( lgt > 8 ) then
						if( lgt = 9 ) then
							islong = TRUE
				    		value64 = (culngint( value ) * 16) + c

				    	elseif( lgt = 17 ) then
				    		if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
				    			errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
				    		end if
							skipchar = TRUE

						else
				    		value64 = (value64 * 16) + c
				    	end if

					else
                		value = (value * 16) + c
                	end if
                end if

			case else
				exit do
			end select
		loop

	'' oct
	case CHAR_OUPP, CHAR_OLOW
		pnum[0] = CHAR_AMP
		pnum[1] = CHAR_OLOW
		pnum += 2
		tlen += 2
		lexEatChar( )

		'' skip trailing zeroes
		while( lexCurrentChar( ) = CHAR_0 )
			*pnum = CHAR_0
			pnum += 1
			tlen += 1
			lexEatChar( )
		wend

		first_c = lexCurrentChar( )
		do
			select case lexCurrentChar( )
			case CHAR_0 to CHAR_7
				c = lexEatChar( )

				if( skipchar = FALSE ) then
                	*pnum = c
                	pnum += 1
                	tlen += 1

                	c -= CHAR_0

					lgt += 1
					if( lgt > 10 ) then
						select case as const lgt
						case 11
							if( first_c > CHAR_3 ) then
								islong = TRUE
								value64 = (culngint( value ) * 8) + c
							else
								value = (value * 8) + c
							end if

						case 12
							if( islong = FALSE ) then
								islong = TRUE
								value64 = culngint( value )
							end if
							value64 = (value64 * 8) + c

						case 22
							if( first_c > CHAR_1 ) then
								if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
									errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
								end if
								skipchar = TRUE
							else
								value64 = (value64 * 8) + c
							end if

						case 23
							if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
								errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
							end if
							skipchar = TRUE

						case else
							value64 = (value64 * 8) + c
						end select

					else
						value = (value * 8) + c
					end if
				end if

			case else
				exit do
			end select
		loop

	'' bin
	case CHAR_BUPP, CHAR_BLOW
		pnum[0] = CHAR_AMP
		pnum[1] = CHAR_BLOW
		pnum += 2
		tlen += 2
		lexEatChar( )

		'' skip trailing zeroes
		while( lexCurrentChar( ) = CHAR_0 )
			*pnum = CHAR_0
			pnum += 1
			tlen += 1
			lexEatChar( )
		wend

		do
			select case lexCurrentChar( )
			case CHAR_0, CHAR_1
				c = lexEatChar( )
				if( skipchar = FALSE ) then
                	*pnum = c
                	pnum += 1
                	tlen += 1

                	c -= CHAR_0

					lgt += 1
					if( lgt > 32 ) then
						if( lgt = 33 ) then
							islong = TRUE
				    		value64 = (culngint( value ) * 2) + c

				    	elseif( lgt = 65 ) then
				    		if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
				    			errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
				    		end if
				    		skipchar = TRUE

				    	else
				    		value64 = (value64 * 2) + c
				    	end if

					else
						value = (value * 2) + c
					end if
				end if

			case else
				exit do
			end select
		loop

	case else
		exit function
	end select

	if( lgt = 0 ) then
		*pnum = CHAR_0
		pnum += 1
		tlen += 1
	end if

	if( islong = FALSE ) then
		function = value
	else
		function = value64
	end if

end function

'':::::
''float           = DOT DIGIT { DIGIT } [FSUFFIX | { EXPCHAR [opadd] DIGIT { DIGIT } } | ].
''
private sub hReadFloatNumber _
	( _
		byref pnum as zstring ptr, _
		byref tlen as integer, _
		byref typ as integer, _
		byval flags as LEXCHECK _
	) static

    dim as uinteger c
    dim as integer llen
    dim as integer skipchar

	typ = FB_DATATYPE_DOUBLE
	llen = tlen
	skipchar = FALSE

	'' DIGIT { DIGIT }
	do
		c = lexCurrentChar( )
		select case c
		case CHAR_0 to CHAR_9
			lexEatChar( )
			if( skipchar = FALSE ) then
				*pnum = c
				pnum += 1
				tlen += 1
			end if
		case else
			exit do
		end select

		'' no more room?
		if( tlen = FB_MAXNUMLEN ) then
			'' not set yet?
			if( skipchar = FALSE ) then
				skipchar = TRUE
			else
 				'' show warning?
 				if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
 					'' just once..
 					flags or= LEXCHECK_NOLINECONT
 					errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
				end if
			end if
		end if
	loop

	'' [FSUFFIX | { EXPCHAR [opadd] DIGIT { DIGIT } } | ]
	select case as const lexCurrentChar( )
	'' '!' | 'F' | 'f'
	case FB_TK_SGNTYPECHAR, CHAR_FUPP, CHAR_FLOW
		if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then
			c = lexEatChar( )
		end if
		typ = FB_DATATYPE_SINGLE

	'' '#'
	case FB_TK_DBLTYPECHAR
		if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then
			c = lexEatChar( )
		end if
		typ = FB_DATATYPE_DOUBLE

	case CHAR_ELOW, CHAR_EUPP, CHAR_DLOW, CHAR_DUPP
		'' EXPCHAR
		c = lexEatChar( )
		if( skipchar = FALSE ) then
			*pnum = CHAR_ELOW
			pnum += 1
			tlen += 1
		end if

		'' [opadd]
		c = lexCurrentChar( )
		if( (c = CHAR_PLUS) or (c = CHAR_MINUS) ) then
			lexEatChar( )
			if( skipchar = FALSE ) then
				*pnum = c
				pnum += 1
				tlen += 1
			end if
		end if

		do
			c = lexCurrentChar( )
			select case as const c
			case CHAR_0 to CHAR_9
				lexEatChar( )
				if( skipchar = FALSE ) then
					*pnum = c
					pnum += 1
					tlen += 1
				end if
			case else
				exit do
			end select

			'' no more room?
			if( tlen = FB_MAXNUMLEN ) then
				'' not set yet?
				if( skipchar = FALSE ) then
					skipchar = TRUE
				else
 					'' show warning?
 					if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
 						'' just once..
 						flags or= LEXCHECK_NOLINECONT
 						errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
					end if
				end if
			end if
		loop

	end select

	if( tlen - llen = 0 ) then
		'' '0'
		*pnum = CHAR_0
		pnum += 1
		tlen += 1
	end if

end sub

'':::::
''number          = DIGIT dig_dot_nil i_fsufx_nil
''                | '.' float
''                | '&' hex_oct_bin
''
''dig_dot_nil     = DIGIT dig_dot_nil
''                | ('.'|EXPCHAR) float
''                | .
''
''i_fsufx_nil     = ISUFFIX                       # is integer
''                | FSUFFIX                       # is float
''                | .                             # is def### !!! context sensitive !!!
''
private sub hReadNumber _
	( _
		byval pnum as zstring ptr, _
		byref typ as integer, _
		byref tlen as integer, _
		byval flags as LEXCHECK _
	) static

	dim as uinteger c
	dim as integer isfloat, issigned, islong, forcedsign
	dim as ulongint value
	dim as integer skipchar

	isfloat    = FALSE
	issigned   = TRUE
	islong     = FALSE
	value	   = 0

	typ 	   = INVALID
	*pnum 	   = 0
	tlen 	   = 0
	skipchar   = FALSE

	c = lexEatChar( )

	select case as const c
	'' integer part
	case CHAR_0 to CHAR_9

		if( c <> CHAR_0 ) then
			*pnum = c
			pnum += 1
			tlen += 1
			value = c - CHAR_0
		end if

		do
			c = lexCurrentChar( )
			select case as const c
			case CHAR_0
				lexEatChar( )
				if( tlen > 0 ) then
					if( skipchar = FALSE ) then
						*pnum = CHAR_0
						pnum += 1
						tlen += 1
						value = (value shl 3) + (value shl 1)
					end if
				end if

			case CHAR_1 to CHAR_9
				lexEatChar( )
				if( skipchar = FALSE ) then
					*pnum = c
					pnum += 1
					tlen += 1
					value = (value shl 3) + (value shl 1) + (c - CHAR_0)
				end if

			case CHAR_DOT, CHAR_ELOW, CHAR_EUPP, CHAR_DLOW, CHAR_DUPP
				isfloat = TRUE
				if( c = CHAR_DOT ) then
					c = lexEatChar( )
					if( skipchar = FALSE ) then
						*pnum = CHAR_DOT
						pnum += 1
						tlen += 1
					end if
				end if

				hReadFloatNumber( pnum, tlen, typ, flags )
				exit do

			case else
				exit do
			end select

			if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then
				if( skipchar = FALSE ) then
					select case as const tlen
					case 10
						if( value > 2147483647ULL ) then
							issigned = FALSE
							if( value > 4294967295ULL ) then
								issigned = TRUE
								islong = TRUE
							end if
						end if

					case 11
						islong = TRUE
						issigned = TRUE

					case 19
						if( value > 9223372036854775807ULL ) then
							issigned = FALSE
						end if

					case 20
						issigned = FALSE
						if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
							if( (value and &h8000000000000000ULL) = 0 ) then
								errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
								skipchar = TRUE
							end if
						end if

					case 21
						if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
							errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
							skipchar = TRUE
						end if
					end select

					'' no more room?
					if( tlen = FB_MAXNUMLEN ) then
 						'' not set yet?
 						if( skipchar = FALSE ) then
 							skipchar = TRUE
 						else
 							'' show warning?
 							if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
 								'' just once..
 								flags or= LEXCHECK_NOLINECONT
 								errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
							end if
						end if
					end if
				end if
			end if

		loop

		if( tlen = 0 ) then
			*pnum = CHAR_0
			pnum += 1
			tlen = 1
		end if

	'' fractional part
	case CHAR_DOT
		isfloat = TRUE
		'' add '.'
		*pnum = CHAR_DOT
		pnum += 1
		tlen = 1
        hReadFloatNumber( pnum, tlen, typ, flags )

	'' hex, oct, bin
	case CHAR_AMP
		tlen = 0
		value = hReadNonDecNumber( pnum, tlen, islong, flags )
		'' it should be always assumed to be a signed (long)integer,
		'' the U(LL) suffix should be used otherwise
		issigned = TRUE
	end select

	'' null-term
	*pnum = 0

	'' check suffix type
	if( isfloat = FALSE ) then
		if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then

			'' 'U' | 'u'
			select case lexCurrentChar( )
			case CHAR_UUPP, CHAR_ULOW
				lexEatChar( )
				issigned = FALSE
				forcedsign = TRUE
			case else
				forcedsign = FALSE
			end select

			select case as const lexCurrentChar( )
			'' 'L' | 'l'
			case CHAR_LUPP, CHAR_LLOW
				lexEatChar( )
				'' 'LL'?
				c = lexCurrentChar( )
				if( (c = CHAR_LUPP) or (c = CHAR_LLOW) ) then
					lexEatChar( )
					islong = TRUE
					'' restore sign if needed
					if( forcedsign = FALSE ) then
						if( value > 2147483647ULL ) then
							if( value < 9223372036854775808ULL ) then
								issigned = TRUE
							end if
						end if
					end if
				else
					if( islong ) then
						if( skipchar = FALSE ) then
							if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
								errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
							end if
						end if
					end if
				end if

			'' '%' | '&'
			case FB_TK_INTTYPECHAR, FB_TK_LNGTYPECHAR
				lexEatChar( )
				if( islong ) then
					if( skipchar = FALSE ) then
						if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
							errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
						end if
					end if
				end if

			'' '!' | 'F' | 'f'
			case FB_TK_SGNTYPECHAR, CHAR_FUPP, CHAR_FLOW
				lexEatChar( )
				typ = FB_DATATYPE_SINGLE

			'' '#' | 'D' | 'd'
			case FB_TK_DBLTYPECHAR, CHAR_DUPP, CHAR_DLOW
				'' isn't it a '##'?
				if( lexGetLookAheadChar( ) <> FB_TK_DBLTYPECHAR ) then
					lexEatChar( )
					typ = FB_DATATYPE_DOUBLE
				end if

			end select

		end if
	end if

	if( typ = INVALID ) then
		if( isfloat = FALSE ) then
			if( islong ) then
				if( issigned ) then
					typ = FB_DATATYPE_LONGINT
				else
					typ = FB_DATATYPE_ULONGINT
				end if
			else
				if( issigned ) then
					typ = FB_DATATYPE_INTEGER
				else
					typ = FB_DATATYPE_UINT
				end if
			end if
		else
			typ = FB_DATATYPE_DOUBLE
		end if
	end if

end sub

'':::::
''string          = '"' { ANY_CHAR_BUT_QUOTE } '"'.   # less quotes
''
private function hReadString _
	( _
		byval ps as zstring ptr, _
		byval flags as LEXCHECK _
	) as integer static

	dim as integer tlen
	dim as integer skipchar
	dim as uinteger char

	*ps = 0
	tlen = 0
	skipchar = FALSE

	'' skip open quote?
	if( (flags and LEXCHECK_NOQUOTES) = 0 ) then
		lexEatChar( )

	'' read it too..
	else
		*ps = lexEatChar( )
		ps += 1
		tlen += 1
	end if

	do
		select case as const lexCurrentChar( )
		case 0, CHAR_CR, CHAR_LF
			exit do

		case CHAR_QUOTE
			lexEatChar( )

			'' check for double-quotes
			if( lexCurrentChar( ) <> CHAR_QUOTE ) then
				'' don't skip quotes?
				if( (flags and LEXCHECK_NOQUOTES) <> 0 ) then
					if( skipchar = FALSE ) then
						*ps = CHAR_QUOTE
						ps += 1
						tlen += 1
					end if
				end if

				exit do
			end if

		'' '\'?
		case CHAR_RSLASH
			'' escaping on? needed or "\\" would fail..
			if( env.opt.escapestr ) then
				lexEatChar( )

				if( skipchar = FALSE ) then
					*ps = CHAR_RSLASH
					ps += 1
					tlen += 1
				end if

				lexCurrentChar( )
			end if

		end select

		char = lexEatChar( )

		if( skipchar = FALSE ) then
			'' no more room?
			if( tlen = FB_MAXLITLEN ) then
				'' show warning?
				if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
					'' just once..
					flags or= LEXCHECK_NOLINECONT
					errReportWarn( FB_WARNINGMSG_LITSTRINGTOOBIG )
				end if

				skipchar = TRUE

			else
				*ps = char
				ps += 1
				tlen += 1
			end if
		end if

	loop

	'' null-term
	*ps = 0

	function = tlen

end function

'':::::
''string          = '"' { ANY_CHAR_BUT_QUOTE } '"'.   # less quotes
''
private function hReadWStr _
	( _
		byval ps as wstring ptr, _
		byval flags as LEXCHECK _
	) as integer static

	dim as integer tlen
	dim as integer skipchar
	dim as uinteger char

	*ps = 0
	tlen = 0
	skipchar = FALSE

	'' skip open quote?
	if( (flags and LEXCHECK_NOQUOTES) = 0 ) then
		lexEatChar( )

	'' read it too..
	else
		*ps = lexEatChar( )
		ps += 1
		tlen += 1
	end if

	do
		select case as const lexCurrentChar( )
		'' EOF or EOL?
		case 0, CHAR_CR, CHAR_LF
			exit do

		'' '"'?
		case CHAR_QUOTE
			lexEatChar( )

			'' check for double-quotes
			if( lexCurrentChar( ) <> CHAR_QUOTE ) then
				'' don't skip quotes?
				if( (flags and LEXCHECK_NOQUOTES) <> 0 ) then
					if( skipchar = FALSE ) then
						*ps = CHAR_QUOTE
						ps += 1
						tlen += 1
					end if
				end if

				exit do
			end if

		'' '\'?
		case CHAR_RSLASH
			'' escaping on? needed or "\\" would fail..
			if( env.opt.escapestr ) then
				lexEatChar( )

				if( skipchar = FALSE ) then
					*ps = CHAR_RSLASH
					ps += 1
					tlen += 1
				end if

				lexCurrentChar( )
			end if

		end select

		char = lexEatChar( )

		if( skipchar = FALSE ) then
			'' no more room?
			if( tlen = FB_MAXLITLEN ) then
				'' show warning?
				if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
					'' just once..
					flags or= LEXCHECK_NOLINECONT
					errReportWarn( FB_WARNINGMSG_LITSTRINGTOOBIG )
				end if

				skipchar = TRUE

			else
				*ps = char
				ps += 1
				tlen += 1
			end if
		end if
	loop

	'' null-term
	*ps = 0

	function = tlen

end function

'':::::
sub lexNextToken _
	( _
		byval t as FBTOKEN ptr, _
		byval flags as LEXCHECK _
	) static

	dim as uinteger char
	dim as integer islinecont, lgt, readfullid
	dim as FBSYMCHAIN ptr chain_

re_read:
	t->text[0] = 0									'' t.text = ""
	t->len = 0
	t->ppos = 0
	t->sym_chain = NULL

	'' skip white space
	islinecont = FALSE
	do
		char = lexCurrentChar( )

		'' !!!FIXME!!! this shouldn't be here
		'' only emit current src line if it's not on an inc file
		if( env.clopt.debug ) then
			if( env.includerec = 0 ) then
				if( (char = CHAR_CR) or (char = CHAR_LF) or (char = 0) ) then
					astAdd( astNewLIT( curline ) )
					curline = ""
				end if
			end if
		end if

		select case as const char
		'' EOF?
		case 0
			t->id = FB_TK_EOF
			t->class = FB_TKCLASS_DELIMITER
			exit sub

		'' line continuation?
		case CHAR_UNDER

			'' alread skipping?
			if( islinecont ) then
				lexEatChar( )
				continue do
			end if

			'' check for line cont?
			if( (flags and LEXCHECK_NOLINECONT) = 0 ) then

				'' is next char a valid identifier char? then, read it
				select case as const lexGetLookAheadChar( )
				case CHAR_AUPP to CHAR_ZUPP, CHAR_ALOW to CHAR_ZLOW, _
					 CHAR_0 to CHAR_9, CHAR_UNDER
                	goto read_id

				'' otherwise, skip until new-line is found
				case else
					lexEatChar( )
					islinecont = TRUE
					continue do
				end select

			'' else, take it as-is
			else
				exit do
			end if

		'' EOL?
		case CHAR_CR, CHAR_LF
			lexEatChar( )

			'' CRLF on DOS, LF only on *NIX
			if( char = CHAR_CR ) then
				if( lexCurrentChar( ) = CHAR_LF ) then
					lexEatChar( )
				end if
			end if

			if( islinecont = FALSE ) then
				t->id = FB_TK_EOL
				t->class = FB_TKCLASS_DELIMITER
				t->len = 1
				t->text[0] = CHAR_LF					'' t.text = chr( 10 )
				t->text[1] = 0                          '' /
				exit sub

			else
				UPDATE_LINENUM( )
				env.stmtcnt += 1
				islinecont = FALSE
				continue do
			end if

		'' white-space?
		case CHAR_TAB, CHAR_SPACE
			if( islinecont = FALSE ) then
				if( (flags and LEXCHECK_NOWHITESPC) <> 0 ) then
					exit do
				end if
			end if

			lexEatChar( )

		''
		case else
			if( islinecont = FALSE ) then
				exit do
			end if

			lexEatChar( )
		end select

	loop

	lex->lastfilepos = lex->filepos + (lex->buffptr - @lex->buff) - 1

	select case as const char
	'' '.'?
	case CHAR_DOT

	    '' only check for fpoint literals if not inside a comment or parsing an $include
	    if( (flags and (LEXCHECK_NOLINECONT or LEXCHECK_NOSUFFIX)) = 0 ) then

	    	dim as uinteger lachar
	    	lachar = lexGetLookAheadChar( TRUE )

	    	'' '0' .. '9'?
	    	if( (lachar >= CHAR_0) and (lachar <= CHAR_9) ) then
				goto read_number
			end if

		end if

		goto read_char

	'' '&'?
	case CHAR_AMP
		select case lexGetLookAheadChar( )
		case CHAR_HUPP, CHAR_HLOW, CHAR_OUPP, CHAR_OLOW, CHAR_BUPP, CHAR_BLOW
			goto read_number
		end select

		t->class = FB_TKCLASS_OPERATOR
		t->id = lexEatChar( )
		t->len = 1
		t->dtype = t->id
		t->text[0] = char                   	'' t.text = chr( char )
		t->text[1] = 0                          '' /

	'' '0' .. '9'?
	case CHAR_0 to CHAR_9
read_number:
		hReadNumber( @t->text, t->id, t->len, flags )
		t->class = FB_TKCLASS_NUMLITERAL
		t->dtype = t->id

	'' 'A' .. 'Z', 'a' .. 'z'?
	case CHAR_AUPP to CHAR_ZUPP, CHAR_ALOW to CHAR_ZLOW
read_id:
		t->len = 0
		hReadIdentifier( @t->text, t->len, t->dtype, flags )

		'' use the special hash tb?
		if( (flags and LEXCHECK_KEYHASHTB) <> 0 ) then
			t->sym_chain = symbLookupAtTb( lex->kwhashtb, @t->text )
			'' not found?
			if( t->sym_chain = NULL ) then
				t->id = FB_TK_ID
				t->class = FB_TKCLASS_IDENTIFIER
			else
				t->id = t->sym_chain->sym->key.id
				t->class = t->sym_chain->sym->key.class
			end if

			exit sub
		end if

		'' don't search for symbols?
		if( (flags and LEXCHECK_NOSYMBOL) <> 0 ) then
			t->id = FB_TK_ID
			t->class = FB_TKCLASS_IDENTIFIER
			exit sub
		end if

		t->sym_chain = symbLookup( @t->text, t->id, t->class )

		'' don't load defines?
		if( (flags and LEXCHECK_NODEFINE) <> 0 ) then
			exit sub
		end if

		'' don't look up symbols?
		if( (flags and LEXCHECK_NOLOOKUP) <> 0 ) then
			'' only check if it's a define..
			chain_ = t->sym_chain
			if( chain_ <> NULL ) then
				if( symbGetClass( chain_->sym ) = FB_SYMBCLASS_DEFINE ) then
					'' restart..
					if( ppDefineLoad( chain_->sym ) ) then
						goto re_read
					end if
				end if
			end if

			exit sub
		end if

		'' handle the stupid '.'s in symbols..
		chain_ = t->sym_chain
		if( chain_ <> NULL ) then
			readfullid = FALSE

			select case symbGetClass( chain_->sym )
			'' define?
			case FB_SYMBCLASS_DEFINE
				'' restart..
				if( ppDefineLoad( chain_->sym ) ) then
					goto re_read
				end if

           	case FB_SYMBCLASS_NAMESPACE

        	case else
				'' is the next char a period?
				if( lexCurrentChar( ) = CHAR_DOT ) then
                    readfullid = TRUE

        			do while( chain_ <> NULL )
        	    		'' variable?
        	    		if( symbIsVar( chain_->sym ) ) then
	    		    		'' UDT?
	    		    		if( symbGetType( chain_->sym ) = FB_DATATYPE_USERDEF ) then
    			    			readfullid = FALSE
        		   				exit do
        		   			end if
						end if
        				chain_ = symbChainGetNext( chain_ )
        			loop
        		end if
        	end select

        '' no symbol..
        else
        	'' only read if next char is a '.'
        	readfullid = (lexCurrentChar( ) = CHAR_DOT)
        end if

        '' read the remaining? (including the '.'s)
        if( readfullid ) then
			t->ppos = t->len
			hReadIdentifier( @t->text[t->len], _
							 t->len, _
							 t->dtype, _
							 flags or LEXCHECK_IDPERIOD )

			t->sym_chain = symbLookup( @t->text, t->id, t->class )
        end if

	'' '"'?
	case CHAR_QUOTE
		t->id = FB_TK_STRLIT
		t->class = FB_TKCLASS_STRLITERAL

		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
			t->len = hReadString( @t->text, flags )
			t->dtype = FB_DATATYPE_CHAR
		else
			t->len = hReadWStr( @t->textw, flags )
			t->dtype = FB_DATATYPE_WCHAR
		end if

	'':::::
	case else
read_char:

		t->id = lexEatChar( )
		t->len = 1
		t->dtype = t->id

		t->text[0] = char                            '' t.text = chr( char )
		t->text[1] = 0                               '' /

		select case as const char
		'' '<', '>', '='?
		case CHAR_LT, CHAR_GT, CHAR_EQ
			t->class = FB_TKCLASS_OPERATOR

			select case char
			case CHAR_LT
				select case lexCurrentChar( TRUE )
				'' '<='?
				case CHAR_EQ
					'' t.text += chr( lexEatChar )
					t->text[t->len+0] = lexEatChar( )
					t->text[t->len+1] = 0
					t->len += 1
					t->id = FB_TK_LE

				'' '<>'?
				case CHAR_GT
					'' t.text += chr( lexEatChar )
					t->text[t->len+0] = lexEatChar( )
					t->text[t->len+1] = 0
					t->len += 1
					t->id = FB_TK_NE

				case else
					t->id = FB_TK_LT
				end select

			case CHAR_GT
				'' '>='?
				if( lexCurrentChar( TRUE ) = CHAR_EQ ) then
					'' t.text += chr( lexEatChar )
					t->text[t->len+0] = lexEatChar( )
					t->text[t->len+1] = 0
					t->len += 1
					t->id = FB_TK_GE
				else
					t->id = FB_TK_GT
				end if

			case CHAR_EQ
				'' '=>'?
				if( lexCurrentChar( TRUE ) = CHAR_GT ) then
					'' t.text += chr( lexEatChar )
					t->text[t->len+0] = lexEatChar( )
					t->text[t->len+1] = 0
					t->len += 1
					t->id = FB_TK_DBLEQ
				else
					t->id = FB_TK_EQ
				end if
			end select

		'' '+', '*', '\'?
		case CHAR_PLUS, CHAR_TIMES, CHAR_RSLASH
			t->class = FB_TKCLASS_OPERATOR

		'' '-'?
		case CHAR_MINUS
			t->class = FB_TKCLASS_OPERATOR

			'' check for type-field dereference
			if( lexCurrentChar( TRUE ) = CHAR_GT ) then
				'' t.text += chr( lexEatChar )
				t->text[t->len+0] = lexEatChar( )
				t->text[t->len+1] = 0
				t->len += 1
				t->id = FB_TK_FIELDDEREF
			end if

		'' '/'?
		case CHAR_SLASH
			t->class = FB_TKCLASS_OPERATOR

			'' "/'"?
			if( lexCurrentChar( ) = CHAR_APOST ) then
				'' multi-line comment..
				hMultiLineComment( )
				goto re_read
			end if

		'' '(', ')', ',', ':', ';', '@', '.', '$', '{', '}', '[', ']'?
		case CHAR_LPRNT, CHAR_RPRNT, CHAR_COMMA, CHAR_COLON, _
			 CHAR_SEMICOLON, CHAR_AT, CHAR_DOT, CHAR_DOLAR, _
			 CHAR_LBRACE, CHAR_RBRACE, CHAR_LBRACKET, CHAR_RBRACKET
			t->class = FB_TKCLASS_DELIMITER

		'' ' ', '\t'?
		case CHAR_SPACE, CHAR_TAB
			t->class = FB_TKCLASS_DELIMITER
			t->id = CHAR_SPACE

			do
				select case as const lexCurrentChar( )
				case CHAR_SPACE, CHAR_TAB
					lexEatChar( )
					t->text[t->len] = CHAR_SPACE  			'' t.text += " "
					t->len += 1
				case else
					t->text[t->len] = 0                     '' t.text += chr( 0 )
					exit do
				end select
			loop

		'' anything else..
		case else
			t->class = FB_TKCLASS_UNKNOWN
		end select

	end select

end sub

'':::::
'' MultiLineComment	 = '/' ''' . '/' '''
''
private sub hMultiLineComment( ) static
	dim as integer cnt

	'' skip the last '''
	lexEatChar( )

	cnt = 0
	do
		select case as const lexCurrentChar( TRUE )
		'' EOF?
		case 0
			errReportEx( FB_ERRMSG_EXPECTEDENDCOMMENT, NULL )
			exit sub

		'' EOL?
		case CHAR_CR
			lexEatChar( )

			'' CRLF on DOS, LF only on *NIX
			if( lexCurrentChar( ) = CHAR_LF ) then
				lexEatChar( )
			end if

			UPDATE_LINENUM()
			env.stmtcnt += 1

		'' EOL?
		case CHAR_LF
			lexEatChar( )

			UPDATE_LINENUM( )
			env.stmtcnt += 1

		'' '/'?
		case CHAR_SLASH
			lexEatChar( )

			'' nested?
			if( lexCurrentChar( ) = CHAR_APOST ) then
				lexEatChar( )
				cnt += 1
			end if

		'' '''?
		case CHAR_APOST
			lexEatChar( )

			'' end of ml comment?
			if( lexCurrentChar( ) = CHAR_SLASH ) then
				lexEatChar( )

				'' not nested?
				if( cnt = 0 ) then
					exit do
				end if

				cnt -= 1
			end if

		'' anything else, skip..
		case else
			lexEatChar( )
		end select
	loop

end sub

'':::::
function lexGetToken _
	( _
		byval flags as LEXCHECK _
	) as integer static

    if( lex->head->id = INVALID ) then
    	lexNextToken( lex->head, flags )
    	ppCheck( )
    end if

    function = lex->head->id

end function

'':::::
function lexGetClass _
	( _
		byval flags as LEXCHECK _
	) as integer static

    if( lex->head->id = INVALID ) then
    	lexNextToken( lex->head, flags )
    	ppCheck( )
    end if

    function = lex->head->class

end function

'':::::
function lexGetLookAhead _
	( _
		byval k as integer, _
		byval flags as LEXCHECK _
	) as integer static

    if( k > FB_LEX_MAXK ) then
    	exit function
    end if

	if( k > lex->k ) then
		lex->k = k
		lex->tail = lex->tail->next
	end if

    if( lex->tail->id = INVALID ) then
	    lexNextToken( lex->tail, flags )
	end if

	function = lex->tail->id

end function

'':::::
function lexGetLookAheadClass _
	( _
		byval k as integer, _
		byval flags as LEXCHECK _
	) as integer static

    if( k > FB_LEX_MAXK ) then
    	exit function
    end if

	if( k > lex->k ) then
		lex->k = k
		lex->tail = lex->tail->next
	end if

    if( lex->tail->id = INVALID ) then
    	lexNextToken( lex->tail, flags )
    end if

    function = lex->tail->class

end function

'':::::
private sub hMoveKDown( ) static

    lex->head->id = INVALID

    lex->k -= 1
    lex->head = lex->head->next

end sub

'':::::
sub lexSkipToken _
	( _
		byval flags as LEXCHECK _
	) static

    '' update stats
    select case lex->head->id
    case FB_TK_EOL
    	UPDATE_LINENUM( )
    	env.stmtcnt += 1
    case FB_TK_STATSEPCHAR
    	env.stmtcnt += 1
    end select

	'' if no macro text been read, reset
	if( lex->deflen = 0 ) then
		lex->currmacro = NULL
	end if

    lex->lasttk_id = lex->head->id

    ''
    if( lex->k = 0 ) then
    	lexNextToken( lex->head, flags )
    else
    	hMoveKDown( )
    end if

    ppCheck( )

end sub

'':::::
sub lexEatToken _
	( _
		byval token as zstring ptr, _
		byval flags as LEXCHECK _
	) static

    ''
  	if( lex->head->dtype <> FB_DATATYPE_WCHAR ) then
    	*token = lex->head->text
    else
    	*token = str( lex->head->textw )
    end if

    lexSkipToken( flags )

end sub

''::::
function lexGetText _
	( _
	) as zstring ptr static

    static as zstring * FB_MAXLITLEN+1 tmpstr

  	if( lex->head->dtype <> FB_DATATYPE_WCHAR ) then
    	function = @lex->head->text
    else
    	tmpstr = str( lex->head->textw )
    	function = @tmpstr
    end if

end function

'':::::
sub lexReadLine _
	( _
		byval endchar as uinteger = INVALID, _
		byval dst as zstring ptr, _
		byval skipline as integer = FALSE _
	) static

    dim as uinteger char

	if( skipline = FALSE ) then
		*dst = ""
	end if

    '' check look ahead tokens if any
    do while( lex->k > 0 )
    	select case lex->head->id
    	case FB_TK_EOF, FB_TK_EOL, endchar
    		exit sub
    	case else
    		if( skipline = FALSE ) then
   				*dst += lex->head->text
    		end if
    	end select

    	hMoveKDown( )
    loop

   	'' check current token
    select case lex->head->id
    case FB_TK_EOF, FB_TK_EOL, endchar
   		exit sub
   	case else
   		if( skipline = FALSE ) then
    		*dst += lex->head->text
   		end if
   	end select

    ''
	do
		char = lexCurrentChar( )

		'' !!!FIXME!!! this shouldn't be here
		'' only emit current src line if it's not on an inc file
		if( env.clopt.debug ) then
			if( env.includerec = 0 ) then
				if( (char = CHAR_CR) or (char = CHAR_LF) or (char = 0) ) then
					astAdd( astNewLIT( curline ) )
					curline = ""
				end if
			end if
		end if

		'' EOF?
		select case as const char
		case 0
			lex->head->id = FB_TK_EOF
			lex->head->class = FB_TKCLASS_DELIMITER
			exit sub

		'' EOL?
		case CHAR_CR, CHAR_LF
			lexEatChar( )
			'' CRLF on DOS, LF only on *NIX
			if( char = CHAR_CR ) then
				if( lexCurrentChar( ) = CHAR_LF ) then lexEatChar
			end if

			lex->head->id 	 = FB_TK_EOL
			lex->head->class = FB_TKCLASS_DELIMITER
			exit sub

		case else
			'' closing char?
			if( char = endchar ) then
				lex->head->id 	 = endchar
				lex->head->class = FB_TKCLASS_DELIMITER
				exit sub
			end if
		end select

		lexEatChar( )
		if( skipline = FALSE ) then
			*dst += chr( char )
		end if
	loop

end sub

'':::::
sub lexSkipLine( ) static

	lexReadLine( , NULL, TRUE )

end sub

'':::::
function lexPeekCurrentLine _
	( _
		byref token_pos as string _
	) as string

	static as zstring * 1024+1 buffer
	dim as string res
	dim as integer p, old_p, start, token_len
	dim as ubyte ptr c

	function = ""

	'' !!!WRITEME!!!
	if( env.inf.format <> FBFILE_FORMAT_ASCII ) then
		exit function
	end if

	'' get file contents around current token
	old_p = seek( env.inf.num )
	p = lex->lastfilepos - 512
	start = 512
	if( p < 0 ) then
		start += p
		p = 0
	end if

	get #env.inf.num, p + 1, buffer
	seek #env.inf.num, old_p

	'' find source line start
	c = @buffer[start]
	token_len = 0
	if( start > 0 ) then
		c -= 1
		while( ( *c <> 10 ) and ( *c <> 13 ) and ( start > 0 ) )
			token_len += 1
			c -= 1
			start -= 1
		wend
		c += 1
	end if

	'' build source line
	res = ""
	token_pos = ""
	while( ( *c <> 0 ) and ( *c <> 10 ) and ( *c <> 13 ) )
		res += chr(*c)
		if( token_len > 0 ) then
			token_pos += chr( iif( *c = 9, 9, 32 ) )
			token_len -= 1
		end if
		c += 1
	wend
	token_pos += "^"

	function = res

end function
