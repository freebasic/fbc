''
''
'' vfw -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __vfw_bi__
#define __vfw_bi__

#include once "windows.bi"
#include once "win/mmsystem.bi"
#include once "win/ole2.bi"

#inclib "avifil32"
#inclib "uuid"

#define ICERR_OK 0
#define ICERR_DONTDRAW 1
#define ICERR_NEWPALETTE 2
#define ICERR_GOTOKEYFRAME 3
#define ICERR_STOPDRAWING 4
#define ICERR_UNSUPPORTED -1
#define ICERR_BADFORMAT -2
#define ICERR_MEMORY -3
#define ICERR_INTERNAL -4
#define ICERR_BADFLAGS -5
#define ICERR_BADPARAM -6
#define ICERR_BADSIZE -7
#define ICERR_BADHANDLE -8
#define ICERR_CANTUPDATE -9
#define ICERR_ABORT -10
#define ICERR_ERROR -100
#define ICERR_BADBITDEPTH -200
#define ICERR_BADIMAGESIZE -201
#define ICERR_CUSTOM -400
#define ICCOMPRESSFRAMES_PADDING &h01
#define ICM_USER (&h4000+&h0000)
#define ICM_RESERVED_LOW (&h4000+&h1000)
#define ICM_RESERVED_HIGH (&h4000+&h2000)
#define ICM_RESERVED (&h4000+&h1000)
#define ICM_GETSTATE ((&h4000+&h1000) +0)
#define ICM_SETSTATE ((&h4000+&h1000) +1)
#define ICM_GETINFO ((&h4000+&h1000) +2)
#define ICM_CONFIGURE ((&h4000+&h1000) +10)
#define ICM_ABOUT ((&h4000+&h1000) +11)
#define ICM_GETDEFAULTQUALITY ((&h4000+&h1000) +30)
#define ICM_GETQUALITY ((&h4000+&h1000) +31)
#define ICM_SETQUALITY ((&h4000+&h1000) +32)
#define ICM_SET ((&h4000+&h1000) +40)
#define ICM_GET ((&h4000+&h1000) +41)
#define ICM_FRAMERATE	mmioFOURCC(asc("F"),asc("r"),asc("m"),asc("R"))
#define ICM_KEYFRAMERATE	mmioFOURCC(asc("K"),asc("e"),asc("y"),asc("R"))
#define ICM_COMPRESS_GET_FORMAT ((&h4000+&h0000) +4)
#define ICM_COMPRESS_GET_SIZE ((&h4000+&h0000) +5)
#define ICM_COMPRESS_QUERY ((&h4000+&h0000) +6)
#define ICM_COMPRESS_BEGIN ((&h4000+&h0000) +7)
#define ICM_COMPRESS ((&h4000+&h0000) +8)
#define ICM_COMPRESS_END ((&h4000+&h0000) +9)
#define ICM_DECOMPRESS_GET_FORMAT ((&h4000+&h0000) +10)
#define ICM_DECOMPRESS_QUERY ((&h4000+&h0000) +11)
#define ICM_DECOMPRESS_BEGIN ((&h4000+&h0000) +12)
#define ICM_DECOMPRESS ((&h4000+&h0000) +13)
#define ICM_DECOMPRESS_END ((&h4000+&h0000) +14)
#define ICM_DECOMPRESS_SET_PALETTE ((&h4000+&h0000) +29)
#define ICM_DECOMPRESS_GET_PALETTE ((&h4000+&h0000) +30)
#define ICM_DRAW_QUERY ((&h4000+&h0000) +31)
#define ICM_DRAW_BEGIN ((&h4000+&h0000) +15)
#define ICM_DRAW_GET_PALETTE ((&h4000+&h0000) +16)
#define ICM_DRAW_START ((&h4000+&h0000) +18)
#define ICM_DRAW_STOP ((&h4000+&h0000) +19)
#define ICM_DRAW_END ((&h4000+&h0000) +21)
#define ICM_DRAW_GETTIME ((&h4000+&h0000) +32)
#define ICM_DRAW ((&h4000+&h0000) +33)
#define ICM_DRAW_WINDOW ((&h4000+&h0000) +34)
#define ICM_DRAW_SETTIME ((&h4000+&h0000) +35)
#define ICM_DRAW_REALIZE ((&h4000+&h0000) +36)
#define ICM_DRAW_FLUSH ((&h4000+&h0000) +37)
#define ICM_DRAW_RENDERBUFFER ((&h4000+&h0000) +38)
#define ICM_DRAW_START_PLAY ((&h4000+&h0000) +39)
#define ICM_DRAW_STOP_PLAY ((&h4000+&h0000) +40)
#define ICM_DRAW_SUGGESTFORMAT ((&h4000+&h0000) +50)
#define ICM_DRAW_CHANGEPALETTE ((&h4000+&h0000) +51)
#define ICM_GETBUFFERSWANTED ((&h4000+&h0000) +41)
#define ICM_GETDEFAULTKEYFRAMERATE ((&h4000+&h0000) +42)
#define ICM_DECOMPRESSEX_BEGIN ((&h4000+&h0000) +60)
#define ICM_DECOMPRESSEX_QUERY ((&h4000+&h0000) +61)
#define ICM_DECOMPRESSEX ((&h4000+&h0000) +62)
#define ICM_DECOMPRESSEX_END ((&h4000+&h0000) +63)
#define ICM_COMPRESS_FRAMES_INFO ((&h4000+&h0000) +70)
#define ICM_SET_STATUS_PROC ((&h4000+&h0000) +72)
#define ICMF_CONFIGURE_QUERY &h01
#define ICCOMPRESS_KEYFRAME &h01
#define ICSTATUS_START 0
#define ICSTATUS_STATUS 1
#define ICSTATUS_END 2
#define ICSTATUS_ERROR 3
#define ICSTATUS_YIELD 4
#define ICMODE_COMPRESS 1
#define ICMODE_DECOMPRESS 2
#define ICMODE_FASTDECOMPRESS 3
#define ICMODE_QUERY 4
#define ICMODE_FASTCOMPRESS 5
#define ICMODE_DRAW 8
#define ICQUALITY_LOW 0
#define ICQUALITY_HIGH 10000
#define ICQUALITY_DEFAULT -1
#define VIDCF_QUALITY &h01
#define VIDCF_CRUNCH &h02
#define VIDCF_TEMPORAL &h04
#define VIDCF_COMPRESSFRAMES &h08
#define VIDCF_DRAW &h10
#define VIDCF_FASTTEMPORALC &h20
#define VIDCF_FASTTEMPORALD &h80
#define VIDCF_QUALITYTIME &h40
#define VIDCF_FASTTEMPORAL (&h20 or &h80)
#define ICMF_ABOUT_QUERY &h01
#define ICDECOMPRESS_HURRYUP &h80000000
#define ICDECOMPRESS_UPDATE &h40000000
#define ICDECOMPRESS_PREROLL &h20000000
#define ICDECOMPRESS_NULLFRAME &h10000000
#define ICDECOMPRESS_NOTKEYFRAME &h8000000
#define ICDRAW_QUERY &h01L
#define ICDRAW_FULLSCREEN &h02L
#define ICDRAW_HDC &h04L
#define ICDRAW_ANIMATE &h08L
#define ICDRAW_CONTINUE &h10L
#define ICDRAW_MEMORYDC &h20L
#define ICDRAW_UPDATING &h40L
#define ICDRAW_RENDER &h80L
#define ICDRAW_BUFFER &h100L
#define ICINSTALL_UNICODE &h8000
#define ICINSTALL_FUNCTION &h01
#define ICINSTALL_DRIVER &h02
#define ICINSTALL_HDRV &h04
#define ICINSTALL_DRIVERW &h8002
#define ICDRAW_HURRYUP &h80000000L
#define ICDRAW_UPDATE &h40000000L
#define ICDRAW_PREROLL &h20000000L
#define ICDRAW_NULLFRAME &h10000000L
#define ICDRAW_NOTKEYFRAME &h8000000L
#define ICMF_COMPVARS_VALID &h01
#define ICMF_CHOOSE_KEYFRAME &h01
#define ICMF_CHOOSE_DATARATE &h02
#define ICMF_CHOOSE_PREVIEW &h04
#define ICMF_CHOOSE_ALLCOMPRESSORS &h08
#define ICTYPE_VIDEO	mmioFOURCC(asc("v",asc("i"),asc("d"),asc("c"))
#define ICTYPE_AUDIO	mmioFOURCC(asc("a"),asc("u"),asc("d"),asc("c"))
#define formtypeAVI	mmioFOURCC(asc("A"),asc("V"),asc("I"),asc(" "))
#define listtypeAVIHEADER	mmioFOURCC(asc("h"),asc("d"),asc("r"),asc("l"))
#define ckidAVIMAINHDR	mmioFOURCC(asc("a"),asc("v"),asc("i"),asc("h"))
#define listtypeSTREAMHEADER	mmioFOURCC(asc("s"),asc("t"),asc("r"),asc("l"))
#define ckidSTREAMHEADER	mmioFOURCC(asc("s"),asc("t"),asc("r"),asc("h"))
#define ckidSTREAMFORMAT	mmioFOURCC(asc("s"),asc("t"),asc("r"),asc("f"))
#define ckidSTREAMHANDLERDATA	mmioFOURCC(asc("s"),asc("t"),asc("r"),asc("d"))
#define ckidSTREAMNAME	mmioFOURCC(asc("s"),asc("t"),asc("r"),asc("n"))
#define listtypeAVIMOVIE	mmioFOURCC(asc("m"),asc("o"),asc("v"),asc("i"))
#define listtypeAVIRECORD	mmioFOURCC(asc("r"),asc("e"),asc("c"),asc(" "))
#define ckidAVINEWINDEX	mmioFOURCC(asc("i', 'd', 'x', '1"))
#define streamtypeANY 0UL
#define streamtypeVIDEO	mmioFOURCC(asc("v"),asc("i"),asc("d"),asc("s"))
#define streamtypeAUDIO	mmioFOURCC(asc("a"),asc("u"),asc("d"),asc("s"))
#define streamtypeMIDI	mmioFOURCC(asc("m"),asc("i"),asc("d"),asc("s"))
#define streamtypeTEXT	mmioFOURCC(asc("t"),asc("x"),asc("t"),asc("s"))
#define cktypeDIBbits	aviTWOCC(asc("d"),asc("b"))
#define cktypeDIBcompressed	aviTWOCC(asc("d"),asc("c"))
#define cktypePALchange	aviTWOCC(asc("p"),asc("c"))
#define cktypeWAVEbytes	aviTWOCC(asc("w"),asc("b"))
#define ckidAVIPADDING	mmioFOURCC(asc("J"),asc("U"),asc("N"),asc("K"))
#define FromHex(n) (((n)>='A')?((n)+10-'A'):((n)-'0'))
#define StreamFromFOURCC(fcc) (cushort((FromHex(LOBYTE(LOWORD(fcc))) shl 4)+(FromHex(HIBYTE(LOWORD(fcc))))))
#define TWOCCFromFOURCC(fcc) HIWORD(fcc)
#define ToHex(n) cubyte(iif((n)>9), ((n)-10+asc("A")), ((n)+asc("0"))))
#define MAKEAVICKID(tcc, stream) MAKELONG((ToHex((stream) and &h0f) shl 8) or (ToHex(((stream) and &hf0) shr 4)),tcc)
#define AVIF_HASINDEX &h10
#define AVIF_MUSTUSEINDEX &h20
#define AVIF_ISINTERLEAVED &h100
#define AVIF_TRUSTCKTYPE &h800
#define AVIF_WASCAPTUREFILE &h10000
#define AVIF_COPYRIGHTED &h20000
#define AVI_HEADERSIZE 2048
#define AVISF_DISABLED &h01
#define AVISF_VIDEO_PALCHANGES &h10000
#define AVIIF_LIST &h01
#define AVIIF_TWOCC &h02
#define AVIIF_KEYFRAME &h10
#define AVIIF_NOTIME &h100
#define AVIIF_COMPUSE &hfff0000
#define AVIIF_KEYFRAME &h10
#define AVIGETFRAMEF_BESTDISPLAYFMT 1
#define AVISTREAMINFO_DISABLED &h01
#define AVISTREAMINFO_FORMATCHANGES &h10000
#define AVIFILEINFO_HASINDEX &h10
#define AVIFILEINFO_MUSTUSEINDEX &h20
#define AVIFILEINFO_ISINTERLEAVED &h100
#define AVIFILEINFO_TRUSTCKTYPE &h800
#define AVIFILEINFO_WASCAPTUREFILE &h10000
#define AVIFILEINFO_COPYRIGHTED &h20000
#define AVIFILECAPS_CANREAD &h01
#define AVIFILECAPS_CANWRITE &h02
#define AVIFILECAPS_ALLKEYFRAMES &h10
#define AVIFILECAPS_NOCOMPRESSION &h20
#define AVICOMPRESSF_INTERLEAVE &h01
#define AVICOMPRESSF_DATARATE &h02
#define AVICOMPRESSF_KEYFRAMES &h04
#define AVICOMPRESSF_VALID &h08
#define FIND_DIR &h0000000fL
#define FIND_NEXT &h00000001L
#define FIND_PREV &h00000004L
#define FIND_FROM_START &h00000008L
#define FIND_TYPE &h000000f0L
#define FIND_KEY &h00000010L
#define FIND_ANY &h00000020L
#define FIND_FORMAT &h00000040L
#define FIND_RET &h0000f000L
#define FIND_POS &h00000000L
#define FIND_LENGTH &h00001000L
#define FIND_OFFSET &h00002000L
#define FIND_SIZE &h00003000L
#define FIND_INDEX &h00004000L
#define AVIERR_OK 0
#define AVIERR_UNSUPPORTED	MAKE_AVIERR(101)
#define AVIERR_BADFORMAT	MAKE_AVIERR(102)
#define AVIERR_MEMORY	MAKE_AVIERR(103)
#define AVIERR_INTERNAL	MAKE_AVIERR(104)
#define AVIERR_BADFLAGS	MAKE_AVIERR(105)
#define AVIERR_BADPARAM	MAKE_AVIERR(106)
#define AVIERR_BADSIZE	MAKE_AVIERR(107)
#define AVIERR_BADHANDLE	MAKE_AVIERR(108)
#define AVIERR_FILEREAD	MAKE_AVIERR(109)
#define AVIERR_FILEWRITE	MAKE_AVIERR(110)
#define AVIERR_FILEOPEN	MAKE_AVIERR(111)
#define AVIERR_COMPRESSOR	MAKE_AVIERR(112)
#define AVIERR_NOCOMPRESSOR	MAKE_AVIERR(113)
#define AVIERR_READONLY	MAKE_AVIERR(114)
#define AVIERR_NODATA	MAKE_AVIERR(115)
#define AVIERR_BUFFERTOOSMALL	MAKE_AVIERR(116)
#define AVIERR_CANTCOMPRESS	MAKE_AVIERR(117)
#define AVIERR_USERABORT	MAKE_AVIERR(198)
#define AVIERR_ERROR	MAKE_AVIERR(199)
#define MAKE_AVIERR(e)	MAKE_SCODE(SEVERITY_ERROR,FACILITY_ITF,&h4000+e)
#define MCIWNDOPENF_NEW &h0001
#define MCIWNDF_NOAUTOSIZEWINDOW &h0001
#define MCIWNDF_NOPLAYBAR &h0002
#define MCIWNDF_NOAUTOSIZEMOVIE &h0004
#define MCIWNDF_NOMENU &h0008
#define MCIWNDF_SHOWNAME &h0010
#define MCIWNDF_SHOWPOS &h0020
#define MCIWNDF_SHOWMODE &h0040
#define MCIWNDF_SHOWALL &h0070
#define MCIWNDF_NOTIFYMODE &h0100
#define MCIWNDF_NOTIFYPOS &h0200
#define MCIWNDF_NOTIFYSIZE &h0400
#define MCIWNDF_NOTIFYERROR &h1000
#define MCIWNDF_NOTIFYALL &h1F00
#define MCIWNDF_NOTIFYANSI &h0080
#define MCIWNDF_NOTIFYMEDIAA &h0880
#define MCIWNDF_NOTIFYMEDIAW &h0800
#define MCIWNDF_RECORD &h2000
#define MCIWNDF_NOERRORDLG &h4000
#define MCIWNDF_NOOPEN &h8000
#define MCIWNDM_GETDEVICEID (1024+100)
#define MCIWNDM_GETSTART (1024+103)
#define MCIWNDM_GETLENGTH (1024+104)
#define MCIWNDM_GETEND (1024+105)
#define MCIWNDM_EJECT (1024+107)
#define MCIWNDM_SETZOOM (1024+108)
#define MCIWNDM_GETZOOM (1024+109)
#define MCIWNDM_SETVOLUME (1024+110)
#define MCIWNDM_GETVOLUME (1024+111)
#define MCIWNDM_SETSPEED (1024+112)
#define MCIWNDM_GETSPEED (1024+113)
#define MCIWNDM_SETREPEAT (1024+114)
#define MCIWNDM_GETREPEAT (1024+115)
#define MCIWNDM_REALIZE (1024+118)
#define MCIWNDM_VALIDATEMEDIA (1024+121)
#define MCIWNDM_PLAYFROM (1024+122)
#define MCIWNDM_PLAYTO (1024+123)
#define MCIWNDM_GETPALETTE (1024+126)
#define MCIWNDM_SETPALETTE (1024+127)
#define MCIWNDM_SETTIMERS (1024+129)
#define MCIWNDM_SETACTIVETIMER (1024+130)
#define MCIWNDM_SETINACTIVETIMER (1024+131)
#define MCIWNDM_GETACTIVETIMER (1024+132)
#define MCIWNDM_GETINACTIVETIMER (1024+133)
#define MCIWNDM_CHANGESTYLES (1024+135)
#define MCIWNDM_GETSTYLES (1024+136)
#define MCIWNDM_GETALIAS (1024+137)
#define MCIWNDM_PLAYREVERSE (1024+139)
#define MCIWNDM_GET_SOURCE (1024+140)
#define MCIWNDM_PUT_SOURCE (1024+141)
#define MCIWNDM_GET_DEST (1024+142)
#define MCIWNDM_PUT_DEST (1024+143)
#define MCIWNDM_CAN_PLAY (1024+144)
#define MCIWNDM_CAN_WINDOW (1024+145)
#define MCIWNDM_CAN_RECORD (1024+146)
#define MCIWNDM_CAN_SAVE (1024+147)
#define MCIWNDM_CAN_EJECT (1024+148)
#define MCIWNDM_CAN_CONFIG (1024+149)
#define MCIWNDM_PALETTEKICK (1024+150)
#define MCIWNDM_OPENINTERFACE (1024+151)
#define MCIWNDM_SETOWNER (1024+152)
#define MCIWNDM_SENDSTRINGA (1024+101)
#define MCIWNDM_GETPOSITIONA (1024+102)
#define MCIWNDM_GETMODEA (1024+106)
#define MCIWNDM_SETTIMEFORMATA (1024+119)
#define MCIWNDM_GETTIMEFORMATA (1024+120)
#define MCIWNDM_GETFILENAMEA (1024+124)
#define MCIWNDM_GETDEVICEA (1024+125)
#define MCIWNDM_GETERRORA (1024+128)
#define MCIWNDM_NEWA (1024+134)
#define MCIWNDM_RETURNSTRINGA (1024+138)
#define MCIWNDM_OPENA (1024+153)
#define MCIWNDM_SENDSTRINGW (1024+201)
#define MCIWNDM_GETPOSITIONW (1024+202)
#define MCIWNDM_GETMODEW (1024+206)
#define MCIWNDM_SETTIMEFORMATW (1024+219)
#define MCIWNDM_GETTIMEFORMATW (1024+220)
#define MCIWNDM_GETFILENAMEW (1024+224)
#define MCIWNDM_GETDEVICEW (1024+225)
#define MCIWNDM_GETERRORW (1024+228)
#define MCIWNDM_NEWW (1024+234)
#define MCIWNDM_RETURNSTRINGW (1024+238)
#define MCIWNDM_OPENW (1024+252)
#define MCIWNDM_NOTIFYMODE (1024+200)
#define MCIWNDM_NOTIFYPOS (1024+201)
#define MCIWNDM_NOTIFYSIZE (1024+202)
#define MCIWNDM_NOTIFYMEDIA (1024+203)
#define MCIWNDM_NOTIFYERROR (1024+205)
#define MCIWND_START -1
#define MCIWND_END -2
#define DDF_UPDATE &h02
#define DDF_SAME_HDC &h04
#define DDF_SAME_DRAW &h08
#define DDF_DONTDRAW &h10
#define DDF_ANIMATE &h20
#define DDF_BUFFER &h40
#define DDF_JUSTDRAWIT &h80
#define DDF_FULLSCREEN &h100
#define DDF_BACKGROUNDPAL &h200
#define DDF_NOTKEYFRAME &h400
#define DDF_HURRYUP &h800
#define DDF_HALFTONE &h1000
#define DDF_PREROLL &h10
#define DDF_SAME_DIB &h08
#define DDF_SAME_SIZE &h08
#define PD_CAN_DRAW_DIB &h01
#define PD_CAN_STRETCHDIB &h02
#define PD_STRETCHDIB_1_1_OK &h04
#define PD_STRETCHDIB_1_2_OK &h08
#define PD_STRETCHDIB_1_N_OK &h10
#ifndef mmioFOURCC
#define mmioFOURCC(c0,c1,c2,c3) (cuint(c0) or (cuitn(c1) shl 8) or (cuint(c2) shl 16) or (cuint(c3) shl 24))
#endif
#ifndef aviTWOCC
#define aviTWOCC(ch0,ch1) (cushort(cubyte(ch0)) or (cushort(cubyte(ch1)) shr 8))
#endif

