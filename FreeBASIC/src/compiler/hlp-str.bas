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


'' string helpers
''
''

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\dstr.bi"

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
		*dst = allocate( (src_len+1) * len( _type ) )    		:_
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
		*dst = allocate( (src_len+1) * len( _type ) )			:_
	else                                                        :_
		dst_len = len( **dst )									:_
		*dst = reallocate( *dst, (dst_len+src_len+1) * len( _type ) ) :_
	end if

'':::::
sub ZstrAssign ( byval dst as zstring ptr ptr, _
				 byval src as zstring ptr )

	ASSIGN_SETUP( dst, src, zstring )

	if( *dst <> NULL ) then
		**dst = *src
	end if

end sub

'':::::
sub ZstrAssignW ( byval dst as zstring ptr ptr, _
				  byval src as wstring ptr )

	ASSIGN_SETUP( dst, src, zstring )

	if( *dst <> NULL ) then
		**dst = *src
	end if

end sub

'':::::
sub ZstrConcatAssign ( byval dst as zstring ptr ptr, _
					   byval src as zstring ptr )

	CONCATASSIGN_SETUP( dst, src, zstring )

	if( *dst <> NULL ) then
		*(*dst + dst_len) = *src
	end if

end sub

'':::::
sub ZstrConcatAssignW ( byval dst as zstring ptr ptr, _
						byval src as wstring ptr )

	CONCATASSIGN_SETUP( dst, src, zstring )

	if( *dst <> NULL ) then
		*(*dst + dst_len) = *src
	end if

end sub


'':::::
sub WstrAssign ( byval dst as wstring ptr ptr, _
				 byval src as wstring ptr )

	ASSIGN_SETUP( dst, src, wstring )

	if( *dst <> NULL ) then
		**dst = *src
	end if

end sub

'':::::
sub WstrAssignA ( byval dst as wstring ptr ptr, _
				  byval src as zstring ptr )

	ASSIGN_SETUP( dst, src, wstring )

	if( *dst <> NULL ) then
		**dst = *src
	end if

end sub

'':::::
sub WstrConcatAssign ( byval dst as wstring ptr ptr, _
					   byval src as wstring ptr )

	CONCATASSIGN_SETUP( dst, src, wstring )

	if( *dst <> NULL ) then
		*(*dst + dst_len) = *src
	end if

end sub

'':::::
sub WstrConcatAssignW ( byval dst as wstring ptr ptr, _
						byval src as zstring ptr )

	CONCATASSIGN_SETUP( dst, src, wstring )

	if( *dst <> NULL ) then
		*(*dst + dst_len) = *src
	end if

end sub


'':::::
function hReplace( byval orgtext as zstring ptr, _
			 	   byval oldtext as zstring ptr, _
			  	   byval newtext as zstring ptr ) as string static

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
		p += newlen
	loop

	function = text

end function

'':::::
function hReplaceW( byval orgtext as wstring ptr, _
			 	    byval oldtext as wstring ptr, _
			  	    byval newtext as wstring ptr ) as wstring ptr static

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
		p += newlen
	loop

	function = text.data

end function

'':::::
function hEscapeStr( byval text as zstring ptr ) as zstring ptr static
    static as DZSTRING res
    dim as integer c, octlen, lgt
    dim as zstring ptr src, dst, src_end

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
function hEscapeWstr( byval text as wstring ptr ) as zstring ptr static
    static as DZSTRING res
    dim as integer char, c, lgt, i, wstrlen
    dim as wstring ptr src, src_end
    dim as zstring ptr dst

	wstrlen = symbGetDataSize( FB_DATATYPE_WCHAR )

	'' up to 4 ascii chars can be used p/ unicode char (\ooo)
	lgt = len( *text )
	if( lgt = 0 ) then
		return NULL
	end if

	DZstrAllocate( res, lgt * (1+3) * wstrlen )

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

			    '' remap char as they will become a octagonal seq
			    select case as const char
			    case asc( "r" )
			    	char = CHAR_CR

			    case asc( "l" ), asc( "n" )
			    	char = CHAR_LF

			    case asc( "t" )
			    	char = CHAR_TAB

			    case asc( "b" )
			    	char = CHAR_BKSPC

			    case asc( "a" )
			    	char = CHAR_BELL

			    case asc( "f" )
			    	char = CHAR_FORMFEED

			    case asc( "v" )
			    	char = CHAR_VTAB

			    '' unicode 16-bit
			    case asc( "u" )
			    	'' x86 little-endian assumption
			    	char = 0
			    	if( src + 4 > src_end ) then exit do
			    	for i = 1 to 4
			    		c = (*src - CHAR_0)
			    		src +=1

                		if( c > 9 ) then
							c -= (CHAR_AUPP - CHAR_9 - 1)
                		end if
                		if( c > 16 ) then
                  			c -= (CHAR_ALOW - CHAR_AUPP)
                		end if

						char = (char shl 4) or c
                    next

                end select
			end if

		end if

		'' convert every char to octagonal form as GAS can't
		'' handle unicode literal strings
		for i = 1 to wstrlen
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
function hUnescapeStr( byval text as zstring ptr ) as zstring ptr static
    static as DZSTRING res
    dim as integer c, lgt
    dim as zstring ptr src, dst, src_len

	if( env.opt.escapestr = FALSE ) then
    	return text
    end if

	lgt = len( *text )
	if( lgt = 0 ) then
		return text
	end if

	DZstrAllocate( res, lgt )

	*res.data = *text

	src = text
	dst = res.data

	src_len = src + lgt
	do while( src < src_len )

		c = *src
		src += 1

		if( c = FB_INTSCAPECHAR ) then
			*dst = CHAR_RSLASH
		end if

		dst += 1
	loop

	function = res.data

