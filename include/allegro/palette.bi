''
''
'' allegro\palette -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_palette_bi__
#define __allegro_palette_bi__

type RGB
	r as ubyte
	g as ubyte
	b as ubyte
	filler as ubyte
end type

#define PAL_SIZE 256

type PALETTE as RGB

#endif
