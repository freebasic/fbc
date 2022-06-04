'' string helpers
''
''


#include once "fb.bi"
#include once "fbint.bi"
#include once "dstr.bi"

'':::::
#macro ASSIGN_SETUP(dst, src, _type)
	dim as integer dst_len, src_len

	if( src = NULL ) then
		src_len = 0
	else
		src_len = len( *src )
	end if

	if( src_len = 0 ) then
		if( *dst <> NULL ) then
			deallocate( *dst )
			*dst = NULL
			exit sub
		end if
	end if

	if( *dst = NULL ) then
		dst_len = 0
	else
		dst_len = len( **dst )
	end if

	if( dst_len <> src_len ) then
		*dst = xallocate( (src_len+1) * len( _type ) )
	end if
#endmacro

'':::::
#macro CONCATASSIGN_SETUP(dst, src, _type)
	dim as integer dst_len, src_len

	if( src = NULL ) then
		exit sub
	end if

	src_len = len( *src )
	if( src_len = 0 ) then
		exit sub
	end if

	if( *dst = NULL ) then
		dst_len = 0
		*dst = xallocate( (src_len+1) * len( _type ) )
	else
		dst_len = len( **dst )
		*dst = xreallocate( *dst, (dst_len+src_len+1) * len( _type ) )
	end if
#endmacro

'':::::
sub ZstrAssign _
	( _
		byval dst as zstring ptr ptr, _
		byval src as zstring ptr _
	)

	ASSIGN_SETUP( dst, src, zstring )

	if( *dst <> NULL ) then
		**dst = *src
	end if

end sub

'':::::
sub ZstrAssignW _
	( _
		byval dst as zstring ptr ptr, _
		byval src as wstring ptr _
	)

	ASSIGN_SETUP( dst, src, zstring )

	if( *dst <> NULL ) then
		**dst = *src
	end if

end sub

'':::::
sub ZstrConcatAssign _
	( _
		byval dst as zstring ptr ptr, _
		byval src as zstring ptr _
	)

	CONCATASSIGN_SETUP( dst, src, zstring )

	if( *dst <> NULL ) then
		*(*dst + dst_len) = *src
	end if

end sub

'':::::
sub ZstrConcatAssignW _
	( _
		byval dst as zstring ptr ptr, _
		byval src as wstring ptr _
	)

	CONCATASSIGN_SETUP( dst, src, zstring )

	if( *dst <> NULL ) then
		*(*dst + dst_len) = *src
	end if

end sub


'':::::
sub WstrAssign _
	( _
		byval dst as wstring ptr ptr, _
		byval src as wstring ptr _
	)

	ASSIGN_SETUP( dst, src, wstring )

	if( *dst <> NULL ) then
		**dst = *src
	end if

end sub

'':::::
sub WstrAssignA _
	( _
		byval dst as wstring ptr ptr, _
		byval src as zstring ptr _
	)

	ASSIGN_SETUP( dst, src, wstring )

	if( *dst <> NULL ) then
		**dst = *src
	end if

end sub

'':::::
sub WstrConcatAssign _
	( _
		byval dst as wstring ptr ptr, _
		byval src as wstring ptr _
	)

	CONCATASSIGN_SETUP( dst, src, wstring )

	if( *dst <> NULL ) then
		*(*dst + dst_len) = *src
	end if

end sub

'':::::
sub WstrConcatAssignW _
	( _
		byval dst as wstring ptr ptr, _
		byval src as zstring ptr _
	)

	CONCATASSIGN_SETUP( dst, src, wstring )

	if( *dst <> NULL ) then
		*(*dst + dst_len) = *src
	end if

end sub

'':::::
function ZstrDup _
	( _
		byval s as zstring ptr _
	) as zstring ptr

	dim as zstring ptr dst

	dst = xallocate( len( *s ) + 1 )
	*dst = *s

	function = dst

end function

'':::::
function WstrDup _
	( _
		byval s as wstring ptr _
	) as wstring ptr

	dim as wstring ptr dst

	dst = xallocate( len( *s ) * len( wstring ) + len( wstring ) )
	*dst = *s

	function = dst

