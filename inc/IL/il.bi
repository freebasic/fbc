'' FreeBASIC binding for DevIL-1.8.0
''
'' based on the C header files:
''    ImageLib Sources
''    Copyright (C) 2000-2017 by Denton Woods
''    Last modified: 03/07/2009
''
''    Filename: IL/il.h
''
''    Description: The main include file for DevIL
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
''   USA
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "IL"
#inclib "jasper"
#inclib "jpeg"
#inclib "tiff"
#inclib "mng"
#inclib "png"
#inclib "lzma"
#inclib "z"
#inclib "stdc++"

#include once "crt/stdio.bi"
#include once "crt/limits.bi"

#ifdef __FB_WIN32__
	extern "Windows"
#else
	extern "C"
#endif

#define __il_h_
#define __IL_H__
const CLAMP_HALF = 1
const CLAMP_FLOATS = 1
const CLAMP_DOUBLES = 1

type ILenum as ulong
type ILboolean as ubyte
type ILbitfield as ulong
type ILbyte as byte
type ILshort as short
type ILint as long
type ILsizei as uinteger
type ILubyte as ubyte
type ILushort as ushort
type ILuint as ulong
type ILfloat as single
type ILclampf as single
type ILdouble as double
type ILclampd as double
type ILint64 as longint
type ILuint64 as ulongint
type ILchar as zstring
type ILstring as zstring ptr
type ILconst_string as const zstring ptr

