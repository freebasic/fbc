'' lexical scanner
''
''
'' chng: sep/2004 written [v1ctor]
''       nov/2005 unicode support added [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "lex.bi"
#include once "pp.bi"
#include once "parser.bi"

declare sub         lexReadUTF8             ( )

declare sub         lexReadUTF16LE          ( )

declare sub         lexReadUTF16BE          ( )

declare sub         lexReadUTF32LE          ( )

declare sub         lexReadUTF32BE          ( )

declare sub         hMultiLineComment       ( )

declare sub hSkipChar( )

const UINVALID as uinteger = cuint( INVALID )

dim shared as LEX_CTX lex

'' Buffer holding the current line when emitting in -pp only mode
dim shared as string pponly_ln

'':::::
'' only update the line count if not inside a multi-line macro
#define UPDATE_LINENUM( )            _
	if( lex.ctx->deflen = 0 ) then  :_
		lex.ctx->linenum += 1       :_
	end if

'':::::
sub lexPushCtx( )

	lex.ctx += 1

end sub

'':::::
sub lexPopCtx( )

	if( env.includerec = 0 ) then
		DZstrAllocate( lex.ctx->currline, 0 )
	end if

	'' free dynamic strings used in macro expansions
	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
		DZstrAllocate( lex.ctx->deftext, 0 )
	else
		DWstrAllocate( lex.ctx->deftextw, 0 )
	end if

	lex.ctx -= 1

end sub


'':::::
sub lexInit _
	( _
		byval isinclude as integer, _
		byval is_fb_eval as integer _
	)

	dim as integer i
	dim as FBTOKEN ptr n

	if( (env.includerec = 0) and (is_fb_eval = FALSE) ) then
		lex.ctx = @lex.ctxTB(0)
	end if

	'' create a circular list
	lex.ctx->k = 0

	lex.ctx->head = @lex.ctx->tokenTB(0)
	lex.ctx->tail = lex.ctx->head

	n = lex.ctx->head
	for i = 0 to FB_LEX_MAXK-1
		n->next = @lex.ctx->tokenTB(i+1)
		n = n->next
	next
	n->next = lex.ctx->head

	''
	for i = 0 to FB_LEX_MAXK
		lex.ctx->tokenTB(i).id = INVALID
	next

	lex.ctx->currchar = UINVALID
	lex.ctx->lahdchar1 = UINVALID
	lex.ctx->lahdchar2 = UINVALID

	lex.ctx->is_fb_eval = is_fb_eval

	if( is_fb_eval ) then
		lex.ctx->linenum = (lex.ctx-1)->linenum
		lex.ctx->reclevel = (lex.ctx-1)->reclevel
		lex.ctx->currmacro = (lex.ctx-1)->currmacro
	else
		lex.ctx->linenum = 1
		lex.ctx->reclevel = 0
		lex.ctx->currmacro = NULL
	end if

	lex.ctx->lasttk_id = INVALID

	''
	lex.ctx->bufflen = 0
	lex.ctx->deflen = 0

	if( env.inf.format = FBFILE_FORMAT_ASCII ) then
		lex.ctx->buffptr = iif( is_fb_eval, @lex.ctx->buff, NULL )
		lex.ctx->defptr = NULL
		DZstrAllocate( lex.ctx->deftext, 0 )
	else
		lex.ctx->buffptrw = @lex.ctx->buffw
		lex.ctx->defptrw = NULL
		DWstrAllocate( lex.ctx->deftextw, 0 )
	end if

	''
	if( is_fb_eval ) then
		lex.ctx->filepos = (lex.ctx-1)->filepos
		lex.ctx->lastfilepos = (lex.ctx-1)->lastfilepos
	else
		lex.ctx->filepos = 0
		lex.ctx->lastfilepos = 0
	end if

	'' only if it's not on an inc file
	if( (env.includerec = 0) or (is_fb_eval = TRUE) ) then
		DZstrAllocate( lex.ctx->currline, 0 )
		lex.insidemacro = FALSE
	end if

	lex.ctx->after_space = FALSE

	if( (isinclude = FALSE) and (is_fb_eval = FALSE ) ) then
		ppInit( )
	end if

end sub

'':::::
sub lexEnd( )

	pponly_ln = ""

	ppEnd( )

end sub

private sub hCollectCharForDebugOutput( byval char as uinteger )
	if( char < 32 ) then
		'' Filter out ASCII control chars, as they really shouldn't be
		'' emitted into .asm/.c, because, for example, &h17 (ETB, end of
		'' transmission block) apparently causes GAS to stop early,
		'' instead of reading until the rest of the .asm file, even if
		'' it's inside a comment.
		select case as const( char )
		case 0, CHAR_CR, CHAR_LF
			exit sub

		'' Those white-space chars should be ok though
		case CHAR_TAB, CHAR_VTAB, CHAR_FORMFEED

		case else
			char = asc( "?" )
		end select

	'' Unicode char? Can't be stored into lex.ctx->currline zstring,
	'' and .asm/.c output files are ANSI/ASCII-only anyways.
	elseif( char > 255 ) then
		char = asc( "?" )
	end if

	DZstrConcatAssignC( lex.ctx->currline, char )
end sub

'':::::
private function hReadChar _
	( _
		_
	) as uinteger

	dim as uinteger char = any

	'' any #define'd text?
	if( lex.ctx->deflen > 0 ) then

		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
			char = *lex.ctx->defptr
		else
			char = *lex.ctx->defptrw
		end if

		'' update current line text (if not parsing an inc file)
		if( env.clopt.debuginfo ) then
			if( env.includerec = 0 ) then
				if( lex.insidemacro = FALSE ) then
					lex.insidemacro = TRUE
					DZstrConcatAssign( lex.ctx->currline, " [Macro Expansion: " )
				end if

				hCollectCharForDebugOutput( char )
			end if
		end if

	else

		'' buffer empty?
		if( lex.ctx->bufflen = 0 ) then
			if( eof( env.inf.num ) = FALSE ) then
				lex.ctx->filepos = seek( env.inf.num )

				select case as const env.inf.format
				case FBFILE_FORMAT_ASCII
					if( get( #env.inf.num, , lex.ctx->buff ) = 0 ) then
						lex.ctx->bufflen = seek( env.inf.num ) - lex.ctx->filepos
						lex.ctx->buffptr = @lex.ctx->buff
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
		if( lex.ctx->bufflen > 0 ) then
			if( env.inf.format = FBFILE_FORMAT_ASCII ) then
				char = *lex.ctx->buffptr
			else
				char = *lex.ctx->buffptrw
			end if

		else
			char = 0
		end if

		'' update current line text (if not parsing an inc file)
		if( env.clopt.debuginfo ) then
			if( env.includerec = 0 ) then
				if( lex.insidemacro ) then
					lex.insidemacro = FALSE
					DZstrConcatAssign( lex.ctx->currline, " ] " )
				end if

				hCollectCharForDebugOutput( char )
			end if
		end if

	end if

	function = char

end function

sub lexEatChar( )
	if( lex.ctx->lahdchar1 = UINVALID ) then
		'' No look-ahead char, read next char and force the next
		'' lexCurrentChar() to update the current char.
		hSkipChar( )
		lex.ctx->currchar = UINVALID
	elseif( lex.ctx->lahdchar2 = UINVALID ) then
		'' Look ahead char is the next current char
		lex.ctx->currchar = lex.ctx->lahdchar1
		lex.ctx->lahdchar1 = UINVALID
	else
		'' Look ahead char is the next current char
		'' and second look ahead char becomes look ahead char
		lex.ctx->currchar = lex.ctx->lahdchar1
		lex.ctx->lahdchar1 = lex.ctx->lahdchar2
		lex.ctx->lahdchar2 = UINVALID
	end if
end sub

function lexEatWhitespace( ) as integer

	function = FALSE

	if( lex.ctx->currchar = UINVALID ) then
		lex.ctx->currchar = hReadChar( )
	end if

	do while( (lex.ctx->currchar = CHAR_TAB) or (lex.ctx->currchar = CHAR_SPACE) )
		lex.ctx->after_space = TRUE
		lexEatChar( )
		lex.ctx->currchar = hReadChar( )
		function = TRUE
	loop

end function

'':::::
private sub hSkipChar

	'' #define'd text?
	if( lex.ctx->deflen > 0 ) then
		lex.ctx->deflen -= 1

		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
			lex.ctx->defptr += 1
		else
			lex.ctx->defptrw += 1
		end if

		'' Reset the current macro if all expansion text is consumed now
		if( lex.ctx->deflen = 0 ) then
			lex.ctx->currmacro = NULL
		end if

	'' input stream (not EOF?)
	elseif( lex.ctx->currchar <> 0 ) then
		lex.ctx->bufflen -= 1

		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
			lex.ctx->buffptr += 1
		else
			lex.ctx->buffptrw += 1
		end if

	end if

end sub

'':::::
function lexCurrentChar _
	( _
	) as uinteger

	if( lex.ctx->currchar = UINVALID ) then
		lex.ctx->currchar = hReadChar( )
	end if

	function = lex.ctx->currchar

end function

'':::::
function lexGetLookAheadChar _
	( _
	) as uinteger

	if( lex.ctx->lahdchar1 = UINVALID ) then
		hSkipChar( )
		lex.ctx->lahdchar1 = hReadChar( )
	end if

	function = lex.ctx->lahdchar1

end function

'':::::
function lexGetLookAheadChar2 _
	( _
	) as uinteger

	'' internally, should never use this function unless there
	'' is already a character in the look aead
	assert( lex.ctx->lahdchar1 <> UINVALID )

	if( lex.ctx->lahdchar2 = UINVALID ) then
		hSkipChar( )
		lex.ctx->lahdchar2 = hReadChar( )
	end if

	function = lex.ctx->lahdchar2

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
		byref dtype as integer, _
		byref suffixchar as integer, _
		byval flags as LEXCHECK _
	)

	dim as integer skipchar = any

	'' (ALPHA | '_' )
	*pid = lexCurrentChar( )
	pid += 1
	tlen += 1
	suffixchar = CHAR_NULL
	lexEatChar( )

	skipchar = FALSE

	'' { [ALPHADIGIT | '_' ] }
	do
		var c = lexCurrentChar( )
		select case as const c
		case CHAR_AUPP to CHAR_ZUPP, _
			CHAR_ALOW to CHAR_ZLOW, _
			CHAR_0 to CHAR_9, _
			CHAR_UNDER

		case CHAR_DOT
			if( (flags and LEXCHECK_EATPERIOD) = 0 ) then
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
	dtype = FB_DATATYPE_INVALID

#if 0
	'' Possible method to disallow suffixes on identifiers in -lang fb
	'' completely would be to not read them.  No nead to report error
	'' or warning. The parser should report an error when it gets an
	'' invalid token on it's own.
	''
	if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) = FALSE ) then
		exit sub
	end if
