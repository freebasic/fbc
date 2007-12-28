''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2007 The FreeBASIC development team.
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


'' lex's UTF readers
''
''
'' chng: nov/2005 written [v1ctor]
''


#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\lex.bi"

#define UTF16_MAX_BMP 		 &h0000FFFF
#define	UTF16_SUR_HIGH_START &hD800
#define	UTF16_SUR_HIGH_END	 &hDBFF
#define	UTF16_SUR_LOW_START	 &hDC00
#define	UTF16_SUR_LOW_END	 &hDFFF
#define	UTF16_HALFSHIFT		 10
#define	UTF16_HALFBASE 		 &h0010000UL
#define	UTF16_HALFMASK 		 &h3FFUL

#define U16_SWAP(c) (((c) shr 8) or ((c) shl 8) and &hFF00)

#define U32_SWAP(c) (((c) shr 24) or (((c) shl 8) and &h00FF0000) or _
			 		(((c) shr 8) and &h0000FF00) or ((c) shl 24))

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' UTF-8
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

	dim shared as ubyte utf8_trailingTb(0 to 255) => _
	{ _
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,_
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,_
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,_
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,_
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,_
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,_
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,_
		2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5 _
	}

	dim shared as uinteger utf8_offsetsTb(0 to 5) => _
	{ _
		&h00000000UL, &h00003080UL, &h000E2080UL, &h03C82080UL, &hFA082080UL, &h82082080UL _
	}

