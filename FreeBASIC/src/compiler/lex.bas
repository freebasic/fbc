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


'' lexical scanner
''
''
'' chng: sep/2004 written [v1ctor]
'' 	     dec/2004 pre-processor added (all code at lexpp.bas) [v1ctor]
''       jan/2005 optimized to not create dynamic strings (but at NextToken:readid)

option explicit
option escape

defint a-z
'$include: 'inc\fb.bi'
'$include: 'inc\fbint.bi'
'$include: 'inc\lex.bi'
'$include: 'inc\emit.bi'

''
const FB.LEX.MAXK%	= 1

''
type LEXCTX
	tokenTB(0 to FB.LEX.MAXK) as FBTOKEN
	k				as integer					'' look ahead cnt (1..MAXK)

	char			as integer
	lachar			as integer					'' lookahead

	linenum 		as integer
	colnum 			as integer
	lasttoken 		as integer

	reclevel 		as integer					'' PP recursion

	'' last #define's text
	deftext			as string * FB.MAXLITLEN
	defptr 			as byte ptr
	deflen 			as integer

	'' last WITH's text
	withtext		as string * FB.MAXNAMELEN
	withptr 		as byte ptr
	withlen 		as integer

	'' input buffer
	bufflen			as integer
	buffptr			as byte ptr
	buff			as string * 8192
end type

'' globals
	dim shared ctx as LEXCTX
	dim shared curline as string

	dim shared ctxcopyTB( 0 TO FB.MAXINCRECLEVEL-1 ) as LEXCTX

'':::::
sub lexSaveCtx( byval level as integer )

	ctxcopyTB(level) = ctx

end sub

'':::::
sub lexRestoreCtx( byval level as integer )

	ctx = ctxcopyTB(level)

end sub

'':::::
sub lexInit
    dim i as integer

	ctx.k = 0

	for i = 0 to FB.LEX.MAXK
		ctx.tokenTB(i).id = INVALID
	next i

	ctx.char		= INVALID
	ctx.lachar		= INVALID

	ctx.linenum		= 1
	ctx.colnum		= 1
	ctx.lasttoken	= INVALID

	ctx.reclevel	= 0

	''
	ctx.deflen		= 0

	ctx.withlen		= 0

	ctx.bufflen		= 0
	ctx.buffptr		= NULL

	'' only if it's not on an inc file
	if( env.reclevel = 0 ) then
		curline = ""
	end if

end sub

'':::::
sub lexEnd

	if( env.reclevel = 0 ) then
		curline = ""
	end if

end sub

'':::::
function lexReadChar as integer static
    dim char as integer
    dim p as integer

	'' any #define'd text?
	if( ctx.deflen > 0 ) then

		char = *ctx.defptr
		ctx.defptr = ctx.defptr + 1
		ctx.deflen = ctx.deflen - 1

	'' any WITH text?
	elseif( ctx.withlen > 0 ) then

		char = *ctx.withptr
		ctx.withptr = ctx.withptr + 1
		ctx.withlen = ctx.withlen - 1

	else

		'' buffer empty?
		if( ctx.bufflen = 0 ) then
			if( not eof( env.inf ) ) then
				p = seek( env.inf )
				get #env.inf, , ctx.buff
				ctx.bufflen = seek( env.inf ) - p
				ctx.buffptr = @ctx.buff
			end if
		end if

		''
		if( ctx.bufflen > 0 ) then
			char = *ctx.buffptr
			ctx.buffptr = ctx.buffptr + 1
			ctx.bufflen = ctx.bufflen - 1
		else
			char = 0
		end if

		'' only save current src line if it's not on an inc file
		if( env.reclevel = 0 ) then
			if( env.clopt.debug ) then
				select case char
				case 0, 13, 10
				case else
					curline = curline + chr$( char )
				end select
			end if
		end if

	end if

	lexReadChar = char

end function

'':::::
sub lexUnreadChar static

	'' buffer not empty and last char not EOF? rewind
	if( (ctx.buffptr > @ctx.buff) and (ctx.char <> 0) ) then
		ctx.buffptr = ctx.buffptr - 1
		ctx.bufflen = ctx.bufflen + 1
	end if

	ctx.char 	= INVALID

end sub

