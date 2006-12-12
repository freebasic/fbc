''
''
'' il -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __il_bi__
#define __il_bi__

#inclib "DevIL"

type ILenum as uinteger
type ILboolean as ubyte
type ILbitfield as uinteger
type ILbyte as byte
type ILshort as short
type ILint as integer
type ILsizei as integer
type ILubyte as ubyte
type ILushort as ushort
type ILuint as uinteger
type ILfloat as single
type ILclampf as single
type ILdouble as double
type ILclampd as double
type ILvoid as any
type ILstring as string

#define IL_FALSE 0
#define IL_TRUE 1
#define IL_COLOUR_INDEX &h1900
#define IL_COLOR_INDEX &h1900
#define IL_RGB &h1907
#define IL_RGBA &h1908
#define IL_BGR &h80E0
#define IL_BGRA &h80E1
#define IL_LUMINANCE &h1909
#define IL_LUMINANCE_ALPHA &h190A
#define IL_BYTE &h1400
#define IL_UNSIGNED_BYTE &h1401
#define IL_SHORT &h1402
#define IL_UNSIGNED_SHORT &h1403
#define IL_INT &h1404
#define IL_UNSIGNED_INT &h1405
#define IL_FLOAT &h1406
#define IL_DOUBLE &h140A
#define IL_VENDOR &h1F00
#define IL_LOAD_EXT &h1F01
#define IL_SAVE_EXT &h1F02
#define IL_VERSION_1_6_7 1
#define IL_VERSION 167
#define IL_ORIGIN_BIT &h00000001
#define IL_FILE_BIT &h00000002
#define IL_PAL_BIT &h00000004
#define IL_FORMAT_BIT &h00000008
#define IL_TYPE_BIT &h00000010
#define IL_COMPRESS_BIT &h00000020
#define IL_LOADFAIL_BIT &h00000040
#define IL_FORMAT_SPECIFIC_BIT &h00000080
#define IL_ALL_ATTRIB_BITS &h000FFFFF
#define IL_PAL_NONE &h0400
#define IL_PAL_RGB24 &h0401
#define IL_PAL_RGB32 &h0402
#define IL_PAL_RGBA32 &h0403
#define IL_PAL_BGR24 &h0404
#define IL_PAL_BGR32 &h0405
#define IL_PAL_BGRA32 &h0406
#define IL_TYPE_UNKNOWN &h0000
#define IL_BMP &h0420
#define IL_CUT &h0421
#define IL_DOOM &h0422
#define IL_DOOM_FLAT &h0423
#define IL_ICO &h0424
#define IL_JPG &h0425
#define IL_JFIF &h0425
#define IL_LBM &h0426
#define IL_PCD &h0427
#define IL_PCX &h0428
#define IL_PIC &h0429
#define IL_PNG &h042A
#define IL_PNM &h042B
#define IL_SGI &h042C
#define IL_TGA &h042D
#define IL_TIF &h042E
#define IL_CHEAD &h042F
#define IL_RAW &h0430
#define IL_MDL &h0431
#define IL_WAL &h0432
#define IL_LIF &h0434
#define IL_MNG &h0435
#define IL_JNG &h0435
#define IL_GIF &h0436
#define IL_DDS &h0437
#define IL_DCX &h0438
#define IL_PSD &h0439
#define IL_EXIF &h043A
#define IL_PSP &h043B
#define IL_PIX &h043C
#define IL_PXR &h043D
#define IL_XPM &h043E
#define IL_JASC_PAL &h0475
#define IL_NO_ERROR &h0000
#define IL_INVALID_ENUM &h0501
#define IL_OUT_OF_MEMORY &h0502
#define IL_FORMAT_NOT_SUPPORTED &h0503
#define IL_INTERNAL_ERROR &h0504
#define IL_INVALID_VALUE &h0505
#define IL_ILLEGAL_OPERATION &h0506
#define IL_ILLEGAL_FILE_VALUE &h0507
#define IL_INVALID_FILE_HEADER &h0508
#define IL_INVALID_PARAM &h0509
#define IL_COULD_NOT_OPEN_FILE &h050A
#define IL_INVALID_EXTENSION &h050B
#define IL_FILE_ALREADY_EXISTS &h050C
#define IL_OUT_FORMAT_SAME &h050D
#define IL_STACK_OVERFLOW &h050E
#define IL_STACK_UNDERFLOW &h050F
#define IL_INVALID_CONVERSION &h0510
#define IL_BAD_DIMENSIONS &h0511
#define IL_FILE_READ_ERROR &h0512
#define IL_FILE_WRITE_ERROR &h0512
#define IL_LIB_GIF_ERROR &h05E1
#define IL_LIB_JPEG_ERROR &h05E2
#define IL_LIB_PNG_ERROR &h05E3
#define IL_LIB_TIFF_ERROR &h05E4
#define IL_LIB_MNG_ERROR &h05E5
#define IL_UNKNOWN_ERROR &h05FF
#define IL_ORIGIN_SET &h0600
#define IL_ORIGIN_LOWER_LEFT &h0601
#define IL_ORIGIN_UPPER_LEFT &h0602
#define IL_ORIGIN_MODE &h0603
#define IL_FORMAT_SET &h0610
#define IL_FORMAT_MODE &h0611
#define IL_TYPE_SET &h0612
#define IL_TYPE_MODE &h0613
#define IL_FILE_OVERWRITE &h0620
#define IL_FILE_MODE &h0621
#define IL_CONV_PAL &h0630
#define IL_DEFAULT_ON_FAIL &h0632
#define IL_USE_KEY_COLOUR &h0635
#define IL_USE_KEY_COLOR &h0635
#define IL_SAVE_INTERLACED &h0639
#define IL_INTERLACE_MODE &h063A
#define IL_QUANTIZATION_MODE &h0640
#define IL_WU_QUANT &h0641
#define IL_NEU_QUANT &h0642
#define IL_NEU_QUANT_SAMPLE &h0643
#define IL_MAX_QUANT_INDEXS &h0644
#define IL_FASTEST &h0660
#define IL_LESS_MEM &h0661
#define IL_DONT_CARE &h0662
#define IL_MEM_SPEED_HINT &h0665
#define IL_USE_COMPRESSION &h0666
#define IL_NO_COMPRESSION &h0667
#define IL_COMPRESSION_HINT &h0668
#define IL_SUB_NEXT &h0680
#define IL_SUB_MIPMAP &h0681
#define IL_SUB_LAYER &h0682
#define IL_COMPRESS_MODE &h0700
#define IL_COMPRESS_NONE &h0701
#define IL_COMPRESS_RLE &h0702
#define IL_COMPRESS_LZO &h0703
#define IL_COMPRESS_ZLIB &h0704
#define IL_TGA_CREATE_STAMP &h0710
#define IL_JPG_QUALITY &h0711
#define IL_PNG_INTERLACE &h0712
#define IL_TGA_RLE &h0713
#define IL_BMP_RLE &h0714
#define IL_SGI_RLE &h0715
#define IL_TGA_ID_STRING &h0717
#define IL_TGA_AUTHNAME_STRING &h0718
#define IL_TGA_AUTHCOMMENT_STRING &h0719
#define IL_PNG_AUTHNAME_STRING &h071A
#define IL_PNG_TITLE_STRING &h071B
#define IL_PNG_DESCRIPTION_STRING &h071C
#define IL_TIF_DESCRIPTION_STRING &h071D
#define IL_TIF_HOSTCOMPUTER_STRING &h071E
#define IL_TIF_DOCUMENTNAME_STRING &h071F
#define IL_TIF_AUTHNAME_STRING &h0720
#define IL_JPG_SAVE_FORMAT &h0721
#define IL_CHEAD_HEADER_STRING &h0722
#define IL_PCD_PICNUM &h0723
#define IL_PNG_ALPHA_INDEX &h0724
#define IL_DXTC_FORMAT &h0705
#define IL_DXT1 &h0706
#define IL_DXT2 &h0707
#define IL_DXT3 &h0708
#define IL_DXT4 &h0709
#define IL_DXT5 &h070A
#define IL_DXT_NO_COMP &h070B
#define IL_KEEP_DXTC_DATA &h070C
#define IL_DXTC_DATA_FORMAT &h070D
#define IL_CUBEMAP_POSITIVEX &h00000400
#define IL_CUBEMAP_NEGATIVEX &h00000800
#define IL_CUBEMAP_POSITIVEY &h00001000
#define IL_CUBEMAP_NEGATIVEY &h00002000
#define IL_CUBEMAP_POSITIVEZ &h00004000
#define IL_CUBEMAP_NEGATIVEZ &h00008000
#define IL_VERSION_NUM &h0DE2
#define IL_IMAGE_WIDTH &h0DE4
#define IL_IMAGE_HEIGHT &h0DE5
#define IL_IMAGE_DEPTH &h0DE6
#define IL_IMAGE_SIZE_OF_DATA &h0DE7
#define IL_IMAGE_BPP &h0DE8
#define IL_IMAGE_BYTES_PER_PIXEL &h0DE8
#define IL_IMAGE_BITS_PER_PIXEL &h0DE9
#define IL_IMAGE_FORMAT &h0DEA
#define IL_IMAGE_TYPE &h0DEB
#define IL_PALETTE_TYPE &h0DEC
#define IL_PALETTE_SIZE &h0DED
#define IL_PALETTE_BPP &h0DEE
#define IL_PALETTE_NUM_COLS &h0DEF
#define IL_PALETTE_BASE_TYPE &h0DF0
#define IL_NUM_IMAGES &h0DF1
#define IL_NUM_MIPMAPS &h0DF2
#define IL_NUM_LAYERS &h0DF3
#define IL_ACTIVE_IMAGE &h0DF4
#define IL_ACTIVE_MIPMAP &h0DF5
#define IL_ACTIVE_LAYER &h0DF6
#define IL_CUR_IMAGE &h0DF7
#define IL_IMAGE_DURATION &h0DF8
#define IL_IMAGE_PLANESIZE &h0DF9
#define IL_IMAGE_BPC &h0DFA
#define IL_IMAGE_OFFX &h0DFB
#define IL_IMAGE_OFFY &h0DFC
#define IL_IMAGE_CUBEFLAGS &h0DFD
#define IL_IMAGE_ORIGIN &h0DFE
#define IL_SEEK_SET 0
#define IL_SEEK_CUR 1
#define IL_SEEK_END 2
#define IL_EOF -1