'':::::
private function hUTF8ToChar( ) as integer static
    dim as ubyte src(0 to 6)
    dim as ubyte ptr p
    dim as uinteger c
    dim as ubyte ptr dst
    dim as integer chars, extbytes, i

	dst = cast( ubyte ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , src(0) ) <> 0 ) then
			exit do
		end if

		extbytes = utf8_trailingTb(src(0))

		c = 0
		p = @src(0)
		if( extbytes > 0 ) then
			if( get( #env.inf.num, , src(1), extbytes ) <> 0 ) then
				exit do
			end if

			i = extbytes
			do
				c += *p
				p += 1
				c shl= 6
        		i -= 1
        	loop while( i > 0 )
		end if

		c += *p

		c -= utf8_offsetsTb(extbytes)

		if( c > 255 ) then
			c = asc( "?" )
		end if

		*dst = c
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF8ToUTF16LE( ) as integer static
    dim as ubyte src(0 to 6)
    dim as ubyte ptr p
    dim as uinteger c
    dim as ushort ptr dst
    dim as integer chars, extbytes, i

	dst = cast( ushort ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , src(0) ) <> 0 ) then
			exit do
		end if

		extbytes = utf8_trailingTb(src(0))

		c = 0
		p = @src(0)
		if( extbytes > 0 ) then
			if( get( #env.inf.num, , src(1), extbytes ) <> 0 ) then
				exit do
			end if

			i = extbytes
			do
				c += *p
				p += 1
				c shl= 6
        		i -= 1
        	loop while( i > 0 )
		end if

		c += *p

		c -= utf8_offsetsTb(extbytes)

		'' create surrogate?
		if( c > UTF16_MAX_BMP ) then
			if( chars < LEX_MAXBUFFCHARS-1 ) then
				*dst = (c shr UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START
				dst += 1
				chars += 1
			end if

			c = (c and UTF16_HALFMASK) + UTF16_SUR_LOW_START
		end if

		*dst = c
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF8ToUTF32LE( ) as integer static
    dim as ubyte src(0 to 6)
    dim as ubyte ptr p
    dim as uinteger c
    dim as uinteger ptr dst
    dim as integer chars, extbytes, i

	dst = cast( uinteger ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , src(0) ) <> 0 ) then
			exit do
		end if

		extbytes = utf8_trailingTb(src(0))

		c = 0
		p = @src(0)
		if( extbytes > 0 ) then
			if( get( #env.inf.num, , src(1), extbytes ) <> 0 ) then
				exit do
			end if

			i = extbytes
			do
				c += *p
				p += 1
				c shl= 6
        		i -= 1
        	loop while( i > 0 )
		end if

		c += *p

		c -= utf8_offsetsTb(extbytes)

		*dst = c
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF8ToUTF32BE( ) as integer static
    dim as uinteger ptr dst
    dim as uinteger c
    dim as integer i, chars

	chars = hUTF8ToUTF32LE( )

	dst = cast( uinteger ptr, @lex->buffw )
	for i = 1 to chars
		c = *dst
		*dst = U32_SWAP( c )
		dst += 1
	next

	function = chars

end function

'':::::
sub lexReadUTF8( )
	dim as integer chars

#if defined(TARGET_DOS)
	chars = hUTF8ToChar( )

#elseif defined(TARGET_WIN32) or defined(TARGET_CYGWIN)
	chars = hUTF8ToUTF16LE( )

#else
# ifdef TARGET_X86
	chars = hUTF8ToUTF32LE( )
# else
	chars = hUTF8ToUTF32BE( )
# endif
#endif

	lex->bufflen = chars
	lex->buffptrw = @lex->buffw

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' UTF-16LE
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hUTF16LEToChar( ) as integer static
    dim as ushort c
    dim as ubyte ptr dst
    dim as integer chars

	dst = cast( ubyte ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , c ) <> 0 ) then
			exit do
		end if

		if( c > 255 ) then
			'' surrogate?
			if( c >= UTF16_SUR_HIGH_START ) then
				if( c <= UTF16_SUR_HIGH_END ) then
					if( get( #env.inf.num, , c ) <> 0 ) then
						exit do
					end if
				end if
			end if

			c = asc( "?" )
		end if

		*dst = c
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF16LEToUTF16LE( ) as integer static

	if( get( #env.inf.num, , lex->buffw ) = 0 ) then
		function = cunsg(seek( env.inf.num ) - lex->filepos) \ len( ushort )
	else
		function = 0
	end if

end function

'':::::
private function hUTF16LEToUTF32LE( ) as integer static
    dim as ushort c
    dim as uinteger wc
    dim as uinteger ptr dst
    dim as integer chars

	dst = cast( uinteger ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , c ) <> 0 ) then
			exit do
		end if

		wc = c
		'' surrogate?
		if( wc >= UTF16_SUR_HIGH_START ) then
			if( wc <= UTF16_SUR_HIGH_END ) then
				if( get( #env.inf.num, , c ) <> 0 ) then
					exit do
				end if

				wc = ((wc - UTF16_SUR_HIGH_START) shl UTF16_HALFSHIFT) + _
			     	  (cuint( c ) - UTF16_SUR_LOW_START) + UTF16_HALFBASE
			end if
		end if

		*dst = wc
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF16LEToUTF32BE( ) as integer static
    dim as uinteger ptr dst
    dim as uinteger c
    dim as integer i, chars

	chars = hUTF16LEToUTF32LE( )

	dst = cast( uinteger ptr, @lex->buffw )
	for i = 1 to chars
		c = *dst
		*dst = U32_SWAP( c )
		dst += 1
	next

	function = chars

end function

'':::::
sub lexReadUTF16LE( ) static
	dim as integer chars

#if defined(TARGET_DOS)
	chars = hUTF16LEToChar( )

#elseif defined(TARGET_WIN32) or defined(TARGET_CYGWIN)
	chars = hUTF16LEToUTF16LE( )

#else
# ifdef TARGET_X86
	chars = hUTF16LEToUTF32LE( )
# else
	chars = hUTF16LEToUTF32BE( )
# endif
#endif

	lex->bufflen = chars
	lex->buffptrw = @lex->buffw

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' UTF-16BE
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hUTF16BEToChar( ) as integer static
    dim as ushort c
    dim as ubyte ptr dst
    dim as integer chars

	dst = cast( ubyte ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , c ) <> 0 ) then
			exit do
		end if

		c = U16_SWAP( c )

		if( c > 255 ) then
			'' surrogate?
			if( c >= UTF16_SUR_HIGH_START ) then
				if( c <= UTF16_SUR_HIGH_END ) then
					if( get( #env.inf.num, , c ) <> 0 ) then
						exit do
					end if
				end if
			end if

			c = asc( "?" )
		end if

		*dst = c
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF16BEToUTF16LE( ) as integer static
    dim as ushort ptr dst
    dim as ushort c
    dim as integer i, chars

	chars = hUTF16LEToUTF16LE( )

	dst = cast( ushort ptr, @lex->buffw )
	for i = 1 to chars
		c = *dst
		*dst = U16_SWAP( c )
		dst += 1
	next

	function = chars

end function

'':::::
private function hUTF16BEToUTF32LE( ) as integer static
    dim as ushort c
    dim as uinteger wc
    dim as uinteger ptr dst
    dim as integer chars

	dst = cast( uinteger ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , c ) <> 0 ) then
			exit do
		end if

		wc = U16_SWAP( c )

		'' surrogate?
		if( wc >= UTF16_SUR_HIGH_START ) then
			if( wc <= UTF16_SUR_HIGH_END ) then
				if( get( #env.inf.num, , c ) <> 0 ) then
					exit do
				end if

				wc = ((wc - UTF16_SUR_HIGH_START) shl UTF16_HALFSHIFT) + _
			     	  (cuint( U16_SWAP( c ) ) - UTF16_SUR_LOW_START) + UTF16_HALFBASE
			end if
		end if

		*dst = wc
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF16BEToUTF32BE( ) as integer static

	function = hUTF16LEToUTF32LE( )

end function

'':::::
sub lexReadUTF16BE( ) static
	dim as integer chars

#if defined(TARGET_DOS)
	chars = hUTF16BEToChar( )

#elseif defined(TARGET_WIN32) or defined(TARGET_CYGWIN)
	chars = hUTF16BEToUTF16LE( )

#else
# ifdef TARGET_X86
	chars = hUTF16BEToUTF32LE( )
# else
	chars = hUTF16BEToUTF32BE( )
# endif
#endif

	lex->bufflen = chars
	lex->buffptrw = @lex->buffw

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' UTF-32LE
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hUTF32LEToChar( ) as integer static
    dim as uinteger c
    dim as ubyte ptr dst
    dim as integer chars

	dst = cast( ubyte ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , c ) <> 0 ) then
			exit do
		end if

		if( c > 255 ) then
			c = asc( "?" )
		end if

		*dst = c
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF32LEToUTF16LE( ) as integer static
    dim as uinteger c
    dim as ushort ptr dst
    dim as integer chars

	dst = cast( ushort ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , c ) <> 0 ) then
			exit do
		end if

		'' create surrogate?
		if( c > UTF16_MAX_BMP ) then
			if( chars < LEX_MAXBUFFCHARS-1 ) then
				*dst = (c shr UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START
				dst += 1
				chars += 1
			end if

			c = (c and UTF16_HALFMASK) + UTF16_SUR_LOW_START
		end if

		*dst = c
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF32LEToUTF32LE( ) as integer static

	if( get( #env.inf.num, , lex->buffw ) = 0 ) then
		function = cunsg(seek( env.inf.num ) - lex->filepos) \ len( uinteger )
	else
		function = 0
	end if

end function

'':::::
private function hUTF32LEToUTF32BE( ) as integer static
    dim as uinteger ptr dst
    dim as uinteger c
    dim as integer i, chars

	chars = hUTF32LEToUTF32LE( )

	dst = cast( uinteger ptr, @lex->buffw )
	for i = 1 to chars
		c = *dst
		*dst = U32_SWAP( c )
		dst += 1
	next

	function = chars

end function

'':::::
sub lexReadUTF32LE( )
	dim as integer chars

#if defined(TARGET_DOS)
	chars = hUTF32LEToChar( )

#elseif defined(TARGET_WIN32) or defined(TARGET_CYGWIN)
	chars = hUTF32LEToUTF16LE( )

#else
# ifdef TARGET_X86
	chars = hUTF32LEToUTF32LE( )
# else
	chars = hUTF32LEToUTF32BE( )
# endif
#endif

	lex->bufflen = chars
	lex->buffptrw = @lex->buffw

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' UTF-32BE
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
private function hUTF32BEToChar( ) as integer static
    dim as uinteger c
    dim as ubyte ptr dst
    dim as integer chars

	dst = cast( ubyte ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , c ) <> 0 ) then
			exit do
		end if

		c = U32_SWAP( c )

		if( c > 255 ) then
			c = asc( "?" )
		end if

		*dst = c
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF32BEToUTF16LE( ) as integer static
    dim as uinteger c
    dim as ushort ptr dst
    dim as integer chars

	dst = cast( ushort ptr, @lex->buffw )
	chars = 0

	do while( chars < LEX_MAXBUFFCHARS )
		if( eof( env.inf.num ) ) then
			exit do
		end if

		if( get( #env.inf.num, , c ) <> 0 ) then
			exit do
		end if

		c = U32_SWAP( c )

		'' create surrogate?
		if( c > UTF16_MAX_BMP ) then
			if( chars < LEX_MAXBUFFCHARS-1 ) then
				*dst = (c shr UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START
				dst += 1
				chars += 1
			end if

			c = (c and UTF16_HALFMASK) + UTF16_SUR_LOW_START
		end if

		*dst = c
		dst += 1
		chars += 1
	loop

	function = chars

end function

'':::::
private function hUTF32BEToUTF32LE( ) as integer static
    dim as uinteger ptr dst
    dim as uinteger c
    dim as integer i, chars

	chars = hUTF32LEToUTF32LE( )

	dst = cast( uinteger ptr, @lex->buffw )
	for i = 1 to chars
		c = *dst
		*dst = U32_SWAP( c )
		dst += 1
	next

	function = chars

end function

'':::::
private function hUTF32BEToUTF32BE( ) as integer static

	function = hUTF32LEToUTF32LE( )

end function

'':::::
sub lexReadUTF32BE( )
	dim as integer chars

#if defined(TARGET_DOS)
	chars = hUTF32BEToChar( )

#elseif defined(TARGET_WIN32) or defined(TARGET_CYGWIN)
	chars = hUTF32BEToUTF16LE( )

#else
# ifdef TARGET_X86
	chars = hUTF32BEToUTF32LE( )
# else
	chars = hUTF32BEToUTF32BE( )
# endif
#endif

	lex->bufflen = chars
	lex->buffptrw = @lex->buffw

end sub