const IL_FALSE = 0
const IL_TRUE = 1
const IL_COLOUR_INDEX = &h1900
const IL_COLOR_INDEX = &h1900
const IL_ALPHA = &h1906
const IL_RGB = &h1907
const IL_RGBA = &h1908
const IL_BGR = &h80E0
const IL_BGRA = &h80E1
const IL_LUMINANCE = &h1909
const IL_LUMINANCE_ALPHA = &h190A
const IL_BYTE = &h1400
const IL_UNSIGNED_BYTE = &h1401
const IL_SHORT = &h1402
const IL_UNSIGNED_SHORT = &h1403
const IL_INT = &h1404
const IL_UNSIGNED_INT = &h1405
const IL_FLOAT = &h1406
const IL_DOUBLE = &h140A
const IL_HALF = &h140B
#define IL_MAX_BYTE SCHAR_MAX
#define IL_MAX_UNSIGNED_BYTE UCHAR_MAX
#define IL_MAX_SHORT SHRT_MAX
#define IL_MAX_UNSIGNED_SHORT USHRT_MAX
#define IL_MAX_INT INT_MAX
#define IL_MAX_UNSIGNED_INT UINT_MAX
#define IL_LIMIT(x, m, M_) iif(x < m, m, iif(x > M_, M_, x))
#define IL_CLAMP(x) IL_LIMIT(x, 0, 1)
const IL_VENDOR = &h1F00
const IL_LOAD_EXT = &h1F01
const IL_SAVE_EXT = &h1F02
const IL_VERSION_1_8_0 = 1
const IL_VERSION = 180
const IL_ORIGIN_BIT = &h00000001
const IL_FILE_BIT = &h00000002
const IL_PAL_BIT = &h00000004
const IL_FORMAT_BIT = &h00000008
const IL_TYPE_BIT = &h00000010
const IL_COMPRESS_BIT = &h00000020
const IL_LOADFAIL_BIT = &h00000040
const IL_FORMAT_SPECIFIC_BIT = &h00000080
const IL_ALL_ATTRIB_BITS = &h000FFFFF
const IL_PAL_NONE = &h0400
const IL_PAL_RGB24 = &h0401
const IL_PAL_RGB32 = &h0402
const IL_PAL_RGBA32 = &h0403
const IL_PAL_BGR24 = &h0404
const IL_PAL_BGR32 = &h0405
const IL_PAL_BGRA32 = &h0406
const IL_TYPE_UNKNOWN = &h0000
const IL_BMP = &h0420
const IL_CUT = &h0421
const IL_DOOM = &h0422
const IL_DOOM_FLAT = &h0423
const IL_ICO = &h0424
const IL_JPG = &h0425
const IL_JFIF = &h0425
const IL_ILBM = &h0426
const IL_PCD = &h0427
const IL_PCX = &h0428
const IL_PIC = &h0429
const IL_PNG = &h042A
const IL_PNM = &h042B
const IL_SGI = &h042C
const IL_TGA = &h042D
const IL_TIF = &h042E
const IL_CHEAD = &h042F
const IL_RAW = &h0430
const IL_MDL = &h0431
const IL_WAL = &h0432
const IL_LIF = &h0434
const IL_MNG = &h0435
const IL_JNG = &h0435
const IL_GIF = &h0436
const IL_DDS = &h0437
const IL_DCX = &h0438
const IL_PSD = &h0439
const IL_EXIF = &h043A
const IL_PSP = &h043B
const IL_PIX = &h043C
const IL_PXR = &h043D
const IL_XPM = &h043E
const IL_HDR = &h043F
const IL_ICNS = &h0440
const IL_JP2 = &h0441
const IL_EXR = &h0442
const IL_WDP = &h0443
const IL_VTF = &h0444
const IL_WBMP = &h0445
const IL_SUN = &h0446
const IL_IFF = &h0447
const IL_TPL = &h0448
const IL_FITS = &h0449
const IL_DICOM = &h044A
const IL_IWI = &h044B
const IL_BLP = &h044C
const IL_FTX = &h044D
const IL_ROT = &h044E
const IL_TEXTURE = &h044F
const IL_DPX = &h0450
const IL_UTX = &h0451
const IL_MP3 = &h0452
const IL_KTX = &h0453
const IL_JASC_PAL = &h0475
const IL_NO_ERROR = &h0000
const IL_INVALID_ENUM = &h0501
const IL_OUT_OF_MEMORY = &h0502
const IL_FORMAT_NOT_SUPPORTED = &h0503
const IL_INTERNAL_ERROR = &h0504
const IL_INVALID_VALUE = &h0505
const IL_ILLEGAL_OPERATION = &h0506
const IL_ILLEGAL_FILE_VALUE = &h0507
const IL_INVALID_FILE_HEADER = &h0508
const IL_INVALID_PARAM = &h0509
const IL_COULD_NOT_OPEN_FILE = &h050A
const IL_INVALID_EXTENSION = &h050B
const IL_FILE_ALREADY_EXISTS = &h050C
const IL_OUT_FORMAT_SAME = &h050D
const IL_STACK_OVERFLOW = &h050E
const IL_STACK_UNDERFLOW = &h050F
const IL_INVALID_CONVERSION = &h0510
const IL_BAD_DIMENSIONS = &h0511
const IL_FILE_READ_ERROR = &h0512
const IL_FILE_WRITE_ERROR = &h0512
const IL_LIB_GIF_ERROR = &h05E1
const IL_LIB_JPEG_ERROR = &h05E2
const IL_LIB_PNG_ERROR = &h05E3
const IL_LIB_TIFF_ERROR = &h05E4
const IL_LIB_MNG_ERROR = &h05E5
const IL_LIB_JP2_ERROR = &h05E6
const IL_LIB_EXR_ERROR = &h05E7
const IL_UNKNOWN_ERROR = &h05FF
const IL_ORIGIN_SET = &h0600
const IL_ORIGIN_LOWER_LEFT = &h0601
const IL_ORIGIN_UPPER_LEFT = &h0602
const IL_ORIGIN_MODE = &h0603
const IL_FORMAT_SET = &h0610
const IL_FORMAT_MODE = &h0611
const IL_TYPE_SET = &h0612
const IL_TYPE_MODE = &h0613
const IL_FILE_OVERWRITE = &h0620
const IL_FILE_MODE = &h0621
const IL_CONV_PAL = &h0630
const IL_DEFAULT_ON_FAIL = &h0632
const IL_USE_KEY_COLOUR = &h0635
const IL_USE_KEY_COLOR = &h0635
const IL_BLIT_BLEND = &h0636
const IL_SAVE_INTERLACED = &h0639
const IL_INTERLACE_MODE = &h063A
const IL_QUANTIZATION_MODE = &h0640
const IL_WU_QUANT = &h0641
const IL_NEU_QUANT = &h0642
const IL_NEU_QUANT_SAMPLE = &h0643
const IL_MAX_QUANT_INDEXS = &h0644
const IL_MAX_QUANT_INDICES = &h0644
const IL_FASTEST = &h0660
const IL_LESS_MEM = &h0661
const IL_DONT_CARE = &h0662
const IL_MEM_SPEED_HINT = &h0665
const IL_USE_COMPRESSION = &h0666
const IL_NO_COMPRESSION = &h0667
const IL_COMPRESSION_HINT = &h0668
const IL_NVIDIA_COMPRESS = &h0670
const IL_SQUISH_COMPRESS = &h0671
const IL_SUB_NEXT = &h0680
const IL_SUB_MIPMAP = &h0681
const IL_SUB_LAYER = &h0682
const IL_COMPRESS_MODE = &h0700
const IL_COMPRESS_NONE = &h0701
const IL_COMPRESS_RLE = &h0702
const IL_COMPRESS_LZO = &h0703
const IL_COMPRESS_ZLIB = &h0704
const IL_TGA_CREATE_STAMP = &h0710
const IL_JPG_QUALITY = &h0711
const IL_PNG_INTERLACE = &h0712
const IL_TGA_RLE = &h0713
const IL_BMP_RLE = &h0714
const IL_SGI_RLE = &h0715
const IL_TGA_ID_STRING = &h0717
const IL_TGA_AUTHNAME_STRING = &h0718
const IL_TGA_AUTHCOMMENT_STRING = &h0719
const IL_PNG_AUTHNAME_STRING = &h071A
const IL_PNG_TITLE_STRING = &h071B
const IL_PNG_DESCRIPTION_STRING = &h071C
const IL_TIF_DESCRIPTION_STRING = &h071D
const IL_TIF_HOSTCOMPUTER_STRING = &h071E
const IL_TIF_DOCUMENTNAME_STRING = &h071F
const IL_TIF_AUTHNAME_STRING = &h0720
const IL_JPG_SAVE_FORMAT = &h0721
const IL_CHEAD_HEADER_STRING = &h0722
const IL_PCD_PICNUM = &h0723
const IL_PNG_ALPHA_INDEX = &h0724
const IL_JPG_PROGRESSIVE = &h0725
const IL_VTF_COMP = &h0726
const IL_DXTC_FORMAT = &h0705
const IL_DXT1 = &h0706
const IL_DXT2 = &h0707
const IL_DXT3 = &h0708
const IL_DXT4 = &h0709
const IL_DXT5 = &h070A
const IL_DXT_NO_COMP = &h070B
const IL_KEEP_DXTC_DATA = &h070C
const IL_DXTC_DATA_FORMAT = &h070D
const IL_3DC = &h070E
const IL_RXGB = &h070F
const IL_ATI1N = &h0710
const IL_DXT1A = &h0711
const IL_CUBEMAP_POSITIVEX = &h00000400
const IL_CUBEMAP_NEGATIVEX = &h00000800
const IL_CUBEMAP_POSITIVEY = &h00001000
const IL_CUBEMAP_NEGATIVEY = &h00002000
const IL_CUBEMAP_POSITIVEZ = &h00004000
const IL_CUBEMAP_NEGATIVEZ = &h00008000
const IL_SPHEREMAP = &h00010000
const IL_VERSION_NUM = &h0DE2
const IL_IMAGE_WIDTH = &h0DE4
const IL_IMAGE_HEIGHT = &h0DE5
const IL_IMAGE_DEPTH = &h0DE6
const IL_IMAGE_SIZE_OF_DATA = &h0DE7
const IL_IMAGE_BPP = &h0DE8
const IL_IMAGE_BYTES_PER_PIXEL = &h0DE8
const IL_IMAGE_BPP = &h0DE8
const IL_IMAGE_BITS_PER_PIXEL = &h0DE9
const IL_IMAGE_FORMAT = &h0DEA
const IL_IMAGE_TYPE = &h0DEB
const IL_PALETTE_TYPE = &h0DEC
const IL_PALETTE_SIZE = &h0DED
const IL_PALETTE_BPP = &h0DEE
const IL_PALETTE_NUM_COLS = &h0DEF
const IL_PALETTE_BASE_TYPE = &h0DF0
const IL_NUM_FACES = &h0DE1
const IL_NUM_IMAGES = &h0DF1
const IL_NUM_MIPMAPS = &h0DF2
const IL_NUM_LAYERS = &h0DF3
const IL_ACTIVE_IMAGE = &h0DF4
const IL_ACTIVE_MIPMAP = &h0DF5
const IL_ACTIVE_LAYER = &h0DF6
const IL_ACTIVE_FACE = &h0E00
const IL_CUR_IMAGE = &h0DF7
const IL_IMAGE_DURATION = &h0DF8
const IL_IMAGE_PLANESIZE = &h0DF9
const IL_IMAGE_BPC = &h0DFA
const IL_IMAGE_OFFX = &h0DFB
const IL_IMAGE_OFFY = &h0DFC
const IL_IMAGE_CUBEFLAGS = &h0DFD
const IL_IMAGE_ORIGIN = &h0DFE
const IL_IMAGE_CHANNELS = &h0DFF
const IL_SEEK_SET = 0
const IL_SEEK_CUR = 1
const IL_SEEK_END = 2
const IL_EOF = -1

