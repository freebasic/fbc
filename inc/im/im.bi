''
''
'' im -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_bi__
#define __im_bi__

#inclib "im"

enum imDataType
	IM_BYTE
	IM_SHORT
	IM_USHORT
	IM_INT
	IM_FLOAT
	IM_CFLOAT
end enum

enum imColorSpace
	IM_RGB
	IM_MAP
	IM_GRAY
	IM_BINARY
	IM_CMYK
	IM_YCBCR
	IM_LAB
	IM_LUV
	IM_XYZ
end enum

enum imColorModeConfig
	IM_ALPHA = &h100
	IM_PACKED = &h200
	IM_TOPDOWN = &h400
end enum

enum imErrorCodes
	IM_ERR_NONE
	IM_ERR_OPEN
	IM_ERR_ACCESS
	IM_ERR_FORMAT
	IM_ERR_DATA
	IM_ERR_COMPRESS
	IM_ERR_MEM
	IM_ERR_COUNTER
end enum

type imFile as _imFile

declare function imFileOpen cdecl alias "imFileOpen" (byval file_name as zstring ptr, byval error as integer ptr) as imFile ptr
declare function imFileOpenAs cdecl alias "imFileOpenAs" (byval file_name as zstring ptr, byval format as zstring ptr, byval error as integer ptr) as imFile ptr
declare function imFileNew cdecl alias "imFileNew" (byval file_name as zstring ptr, byval format as zstring ptr, byval error as integer ptr) as imFile ptr
declare sub imFileClose cdecl alias "imFileClose" (byval ifile as imFile ptr)
declare function imFileHandle cdecl alias "imFileHandle" (byval ifile as imFile ptr, byval index as integer) as any ptr
declare sub imFileGetInfo cdecl alias "imFileGetInfo" (byval ifile as imFile ptr, byval format as zstring ptr, byval compression as zstring ptr, byval image_count as integer ptr)
declare sub imFileSetInfo cdecl alias "imFileSetInfo" (byval ifile as imFile ptr, byval compression as zstring ptr)
declare sub imFileSetAttribute cdecl alias "imFileSetAttribute" (byval ifile as imFile ptr, byval attrib as zstring ptr, byval data_type as integer, byval count as integer, byval data as any ptr)
declare function imFileGetAttribute cdecl alias "imFileGetAttribute" (byval ifile as imFile ptr, byval attrib as zstring ptr, byval data_type as integer ptr, byval count as integer ptr) as any ptr
declare sub imFileGetAttributeList cdecl alias "imFileGetAttributeList" (byval ifile as imFile ptr, byval attrib as byte ptr ptr, byval attrib_count as integer ptr)
declare sub imFileGetPalette cdecl alias "imFileGetPalette" (byval ifile as imFile ptr, byval palette as integer ptr, byval palette_count as integer ptr)
declare sub imFileSetPalette cdecl alias "imFileSetPalette" (byval ifile as imFile ptr, byval palette as integer ptr, byval palette_count as integer)
declare function imFileReadImageInfo cdecl alias "imFileReadImageInfo" (byval ifile as imFile ptr, byval index as integer, byval width as integer ptr, byval height as integer ptr, byval file_color_mode as integer ptr, byval file_data_type as integer ptr) as integer
declare function imFileWriteImageInfo cdecl alias "imFileWriteImageInfo" (byval ifile as imFile ptr, byval width as integer, byval height as integer, byval user_color_mode as integer, byval user_data_type as integer) as integer
declare function imFileReadImageData cdecl alias "imFileReadImageData" (byval ifile as imFile ptr, byval data as any ptr, byval convert2bitmap as integer, byval color_mode_flags as integer) as integer
declare function imFileWriteImageData cdecl alias "imFileWriteImageData" (byval ifile as imFile ptr, byval data as any ptr) as integer
declare sub imFormatRegisterInternal cdecl alias "imFormatRegisterInternal" ()
declare sub imFormatRemoveAll cdecl alias "imFormatRemoveAll" ()
declare sub imFormatList cdecl alias "imFormatList" (byval format_list as byte ptr ptr, byval format_count as integer ptr)
declare function imFormatInfo cdecl alias "imFormatInfo" (byval format as zstring ptr, byval desc as zstring ptr, byval ext as zstring ptr, byval can_sequence as integer ptr) as integer
declare function imFormatInfoExtra cdecl alias "imFormatInfoExtra" (byval format as zstring ptr, byval extra as zstring ptr) as integer
declare function imFormatCompressions cdecl alias "imFormatCompressions" (byval format as zstring ptr, byval comp as byte ptr ptr, byval comp_count as integer ptr, byval color_mode as integer, byval data_type as integer) as integer
declare function imFormatCanWriteImage cdecl alias "imFormatCanWriteImage" (byval format as zstring ptr, byval compression as zstring ptr, byval color_mode as integer, byval data_type as integer) as integer

#endif