#endif

	if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then
		select case as const lexCurrentChar( )
		'' '%'?
		case FB_TK_INTTYPECHAR
			dtype = env.lang.integerkeyworddtype
			suffixchar = FB_TK_INTTYPECHAR
			lexEatChar( )

		'' '&'?
		case FB_TK_LNGTYPECHAR
			dtype = FB_DATATYPE_LONG
			suffixchar = FB_TK_LNGTYPECHAR
			lexEatChar( )

		'' '!'?
		case FB_TK_SNGTYPECHAR
			dtype = FB_DATATYPE_SINGLE
			suffixchar = FB_TK_SNGTYPECHAR
			lexEatChar( )

		'' '#'?
		case FB_TK_DBLTYPECHAR '' alias for CHAR_SHARP
			'' isn't it a '##'?
			if( lexGetLookAheadChar( ) <> FB_TK_DBLTYPECHAR ) then
				dtype = FB_DATATYPE_DOUBLE
				suffixchar = FB_TK_DBLTYPECHAR
				lexEatChar( )
			end if

		'' '$'?
		case FB_TK_STRTYPECHAR
			dtype = FB_DATATYPE_STRING
			suffixchar = FB_TK_STRTYPECHAR
			lexEatChar( )
		end select
	end if

end sub

''::::
''hex_oct_bin     = '&' OCTDIG+
''                | '&' 'H' HEXDIG+
''                | '&' 'O' OCTDIG+
''                | '&' 'B' BINDIG+
''
private function hReadNonDecNumber _
	( _
		byref pnum as zstring ptr, _
		byref tlen as integer, _
		byref dtype as integer, _
		byval flags as LEXCHECK _
	) as ulongint

	dim as uinteger value = any, c = any, first_c = any
	dim as ulongint value64 = any
	dim as integer lgt = any, havedigits = any
	dim as integer skipchar = any

	assert( dtype = FB_DATATYPE_SHORT )

	value = 0
	lgt = 0
	skipchar = FALSE
	havedigits = FALSE

	#if __FB_DEBUG__
		'' expect that hReadNonDecNumber( ) was called with '&' in lexCurrentChar( )
		c = lexCurrentChar( )
		assert( c = CHAR_AMP )
	#endif

	c = lexGetLookAheadChar( )

	'' and octal number immediately after '&' indicates octal
	select case as const c
	case CHAR_0 to CHAR_7
		c = CHAR_OUPP
		'' don't lexEatChar( ) here, case CHAR_OUPP, CHAR_OLOW
		'' will take take of it below
	case else
		'' no octal char is next so consume the char and lex normally
		'' '&'
		lexEatChar( )
	end select

	select case as const c
	'' hex
	case CHAR_HUPP, CHAR_HLOW
		pnum[0] = CHAR_AMP
		pnum[1] = c
		pnum += 2
		tlen += 2
		lexEatChar( )

		'' skip leading zeroes if not inside a comment or parsing an $include
		if( (flags and (LEXCHECK_NOLINECONT or LEXCHECK_NOSUFFIX)) = 0 ) then
			while( lexCurrentChar( ) = CHAR_0 )
				*pnum = CHAR_0
				pnum += 1
				tlen += 1
				lexEatChar( )
				havedigits = TRUE
			wend
		end if

		do
			c = lexCurrentChar( )
			select case c
			case CHAR_ALOW to CHAR_FLOW, CHAR_AUPP to CHAR_FUPP, CHAR_0 to CHAR_9
				lexEatChar( )
				havedigits = TRUE
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
							dtype = FB_DATATYPE_LONGINT
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
						if( lgt = 5 ) then
							dtype = FB_DATATYPE_LONG
						end if
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
		pnum[1] = c
		pnum += 2
		tlen += 2
		lexEatChar( )

		'' skip leading zeroes if not inside a comment or parsing an $include
		if( (flags and (LEXCHECK_NOLINECONT or LEXCHECK_NOSUFFIX)) = 0 ) then
			while( lexCurrentChar( ) = CHAR_0 )
				*pnum = CHAR_0
				pnum += 1
				tlen += 1
				lexEatChar( )
				havedigits = TRUE
			wend
		end if

		first_c = lexCurrentChar( )
		do
			c = lexCurrentChar( )
			select case c
			case CHAR_0 to CHAR_7
				lexEatChar( )
				havedigits = TRUE

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
								dtype = FB_DATATYPE_LONGINT
								value64 = (culngint( value ) * 8) + c
							else
								value = (value * 8) + c
							end if

						case 12
							if( typeGetSize( dtype ) < 8  ) then
								dtype = FB_DATATYPE_LONGINT
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
						if( lgt = 6 ) then
							if( first_c > CHAR_1 ) then
								dtype = FB_DATATYPE_LONG
							end if
						elseif( lgt = 7 ) then
							dtype = FB_DATATYPE_LONG
						end if
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
		pnum[1] = c
		pnum += 2
		tlen += 2
		lexEatChar( )

		'' skip leading zeroes if not inside a comment or parsing an $include
		if( (flags and (LEXCHECK_NOLINECONT or LEXCHECK_NOSUFFIX)) = 0 ) then
			while( lexCurrentChar( ) = CHAR_0 )
				*pnum = CHAR_0
				pnum += 1
				tlen += 1
				lexEatChar( )
				havedigits = TRUE
			wend
		end if

		do
			c = lexCurrentChar( )
			select case c
			case CHAR_0, CHAR_1
				lexEatChar( )
				havedigits = TRUE

				if( skipchar = FALSE ) then
					*pnum = c
					pnum += 1
					tlen += 1

					c -= CHAR_0

					lgt += 1
					if( lgt > 32 ) then
						if( lgt = 33 ) then
							dtype = FB_DATATYPE_LONGINT
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
						if( lgt = 17 ) then
							dtype = FB_DATATYPE_LONG
						end if
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


	'' lgt havedigits
	''  0     FALSE    no numbers, show a warning and recover
	''  0     TRUE     all leading zeroes, truncate to single zero
	''  >0    FALSE    not possible - do nothing here
	''  >0    TRUE     normal number - do nothing here

	'' no number or only leading zeros?
	if( lgt = 0 ) then
		'' no digits at all? show a warning
		if( havedigits = FALSE ) then
			if( (flags and (LEXCHECK_NOLINECONT or LEXCHECK_NOSUFFIX)) = 0 ) then
				errReportWarn( FB_WARNINGMSG_EXPECTEDDIGIT )
			end if
		end if
		'' truncate or recover with a single 0
		*pnum = CHAR_0
		pnum += 1
		tlen += 1
	end if

	if( typeGetSize( dtype ) < 8 ) then
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
		byref t as FBTOKEN, _
		byval hasdot as integer, _
		byval flags as LEXCHECK _
	)

	dim as uinteger c = any
	dim as integer llen = any
	dim as integer skipchar = any

	t.dtype = env.lang.floatliteraldtype
	llen = t.len
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
				t.len += 1
			end if
		case else
			exit do
		end select

		'' no more room?
		if( t.len = FB_MAXNUMLEN ) then
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

	if( t.len > 7 + iif( hasdot, 1, 0 ) ) then
		t.dtype = FB_DATATYPE_DOUBLE
	end if

	'' [FSUFFIX | { EXPCHAR [opadd] DIGIT { DIGIT } } | ]
	c = lexCurrentChar( )
	select case as const c
	'' 'e', 'E', 'd', 'D'?
	case CHAR_ELOW, CHAR_EUPP, CHAR_DLOW, CHAR_DUPP
		'' EXPCHAR
		if( c = CHAR_DLOW or c = CHAR_DUPP ) then
			t.dtype = FB_DATATYPE_DOUBLE
		end if
		if( skipchar = FALSE ) then
			if( flags = LEXCHECK_EVERYTHING ) then
				'' make sure exp char is an 'e'
				'' (Val should accept 'd's, so may not be necessary now...)
				c = CHAR_ELOW
			end if
			*pnum = c
			pnum += 1
			t.len += 1
		end if
		lexEatChar( )

		'' [opadd]
		c = lexCurrentChar( )
		if( (c = CHAR_PLUS) or (c = CHAR_MINUS) ) then
			lexEatChar( )
			if( skipchar = FALSE ) then
				*pnum = c
				pnum += 1
				t.len += 1
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
					t.len += 1
				end if
			case else
				exit do
			end select

			'' no more room?
			if( t.len = FB_MAXNUMLEN ) then
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


	select case as const lexCurrentChar( )
	'' 'F', 'f'?
	case CHAR_FUPP, CHAR_FLOW
		t.dtype = FB_DATATYPE_SINGLE

		if( (flags and (LEXCHECK_NOSUFFIX or LEXCHECK_NOLETTERSUFFIX)) = 0 ) then
			lexEatChar( )
		end if

	'' '!'
	case FB_TK_SNGTYPECHAR
		t.dtype = FB_DATATYPE_SINGLE

		if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then
			lexEatChar( )
		end if

	'' '#'?
	case FB_TK_DBLTYPECHAR '' alias for CHAR_SHARP
		t.dtype = FB_DATATYPE_DOUBLE

		if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then
			lexEatChar( )
		end if

	end select

	if( flags = LEXCHECK_EVERYTHING ) then
		if( t.len - llen = 0 ) then
			'' '0'
			*pnum = CHAR_0
			pnum += 1
			t.len += 1
		end if
	endif

