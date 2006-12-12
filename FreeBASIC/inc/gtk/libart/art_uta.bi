''
''
'' art_uta -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_uta_bi__
#define __art_uta_bi__

#include once "art_misc.bi"

type ArtUtaBbox as art_u32
type ArtUta as _ArtUta

#define ART_UTILE_SHIFT 5
#define ART_UTILE_SIZE (1 shl 5)

type _ArtUta
	x0 as integer
	y0 as integer
	width as integer
	height as integer
	utiles as ArtUtaBbox ptr
end type

declare function art_uta_new (byval x0 as integer, byval y0 as integer, byval x1 as integer, byval y1 as integer) as ArtUta ptr
declare function art_uta_new_coords (byval x0 as integer, byval y0 as integer, byval x1 as integer, byval y1 as integer) as ArtUta ptr
declare sub art_uta_free (byval uta as ArtUta ptr)

#endif