type ILHANDLE as any ptr
type fCloseRProc as sub(byval as ILHANDLE)
type fEofProc as function(byval as ILHANDLE) as ILboolean
type fGetcProc as function(byval as ILHANDLE) as ILint
type fOpenRProc as function(byval as const zstring ptr) as ILHANDLE
type fReadProc as function(byval as any ptr, byval as ILuint, byval as ILuint, byval as ILHANDLE) as ILint
type fSeekRProc as function(byval as ILHANDLE, byval as ILint, byval as ILint) as ILint
type fTellRProc as function(byval as ILHANDLE) as ILint
type fCloseWProc as sub(byval as ILHANDLE)
type fOpenWProc as function(byval as const zstring ptr) as ILHANDLE
type fPutcProc as function(byval as ILubyte, byval as ILHANDLE) as ILint
type fSeekWProc as function(byval as ILHANDLE, byval as ILint, byval as ILint) as ILint
type fTellWProc as function(byval as ILHANDLE) as ILint
type fWriteProc as function(byval as const any ptr, byval as ILuint, byval as ILuint, byval as ILHANDLE) as ILint
type mAlloc as function(byval as const ILsizei) as any ptr
type mFree as sub(byval as const any const ptr)
type IL_LOADPROC as function(byval as const zstring ptr) as ILenum
type IL_SAVEPROC as function(byval as const zstring ptr) as ILenum

