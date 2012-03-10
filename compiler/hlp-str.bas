'' string helpers
''
''


#include once "fb.bi"
#include once "fbint.bi"
#include once "dstr.bi"

'':::::
#define ASSIGN_SETUP(dst, src, _type)							_
	dim as integer dst_len, src_len								:_
	                                                            :_
	if( src = NULL ) then                                       :_
		src_len = 0                                             :_
	else                                                        :_
		src_len = len( *src )                        			:_
	end if														:_
																:_
	if( src_len = 0 ) then                                      :_
		if( *dst <> NULL ) then                             	:_
			deallocate( *dst )                              	:_
			*dst = NULL                                     	:_
			exit sub                                            :_
		end if                                                  :_
	end if                                                      :_
                                                                :_
	if( *dst = NULL ) then                                      :_
		dst_len = 0                                             :_
	else                                                        :_
		dst_len = len( **dst )									:_
	end if														:_
                                                                :_
	if( dst_len <> src_len ) then                               :_
		*dst = xallocate( (src_len+1) * len( _type ) )    		:_
	end if

'':::::
#define CONCATASSIGN_SETUP(dst, src, _type)						_
	dim as integer dst_len, src_len								:_
	                                                            :_
	if( src = NULL ) then                                       :_
		exit sub												:_
	end if														:_
																:_
	src_len = len( *src )                        				:_
	if( src_len = 0 ) then                                      :_
		exit sub                                                :_
	end if                                                      :_
                                                                :_
	if( *dst = NULL ) then                                      :_
		dst_len = 0                                             :_
		*dst = xallocate( (src_len+1) * len( _type ) )			:_
	else                                                        :_
		dst_len = len( **dst )									:_
		*dst = xreallocate( *dst, (dst_len+src_len+1) * len( _type ) ) :_
	end if

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
				do while( value > 7 )
					value shr= 3
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
				c += CHAR_0

			elseif( c < 64 ) then
				*dst = CHAR_0 + (c shr 3)
				dst += 1
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
		byval src as wstring ptr _
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
		byval text as wstring ptr _
	) as zstring ptr static

    static as DZSTRING res
    dim as uinteger char, c
	dim as integer lgt, i, wcharlen
    dim as wstring ptr src, src_end
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

			'' octagonal? convert to integer..
			'' note: it can be up to 6 digits due wchr()
			'' when evaluated at compile-time
			if( (char >= 1) and (char <= 6) ) then
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
function hEscapeUCN _
	( _
		byval text as wstring ptr _
	) as zstring ptr

    static as DZSTRING res
    dim as uinteger char = any, c = any
    dim as integer lgt = any, i = any, wstrlen = any
    dim as wstring ptr src = any, src_end = any
    dim as zstring ptr dst = any

	'' convert the internal escape sequences to GCC format

	wstrlen = typeGetSize( FB_DATATYPE_WCHAR )
	var u_char = iif( wstrlen = len( FB_INTEGERSIZE ), asc( "U" ), asc( "u" ) )

	'' up to 6 ascii chars can be used p/ unicode char (\uxxxx) -- or \Uxxxxxxxx
	lgt = len( *text )
	if( lgt = 0 ) then
		return NULL
	end if

	DZstrAllocate( res, lgt * (2+wstrlen*2) + 1 )

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

			'' octagonal? convert to integer..
			'' note: it can be up to 6 digits due wchr()
			'' when evaluated at compile-time
			if( (char >= 1) and (char <= 6) ) then
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

		''
		if( char < &h00A0 ) then
			if( char < 32 ) then
				*dst = CHAR_RSLASH
				dst += 1
				if( char < 8 ) then
					dst[0] = CHAR_0 + char
					dst += 1
				else
					dst[0] = CHAR_0 + (char shr 3)
					dst[1] = CHAR_0 + (char and 7)
					dst += 2
				end if
			else
				*dst = char
				dst += 1
			end if

		else
			dst[0] = CHAR_RSLASH
			dst[1] = u_char
			dst += 2

			if( wstrlen = len( FB_INTEGERSIZE ) ) then
				for i = 0 to 3
					*dst = CHAR_0
					dst += 1
				next
			end if

			for i = 3 to 0 step -1
				'' x86 little-endian assumption
				c = char and 15
				if( c < 10 ) then
					dst[i] = CHAR_0 + c
				else
					dst[i] = asc( "A" ) + (c - 10)
				end if

        		char shr= 4
			next

			dst += 4
		end if

	loop

	'' null=term
	*dst = 0

	function = res.data

end function

'':::::
function hUnescape _
	( _
		byval text as zstring ptr _
	) as zstring ptr static

    static as DZSTRING res
    dim as integer char, lgt, i
    dim as zstring ptr src, dst, src_end

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

	function = res.data

end function

'':::::
function hUnescapeW _
	( _
		byval text as wstring ptr _
	) as wstring ptr static

    static as DWSTRING res
    dim as integer char, lgt, i
    dim as wstring ptr src, dst, src_end

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
			'' note: it can be up to 6 digits due wchr()
			'' when evaluated at compile-time
			if( (char >= 1) and (char <= 6) ) then
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

    function = res.data

end function

'':::::
function hGetWstrNull( ) as zstring ptr
    static as integer isset = FALSE
    static as zstring * FB_INTEGERSIZE*3+1 nullseq
    dim as integer i

    if( isset = FALSE ) then
    	isset = TRUE
    	nullseq = ""
    	for i = 1 to typeGetSize( FB_DATATYPE_WCHAR )
    		nullseq += RSLASH + "0"
    	next
	end if

	function = @nullseq

end function