type HIC__
	i as integer
end type

type HIC as HIC__ ptr

type HDRAWDIB__
	i as integer
end type

type HDRAWDIB as HDRAWDIB__ ptr
type TWOCC as WORD
type AVISAVECALLBACK as function (byval as INT_) as BOOL

type ICOPEN
	dwSize as DWORD
	fccType as DWORD
	fccHandler as DWORD
	dwVersion as DWORD
	dwFlags as DWORD
	dwError as LONG
	pV1Reserved as LPVOID
	pV2Reserved as LPVOID
	dnDevNode as DWORD
end type

type LPICOPEN as ICOPEN ptr

type ICCOMPRESS
	dwFlags as DWORD
	lpbiOutput as LPBITMAPINFOHEADER
	lpOutput as LPVOID
	lpbiInput as LPBITMAPINFOHEADER
	lpInput as LPVOID
	lpckid as LPDWORD
	lpdwFlags as LPDWORD
	lFrameNum as LONG
	dwFrameSize as DWORD
	dwQuality as DWORD
	lpbiPrev as LPBITMAPINFOHEADER
	lpPrev as LPVOID
end type

type ICCOMPRESSFRAMES
	dwFlags as DWORD
	lpbiOutput as LPBITMAPINFOHEADER
	lOutput as LPARAM
	lpbiInput as LPBITMAPINFOHEADER
	lInput as LPARAM
	lStartFrame as LONG
	lFrameCount as LONG
	lQuality as LONG
	lDataRate as LONG
	lKeyRate as LONG
	dwRate as DWORD
	dwScale as DWORD
	dwOverheadPerFrame as DWORD
	dwReserved2 as DWORD
	GetData as function (byval as LPARAM, byval as LONG, byval as LPVOID, byval as LONG) as LONG
	PutData as function (byval as LPARAM, byval as LONG, byval as LPVOID, byval as LONG) as LONG