end function

'':::::
function hReplace _
	( _
		byval orgtext as zstring ptr, _
		byval oldtext as zstring ptr, _
		byval newtext as zstring ptr _
	) as string static

	dim as integer oldlen, newlen, p
	static as string text, remtext

	oldlen = len( *oldtext )
	newlen = len( *newtext )

	text = *orgtext
	p = 0
	do
		p = instr( p+1, text, *oldtext )
		if( p = 0 ) then
			exit do
		end if

		remtext = mid( text, p + oldlen )
		text = left( text, p-1 )
		text += *newtext
		text += remtext
		p += newlen-1
	loop

	function = text

end function

'':::::
function hReplaceW _
	( _
		byval orgtext as wstring ptr, _
		byval oldtext as wstring ptr, _
		byval newtext as wstring ptr _
	) as wstring ptr static

	dim as integer oldlen, newlen, p
	static as DWSTRING text, remtext

	oldlen = len( *oldtext )
	newlen = len( *newtext )

	DWstrAssign( text, orgtext )

	p = 0
	do
		p = instr( p+1, *text.data, *oldtext )
		if( p = 0 ) then
			exit do
		end if

		DWstrAssign( remtext, mid( *text.data, p + oldlen ) )
		DWstrAssign( text, left( *text.data, p-1 ) )
		DWstrConcatAssign( text, newtext )
		DWstrConcatAssign( text, remtext.data )
		p += newlen-1
	loop

	function = text.data

end function

'':::::
function hReplaceChar _
	( _
		byval orgtext as zstring ptr, _
		byval oldchar as integer, _
		byval newchar as integer _
	) as zstring ptr

	for i as integer = 0 to len( *orgtext ) - 1
		if( orgtext[i] = oldchar ) then
			orgtext[i] = newchar
		end if
	next

	function = orgtext

end function

