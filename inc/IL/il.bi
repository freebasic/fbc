#pragma once

#ifdef __FB_WIN32__
	'' DevIL MSVC build:
	''#inclib "DevIL"
	''extern "Windows-MS"

	'' DevIL MinGW/MSYS build:
	#inclib "IL"
	extern "Windows"
#else
	#inclib "IL"
	extern "C"
#endif

'' Dependencies for static linking
#inclib "jasper"
#inclib "jpeg"
#inclib "tiff"
#inclib "mng"
#inclib "png"
#inclib "lzma"
#inclib "z"
#inclib "stdc++"

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

#ifdef _UNICODE
	#define ILchar wstring
	#define ILstring wstring ptr
	#define ILconst_string const wstring ptr
#else
	#define ILchar zstring
	#define ILstring zstring ptr
	#define ILconst_string const zstring ptr
#endif

#define IL_FALSE 0
#define IL_TRUE 1

#define IL_COLOUR_INDEX &h1900
#define IL_COLOR_INDEX &h1900
#define IL_ALPHA &h1906
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
#define IL_HALF &h140B

#define IL_VENDOR &h1F00
#define IL_LOAD_EXT &h1F01
#define IL_SAVE_EXT &h1F02

#define IL_VERSION_1_7_8 1
#define IL_VERSION 178

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
#define IL_ILBM &h0426
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
#define IL_HDR &h043F
#define IL_ICNS &h0440
#define IL_JP2 &h0441
#define IL_EXR &h0442
#define IL_WDP &h0443
#define IL_VTF &h0444
#define IL_WBMP &h0445
#define IL_SUN &h0446
#define IL_IFF &h0447
#define IL_TPL &h0448
#define IL_FITS &h0449
#define IL_DICOM &h044A
#define IL_IWI &h044B
#define IL_BLP &h044C
#define IL_FTX &h044D
#define IL_ROT &h044E
#define IL_TEXTURE &h044F
#define IL_DPX &h0450
#define IL_UTX &h0451
#define IL_MP3 &h0452

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
#define IL_LIB_JP2_ERROR &h05E6
#define IL_LIB_EXR_ERROR &h05E7
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
#define IL_BLIT_BLEND &h0636

#define IL_SAVE_INTERLACED &h0639
#define IL_INTERLACE_MODE &h063A

#define IL_QUANTIZATION_MODE &h0640
#define IL_WU_QUANT &h0641
#define IL_NEU_QUANT &h0642
#define IL_NEU_QUANT_SAMPLE &h0643
#define IL_MAX_QUANT_INDEXS &h0644
#define IL_MAX_QUANT_INDICES &h0644

#define IL_FASTEST &h0660
#define IL_LESS_MEM &h0661
#define IL_DONT_CARE &h0662
#define IL_MEM_SPEED_HINT &h0665
#define IL_USE_COMPRESSION &h0666
#define IL_NO_COMPRESSION &h0667
#define IL_COMPRESSION_HINT &h0668

#define IL_NVIDIA_COMPRESS &h0670
#define IL_SQUISH_COMPRESS &h0671

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
#define IL_JPG_PROGRESSIVE &h0725
#define IL_VTF_COMP &h0726

#define IL_DXTC_FORMAT &h0705
#define IL_DXT1 &h0706
#define IL_DXT2 &h0707
#define IL_DXT3 &h0708
#define IL_DXT4 &h0709
#define IL_DXT5 &h070A
#define IL_DXT_NO_COMP &h070B
#define IL_KEEP_DXTC_DATA &h070C
#define IL_DXTC_DATA_FORMAT &h070D
#define IL_3DC &h070E
#define IL_RXGB &h070F
#define IL_ATI1N &h0710
#define IL_DXT1A &h0711

#define IL_CUBEMAP_POSITIVEX &h00000400
#define IL_CUBEMAP_NEGATIVEX &h00000800
#define IL_CUBEMAP_POSITIVEY &h00001000
#define IL_CUBEMAP_NEGATIVEY &h00002000
#define IL_CUBEMAP_POSITIVEZ &h00004000
#define IL_CUBEMAP_NEGATIVEZ &h00008000
#define IL_SPHEREMAP &h00010000

