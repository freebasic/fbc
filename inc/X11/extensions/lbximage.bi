''
''
'' lbximage -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lbximage_bi__
#define __lbximage_bi__

#define LBX_MAX_DEPTHS 5

type _LbxPixmapCompMethod
	methodName as zstring ptr
	formatMask as uinteger
	depthCount as integer
	depths(0 to 5-1) as integer
	inited as integer
	methodOpCode as integer
	compInit as function cdecl() as integer
	compFunc as function cdecl(byval as zstring ptr, byval as zstring ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer ptr) as integer
	decompFunc as function cdecl(byval as zstring ptr, byval as zstring ptr, byval as integer, byval as integer) as integer
end type

type LbxPixmapCompMethod as _LbxPixmapCompMethod

declare function LbxImageEncodePackBits cdecl alias "LbxImageEncodePackBits" (byval as zstring ptr, byval as zstring ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer ptr) as integer
declare function LbxImageEncodeFaxG42D cdecl alias "LbxImageEncodeFaxG42D" (byval as ubyte ptr, byval as ubyte ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer ptr) as integer
declare function LbxImageDecodePackBits cdecl alias "LbxImageDecodePackBits" (byval as zstring ptr, byval as zstring ptr, byval as integer, byval as integer) as integer
declare function LbxImageDecodeFaxG42D cdecl alias "LbxImageDecodeFaxG42D" (byval as ubyte ptr, byval as ubyte ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer

#define LBX_IMAGE_COMPRESS_SUCCESS 0
#define LBX_IMAGE_COMPRESS_NO_SUPPORT 1
#define LBX_IMAGE_COMPRESS_BAD_MALLOC 2
#define LBX_IMAGE_COMPRESS_NOT_WORTH_IT 3

#endif