'':::::
function hReEscape _
	( _
		byval text as zstring ptr, _
		byref textlen as integer, _
		byref isunicode as integer _
	) as zstring ptr static

	static as DZSTRING res
	dim as integer char, lgt, i, value, isnumber
	dim as zstring ptr src, dst, src_end

	'' convert escape sequences to internal format

	isunicode = FALSE
	textlen = 0

	lgt = len( *text )
	if( lgt = 0 ) then
		return text
	end if

	DZstrAllocate( res, lgt * 2 )

	src = text
	dst = res.data

	src_end = src + lgt
	do while( src < src_end )
		char = *src
		src += 1

		'' '\'?
		if( char = CHAR_RSLASH ) then

			if( src >= src_end ) then exit do

			'' change to internal
			*dst = FB_INTSCAPECHAR
			dst += 1

			isnumber = FALSE

			char = *src
			src += 1

			'' if it's a literal number, convert to octagonal
			select case char
			case CHAR_0 to CHAR_9
				isnumber = TRUE

				value = (char - CHAR_0)
				'' max 3 digits
				for i = 2 to 3
					if( src >= src_end ) then exit for

					char = *src
					if( (char < CHAR_0) or (char > CHAR_9) ) then
						exit for
					end if
					value = (value * 10) + (char - CHAR_0)
					src += 1
				next

			case CHAR_AMP, CHAR_XUPP, CHAR_XLOW
				if( src >= src_end ) then exit do

				value = 0

				if( char = CHAR_AMP ) then
					char = *src
					src += 1
				else
					'' make '\x', '\X' look like '\&H'
					char = CHAR_HUPP
				end if

				select case as const char
				'' hex?
				case CHAR_HUPP, CHAR_HLOW
					isnumber = TRUE

					'' max 2 digits
					for i = 1 to 2
						if( src >= src_end ) then exit for

						char = *src
						select case char
						case CHAR_ALOW to CHAR_FLOW, _
							CHAR_AUPP to CHAR_FUPP, _
							CHAR_0 to CHAR_9
							char -= CHAR_0
							if( char > 9 ) then
								char -= (CHAR_AUPP - CHAR_9 - 1)
							end if
							if( char > 16 ) then
								char -= (CHAR_ALOW - CHAR_AUPP)
							end if

							value = (value * 16) + char

						case else
							exit for
						end select
						src += 1
					next

				'' oct?
				case CHAR_OUPP, CHAR_OLOW
					isnumber = TRUE

					'' max 3 digits
					for i = 1 to 3
						if( src >= src_end ) then exit for

						char = *src
						if( (char < CHAR_0) or (char > CHAR_7) ) then
							exit for
						end if
						value = (value * 8) + (char - CHAR_0)
						src += 1
					next

				'' bin?
				case CHAR_BUPP, CHAR_BLOW
					isnumber = TRUE

					'' max 8 digits
					for i = 1 to 8
						if( src >= src_end ) then exit for

						char = *src
						if( (char < CHAR_0) or (char > CHAR_1) ) then
							exit for
						end if
						value = (value * 2) + (char - CHAR_0)
						src += 1
					next

				end select

			case CHAR_ALOW
				'' GAS does not support '\a'
				isnumber = TRUE
				value = CHAR_BELL

			'' 16-bit unicode?
			case CHAR_ULOW
				isunicode = TRUE

				'' 'u'
				*dst = char
				dst += 1

				for i = 1 to 4
					*dst = *src
					dst += 1
					src += 1
				next

				textlen += 2

				continue do

			'' 32-bit unicode?
			case CHAR_UUPP
				isunicode = TRUE

				'' break in two 16-bit..

				'' 'u'
				*dst = CHAR_UUPP
				dst += 1

				for i = 1 to 4
					*dst = *src
					dst += 1
					src += 1
				next

				'' '\u'
				dst[0] = FB_INTSCAPECHAR
				dst[1] = CHAR_UUPP
				dst += 2

				for i = 1 to 4
					*dst = *src
					dst += 1
					src += 1
				next

				textlen += 4

				continue do

			end select

			if( isnumber ) then
				if( cuint( value ) > 255 ) then
					errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
					value = 255
				end if

				'' save the oct len, or concatenation would fail
				'' if other numeric characters follow
				if( value < 8 ) then
					lgt = 1
				elseif( value < 64 ) then
					lgt = 2
				else
					lgt = 3
				end if

				*dst = lgt
				dst += 1

				*dst = oct( value )
				dst += lgt

				textlen += 1

				continue do
			end if

		end if

		*dst = char
		dst += 1
		textlen += 1
	loop

	'' null-term
	*dst = 0

	function = res.data

end function