'':::::
function lexCurrentChar( byval skipwhitespc as integer = FALSE ) as integer static

    if( ctx.char = INVALID ) then
    	ctx.char = lexReadChar
    end if

    if( skipwhitespc ) then
    	do while( (ctx.char = CHAR_TAB) or (ctx.char = CHAR_SPACE) )
    		ctx.char = lexReadChar
    	loop
    end if

    lexCurrentChar = ctx.char

end function

'':::::
function lexEatChar as integer static

	ctx.colnum = ctx.colnum + 1

    ''
    lexEatChar = ctx.char

    if( ctx.lachar = INVALID ) then
    	ctx.char = lexReadChar
    else
    	ctx.char = ctx.lachar
    	ctx.lachar = INVALID
    end if

end function

'':::::
function lexLookAheadCharEx( byval skipwhitespc as integer ) as integer

	if( ctx.lachar = INVALID ) then
		ctx.lachar = lexReadChar
	end if

    if( skipwhitespc ) then
    	do while( (ctx.lachar = CHAR_TAB) or (ctx.lachar = CHAR_SPACE) )
    		ctx.lachar = lexReadChar
    	loop
    end if

	lexLookAheadCharEx = ctx.lachar

end function

'':::::
function lexLookAheadChar as integer

	lexLookAheadChar = 	lexLookAheadCharEx( FALSE )

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
''indentifier    = ALPHA { [ALPHADIGIT | '_' | '.'] } [SUFFIX].
''
sub lexReadIdentifier( byval pid as byte ptr, tlen as integer, typ as integer ) static
	dim c as integer

	'' ALPHA
	*pid = lexEatChar
	pid = pid + 1

	tlen = 1

	'' { [ALPHADIGIT | '_' | '.'] }
	do
		c = lexCurrentChar
		select case as const c
		case CHAR_AUPP to CHAR_ZUPP, CHAR_ALOW to CHAR_ZLOW, CHAR_0 to CHAR_9, CHAR_DOT, CHAR_UNDER

			tlen = tlen + 1
			if( tlen > FB.MAXNAMELEN ) then
				hReportError FB.ERRMSG.IDNAMETOOBIG, TRUE
				exit function
			end if

			*pid = lexEatChar
			pid = pid + 1

		case else
			exit do
		end select
	loop

	'' null-term
	*pid = 0

	'' [SUFFIX]
	typ = INVALID

	select case as const lexCurrentChar
	case FB.TK.INTTYPECHAR, FB.TK.LNGTYPECHAR
		typ = FB.SYMBTYPE.INTEGER
	case FB.TK.SGNTYPECHAR
		typ = FB.SYMBTYPE.SINGLE
	case FB.TK.DBLTYPECHAR
		typ = FB.SYMBTYPE.DOUBLE
	case FB.TK.STRTYPECHAR
		typ = FB.SYMBTYPE.STRING
	end select

	if( typ <> INVALID ) then
		c = lexEatChar
	end if

end sub

''::::
''hex_oct_bin     = 'H' HEXDIG+
''                | 'O' OCTDIG+
''                | 'B' BINDIG+
''
sub lexReadNonDecNumber( pnum as byte ptr, tlen as integer ) static
	dim v as uinteger, c as integer
	dim tb(0 to 31) as integer, i as integer

	v = 0

	select case as const lexEatChar
	'' hex
	case CHAR_HUPP, CHAR_HLOW
		do
			select case lexCurrentChar
			case CHAR_ALOW to CHAR_FLOW, CHAR_AUPP to CHAR_FUPP, CHAR_0 to CHAR_9
				  c = lexEatChar - CHAR_0
                  if( c > 9 ) then c = c - (CHAR_AUPP - CHAR_9 - 1)
                  if( c > 16 ) then c = c - (CHAR_ALOW - CHAR_AUPP)
                  v = (v * 16) + c
			case else
				exit do
			end select
		loop

	'' oct
	case CHAR_OUPP, CHAR_OLOW
		do
			select case lexCurrentChar
			case CHAR_0 to CHAR_7
				v = (v * 8) + (lexEatChar - CHAR_0)
			case else
				exit do
			end select
		loop

	'' bin
	case CHAR_BUPP, CHAR_BLOW
		do
			select case lexCurrentChar
			case CHAR_0, CHAR_1
				v = (v * 2) + (lexEatChar - CHAR_0)
			case else
				exit do
			end select
		loop

	end select

	''!!!WRITEME!!! check too big numbers here !!!WRITEME!!!

	'' int to ascii
	if( v = 0 ) then
		*pnum = CHAR_0
		pnum = pnum + 1
		tlen = tlen + 1

	else

		'' convert to unsigned
		if( (v and &h80000000) > 0 ) then
			v = -v

			*pnum = CHAR_MINUS
			pnum = pnum + 1
			tlen = tlen + 1
		end if

		i = 0
		do while( v > 0 )
			tb(i) = v mod 10
			i = i + 1
			v = v \ 10
		loop

		do while( i > 0 )
			i = i - 1
			*pnum = CHAR_0 + tb(i)
			pnum = pnum + 1
			tlen = tlen + 1
		loop
	end if