end type

type ICSETSTATUSPROC
	dwFlags as DWORD
	lParam as LPARAM
	Status as function (byval as LPARAM, byval as UINT, byval as LONG) as LONG
end type

type ICINFO
	dwSize as DWORD
	fccType as DWORD
	fccHandler as DWORD
	dwFlags as DWORD
	dwVersion as DWORD
	dwVersionICM as DWORD
	szName as wstring * 16
	szDescription as wstring * 128
	szDriver as wstring * 128
end type

type ICDECOMPRESS
	dwFlags as DWORD
	lpbiInput as LPBITMAPINFOHEADER
	lpInput as LPVOID
	lpbiOutput as LPBITMAPINFOHEADER
	lpOutput as LPVOID
	ckid as DWORD
end type

type ICDECOMPRESSEX
	dwFlags as DWORD
	lpbiSrc as LPBITMAPINFOHEADER
	lpSrc as LPVOID
	lpbiDst as LPBITMAPINFOHEADER
	lpDst as LPVOID
	xDst as INT_
	yDst as INT_
	dxDst as INT_
	dyDst as INT_
	xSrc as INT_
	ySrc as INT_
	dxSrc as INT_
	dySrc as INT_
end type

type ICDRAWSUGGEST
	dwFlags as DWORD
	lpbiIn as LPBITMAPINFOHEADER
	lpbiSuggest as LPBITMAPINFOHEADER
	dxSrc as INT_
	dySrc as INT_
	dxDst as INT_
	dyDst as INT_
	hicDecompressor as HIC
end type

type ICPALETTE
	dwFlags as DWORD
	iStart as INT_
	iLen as INT_
	lppe as LPPALETTEENTRY
end type

type ICDRAWBEGIN
	dwFlags as DWORD
	hpal as HPALETTE
	hwnd as HWND
	hdc as HDC
	xDst as INT_
	yDst as INT_
	dxDst as INT_
	dyDst as INT_
	lpbi as LPBITMAPINFOHEADER
	xSrc as INT_
	ySrc as INT_
	dxSrc as INT_
	dySrc as INT_
	dwRate as DWORD
	dwScale as DWORD
end type

type ICDRAW
	dwFlags as DWORD
	lpFormat as LPVOID
	lpData as LPVOID
	cbData as DWORD
	lTime as LONG
end type

type COMPVARS
	cbSize as LONG
	dwFlags as DWORD
	hic as HIC
	fccType as DWORD
	fccHandler as DWORD
	lpbiIn as LPBITMAPINFO
	lpbiOut as LPBITMAPINFO
	lpBitsOut as LPVOID
	lpBitsPrev as LPVOID
	lFrame as LONG
	lKey as LONG
	lDataRate as LONG
	lQ as LONG
	lKeyCount as LONG
	lpState as LPVOID
	cbState as LONG
end type

type PCOMPVARS as COMPVARS ptr

type MainAVIHeader
	dwMicroSecPerFrame as DWORD
	dwMaxBytesPerSec as DWORD
	dwPaddingGranularity as DWORD
	dwFlags as DWORD
	dwTotalFrames as DWORD
	dwInitialFrames as DWORD
	dwStreams as DWORD
	dwSuggestedBufferSize as DWORD
	dwWidth as DWORD
	dwHeight as DWORD
	dwReserved(0 to 4-1) as DWORD
end type

type AVIStreamHeader
	fccType as FOURCC
	fccHandler as FOURCC
	dwFlags as DWORD
	wPriority as WORD
	wLanguage as WORD
	dwInitialFrames as DWORD
	dwScale as DWORD
	dwRate as DWORD
	dwStart as DWORD
	dwLength as DWORD
	dwSuggestedBufferSize as DWORD
	dwQuality as DWORD
	dwSampleSize as DWORD
	rcFrame as RECT
end type

type AVIINDEXENTRY
	ckid as DWORD
	dwFlags as DWORD
	dwChunkOffset as DWORD
	dwChunkLength as DWORD
end type

type AVIPALCHANGE
	bFirstEntry as BYTE
	bNumEntries as BYTE
	wFlags as WORD
	peNew(0 to 1-1) as PALETTEENTRY
end type

#ifndef UNICODE
type AVISTREAMINFOA
	fccType as DWORD
	fccHandler as DWORD
	dwFlags as DWORD
	dwCaps as DWORD
	wPriority as WORD
	wLanguage as WORD
	dwScale as DWORD
	dwRate as DWORD
	dwStart as DWORD
	dwLength as DWORD
	dwInitialFrames as DWORD
	dwSuggestedBufferSize as DWORD
	dwQuality as DWORD
	dwSampleSize as DWORD
	rcFrame as RECT
	dwEditCount as DWORD
	dwFormatChangeCount as DWORD
	szName as zstring * 64
end type