#define IL_VERSION_NUM &h0DE2
#define IL_IMAGE_WIDTH &h0DE4
#define IL_IMAGE_HEIGHT &h0DE5
#define IL_IMAGE_DEPTH &h0DE6
#define IL_IMAGE_SIZE_OF_DATA &h0DE7
#define IL_IMAGE_BPP &h0DE8
#define IL_IMAGE_BYTES_PER_PIXEL &h0DE8
#define IL_IMAGE_BPP &h0DE8
#define IL_IMAGE_BITS_PER_PIXEL &h0DE9
#define IL_IMAGE_FORMAT &h0DEA
#define IL_IMAGE_TYPE &h0DEB
#define IL_PALETTE_TYPE &h0DEC
#define IL_PALETTE_SIZE &h0DED
#define IL_PALETTE_BPP &h0DEE
#define IL_PALETTE_NUM_COLS &h0DEF
#define IL_PALETTE_BASE_TYPE &h0DF0
#define IL_NUM_FACES &h0DE1
#define IL_NUM_IMAGES &h0DF1
#define IL_NUM_MIPMAPS &h0DF2
#define IL_NUM_LAYERS &h0DF3
#define IL_ACTIVE_IMAGE &h0DF4
#define IL_ACTIVE_MIPMAP &h0DF5
#define IL_ACTIVE_LAYER &h0DF6
#define IL_ACTIVE_FACE &h0E00
#define IL_CUR_IMAGE &h0DF7
#define IL_IMAGE_DURATION &h0DF8
#define IL_IMAGE_PLANESIZE &h0DF9
#define IL_IMAGE_BPC &h0DFA
#define IL_IMAGE_OFFX &h0DFB
#define IL_IMAGE_OFFY &h0DFC
#define IL_IMAGE_CUBEFLAGS &h0DFD
#define IL_IMAGE_ORIGIN &h0DFE
#define IL_IMAGE_CHANNELS &h0DFF

#define IL_SEEK_SET 0
#define IL_SEEK_CUR 1
#define IL_SEEK_END 2
#define IL_EOF -1

type ILHANDLE as any ptr
type fCloseRProc as sub (byval as ILHANDLE)
type fEofProc as function (byval as ILHANDLE) as ILboolean
type fGetcProc as function (byval as ILHANDLE) as ILint
type fOpenRProc as function (byval as ILconst_string) as ILHANDLE
type fReadProc as function (byval as any ptr, byval as ILuint, byval as ILuint, byval as ILHANDLE) as ILint
type fSeekRProc as function (byval as ILHANDLE, byval as ILint, byval as ILint) as ILint
type fTellRProc as function (byval as ILHANDLE) as ILint

type fCloseWProc as sub (byval as ILHANDLE)
type fOpenWProc as function (byval as ILconst_string) as ILHANDLE
type fPutcProc as function (byval as ILubyte, byval as ILHANDLE) as ILint
type fSeekWProc as function (byval as ILHANDLE, byval as ILint, byval as ILint) as ILint
type fTellWProc as function (byval as ILHANDLE) as ILint
type fWriteProc as function (byval as const any ptr, byval as ILuint, byval as ILuint, byval as ILHANDLE) as ILint

type mAlloc as function (byval as const ILsizei) as any ptr
type mFree as sub (byval as const any const ptr)

type IL_LOADPROC as function (byval as ILconst_string) as ILenum
type IL_SAVEPROC as function (byval as ILconst_string) as ILenum