declare function ilActiveFace(byval Number as ILuint) as ILboolean
declare function ilActiveImage(byval Number as ILuint) as ILboolean
declare function ilActiveLayer(byval Number as ILuint) as ILboolean
declare function ilActiveMipmap(byval Number as ILuint) as ILboolean
declare function ilApplyPal(byval FileName as const zstring ptr) as ILboolean
declare function ilApplyProfile(byval InProfile as zstring ptr, byval OutProfile as zstring ptr) as ILboolean
declare sub ilBindImage(byval Image as ILuint)
declare function ilBlit(byval Source as ILuint, byval DestX as ILint, byval DestY as ILint, byval DestZ as ILint, byval SrcX as ILuint, byval SrcY as ILuint, byval SrcZ as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint) as ILboolean
declare function ilClampNTSC() as ILboolean
declare sub ilClearColour(byval Red as ILclampf, byval Green as ILclampf, byval Blue as ILclampf, byval Alpha as ILclampf)
declare function ilClearImage() as ILboolean
declare function ilCloneCurImage() as ILuint
declare function ilCompressDXT(byval Data as ILubyte ptr, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval DXTCFormat as ILenum, byval DXTCSize as ILuint ptr) as ILubyte ptr
declare function ilCompressFunc(byval Mode as ILenum) as ILboolean
declare function ilConvertImage(byval DestFormat as ILenum, byval DestType as ILenum) as ILboolean
declare function ilConvertPal(byval DestFormat as ILenum) as ILboolean
declare function ilCopyImage(byval Src as ILuint) as ILboolean
declare function ilCopyPixels(byval XOff as ILuint, byval YOff as ILuint, byval ZOff as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Format as ILenum, byval Type as ILenum, byval Data as any ptr) as ILuint
declare function ilCreateSubImage(byval Type as ILenum, byval Num as ILuint) as ILuint
declare function ilDefaultImage() as ILboolean
declare sub ilDeleteImage(byval Num as const ILuint)
declare sub ilDeleteImages(byval Num as ILsizei, byval Images as const ILuint ptr)
declare function ilDetermineType(byval FileName as const zstring ptr) as ILenum
declare function ilDetermineTypeF(byval File as ILHANDLE) as ILenum
declare function ilDetermineTypeL(byval Lump as const any ptr, byval Size as ILuint) as ILenum
declare function ilDisable(byval Mode as ILenum) as ILboolean
declare function ilDxtcDataToImage() as ILboolean
declare function ilDxtcDataToSurface() as ILboolean
declare function ilEnable(byval Mode as ILenum) as ILboolean
declare sub ilFlipSurfaceDxtcData()
declare function ilFormatFunc(byval Mode as ILenum) as ILboolean
declare sub ilGenImages(byval Num as ILsizei, byval Images as ILuint ptr)
declare function ilGenImage() as ILuint
declare function ilGetAlpha(byval Type as ILenum) as ILubyte ptr
declare function ilGetBoolean(byval Mode as ILenum) as ILboolean
declare sub ilGetBooleanv(byval Mode as ILenum, byval Param as ILboolean ptr)
declare function ilGetData() as ILubyte ptr
declare function ilGetDXTCData(byval Buffer as any ptr, byval BufferSize as ILuint, byval DXTCFormat as ILenum) as ILuint
declare function ilGetError() as ILenum
declare function ilGetInteger(byval Mode as ILenum) as ILint
declare sub ilGetIntegerv(byval Mode as ILenum, byval Param as ILint ptr)
declare function ilGetLumpPos() as ILuint
declare function ilGetPalette() as ILubyte ptr
declare function ilGetString(byval StringName as ILenum) as const zstring ptr
declare sub ilHint(byval Target as ILenum, byval Mode as ILenum)
declare function ilInvertSurfaceDxtcDataAlpha() as ILboolean
declare sub ilInit()
declare function ilImageToDxtcData(byval Format as ILenum) as ILboolean
declare function ilIsDisabled(byval Mode as ILenum) as ILboolean
declare function ilIsEnabled(byval Mode as ILenum) as ILboolean
declare function ilIsImage(byval Image as ILuint) as ILboolean
declare function ilIsValid(byval Type as ILenum, byval FileName as const zstring ptr) as ILboolean
declare function ilIsValidF(byval Type as ILenum, byval File as ILHANDLE) as ILboolean
declare function ilIsValidL(byval Type as ILenum, byval Lump as any ptr, byval Size as ILuint) as ILboolean
declare sub ilKeyColour(byval Red as ILclampf, byval Green as ILclampf, byval Blue as ILclampf, byval Alpha as ILclampf)
declare function ilLoad(byval Type as ILenum, byval FileName as const zstring ptr) as ILboolean
declare function ilLoadF(byval Type as ILenum, byval File as ILHANDLE) as ILboolean
declare function ilLoadImage(byval FileName as const zstring ptr) as ILboolean
declare function ilLoadL(byval Type as ILenum, byval Lump as const any ptr, byval Size as ILuint) as ILboolean
declare function ilLoadPal(byval FileName as const zstring ptr) as ILboolean
declare sub ilModAlpha(byval AlphaValue as ILdouble)
declare function ilOriginFunc(byval Mode as ILenum) as ILboolean
declare function ilOverlayImage(byval Source as ILuint, byval XCoord as ILint, byval YCoord as ILint, byval ZCoord as ILint) as ILboolean
declare sub ilPopAttrib()
declare sub ilPushAttrib(byval Bits as ILuint)
declare sub ilRegisterFormat(byval Format as ILenum)
declare function ilRegisterLoad(byval Ext as const zstring ptr, byval Load as IL_LOADPROC) as ILboolean
declare function ilRegisterMipNum(byval Num as ILuint) as ILboolean
declare function ilRegisterNumFaces(byval Num as ILuint) as ILboolean
declare function ilRegisterNumImages(byval Num as ILuint) as ILboolean
declare sub ilRegisterOrigin(byval Origin as ILenum)
declare sub ilRegisterPal(byval Pal as any ptr, byval Size as ILuint, byval Type as ILenum)
declare function ilRegisterSave(byval Ext as const zstring ptr, byval Save as IL_SAVEPROC) as ILboolean
declare sub ilRegisterType(byval Type as ILenum)
declare function ilRemoveLoad(byval Ext as const zstring ptr) as ILboolean
declare function ilRemoveSave(byval Ext as const zstring ptr) as ILboolean
declare sub ilResetMemory()
declare sub ilResetRead()
declare sub ilResetWrite()
declare function ilSave(byval Type as ILenum, byval FileName as const zstring ptr) as ILboolean
declare function ilSaveF(byval Type as ILenum, byval File as ILHANDLE) as ILuint
declare function ilSaveImage(byval FileName as const zstring ptr) as ILboolean
declare function ilSaveL(byval Type as ILenum, byval Lump as any ptr, byval Size as ILuint) as ILuint
declare function ilSavePal(byval FileName as const zstring ptr) as ILboolean
declare function ilSetAlpha(byval AlphaValue as ILdouble) as ILboolean
declare function ilSetData(byval Data as any ptr) as ILboolean
declare function ilSetDuration(byval Duration as ILuint) as ILboolean
declare sub ilSetInteger(byval Mode as ILenum, byval Param as ILint)
declare sub ilSetMemory(byval as mAlloc, byval as mFree)
declare sub ilSetPixels(byval XOff as ILint, byval YOff as ILint, byval ZOff as ILint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Format as ILenum, byval Type as ILenum, byval Data as any ptr)
declare sub ilSetRead(byval as fOpenRProc, byval as fCloseRProc, byval as fEofProc, byval as fGetcProc, byval as fReadProc, byval as fSeekRProc, byval as fTellRProc)
declare sub ilSetString(byval Mode as ILenum, byval String as const zstring ptr)
declare sub ilSetWrite(byval as fOpenWProc, byval as fCloseWProc, byval as fPutcProc, byval as fSeekWProc, byval as fTellWProc, byval as fWriteProc)
declare sub ilShutDown()
declare function ilSurfaceToDxtcData(byval Format as ILenum) as ILboolean
declare function ilTexImage(byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval NumChannels as ILubyte, byval Format as ILenum, byval Type as ILenum, byval Data as any ptr) as ILboolean
declare function ilTexImageDxtc(byval w as ILint, byval h as ILint, byval d as ILint, byval DxtFormat as ILenum, byval data as const ILubyte ptr) as ILboolean
declare function ilTypeFromExt(byval FileName as const zstring ptr) as ILenum
declare function ilTypeFunc(byval Mode as ILenum) as ILboolean
declare function ilLoadData(byval FileName as const zstring ptr, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte) as ILboolean
declare function ilLoadDataF(byval File as ILHANDLE, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte) as ILboolean
declare function ilLoadDataL(byval Lump as any ptr, byval Size as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte) as ILboolean
declare function ilSaveData(byval FileName as const zstring ptr) as ILboolean
declare sub ilClearColor alias "ilClearColour"(byval Red as ILclampf, byval Green as ILclampf, byval Blue as ILclampf, byval Alpha as ILclampf)
declare sub ilKeyColor alias "ilKeyColour"(byval Red as ILclampf, byval Green as ILclampf, byval Blue as ILclampf, byval Alpha as ILclampf)
#define imemclear(x, y) memset(x, 0, y)

end extern
