''
''
'' allegro\datafile -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_datafile_bi__
#define __allegro_datafile_bi__

#include once "allegro/base.bi"

#define DAT_ID(a,b,c,d) AL_ID(a,b,c,d)
#define DAT_MAGIC DAT_ID(asc("A"),asc("L"),asc("L"),asc("."))
#define DAT_FILE DAT_ID(asc("F"),asc("I"),asc("L"),asc("E"))
#define DAT_DATA DAT_ID(asc("D"),asc("A"),asc("T"),asc("A"))
#define DAT_FONT DAT_ID(asc("F"),asc("O"),asc("N"),asc("T"))
#define DAT_SAMPLE DAT_ID(asc("S"),asc("A"),asc("M"),asc("P"))
#define DAT_MIDI DAT_ID(asc("M"),asc("I"),asc("D"),asc("I"))
#define DAT_PATCH DAT_ID(asc("P"),asc("A"),asc("T"),asc(" "))
#define DAT_FLI DAT_ID(asc("F"),asc("L"),asc("I"),asc("C"))
#define DAT_BITMAP DAT_ID(asc("B"),asc("M"),asc("P"),asc(" "))
#define DAT_RLE_SPRITE DAT_ID(asc("R"),asc("L"),asc("E"),asc(" "))
#define DAT_C_SPRITE DAT_ID(asc("C"),asc("M"),asc("P"),asc(" "))
#define DAT_XC_SPRITE DAT_ID(asc("X"),asc("C"),asc("M"),asc("P"))
#define DAT_PALETTE DAT_ID(asc("P"),asc("A"),asc("L"),asc(" "))
#define DAT_PROPERTY DAT_ID(asc("p"),asc("r"),asc("o"),asc("p"))
#define DAT_NAME DAT_ID(asc("N"),asc("A"),asc("M"),asc("E"))
#define DAT_END -1

type DATAFILE_PROPERTY
	dat as zstring ptr
	type as integer
end type

type DATAFILE
	dat as any ptr
	type as integer
	size as integer
	prop as DATAFILE_PROPERTY ptr
end type

declare function load_datafile cdecl alias "load_datafile" (byval filename as zstring ptr) as DATAFILE ptr
declare function load_datafile_callback cdecl alias "load_datafile_callback" (byval filename as zstring ptr, byval callback as sub cdecl(byval as DATAFILE ptr)) as DATAFILE ptr
declare sub unload_datafile cdecl alias "unload_datafile" (byval dat as DATAFILE ptr)
declare function load_datafile_object cdecl alias "load_datafile_object" (byval filename as zstring ptr, byval objectname as zstring ptr) as DATAFILE ptr
declare sub unload_datafile_object cdecl alias "unload_datafile_object" (byval dat as DATAFILE ptr)
declare function find_datafile_object cdecl alias "find_datafile_object" (byval dat as DATAFILE ptr, byval objectname as zstring ptr) as DATAFILE ptr
declare function get_datafile_property cdecl alias "get_datafile_property" (byval dat as DATAFILE ptr, byval type as integer) as zstring ptr
declare sub register_datafile_object cdecl alias "register_datafile_object" (byval id_ as integer, byval load as sub cdecl(byval as PACKFILE ptr, byval as integer), byval destroy as sub cdecl(byval as any ptr))
declare sub fixup_datafile cdecl alias "fixup_datafile" (byval data as DATAFILE ptr)
declare function load_bitmap cdecl alias "load_bitmap" (byval filename as zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_bmp cdecl alias "load_bmp" (byval filename as zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_lbm cdecl alias "load_lbm" (byval filename as zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_pcx cdecl alias "load_pcx" (byval filename as zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function load_tga cdecl alias "load_tga" (byval filename as zstring ptr, byval pal as RGB ptr) as BITMAP ptr
declare function save_bitmap cdecl alias "save_bitmap" (byval filename as zstring ptr, byval bmp as BITMAP ptr, byval pal as RGB ptr) as integer
declare function save_bmp cdecl alias "save_bmp" (byval filename as zstring ptr, byval bmp as BITMAP ptr, byval pal as RGB ptr) as integer
declare function save_pcx cdecl alias "save_pcx" (byval filename as zstring ptr, byval bmp as BITMAP ptr, byval pal as RGB ptr) as integer
declare function save_tga cdecl alias "save_tga" (byval filename as zstring ptr, byval bmp as BITMAP ptr, byval pal as RGB ptr) as integer
declare sub register_bitmap_file_type cdecl alias "register_bitmap_file_type" (byval ext as zstring ptr, byval load as function cdecl(byval as zstring ptr, byval as RGB ptr) as BITMAP ptr, byval save as function cdecl(byval as zstring ptr, byval as BITMAP ptr, byval as RGB ptr) as integer)

#endif