declare function ilActiveFace (byval Number as ILuint) as ILboolean
declare function ilActiveImage (byval Number as ILuint) as ILboolean
declare function ilActiveLayer (byval Number as ILuint) as ILboolean
declare function ilActiveMipmap (byval Number as ILuint) as ILboolean
declare function ilApplyPal (byval FileName as ILconst_string) as ILboolean
declare function ilApplyProfile (byval InProfile as ILstring, byval OutProfile as ILstring) as ILboolean
declare sub ilBindImage (byval Image as ILuint)
declare function ilBlit (byval Source as ILuint, byval DestX as ILint, byval DestY as ILint, byval DestZ as ILint, byval SrcX as ILuint, byval SrcY as ILuint, byval SrcZ as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint) as ILboolean
declare function ilClampNTSC () as ILboolean
declare sub ilClearColour (byval Red as ILclampf, byval Green as ILclampf, byval Blue as ILclampf, byval Alpha as ILclampf)
declare function ilClearImage () as ILboolean
declare function ilCloneCurImage () as ILuint
declare function ilCompressDXT (byval Data as ILubyte ptr, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval DXTCFormat as ILenum, byval DXTCSize as ILuint ptr) as ILubyte ptr
declare function ilCompressFunc (byval Mode as ILenum) as ILboolean
declare function ilConvertImage (byval DestFormat as ILenum, byval DestType as ILenum) as ILboolean
declare function ilConvertPal (byval DestFormat as ILenum) as ILboolean
declare function ilCopyImage (byval Src as ILuint) as ILboolean
declare function ilCopyPixels (byval XOff as ILuint, byval YOff as ILuint, byval ZOff as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Format as ILenum, byval Type as ILenum, byval Data as any ptr) as ILuint
declare function ilCreateSubImage (byval Type as ILenum, byval Num as ILuint) as ILuint
declare function ilDefaultImage () as ILboolean
declare sub ilDeleteImage (byval Num as const ILuint)
declare sub ilDeleteImages (byval Num as ILsizei, byval Images as const ILuint ptr)
declare function ilDetermineType (byval FileName as ILconst_string) as ILenum
declare function ilDetermineTypeF (byval File as ILHANDLE) as ILenum
declare function ilDetermineTypeL (byval Lump as const any ptr, byval Size as ILuint) as ILenum
declare function ilDisable (byval Mode as ILenum) as ILboolean
declare function ilDxtcDataToImage () as ILboolean
declare function ilDxtcDataToSurface () as ILboolean
declare function ilEnable (byval Mode as ILenum) as ILboolean
declare sub ilFlipSurfaceDxtcData ()
declare function ilFormatFunc (byval Mode as ILenum) as ILboolean
declare sub ilGenImages (byval Num as ILsizei, byval Images as ILuint ptr)
declare function ilGenImage () as ILuint
declare function ilGetAlpha (byval Type as ILenum) as ILubyte ptr
declare function ilGetBoolean (byval Mode as ILenum) as ILboolean
declare sub ilGetBooleanv (byval Mode as ILenum, byval Param as ILboolean ptr)
declare function ilGetData () as ILubyte ptr
declare function ilGetDXTCData (byval Buffer as any ptr, byval BufferSize as ILuint, byval DXTCFormat as ILenum) as ILuint
declare function ilGetError () as ILenum
declare function ilGetInteger (byval Mode as ILenum) as ILint
declare sub ilGetIntegerv (byval Mode as ILenum, byval Param as ILint ptr)
declare function ilGetLumpPos () as ILuint
declare function ilGetPalette () as ILubyte ptr
declare function ilGetString (byval StringName as ILenum) as ILconst_string
declare sub ilHint (byval Target as ILenum, byval Mode as ILenum)
declare function ilInvertSurfaceDxtcDataAlpha () as ILboolean
declare sub ilInit ()
declare function ilImageToDxtcData (byval Format as ILenum) as ILboolean
declare function ilIsDisabled (byval Mode as ILenum) as ILboolean
declare function ilIsEnabled (byval Mode as ILenum) as ILboolean
declare function ilIsImage (byval Image as ILuint) as ILboolean
declare function ilIsValid (byval Type as ILenum, byval FileName as ILconst_string) as ILboolean
declare function ilIsValidF (byval Type as ILenum, byval File as ILHANDLE) as ILboolean
declare function ilIsValidL (byval Type as ILenum, byval Lump as any ptr, byval Size as ILuint) as ILboolean
declare sub ilKeyColour (byval Red as ILclampf, byval Green as ILclampf, byval Blue as ILclampf, byval Alpha as ILclampf)
declare function ilLoad (byval Type as ILenum, byval FileName as ILconst_string) as ILboolean
declare function ilLoadF (byval Type as ILenum, byval File as ILHANDLE) as ILboolean
declare function ilLoadImage (byval FileName as ILconst_string) as ILboolean
declare function ilLoadL (byval Type as ILenum, byval Lump as const any ptr, byval Size as ILuint) as ILboolean
declare function ilLoadPal (byval FileName as ILconst_string) as ILboolean
declare sub ilModAlpha (byval AlphaValue as ILdouble)
declare function ilOriginFunc (byval Mode as ILenum) as ILboolean
declare function ilOverlayImage (byval Source as ILuint, byval XCoord as ILint, byval YCoord as ILint, byval ZCoord as ILint) as ILboolean
declare sub ilPopAttrib ()
declare sub ilPushAttrib (byval Bits as ILuint)
declare sub ilRegisterFormat (byval Format as ILenum)
declare function ilRegisterLoad (byval Ext as ILconst_string, byval Load as IL_LOADPROC) as ILboolean
declare function ilRegisterMipNum (byval Num as ILuint) as ILboolean
declare function ilRegisterNumFaces (byval Num as ILuint) as ILboolean
declare function ilRegisterNumImages (byval Num as ILuint) as ILboolean
declare sub ilRegisterOrigin (byval Origin as ILenum)
declare sub ilRegisterPal (byval Pal as any ptr, byval Size as ILuint, byval Type as ILenum)
declare function ilRegisterSave (byval Ext as ILconst_string, byval Save as IL_SAVEPROC) as ILboolean
declare sub ilRegisterType (byval Type as ILenum)
declare function ilRemoveLoad (byval Ext as ILconst_string) as ILboolean
declare function ilRemoveSave (byval Ext as ILconst_string) as ILboolean
declare sub ilResetMemory ()
declare sub ilResetRead ()
declare sub ilResetWrite ()
declare function ilSave (byval Type as ILenum, byval FileName as ILconst_string) as ILboolean
declare function ilSaveF (byval Type as ILenum, byval File as ILHANDLE) as ILuint
declare function ilSaveImage (byval FileName as ILconst_string) as ILboolean
declare function ilSaveL (byval Type as ILenum, byval Lump as any ptr, byval Size as ILuint) as ILuint
declare function ilSavePal (byval FileName as ILconst_string) as ILboolean
declare function ilSetAlpha (byval AlphaValue as ILdouble) as ILboolean
declare function ilSetData (byval Data as any ptr) as ILboolean
declare function ilSetDuration (byval Duration as ILuint) as ILboolean
declare sub ilSetInteger (byval Mode as ILenum, byval Param as ILint)
declare sub ilSetMemory (byval as mAlloc, byval as mFree)
declare sub ilSetPixels (byval XOff as ILint, byval YOff as ILint, byval ZOff as ILint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Format as ILenum, byval Type as ILenum, byval Data as any ptr)
declare sub ilSetRead (byval as fOpenRProc, byval as fCloseRProc, byval as fEofProc, byval as fGetcProc, byval as fReadProc, byval as fSeekRProc, byval as fTellRProc)
declare sub ilSetString (byval Mode as ILenum, byval String as const zstring ptr)
declare sub ilSetWrite (byval as fOpenWProc, byval as fCloseWProc, byval as fPutcProc, byval as fSeekWProc, byval as fTellWProc, byval as fWriteProc)
declare sub ilShutDown ()
declare function ilSurfaceToDxtcData (byval Format as ILenum) as ILboolean
declare function ilTexImage (byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval NumChannels as ILubyte, byval Format as ILenum, byval Type as ILenum, byval Data as any ptr) as ILboolean
declare function ilTexImageDxtc (byval w as ILint, byval h as ILint, byval d as ILint, byval DxtFormat as ILenum, byval data as const ILubyte ptr) as ILboolean
declare function ilTypeFromExt (byval FileName as ILconst_string) as ILenum
declare function ilTypeFunc (byval Mode as ILenum) as ILboolean
declare function ilLoadData (byval FileName as ILconst_string, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte) as ILboolean
declare function ilLoadDataF (byval File as ILHANDLE, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte) as ILboolean
declare function ilLoadDataL (byval Lump as any ptr, byval Size as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint, byval Bpp as ILubyte) as ILboolean
declare function ilSaveData (byval FileName as ILconst_string) as ILboolean

#define ilClearColor ilClearColour
#define ilKeyColor ilKeyColour

#define imemclear (x,y) memset(x,0,y)

end extern