'':::::
function hReEscapeW _
	( _
		byval text as wstring ptr, _
		byref textlen as integer _
	) as wstring ptr static

	static as DWSTRING res
	dim as integer char, lgt, i, isnumber
	dim as uinteger value
	dim as wstring ptr src, dst, src_end

	'' convert escape sequences to internal format

	textlen = 0

	lgt = len( *text )
	if( lgt = 0 ) then
		return text
	end if

	DWstrAllocate( res, lgt * 2 )

	src = text
	dst = res.data

	src_end = src + lgt
	do while( src < src_end )
		char = *src
		src += 1

		'' '\'?
		if( char = CHAR_RSLASH ) then

			if( src >= src_end ) then exit do

			'' change to internal
			*dst = FB_INTSCAPECHAR
			dst += 1

			isnumber = FALSE

			char = *src
			src += 1

			'' if it's a literal number, convert to octagonal
			select case char
			case CHAR_0 to CHAR_9
				isnumber = TRUE

				value = (char - CHAR_0)
				'' max 5 digits
				for i = 2 to 5
					if( src >= src_end ) then exit for

					char = *src
					if( (char < CHAR_0) or (char > CHAR_9) ) then
						exit for
					end if
					value = (value * 10) + (char - CHAR_0)
					src += 1
				next

			case CHAR_AMP, CHAR_XUPP, CHAR_XLOW
				if( src >= src_end ) then exit do

				value = 0

				if( char = CHAR_AMP ) then
					char = *src
					src += 1
				else
					'' make '\x', '\X' look like '\&H'
					char = CHAR_HUPP
				end if

				select case as const char
				'' hex?
				case CHAR_HUPP, CHAR_HLOW
					isnumber = TRUE

					'' max 4 digits
					for i = 1 to 4
						if( src >= src_end ) then exit for

						char = *src
						select case char
						case CHAR_ALOW to CHAR_FLOW, _
							CHAR_AUPP to CHAR_FUPP, _
							CHAR_0 to CHAR_9
							char -= CHAR_0
							if( char > 9 ) then
								char -= (CHAR_AUPP - CHAR_9 - 1)
							end if
							if( char > 16 ) then
								char -= (CHAR_ALOW - CHAR_AUPP)
							end if

							value = (value * 16) + char

						case else
							exit for
						end select
						src += 1
					next

				'' oct?
				case CHAR_OUPP, CHAR_OLOW
					isnumber = TRUE

					'' max 6 digits
					for i = 1 to 6
						if( src >= src_end ) then exit for

						char = *src
						if( (char < CHAR_0) or (char > CHAR_7) ) then
							exit for
						end if
						value = (value * 8) + (char - CHAR_0)
						src += 1
					next

				'' bin?
				case CHAR_BUPP, CHAR_BLOW
					isnumber = TRUE

					'' max 16 digits
					for i = 1 to 16
						if( src >= src_end ) then exit for

						char = *src
						if( (char < CHAR_0) or (char > CHAR_1) ) then
							exit for
						end if
						value = (value * 2) + (char - CHAR_0)
						src += 1
					next

				end select

			'' 16-bit unicode?
			case CHAR_ULOW
				'' 'u'
				*dst = char
				dst += 1

				for i = 1 to 4
					*dst = *src
					dst += 1
					src += 1
				next

				textlen += 2

				continue do

			'' 32-bit unicode?
			case CHAR_UUPP
				'' break in two 16-bit..

				'' 'u'
				*dst = CHAR_UUPP
				dst += 1

				for i = 1 to 4
					*dst = *src
					dst += 1
					src += 1
				next

				'' '\u'
				dst[0] = FB_INTSCAPECHAR
				dst[1] = CHAR_UUPP
				dst += 2

				for i = 1 to 4
					*dst = *src
					dst += 1
					src += 1
				next

				textlen += 4

				continue do

			end select

			if( isnumber ) then
				if( cuint( value ) > 65535 ) then
					errReportWarn( FB_WARNINGMSG_NUMBERTOOBIG )
					value = 65535
				end if

				'' save the oct len, or concatenation would fail
				'' if other numeric characters follow
				lgt = 1
				dim as uinteger uivalue = any
				uivalue = value
				do while( uivalue > 7 )
					uivalue shr= 3
					lgt += 1
				loop

				*dst = lgt
				dst += 1

				*dst = woct( value )
				dst += lgt

				textlen += 1

				continue do
			end if

		end if

		*dst = char
		dst += 1
		textlen += 1
	loop

	'' null-term
	*dst = 0

	function = res.data

end function

'':::::
function hEscape _
	( _
		byval text as const zstring ptr _
	) as const zstring ptr static

	static as DZSTRING res
	dim as integer c, octlen, lgt
	dim as const zstring ptr src, /'dst,'/ src_end
	dim as zstring ptr dst

	'' convert the internal escape sequences to GAS format

	octlen = 0

	lgt = len( *text )
	if( lgt = 0 ) then
		return text
	end if

	DZstrAllocate( res, lgt * 4 )

	src = text
	dst = res.data

	src_end = src + lgt
	do while( src < src_end )
		c = *src
		src += 1

		select case c
		case CHAR_RSLASH, CHAR_QUOTE
			*dst = CHAR_RSLASH
			dst += 1

		case FB_INTSCAPECHAR
			*dst = CHAR_RSLASH
			dst += 1

			if( src >= src_end ) then exit do
			c = *src
			src += 1

			'' octagonal?
			if( c >= 1 and c <= 3 ) then
				octlen = c
				if( src >= src_end ) then exit do
				c = *src
				src += 1
			end if

		case 0 to 31, 128 to 255
			*dst = CHAR_RSLASH
			dst += 1

			if( c < 8 ) then
				dst[0] = CHAR_0
				dst[1] = CHAR_0
				dst += 2
				c += CHAR_0

			elseif( c < 64 ) then
				dst[0] = CHAR_0
				dst[1] = CHAR_0 + (c shr 3)
				dst += 2
				c = CHAR_0 + (c and 7)

			else
				dst[0] = CHAR_0 + (c shr 6)
				dst[1] = CHAR_0 + ((c and &b00111000) shr 3)
				dst += 2
				c = CHAR_0 + (c and 7)
			end if

		end select

		*dst = c
		dst += 1

		'' add quote's when the octagonal escape ends
		if( octlen > 0 ) then
			octlen -= 1
			if( octlen = 0 ) then
				dst[0] = CHAR_QUOTE
				dst[1] = CHAR_QUOTE
				dst += 2
			end if
		end if
	loop

	'' null-term
	*dst = 0

	function = res.data