end sub

'':::::
''float           = DOT DIGIT { DIGIT } [FSUFFIX | { EXPCHAR [opadd] DIGIT { DIGIT } } | ].
''
sub lexReadFloatNumber( pnum as byte ptr, tlen as integer, typ as integer ) static
    dim c as integer
    dim llen as integer

	typ = FB.SYMBTYPE.DOUBLE

	llen = tlen

	'' DIGIT { DIGIT }
	do
		c = lexCurrentChar
		select case c
		case CHAR_0 to CHAR_9
			*pnum = lexEatChar
			pnum = pnum + 1
			tlen = tlen + 1
		case else
			exit do
		end select
	loop

	'' [FSUFFIX | { EXPCHAR [opadd] DIGIT { DIGIT } } | ]
	select case as const lexCurrentChar
	case FB.TK.SGNTYPECHAR
		c = lexEatChar
		typ = FB.SYMBTYPE.SINGLE
	case FB.TK.DBLTYPECHAR
		c = lexEatChar
		typ = FB.SYMBTYPE.DOUBLE

	case CHAR_ELOW, CHAR_EUPP, CHAR_DLOW, CHAR_DUPP
		'' EXPCHAR
		c = lexEatChar
		*pnum = CHAR_ELOW
		pnum = pnum + 1
		tlen = tlen + 1

		'' [opadd]
		c = lexCurrentChar
		if( (c = CHAR_PLUS) or (c = CHAR_MINUS) ) then
			*pnum = lexEatChar
			pnum = pnum + 1
			tlen = tlen + 1
		end if

		do
			c = lexCurrentChar
			select case c
			case CHAR_0 to CHAR_9
				*pnum = lexEatChar
				pnum = pnum + 1
				tlen = tlen + 1
			case else
				exit do
			end select
		loop

	end select

	if( tlen - llen = 0 ) then
		'' '0'
		*pnum = CHAR_0
		pnum = pnum + 1
		tlen = tlen + 1
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
sub lexReadNumber( byval pnum as byte ptr, typ as integer, tlen as integer ) static
	dim c as integer
	dim isfloat as integer

	isfloat = FALSE
	typ = INVALID
	*pnum = 0

	c = lexEatChar

	select case as const c
	'' integer part
	case CHAR_0 to CHAR_9

		*pnum = c
		pnum = pnum + 1
		tlen = 1

		do
			c = lexCurrentChar
			select case as const c
			case CHAR_0 to CHAR_9
				*pnum = lexEatChar
				pnum = pnum + 1
				tlen = tlen + 1

			case CHAR_DOT, CHAR_ELOW, CHAR_EUPP, CHAR_DLOW, CHAR_DUPP
				isfloat = TRUE
				if( c = CHAR_DOT ) then
					c = lexEatChar
					*pnum = CHAR_DOT
					pnum = pnum + 1
					tlen = tlen + 1
				end if
				lexReadFloatNumber pnum, tlen, typ
				exit do
			case else
				exit do
			end select
		loop

	'' fractional part
	case CHAR_DOT
		isfloat = TRUE
		'' add '.'
		*pnum = CHAR_DOT
		pnum = pnum + 1
		tlen = 1
        lexReadFloatNumber pnum, tlen, typ

	'' hex, oct, bin
	case CHAR_AMP
		tlen = 0
		lexReadNonDecNumber pnum, tlen
	end select

	'' null-term
	*pnum = 0

	'' check suffix type
	if( not isfloat ) then
		select case as const lexCurrentChar
		case FB.TK.INTTYPECHAR, FB.TK.LNGTYPECHAR
			typ = FB.SYMBTYPE.INTEGER
		case FB.TK.SGNTYPECHAR, FB.TK.DBLTYPECHAR
			typ = FB.SYMBTYPE.DOUBLE
		end select

		if( typ <> INVALID ) then
			c = lexEatChar
		end if
	end if

	if( typ = INVALID ) then
		if( not isfloat ) then
			typ = FB.SYMBTYPE.INTEGER
		else
			typ = FB.SYMBTYPE.DOUBLE
		end if
	end if

	''!!!WRITEME!!! check too big numbers here !!!WRITEME!!!

