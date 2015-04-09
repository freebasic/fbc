'' FreeBASIC binding for liblbxutil-1.1.0

#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _LBX_IMAGE_H_

type _LbxBitmapCompMethod
	methodName as zstring ptr
	inited as long
	methodOpCode as long
	compInit as function() as long
	compFunc as function(byval as ubyte ptr, byval as ubyte ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long ptr) as long
	decompFunc as function(byval as ubyte ptr, byval as ubyte ptr, byval as long, byval as long, byval as long, byval as long) as long
end type

type LbxBitmapCompMethod as _LbxBitmapCompMethod
const LBX_MAX_DEPTHS = 5

type _LbxPixmapCompMethod
	methodName as zstring ptr
	formatMask as ulong
	depthCount as long
	depths(0 to 4) as long
	inited as long
	methodOpCode as long
	compInit as function() as long
	compFunc as function(byval as zstring ptr, byval as zstring ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long ptr) as long
	decompFunc as function(byval as zstring ptr, byval as zstring ptr, byval as long, byval as long) as long
end type

type LbxPixmapCompMethod as _LbxPixmapCompMethod
declare function LbxImageEncodePackBits(byval as zstring ptr, byval as zstring ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long ptr) as long
declare function LbxImageEncodeFaxG42D(byval as ubyte ptr, byval as ubyte ptr, byval as long, byval as long, byval as long, byval as long, byval as long, byval as long ptr) as long
declare function LbxImageDecodePackBits(byval as zstring ptr, byval as zstring ptr, byval as long, byval as long) as long
declare function LbxImageDecodeFaxG42D(byval as ubyte ptr, byval as ubyte ptr, byval as long, byval as long, byval as long, byval as long) as long

const LBX_IMAGE_COMPRESS_SUCCESS = 0
const LBX_IMAGE_COMPRESS_NO_SUPPORT = 1
const LBX_IMAGE_COMPRESS_BAD_MALLOC = 2
const LBX_IMAGE_COMPRESS_NOT_WORTH_IT = 3

end extern