end function

'':::::
private function hRemapChar _
	( _
		byval char as integer _
	) as integer static

	select case as const char
	case asc( "r" )
		function = CHAR_CR

	case asc( "l" ), asc( "n" )
		function = CHAR_LF

	case asc( "t" )
		function = CHAR_TAB

	case asc( "b" )
		function = CHAR_BKSPC

	case asc( "a" )
		function = CHAR_BELL

	case asc( "f" )
		function = CHAR_FORMFEED

	case asc( "v" )
		function = CHAR_VTAB

	case else
		function = char
	end select

end function

'':::::
function hHasEscape _
	( _
		byval text as zstring ptr _
	) as integer static

	dim as uinteger char
	dim as integer lgt

	lgt = len( *text )
	do while( lgt > 0 )
		'' '\'?
		if( *text = CHAR_RSLASH ) then
			text += 1

			char = *text
			select case as const char
			case asc( "r" ), _
				asc( "l" ), _
				asc( "n" ), _
				asc( "t" ), _
				asc( "b" ), _
				asc( "a" ), _
				asc( "f" ), _
				asc( "v" ), _
				CHAR_QUOTE, _
				CHAR_0 to CHAR_9, _
				CHAR_AMP, _
				CHAR_ULOW, CHAR_UUPP, _
				CHAR_RSLASH

				return TRUE
			end select
		end if

		text += 1
		lgt -= 1
	loop

	function = FALSE

end function

'':::::
function hHasEscapeW _
	( _
		byval text as wstring ptr _
	) as integer static

	dim as uinteger char
	dim as integer lgt

	lgt = len( *text )
	do while( lgt > 0 )
		'' '\'?
		if( *text = CHAR_RSLASH ) then
			text += 1

			char = *text
			select case as const char
			case asc( "r" ), _
				asc( "l" ), _
				asc( "n" ), _
				asc( "t" ), _
				asc( "b" ), _
				asc( "a" ), _
				asc( "f" ), _
				asc( "v" ), _
				CHAR_QUOTE, _
				CHAR_0 to CHAR_9, _
				CHAR_AMP, _
				CHAR_ULOW, CHAR_UUPP, _
				CHAR_RSLASH

				return TRUE
			end select
		end if

		text += 1
		lgt -= 1
	loop

	function = FALSE

end function

''::::
private function hU16ToWchar _
	( _
		byval src as const wstring ptr _
	) as uinteger static

	dim as uinteger char, c
	dim as integer i

	'' x86 little-endian assumption
	char = 0

	for i = 1 to 4
		c = *src - CHAR_0
		src += 1

		if( c > 9 ) then
			c -= (CHAR_AUPP - CHAR_9 - 1)
		end if
		if( c > 16 ) then
			c -= (CHAR_ALOW - CHAR_AUPP)
		end if

		char = (char * 16) or c
	next

	function = char

end function


