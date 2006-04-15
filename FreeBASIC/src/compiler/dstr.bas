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


'' dynamic zstring helpers
''
''

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\dstr.bi"

declare sub 	hRealloc			( byval s as DSTRING ptr, _
					  			  	  byval chars as integer, _
					  				  byval charsize as integer, _
					  				  byval dopreserve as integer )


'':::::
#define ALLOC_SETUP(dst, chars, _type)							_
	if( chars = 0 ) then                                      	:_
		if( dst.data <> NULL ) then                             :_
			deallocate( dst.data )                              :_
			dst.data = NULL                                     :_
			dst.len  = 0										:_
			dst.size = 0										:_
			exit sub                                            :_
		end if                                                  :_
	end if                                                      :_
                                                                :_
	if( dst.len <> chars ) then                               	:_
		hRealloc( cast( DSTRING ptr, @dst ), 					_
				  chars, 										_
				  len( _type ), 								_
				  FALSE )    									:_
	end if

'':::::
#define REALLOC_SETUP(dst, chars, _type)						_
	if( chars = 0 ) then                                      	:_
		exit sub                                                :_
	end if                                                      :_
                                                                :_
	hRealloc( cast( DSTRING ptr, @dst ), 						_
			  dst.len + chars, 									_
			  len( _type ), 									_
			  TRUE )


'':::::
#define CALC_LEN( p ) iif( p <> NULL, len( *src ), 0 )

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' dynamic zstrings
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub DZstrZero ( byref dst as DZSTRING )

    dst.data = NULL
    dst.len = 0
    dst.size = 0

end sub

'':::::
sub DZstrAllocate ( byref dst as DZSTRING, _
				    byval chars as integer )

	ALLOC_SETUP( dst, chars, zstring )

end sub

'':::::
sub DZstrAssign ( byref dst as DZSTRING, _
				  byval src as zstring ptr )

	dim as integer src_len = CALC_LEN( src )

	ALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		*dst.data = *src
	end if

end sub

'':::::
sub DZstrAssignW ( byref dst as DZSTRING, _
				   byval src as wstring ptr )

	dim as integer src_len = CALC_LEN( src )

	ALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		*dst.data = *src
	end if

end sub

'':::::
sub DZstrConcatAssign ( byref dst as DZSTRING, _
						byval src as zstring ptr )

	dim as integer src_len = CALC_LEN( src )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len) = *src
	end if

end sub

'':::::
sub DZstrConcatAssignW ( byref dst as DZSTRING, _
						 byval src as wstring ptr )

	dim as integer src_len = CALC_LEN( src )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len) = *src
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' dynamic wstrings
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub DWstrZero ( byref dst as DWSTRING )

    dst.data = NULL
    dst.len = 0
    dst.size = 0

end sub

'':::::
sub DWstrAllocate ( byref dst as DWSTRING, _
				 	byval chars as integer )

	ALLOC_SETUP( dst, chars, wstring )

end sub

'':::::
sub DWstrAssign ( byref dst as DWSTRING, _
				  byval src as wstring ptr )

	dim as integer src_len = CALC_LEN( src )

	ALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		*dst.data = *src
	end if

end sub

'':::::
sub DWstrAssignA ( byref dst as DWSTRING, _
				   byval src as zstring ptr )

	dim as integer src_len = CALC_LEN( src )

	ALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		*dst.data = *src
	end if

end sub

'':::::
sub DWstrConcatAssign ( byref dst as DWSTRING, _
						byval src as wstring ptr )

	dim as integer src_len = CALC_LEN( src )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len) = *src
	end if

end sub

'':::::
sub DWstrConcatAssignA ( byref dst as DWSTRING, _
						 byval src as zstring ptr )

	dim as integer src_len = CALC_LEN( src )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len) = *src
	end if

end sub

'':::::
private sub hRealloc( byval s as DSTRING ptr, _
					  byval chars as integer, _
					  byval charsize as integer, _
					  byval dopreserve as integer ) static

	dim as integer newsize
	dim as any ptr p

	'' alloc every 16-chars
	newsize = (chars + 15) and not 15

	if( (s->data = NULL) or _
	    (chars > s->size) or _
	    (newsize < (s->size - (s->size shr 3))) ) then

		if( dopreserve = FALSE ) then
			if( s->data <> NULL ) then
				deallocate( s->data )
			end if

			s->data = allocate( (newsize + 1) * charsize )
			'' failed? try the original request
			if( s->data = NULL ) then
				s->data = allocate( (chars + 1) * charsize )
				newsize = chars
			end if

		'' preserve..
		else
            p = s->data
			s->data = reallocate( p, (newsize + 1) * charsize )
			'' failed? try the original request
			if( s->data = NULL ) then
				s->data = reallocate( p, (chars + 1) * charsize )
                if( s->data = NULL ) then
                    '' restore the old memory block
                    s->data = p
                    exit sub
                end if
				newsize = chars
            end if
		end if

		'' failed?
		if( s->data = NULL ) then
            s->len = 0
            s->size = 0
			exit sub
		end if

		s->size = newsize
	end if

	s->len = chars

end sub