end sub

'':::::
''string          = '"' { ANY_CHAR_BUT_QUOTE } '"'.   # less quotes
''
sub lexReadString ( byval ps as byte ptr, tlen as integer ) static
	dim rlen as integer
	dim nval as string * 16, ntyp as integer, nlen as integer, pval as byte ptr

	*ps = 0
	tlen = 0
	rlen = 0

	lexEatChar									'' skip open quote

	do
		select case as const lexCurrentChar
		case 0, CHAR_CR, CHAR_LF
			exit do

		case CHAR_QUOTE
			lexEatChar
			'' check for double-quotes
			if( lexCurrentChar <> CHAR_QUOTE ) then
				exit do
			end if

		case CHAR_RSLASH
			'' process the scape sequence
			if( env.optescapestr ) then

				'' can't use '\', it will be escaped anyway because GAS
				lexEatChar
				*ps = FB.INTSCAPECHAR
				ps = ps + 1
				rlen = rlen + 1

				select case lexCurrentChar
				'' if it's a literal number, convert to octagonal
				case CHAR_0 to CHAR_9, CHAR_AMP
					lexReadNumber @nval, ntyp, nlen
					if( nlen > 3 ) then
						nval = left$( nval, 3 )
					end if
					nval = oct$( val( nval ) )
					pval = sadd( nval )
					do until( *pval = 0 )
						*ps = *pval
						pval = pval + 1
						ps = ps + 1
						rlen = rlen + 1
					loop
					tlen = tlen + 1
					continue do
				end select

			end if
		end select

		rlen = rlen + 1
		if( rlen > FB.MAXLITLEN ) then
			hReportError FB.ERRMSG.LITSTRINGTOOBIG, TRUE
			exit function
		end if

		*ps = lexEatChar
		ps = ps + 1
		tlen = tlen + 1
	loop

	'' null-term
	*ps = 0

end sub

'':::::
sub lexNextToken ( t as FBTOKEN, byval checkLineCont as integer = TRUE, byval checkDefine as integer = TRUE ) static
	dim c as integer
	dim linecontinuation as integer
	dim isnumber as integer
	dim d as FBDEFINE ptr
	dim token as string
	dim iswith as integer