end sub

private sub readNumberChars _
	( _
		byref t as FBTOKEN, _
		byref flags as LEXCHECK, _
		byref pnum as zstring ptr, _
		byref skipchar as integer, _
		byref value as ulongint _
	)

	'' Skip leading zeroes if not inside a comment or parsing an $include
	var save_first_leading_zero = ((flags and (LEXCHECK_NOLINECONT or LEXCHECK_NOSUFFIX)) <> 0)

	dim value_prev as ulongint

	do
		var c = lexCurrentChar( )
		select case as const c
		case CHAR_0 to CHAR_9
			lexEatChar( )
			if( ((c <> CHAR_0) or (t.len > 0) or save_first_leading_zero) and _
				(not skipchar) ) then
				*pnum = c
				pnum += 1
				t.len += 1
				value = (value shl 3) + (value shl 1) + (c - CHAR_0)
			end if

		case CHAR_DOT, CHAR_ELOW, CHAR_EUPP, CHAR_DLOW, CHAR_DUPP
			var hasdot = FALSE
			if( c = CHAR_DOT ) then
				lexEatChar( )
				if( skipchar = FALSE ) then
					*pnum = CHAR_DOT
					pnum += 1
					t.len += 1
				end if
				hasdot = TRUE
			end if

			hReadFloatNumber( pnum, t, hasdot, flags )
			exit do

		case else
			exit do
		end select

		if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then
			if( skipchar = FALSE ) then
				select case as const t.len
				case 5
					if( value > 32767 ) then
						t.dtype = FB_DATATYPE_LONG
					end if

				case 6
					t.dtype = FB_DATATYPE_LONG

				case 10
					if( value > 2147483647ULL ) then
						if( value > 4294967295ULL ) then
							t.dtype = FB_DATATYPE_LONGINT
						else
							t.dtype = FB_DATATYPE_ULONG
						end if
					end if

				case 11
					t.dtype = FB_DATATYPE_LONGINT

				case 19
					if( value > 9223372036854775807ULL ) then
						t.dtype = FB_DATATYPE_ULONGINT
					end if
					value_prev = value

				case 20
					t.dtype = FB_DATATYPE_ULONGINT
					if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
						if( value_prev > 1844674407370955161ULL or _
						(value and &h8000000000000000ULL) = 0 ) then
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
				if( t.len = FB_MAXNUMLEN ) then
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

	if( t.len = 0 ) then
		*pnum = CHAR_0
		pnum += 1
		t.len = 1
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
private sub hReadNumber( byref t as FBTOKEN, byval flags as LEXCHECK )
	'' Starting with SHORT for the integer literal parser,
	'' may be changed to USHORT, LONG, ULONG, LONGINT, ULONGINT,
	'' depending on the literal's size.
	'' The float literal parser will change this to SINGLE/DOUBLE.
	t.dtype = FB_DATATYPE_SHORT

	var have_u_suffix = FALSE, skipchar = FALSE
	dim value as ulongint

	var pnum = @t.text[0]
	*pnum = 0
	t.len = 0

	select case as const lexCurrentChar( )
	'' integer part
	case CHAR_0 to CHAR_9
		readNumberChars( t, flags, pnum, skipchar, value )

	'' fractional part
	case CHAR_DOT
		lexEatChar( )
		'' add '.'
		*pnum = CHAR_DOT
		pnum += 1
		t.len = 1
		hReadFloatNumber( pnum, t, TRUE, flags )

	'' hex, oct, bin
	case CHAR_AMP
		'' let hReadNonDecNumber call lexEatChar( ) just in case the
		'' literal number starts with &[0..7]
		t.len = 0
		value = hReadNonDecNumber( pnum, t.len, t.dtype, flags )

	end select

	'' null-term
	*pnum = 0

	select case( t.dtype )
	case FB_DATATYPE_SHORT    : t.dtype = env.lang.int15literaldtype
	case FB_DATATYPE_USHORT   : t.dtype = env.lang.int16literaldtype
	case FB_DATATYPE_LONG     : t.dtype = env.lang.int31literaldtype
	case FB_DATATYPE_ULONG    : t.dtype = env.lang.int32literaldtype
	case FB_DATATYPE_LONGINT  : t.dtype = env.lang.int63literaldtype
	case FB_DATATYPE_ULONGINT : t.dtype = env.lang.int64literaldtype
