'' dynamic zstring helpers
''
''


#include once "fb.bi"
#include once "fbint.bi"
#include once "dstr.bi"

declare sub hRealloc _
	( _
		byval s as DSTRING ptr, _
		byval chars as integer, _
		byval charsize as integer, _
		byval dopreserve as integer _
	)


'':::::
#macro ALLOC_SETUP(dst, chars, _type)
	if( chars = 0 ) then
		if( dst.data <> NULL ) then
			deallocate( dst.data )
			dst.data = NULL
			dst.len  = 0
			dst.size = 0
		end if
		exit sub
	end if

	if( dst.len <> chars ) then
		hRealloc( cast( DSTRING ptr, @dst ), _
				  chars, _
				  len( _type ), _
				  FALSE )
	end if
#endmacro

'':::::
#macro REALLOC_SETUP(dst, chars, _type)
	if( chars = 0 ) then
		exit sub
	end if

	hRealloc( cast( DSTRING ptr, @dst ),  _
			  dst.len + chars, _
			  len( _type ), _
			  TRUE )
#endmacro

'':::::
#define CALC_LEN( p ) iif( p <> NULL, len( *p ), 0 )

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' dynamic zstrings
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub DZstrZero _
	( _
		byref dst as DZSTRING _
	)

	dst.data = NULL
	dst.len = 0
	dst.size = 0

end sub

'':::::
sub DZstrAllocate _
	( _
		byref dst as DZSTRING, _
		byval chars as integer _
	)

	ALLOC_SETUP( dst, chars, zstring )

end sub

'':::::
sub DZstrReset _
	( _
		byref dst as DZSTRING _
	)

	if( dst.data <> NULL ) then
		*dst.data = 0
	end if

	dst.len = 0

end sub

'':::::
sub DZstrAssign _
	( _
		byref dst as DZSTRING, _
		byval src as const zstring ptr _
	)

	dim as integer src_len = CALC_LEN( src )

	ALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		*dst.data = *src
	end if

end sub

'':::::
sub DZstrAssignW _
	( _
		byref dst as DZSTRING, _
		byval src as const wstring ptr _
	)

	dim as integer src_len = CALC_LEN( src )

	ALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		*dst.data = *src
	end if

end sub

'':::::
sub DZstrAssignC _
	( _
		byref dst as DZSTRING, _
		byval src as uinteger _
	)

	dim as integer src_len = len( zstring )

	ALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		dst.data[0] = src
		dst.data[1] = 0
	end if

end sub

'':::::
sub DZstrConcatAssign _
	( _
		byref dst as DZSTRING, _
		byval src as const zstring ptr _
	)

	dim as integer src_len = CALC_LEN( src )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len) = *src
	end if

end sub

'':::::
sub DZstrConcatAssignW _
	( _
		byref dst as DZSTRING, _
		byval src as const wstring ptr _
	)

	dim as integer src_len = CALC_LEN( src )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len) = *src
	end if

end sub

'':::::
sub DZstrConcatAssignC _
	( _
		byref dst as DZSTRING, _
		byval src as uinteger _
	)

	dim as integer src_len = len( zstring )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, zstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len+0) = src
		*(dst.data + dst_len+1) = 0
	end if

end sub

''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
'' dynamic wstrings
''::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

'':::::
sub DWstrZero _
	( _
		byref dst as DWSTRING _
	)

	dst.data = NULL
	dst.len = 0
	dst.size = 0

end sub

'':::::
sub DWstrAllocate _
	( _
		byref dst as DWSTRING, _
		byval chars as integer _
	)

	ALLOC_SETUP( dst, chars, wstring )

end sub

'':::::
sub DWstrReset _
	( _
		byref dst as DWSTRING _
	)

	if( dst.data <> NULL ) then
		*dst.data = 0
	end if

	dst.len = 0

end sub

'':::::
sub DWstrAssign _
	( _
		byref dst as DWSTRING, _
		byval src as const wstring ptr _
	)

	dim as integer src_len = CALC_LEN( src )

	ALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		*dst.data = *src
	end if

end sub

'':::::
sub DWstrAssignA _
	( _
		byref dst as DWSTRING, _
		byval src as const zstring ptr _
	)

	dim as integer src_len = CALC_LEN( src )

	ALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		*dst.data = *src
	end if

end sub

'':::::
sub DWstrAssignC _
	( _
		byref dst as DWSTRING, _
		byval src as uinteger _
	)

	dim as integer src_len = len( wstring )

	ALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		dst.data[0] = src
		dst.data[1] = 0
	end if

end sub

'':::::
sub DWstrConcatAssign _
	( _
		byref dst as DWSTRING, _
		byval src as const wstring ptr _
	)

	dim as integer src_len = CALC_LEN( src )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len) = *src
	end if

end sub

'':::::
sub DWstrConcatAssignA _
	( _
		byref dst as DWSTRING, _
		byval src as const zstring ptr _
	)

	dim as integer src_len = CALC_LEN( src )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len) = *src
	end if

end sub

'':::::
sub DWstrConcatAssignC _
	( _
		byref dst as DWSTRING, _
		byval src as uinteger _
	)

	dim as integer src_len = len( wstring )
	dim as integer dst_len = dst.len

	REALLOC_SETUP( dst, src_len, wstring )

	if( dst.data <> NULL ) then
		*(dst.data + dst_len+0) = src
		*(dst.data + dst_len+1) = 0
	end if

end sub

'':::::
private sub hRealloc _
	( _
		byval s as DSTRING ptr, _
		byval chars as integer, _
		byval charsize as integer, _
		byval dopreserve as integer _
	) static

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
				s->data = xallocate( (chars + 1) * charsize )
				newsize = chars
			end if

		'' preserve..
		else
			p = s->data
			s->data = reallocate( p, (newsize + 1) * charsize )
			'' failed? try the original request
			if( s->data = NULL ) then
				s->data = xreallocate( p, (chars + 1) * charsize )
				newsize = chars
			end if
		end if

		s->size = newsize
	end if

	s->len = chars

end sub

