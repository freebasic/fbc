''
''
'' im_file -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_file_bi__
#define __im_file_bi__

type _imFile
	is_new as integer
	attrib_table as any ptr
	line_buffer as any ptr
	line_buffer_size as integer
	line_buffer_extra as integer
	line_buffer_alloc as integer
	counter as integer
	convert_bpp as integer
	switch_type as integer
	palette(0 to 256-1) as integer
	palette_count as integer
	user_color_mode as integer
	user_data_type as integer
	file_color_mode as integer
	file_data_type as integer
	compression as zstring * 10
	image_count as integer
	image_index as integer
	width as integer
	height as integer
end type

declare sub imFileClear cdecl alias "imFileClear" (byval ifile as imFile ptr)
declare sub imFileLineBufferInit cdecl alias "imFileLineBufferInit" (byval ifile as imFile ptr)
declare function imFileCheckConversion cdecl alias "imFileCheckConversion" (byval ifile as imFile ptr) as integer
declare function imFileLineBufferCount cdecl alias "imFileLineBufferCount" (byval ifile as imFile ptr) as integer
declare sub imFileLineBufferInc cdecl alias "imFileLineBufferInc" (byval ifile as imFile ptr, byval row as integer ptr, byval plane as integer ptr)
declare sub imFileLineBufferRead cdecl alias "imFileLineBufferRead" (byval ifile as imFile ptr, byval data as any ptr, byval line as integer, byval plane as integer)
declare sub imFileLineBufferWrite cdecl alias "imFileLineBufferWrite" (byval ifile as imFile ptr, byval data as any ptr, byval line as integer, byval plane as integer)
declare function imFileLineSizeAligned cdecl alias "imFileLineSizeAligned" (byval width as integer, byval bpp as integer, byval align as integer) as integer
declare sub imFileSetBaseAttributes cdecl alias "imFileSetBaseAttributes" (byval ifile as imFile ptr)

#endif