'':::::
function hEscapeW _
	( _
		byval text as const wstring ptr _
	) as zstring ptr static

	static as DZSTRING res
	dim as uinteger char, c
	dim as integer lgt, i, wcharlen
	dim as const wstring ptr src, src_end
	dim as zstring ptr dst

	'' convert the internal escape sequences to GAS format

	wcharlen = typeGetSize( FB_DATATYPE_WCHAR )

	'' up to (4 * wcharlen) ascii chars can be used per unicode char
	'' (up to one '\ooo' per byte of wchar)
	lgt = len( *text )
	if( lgt = 0 ) then
		return NULL
	end if

	DZstrAllocate( res, lgt * (1+3) * wcharlen )

	src = text
	dst = res.data

	src_end = src + lgt
	do while( src < src_end )
		char = *src
		src += 1

		'' internal espace char?
		if( char = FB_INTSCAPECHAR ) then
			if( src >= src_end ) then exit do
			char = *src
			src += 1

			'' octal? convert to integer..
			'' note: it can be up to 11 digits due wchr()
			'' when evaluated at compile-time
			if( (char >= 1) and (char <= 11) ) then
				i = char
				char = 0

				if( src + i > src_end ) then exit do

				do while( i > 0 )
					char = (char * 8) + (*src - CHAR_0)
					src += 1
					i -= 1
				loop

			else
				'' unicode 16-bit?
				if( char = asc( "u" ) ) then
					if( src + 4 > src_end ) then exit do
					char = hU16ToWchar( src )
					src += 4

				'' remap char as they will become a octagonal seq
				else
					char = hRemapChar( char )
				end if
			end if

		end if

		'' convert every char to octagonal form as GAS can't
		'' handle unicode literal strings
		for i = 1 to wcharlen
			*dst = CHAR_RSLASH
			dst += 1

			'' x86 little-endian assumption
			c = char and 255
			if( c < 8 ) then
				dst[0] = CHAR_0 + c
				dst += 1

			elseif( c < 64 ) then
				dst[0] = CHAR_0 + (c shr 3)
				dst[1] = CHAR_0 + (c and 7)
				dst += 2

			else
				dst[0] = CHAR_0 + (c shr 6)
				dst[1] = CHAR_0 + ((c and &b00111000) shr 3)
				dst[2] = CHAR_0 + (c and 7)
				dst += 3
			end if

			char shr= 8
		next

	loop

	'' null=term
	*dst = 0

	function = res.data

end function

'':::::
function hUnescape _
	( _
		byval text as zstring ptr, _
		byref textlen as integer = 0 _
	) as zstring ptr static

	static as DZSTRING res
	dim as integer char, lgt, i
	dim as zstring ptr src, dst, src_end

	textlen = 0

	lgt = len( *text )
	if( lgt = 0 ) then
		return text
	end if

	DZstrAllocate( res, lgt )

	src = text
	dst = res.data

	src_end = src + lgt
	do while( src < src_end )
		char = *src
		src += 1

		if( char = FB_INTSCAPECHAR ) then

			if( src >= src_end ) then exit do
			char = *src
			src += 1

			'' octagonal? convert to integer..
			if( (char >= 1) and (char <= 3) ) then
				i = char
				char = 0
				do while( i > 0 )
					char = (char * 8) + (*src - CHAR_0)
					src += 1
					i -= 1
				loop

			else
				'' remap char
				char = hRemapChar( char )

				'' note: zstring's won't contain \u seqs
			end if

		end if

		*dst = char
		dst += 1

	loop

	'' null-term
	*dst = 0

	textlen = (cast(integer, dst) - cast(integer, res.data))
	function = res.data

end function