#if __FB_DEBUG__
	case FB_DATATYPE_SINGLE, FB_DATATYPE_DOUBLE
	case else
		assert( FALSE )
#endif
	end select

	'' check suffix type
	if( typeGetClass( t.dtype ) <> FB_DATACLASS_FPOINT ) then
		if( (flags and LEXCHECK_NOSUFFIX) = 0 ) then

			'' 'U' | 'u'
			if( (flags and LEXCHECK_NOLETTERSUFFIX) = 0 ) then
				select case lexCurrentChar( )
				case CHAR_UUPP, CHAR_ULOW
					lexEatChar( )
					t.dtype = typeToUnsigned( t.dtype )
					have_u_suffix = TRUE
				end select
			end if

			select case as const lexCurrentChar( )
			'' 'L' | 'l'
			case CHAR_LUPP, CHAR_LLOW
				if( (flags and LEXCHECK_NOLETTERSUFFIX) = 0 ) then
					lexEatChar( )
					'' 'LL'?
					var c = lexCurrentChar( )
					if( (c = CHAR_LUPP) or (c = CHAR_LLOW) ) then
						lexEatChar( )
						'' 'ULL' or 'LL'
						t.dtype = iif( have_u_suffix, FB_DATATYPE_ULONGINT, FB_DATATYPE_LONGINT )
					'' 'L' only
					else
						'' LONG is 32bit; warn if number is > 32bit
						if( value > &hFFFFFFFFull ) then
							if( skipchar = FALSE ) then
								if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
									errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
								end if
							end if
						end if
						'' 'UL' or 'L'
						t.dtype = iif( have_u_suffix, FB_DATATYPE_ULONG, FB_DATATYPE_LONG )
					end if
				end if

			'' 'F' | 'f'
			case CHAR_FUPP, CHAR_FLOW
				if( (flags and LEXCHECK_NOLETTERSUFFIX) = 0 ) then
					if( have_u_suffix = FALSE ) then
						t.dtype = FB_DATATYPE_SINGLE
						lexEatChar( )
					end if
				end if

			'' 'D' | 'd'
			'' (NOTE: should this ever occur? Wouldn't it have been parsed as a float already?)
			case CHAR_DUPP, CHAR_DLOW
				if( (flags and LEXCHECK_NOLETTERSUFFIX) = 0 ) then
					if( have_u_suffix = FALSE ) then
						t.dtype = FB_DATATYPE_DOUBLE
						lexEatChar( )
					end if
				end if

			'' '%'
			case FB_TK_INTTYPECHAR
				'' Assuming it'll be either SHORT (16bit) or INTEGER (32bit or 64bit).
				'' So, no need to worry about 8bit. And if it's 64bit, no need to warn
				'' either - because it's always big enough.
				var warn = FALSE
				select case( typeGetSize( env.lang.integerkeyworddtype ) )
				case 2    : warn = (value > &hFFFFull)
				case 4    : warn = (value > &hFFFFFFFFull)
				end select
				if( warn ) then
					if( skipchar = FALSE ) then
						if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
							errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
						end if
					end if
				end if
				t.dtype = env.lang.integerkeyworddtype

				lexEatChar( )

			'' '&'
			case FB_TK_LNGTYPECHAR
				if( value > &hFFFFFFFFull ) then
					if( skipchar = FALSE ) then
						if( (flags and LEXCHECK_NOLINECONT) = 0 ) then
							errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
						end if
					end if
				end if
				t.dtype = FB_DATATYPE_LONG

				lexEatChar( )

			'' '!'
			case FB_TK_SNGTYPECHAR
				if( have_u_suffix = FALSE ) then
					t.dtype = FB_DATATYPE_SINGLE
					lexEatChar( )
				end if

			'' '#'
			case FB_TK_DBLTYPECHAR '' alias for CHAR_SHARP
				if( have_u_suffix = FALSE ) then
					'' isn't it a '##'?
					if( lexGetLookAheadChar( ) <> FB_TK_DBLTYPECHAR ) then
						t.dtype = FB_DATATYPE_DOUBLE
						lexEatChar( )
					end if
				end if

			end select

		end if
	end if

	t.class = FB_TKCLASS_NUMLITERAL
	t.id = t.dtype
end sub

'':::::
''string          = '"' { ANY_CHAR_BUT_QUOTE } '"'.   # less quotes
''
private sub hReadString _
	( _
		byval tk as FBTOKEN ptr, _
		byval ps as zstring ptr, _
		byval flags as LEXCHECK _
	)

	dim as integer lgt = any, hasesc = any, escaped = any, skipchar = any
	dim as uinteger char = any

	*ps = 0
	lgt = 0
	hasesc = FALSE

	escaped = (tk->id = FB_TK_STRLIT_ESC)
	skipchar = FALSE

	'' Save opening quote?
	if( flags and LEXCHECK_NOQUOTES ) then
		*ps = lexCurrentChar( )
		ps += 1
		lgt += 1
	end if
	lexEatChar( )

	do
		char = lexCurrentChar( )

		'' '"'?
		if( char = CHAR_QUOTE ) then
			lexEatChar( )

			'' copy quote? (even if first of a double)
			if( (flags and LEXCHECK_NOQUOTES) <> 0 ) then
				if( skipchar = FALSE ) then
					*ps = CHAR_QUOTE
					ps += 1
					lgt += 1
				end if
			end if

			'' not a double-quote? then it's the closing quote
			char = lexCurrentChar( )
			if( char <> CHAR_QUOTE ) then exit do

		'' '[\x1b]' (internal escape char)
		elseif( char = FB_INTSCAPECHAR ) then

			'' escape it?
			if( (flags and LEXCHECK_NOQUOTES) = 0 ) then
				if( skipchar = FALSE ) then
					*ps = FB_INTSCAPECHAR
					ps += 1
					lgt += 1
				end if
			end if

		'' '\'?
		elseif( char = CHAR_RSLASH ) then
			hasesc = TRUE

			'' escaping on? needed or "\\" would fail..
			if( escaped ) then
				lexEatChar( )

				if( skipchar = FALSE ) then
					*ps = CHAR_RSLASH
					ps += 1
					lgt += 1
				end if

				char = lexCurrentChar( )
			end if

		end if

		select case char
		'' EOF or EOL?
		case 0, CHAR_CR, CHAR_LF
			'' only warn if not in comments
			if (flags and (LEXCHECK_NOLINECONT or LEXCHECK_NOSUFFIX)) = 0 then
				errReportWarn( FB_WARNINGMSG_NOCLOSINGQUOTE )
			end if
			exit do

		end select

		lexEatChar( )

		if( skipchar = FALSE ) then
			'' no more room?
			if( lgt = FB_MAXLITLEN ) then
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
				lgt += 1
			end if
		end if

	loop

	'' null-term
	*ps = 0

	tk->dtype = FB_DATATYPE_CHAR
	tk->len = lgt
	tk->hasesc = hasesc

end sub

'':::::
''string          = '"' { ANY_CHAR_BUT_QUOTE } '"'.   # less quotes
''
private sub hReadWStr _
	( _
		byval tk as FBTOKEN ptr, _
		byval ps as wstring ptr, _
		byval flags as LEXCHECK _
	)

	dim as integer lgt = any, hasesc = any, escaped = any, skipchar = any
	dim as uinteger char = any

	*ps = 0
	lgt = 0
	hasesc = FALSE

	escaped = (tk->id = FB_TK_STRLIT_ESC)
	skipchar = FALSE

	'' Save opening quote?
	if( flags and LEXCHECK_NOQUOTES ) then
		*ps = lexCurrentChar( )
		ps += 1
		lgt += 1
	end if
	lexEatChar( )

	do
		char = lexCurrentChar( )

		'' '"'?
		if( char = CHAR_QUOTE ) then
			lexEatChar( )

			'' copy quote? (even if first of a double)
			if( (flags and LEXCHECK_NOQUOTES) <> 0 ) then
				if( skipchar = FALSE ) then
					*ps = CHAR_QUOTE
					ps += 1
					lgt += 1
				end if
			end if

			'' not a double-quote? then it's the closing quote
			char = lexCurrentChar( )
			if( char <> CHAR_QUOTE ) then exit do

		'' '\27' (internal escape char)
		elseif( char = FB_INTSCAPECHAR ) then

			'' escape it?
			if( (flags and LEXCHECK_NOQUOTES) = 0 ) then
				if( skipchar = FALSE ) then
					*ps = FB_INTSCAPECHAR
					ps += 1
					lgt += 1
				end if
			end if

		'' '\'?
		elseif( char = CHAR_RSLASH ) then
			hasesc = TRUE

			'' escaping on? needed or "\\" would fail..
			if( escaped ) then
				lexEatChar( )

				if( skipchar = FALSE ) then
					*ps = CHAR_RSLASH
					ps += 1
					lgt += 1
				end if

				char = lexCurrentChar( )
			end if

		end if

		select case char
		'' EOF or EOL?
		case 0, CHAR_CR, CHAR_LF
			'' only warn if not in comments
			if (flags and (LEXCHECK_NOLINECONT or LEXCHECK_NOSUFFIX)) = 0 then
				errReportWarn( FB_WARNINGMSG_NOCLOSINGQUOTE )
			end if
			exit do

		end select

		lexEatChar( )

		if( skipchar = FALSE ) then
			'' no more room?
			if( lgt = FB_MAXLITLEN ) then
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
				lgt += 1
			end if
		end if

	loop

	'' null-term
	*ps = 0

	tk->dtype = FB_DATATYPE_WCHAR
	tk->len = lgt
	tk->hasesc = hasesc

end sub

'':::::
private sub hCheckPeriods _
	( _
		byval t as FBTOKEN ptr, _
		byval flags as LEXCHECK, _
		byval chain_ as FBSYMCHAIN ptr _
	)

	dim as integer readfullid = any

	'' handle the stupid '.'s in symbols
	if( chain_ <> NULL ) then
		readfullid = FALSE

		'' is the next char a period?
		if( lexCurrentChar( ) = CHAR_DOT ) then
			'' not a qualified name (namespace or UDT var)?
			if( symbGetClass( chain_->sym ) <> FB_SYMBCLASS_NAMESPACE ) then
				readfullid = TRUE

				'' search UDT variables
				do while( chain_ <> NULL )
					dim as FBSYMBOL ptr sym = chain_->sym
					do
						if( symbIsVar( sym ) ) then
							if( symbGetType( sym ) = FB_DATATYPE_STRUCT ) then
								exit sub
							end if
						end if

						sym = sym->hash.next
					loop while( sym <> NULL )

					chain_ = symbChainGetNext( chain_ )
				loop
			end if
		end if

	'' no symbol..
	else
		'' only read if next char is a '.'
		readfullid = (lexCurrentChar( ) = CHAR_DOT)
	end if

	'' read the remaining? (including the '.'s)
	if( readfullid ) then
		t->prdpos = t->len
		hReadIdentifier( @t->text[t->len], _
						t->len, _
						t->dtype, _
						t->suffixchar, _
						flags or LEXCHECK_EATPERIOD )

		t->sym_chain = symbLookup( @t->text, t->id, t->class )
	end if

end sub

private function readId( byref t as FBTOKEN, byval flags as LEXCHECK ) as integer
	'' Capture the currmacro status for ppDefineLoad() (in case this is a macro),
	'' before we skip the identifier's chars, because that could reset the currmacro
	'' if we leave the current expansion text in the process.
	var currmacro = lex.ctx->currmacro

	t.len = 0
	t.prdpos = 0
	hReadIdentifier( @t.text, t.len, t.dtype, t.suffixchar, flags )

	'' use the special hash tb?
	if( flags and LEXCHECK_KWDNAMESPC ) then
		t.sym_chain = symbLookupAt(lex.ctx->kwdns, @t.text, FALSE, FALSE)

		'' not found?
		if( t.sym_chain = NULL ) then
			t.id = FB_TK_ID
			t.class = FB_TKCLASS_IDENTIFIER
		else
			t.id = t.sym_chain->sym->key.id
			t.class = t.sym_chain->sym->key.tkclass
		end if

		return TRUE
	end if

	'' don't search for symbols?
	if( flags and LEXCHECK_NOSYMBOL ) then
		t.id = FB_TK_ID
		t.class = FB_TKCLASS_IDENTIFIER
		return TRUE
	end if

	t.sym_chain = symbLookup( @t.text, t.id, t.class )

	'' don't load defines?
	if( flags and LEXCHECK_NODEFINE ) then
		return TRUE
	end if

	if( t.sym_chain ) then
		'' define? (defines can't have dups nor be part of namespaces)
		if( symbGetClass( t.sym_chain->sym ) = FB_SYMBCLASS_DEFINE ) then
			'' restart..
			if( ppDefineLoad( t.sym_chain->sym, currmacro ) ) then
				t.after_space = TRUE
				'' Ignore the ID and read expanded text
				return FALSE
			end if
		end if
	end if

	if( fbLangOptIsSet( FB_LANG_OPT_PERIODS ) ) then
		if( (flags and LEXCHECK_NOPERIOD) = 0 ) then
			hCheckPeriods( @t, flags, t.sym_chain )
		end if
	end if

	return TRUE
end function

'':::::
sub lexNextToken _
	( _
		byval t as FBTOKEN ptr, _
		byval flags as LEXCHECK _
	)

	dim as uinteger char = any
	dim as integer islinecont = any, lgt = any

	t->after_space = lex.ctx->after_space
	lex.ctx->after_space = FALSE

re_read:
	t->text[0] = 0                                  '' t.text = ""
	t->len = 0
	t->sym_chain = NULL

	'' skip white space
	islinecont = FALSE
	do
		char = lexCurrentChar( )

		select case as const char
		'' EOF?
		case 0
			t->id = FB_TK_EOF
			t->class = FB_TKCLASS_DELIMITER
			t->dtype = FB_DATATYPE_INVALID
			t->suffixchar = CHAR_NULL
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
					exit do

				'' could it be '_##'?
				case CHAR_SHARP
					if( lexGetLookAheadChar2( ) = CHAR_SHARP ) then
						exit do
					end if

				end select

				'' otherwise, skip until new-line is found
				lexEatChar( )
				islinecont = TRUE
				continue do

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
				t->dtype = FB_DATATYPE_INVALID
				t->suffixchar = CHAR_NULL
				t->len = 1
				t->text[0] = CHAR_LF                    '' t.text = chr( 10 )
				t->text[1] = 0                          '' /
				exit sub

			else
				t->after_space = TRUE
				UPDATE_LINENUM( )
				islinecont = FALSE
				continue do
			end if

		'' white-space?
		case CHAR_TAB, CHAR_SPACE
			t->after_space = TRUE
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

	lex.ctx->lastfilepos = lex.ctx->filepos + (lex.ctx->buffptr - @lex.ctx->buff) - 1

	select case as const char
	'' '.'?
	case CHAR_DOT
		'' only check for fpoint literals if not inside a comment or parsing an $include
		if( (flags and (LEXCHECK_NOLINECONT or LEXCHECK_NOSUFFIX)) = 0 ) then
			var lachar = lexGetLookAheadChar( )
			'' '0' .. '9'?
			if( (lachar >= CHAR_0) and (lachar <= CHAR_9) ) then
				hReadNumber( *t, flags )
				exit select
			end if
		end if
		goto read_char

	'' '&'?
	case CHAR_AMP
		select case lexGetLookAheadChar( )
		case CHAR_HUPP, CHAR_HLOW, CHAR_OUPP, CHAR_OLOW, CHAR_BUPP, CHAR_BLOW, CHAR_0 to CHAR_7
			hReadNumber( *t, flags )
		case else
			t->class = FB_TKCLASS_OPERATOR
			t->id = CHAR_AMP
			t->dtype = t->id
			t->len = 1
			t->text[0] = CHAR_AMP                   '' t.text = chr( char )
			t->text[1] = 0                          '' /
			lexEatChar( )
		end select

	'' '0' .. '9'?
	case CHAR_0 to CHAR_9
		hReadNumber( *t, flags )

	'' A-Z, a-z, _
	case CHAR_AUPP to CHAR_ZUPP, CHAR_ALOW to CHAR_ZLOW, CHAR_UNDER
		if( not readId( *t, flags ) ) then
			goto re_read
		end if

	'' '"'?
	case CHAR_QUOTE
		t->class = FB_TKCLASS_STRLITERAL
		t->id = iif( env.opt.escapestr, FB_TK_STRLIT_ESC, FB_TK_STRLIT )
		t->dtype = FB_DATATYPE_INVALID

		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
			hReadString( t, @t->text, flags )
		else
			hReadWStr( t, @t->textw, flags )
		end if

	'' '!' | '$'?
	case CHAR_EXCL, CHAR_DOLAR
		'' '"' following?
		if( lexGetLookAheadChar( ) <> CHAR_QUOTE ) then
			goto read_char
		end if

		lexEatChar( )

		t->class = FB_TKCLASS_STRLITERAL
		t->id = iif( char = CHAR_EXCL, FB_TK_STRLIT_ESC, FB_TK_STRLIT_NOESC )
		t->dtype = FB_DATATYPE_INVALID

		if( env.inf.format = FBFILE_FORMAT_ASCII ) then
			dim as zstring ptr ps = any

			'' do not preserve the string modifier?
			if( (flags and LEXCHECK_NOQUOTES) = 0 ) then
				ps = @t->text
			else
				t->text[0] = char
				ps = @t->text[1]
			end if

			hReadString( t, ps, flags )

		else
			dim as wstring ptr ps = any

			'' do not preserve the string modifier?
			if( (flags and LEXCHECK_NOQUOTES) = 0 ) then
				ps = @t->textw
			else
				t->textw[0] = char
				ps = @t->textw[1]
			end if

			hReadWStr( t, ps, flags )
		end if

	'':::::
	case else
read_char:

		t->id = char
		t->dtype = t->id
		t->suffixchar = CHAR_NULL
		t->len = 1
		t->text[0] = char                            '' t.text = chr( char )
		t->text[1] = 0                               '' /
		lexEatChar( )

		select case as const char
		'' '<', '>', '='?
		case CHAR_LT, CHAR_GT, CHAR_EQ
			t->class = FB_TKCLASS_OPERATOR

			select case char
			case CHAR_LT
				select case lexCurrentChar( )
				'' '<='?
				case CHAR_EQ
					t->text[t->len+0] = CHAR_EQ
					t->text[t->len+1] = 0
					t->len += 1
					t->id = FB_TK_LE
					lexEatChar( )

				'' '<>'?
				case CHAR_GT
					t->text[t->len+0] = CHAR_GT
					t->text[t->len+1] = 0
					t->len += 1
					t->id = FB_TK_NE
					lexEatChar( )

				case else
					t->id = FB_TK_LT
				end select

			case CHAR_GT
				'' '>='?
				if( (fbGetGtInParensOnly( ) = FALSE) andalso (lexCurrentChar( ) = CHAR_EQ) ) then
					t->text[t->len+0] = CHAR_EQ
					t->text[t->len+1] = 0
					t->len += 1
					t->id = FB_TK_GE
					lexEatChar( )
				else
					t->id = FB_TK_GT
				end if

			case CHAR_EQ
				'' '=>'?
				if( lexCurrentChar( ) = CHAR_GT ) then
					t->text[t->len+0] = CHAR_GT
					t->text[t->len+1] = 0
					t->len += 1
					t->id = FB_TK_DBLEQ
					lexEatChar( )
				else
					t->id = FB_TK_EQ
				end if
			end select

		'' '+', '*', '\', '^', '@'?
		case CHAR_PLUS, CHAR_TIMES, CHAR_RSLASH, CHAR_CART, CHAR_AT
			t->class = FB_TKCLASS_OPERATOR

		'' '-'?
		case CHAR_MINUS
			t->class = FB_TKCLASS_OPERATOR

			'' check for type-field dereference
			if( lexCurrentChar( ) = CHAR_GT ) then
				t->text[t->len+0] = CHAR_GT
				t->text[t->len+1] = 0
				t->len += 1
				t->id = FB_TK_FIELDDEREF
				lexEatChar( )
			end if

		'' '/'?
		case CHAR_SLASH
			t->class = FB_TKCLASS_OPERATOR
			'' only check for multiline comment if not inside
			'' a single line comment already (thanks to VonGodric for help)
			if( (flags and LEXCHECK_NOMULTILINECOMMENT) = 0 ) then
				'' "/'"?
				if( lexCurrentChar( ) = CHAR_APOST ) then
					'' multi-line comment..
					hMultiLineComment( )
					t->after_space = TRUE
					goto re_read
				end if
			end if

		'' '''
		case CHAR_APOST
			t->class = FB_TKCLASS_DELIMITER
			t->id = FB_TK_COMMENT

		'' ':'
		case CHAR_COLON
			t->class = FB_TKCLASS_DELIMITER
			t->id = FB_TK_STMTSEP

		'' '(', ')', ',', ';', '.', '{', '}', '[', ']'?
		case CHAR_LPRNT, CHAR_RPRNT, CHAR_COMMA, _
			CHAR_SEMICOLON, CHAR_DOT, CHAR_LBRACE, CHAR_RBRACE, _
			CHAR_LBRACKET, CHAR_RBRACKET
			t->class = FB_TKCLASS_DELIMITER

		'' ' ', '\t'?
		case CHAR_SPACE, CHAR_TAB
			t->class = FB_TKCLASS_DELIMITER
			t->id = CHAR_SPACE

			do
				select case as const lexCurrentChar( )
				case CHAR_SPACE, CHAR_TAB
					lexEatChar( )
					t->text[t->len] = CHAR_SPACE            '' t.text += " "
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
'' MultiLineComment  = '/' ''' . '/' '''
''
private sub hMultiLineComment( ) static
	dim as integer cnt

	'' skip the last '''
	lexEatChar( )

	cnt = 0
	do
		select case as const lexCurrentChar( )
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

		'' EOL?
		case CHAR_LF
			lexEatChar( )

			UPDATE_LINENUM( )

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

	if( lex.ctx->head->id = INVALID ) then
		lexNextToken( lex.ctx->head, flags )
		ppCheck( )
	end if

	function = lex.ctx->head->id

end function

'':::::
function lexGetClass _
	( _
		byval flags as LEXCHECK _
	) as integer static

	if( lex.ctx->head->id = INVALID ) then
		lexNextToken( lex.ctx->head, flags )
		ppCheck( )
	end if

	function = lex.ctx->head->class

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

	if( k > lex.ctx->k ) then
		lex.ctx->k = k
		lex.ctx->tail = lex.ctx->tail->next
	end if

	if( lex.ctx->tail->id = INVALID ) then
		lexNextToken( lex.ctx->tail, flags )
	end if

	function = lex.ctx->tail->id

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

	if( k > lex.ctx->k ) then
		lex.ctx->k = k
		lex.ctx->tail = lex.ctx->tail->next
	end if

	if( lex.ctx->tail->id = INVALID ) then
		lexNextToken( lex.ctx->tail, flags )
	end if

	function = lex.ctx->tail->class

end function

'':::::
private sub hMoveKDown( ) static

	lex.ctx->head->id = INVALID

	lex.ctx->k -= 1
	lex.ctx->head = lex.ctx->head->next

end sub

private function lexGetStrLitText( byval tk as integer ) as string
	dim as string s
	dim as integer is_escaped = any, saw_backslash = any
	dim as ubyte ptr p = any

	select case( tk )
	case FB_TK_STRLIT
		is_escaped = FALSE
	case FB_TK_STRLIT_ESC
		s += "!"
		is_escaped = TRUE
	case FB_TK_STRLIT_NOESC
		s += "$"
		is_escaped = FALSE
	end select

	s += """"

	'' Escaping is enabled for this string literal, so it could contain
	''  \"  (which didn't stop the string token parser), or
	''  "   (from "" sequences).
	''
	'' And \" shouldn't be turned into \"" in the -pp output...

	saw_backslash = FALSE
	p = lexGetText( )
	do
		select case( *p )
		case 0
			exit do

		case asc( """" )
			if( saw_backslash ) then
				'' It's just a '\"'
				s += """"
			else
				'' It's a '"', and the user did '""'
				s += """"""
			end if
			saw_backslash = FALSE

		case asc( "\" )
			saw_backslash = is_escaped
			s += "\"

		case else
			saw_backslash = FALSE
			s += chr( *p )

		end select

		p += 1
	loop

	s += """"

	function = s
end function

sub lexPPOnlyEmitToken( )
	select case( lexGetToken( ) )
	case FB_TK_COMMENT, FB_TK_REM
		'' Single-line comment
		exit sub

	case FB_TK_EOF, FB_TK_EOL
		'' EOF/EOL

		'' Don't write out empty lines (e.g. from PP directives)...
		if( len( pponly_ln ) > 0 ) then
			print #env.ppfile_num, pponly_ln
			pponly_ln = ""
		elseif( lexGetToken( ) = FB_TK_EOL ) then
			'' except for lines that really were empty, to help readability in the output.
			if( lex.ctx->lasttk_id = FB_TK_EOL ) then
				print #env.ppfile_num, ""
			end if
		end if

		exit sub
	end select

	'' Everything else...
	if( lex.ctx->head->after_space ) then
		pponly_ln += " "
	end if

	select case( lexGetToken( ) )
	case FB_TK_STRLIT, FB_TK_STRLIT_ESC, FB_TK_STRLIT_NOESC
		pponly_ln += lexGetStrLitText( lexGetToken( ) )
	case else
		pponly_ln += *lexGetText( )
	end select
end sub

sub lexPPOnlyEmitText( byref s as string )
	pponly_ln += s
end sub

sub lexSkipToken( byval flags as LEXCHECK )

	lexCheckToken( flags )

	'' don't preserve any flags that were for warn / error checks only
	flags and= not LEXCHECK_POST_MASK

	'' Emit current token, if -pp was given, except if called from the PP,
	'' so only the tokens seen by the parser are written.
	'' (some cases like #inclib are given special treatment in the PP)
	if( env.ppfile_num > 0 ) then
		if( lex.ctx->reclevel = 0 ) then
			lexPPOnlyEmitToken( )
		end if
	end if

	'' update stats
	select case lex.ctx->head->id
	case FB_TK_EOL
		UPDATE_LINENUM( )

	end select

	lex.ctx->lasttk_id = lex.ctx->head->id

	''
	if( lex.ctx->k = 0 ) then
		lexNextToken( lex.ctx->head, flags )
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
	if( lex.ctx->head->dtype <> FB_DATATYPE_WCHAR ) then
		*token = lex.ctx->head->text
	else
		*token = str( lex.ctx->head->textw )
	end if

	lexSkipToken( flags )

end sub

''::::
function lexGetText _
	( _
	) as zstring ptr static

	static as zstring * FB_MAXLITLEN+1 tmpstr

	if( lex.ctx->head->dtype <> FB_DATATYPE_WCHAR ) then
		function = @lex.ctx->head->text
	else
		tmpstr = str( lex.ctx->head->textw )
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
	do while( lex.ctx->k > 0 )
		select case lex.ctx->head->id
		case FB_TK_EOF, FB_TK_EOL, endchar
			exit sub
		case else
			if( skipline = FALSE ) then
				*dst += lex.ctx->head->text
			end if
		end select

		hMoveKDown( )
	loop

	'' check current token
	select case lex.ctx->head->id
	case FB_TK_EOF, FB_TK_EOL, endchar
		exit sub
	case else
		if( skipline = FALSE ) then
			*dst += lex.ctx->head->text
		end if
	end select

	''
	do
		char = lexCurrentChar( )

		'' EOF?
		select case as const char
		case 0
			lex.ctx->head->id = FB_TK_EOF
			lex.ctx->head->class = FB_TKCLASS_DELIMITER
			exit sub

		'' EOL?
		case CHAR_CR, CHAR_LF
			lexEatChar( )
			'' CRLF on DOS, LF only on *NIX
			if( char = CHAR_CR ) then
				if( lexCurrentChar( ) = CHAR_LF ) then
					lexEatChar( )
				end if
			end if

			lex.ctx->head->id    = FB_TK_EOL
			lex.ctx->head->class = FB_TKCLASS_DELIMITER
			exit sub

		case else
			'' closing char?
			if( char = endchar ) then
				lex.ctx->head->id    = endchar
				lex.ctx->head->class = FB_TKCLASS_DELIMITER
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
		byref token_pos as string, _
		byval do_trim as integer _
	) as string

	static as zstring * 1024+1 buffer
	dim as string res
	dim as integer p, old_p, start, token_len
	dim as ubyte ptr c
	dim as uinteger char

	function = ""

	'' !!!WRITEME!!!
	if( env.inf.format <> FBFILE_FORMAT_ASCII ) then
		exit function
	end if

	'' get file contents around current token
	old_p = seek( env.inf.num )

	if( lex.ctx->is_fb_eval ) then
		p = (lex.ctx-1)->lastfilepos - 512
	else
		p = lex.ctx->lastfilepos - 512
	end if

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
		do
			char = *c
			select case char
			case CHAR_CR, CHAR_LF
				exit do
			end select

			if( start <= 0 ) then
				exit do
			end if

			token_len += 1
			c -= 1
			start -= 1
		loop
		c += 1
	end if

	'' build source line
	res = ""
	token_pos = ""
	do
		char = *c
		select case char
		case 0, CHAR_CR, CHAR_LF
			exit do
		end select

		res += chr( char )
		if( token_len > 0 ) then
			token_pos += chr( iif( char = CHAR_TAB, CHAR_TAB, CHAR_SPACE ) )
			token_len -= 1
		end if

		c += 1
	loop

	if( do_trim ) then
		dim as integer i
		'' ltrim
		for i = 0 to len( res )-1
			select case res[i]
			case CHAR_TAB, CHAR_SPACE

			case else
				exit for
			end select
		next

		if( i < len( res ) ) then
			res = mid( res, 1+i )
		else
			res = ""
		end if

		'' rtrim
		for i = len( res )-1 to 0 step -1
			select case res[i]
			case CHAR_TAB, CHAR_SPACE

			case else
				exit for
			end select
		next

		if( i > 0 ) then
			res = left( res, 1+i )
		end if
	end if

	token_pos += "^"

	function = res

end function

'':::::
sub lexCheckToken _
	( _
		byval flags as LEXCHECK _
	)

	#define hStrSuffixChar(c) iif( c, chr(c), "" )
	#define hTokenDesc() "in '" & *lexGetText() & hStrSuffixChar( lexGetSuffixChar() ) & "'"
	#define hWarnSuffix() errReportWarn( FB_WARNINGMSG_SUFFIXIGNORED, hTokenDesc(), FB_ERRMSGOPT_NONE )
	#define hErrSuffix()  errReportNotAllowed( FB_LANG_OPT_SUFFIX, FB_ERRMSG_SUFFIXONLYVALIDINLANG )
	#define hDropSuffix() lexGetType() = FB_DATATYPE_INVALID : lexGetSuffixChar() = CHAR_NULL

	'' suffix?
	if( lexGetSuffixChar() <> CHAR_NULL ) then

		'' any suffix check flags?
		if( flags and LEXCHECK_POST_MASK ) then

			'' For these checks, type does not matter, just use the actual suffix char
			''   FB_TK_INTTYPECHAR, FB_TK_LNGTYPECHAR, FB_TK_SNGTYPECHAR, FB_TK_DBLTYPECHAR, FB_TK_STRTYPECHAR
			''
			'' If more than one flag is given, check only one
			''
			''   LEXCHECK_POST_SUFFIX         - no suffix is allowed, any dialect
			''   LEXCHECK_POST_LANG_SUFFIX    - suffix allowed but only if the dialect allows
			''   LEXCHECK_POST_STRING_SUFFIX  - string suffix $ allowed depending on dialect, and other suffixes not allowed

			'' no suffix is allowed in any dialect?
			if( (flags and LEXCHECK_POST_SUFFIX) <> 0 ) then
				hWarnSuffix()
				hDropSuffix()

			'' warn on suffix only if the dialect doesn't allow suffix?
			elseif( (flags and LEXCHECK_POST_LANG_SUFFIX) <> 0 ) then
				if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) = FALSE ) then
					hWarnSuffix()
					hDropSuffix()
				end if

			'' warn on '$' suffix depending if dialect allows suffix.
			elseif( (flags and LEXCHECK_POST_STRING_SUFFIX) <> 0 ) then

				if( fbLangOptIsSet( FB_LANG_OPT_SUFFIX ) ) then
					'' not string suffix?
					if( lexGetSuffixChar() <> FB_TK_STRTYPECHAR ) then
						hWarnSuffix()
						hDropSuffix()
					end if
				else
					'' string suffix?
					if( lexGetSuffixChar() = FB_TK_STRTYPECHAR ) then
						'' warn only '-w suffix' or '-w pedantic' was given
						if( fbPdCheckIsSet( FB_PDCHECK_SUFFIX ) ) then
							hWarnSuffix()
						end if
					else
						hWarnSuffix()
					end if
					'' error recovery: always drop the suffix
					''     the lang dialect doesn't support it
					hDropSuffix()
				end if

			end if
		end if
	end if

end sub

function hMatchIdOrKw _
	( _
		byval txt as const zstring ptr, _
		byval flags as LEXCHECK _
	) as integer

	select case( lexGetClass( ) )
	case FB_TKCLASS_IDENTIFIER, FB_TKCLASS_QUIRKWD, FB_TKCLASS_KEYWORD
		if( ucase( *lexGetText( ) ) = *txt ) then
			lexSkipToken( flags )
			return TRUE
		end if
	end select
	return FALSE
end function

'':::::
function hMatch _
	( _
		byval token as integer, _
		byval flags as LEXCHECK _
	) as integer

	if( lexGetToken( ) = token ) then
		lexSkipToken( flags )
		function = TRUE
	else
		function = FALSE
	end if

end function