type LPAVISTREAMINFOA as AVISTREAMINFOA ptr
type PAVISTREAMINFOA as AVISTREAMINFOA ptr

type AVIFILEINFOA
	dwMaxBytesPerSec as DWORD
	dwFlags as DWORD
	dwCaps as DWORD
	dwStreams as DWORD
	dwSuggestedBufferSize as DWORD
	dwWidth as DWORD
	dwHeight as DWORD
	dwScale as DWORD
	dwRate as DWORD
	dwLength as DWORD
	dwEditCount as DWORD
	szFileType as zstring * 64
end type

type LPAVIFILEINFOA as AVIFILEINFOA ptr
type PAVIFILEINFOA as AVIFILEINFOA ptr

type AVISTREAMINFOW as any
type AVIFILEINFOW as any

#else ''UNICODE
type AVISTREAMINFOW
	fccType as DWORD
	fccHandler as DWORD
	dwFlags as DWORD
	dwCaps as DWORD
	wPriority as WORD
	wLanguage as WORD
	dwScale as DWORD
	dwRate as DWORD
	dwStart as DWORD
	dwLength as DWORD
	dwInitialFrames as DWORD
	dwSuggestedBufferSize as DWORD
	dwQuality as DWORD
	dwSampleSize as DWORD
	rcFrame as RECT
	dwEditCount as DWORD
	dwFormatChangeCount as DWORD
	szName as wstring * 64
end type

type LPAVISTREAMINFOW as AVISTREAMINFOW ptr
type PAVISTREAMINFOW as AVISTREAMINFOW ptr

type AVIFILEINFOW
	dwMaxBytesPerSec as DWORD
	dwFlags as DWORD
	dwCaps as DWORD
	dwStreams as DWORD
	dwSuggestedBufferSize as DWORD
	dwWidth as DWORD
	dwHeight as DWORD
	dwScale as DWORD
	dwRate as DWORD
	dwLength as DWORD
	dwEditCount as DWORD
	szFileType as wstring * 64
end type

type LPAVIFILEINFOW as AVIFILEINFOW ptr
type PAVIFILEINFOW as AVIFILEINFOW ptr

#endif

type AVICOMPRESSOPTIONS
	fccType as DWORD
	fccHandler as DWORD
	dwKeyFrameEvery as DWORD
	dwQuality as DWORD
	dwBytesPerSecond as DWORD
	dwFlags as DWORD
	lpFormat as LPVOID
	cbFormat as DWORD
	lpParms as LPVOID
	cbParms as DWORD
	dwInterleaveEvery as DWORD
end type

type LPAVICOMPRESSOPTIONS as AVICOMPRESSOPTIONS ptr
type PAVICOMPRESSOPTIONS as AVICOMPRESSOPTIONS ptr

extern IID_IAVIFile alias "IID_IAVIFile" as GUID
extern IID_IAVIStream alias "IID_IAVIStream" as GUID
extern IID_IAVIStreaming alias "IID_IAVIStreaming" as GUID
extern IID_IGetFrame alias "IID_IGetFrame" as GUID
extern IID_IAVIEditStream alias "IID_IAVIEditStream" as GUID
extern CLSID_AVIFile alias "CLSID_AVIFile" as GUID

type IAVIStreamVtbl_ as IAVIStreamVtbl

type IAVIStream
	lpVtbl as IAVIStreamVtbl_ ptr
end type

type IAVIStreamVtbl
	QueryInterface as function (byval as IAVIStream ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IAVIStream ptr) as ULONG
	Release as function (byval as IAVIStream ptr) as ULONG
	Create as function (byval as IAVIStream ptr, byval as LPARAM, byval as LPARAM) as HRESULT
	Info as function (byval as IAVIStream ptr, byval as AVISTREAMINFOW ptr, byval as LONG) as HRESULT
	FindSample as function (byval as IAVIStream ptr, byval as LONG, byval as LONG) as LONG
	ReadFormat as function (byval as IAVIStream ptr, byval as LONG, byval as LPVOID, byval as LONG ptr) as HRESULT
	SetFormat as function (byval as IAVIStream ptr, byval as LONG, byval as LPVOID, byval as LONG) as HRESULT
	Read as function (byval as IAVIStream ptr, byval as LONG, byval as LONG, byval as LPVOID, byval as LONG, byval as LONG ptr, byval as LONG ptr) as HRESULT
	Write as function (byval as IAVIStream ptr, byval as LONG, byval as LONG, byval as LPVOID, byval as LONG, byval as DWORD, byval as LONG ptr, byval as LONG ptr) as HRESULT
	Delete as function (byval as IAVIStream ptr, byval as LONG, byval as LONG) as HRESULT
	ReadData as function (byval as IAVIStream ptr, byval as DWORD, byval as LPVOID, byval as LONG ptr) as HRESULT
	WriteData as function (byval as IAVIStream ptr, byval as DWORD, byval as LPVOID, byval as LONG) as HRESULT
	SetInfo as function (byval as IAVIStream ptr, byval as AVISTREAMINFOW ptr, byval as LONG) as HRESULT
end type

type PAVISTREAM as IAVIStream ptr

type IAVIStreamingVtbl_ as IAVIStreamingVtbl

type IAVIStreaming
	lpVtbl as IAVIStreamingVtbl_ ptr
end type

type IAVIStreamingVtbl
	QueryInterface as function (byval as IAVIStreaming ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IAVIStreaming ptr) as ULONG
	Release as function (byval as IAVIStreaming ptr) as ULONG
	Begin as function (byval as IAVIStreaming ptr, byval as LONG, byval as LONG, byval as LONG) as HRESULT
	End as function (byval as IAVIStreaming ptr) as HRESULT
end type

type PAVISTREAMING as IAVIStreaming ptr

type IAVIEditStreamVtbl_ as IAVIEditStreamVtbl

type IAVIEditStream
	lpVtbl as IAVIEditStreamVtbl_ ptr
end type

type IAVIEditStreamVtbl
	QueryInterface as function (byval as IAVIEditStream ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IAVIEditStream ptr) as ULONG
	Release as function (byval as IAVIEditStream ptr) as ULONG
	Cut as function (byval as IAVIEditStream ptr, byval as LONG ptr, byval as LONG ptr, byval as PAVISTREAM ptr) as HRESULT
	Copy as function (byval as IAVIEditStream ptr, byval as LONG ptr, byval as LONG ptr, byval as PAVISTREAM ptr) as HRESULT
	Paste as function (byval as IAVIEditStream ptr, byval as LONG ptr, byval as LONG ptr, byval as PAVISTREAM, byval as LONG, byval as LONG) as HRESULT
	Clone as function (byval as IAVIEditStream ptr, byval as PAVISTREAM ptr) as HRESULT
	SetInfo as function (byval as IAVIEditStream ptr, byval as LPAVISTREAMINFOW, byval as LONG) as HRESULT
end type

type PAVIEDITSTREAM as IAVIEditStream ptr

type IAVIFileVtbl_ as IAVIFileVtbl

type IAVIFile
	lpVtbl as IAVIFileVtbl_ ptr
end type

type IAVIFileVtbl
	QueryInterface as function (byval as IAVIFile ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IAVIFile ptr) as ULONG
	Release as function (byval as IAVIFile ptr) as ULONG
	Info as function (byval as IAVIFile ptr, byval as AVIFILEINFOW ptr, byval as LONG) as HRESULT
	GetStream as function (byval as IAVIFile ptr, byval as PAVISTREAM ptr, byval as DWORD, byval as LONG) as HRESULT
	CreateStream as function (byval as IAVIFile ptr, byval as PAVISTREAM ptr, byval as AVISTREAMINFOW ptr) as HRESULT
	WriteData as function (byval as IAVIFile ptr, byval as DWORD, byval as LPVOID, byval as LONG) as HRESULT
	ReadData as function (byval as IAVIFile ptr, byval as DWORD, byval as LPVOID, byval as LONG ptr) as HRESULT
	EndRecord as function (byval as IAVIFile ptr) as HRESULT
	DeleteStream as function (byval as IAVIFile ptr, byval as DWORD, byval as LONG) as HRESULT
end type

type PAVIFILE as IAVIFile ptr

type IGetFrameVtbl_ as IGetFrameVtbl

type IGetFrame
	lpVtbl as IGetFrameVtbl_ ptr
end type

