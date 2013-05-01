''
''
'' im_util -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_util_bi__
#define __im_util_bi__

declare function imStrEqual cdecl alias "imStrEqual" (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function imStrNLen cdecl alias "imStrNLen" (byval str as zstring ptr, byval max_len as integer) as integer
declare function imStrCheck cdecl alias "imStrCheck" (byval data as any ptr, byval count as integer) as integer
declare function imImageDataSize cdecl alias "imImageDataSize" (byval width as integer, byval height as integer, byval color_mode as integer, byval data_type as integer) as integer
declare function imImageLineSize cdecl alias "imImageLineSize" (byval width as integer, byval color_mode as integer, byval data_type as integer) as integer
declare function imImageLineCount cdecl alias "imImageLineCount" (byval width as integer, byval color_mode as integer) as integer
declare function imImageCheckFormat cdecl alias "imImageCheckFormat" (byval color_mode as integer, byval data_type as integer) as integer
declare function imColorEncode cdecl alias "imColorEncode" (byval red as ubyte, byval green as ubyte, byval blue as ubyte) as integer
declare sub imColorDecode cdecl alias "imColorDecode" (byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval color as integer)
declare function imColorModeSpaceName cdecl alias "imColorModeSpaceName" (byval color_mode as integer) as zstring ptr
declare function imColorModeDepth cdecl alias "imColorModeDepth" (byval color_mode as integer) as integer
declare function imColorModeToBitmap cdecl alias "imColorModeToBitmap" (byval color_mode as integer) as integer
declare function imColorModeIsBitmap cdecl alias "imColorModeIsBitmap" (byval color_mode as integer, byval data_type as integer) as integer

#define IM_MAXDEPTH 5

type imbyte as ubyte
type imushort as ushort

declare function imDataTypeSize cdecl alias "imDataTypeSize" (byval data_type as integer) as integer
declare function imDataTypeName cdecl alias "imDataTypeName" (byval data_type as integer) as zstring ptr
declare function imDataTypeIntMax cdecl alias "imDataTypeIntMax" (byval data_type as integer) as uinteger
declare function imDataTypeIntMin cdecl alias "imDataTypeIntMin" (byval data_type as integer) as integer

enum imByteOrder
	IM_LITTLEENDIAN
	IM_BIGENDIAN
end enum

declare function imBinCPUByteOrder cdecl alias "imBinCPUByteOrder" () as integer
declare sub imBinSwapBytes cdecl alias "imBinSwapBytes" (byval data as any ptr, byval count as integer, byval size as integer)
declare sub imBinSwapBytes2 cdecl alias "imBinSwapBytes2" (byval data as any ptr, byval count as integer)
declare sub imBinSwapBytes4 cdecl alias "imBinSwapBytes4" (byval data as any ptr, byval count as integer)
declare sub imBinSwapBytes8 cdecl alias "imBinSwapBytes8" (byval data as any ptr, byval count as integer)
declare function imCompressDataZ cdecl alias "imCompressDataZ" (byval src_data as any ptr, byval src_size as integer, byval dst_data as any ptr, byval dst_size as integer, byval zip_quality as integer) as integer
declare function imCompressDataUnZ cdecl alias "imCompressDataUnZ" (byval src_data as any ptr, byval src_size as integer, byval dst_data as any ptr, byval dst_size as integer) as integer
declare function imCompressDataLZF cdecl alias "imCompressDataLZF" (byval src_data as any ptr, byval src_size as integer, byval dst_data as any ptr, byval dst_size as integer, byval zip_quality as integer) as integer
declare function imCompressDataUnLZF cdecl alias "imCompressDataUnLZF" (byval src_data as any ptr, byval src_size as integer, byval dst_data as any ptr, byval dst_size as integer) as integer

#endif