end function

'':::::
function hUnescapeWstr( byval text as wstring ptr ) as wstring ptr static
    static as DWSTRING res
    dim as integer c, lgt
    dim as wstring ptr src, dst, src_len

	if( env.opt.escapestr = FALSE ) then
    	return text
    end if

	lgt = len( *text )
	if( lgt = 0 ) then
		return text
	end if

	DWstrAllocate( res, lgt )

	*res.data = *text

	src = text
	dst = res.data

	src_len = src + lgt
    do while( src < src_len )

		c = *src
		src += 1

		if( c = FB_INTSCAPECHAR ) then
			*dst = CHAR_RSLASH
		end if

		dst += 1
	loop

    '' null-term
    *dst = 0

	function = res.data

end function

'':::::
function hEscapeToChar( byval text as zstring ptr ) as zstring ptr static
    static as DZSTRING res
    dim as integer char, lgt, i
    dim as zstring ptr src, dst, src_len

	if( env.opt.escapestr = FALSE ) then
    	return text
    end if

	lgt = len( *text )
	if( lgt = 0 ) then
		return text
	end if

	DZstrAllocate( res, lgt )

	src = text
	dst = res.data

	src_len = src + lgt
	do while( src < src_len )
		char = *src
		src += 1

		if( char = FB_INTSCAPECHAR ) then

			if( src >= src_len ) then exit do
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
			    select case as const char
			    case asc( "r" )
			    	char = CHAR_CR

			    case asc( "l" ), asc( "n" )
			    	char = CHAR_LF

			    case asc( "t" )
			    	char = CHAR_TAB

			    case asc( "b" )
			    	char = CHAR_BKSPC

			    case asc( "a" )
			    	char = CHAR_BELL

			    case asc( "f" )
			    	char = CHAR_FORMFEED

			    case asc( "v" )
			    	char = CHAR_VTAB

			    end select

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
function hEscapeToCharW( byval text as wstring ptr ) as wstring ptr static
    static as DWSTRING res
    dim as integer char, lgt, i
    dim as wstring ptr src, dst, src_len

	if( env.opt.escapestr = FALSE ) then
    	return text
    end if

	lgt = len( *text )
	if( lgt = 0 ) then
		return text
	end if

	DWstrAllocate( res, lgt )

	*res.data = *text

	src = text
	dst = res.data

	src_len = src + lgt
    do while( src < src_len )
    	char = *src
    	src += 1

    	if( char = FB_INTSCAPECHAR ) then

			if( src >= src_len ) then exit do
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
			    '' remap char
			    select case as const char
			    case asc( "r" )
			    	char = CHAR_CR

			    case asc( "l" ), asc( "n" )
			    	char = CHAR_LF

			    case asc( "t" )
			    	char = CHAR_TAB

			    case asc( "b" )
			    	char = CHAR_BKSPC

			    case asc( "a" )
			    	char = CHAR_BELL

			    case asc( "f" )
			    	char = CHAR_FORMFEED

			    case asc( "v" )
			    	char = CHAR_VTAB

			    end select
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
    	for i = 1 to symbGetDataSize( FB_DATATYPE_WCHAR )
    		nullseq += "\\0"
    	next
	end if

	function = @nullseq

end function