reread:
	poke @t.text, 0								''t.text = ""
	t.tlen = 0

	'':::::
	'' skip white space
	linecontinuation = FALSE
	do
		c  = lexCurrentChar

		'' !!!FIXME!!! this shouldn't be here
		'' only emit current src line if it's not on an inc file
		if( env.reclevel = 0 ) then
			if( env.clopt.debug ) then
				if( (c = CHAR_CR) or (c = CHAR_LF) or (c = 0) ) then
					emitCOMMENT curline
					curline = ""
				end if
			end if
		end if

		'' check EOF
		if( c = 0 ) then
			t.id = FB.TK.EOF
			t.class = FB.TKCLASS.DELIMITER
			exit sub
		end if

		'' check for line continuation
		if( c = CHAR_UNDER ) then
			if( checkLineCont ) then
				c = lexEatChar
				linecontinuation = TRUE
				continue do
			end if
		end if

		'' check EOL
		if( (c = CHAR_CR) or (c = CHAR_LF) ) then
			c = lexEatChar

			'' CRLF on DOS, LF only on *NIX
			if( c = CHAR_CR ) then
				if( lexCurrentChar = CHAR_LF ) then c = lexEatChar
			end if

			if( not linecontinuation ) then
				t.id = FB.TK.EOL
				t.class = FB.TKCLASS.DELIMITER
				exit sub
			else
				ctx.linenum = ctx.linenum + 1
				linecontinuation = FALSE
				continue do
			end if
		end if

		if( (not linecontinuation) and ((c <> CHAR_TAB) and (c <> CHAR_SPACE)) ) then
			exit do
		else
			c = lexEatChar
		end if
	loop

	iswith = FALSE

	select case as const c
	'':::::
	case CHAR_DOT

	    isnumber = FALSE

	    '' only check for fpoint literals if not inside a comment or parsing an $include
	    if( checkLineCont ) then
	    	c = lexLookAheadCharEx( TRUE )
	    	if( c >= CHAR_0 and c <= CHAR_9 ) then
				isnumber = TRUE
			elseif( ctx.lasttoken <> CHAR_RPRNT ) then
				if( ctx.lasttoken <> CHAR_RBRACKET ) then
					if( env.withtextidx = INVALID ) then
						isnumber = TRUE
					else
						iswith = TRUE
					end if
				end if
			end if
		end if

		if( isnumber ) then
			goto readnumber
		else
			goto readid
		end if

	'':::::
	case CHAR_AMP, CHAR_0 to CHAR_9
readnumber:
		lexReadNumber @t.text, t.id, t.tlen
		t.class 	= FB.TKCLASS.NUMLITERAL
		t.typ		= t.id

	'':::::
	case CHAR_AUPP to CHAR_ZUPP, CHAR_ALOW to CHAR_ZLOW
readid:
		lexReadIdentifier @t.text, t.tlen, t.typ
		token = t.text

		if( checkDefine ) then
			'' is it a define?
			d = symbLookupDefine( token )
			if( d <> NULL ) then
				lexUnreadChar
				ctx.deftext = symbGetDefineText( d )
				ctx.deflen  = symbGetDefineLen( d )
				ctx.defptr  = @ctx.deftext
				goto reread
        	end if
        end if

       	t.id = symbLookupKeyword( token, t.class, t.typ )

       	'' WITH hack
       	if( iswith ) then
			lexUnreadChar
			token = strpGet( env.withtextidx )
			ctx.withtext = token + t.text
			ctx.withlen  = len( token ) + t.tlen
			ctx.withptr  = @ctx.withtext
			goto reread
       	end if

	'':::::
	case CHAR_QUOTE
		t.id		= FB.TK.STRLIT
		lexReadString @t.littext, t.tlen
		t.class 	= FB.TKCLASS.STRLITERAL
		t.typ		= t.id

	'':::::
	case else
		t.id		= lexEatChar
''#ifndef FB__BIGENDIAN
		pokei @t.text, c and &h000000FF			'' t.text = chr$( c )
''#endif
		t.tlen		= 1
		t.typ		= t.id

		select case as const c
		'':::
		case CHAR_LT, CHAR_GT, CHAR_EQ
			t.class = FB.TKCLASS.OPERATOR

			select case c
			case CHAR_LT
				select case lexCurrentChar( TRUE )
				case CHAR_EQ
					c = lexEatChar
					t.id = FB.TK.LE
					t.tlen = t.tlen + 1
				case CHAR_GT
					c = lexEatChar
					t.id = FB.TK.NE
					t.tlen = t.tlen + 1
				case else
					t.id = FB.TK.LT
				end select

			case CHAR_GT
				if( lexCurrentChar( TRUE ) = CHAR_EQ ) then
					c = lexEatChar
					t.id = FB.TK.GE
					t.tlen = t.tlen + 1
				else
					t.id = FB.TK.GT
				end if

			case CHAR_EQ
				t.id = FB.TK.EQ
			end select

		'':::
		case CHAR_PLUS, CHAR_MINUS, CHAR_TIMES, CHAR_SLASH, CHAR_RSLASH
			t.class = FB.TKCLASS.OPERATOR

			'' check for type-field dereference
			if( c = CHAR_MINUS ) then
				if( lexCurrentChar( TRUE ) = CHAR_GT ) then
					c = lexEatChar
					t.id = FB.TK.FIELDDEREF
					t.tlen = t.tlen + 1
				end if
			end if

		'':::
		case CHAR_LPRNT, CHAR_RPRNT, CHAR_COMMA, CHAR_COLON, CHAR_SEMICOLON, CHAR_AT
			t.class	= FB.TKCLASS.DELIMITER

		'':::
		case else
			t.class = FB.TKCLASS.UNKNOWN
		end select

	end select