type IGetFrameVtbl
	QueryInterface as function (byval as IGetFrame ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function (byval as IGetFrame ptr) as ULONG
	Release as function (byval as IGetFrame ptr) as ULONG
	GetFrame as function (byval as IGetFrame ptr, byval as LONG) as LPVOID
	Begin as function (byval as IGetFrame ptr, byval as LONG, byval as LONG, byval as LONG) as HRESULT
	End as function (byval as IGetFrame ptr) as HRESULT
	SetFormat as function (byval as IGetFrame ptr, byval as LPBITMAPINFOHEADER, byval as LPVOID, byval as INT_, byval as INT_, byval as INT_, byval as INT_) as HRESULT
end type

type PGETFRAME as IGetFrame ptr

declare function VideoForWindowsVersion alias "VideoForWindowsVersion" () as DWORD
declare function InitVFW alias "InitVFW" () as LONG
declare function TermVFW alias "TermVFW" () as LONG
declare function ICCompress alias "ICCompress" (byval as HIC, byval as DWORD, byval as LPBITMAPINFOHEADER, byval as LPVOID, byval as LPBITMAPINFOHEADER, byval as LPVOID, byval as LPDWORD, byval as LPDWORD, byval as LONG, byval as DWORD, byval as DWORD, byval as LPBITMAPINFOHEADER, byval as LPVOID) as DWORD
declare function ICDecompress alias "ICDecompress" (byval as HIC, byval as DWORD, byval as LPBITMAPINFOHEADER, byval as LPVOID, byval as LPBITMAPINFOHEADER, byval as LPVOID) as DWORD
declare function ICSendMessage alias "ICSendMessage" (byval as HIC, byval as UINT, byval as DWORD, byval as DWORD) as LRESULT
declare function ICImageCompress alias "ICImageCompress" (byval as HIC, byval as UINT, byval as LPBITMAPINFO, byval as LPVOID, byval as LPBITMAPINFO, byval as LONG, byval as LONG ptr) as HANDLE
declare function ICImageDecompress alias "ICImageDecompress" (byval as HIC, byval as UINT, byval as LPBITMAPINFO, byval as LPVOID, byval as LPBITMAPINFO) as HANDLE
declare function ICInfo alias "ICInfo" (byval as DWORD, byval as DWORD, byval as ICINFO ptr) as BOOL
declare function ICInstall alias "ICInstall" (byval as DWORD, byval as DWORD, byval as LPARAM, byval as LPSTR, byval as UINT) as BOOL
declare function ICRemove alias "ICRemove" (byval as DWORD, byval as DWORD, byval as UINT) as BOOL
declare function ICGetInfo alias "ICGetInfo" (byval as HIC, byval as ICINFO ptr, byval as DWORD) as LRESULT
declare function ICOpen alias "ICOpen" (byval as DWORD, byval as DWORD, byval as UINT) as HIC
declare function ICOpenFunction alias "ICOpenFunction" (byval as DWORD, byval as DWORD, byval as UINT, byval as FARPROC) as HIC
declare function ICClose alias "ICClose" (byval hic as HIC) as LRESULT
declare function ICLocate alias "ICLocate" (byval as DWORD, byval as DWORD, byval as LPBITMAPINFOHEADER, byval as LPBITMAPINFOHEADER, byval as WORD) as HIC
declare function ICGetDisplayFormat alias "ICGetDisplayFormat" (byval as HIC, byval as LPBITMAPINFOHEADER, byval as LPBITMAPINFOHEADER, byval as INT_, byval as INT_, byval as INT_) as HIC
declare function ICDrawBegin alias "ICDrawBegin" (byval as HIC, byval as DWORD, byval as HPALETTE, byval as HWND, byval as HDC, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as LPBITMAPINFOHEADER, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as DWORD, byval as DWORD) as DWORD
declare function ICDraw alias "ICDraw" (byval as HIC, byval as DWORD, byval as LPVOID, byval as LPVOID, byval as DWORD, byval as LONG) as DWORD
declare function ICCompressorChoose alias "ICCompressorChoose" (byval as HWND, byval as UINT, byval as LPVOID, byval as LPVOID, byval as PCOMPVARS, byval as LPSTR) as BOOL
declare function ICSeqCompressFrameStart alias "ICSeqCompressFrameStart" (byval as PCOMPVARS, byval as LPBITMAPINFO) as BOOL
declare sub ICSeqCompressFrameEnd alias "ICSeqCompressFrameEnd" (byval as PCOMPVARS)
declare function ICSeqCompressFrame alias "ICSeqCompressFrame" (byval as PCOMPVARS, byval as UINT, byval as LPVOID, byval as BOOL ptr, byval as LONG ptr) as LPVOID
declare sub ICCompressorFree alias "ICCompressorFree" (byval as PCOMPVARS)
declare function AVIStreamAddRef alias "AVIStreamAddRef" (byval as PAVISTREAM) as ULONG
declare function AVIStreamRelease alias "AVIStreamRelease" (byval as PAVISTREAM) as ULONG
declare function AVIStreamCreate alias "AVIStreamCreate" (byval as PAVISTREAM ptr, byval as LONG, byval as LONG, byval as CLSID ptr) as HRESULT
declare function AVIStreamFindSample alias "AVIStreamFindSample" (byval as PAVISTREAM, byval as LONG, byval as DWORD) as HRESULT
declare function AVIStreamReadFormat alias "AVIStreamReadFormat" (byval as PAVISTREAM, byval as LONG, byval as LPVOID, byval as LONG ptr) as HRESULT
declare function AVIStreamSetFormat alias "AVIStreamSetFormat" (byval as PAVISTREAM, byval as LONG, byval as LPVOID, byval as LONG) as HRESULT
declare function AVIStreamRead alias "AVIStreamRead" (byval as PAVISTREAM, byval as LONG, byval as LONG, byval as LPVOID, byval as LONG, byval as LONG ptr, byval as LONG ptr) as HRESULT
declare function AVIStreamWrite alias "AVIStreamWrite" (byval as PAVISTREAM, byval as LONG, byval as LONG, byval as LPVOID, byval as LONG, byval as DWORD, byval as LONG ptr, byval as LONG ptr) as HRESULT
declare function AVIStreamReadData alias "AVIStreamReadData" (byval as PAVISTREAM, byval as DWORD, byval as LPVOID, byval as LONG ptr) as HRESULT
declare function AVIStreamWriteData alias "AVIStreamWriteData" (byval as PAVISTREAM, byval as DWORD, byval as LPVOID, byval as LONG) as HRESULT
declare function AVIStreamGetFrameOpen alias "AVIStreamGetFrameOpen" (byval as PAVISTREAM, byval as LPBITMAPINFOHEADER) as PGETFRAME
declare function AVIStreamGetFrame alias "AVIStreamGetFrame" (byval as PGETFRAME, byval as LONG) as LPVOID
declare function AVIStreamGetFrameClose alias "AVIStreamGetFrameClose" (byval as PGETFRAME) as HRESULT
declare function AVIMakeCompressedStream alias "AVIMakeCompressedStream" (byval as PAVISTREAM ptr, byval as PAVISTREAM, byval as AVICOMPRESSOPTIONS ptr, byval as CLSID ptr) as HRESULT
declare function AVIMakeFileFromStreams alias "AVIMakeFileFromStreams" (byval as PAVIFILE ptr, byval as INT_, byval as PAVISTREAM ptr) as HRESULT
declare function AVISaveOptions alias "AVISaveOptions" (byval as HWND, byval as UINT, byval as INT_, byval as PAVISTREAM ptr, byval as LPAVICOMPRESSOPTIONS ptr) as BOOL
declare function AVISaveOptionsFree alias "AVISaveOptionsFree" (byval as INT_, byval as LPAVICOMPRESSOPTIONS ptr) as HRESULT
declare function AVIStreamStart alias "AVIStreamStart" (byval as PAVISTREAM) as LONG
declare function AVIStreamLength alias "AVIStreamLength" (byval as PAVISTREAM) as LONG
declare function AVIStreamSampleToTime alias "AVIStreamSampleToTime" (byval as PAVISTREAM, byval as LONG) as LONG
declare function AVIStreamTimeToSample alias "AVIStreamTimeToSample" (byval as PAVISTREAM, byval as LONG) as LONG
declare function CreateEditableStream alias "CreateEditableStream" (byval as PAVISTREAM ptr, byval as PAVISTREAM) as HRESULT
declare function EditStreamClone alias "EditStreamClone" (byval as PAVISTREAM, byval as PAVISTREAM ptr) as HRESULT
declare function EditStreamCopy alias "EditStreamCopy" (byval as PAVISTREAM, byval as LONG ptr, byval as LONG ptr, byval as PAVISTREAM ptr) as HRESULT
declare function EditStreamCut alias "EditStreamCut" (byval as PAVISTREAM, byval as LONG ptr, byval as LONG ptr, byval as PAVISTREAM ptr) as HRESULT
declare function EditStreamPaste alias "EditStreamPaste" (byval as PAVISTREAM, byval as LONG ptr, byval as LONG ptr, byval as PAVISTREAM, byval as LONG, byval as LONG) as HRESULT
declare sub AVIFileInit alias "AVIFileInit" ()
declare sub AVIFileExit alias "AVIFileExit" ()
declare function AVIFileAddRef alias "AVIFileAddRef" (byval as PAVIFILE) as ULONG
declare function AVIFileRelease alias "AVIFileRelease" (byval as PAVIFILE) as ULONG
declare function AVIFileGetStream alias "AVIFileGetStream" (byval as PAVIFILE, byval as PAVISTREAM ptr, byval as DWORD, byval as LONG) as HRESULT
declare function AVIFileWriteData alias "AVIFileWriteData" (byval as PAVIFILE, byval as DWORD, byval as LPVOID, byval as LONG) as HRESULT
declare function AVIFileReadData alias "AVIFileReadData" (byval as PAVIFILE, byval as DWORD, byval as LPVOID, byval as LPLONG) as HRESULT
declare function AVIFileEndRecord alias "AVIFileEndRecord" (byval as PAVIFILE) as HRESULT
declare function AVIClearClipboard alias "AVIClearClipboard" () as HRESULT
declare function AVIGetFromClipboard alias "AVIGetFromClipboard" (byval as PAVIFILE ptr) as HRESULT
declare function AVIPutFileOnClipboard alias "AVIPutFileOnClipboard" (byval as PAVIFILE) as HRESULT
declare function DrawDibOpen alias "DrawDibOpen" () as HDRAWDIB
declare function DrawDibRealize alias "DrawDibRealize" (byval as HDRAWDIB, byval as HDC, byval as BOOL) as UINT
declare function DrawDibBegin alias "DrawDibBegin" (byval as HDRAWDIB, byval as HDC, byval as INT_, byval as INT_, byval as LPBITMAPINFOHEADER, byval as INT_, byval as INT_, byval as UINT) as BOOL
declare function DrawDibDraw alias "DrawDibDraw" (byval as HDRAWDIB, byval as HDC, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as LPBITMAPINFOHEADER, byval as LPVOID, byval as INT_, byval as INT_, byval as INT_, byval as INT_, byval as UINT) as BOOL
declare function DrawDibSetPalette alias "DrawDibSetPalette" (byval as HDRAWDIB, byval as HPALETTE) as BOOL
declare function DrawDibGetPalette alias "DrawDibGetPalette" (byval as HDRAWDIB) as HPALETTE
declare function DrawDibChangePalette alias "DrawDibChangePalette" (byval as HDRAWDIB, byval as integer, byval as integer, byval as LPPALETTEENTRY) as BOOL
declare function DrawDibGetBuffer alias "DrawDibGetBuffer" (byval as HDRAWDIB, byval as LPBITMAPINFOHEADER, byval as DWORD, byval as DWORD) as LPVOID
declare function DrawDibStart alias "DrawDibStart" (byval as HDRAWDIB, byval as DWORD) as BOOL
declare function DrawDibStop alias "DrawDibStop" (byval as HDRAWDIB) as BOOL
declare function DrawDibEnd alias "DrawDibEnd" (byval as HDRAWDIB) as BOOL
declare function DrawDibClose alias "DrawDibClose" (byval as HDRAWDIB) as BOOL
declare function DrawDibProfileDisplay alias "DrawDibProfileDisplay" (byval as LPBITMAPINFOHEADER) as DWORD

#ifdef UNICODE
declare function AVIStreamOpenFromFile alias "AVIStreamOpenFromFileW" (byval as PAVISTREAM ptr, byval as LPCWSTR, byval as DWORD, byval as LONG, byval as UINT, byval as CLSID ptr) as HRESULT
declare function AVIBuildFilter alias "AVIBuildFilterW" (byval as LPWSTR, byval as LONG, byval as BOOL) as HRESULT
declare function AVISaveV alias "AVISaveVW" (byval as LPCWSTR, byval as CLSID ptr, byval as AVISAVECALLBACK, byval as INT_, byval as PAVISTREAM ptr, byval as LPAVICOMPRESSOPTIONS ptr) as HRESULT
declare function EditStreamSetInfo alias "EditStreamSetInfoW" (byval as PAVISTREAM, byval as LPAVISTREAMINFOW, byval as LONG) as HRESULT
declare function EditStreamSetName alias "EditStreamSetNameW" (byval as PAVISTREAM, byval as LPCWSTR) as HRESULT
declare function AVIFileOpen alias "AVIFileOpenW" (byval as PAVIFILE ptr, byval as LPCWSTR, byval as UINT, byval as LPCLSID) as HRESULT
declare function AVIFileInfo alias "AVIFileInfoW" (byval as PAVIFILE, byval as PAVIFILEINFOW, byval as LONG) as HRESULT
declare function AVIFileCreateStream alias "AVIFileCreateStreamW" (byval as PAVIFILE, byval as PAVISTREAM ptr, byval as AVISTREAMINFOW ptr) as HRESULT
declare function AVIStreamInfo alias "AVIStreamInfoW" (byval as PAVISTREAM, byval as AVISTREAMINFOW ptr, byval as LONG) as HRESULT
#ifdef OFN_READONLY
declare function GetOpenFileNamePreview alias "GetOpenFileNamePreviewW" (byval as LPOPENFILENAMEW) as BOOL
declare function GetSaveFileNamePreview alias "GetSaveFileNamePreviewW" (byval as LPOPENFILENAMEW) as BOOL
#endif
declare function MCIWndCreate alias "MCIWndCreateW" (byval as HWND, byval as HINSTANCE, byval as DWORD, byval as LPCWSTR) as HWND

type AVISTREAMINFO as AVISTREAMINFOW
type LPAVISTREAMINFO as LPAVISTREAMINFOW
type PAVISTREAMINFO as PAVISTREAMINFOW
type AVIFILEINFO as AVIFILEINFOW
type PAVIFILEINFO as PAVIFILEINFOW
type LPAVIFILEINFO as LPAVIFILEINFOW

#define MCIWNDF_NOTIFYMEDIA MCIWNDF_NOTIFYMEDIAW
#define MCIWNDM_SENDSTRING MCIWNDM_SENDSTRINGW
#define MCIWNDM_GETPOSITION MCIWNDM_GETPOSITIONW
#define MCIWNDM_GETMODE MCIWNDM_GETMODEW
#define MCIWNDM_SETTIMEFORMAT MCIWNDM_SETTIMEFORMATW
#define MCIWNDM_GETTIMEFORMAT MCIWNDM_GETTIMEFORMATW
#define MCIWNDM_GETFILENAME MCIWNDM_GETFILENAMEW
#define MCIWNDM_GETDEVICE MCIWNDM_GETDEVICEW
#define MCIWNDM_GETERROR MCIWNDM_GETERRORW
#define MCIWNDM_NEW MCIWNDM_NEWW
#define MCIWNDM_RETURNSTRING MCIWNDM_RETURNSTRINGW
#define MCIWNDM_OPEN MCIWNDM_OPENW

#else ''UNICODE
declare function AVIStreamOpenFromFile alias "AVIStreamOpenFromFileA" (byval as PAVISTREAM ptr, byval as LPCSTR, byval as DWORD, byval as LONG, byval as UINT, byval as CLSID ptr) as HRESULT
declare function AVIBuildFilter alias "AVIBuildFilterA" (byval as LPSTR, byval as LONG, byval as BOOL) as HRESULT
declare function AVISaveV alias "AVISaveVA" (byval as LPCSTR, byval as CLSID ptr, byval as AVISAVECALLBACK, byval as INT_, byval as PAVISTREAM ptr, byval as LPAVICOMPRESSOPTIONS ptr) as HRESULT
declare function EditStreamSetInfo alias "EditStreamSetInfoA" (byval as PAVISTREAM, byval as LPAVISTREAMINFOA, byval as LONG) as HRESULT
declare function EditStreamSetName alias "EditStreamSetNameA" (byval as PAVISTREAM, byval as LPCSTR) as HRESULT
declare function AVIFileOpen alias "AVIFileOpenA" (byval as PAVIFILE ptr, byval as LPCSTR, byval as UINT, byval as LPCLSID) as HRESULT
declare function AVIFileInfo alias "AVIFileInfoA" (byval as PAVIFILE, byval as PAVIFILEINFOA, byval as LONG) as HRESULT
declare function AVIFileCreateStream alias "AVIFileCreateStreamA" (byval as PAVIFILE, byval as PAVISTREAM ptr, byval as AVISTREAMINFOA ptr) as HRESULT
declare function AVIStreamInfo alias "AVIStreamInfoA" (byval as PAVISTREAM, byval as AVISTREAMINFOA ptr, byval as LONG) as HRESULT
#ifdef OFN_READONLY
declare function GetOpenFileNamePreview alias "GetOpenFileNamePreviewA" (byval as LPOPENFILENAMEA) as BOOL
declare function GetSaveFileNamePreview alias "GetSaveFileNamePreviewA" (byval as LPOPENFILENAMEA) as BOOL
#endif
declare function MCIWndCreate alias "MCIWndCreateA" (byval as HWND, byval as HINSTANCE, byval as DWORD, byval as LPCSTR) as HWND

type AVISTREAMINFO as AVISTREAMINFOA
type LPAVISTREAMINFO as LPAVISTREAMINFOA
type PAVISTREAMINFO as PAVISTREAMINFOA
type AVIFILEINFO as AVIFILEINFOA
type PAVIFILEINFO as PAVIFILEINFOA
type LPAVIFILEINFO as LPAVIFILEINFOA

#define MCIWNDF_NOTIFYMEDIA MCIWNDF_NOTIFYMEDIAA
#define MCIWNDM_SENDSTRING MCIWNDM_SENDSTRINGA
#define MCIWNDM_GETPOSITION MCIWNDM_GETPOSITIONA
#define MCIWNDM_GETMODE MCIWNDM_GETMODEA
#define MCIWNDM_SETTIMEFORMAT MCIWNDM_SETTIMEFORMATA
#define MCIWNDM_GETTIMEFORMAT MCIWNDM_GETTIMEFORMATA
#define MCIWNDM_GETFILENAME MCIWNDM_GETFILENAMEA
#define MCIWNDM_GETDEVICE MCIWNDM_GETDEVICEA
#define MCIWNDM_GETERROR MCIWNDM_GETERRORA
#define MCIWNDM_NEW MCIWNDM_NEWA
#define MCIWNDM_RETURNSTRING MCIWNDM_RETURNSTRINGA
#define MCIWNDM_OPEN MCIWNDM_OPENA
#endif ''UNICODE

#if 0
''!!!FIXME!!! !!!WRITEME!!! !!!FINISHME!!!
#define ICCompressGetFormat(hic,lpbiInput,lpbiOutput) ICSendMessage(hic,ICM_COMPRESS_GET_FORMAT,(DWORD)(lpbiInput),(DWORD)(lpbiOutput))
#define ICCompressGetFormatSize(hic,lpbi) ICCompressGetFormat(hic,lpbi,NULL)
#define ICCompressBegin(hic,lpbiInput,lpbiOutput) ICSendMessage(hic,ICM_COMPRESS_BEGIN,(DWORD)(lpbiInput),(DWORD)(lpbiOutput))
#define ICCompressGetSize(hic,lpbiInput,lpbiOutput) ICSendMessage(hic,ICM_COMPRESS_GET_SIZE,(DWORD)(lpbiInput),(DWORD)(lpbiOutput))
#define ICCompressQuery(hic,lpbiInput,lpbiOutput) ICSendMessage(hic,ICM_COMPRESS_QUERY,(DWORD)(lpbiInput),(DWORD)(lpbiOutput))
#define ICCompressEnd(hic) ICSendMessage(hic,ICM_COMPRESS_END,0,0)
#define ICQueryAbout(hic) (ICSendMessage(hic,ICM_ABOUT,(DWORD)-1,ICMF_ABOUT_QUERY)==ICERR_OK)
#define ICAbout(hic,hwnd) ICSendMessage(hic,ICM_ABOUT,(DWORD)(hwnd),0)
#define ICQueryConfigure(hic) (ICSendMessage(hic,ICM_CONFIGURE,(DWORD)-1,ICMF_CONFIGURE_QUERY)==ICERR_OK)
#define ICConfigure(hic,hwnd) ICSendMessage(hic,ICM_CONFIGURE,(DWORD)(hwnd),0)
#define ICDecompressBegin(hic,lpbiInput,lpbiOutput) ICSendMessage(hic,ICM_DECOMPRESS_BEGIN,(DWORD)(lpbiInput),(DWORD)(lpbiOutput))
#define ICDecompressQuery(hic,lpbiInput,lpbiOutput) ICSendMessage(hic,ICM_DECOMPRESS_QUERY,(DWORD)(lpbiInput),(DWORD)(lpbiOutput))
#define ICDecompressGetFormat(hic,lpbiInput,lpbiOutput) (LONG)ICSendMessage(hic,ICM_DECOMPRESS_GET_FORMAT,(DWORD)(lpbiInput),(DWORD)(lpbiOutput))
#define ICDecompressGetFormatSize(hic,lpbi) ICDecompressGetFormat(hic, lpbi, NULL)
#define ICDecompressGetPalette(hic,lpbiInput,lpbiOutput) ICSendMessage(hic,ICM_DECOMPRESS_GET_PALETTE,(DWORD)(lpbiInput),(DWORD)(lpbiOutput))
#define ICDecompressSetPalette(hic,lpbiPalette) ICSendMessage(hic,ICM_DECOMPRESS_SET_PALETTE,(DWORD)(lpbiPalette),0)
#define ICDecompressEnd(hic) ICSendMessage(hic,ICM_DECOMPRESS_END,0,0)
#define ICDecompressExEnd(hic) ICSendMessage(hic,ICM_DECOMPRESSEX_END,0,0)
#define ICDecompressOpen(fccType,fccHandler,lpbiIn,lpbiOut) ICLocate(fccType,fccHandler,lpbiIn,lpbiOut,ICMODE_DECOMPRESS)
#define ICDrawOpen(fccType,fccHandler,lpbiIn) ICLocate(fccType,fccHandler,lpbiIn,NULL,ICMODE_DRAW)
#define ICGetState(hic,pv,cb) ICSendMessage(hic,ICM_GETSTATE,(DWORD)(pv),(DWORD)(cb))
#define ICSetState(hic,pv,cb) ICSendMessage(hic,ICM_SETSTATE,(DWORD)(pv),(DWORD)(cb))
#define ICGetStateSize(hic) ICGetState(hic,NULL,0)
#define ICDrawWindow(hic,prc) ICSendMessage(hic,ICM_DRAW_WINDOW,(DWORD)(prc),sizeof(RECT))
#define ICDrawQuery(hic,lpbiInput) ICSendMessage(hic,ICM_DRAW_QUERY,(DWORD)(lpbiInput),0)
#define ICDrawChangePalette(hic,lpbiInput) ICSendMessage(hic,ICM_DRAW_CHANGEPALETTE,(DWORD)(lpbiInput),0)
#define ICGetBuffersWanted(hic,lpdwBuffers) ICSendMessage(hic,ICM_GETBUFFERSWANTED,(DWORD)(lpdwBuffers),0)
#define ICDrawEnd(hic) ICSendMessage(hic,ICM_DRAW_END,0,0)
#define ICDrawStart(hic) ICSendMessage(hic,ICM_DRAW_START,0,0)
#define ICDrawStartPlay(hic,lFrom,lTo) ICSendMessage(hic,ICM_DRAW_START_PLAY,(DWORD)(lFrom),(DWORD)(lTo))
#define ICDrawStop(hic) ICSendMessage(hic,ICM_DRAW_STOP,0,0)
#define ICDrawStopPlay(hic) ICSendMessage(hic,ICM_DRAW_STOP_PLAY,0,0)
#define ICDrawGetTime(hic,lplTime) ICSendMessage(hic,ICM_DRAW_GETTIME,(DWORD)(lplTime),0)
#define ICDrawSetTime(hic,lTime) ICSendMessage(hic,ICM_DRAW_SETTIME,(DWORD)lTime,0)
#define ICDrawRealize(hic,hdc,fBackground) ICSendMessage(hic,ICM_DRAW_REALIZE,(DWORD)(hdc),(DWORD)(fBackground))
#define ICDrawFlush(hic) ICSendMessage(hic,ICM_DRAW_FLUSH,0,0)
#define ICDrawRenderBuffer(hic) ICSendMessage(hic,ICM_DRAW_RENDERBUFFER,0,0)
#define AVIFileClose(pavi) AVIFileRelease(pavi)
#define AVIStreamClose(pavi) AVIStreamRelease(pavi);
#define AVIStreamEnd(pavi) (AVIStreamStart(pavi)+AVIStreamLength(pavi))
#define AVIStreamEndTime(pavi) AVIStreamSampleToTime(pavi,AVIStreamEnd(pavi))
#define AVIStreamFormatSize(pavi,lPos,plSize) AVIStreamReadFormat(pavi,lPos,NULL,plSize)
#define AVIStreamLengthTime(pavi) AVIStreamSampleToTime(pavi,AVIStreamLength(pavi))
#define AVIStreamSampleSize(pavi,pos,psize) AVIStreamRead(pavi,pos,1,NULL,0,psize,NULL)
#define AVIStreamSampleToSample(pavi1,pavi2,samp2) AVIStreamTimeToSample(pavi1,AVIStreamSampleToTime(pavi2,samp2))
#define AVIStreamStartTime(pavi) AVIStreamSampleToTime(pavi,AVIStreamStart(pavi))
#define AVIStreamNextSample(pavi,pos) AVIStreamFindSample(pavi,pos+1,FIND_NEXT|FIND_ANY)
#define AVIStreamPrevSample(pavi,pos) AVIStreamFindSample(pavi,pos-1,FIND_PREV|FIND_ANY)
#define AVIStreamNearestSample(pavi, pos) AVIStreamFindSample(pavi,pos,FIND_PREV|FIND_ANY)
#define AVStreamNextKeyFrame(pavi,pos) AVIStreamFindSample(pavi,pos+1,FIND_NEXT|FIND_KEY)
#define AVStreamPrevKeyFrame(pavi,pos) AVIStreamFindSample(pavi,pos-1,FIND_NEXT|FIND_KEY)
#define AVIStreamNearestKeyFrame(pavi,pos) AVIStreamFindSample(pavi,pos,FIND_PREV|FIND_KEY)
#define AVIStreamIsKeyFrame(pavi, pos) (AVIStreamNearestKeyFrame(pavi,pos) == pos)
#define MCIWndSM SendMessage
#define MCIWndCanPlay(hWnd) (BOOL)MCIWndSM(hWnd,MCIWNDM_CAN_PLAY,0,0)
#define MCIWndCanRecord(hWnd) (BOOL)MCIWndSM(hWnd,MCIWNDM_CAN_RECORD,0,0)
#define MCIWndCanSave(hWnd) (BOOL)MCIWndSM(hWnd,MCIWNDM_CAN_SAVE,0,0)
#define MCIWndCanWindow(hWnd) (BOOL)MCIWndSM(hWnd,MCIWNDM_CAN_WINDOW,0,0)
#define MCIWndCanEject(hWnd) (BOOL)MCIWndSM(hWnd,MCIWNDM_CAN_EJECT,0,0)
#define MCIWndCanConfig(hWnd) (BOOL)MCIWndSM(hWnd,MCIWNDM_CAN_CONFIG,0,0)
#define MCIWndPaletteKick(hWnd) (BOOL)MCIWndSM(hWnd,MCIWNDM_PALETTEKICK,0,0)
#define MCIWndSave(hWnd,szFile) (LONG)MCIWndSM(hWnd,MCI_SAVE,0,(LPARAM)(LPVOID)(szFile))
#define MCIWndSaveDialog(hWnd) MCIWndSave(hWnd,-1)
#define MCIWndNew(hWnd,lp) (LONG)MCIWndSM(hWnd,MCIWNDM_NEW,0,(LPARAM)(LPVOID)(lp))
#define MCIWndRecord(hWnd) (LONG)MCIWndSM(hWnd,MCI_RECORD,0,0)
#define MCIWndOpen(hWnd,sz,f) (LONG)MCIWndSM(hWnd,MCIWNDM_OPEN,(WPARAM)(UINT)(f),(LPARAM)(LPVOID)(sz))
#define MCIWndOpenDialog(hWnd) MCIWndOpen(hWnd,-1,0)
#define MCIWndClose(hWnd) (LONG)MCIWndSM(hWnd,MCI_CLOSE,0,0)
#define MCIWndPlay(hWnd) (LONG)MCIWndSM(hWnd,MCI_PLAY,0,0)
#define MCIWndStop(hWnd) (LONG)MCIWndSM(hWnd,MCI_STOP,0,0)
#define MCIWndPause(hWnd) (LONG)MCIWndSM(hWnd,MCI_PAUSE,0,0)
#define MCIWndResume(hWnd) (LONG)MCIWndSM(hWnd,MCI_RESUME,0,0)
#define MCIWndSeek(hWnd,lPos) (LONG)MCIWndSM(hWnd,MCI_SEEK,0,(LPARAM)(LONG)(lPos))
#define MCIWndEject(hWnd) (LONG)MCIWndSM(hWnd,MCIWNDM_EJECT,0,0)
#define MCIWndHome(hWnd) MCIWndSeek(hWnd,MCIWND_START)
#define MCIWndEnd(hWnd) MCIWndSeek(hWnd,MCIWND_END)
#define MCIWndGetSource(hWnd,prc) (LONG)MCIWndSM(hWnd,MCIWNDM_GET_SOURCE,0,(LPARAM)(LPRECT)(prc))
#define MCIWndPutSource(hWnd,prc) (LONG)MCIWndSM(hWnd,MCIWNDM_PUT_SOURCE,0,(LPARAM)(LPRECT)(prc))
#define MCIWndGetDest(hWnd,prc) (LONG)MCIWndSM(hWnd,MCIWNDM_GET_DEST,0,(LPARAM)(LPRECT)(prc))
#define MCIWndPutDest(hWnd,prc) (LONG)MCIWndSM(hWnd,MCIWNDM_PUT_DEST,0,(LPARAM)(LPRECT)(prc))
#define MCIWndPlayReverse(hWnd) (LONG)MCIWndSM(hWnd,MCIWNDM_PLAYREVERSE,0,0)
#define MCIWndPlayFrom(hWnd,lPos) (LONG)MCIWndSM(hWnd,MCIWNDM_PLAYFROM,0,(LPARAM)(LONG)(lPos))
#define MCIWndPlayTo(hWnd,lPos) (LONG)MCIWndSM(hWnd,MCIWNDM_PLAYTO,  0,(LPARAM)(LONG)(lPos))
#define MCIWndPlayFromTo(hWnd,lStart,lEnd) (MCIWndSeek(hWnd,lStart),MCIWndPlayTo(hWnd,lEnd))
#define MCIWndGetDeviceID(hWnd) (UINT)MCIWndSM(hWnd,MCIWNDM_GETDEVICEID,0,0)
#define MCIWndGetAlias(hWnd) (UINT)MCIWndSM(hWnd,MCIWNDM_GETALIAS,0,0)
#define MCIWndGetMode(hWnd,lp,len) (LONG)MCIWndSM(hWnd,MCIWNDM_GETMODE,(WPARAM)(UINT)(len),(LPARAM)(LPTSTR)(lp))
#define MCIWndGetPosition(hWnd) (LONG)MCIWndSM(hWnd,MCIWNDM_GETPOSITION,0,0)
#define MCIWndGetPositionString(hWnd,lp,len) (LONG)MCIWndSM(hWnd,MCIWNDM_GETPOSITION,(WPARAM)(UINT)(len),(LPARAM)(LPTSTR)(lp))
#define MCIWndGetStart(hWnd) (LONG)MCIWndSM(hWnd,MCIWNDM_GETSTART,0,0)
#define MCIWndGetLength(hWnd) (LONG)MCIWndSM(hWnd,MCIWNDM_GETLENGTH,0,0)
#define MCIWndGetEnd(hWnd) (LONG)MCIWndSM(hWnd,MCIWNDM_GETEND,0,0)
#define MCIWndStep(hWnd,n) (LONG)MCIWndSM(hWnd,MCI_STEP,0,(LPARAM)(long)(n))
#define MCIWndDestroy(hWnd) (VOID)MCIWndSM(hWnd,WM_CLOSE,0,0)
#define MCIWndSetZoom(hWnd,iZoom) (VOID)MCIWndSM(hWnd,MCIWNDM_SETZOOM,0,(LPARAM)(UINT)(iZoom))
#define MCIWndGetZoom(hWnd) (UINT)MCIWndSM(hWnd,MCIWNDM_GETZOOM,0,0)
#define MCIWndSetVolume(hWnd,iVol) (LONG)MCIWndSM(hWnd,MCIWNDM_SETVOLUME,0,(LPARAM)(UINT)(iVol))
#define MCIWndGetVolume(hWnd) (LONG)MCIWndSM(hWnd,MCIWNDM_GETVOLUME,0,0)
#define MCIWndSetSpeed(hWnd,iSpeed) (LONG)MCIWndSM(hWnd,MCIWNDM_SETSPEED,0,(LPARAM)(UINT)(iSpeed))
#define MCIWndGetSpeed(hWnd) (LONG)MCIWndSM(hWnd,MCIWNDM_GETSPEED,0,0)
#define MCIWndSetTimeFormat(hWnd,lp) (LONG)MCIWndSM(hWnd,MCIWNDM_SETTIMEFORMAT,0,(LPARAM)(LPTSTR)(lp))
#define MCIWndGetTimeFormat(hWnd,lp,len) (LONG)MCIWndSM(hWnd,MCIWNDM_GETTIMEFORMAT,(WPARAM)(UINT)(len),(LPARAM)(LPTSTR)(lp))
#define MCIWndValidateMedia(hWnd) (VOID)MCIWndSM(hWnd,MCIWNDM_VALIDATEMEDIA,0,0)
#define MCIWndSetRepeat(hWnd,f) (void)MCIWndSM(hWnd,MCIWNDM_SETREPEAT,0,(LPARAM)(BOOL)(f))
#define MCIWndGetRepeat(hWnd) (BOOL)MCIWndSM(hWnd,MCIWNDM_GETREPEAT,0,0)
#define MCIWndUseFrames(hWnd) MCIWndSetTimeFormat(hWnd,TEXT("frames"))
#define MCIWndUseTime(hWnd) MCIWndSetTimeFormat(hWnd,TEXT("ms"))
#define MCIWndSetActiveTimer(hWnd,active) (VOID)MCIWndSM(hWnd,MCIWNDM_SETACTIVETIMER,(WPARAM)(UINT)(active),0L)
#define MCIWndSetInactiveTimer(hWnd,inactive) (VOID)MCIWndSM(hWnd,MCIWNDM_SETINACTIVETIMER,(WPARAM)(UINT)(inactive),0L)
#define MCIWndSetTimers(hWnd,active,inactive) (VOID)MCIWndSM(hWnd,MCIWNDM_SETTIMERS,(WPARAM)(UINT)(active),(LPARAM)(UINT)(inactive))
#define MCIWndGetActiveTimer(hWnd) (UINT)MCIWndSM(hWnd,MCIWNDM_GETACTIVETIMER,0,0L);
#define MCIWndGetInactiveTimer(hWnd) (UINT)MCIWndSM(hWnd,MCIWNDM_GETINACTIVETIMER,0,0L);
#define MCIWndRealize(hWnd,fBkgnd) (LONG)MCIWndSM(hWnd,MCIWNDM_REALIZE,(WPARAM)(BOOL)(fBkgnd),0)
#define MCIWndSendString(hWnd,sz) (LONG)MCIWndSM(hWnd,MCIWNDM_SENDSTRING,0,(LPARAM)(LPTSTR)(sz))
#define MCIWndReturnString(hWnd,lp,len) (LONG)MCIWndSM(hWnd,MCIWNDM_RETURNSTRING,(WPARAM)(UINT)(len),(LPARAM)(LPVOID)(lp))
#define MCIWndGetError(hWnd,lp,len) (LONG)MCIWndSM(hWnd,MCIWNDM_GETERROR,(WPARAM)(UINT)(len),(LPARAM)(LPVOID)(lp))
#define MCIWndGetPalette(hWnd) (HPALETTE)MCIWndSM(hWnd,MCIWNDM_GETPALETTE,0,0)
#define MCIWndSetPalette(hWnd,hpal) (LONG)MCIWndSM(hWnd,MCIWNDM_SETPALETTE,(WPARAM)(HPALETTE)(hpal),0)
#define MCIWndGetFileName(hWnd,lp,len) (LONG)MCIWndSM(hWnd,MCIWNDM_GETFILENAME,(WPARAM)(UINT)(len),(LPARAM)(LPVOID)(lp))
#define MCIWndGetDevice(hWnd,lp,len) (LONG)MCIWndSM(hWnd,MCIWNDM_GETDEVICE,(WPARAM)(UINT)(len),(LPARAM)(LPVOID)(lp))
#define MCIWndGetStyles(hWnd) (UINT)MCIWndSM(hWnd,MCIWNDM_GETSTYLES,0,0L)
#define MCIWndChangeStyles(hWnd,mask,value) (LONG)MCIWndSM(hWnd,MCIWNDM_CHANGESTYLES,(WPARAM)(UINT)(mask),(LPARAM)(LONG)(value))
#define MCIWndOpenInterface(hWnd,pUnk) (LONG)MCIWndSM(hWnd,MCIWNDM_OPENINTERFACE,0,(LPARAM)(LPUNKNOWN)(pUnk))
#define MCIWndSetOwner(hWnd,hWndP) (LONG)MCIWndSM(hWnd,MCIWNDM_SETOWNER,(WPARAM)(hWndP),0)
#define DrawDibUpdate(hdd,hdc,x,y) DrawDibDraw(hdd,hdc,x,y,0,0,NULL,NULL,0,0,0,0,DDF_UPDATE)
''!!!FIXME!!! !!!WRITEME!!! !!!FINISHME!!!
#endif

#endif