'':::::
function hUnescapeW _
	( _
		byval text as wstring ptr, _
		byref textlen as integer = 0 _
	) as wstring ptr static

	static as DWSTRING res
	dim as integer char, lgt, i
	dim as wstring ptr src, dst, src_end

	textlen = 0

	lgt = len( *text )
	if( lgt = 0 ) then
		return text
	end if

	DWstrAllocate( res, lgt )

	src = text
	dst = res.data

	src_end = src + lgt
	do while( src < src_end )
		char = *src
		src += 1

		if( char = FB_INTSCAPECHAR ) then

			if( src >= src_end ) then exit do
			char = *src
			src += 1

			'' octagonal? convert to integer..
			'' note: it can be up to 11 digits due wchr()
			'' when evaluated at compile-time
			if( (char >= 1) and (char <= 11) ) then
				i = char
				char = 0
				do while( i > 0 )
					char = (char * 8) + (*src - CHAR_0)
					src += 1
					i -= 1
				loop

			else
				'' unicode 16-bit?
				if( char = asc( "u" ) ) then
					if( src + 4 > src_end ) then exit do
					char = hU16ToWchar( src )
					src += 4

				'' remap char as they will become a octagonal seq
				else
					char = hRemapChar( char )
				end if
			end if

		end if

		*dst = char
		dst += 1

	loop

	'' null-term
	*dst = 0

	textlen = (cast(integer, dst) - cast(integer, res.data)) \ sizeof(wstring)
	function = res.data

end function

