''
''
'' allegro\text -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_text_bi__
#define __allegro_text_bi__

#include once "allegro/base.bi"

type FONT_GLYPH
	w as short
	h as short
	dat(0 to 0) as ubyte
end type

type FONT_VTABLE_ as FONT_VTABLE

type FONT
	data as any ptr
	height as integer
	vtable as FONT_VTABLE_ ptr
end type

extern _AL_DLL font alias "font" as FONT ptr
extern _AL_DLL allegro_404_char alias "allegro_404_char" as integer

declare function text_mode cdecl alias "text_mode" (byval mode as integer) as integer
declare sub textout cdecl alias "textout" (byval bmp as BITMAP ptr, byval f as FONT ptr, byval str as zstring ptr, byval x as integer, byval y as integer, byval color as integer)
declare sub textout_centre cdecl alias "textout_centre" (byval bmp as BITMAP ptr, byval f as FONT ptr, byval str as zstring ptr, byval x as integer, byval y as integer, byval color as integer)
declare sub textout_right cdecl alias "textout_right" (byval bmp as BITMAP ptr, byval f as FONT ptr, byval str as zstring ptr, byval x as integer, byval y as integer, byval color as integer)
declare sub textout_justify cdecl alias "textout_justify" (byval bmp as BITMAP ptr, byval f as FONT ptr, byval str as zstring ptr, byval x1 as integer, byval x2 as integer, byval y as integer, byval diff as integer, byval color as integer)
declare sub textprintf cdecl alias "textprintf" (byval bmp as BITMAP ptr, byval f as FONT ptr, byval x as integer, byval y as integer, byval color as integer, byval format as zstring ptr, ...)
declare sub textprintf_centre cdecl alias "textprintf_centre" (byval bmp as BITMAP ptr, byval f as FONT ptr, byval x as integer, byval y as integer, byval color as integer, byval format as zstring ptr, ...)
declare sub textprintf_right cdecl alias "textprintf_right" (byval bmp as BITMAP ptr, byval f as FONT ptr, byval x as integer, byval y as integer, byval color as integer, byval format as zstring ptr, ...)
declare sub textprintf_justify cdecl alias "textprintf_justify" (byval bmp as BITMAP ptr, byval f as FONT ptr, byval x1 as integer, byval x2 as integer, byval y as integer, byval diff as integer, byval color as integer, byval format as zstring ptr, ...)
declare function text_length cdecl alias "text_length" (byval f as FONT ptr, byval str as zstring ptr) as integer
declare function text_height cdecl alias "text_height" (byval f as FONT ptr) as integer
declare sub destroy_font cdecl alias "destroy_font" (byval f as FONT ptr)

#endif