type ILHANDLE as any ptr
type fCloseRProc as ILvoid ptr
type fEofProc as ILboolean ptr
type fGetcProc as ILint ptr
type fOpenRProc as ILHANDLE ptr
type fReadProc as ILint ptr
type fSeekRProc as ILint ptr
type fTellRProc as ILint ptr
type fCloseWProc as ILvoid ptr
type fOpenWProc as ILHANDLE ptr
type fPutcProc as ILint ptr
type fSeekWProc as ILint ptr
type fTellWProc as ILint ptr
type fWriteProc as ILint ptr
type mAlloc as ILvoid ptr
type mFree as ILvoid ptr
type IL_LOADPROC as ILenum ptr
type IL_SAVEPROC as ILenum ptr

extern "c"
declare function ilActiveImage (byval Number as ILuint) as ILboolean
declare function ilActiveLayer (byval Number as ILuint) as ILboolean
declare function ilActiveMipmap (byval Number as ILuint) as ILboolean
declare function ilApplyPal (byval FileName as ILstring) as ILboolean
declare function ilApplyProfile (byval InProfile as ILstring, byval OutProfile as ILstring) as ILboolean
declare sub ilBindImage (byval Image as ILuint)
declare function ilBlit (byval Source as ILuint, byval DestX as ILint, byval DestY as ILint, byval DestZ as ILint, byval SrcX as ILuint, byval SrcY as ILuint, byval SrcZ as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint) as ILboolean
declare sub ilClearColour (byval Red as ILclampf, byval Green as ILclampf, byval Blue as ILclampf, byval Alpha as ILclampf)
declare function ilClearImage () as ILboolean
declare function ilCloneCurImage () as ILuint
declare function ilCompressFunc (byval Mode as ILenum) as ILboolean
declare function ilConvertImage (byval DestFormat as ILenum, byval DestType as ILenum) as ILboolean
declare function ilConvertPal (byval DestFormat as ILenum) as ILboolean
declare function ilCopyImage (byval Src as ILuint) as ILboolean
declare function ilCopyPixels (byval XOff as ILuint, byval YOff as ILuint, byval ZOff as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Format as ILenum, byval Type as ILenum, byval Data as ILvoid ptr) as ILuint
declare function ilCreateSubImage (byval Type as ILenum, byval Num as ILuint) as ILuint
declare function ilDefaultImage () as ILboolean
declare sub ilDeleteImages (byval Num as ILsizei, byval Images as ILuint ptr)
declare function ilDisable (byval Mode as ILenum) as ILboolean
declare function ilEnable (byval Mode as ILenum) as ILboolean
declare function ilFormatFunc (byval Mode as ILenum) as ILboolean
declare sub ilGenImages (byval Num as ILsizei, byval Images as ILuint ptr)
declare function ilGetAlpha (byval Type as ILenum) as ILubyte ptr
declare sub ilModAlpha (byval AlphaValue as ILint)
declare sub ilSetAlpha (byval AlphaValue as ILuint)
declare function ilGetBoolean (byval Mode as ILenum) as ILboolean
declare sub ilGetBooleanv (byval Mode as ILenum, byval Param as ILboolean ptr)
declare function ilGetData () as ILubyte ptr
declare function ilGetDXTCData (byval Buffer as ILvoid ptr, byval BufferSize as ILuint, byval DXTCFormat as ILenum) as ILuint
declare function ilGetError () as ILenum
declare function ilGetInteger (byval Mode as ILenum) as ILint
declare sub ilGetIntegerv (byval Mode as ILenum, byval Param as ILint ptr)
declare function ilGetLumpPos () as ILuint
declare function ilGetPalette () as ILubyte ptr
declare function ilGetString (byval StringName as ILenum) as zstring ptr
declare sub ilHint (byval Target as ILenum, byval Mode as ILenum)
declare sub ilInit ()
declare function ilIsDisabled (byval Mode as ILenum) as ILboolean
declare function ilIsEnabled (byval Mode as ILenum) as ILboolean
declare function ilIsImage (byval Image as ILuint) as ILboolean
declare function ilIsValid (byval Type as ILenum, byval FileName as ILstring) as ILboolean
declare function ilIsValidF (byval Type as ILenum, byval File as ILHANDLE) as ILboolean
declare function ilIsValidL (byval Type as ILenum, byval Lump as ILvoid ptr, byval Size as ILuint) as ILboolean
declare sub ilKeyColour (byval Red as ILclampf, byval Green as ILclampf, byval Blue as ILclampf, byval Alpha as ILclampf)
declare function ilLoad (byval Type as ILenum, byval FileName as ILstring) as ILboolean
declare function ilLoadF (byval Type as ILenum, byval File as ILHANDLE) as ILboolean
declare function ilLoadImage (byval FileName as ILstring) as ILboolean
declare function ilLoadL (byval Type as ILenum, byval Lump as ILvoid ptr, byval Size as ILuint) as ILboolean
declare function ilLoadPal (byval FileName as ILstring) as ILboolean
declare function ilOriginFunc (byval Mode as ILenum) as ILboolean
declare function ilOverlayImage (byval Source as ILuint, byval XCoord as ILint, byval YCoord as ILint, byval ZCoord as ILint) as ILboolean
declare sub ilPopAttrib ()
declare sub ilPushAttrib (byval Bits as ILuint)
declare sub ilRegisterFormat (byval Format as ILenum)
declare function ilRegisterLoad (byval Ext as ILstring, byval Load as IL_LOADPROC) as ILboolean
declare function ilRegisterMipNum (byval Num as ILuint) as ILboolean
declare function ilRegisterNumImages (byval Num as ILuint) as ILboolean
declare sub ilRegisterOrigin (byval Origin as ILenum)
declare sub ilRegisterPal (byval Pal as ILvoid ptr, byval Size as ILuint, byval Type as ILenum)
declare function ilRegisterSave (byval Ext as ILstring, byval Save as IL_SAVEPROC) as ILboolean
declare sub ilRegisterType (byval Type as ILenum)
declare function ilRemoveLoad (byval Ext as ILstring) as ILboolean
declare function ilRemoveSave (byval Ext as ILstring) as ILboolean
declare sub ilResetMemory ()
declare sub ilResetRead ()
declare sub ilResetWrite ()
declare function ilSave (byval Type as ILenum, byval FileName as ILstring) as ILboolean
declare function ilSaveF (byval Type as ILenum, byval File as ILHANDLE) as ILuint
declare function ilSaveImage (byval FileName as ILstring) as ILboolean
declare function ilSaveL (byval Type as ILenum, byval Lump as ILvoid ptr, byval Size as ILuint) as ILuint
declare function ilSavePal (byval FileName as ILstring) as ILboolean
declare function ilSetData (byval Data as ILvoid ptr) as ILboolean
declare function ilSetDuration (byval Duration as ILuint) as ILboolean
declare sub ilSetInteger (byval Mode as ILenum, byval Param as ILint)
declare sub ilSetMemory (byval as mAlloc, byval as mFree)
declare sub ilSetPixels (byval XOff as ILint, byval YOff as ILint, byval ZOff as ILint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Format as ILenum, byval Type as ILenum, byval Data as ILvoid ptr)
declare sub ilSetRead (byval as fOpenRProc, byval as fCloseRProc, byval as fEofProc, byval as fGetcProc, byval as fReadProc, byval as fSeekRProc, byval as fTellRProc)
declare sub ilSetString (byval Mode as ILenum, byval String as zstring ptr)
declare sub ilSetWrite (byval as fOpenWProc, byval as fCloseWProc, byval as fPutcProc, byval as fSeekWProc, byval as fTellWProc, byval as fWriteProc)
declare sub ilShutDown ()
declare function ilTexImage (byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte, byval Format as ILenum, byval Type as ILenum, byval Data as ILvoid ptr) as ILboolean
declare function ilTypeFunc (byval Mode as ILenum) as ILboolean
declare function ilLoadData (byval FileName as ILstring, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte) as ILboolean
declare function ilLoadDataF (byval File as ILHANDLE, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte) as ILboolean
declare function ilLoadDataL (byval Lump as ILvoid ptr, byval Size as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte) as ILboolean
declare function ilSaveData (byval FileName as ILstring) as ILboolean
declare function ilLoadFromJpegStruct (byval JpegDecompressorPtr as ILvoid ptr) as ILboolean
declare function ilSaveFromJpegStruct (byval JpegCompressorPtr as ILvoid ptr) as ILboolean
end extern

#endif
