''
''
'' Xinerama -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xinerama_bi__
#define __Xinerama_bi__

type XineramaScreenInfo
	screen_number as integer
	x_org as short
	y_org as short
	width as short
	height as short
end type

declare function XineramaIsActive cdecl alias "XineramaIsActive" (byval dpy as Display ptr) as Bool
declare function XineramaQueryScreens cdecl alias "XineramaQueryScreens" (byval dpy as Display ptr, byval number as integer ptr) as XineramaScreenInfo ptr

#endif