end sub

'':::::
private sub hCheckPP

	'' not already inside the PP? (ie: not skipping a false #IF or #ELSE)
	if( ctx.reclevel = 0 ) then
		'' '#' char?
		if( ctx.tokenTB(0).id = CHAR_SHARP ) then
			'' at beginning of line (or top of source-file)?
			if( (ctx.lasttoken = FB.TK.EOL) or (ctx.lasttoken = INVALID) ) then
                ctx.reclevel = ctx.reclevel + 1
                lexSkipToken

       			'' not a keyword? error, parser will catch it..
       			if( ctx.tokenTB(0).class <> FB.TKCLASS.KEYWORD ) then
       				ctx.reclevel = ctx.reclevel - 1
       				exit sub
       			end if

       			'' pp failed? exit
       			if( not lexPreProcessor ) then
       				ctx.reclevel = ctx.reclevel - 1
       				exit sub
       			end if

				ctx.reclevel = ctx.reclevel - 1
			end if
		end if
	end if

end sub

'':::::
function lexCurrentToken( byval checkLineCont as integer = TRUE, byval checkDefine as integer = TRUE ) as integer static

    if( ctx.tokenTB(0).id = INVALID ) then
    	lexNextToken ctx.tokenTB(0), checkLineCont, checkDefine
    	hCheckPP
    end if

    lexCurrentToken = ctx.tokenTB(0).id

end function

'':::::
function lexCurrentTokenClass( byval checkLineCont as integer = TRUE, byval checkDefine as integer = TRUE ) as integer static

    if( ctx.tokenTB(0).id = INVALID ) then
    	lexNextToken ctx.tokenTB(0), checkLineCont, checkDefine
    	hCheckPP
    end if

    lexCurrentTokenClass = ctx.tokenTB(0).class

end function

'':::::
function lexLookAhead( byval k as integer ) as integer static

    if( k > FB.LEX.MAXK ) then
    	exit function
    end if

    if( ctx.tokenTB(k).id = INVALID ) then
	    lexNextToken ctx.tokenTB(k)
	end if

	if( k > ctx.k ) then
		ctx.k = k
	end if

	lexLookAhead = ctx.tokenTB(k).id

end function

'':::::
function lexLookAheadClass( byval k as integer ) as integer static

    if( k > FB.LEX.MAXK ) then
    	exit function
    end if

    if( ctx.tokenTB(k).id = INVALID ) then
    	lexNextToken ctx.tokenTB(k)
    end if

	if( k > ctx.k ) then
		ctx.k = k
	end if

    lexLookAheadClass = ctx.tokenTB(k).class

end function

'':::::
private sub hMoveKDown static
    dim i as integer

    for i = 0 to ctx.k-1
    	ctx.tokenTB(i) = ctx.tokenTB(i+1)
    next i

    ctx.tokenTB(ctx.k).id = INVALID

    ctx.k = ctx.k - 1

end sub

'':::::
function lexEatToken( byval checkLineCont as integer = TRUE, byval checkDefine as integer = TRUE ) as string static

    ''
    if( ctx.tokenTB(0).class <> FB.TKCLASS.STRLITERAL ) then
    	lexEatToken = ctx.tokenTB(0).text
    else
    	lexEatToken = ctx.tokenTB(0).littext
    end if

    ''
    if( ctx.tokenTB(0).id = FB.TK.EOL ) then
    	ctx.linenum = ctx.linenum + 1
    	ctx.colnum  = 1
    end if

    ctx.lasttoken = ctx.tokenTB(0).id

    if( ctx.k = 0 ) then
    	lexNextToken ctx.tokenTB(0), checkLineCont, checkDefine
    else
    	hMoveKDown
    end if

    hCheckPP

end function

'':::::
sub lexSkipToken( byval checkLineCont as integer = TRUE, byval checkDefine as integer = TRUE ) static

    if( ctx.tokenTB(0).id = FB.TK.EOL ) then
    	ctx.linenum = ctx.linenum + 1
    	ctx.colnum  = 1
    end if

    ctx.lasttoken = ctx.tokenTB(0).id

    ''
    if( ctx.k = 0 ) then
    	lexNextToken ctx.tokenTB(0), checkLineCont, checkDefine
    else
    	hMoveKDown
    end if

    hCheckPP

end sub

'':::::
sub lexReadLine( byval endchar as integer = INVALID, dst as string, byval skipline as integer = FALSE ) static
    dim c as integer

	if( not skipline ) then
		dst = ""
	end if

    '' check look ahead tokens if any
    do while( ctx.k > 0 )
    	c = ctx.tokenTB(0).id
    	select case c
    	case FB.TK.EOF, FB.TK.EOL, endchar
    		exit sub
    	case else
    		if( not skipline ) then
    			if( ctx.tokenTB(0).class <> FB.TKCLASS.STRLITERAL ) then
    				dst = dst + ctx.tokenTB(0).text
    			else
    				dst = dst + ctx.tokenTB(0).littext
				end if
    		end if
    	end select

    	hMoveKDown
    loop

   	'' check current token
    select case ctx.tokenTB(0).id
    case FB.TK.EOF, FB.TK.EOL, endchar
   		exit sub
   	case else
   		if( not skipline ) then
    		if( ctx.tokenTB(0).class <> FB.TKCLASS.STRLITERAL ) then
    			dst = dst + ctx.tokenTB(0).text
    		else
    			dst = dst + ctx.tokenTB(0).littext
			end if
   		end if
   	end select

    ''
	do
		c  = lexCurrentChar

		'' !!!FIXME!!! this shouldn't be here
		'' only emit current src line if it's not on an inc file
		if( env.reclevel = 0 ) then
			if( env.clopt.debug ) then
				if( (c = CHAR_CR) or (c = CHAR_LF) or (c = 0) ) then
					emitCOMMENT curline
					curline = ""
				end if
			end if
		end if

		'' check EOF
		if( c = 0 ) then
			ctx.tokenTB(0).id = FB.TK.EOF
			ctx.tokenTB(0).class = FB.TKCLASS.DELIMITER
			exit sub
		end if

		'' check EOL
		if( (c = CHAR_CR) or (c = CHAR_LF) ) then
			c = lexEatChar
			'' CRLF on DOS, LF only on *NIX
			if( c = CHAR_CR ) then
				if( lexCurrentChar = CHAR_LF ) then c = lexEatChar
			end if

			ctx.tokenTB(0).id 	 = FB.TK.EOL
			ctx.tokenTB(0).class = FB.TKCLASS.DELIMITER
			exit sub

		'' closing char?
		elseif( c = endchar ) then
			ctx.tokenTB(0).id 	 = endchar
			ctx.tokenTB(0).class = FB.TKCLASS.DELIMITER
			exit sub

		end if

		c = lexEatChar
		if( not skipline ) then
			dst = dst + chr$( c )
		end if
	loop

end sub

'':::::
sub lexSkipLine static

	lexReadLine , "", TRUE

end sub


''::::
function lexLineNum as integer

	lexLineNum = ctx.linenum

end function

''::::
function lexColNum as integer

	lexColNum = ctx.colnum - ctx.tokenTB(0).tlen + 1

end function

''::::
function lexTokenText as string

    if( ctx.tokenTB(0).class <> FB.TKCLASS.STRLITERAL ) then
    	lexTokenText = ctx.tokenTB(0).text
    else
    	lexTokenText = ctx.tokenTB(0).littext
    end if

end function

''::::
function lexTokenTextLen as integer

	lexTokenTextLen = ctx.tokenTB(0).tlen

end function

''::::
function lexTokenType as integer

	lexTokenType = ctx.tokenTB(0).typ

end function

'':::::
sub lexSetCurrentToken( byval id as integer, byval class as integer )

	ctx.tokenTB(0).tlen 	= 0
	ctx.tokenTB(0).id 		= id
	ctx.tokenTB(0).class 	= class

end sub