function hCharNeedsEscaping _
	( _
		byval ch as integer, _
		byval quotechar as integer _
	) as integer

	'' Any special char, backslashes and single/double quotes (depending on
	'' context) must be escaped. Also any high (i.e. non-ASCII) codepage or
	'' Unicode chars should be escaped, to be safe.
	function = (ch < 32) or (ch >= 127) or _
		(ch = asc( $"\" )) or (ch = quotechar)
end function

function hIsValidHexDigit( byval ch as integer ) as integer
	function = ((ch >= asc( "0" )) and (ch <= asc( "9" ))) or _
		((ch >= asc( "a" )) and (ch <= asc( "f" ))) or _
		((ch >= asc( "A" )) and (ch <= asc( "F" )))
end function

function hStr2long( byref txt as string, byref value as long ) as integer
	'' could we not use VALINT() or some variation from rtlib?

	const CHAR_ZERO = asc("0")

	dim nvalue as long = 0
	dim nsign as long = 1

	if( len( txt ) = 0 ) then
		return FALSE
	end if

	dim s as ubyte ptr = strptr(txt)

	if( s = NULL orelse *s = CHAR_NULL ) then
		return FALSE
	end if

	if( *s = CHAR_MINUS ) then
		nsign = -1
		s += 1
	end if

	if( *s = CHAR_NULL ) then
		return FALSE
	end if

	while( hIsCharNumeric(*s) )
		nvalue *= 10
		nvalue += (*s - CHAR_ZERO)
		s += 1
	wend

	value = nvalue * nsign

	'' return TRUE if we read the entire string
	return (*s = CHAR_NULL)
end function

'':::::
sub hSplitStr(byref txt as string, byref del as string, res() as string)

	var items = 10
	redim dpos(0 to items-1) as integer

	var dellen = len(del)

	var cnt = 0
	var p = 1
	do
		p = instr(p, txt, del)
		if( p > 0 ) then
			if( cnt >= items ) then
				items += 10
				redim preserve dpos(0 to items-1)
			end if
			dpos(cnt) = p
			p += dellen
		end if
		cnt += 1
	loop until( p = 0 )

	cnt -= 1
	if( cnt = 0 ) then
		redim res(0 to 0)
		res(0) = txt
		return
	end if

	redim res(0 to cnt)
	res(0) = Left(txt, dpos(0) - 1 )
	p = 1
	do until( p = cnt )
		res(p) = mid(txt, dpos(p - 1) + dellen, dpos(p) - dpos(p - 1) - dellen )
		p += 1
	loop
	res(cnt) = mid(txt, dpos(cnt - 1) + dellen)

end sub

'':::::
function hStr2Tok(byval txt as const zstring ptr, res() as string) as integer

	dim as integer t = 0
	dim as uinteger lc = CHAR_SPACE
	dim as const ubyte ptr s = cast(const ubyte ptr, txt)
	do while( *s <> CHAR_NULL )
		dim as uinteger c = cast(uinteger, *s)

		if( c = CHAR_BELL ) then
			c = CHAR_SPACE
		end if

		if( c = CHAR_SPACE ) then
			if( lc <> CHAR_SPACE ) then
				t += 1
			end if
		end if

		lc = c
		s += 1
	loop

	if( lc <> CHAR_SPACE ) then
		t += 1
	end if

	if( t = 0 ) then
		return 0
	end if

	redim res(0 to t-1)

	t = 0
	lc = CHAR_SPACE
	s = cast(const ubyte ptr, txt)
	do while( *s <> CHAR_NULL )
		var c = cast(uinteger, *s)

		if( c = CHAR_BELL ) then
			c = CHAR_SPACE
		end if

		if( c = CHAR_SPACE ) then
			if( lc <> CHAR_SPACE ) then
				t += 1
			end if
		else
			res(t) += chr(c)
		end if

		lc = c
		s += 1
	loop

	function = iif(lc <> CHAR_SPACE, t + 1, t)

end function

'':::::
function hStr2Args( byval txt as const zstring ptr, res() as string ) as integer

	'' !!!TODO!!! add the wstring version

	dim as integer t = 0
	dim as const ubyte ptr s = cast(const ubyte ptr, txt)
	dim as integer prntcnt = 0
	dim as uinteger c = CHAR_NULL
	dim as integer max_t = 10

	if( txt = NULl ) then
		return 0
	end if

	#define PeekChar()   cast( uinteger, s[0] )
	#define SkipChar()   s += 1
	#define ReadChar(c)  res(t-1) += chr(c) : s += 1

	redim res( 0 to max_t-1 ) as string

	do
		c = PeekChar()
		if (c = CHAR_TAB) or (c = CHAR_SPACE) then
			SkipChar()
		else
			exit do
		end if
	loop

	'' no arguments?
	if( c = CHAR_NULL ) then
		return 0
	end if

	'' ok, there's at least one argument
	t += 1

	'' scan for arguments
	do
		c = PeekChar()
		select case c
		case CHAR_NULL
			exit do

		case CHAR_LPRNT
			prntcnt += 1

		case CHAR_RPRNT
			if( prntcnt > 0 ) then
				prntcnt -= 1
			end if

		case CHAR_COMMA
			if( prntcnt = 0 ) then
				t += 1
				if( t > max_t ) then
					max_t += 10
					redim preserve res( 0 to max_t - 1 )
				end if
				SkipChar()
				continue do
			end if

		case CHAR_QUOTE, CHAR_EXCL, CHAR_DOLAR
			dim as integer escaped = env.opt.escapestr
			if( c <> CHAR_QUOTE ) then
				escaped = ( c = CHAR_EXCL )

				'' '!' | '$'
				ReadChar(c)
				c = PeekChar()
				if( c <> CHAR_QUOTE ) then
					continue do
				end if

			end if

			'' '"'
			ReadChar(c)

			do
				c = PeekChar()
				if( c = CHAR_NULL ) then
					exit do
				end if

				'' '"' | '\' | any other string char
				ReadChar(c)
				if( c = CHAR_QUOTE ) then

					c = PeekChar()
					if( c <> CHAR_QUOTE ) then
						exit do
					end if

					'' '"'
					ReadChar(c)

				elseif( c = CHAR_RSLASH ) then

					c = PeekChar()
					select case c
					case CHAR_QUOTE, CHAR_RSLASH
						'' '"' | '\'
						ReadChar(c)
					end select

				end if
			loop
			continue do

		case CHAR_SLASH

			'' '/'
			ReadChar(c)

			c = PeekChar()
			if( c <> CHAR_APOST ) then
				continue do
			end if

			'' '''
			ReadChar(c)

			do
				c = PeekChar()
				if( c = CHAR_NULL ) then
					exit do
				end if

				'' ''' | any other comment char
				ReadChar(c)

				if( c = CHAR_APOST ) then
					c = PeekChar()
					if( c = CHAR_SLASH ) then
						'' '/'
						ReadChar(c)
						exit do
					end if
				end if

			loop
			continue do

		case CHAR_APOST
			while( c <> CHAR_NULL )
				'' ''' or any comment char to end of line
				ReadChar(c)
				c = PeekChar()
			wend
			exit do

		end select

		'' any other char not handled above
		ReadChar(c)

	loop

	function = t

end function
