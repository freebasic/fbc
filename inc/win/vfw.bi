'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "avifil32"
#inclib "avicap32"
#inclib "uuid"
#inclib "vfw32"

#include once "_mingw_unicode.bi"
#include once "mmreg.bi"
#include once "ole2.bi"
#include once "msacm.bi"

extern "Windows"

#define _INC_VFW
declare function VideoForWindowsVersion() as DWORD
declare function InitVFW() as LONG
declare function TermVFW() as LONG
#define MKFOURCC(ch0, ch1, ch2, ch3) (((cast(DWORD, cast(UBYTE, (ch0))) or (cast(DWORD, cast(UBYTE, (ch1))) shl 8)) or (cast(DWORD, cast(UBYTE, (ch2))) shl 16)) or (cast(DWORD, cast(UBYTE, (ch3))) shl 24))
const ICVERSION = &h0104

type HIC__
	unused as long
end type

type HIC as HIC__ ptr
const BI_1632 = &h32333631
#define aviTWOCC(ch0, ch1) (cast(WORD, cast(UBYTE, (ch0))) or (cast(WORD, cast(UBYTE, (ch1))) shl 8))
const ICERR_OK = 0
const ICERR_DONTDRAW = 1
const ICERR_NEWPALETTE = 2
const ICERR_GOTOKEYFRAME = 3
const ICERR_STOPDRAWING = 4
const ICERR_UNSUPPORTED = -1
const ICERR_BADFORMAT = -2
const ICERR_MEMORY = -3
const ICERR_INTERNAL = -4
const ICERR_BADFLAGS = -5
const ICERR_BADPARAM = -6
const ICERR_BADSIZE = -7
const ICERR_BADHANDLE = -8
const ICERR_CANTUPDATE = -9
const ICERR_ABORT = -10
const ICERR_ERROR = -100
const ICERR_BADBITDEPTH = -200
const ICERR_BADIMAGESIZE = -201
const ICERR_CUSTOM = -400
const ICMODE_COMPRESS = 1
const ICMODE_DECOMPRESS = 2
const ICMODE_FASTDECOMPRESS = 3
const ICMODE_QUERY = 4
const ICMODE_FASTCOMPRESS = 5
const ICMODE_DRAW = 8
const AVIIF_LIST = &h00000001
const AVIIF_TWOCC = &h00000002
const AVIIF_KEYFRAME = &h00000010
const ICQUALITY_LOW = 0
const ICQUALITY_HIGH = 10000
const ICQUALITY_DEFAULT = -1
const ICM_USER = DRV_USER + &h0000
const ICM_RESERVED_LOW = DRV_USER + &h1000
const ICM_RESERVED = ICM_RESERVED_LOW
const ICM_RESERVED_HIGH = DRV_USER + &h2000
const ICM_GETSTATE = ICM_RESERVED + 0
const ICM_SETSTATE = ICM_RESERVED + 1
const ICM_GETINFO = ICM_RESERVED + 2
const ICM_CONFIGURE = ICM_RESERVED + 10
const ICM_ABOUT = ICM_RESERVED + 11
const ICM_GETERRORTEXT = ICM_RESERVED + 12
const ICM_GETFORMATNAME = ICM_RESERVED + 20
const ICM_ENUMFORMATS = ICM_RESERVED + 21
const ICM_GETDEFAULTQUALITY = ICM_RESERVED + 30
const ICM_GETQUALITY = ICM_RESERVED + 31
const ICM_SETQUALITY = ICM_RESERVED + 32
const ICM_SET = ICM_RESERVED + 40
const ICM_GET = ICM_RESERVED + 41
#define ICM_FRAMERATE mmioFOURCC(asc("F"), asc("r"), asc("m"), asc("R"))
#define ICM_KEYFRAMERATE mmioFOURCC(asc("K"), asc("e"), asc("y"), asc("R"))
const ICM_COMPRESS_GET_FORMAT = ICM_USER + 4
const ICM_COMPRESS_GET_SIZE = ICM_USER + 5
const ICM_COMPRESS_QUERY = ICM_USER + 6
const ICM_COMPRESS_BEGIN = ICM_USER + 7
const ICM_COMPRESS = ICM_USER + 8
const ICM_COMPRESS_END = ICM_USER + 9
const ICM_DECOMPRESS_GET_FORMAT = ICM_USER + 10
const ICM_DECOMPRESS_QUERY = ICM_USER + 11
const ICM_DECOMPRESS_BEGIN = ICM_USER + 12
const ICM_DECOMPRESS = ICM_USER + 13
const ICM_DECOMPRESS_END = ICM_USER + 14
const ICM_DECOMPRESS_SET_PALETTE = ICM_USER + 29
const ICM_DECOMPRESS_GET_PALETTE = ICM_USER + 30
const ICM_DRAW_QUERY = ICM_USER + 31
const ICM_DRAW_BEGIN = ICM_USER + 15
const ICM_DRAW_GET_PALETTE = ICM_USER + 16
const ICM_DRAW_UPDATE = ICM_USER + 17
const ICM_DRAW_START = ICM_USER + 18
const ICM_DRAW_STOP = ICM_USER + 19
const ICM_DRAW_BITS = ICM_USER + 20
const ICM_DRAW_END = ICM_USER + 21
const ICM_DRAW_GETTIME = ICM_USER + 32
const ICM_DRAW = ICM_USER + 33
const ICM_DRAW_WINDOW = ICM_USER + 34
const ICM_DRAW_SETTIME = ICM_USER + 35
const ICM_DRAW_REALIZE = ICM_USER + 36
const ICM_DRAW_FLUSH = ICM_USER + 37
const ICM_DRAW_RENDERBUFFER = ICM_USER + 38
const ICM_DRAW_START_PLAY = ICM_USER + 39
const ICM_DRAW_STOP_PLAY = ICM_USER + 40
const ICM_DRAW_SUGGESTFORMAT = ICM_USER + 50
const ICM_DRAW_CHANGEPALETTE = ICM_USER + 51
const ICM_DRAW_IDLE = ICM_USER + 52
const ICM_GETBUFFERSWANTED = ICM_USER + 41
const ICM_GETDEFAULTKEYFRAMERATE = ICM_USER + 42
const ICM_DECOMPRESSEX_BEGIN = ICM_USER + 60
const ICM_DECOMPRESSEX_QUERY = ICM_USER + 61
const ICM_DECOMPRESSEX = ICM_USER + 62
const ICM_DECOMPRESSEX_END = ICM_USER + 63
const ICM_COMPRESS_FRAMES_INFO = ICM_USER + 70
const ICM_COMPRESS_FRAMES = ICM_USER + 71
const ICM_SET_STATUS_PROC = ICM_USER + 72

type ICOPEN
	dwSize as DWORD
	fccType as DWORD
	fccHandler as DWORD
	dwVersion as DWORD
	dwFlags as DWORD
	dwError as LRESULT
	pV1Reserved as LPVOID
	pV2Reserved as LPVOID
	dnDevNode as DWORD
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

const VIDCF_QUALITY = &h0001
const VIDCF_CRUNCH = &h0002
const VIDCF_TEMPORAL = &h0004
const VIDCF_COMPRESSFRAMES = &h0008
const VIDCF_DRAW = &h0010
const VIDCF_FASTTEMPORALC = &h0020
const VIDCF_QUALITYTIME = &h0040
const VIDCF_FASTTEMPORALD = &h0080
const VIDCF_FASTTEMPORAL = VIDCF_FASTTEMPORALC or VIDCF_FASTTEMPORALD
const ICCOMPRESS_KEYFRAME = &h00000001

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

const ICCOMPRESSFRAMES_PADDING = &h00000001

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
	GetData as function(byval lInput as LPARAM, byval lFrame as LONG, byval lpBits as LPVOID, byval len as LONG) as LONG
	PutData as function(byval lOutput as LPARAM, byval lFrame as LONG, byval lpBits as LPVOID, byval len as LONG) as LONG
end type

const ICSTATUS_START = 0
const ICSTATUS_STATUS = 1
const ICSTATUS_END = 2
const ICSTATUS_ERROR = 3
const ICSTATUS_YIELD = 4

type ICSETSTATUSPROC
	dwFlags as DWORD
	lParam as LPARAM
	Status as function(byval lParam as LPARAM, byval message as UINT, byval l as LONG) as LONG
end type

const ICDECOMPRESS_HURRYUP = &h80000000
const ICDECOMPRESS_UPDATE = &h40000000
const ICDECOMPRESS_PREROLL = &h20000000
const ICDECOMPRESS_NULLFRAME = &h10000000
const ICDECOMPRESS_NOTKEYFRAME = &h08000000

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
	xDst as long
	yDst as long
	dxDst as long
	dyDst as long
	xSrc as long
	ySrc as long
	dxSrc as long
	dySrc as long
end type

const ICDRAW_QUERY = &h00000001
const ICDRAW_FULLSCREEN = &h00000002
const ICDRAW_HDC = &h00000004
const ICDRAW_ANIMATE = &h00000008
const ICDRAW_CONTINUE = &h00000010
const ICDRAW_MEMORYDC = &h00000020
const ICDRAW_UPDATING = &h00000040
const ICDRAW_RENDER = &h00000080
const ICDRAW_BUFFER = &h00000100

type ICDRAWBEGIN
	dwFlags as DWORD
	hpal as HPALETTE
	hwnd as HWND
	hdc as HDC
	xDst as long
	yDst as long
	dxDst as long
	dyDst as long
	lpbi as LPBITMAPINFOHEADER
	xSrc as long
	ySrc as long
	dxSrc as long
	dySrc as long
	dwRate as DWORD
	dwScale as DWORD
end type

const ICDRAW_HURRYUP = &h80000000
const ICDRAW_UPDATE = &h40000000
const ICDRAW_PREROLL = &h20000000
const ICDRAW_NULLFRAME = &h10000000
const ICDRAW_NOTKEYFRAME = &h08000000

type ICDRAW
	dwFlags as DWORD
	lpFormat as LPVOID
	lpData as LPVOID
	cbData as DWORD
	lTime as LONG
end type

type ICDRAWSUGGEST
	lpbiIn as LPBITMAPINFOHEADER
	lpbiSuggest as LPBITMAPINFOHEADER
	dxSrc as long
	dySrc as long
	dxDst as long
	dyDst as long
	hicDecompressor as HIC
end type

type ICPALETTE
	dwFlags as DWORD
	iStart as long
	iLen as long
	lppe as LPPALETTEENTRY
end type

declare function ICInfo(byval fccType as DWORD, byval fccHandler as DWORD, byval lpicinfo as ICINFO ptr) as WINBOOL
declare function ICInstall(byval fccType as DWORD, byval fccHandler as DWORD, byval lParam as LPARAM, byval szDesc as LPSTR, byval wFlags as UINT) as WINBOOL
declare function ICRemove(byval fccType as DWORD, byval fccHandler as DWORD, byval wFlags as UINT) as WINBOOL
declare function ICGetInfo(byval hic as HIC, byval picinfo as ICINFO ptr, byval cb as DWORD) as LRESULT
declare function ICOpen(byval fccType as DWORD, byval fccHandler as DWORD, byval wMode as UINT) as HIC
declare function ICOpenFunction(byval fccType as DWORD, byval fccHandler as DWORD, byval wMode as UINT, byval lpfnHandler as FARPROC) as HIC
declare function ICClose(byval hic as HIC) as LRESULT
declare function ICSendMessage(byval hic as HIC, byval msg as UINT, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR) as LRESULT

const ICINSTALL_UNICODE = &h8000
const ICINSTALL_FUNCTION = &h0001
const ICINSTALL_DRIVER = &h0002
const ICINSTALL_HDRV = &h0004
const ICINSTALL_DRIVERW = &h8002
const ICMF_CONFIGURE_QUERY = &h00000001
const ICMF_ABOUT_QUERY = &h00000001
#define ICQueryAbout(hic) (ICSendMessage(hic, ICM_ABOUT, cast(DWORD_PTR, -1), ICMF_ABOUT_QUERY) = ICERR_OK)
#define ICAbout(hic, hwnd) ICSendMessage(hic, ICM_ABOUT, cast(DWORD_PTR, cast(UINT_PTR, (hwnd))), cast(DWORD_PTR, 0))
#define ICQueryConfigure(hic) (ICSendMessage(hic, ICM_CONFIGURE, cast(DWORD_PTR, -1), ICMF_CONFIGURE_QUERY) = ICERR_OK)
#define ICConfigure(hic, hwnd) ICSendMessage(hic, ICM_CONFIGURE, cast(DWORD_PTR, cast(UINT_PTR, (hwnd))), cast(DWORD_PTR, 0))
#define ICGetState(hic, pv, cb) ICSendMessage(hic, ICM_GETSTATE, cast(DWORD_PTR, cast(LPVOID, (pv))), cast(DWORD_PTR, (cb)))
#define ICSetState(hic, pv, cb) ICSendMessage(hic, ICM_SETSTATE, cast(DWORD_PTR, cast(LPVOID, (pv))), cast(DWORD_PTR, (cb)))
#define ICGetStateSize(hic) cast(DWORD, ICGetState(hic, NULL, 0))

dim shared dwICValue as DWORD

private function ICGetDefaultQuality(byval hic as HIC) as DWORD
	ICSendMessage(hic, ICM_GETDEFAULTQUALITY, cast(DWORD_PTR, cast(LPVOID, @dwICValue)), sizeof(DWORD))
	function = dwICValue
end function

private function ICGetDefaultKeyFrameRate(byval hic as HIC) as DWORD
	ICSendMessage(hic, ICM_GETDEFAULTKEYFRAMERATE, cast(DWORD_PTR, cast(LPVOID, @dwICValue)), sizeof(DWORD))
	function = dwICValue
end function

#define ICDrawWindow(hic, prc) ICSendMessage(hic, ICM_DRAW_WINDOW, cast(DWORD_PTR, cast(LPVOID, (prc))), sizeof(RECT))
declare function ICCompress cdecl(byval hic as HIC, byval dwFlags as DWORD, byval lpbiOutput as LPBITMAPINFOHEADER, byval lpData as LPVOID, byval lpbiInput as LPBITMAPINFOHEADER, byval lpBits as LPVOID, byval lpckid as LPDWORD, byval lpdwFlags as LPDWORD, byval lFrameNum as LONG, byval dwFrameSize as DWORD, byval dwQuality as DWORD, byval lpbiPrev as LPBITMAPINFOHEADER, byval lpPrev as LPVOID) as DWORD
#define ICCompressBegin(hic, lpbiInput, lpbiOutput) ICSendMessage(hic, ICM_COMPRESS_BEGIN, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD_PTR, cast(LPVOID, (lpbiOutput))))
#define ICCompressQuery(hic, lpbiInput, lpbiOutput) ICSendMessage(hic, ICM_COMPRESS_QUERY, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD_PTR, cast(LPVOID, (lpbiOutput))))
#define ICCompressGetFormat(hic, lpbiInput, lpbiOutput) ICSendMessage(hic, ICM_COMPRESS_GET_FORMAT, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD_PTR, cast(LPVOID, (lpbiOutput))))
#define ICCompressGetFormatSize(hic, lpbi) cast(DWORD, ICCompressGetFormat(hic, lpbi, NULL))
#define ICCompressGetSize(hic, lpbiInput, lpbiOutput) cast(DWORD, ICSendMessage(hic, ICM_COMPRESS_GET_SIZE, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD_PTR, cast(LPVOID, (lpbiOutput)))))
#define ICCompressEnd(hic) ICSendMessage(hic, ICM_COMPRESS_END, cast(DWORD_PTR, 0), cast(DWORD_PTR, 0))
const ICDECOMPRESS_HURRYUP = &h80000000
declare function ICDecompress cdecl(byval hic as HIC, byval dwFlags as DWORD, byval lpbiFormat as LPBITMAPINFOHEADER, byval lpData as LPVOID, byval lpbi as LPBITMAPINFOHEADER, byval lpBits as LPVOID) as DWORD
#define ICDecompressBegin(hic, lpbiInput, lpbiOutput) ICSendMessage(hic, ICM_DECOMPRESS_BEGIN, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD_PTR, cast(LPVOID, (lpbiOutput))))
#define ICDecompressQuery(hic, lpbiInput, lpbiOutput) ICSendMessage(hic, ICM_DECOMPRESS_QUERY, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD_PTR, cast(LPVOID, (lpbiOutput))))
#define ICDecompressGetFormat(hic, lpbiInput, lpbiOutput) cast(LONG, ICSendMessage(hic, ICM_DECOMPRESS_GET_FORMAT, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD_PTR, cast(LPVOID, (lpbiOutput)))))
#define ICDecompressGetFormatSize(hic, lpbi) ICDecompressGetFormat(hic, lpbi, NULL)
#define ICDecompressGetPalette(hic, lpbiInput, lpbiOutput) ICSendMessage(hic, ICM_DECOMPRESS_GET_PALETTE, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD_PTR, cast(LPVOID, (lpbiOutput))))
#define ICDecompressSetPalette(hic, lpbiPalette) ICSendMessage(hic, ICM_DECOMPRESS_SET_PALETTE, cast(DWORD_PTR, cast(LPVOID, (lpbiPalette))), cast(DWORD_PTR, 0))
#define ICDecompressEnd(hic) ICSendMessage(hic, ICM_DECOMPRESS_END, cast(DWORD_PTR, 0), cast(DWORD_PTR, 0))
#define ICDecompressExEnd(hic) ICSendMessage(hic, ICM_DECOMPRESSEX_END, cast(DWORD_PTR, 0), cast(DWORD_PTR, 0))
const ICDRAW_QUERY = &h00000001
const ICDRAW_FULLSCREEN = &h00000002
const ICDRAW_HDC = &h00000004
declare function ICDrawBegin cdecl(byval hic as HIC, byval dwFlags as DWORD, byval hpal as HPALETTE, byval hwnd as HWND, byval hdc as HDC, byval xDst as long, byval yDst as long, byval dxDst as long, byval dyDst as long, byval lpbi as LPBITMAPINFOHEADER, byval xSrc as long, byval ySrc as long, byval dxSrc as long, byval dySrc as long, byval dwRate as DWORD, byval dwScale as DWORD) as DWORD
const ICDRAW_HURRYUP = &h80000000
const ICDRAW_UPDATE = &h40000000
declare function ICDraw cdecl(byval hic as HIC, byval dwFlags as DWORD, byval lpFormat as LPVOID, byval lpData as LPVOID, byval cbData as DWORD, byval lTime as LONG) as DWORD
#define ICDrawQuery(hic, lpbiInput) ICSendMessage(hic, ICM_DRAW_QUERY, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD, 0))
#define ICDrawChangePalette(hic, lpbiInput) ICSendMessage(hic, ICM_DRAW_CHANGEPALETTE, cast(DWORD_PTR, cast(LPVOID, (lpbiInput))), cast(DWORD, 0))
#define ICGetBuffersWanted(hic, lpdwBuffers) ICSendMessage(hic, ICM_GETBUFFERSWANTED, cast(DWORD_PTR, cast(LPVOID, (lpdwBuffers))), cast(DWORD_PTR, 0))
#define ICDrawEnd(hic) ICSendMessage(hic, ICM_DRAW_END, cast(DWORD_PTR, 0), cast(DWORD_PTR, 0))
#define ICDrawStart(hic) ICSendMessage(hic, ICM_DRAW_START, cast(DWORD_PTR, 0), cast(DWORD_PTR, 0))
#define ICDrawStartPlay(hic, lFrom, lTo) ICSendMessage(hic, ICM_DRAW_START_PLAY, cast(DWORD_PTR, (lFrom)), cast(DWORD_PTR, (lTo)))
#define ICDrawStop(hic) ICSendMessage(hic, ICM_DRAW_STOP, cast(DWORD_PTR, 0), cast(DWORD_PTR, 0))
#define ICDrawStopPlay(hic) ICSendMessage(hic, ICM_DRAW_STOP_PLAY, cast(DWORD_PTR, 0), cast(DWORD_PTR, 0))
#define ICDrawGetTime(hic, lplTime) ICSendMessage(hic, ICM_DRAW_GETTIME, cast(DWORD_PTR, cast(LPVOID, (lplTime))), cast(DWORD_PTR, 0))
#define ICDrawSetTime(hic, lTime) ICSendMessage(hic, ICM_DRAW_SETTIME, cast(DWORD_PTR, lTime), cast(DWORD_PTR, 0))
#define ICDrawRealize(hic, hdc_, fBackground) ICSendMessage(hic, ICM_DRAW_REALIZE, cast(DWORD_PTR, cast(UINT_PTR, cast(HDC, (hdc_)))), cast(DWORD_PTR, cast(WINBOOL, (fBackground))))
#define ICDrawFlush(hic) ICSendMessage(hic, ICM_DRAW_FLUSH, cast(DWORD_PTR, 0), cast(DWORD_PTR, 0))
#define ICDrawRenderBuffer(hic) ICSendMessage(hic, ICM_DRAW_RENDERBUFFER, cast(DWORD_PTR, 0), cast(DWORD_PTR, 0))
#define ICDecompressOpen(fccType, fccHandler, lpbiIn, lpbiOut) ICLocate(fccType, fccHandler, lpbiIn, lpbiOut, ICMODE_DECOMPRESS)
#define ICDrawOpen(fccType, fccHandler, lpbiIn) ICLocate(fccType, fccHandler, lpbiIn, NULL, ICMODE_DRAW)

declare function ICLocate(byval fccType as DWORD, byval fccHandler as DWORD, byval lpbiIn as LPBITMAPINFOHEADER, byval lpbiOut as LPBITMAPINFOHEADER, byval wFlags as WORD) as HIC
declare function ICGetDisplayFormat(byval hic as HIC, byval lpbiIn as LPBITMAPINFOHEADER, byval lpbiOut as LPBITMAPINFOHEADER, byval BitDepth as long, byval dx as long, byval dy as long) as HIC
declare function ICImageCompress(byval hic as HIC, byval uiFlags as UINT, byval lpbiIn as LPBITMAPINFO, byval lpBits as LPVOID, byval lpbiOut as LPBITMAPINFO, byval lQuality as LONG, byval plSize as LONG ptr) as HANDLE
declare function ICImageDecompress(byval hic as HIC, byval uiFlags as UINT, byval lpbiIn as LPBITMAPINFO, byval lpBits as LPVOID, byval lpbiOut as LPBITMAPINFO) as HANDLE

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
const ICMF_COMPVARS_VALID = &h00000001
declare function ICCompressorChoose(byval hwnd as HWND, byval uiFlags as UINT, byval pvIn as LPVOID, byval lpData as LPVOID, byval pc as PCOMPVARS, byval lpszTitle as LPSTR) as WINBOOL
const ICMF_CHOOSE_KEYFRAME = &h0001
const ICMF_CHOOSE_DATARATE = &h0002
const ICMF_CHOOSE_PREVIEW = &h0004
const ICMF_CHOOSE_ALLCOMPRESSORS = &h0008

declare function ICSeqCompressFrameStart(byval pc as PCOMPVARS, byval lpbiIn as LPBITMAPINFO) as WINBOOL
declare sub ICSeqCompressFrameEnd(byval pc as PCOMPVARS)
declare function ICSeqCompressFrame(byval pc as PCOMPVARS, byval uiFlags as UINT, byval lpBits as LPVOID, byval pfKey as WINBOOL ptr, byval plSize as LONG ptr) as LPVOID
declare sub ICCompressorFree(byval pc as PCOMPVARS)
type HDRAWDIB as HANDLE

const DDF_0001 = &h0001
const DDF_UPDATE = &h0002
const DDF_SAME_HDC = &h0004
const DDF_SAME_DRAW = &h0008
const DDF_DONTDRAW = &h0010
const DDF_ANIMATE = &h0020
const DDF_BUFFER = &h0040
const DDF_JUSTDRAWIT = &h0080
const DDF_FULLSCREEN = &h0100
const DDF_BACKGROUNDPAL = &h0200
const DDF_NOTKEYFRAME = &h0400
const DDF_HURRYUP = &h0800
const DDF_HALFTONE = &h1000
const DDF_2000 = &h2000
const DDF_PREROLL = DDF_DONTDRAW
const DDF_SAME_DIB = DDF_SAME_DRAW
const DDF_SAME_SIZE = DDF_SAME_DRAW

declare function DrawDibInit() as WINBOOL
declare function DrawDibOpen() as HDRAWDIB
declare function DrawDibClose(byval hdd as HDRAWDIB) as WINBOOL
declare function DrawDibGetBuffer(byval hdd as HDRAWDIB, byval lpbi as LPBITMAPINFOHEADER, byval dwSize as DWORD, byval dwFlags as DWORD) as LPVOID
declare function DrawDibError(byval hdd as HDRAWDIB) as UINT
declare function DrawDibGetPalette(byval hdd as HDRAWDIB) as HPALETTE
declare function DrawDibSetPalette(byval hdd as HDRAWDIB, byval hpal as HPALETTE) as WINBOOL
declare function DrawDibChangePalette(byval hdd as HDRAWDIB, byval iStart as long, byval iLen as long, byval lppe as LPPALETTEENTRY) as WINBOOL
declare function DrawDibRealize(byval hdd as HDRAWDIB, byval hdc as HDC, byval fBackground as WINBOOL) as UINT
declare function DrawDibStart(byval hdd as HDRAWDIB, byval rate as DWORD) as WINBOOL
declare function DrawDibStop(byval hdd as HDRAWDIB) as WINBOOL
declare function DrawDibBegin(byval hdd as HDRAWDIB, byval hdc as HDC, byval dxDst as long, byval dyDst as long, byval lpbi as LPBITMAPINFOHEADER, byval dxSrc as long, byval dySrc as long, byval wFlags as UINT) as WINBOOL
declare function DrawDibDraw(byval hdd as HDRAWDIB, byval hdc as HDC, byval xDst as long, byval yDst as long, byval dxDst as long, byval dyDst as long, byval lpbi as LPBITMAPINFOHEADER, byval lpBits as LPVOID, byval xSrc as long, byval ySrc as long, byval dxSrc as long, byval dySrc as long, byval wFlags as UINT) as WINBOOL
#define DrawDibUpdate(hdd, hdc, x, y) DrawDibDraw(hdd, hdc, x, y, 0, 0, NULL, NULL, 0, 0, 0, 0, DDF_UPDATE)
declare function DrawDibEnd(byval hdd as HDRAWDIB) as WINBOOL

type DRAWDIBTIME
	timeCount as LONG
	timeDraw as LONG
	timeDecompress as LONG
	timeDither as LONG
	timeStretch as LONG
	timeBlt as LONG
	timeSetDIBits as LONG
end type

type LPDRAWDIBTIME as DRAWDIBTIME ptr
declare function DrawDibTime(byval hdd as HDRAWDIB, byval lpddtime as LPDRAWDIBTIME) as WINBOOL
const PD_CAN_DRAW_DIB = &h0001
const PD_CAN_STRETCHDIB = &h0002
const PD_STRETCHDIB_1_1_OK = &h0004
const PD_STRETCHDIB_1_2_OK = &h0008
const PD_STRETCHDIB_1_N_OK = &h0010
declare function DrawDibProfileDisplay(byval lpbi as LPBITMAPINFOHEADER) as LRESULT
type TWOCC as WORD
#define formtypeAVI mmioFOURCC(asc("A"), asc("V"), asc("I"), asc(" "))
#define listtypeAVIHEADER mmioFOURCC(asc("h"), asc("d"), asc("r"), asc("l"))
#define ckidAVIMAINHDR mmioFOURCC(asc("a"), asc("v"), asc("i"), asc("h"))
#define listtypeSTREAMHEADER mmioFOURCC(asc("s"), asc("t"), asc("r"), asc("l"))
#define ckidSTREAMHEADER mmioFOURCC(asc("s"), asc("t"), asc("r"), asc("h"))
#define ckidSTREAMFORMAT mmioFOURCC(asc("s"), asc("t"), asc("r"), asc("f"))
#define ckidSTREAMHANDLERDATA mmioFOURCC(asc("s"), asc("t"), asc("r"), asc("d"))
#define ckidSTREAMNAME mmioFOURCC(asc("s"), asc("t"), asc("r"), asc("n"))
#define listtypeAVIMOVIE mmioFOURCC(asc("m"), asc("o"), asc("v"), asc("i"))
#define listtypeAVIRECORD mmioFOURCC(asc("r"), asc("e"), asc("c"), asc(" "))
#define ckidAVINEWINDEX mmioFOURCC(asc("i"), asc("d"), asc("x"), asc("1"))
const streamtypeANY = 0u
#define streamtypeVIDEO mmioFOURCC(asc("v"), asc("i"), asc("d"), asc("s"))
#define streamtypeAUDIO mmioFOURCC(asc("a"), asc("u"), asc("d"), asc("s"))
#define streamtypeMIDI mmioFOURCC(asc("m"), asc("i"), asc("d"), asc("s"))
#define streamtypeTEXT mmioFOURCC(asc("t"), asc("x"), asc("t"), asc("s"))
#define cktypeDIBbits aviTWOCC(asc("d"), asc("b"))
#define cktypeDIBcompressed aviTWOCC(asc("d"), asc("c"))
#define cktypePALchange aviTWOCC(asc("p"), asc("c"))
#define cktypeWAVEbytes aviTWOCC(asc("w"), asc("b"))
#define ckidAVIPADDING mmioFOURCC(asc("J"), asc("U"), asc("N"), asc("K"))
#define FromHex(n) iif((n) >= asc("A"), ((n) + 10) - asc("A"), (n) - asc("0"))
#define StreamFromFOURCC(fcc) cast(WORD, (FromHex(LOBYTE(LOWORD(fcc))) shl 4) + FromHex(HIBYTE(LOWORD(fcc))))
#define TWOCCFromFOURCC(fcc) HIWORD(fcc)
#define ToHex(n) cast(UBYTE, iif((n) > 9, ((n) - 10) + asc("A"), (n) + asc("0")))
#define MAKEAVICKID(tcc, stream) MAKELONG((ToHex((stream) and &h0f) shl 8) or ToHex(((stream) and &hf0) shr 4), tcc)
const AVIF_HASINDEX = &h00000010
const AVIF_MUSTUSEINDEX = &h00000020
const AVIF_ISINTERLEAVED = &h00000100
const AVIF_TRUSTCKTYPE = &h00000800
const AVIF_WASCAPTUREFILE = &h00010000
const AVIF_COPYRIGHTED = &h00020000
const AVI_HEADERSIZE = 2048

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
	dwReserved(0 to 3) as DWORD
end type

const AVISF_DISABLED = &h00000001
const AVISF_VIDEO_PALCHANGES = &h00010000

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

const AVIIF_LIST = &h00000001
const AVIIF_KEYFRAME = &h00000010
const AVIIF_FIRSTPART = &h00000020
const AVIIF_LASTPART = &h00000040
const AVIIF_MIDPART = AVIIF_LASTPART or AVIIF_FIRSTPART
const AVIIF_NOTIME = &h00000100
const AVIIF_COMPUSE = &h0FFF0000

type AVIINDEXENTRY
	ckid as DWORD
	dwFlags as DWORD
	dwChunkOffset as DWORD
	dwChunkLength as DWORD
end type

type AVIPALCHANGE
	bFirstEntry as UBYTE
	bNumEntries as UBYTE
	wFlags as WORD
	peNew(0 to 0) as PALETTEENTRY
end type

const AVIGETFRAMEF_BESTDISPLAYFMT = 1

type _AVISTREAMINFOW
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

type AVISTREAMINFOW as _AVISTREAMINFOW
type LPAVISTREAMINFOW as _AVISTREAMINFOW ptr

type _AVISTREAMINFOA
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

type AVISTREAMINFOA as _AVISTREAMINFOA
type LPAVISTREAMINFOA as _AVISTREAMINFOA ptr

#ifdef UNICODE
	type AVISTREAMINFO as AVISTREAMINFOW
	type LPAVISTREAMINFO as LPAVISTREAMINFOW
#else
	type AVISTREAMINFO as AVISTREAMINFOA
	type LPAVISTREAMINFO as LPAVISTREAMINFOA
#endif

const AVISTREAMINFO_DISABLED = &h00000001
const AVISTREAMINFO_FORMATCHANGES = &h00010000

type _AVIFILEINFOW
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

type AVIFILEINFOW as _AVIFILEINFOW
type LPAVIFILEINFOW as _AVIFILEINFOW ptr

type _AVIFILEINFOA
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

type AVIFILEINFOA as _AVIFILEINFOA
type LPAVIFILEINFOA as _AVIFILEINFOA ptr

#ifdef UNICODE
	type AVIFILEINFO as AVIFILEINFOW
	type LPAVIFILEINFO as LPAVIFILEINFOW
#else
	type AVIFILEINFO as AVIFILEINFOA
	type LPAVIFILEINFO as LPAVIFILEINFOA
#endif

const AVIFILEINFO_HASINDEX = &h00000010
const AVIFILEINFO_MUSTUSEINDEX = &h00000020
const AVIFILEINFO_ISINTERLEAVED = &h00000100
const AVIFILEINFO_TRUSTCKTYPE = &h00000800
const AVIFILEINFO_WASCAPTUREFILE = &h00010000
const AVIFILEINFO_COPYRIGHTED = &h00020000
const AVIFILECAPS_CANREAD = &h00000001
const AVIFILECAPS_CANWRITE = &h00000002
const AVIFILECAPS_ALLKEYFRAMES = &h00000010
const AVIFILECAPS_NOCOMPRESSION = &h00000020
type AVISAVECALLBACK as function(byval as long) as WINBOOL

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
const AVICOMPRESSF_INTERLEAVE = &h00000001
const AVICOMPRESSF_DATARATE = &h00000002
const AVICOMPRESSF_KEYFRAMES = &h00000004
const AVICOMPRESSF_VALID = &h00000008
type IAVIStreamVtbl as IAVIStreamVtbl_

type IAVIStream
	lpVtbl as IAVIStreamVtbl ptr
end type

type IAVIStreamVtbl_
	QueryInterface as function(byval This as IAVIStream ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IAVIStream ptr) as ULONG
	Release as function(byval This as IAVIStream ptr) as ULONG
	Create as function(byval This as IAVIStream ptr, byval lParam1 as LPARAM, byval lParam2 as LPARAM) as HRESULT
	Info as function(byval This as IAVIStream ptr, byval psi as AVISTREAMINFOW ptr, byval lSize as LONG) as HRESULT
	FindSample as function(byval This as IAVIStream ptr, byval lPos as LONG, byval lFlags as LONG) as LONG
	ReadFormat as function(byval This as IAVIStream ptr, byval lPos as LONG, byval lpFormat as LPVOID, byval lpcbFormat as LONG ptr) as HRESULT
	SetFormat as function(byval This as IAVIStream ptr, byval lPos as LONG, byval lpFormat as LPVOID, byval cbFormat as LONG) as HRESULT
	Read as function(byval This as IAVIStream ptr, byval lStart as LONG, byval lSamples as LONG, byval lpBuffer as LPVOID, byval cbBuffer as LONG, byval plBytes as LONG ptr, byval plSamples as LONG ptr) as HRESULT
	Write as function(byval This as IAVIStream ptr, byval lStart as LONG, byval lSamples as LONG, byval lpBuffer as LPVOID, byval cbBuffer as LONG, byval dwFlags as DWORD, byval plSampWritten as LONG ptr, byval plBytesWritten as LONG ptr) as HRESULT
	Delete_ as function(byval This as IAVIStream ptr, byval lStart as LONG, byval lSamples as LONG) as HRESULT
	ReadData as function(byval This as IAVIStream ptr, byval fcc as DWORD, byval lp as LPVOID, byval lpcb as LONG ptr) as HRESULT
	WriteData as function(byval This as IAVIStream ptr, byval fcc as DWORD, byval lp as LPVOID, byval cb as LONG) as HRESULT
	SetInfo as function(byval This as IAVIStream ptr, byval lpInfo as AVISTREAMINFOW ptr, byval cbInfo as LONG) as HRESULT
end type

type PAVISTREAM as IAVIStream ptr
type IAVIStreamingVtbl as IAVIStreamingVtbl_

type IAVIStreaming
	lpVtbl as IAVIStreamingVtbl ptr
end type

type IAVIStreamingVtbl_
	QueryInterface as function(byval This as IAVIStreaming ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IAVIStreaming ptr) as ULONG
	Release as function(byval This as IAVIStreaming ptr) as ULONG
	Begin as function(byval This as IAVIStreaming ptr, byval lStart as LONG, byval lEnd as LONG, byval lRate as LONG) as HRESULT
	as function(byval This as IAVIStreaming ptr) as HRESULT End
end type

type PAVISTREAMING as IAVIStreaming ptr
type IAVIEditStreamVtbl as IAVIEditStreamVtbl_

type IAVIEditStream
	lpVtbl as IAVIEditStreamVtbl ptr
end type

type IAVIEditStreamVtbl_
	QueryInterface as function(byval This as IAVIEditStream ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IAVIEditStream ptr) as ULONG
	Release as function(byval This as IAVIEditStream ptr) as ULONG
	Cut as function(byval This as IAVIEditStream ptr, byval plStart as LONG ptr, byval plLength as LONG ptr, byval ppResult as PAVISTREAM ptr) as HRESULT
	Copy as function(byval This as IAVIEditStream ptr, byval plStart as LONG ptr, byval plLength as LONG ptr, byval ppResult as PAVISTREAM ptr) as HRESULT
	Paste as function(byval This as IAVIEditStream ptr, byval plPos as LONG ptr, byval plLength as LONG ptr, byval pstream as PAVISTREAM, byval lStart as LONG, byval lEnd as LONG) as HRESULT
	Clone as function(byval This as IAVIEditStream ptr, byval ppResult as PAVISTREAM ptr) as HRESULT
	SetInfo as function(byval This as IAVIEditStream ptr, byval lpInfo as AVISTREAMINFOW ptr, byval cbInfo as LONG) as HRESULT
end type

type PAVIEDITSTREAM as IAVIEditStream ptr
type IAVIPersistFileVtbl as IAVIPersistFileVtbl_

type IAVIPersistFile
	lpVtbl as IAVIPersistFileVtbl ptr
end type

type IAVIPersistFileVtbl_
	Reserved1 as function(byval This as IAVIPersistFile ptr) as HRESULT
end type

type PAVIPERSISTFILE as IAVIPersistFile ptr
type PAVIFILE as IAVIFile ptr
type IAVIFileVtbl as IAVIFileVtbl_

type IAVIFile
	lpVtbl as IAVIFileVtbl ptr
end type

type IAVIFileVtbl_
	QueryInterface as function(byval This as IAVIFile ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IAVIFile ptr) as ULONG
	Release as function(byval This as IAVIFile ptr) as ULONG
	Info as function(byval This as IAVIFile ptr, byval pfi as AVIFILEINFOW ptr, byval lSize as LONG) as HRESULT
	GetStream as function(byval This as IAVIFile ptr, byval ppStream as PAVISTREAM ptr, byval fccType as DWORD, byval lParam as LONG) as HRESULT
	CreateStream as function(byval This as IAVIFile ptr, byval ppStream as PAVISTREAM ptr, byval psi as AVISTREAMINFOW ptr) as HRESULT
	WriteData as function(byval This as IAVIFile ptr, byval ckid as DWORD, byval lpData as LPVOID, byval cbData as LONG) as HRESULT
	ReadData as function(byval This as IAVIFile ptr, byval ckid as DWORD, byval lpData as LPVOID, byval lpcbData as LONG ptr) as HRESULT
	EndRecord as function(byval This as IAVIFile ptr) as HRESULT
	DeleteStream as function(byval This as IAVIFile ptr, byval fccType as DWORD, byval lParam as LONG) as HRESULT
end type

#undef PAVIFILE
type PAVIFILE as IAVIFile ptr
type PGETFRAME as IGetFrame ptr
type IGetFrameVtbl as IGetFrameVtbl_

type IGetFrame
	lpVtbl as IGetFrameVtbl ptr
end type

type IGetFrameVtbl_
	QueryInterface as function(byval This as IGetFrame ptr, byval riid as const IID const ptr, byval ppvObj as LPVOID ptr) as HRESULT
	AddRef as function(byval This as IGetFrame ptr) as ULONG
	Release as function(byval This as IGetFrame ptr) as ULONG
	GetFrame as function(byval This as IGetFrame ptr, byval lPos as LONG) as LPVOID
	Begin as function(byval This as IGetFrame ptr, byval lStart as LONG, byval lEnd as LONG, byval lRate as LONG) as HRESULT
	as function(byval This as IGetFrame ptr) as HRESULT End
	SetFormat as function(byval This as IGetFrame ptr, byval lpbi as LPBITMAPINFOHEADER, byval lpBits as LPVOID, byval x as long, byval y as long, byval dx as long, byval dy as long) as HRESULT
end type

#undef PGETFRAME
type PGETFRAME as IGetFrame ptr
#define DEFINE_AVIGUID(name, l, w1, w2) DEFINE_GUID(name, l, w1, w2, &hC0, 0, 0, 0, 0, 0, 0, &h46)
extern IID_IAVIFile as const GUID
extern IID_IAVIStream as const GUID
extern IID_IAVIStreaming as const GUID
extern IID_IGetFrame as const GUID
extern IID_IAVIEditStream as const GUID
extern IID_IAVIPersistFile as const GUID

#ifndef UNICODE
	extern CLSID_AVISimpleUnMarshal as const GUID
#endif

extern CLSID_AVIFile as const GUID
const AVIFILEHANDLER_CANREAD = &h0001
const AVIFILEHANDLER_CANWRITE = &h0002
const AVIFILEHANDLER_CANACCEPTNONRGB = &h0004

declare sub AVIFileInit()
declare sub AVIFileExit()
declare function AVIFileAddRef(byval pfile as PAVIFILE) as ULONG
declare function AVIFileRelease(byval pfile as PAVIFILE) as ULONG
declare function AVIFileOpenA(byval ppfile as PAVIFILE ptr, byval szFile as LPCSTR, byval uMode as UINT, byval lpHandler as LPCLSID) as HRESULT

#ifndef UNICODE
	declare function AVIFileOpen alias "AVIFileOpenA"(byval ppfile as PAVIFILE ptr, byval szFile as LPCSTR, byval uMode as UINT, byval lpHandler as LPCLSID) as HRESULT
#endif

declare function AVIFileOpenW(byval ppfile as PAVIFILE ptr, byval szFile as LPCWSTR, byval uMode as UINT, byval lpHandler as LPCLSID) as HRESULT

#ifdef UNICODE
	declare function AVIFileOpen alias "AVIFileOpenW"(byval ppfile as PAVIFILE ptr, byval szFile as LPCWSTR, byval uMode as UINT, byval lpHandler as LPCLSID) as HRESULT
#endif

declare function AVIFileInfoW(byval pfile as PAVIFILE, byval pfi as LPAVIFILEINFOW, byval lSize as LONG) as HRESULT

#ifdef UNICODE
	declare function AVIFileInfo alias "AVIFileInfoW"(byval pfile as PAVIFILE, byval pfi as LPAVIFILEINFOW, byval lSize as LONG) as HRESULT
#endif

declare function AVIFileInfoA(byval pfile as PAVIFILE, byval pfi as LPAVIFILEINFOA, byval lSize as LONG) as HRESULT

#ifndef UNICODE
	declare function AVIFileInfo alias "AVIFileInfoA"(byval pfile as PAVIFILE, byval pfi as LPAVIFILEINFOA, byval lSize as LONG) as HRESULT
#endif

declare function AVIFileGetStream(byval pfile as PAVIFILE, byval ppavi as PAVISTREAM ptr, byval fccType as DWORD, byval lParam as LONG) as HRESULT
declare function AVIFileCreateStreamW(byval pfile as PAVIFILE, byval ppavi as PAVISTREAM ptr, byval psi as AVISTREAMINFOW ptr) as HRESULT

#ifdef UNICODE
	declare function AVIFileCreateStream alias "AVIFileCreateStreamW"(byval pfile as PAVIFILE, byval ppavi as PAVISTREAM ptr, byval psi as AVISTREAMINFOW ptr) as HRESULT
#endif

declare function AVIFileCreateStreamA(byval pfile as PAVIFILE, byval ppavi as PAVISTREAM ptr, byval psi as AVISTREAMINFOA ptr) as HRESULT

#ifndef UNICODE
	declare function AVIFileCreateStream alias "AVIFileCreateStreamA"(byval pfile as PAVIFILE, byval ppavi as PAVISTREAM ptr, byval psi as AVISTREAMINFOA ptr) as HRESULT
#endif

declare function AVIFileWriteData(byval pfile as PAVIFILE, byval ckid as DWORD, byval lpData as LPVOID, byval cbData as LONG) as HRESULT
declare function AVIFileReadData(byval pfile as PAVIFILE, byval ckid as DWORD, byval lpData as LPVOID, byval lpcbData as LONG ptr) as HRESULT
declare function AVIFileEndRecord(byval pfile as PAVIFILE) as HRESULT
declare function AVIStreamAddRef(byval pavi as PAVISTREAM) as ULONG
declare function AVIStreamRelease(byval pavi as PAVISTREAM) as ULONG
declare function AVIStreamInfoW(byval pavi as PAVISTREAM, byval psi as LPAVISTREAMINFOW, byval lSize as LONG) as HRESULT

#ifdef UNICODE
	declare function AVIStreamInfo alias "AVIStreamInfoW"(byval pavi as PAVISTREAM, byval psi as LPAVISTREAMINFOW, byval lSize as LONG) as HRESULT
#endif

declare function AVIStreamInfoA(byval pavi as PAVISTREAM, byval psi as LPAVISTREAMINFOA, byval lSize as LONG) as HRESULT

#ifndef UNICODE
	declare function AVIStreamInfo alias "AVIStreamInfoA"(byval pavi as PAVISTREAM, byval psi as LPAVISTREAMINFOA, byval lSize as LONG) as HRESULT
#endif

declare function AVIStreamFindSample(byval pavi as PAVISTREAM, byval lPos as LONG, byval lFlags as LONG) as LONG
declare function AVIStreamReadFormat(byval pavi as PAVISTREAM, byval lPos as LONG, byval lpFormat as LPVOID, byval lpcbFormat as LONG ptr) as HRESULT
declare function AVIStreamSetFormat(byval pavi as PAVISTREAM, byval lPos as LONG, byval lpFormat as LPVOID, byval cbFormat as LONG) as HRESULT
declare function AVIStreamReadData(byval pavi as PAVISTREAM, byval fcc as DWORD, byval lp as LPVOID, byval lpcb as LONG ptr) as HRESULT
declare function AVIStreamWriteData(byval pavi as PAVISTREAM, byval fcc as DWORD, byval lp as LPVOID, byval cb as LONG) as HRESULT
declare function AVIStreamRead(byval pavi as PAVISTREAM, byval lStart as LONG, byval lSamples as LONG, byval lpBuffer as LPVOID, byval cbBuffer as LONG, byval plBytes as LONG ptr, byval plSamples as LONG ptr) as HRESULT
const AVISTREAMREAD_CONVENIENT = -1
declare function AVIStreamWrite(byval pavi as PAVISTREAM, byval lStart as LONG, byval lSamples as LONG, byval lpBuffer as LPVOID, byval cbBuffer as LONG, byval dwFlags as DWORD, byval plSampWritten as LONG ptr, byval plBytesWritten as LONG ptr) as HRESULT
declare function AVIStreamStart(byval pavi as PAVISTREAM) as LONG
declare function AVIStreamLength(byval pavi as PAVISTREAM) as LONG
declare function AVIStreamTimeToSample(byval pavi as PAVISTREAM, byval lTime as LONG) as LONG
declare function AVIStreamSampleToTime(byval pavi as PAVISTREAM, byval lSample as LONG) as LONG
declare function AVIStreamBeginStreaming(byval pavi as PAVISTREAM, byval lStart as LONG, byval lEnd as LONG, byval lRate as LONG) as HRESULT
declare function AVIStreamEndStreaming(byval pavi as PAVISTREAM) as HRESULT
declare function AVIStreamGetFrameOpen(byval pavi as PAVISTREAM, byval lpbiWanted as LPBITMAPINFOHEADER) as PGETFRAME
declare function AVIStreamGetFrame(byval pg as PGETFRAME, byval lPos as LONG) as LPVOID
declare function AVIStreamGetFrameClose(byval pg as PGETFRAME) as HRESULT
declare function AVIStreamOpenFromFileA(byval ppavi as PAVISTREAM ptr, byval szFile as LPCSTR, byval fccType as DWORD, byval lParam as LONG, byval mode as UINT, byval pclsidHandler as CLSID ptr) as HRESULT

#ifndef UNICODE
	declare function AVIStreamOpenFromFile alias "AVIStreamOpenFromFileA"(byval ppavi as PAVISTREAM ptr, byval szFile as LPCSTR, byval fccType as DWORD, byval lParam as LONG, byval mode as UINT, byval pclsidHandler as CLSID ptr) as HRESULT
#endif

declare function AVIStreamOpenFromFileW(byval ppavi as PAVISTREAM ptr, byval szFile as LPCWSTR, byval fccType as DWORD, byval lParam as LONG, byval mode as UINT, byval pclsidHandler as CLSID ptr) as HRESULT

#ifdef UNICODE
	declare function AVIStreamOpenFromFile alias "AVIStreamOpenFromFileW"(byval ppavi as PAVISTREAM ptr, byval szFile as LPCWSTR, byval fccType as DWORD, byval lParam as LONG, byval mode as UINT, byval pclsidHandler as CLSID ptr) as HRESULT
#endif

declare function AVIStreamCreate(byval ppavi as PAVISTREAM ptr, byval lParam1 as LONG, byval lParam2 as LONG, byval pclsidHandler as CLSID ptr) as HRESULT
const FIND_DIR = &h0000000F
const FIND_NEXT = &h00000001
const FIND_PREV = &h00000004
const FIND_FROM_START = &h00000008
const FIND_TYPE = &h000000F0
const FIND_KEY = &h00000010
const FIND_ANY = &h00000020
const FIND_FORMAT = &h00000040
const FIND_RET = &h0000F000
const FIND_POS = &h00000000
const FIND_LENGTH = &h00001000
const FIND_OFFSET = &h00002000
const FIND_SIZE = &h00003000
const FIND_INDEX = &h00004000
declare function AVIStreamFindKeyFrame alias "AVIStreamFindSample"(byval pavi as PAVISTREAM, byval lPos as LONG, byval lFlags as LONG) as LONG
#define FindKeyFrame FindSample

declare function AVIStreamClose alias "AVIStreamRelease"(byval pavi as PAVISTREAM) as ULONG
declare function AVIFileClose alias "AVIFileRelease"(byval pfile as PAVIFILE) as ULONG
declare sub AVIStreamInit alias "AVIFileInit"()
declare sub AVIStreamExit alias "AVIFileExit"()

const SEARCH_NEAREST = FIND_PREV
const SEARCH_BACKWARD = FIND_PREV
const SEARCH_FORWARD = FIND_NEXT
const SEARCH_KEY = FIND_KEY
const SEARCH_ANY = FIND_ANY
#define AVIStreamSampleToSample(pavi1, pavi2, l) AVIStreamTimeToSample(pavi1, AVIStreamSampleToTime(pavi2, l))
#define AVIStreamNextSample(pavi, l) AVIStreamFindSample(pavi, l + 1, FIND_NEXT or FIND_ANY)
#define AVIStreamPrevSample(pavi, l) AVIStreamFindSample(pavi, l - 1, FIND_PREV or FIND_ANY)
#define AVIStreamNearestSample(pavi, l) AVIStreamFindSample(pavi, l, FIND_PREV or FIND_ANY)
#define AVIStreamNextKeyFrame(pavi, l) AVIStreamFindSample(pavi, l + 1, FIND_NEXT or FIND_KEY)
#define AVIStreamPrevKeyFrame(pavi, l) AVIStreamFindSample(pavi, l - 1, FIND_PREV or FIND_KEY)
#define AVIStreamNearestKeyFrame(pavi, l) AVIStreamFindSample(pavi, l, FIND_PREV or FIND_KEY)
#define AVIStreamIsKeyFrame(pavi, l) (AVIStreamNearestKeyFrame(pavi, l) = l)
#define AVIStreamPrevSampleTime(pavi, t) AVIStreamSampleToTime(pavi, AVIStreamPrevSample(pavi, AVIStreamTimeToSample(pavi, t)))
#define AVIStreamNextSampleTime(pavi, t) AVIStreamSampleToTime(pavi, AVIStreamNextSample(pavi, AVIStreamTimeToSample(pavi, t)))
#define AVIStreamNearestSampleTime(pavi, t) AVIStreamSampleToTime(pavi, AVIStreamNearestSample(pavi, AVIStreamTimeToSample(pavi, t)))
#define AVIStreamNextKeyFrameTime(pavi, t) AVIStreamSampleToTime(pavi, AVIStreamNextKeyFrame(pavi, AVIStreamTimeToSample(pavi, t)))
#define AVIStreamPrevKeyFrameTime(pavi, t) AVIStreamSampleToTime(pavi, AVIStreamPrevKeyFrame(pavi, AVIStreamTimeToSample(pavi, t)))
#define AVIStreamNearestKeyFrameTime(pavi, t) AVIStreamSampleToTime(pavi, AVIStreamNearestKeyFrame(pavi, AVIStreamTimeToSample(pavi, t)))
#define AVIStreamStartTime(pavi) AVIStreamSampleToTime(pavi, AVIStreamStart(pavi))
#define AVIStreamLengthTime(pavi) AVIStreamSampleToTime(pavi, AVIStreamLength(pavi))
#define AVIStreamEnd(pavi) (AVIStreamStart(pavi) + AVIStreamLength(pavi))
#define AVIStreamEndTime(pavi) AVIStreamSampleToTime(pavi, AVIStreamEnd(pavi))
#define AVIStreamSampleSize(pavi, lPos, plSize) AVIStreamRead(pavi, lPos, 1, NULL, cast(LONG, 0), plSize, NULL)
#define AVIStreamFormatSize(pavi, lPos, plSize) AVIStreamReadFormat(pavi, lPos, NULL, plSize)
#define AVIStreamDataSize(pavi, fcc, plSize) AVIStreamReadData(pavi, fcc, NULL, plSize)
#define AVStreamNextKeyFrame(pavi, pos) AVIStreamFindSample(pavi, pos + 1, FIND_NEXT or FIND_KEY)
#define AVStreamPrevKeyFrame(pavi, pos) AVIStreamFindSample(pavi, pos - 1, FIND_NEXT or FIND_KEY)
#define comptypeDIB mmioFOURCC(asc("D"), asc("I"), asc("B"), asc(" "))
declare function AVIMakeCompressedStream(byval ppsCompressed as PAVISTREAM ptr, byval ppsSource as PAVISTREAM, byval lpOptions as AVICOMPRESSOPTIONS ptr, byval pclsidHandler as CLSID ptr) as HRESULT
declare function AVISaveA cdecl(byval szFile as LPCSTR, byval pclsidHandler as CLSID ptr, byval lpfnCallback as AVISAVECALLBACK, byval nStreams as long, byval pfile as PAVISTREAM, byval lpOptions as LPAVICOMPRESSOPTIONS, ...) as HRESULT

#ifndef UNICODE
	declare function AVISave cdecl alias "AVISaveA"(byval szFile as LPCSTR, byval pclsidHandler as CLSID ptr, byval lpfnCallback as AVISAVECALLBACK, byval nStreams as long, byval pfile as PAVISTREAM, byval lpOptions as LPAVICOMPRESSOPTIONS, ...) as HRESULT
#endif

declare function AVISaveVA(byval szFile as LPCSTR, byval pclsidHandler as CLSID ptr, byval lpfnCallback as AVISAVECALLBACK, byval nStreams as long, byval ppavi as PAVISTREAM ptr, byval plpOptions as LPAVICOMPRESSOPTIONS ptr) as HRESULT

#ifndef UNICODE
	declare function AVISaveV alias "AVISaveVA"(byval szFile as LPCSTR, byval pclsidHandler as CLSID ptr, byval lpfnCallback as AVISAVECALLBACK, byval nStreams as long, byval ppavi as PAVISTREAM ptr, byval plpOptions as LPAVICOMPRESSOPTIONS ptr) as HRESULT
#endif

declare function AVISaveW cdecl(byval szFile as LPCWSTR, byval pclsidHandler as CLSID ptr, byval lpfnCallback as AVISAVECALLBACK, byval nStreams as long, byval pfile as PAVISTREAM, byval lpOptions as LPAVICOMPRESSOPTIONS, ...) as HRESULT

#ifdef UNICODE
	declare function AVISave cdecl alias "AVISaveW"(byval szFile as LPCWSTR, byval pclsidHandler as CLSID ptr, byval lpfnCallback as AVISAVECALLBACK, byval nStreams as long, byval pfile as PAVISTREAM, byval lpOptions as LPAVICOMPRESSOPTIONS, ...) as HRESULT
#endif

declare function AVISaveVW(byval szFile as LPCWSTR, byval pclsidHandler as CLSID ptr, byval lpfnCallback as AVISAVECALLBACK, byval nStreams as long, byval ppavi as PAVISTREAM ptr, byval plpOptions as LPAVICOMPRESSOPTIONS ptr) as HRESULT

#ifdef UNICODE
	declare function AVISaveV alias "AVISaveVW"(byval szFile as LPCWSTR, byval pclsidHandler as CLSID ptr, byval lpfnCallback as AVISAVECALLBACK, byval nStreams as long, byval ppavi as PAVISTREAM ptr, byval plpOptions as LPAVICOMPRESSOPTIONS ptr) as HRESULT
#endif

declare function AVISaveOptions(byval hwnd as HWND, byval uiFlags as UINT, byval nStreams as long, byval ppavi as PAVISTREAM ptr, byval plpOptions as LPAVICOMPRESSOPTIONS ptr) as INT_PTR
declare function AVISaveOptionsFree(byval nStreams as long, byval plpOptions as LPAVICOMPRESSOPTIONS ptr) as HRESULT
declare function AVIBuildFilterW(byval lpszFilter as LPWSTR, byval cbFilter as LONG, byval fSaving as WINBOOL) as HRESULT

#ifdef UNICODE
	declare function AVIBuildFilter alias "AVIBuildFilterW"(byval lpszFilter as LPWSTR, byval cbFilter as LONG, byval fSaving as WINBOOL) as HRESULT
#endif

declare function AVIBuildFilterA(byval lpszFilter as LPSTR, byval cbFilter as LONG, byval fSaving as WINBOOL) as HRESULT

#ifndef UNICODE
	declare function AVIBuildFilter alias "AVIBuildFilterA"(byval lpszFilter as LPSTR, byval cbFilter as LONG, byval fSaving as WINBOOL) as HRESULT
#endif

declare function AVIMakeFileFromStreams(byval ppfile as PAVIFILE ptr, byval nStreams as long, byval papStreams as PAVISTREAM ptr) as HRESULT
declare function AVIMakeStreamFromClipboard(byval cfFormat as UINT, byval hGlobal as HANDLE, byval ppstream as PAVISTREAM ptr) as HRESULT
declare function AVIPutFileOnClipboard(byval pf as PAVIFILE) as HRESULT
declare function AVIGetFromClipboard(byval lppf as PAVIFILE ptr) as HRESULT
declare function AVIClearClipboard() as HRESULT
declare function CreateEditableStream(byval ppsEditable as PAVISTREAM ptr, byval psSource as PAVISTREAM) as HRESULT
declare function EditStreamCut(byval pavi as PAVISTREAM, byval plStart as LONG ptr, byval plLength as LONG ptr, byval ppResult as PAVISTREAM ptr) as HRESULT
declare function EditStreamCopy(byval pavi as PAVISTREAM, byval plStart as LONG ptr, byval plLength as LONG ptr, byval ppResult as PAVISTREAM ptr) as HRESULT
declare function EditStreamPaste(byval pavi as PAVISTREAM, byval plPos as LONG ptr, byval plLength as LONG ptr, byval pstream as PAVISTREAM, byval lStart as LONG, byval lEnd as LONG) as HRESULT
declare function EditStreamClone(byval pavi as PAVISTREAM, byval ppResult as PAVISTREAM ptr) as HRESULT
declare function EditStreamSetNameA(byval pavi as PAVISTREAM, byval lpszName as LPCSTR) as HRESULT

#ifndef UNICODE
	declare function EditStreamSetName alias "EditStreamSetNameA"(byval pavi as PAVISTREAM, byval lpszName as LPCSTR) as HRESULT
#endif

declare function EditStreamSetNameW(byval pavi as PAVISTREAM, byval lpszName as LPCWSTR) as HRESULT

#ifdef UNICODE
	declare function EditStreamSetName alias "EditStreamSetNameW"(byval pavi as PAVISTREAM, byval lpszName as LPCWSTR) as HRESULT
#endif

declare function EditStreamSetInfoW(byval pavi as PAVISTREAM, byval lpInfo as LPAVISTREAMINFOW, byval cbInfo as LONG) as HRESULT

#ifdef UNICODE
	declare function EditStreamSetInfo alias "EditStreamSetInfoW"(byval pavi as PAVISTREAM, byval lpInfo as LPAVISTREAMINFOW, byval cbInfo as LONG) as HRESULT
#endif

declare function EditStreamSetInfoA(byval pavi as PAVISTREAM, byval lpInfo as LPAVISTREAMINFOA, byval cbInfo as LONG) as HRESULT

#ifndef UNICODE
	declare function EditStreamSetInfo alias "EditStreamSetInfoA"(byval pavi as PAVISTREAM, byval lpInfo as LPAVISTREAMINFOA, byval cbInfo as LONG) as HRESULT
#endif

const AVIERR_OK = 0
#define MAKE_AVIERR(error) MAKE_SCODE(SEVERITY_ERROR, FACILITY_ITF, &h4000 + error)
#define AVIERR_UNSUPPORTED MAKE_AVIERR(101)
#define AVIERR_BADFORMAT MAKE_AVIERR(102)
#define AVIERR_MEMORY MAKE_AVIERR(103)
#define AVIERR_INTERNAL MAKE_AVIERR(104)
#define AVIERR_BADFLAGS MAKE_AVIERR(105)
#define AVIERR_BADPARAM MAKE_AVIERR(106)
#define AVIERR_BADSIZE MAKE_AVIERR(107)
#define AVIERR_BADHANDLE MAKE_AVIERR(108)
#define AVIERR_FILEREAD MAKE_AVIERR(109)
#define AVIERR_FILEWRITE MAKE_AVIERR(110)
#define AVIERR_FILEOPEN MAKE_AVIERR(111)
#define AVIERR_COMPRESSOR MAKE_AVIERR(112)
#define AVIERR_NOCOMPRESSOR MAKE_AVIERR(113)
#define AVIERR_READONLY MAKE_AVIERR(114)
#define AVIERR_NODATA MAKE_AVIERR(115)
#define AVIERR_BUFFERTOOSMALL MAKE_AVIERR(116)
#define AVIERR_CANTCOMPRESS MAKE_AVIERR(117)
#define AVIERR_USERABORT MAKE_AVIERR(198)
#define AVIERR_ERROR MAKE_AVIERR(199)

#ifdef UNICODE
	declare function MCIWndSM alias "SendMessageW"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#else
	declare function MCIWndSM alias "SendMessageA"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

#define MCIWND_WINDOW_CLASS __TEXT("MCIWndClass")
declare function MCIWndCreateA cdecl(byval hwndParent as HWND, byval hInstance as HINSTANCE, byval dwStyle as DWORD, byval szFile as LPCSTR) as HWND

#ifndef UNICODE
	declare function MCIWndCreate cdecl alias "MCIWndCreateA"(byval hwndParent as HWND, byval hInstance as HINSTANCE, byval dwStyle as DWORD, byval szFile as LPCSTR) as HWND
#endif

declare function MCIWndCreateW cdecl(byval hwndParent as HWND, byval hInstance as HINSTANCE, byval dwStyle as DWORD, byval szFile as LPCWSTR) as HWND

#ifdef UNICODE
	declare function MCIWndCreate cdecl alias "MCIWndCreateW"(byval hwndParent as HWND, byval hInstance as HINSTANCE, byval dwStyle as DWORD, byval szFile as LPCWSTR) as HWND
#endif

declare function MCIWndRegisterClass cdecl() as WINBOOL
const MCIWNDOPENF_NEW = &h0001
const MCIWNDF_NOAUTOSIZEWINDOW = &h0001
const MCIWNDF_NOPLAYBAR = &h0002
const MCIWNDF_NOAUTOSIZEMOVIE = &h0004
const MCIWNDF_NOMENU = &h0008
const MCIWNDF_SHOWNAME = &h0010
const MCIWNDF_SHOWPOS = &h0020
const MCIWNDF_SHOWMODE = &h0040
const MCIWNDF_SHOWALL = &h0070
const MCIWNDF_NOTIFYMODE = &h0100
const MCIWNDF_NOTIFYPOS = &h0200
const MCIWNDF_NOTIFYSIZE = &h0400
const MCIWNDF_NOTIFYERROR = &h1000
const MCIWNDF_NOTIFYALL = &h1F00
const MCIWNDF_NOTIFYANSI = &h0080
const MCIWNDF_NOTIFYMEDIAA = &h0880
const MCIWNDF_NOTIFYMEDIAW = &h0800

#ifdef UNICODE
	const MCIWNDF_NOTIFYMEDIA = MCIWNDF_NOTIFYMEDIAW
#else
	const MCIWNDF_NOTIFYMEDIA = MCIWNDF_NOTIFYMEDIAA
#endif

const MCIWNDF_RECORD = &h2000
const MCIWNDF_NOERRORDLG = &h4000
const MCIWNDF_NOOPEN = &h8000
#define MCIWndCanPlay(hwnd) cast(WINBOOL, MCIWndSM(hwnd, MCIWNDM_CAN_PLAY, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndCanRecord(hwnd) cast(WINBOOL, MCIWndSM(hwnd, MCIWNDM_CAN_RECORD, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndCanSave(hwnd) cast(WINBOOL, MCIWndSM(hwnd, MCIWNDM_CAN_SAVE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndCanWindow(hwnd) cast(WINBOOL, MCIWndSM(hwnd, MCIWNDM_CAN_WINDOW, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndCanEject(hwnd) cast(WINBOOL, MCIWndSM(hwnd, MCIWNDM_CAN_EJECT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndCanConfig(hwnd) cast(WINBOOL, MCIWndSM(hwnd, MCIWNDM_CAN_CONFIG, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndPaletteKick(hwnd) cast(WINBOOL, MCIWndSM(hwnd, MCIWNDM_PALETTEKICK, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndSave(hwnd, szFile) cast(LONG, MCIWndSM(hwnd, MCI_SAVE, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, (szFile)))))
#define MCIWndSaveDialog(hwnd) MCIWndSave(hwnd, -1)
#define MCIWndNew(hwnd, lp) cast(LONG, MCIWndSM(hwnd, MCIWNDM_NEW, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, (lp)))))
#define MCIWndRecord(hwnd) cast(LONG, MCIWndSM(hwnd, MCI_RECORD, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndOpen(hwnd, sz, f) cast(LONG, MCIWndSM(hwnd, MCIWNDM_OPEN, cast(WPARAM, cast(UINT, (f))), cast(LPARAM, cast(LPVOID, (sz)))))
#define MCIWndOpenDialog(hwnd) MCIWndOpen(hwnd, -1, 0)
#define MCIWndClose(hwnd) cast(LONG, MCIWndSM(hwnd, MCI_CLOSE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndPlay(hwnd) cast(LONG, MCIWndSM(hwnd, MCI_PLAY, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndStop(hwnd) cast(LONG, MCIWndSM(hwnd, MCI_STOP, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndPause(hwnd) cast(LONG, MCIWndSM(hwnd, MCI_PAUSE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndResume(hwnd) cast(LONG, MCIWndSM(hwnd, MCI_RESUME, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndSeek(hwnd, lPos) cast(LONG, MCIWndSM(hwnd, MCI_SEEK, cast(WPARAM, 0), cast(LPARAM, cast(LONG, (lPos)))))
#define MCIWndEject(hwnd) cast(LONG, MCIWndSM(hwnd, MCIWNDM_EJECT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndHome(hwnd) MCIWndSeek(hwnd, MCIWND_START)
#define MCIWndEnd(hwnd) MCIWndSeek(hwnd, MCIWND_END)
#define MCIWndGetSource(hwnd, prc) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GET_SOURCE, cast(WPARAM, 0), cast(LPARAM, cast(LPRECT, (prc)))))
#define MCIWndPutSource(hwnd, prc) cast(LONG, MCIWndSM(hwnd, MCIWNDM_PUT_SOURCE, cast(WPARAM, 0), cast(LPARAM, cast(LPRECT, (prc)))))
#define MCIWndGetDest(hwnd, prc) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GET_DEST, cast(WPARAM, 0), cast(LPARAM, cast(LPRECT, (prc)))))
#define MCIWndPutDest(hwnd, prc) cast(LONG, MCIWndSM(hwnd, MCIWNDM_PUT_DEST, cast(WPARAM, 0), cast(LPARAM, cast(LPRECT, (prc)))))
#define MCIWndPlayReverse(hwnd) cast(LONG, MCIWndSM(hwnd, MCIWNDM_PLAYREVERSE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndPlayFrom(hwnd, lPos) cast(LONG, MCIWndSM(hwnd, MCIWNDM_PLAYFROM, cast(WPARAM, 0), cast(LPARAM, cast(LONG, (lPos)))))
#define MCIWndPlayTo(hwnd, lPos) cast(LONG, MCIWndSM(hwnd, MCIWNDM_PLAYTO, cast(WPARAM, 0), cast(LPARAM, cast(LONG, (lPos)))))
#define MCIWndGetDeviceID(hwnd) cast(UINT, MCIWndSM(hwnd, MCIWNDM_GETDEVICEID, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndGetAlias(hwnd) cast(UINT, MCIWndSM(hwnd, MCIWNDM_GETALIAS, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndGetMode(hwnd, lp, len) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETMODE, cast(WPARAM, cast(UINT, (len))), cast(LPARAM, cast(LPTSTR, (lp)))))
#define MCIWndGetPosition(hwnd) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETPOSITION, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndGetPositionString(hwnd, lp, len) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETPOSITION, cast(WPARAM, cast(UINT, (len))), cast(LPARAM, cast(LPTSTR, (lp)))))
#define MCIWndGetStart(hwnd) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETSTART, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndGetLength(hwnd) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETLENGTH, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndGetEnd(hwnd) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETEND, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndStep(hwnd, n) cast(LONG, MCIWndSM(hwnd, MCI_STEP, cast(WPARAM, 0), cast(LPARAM, clng(n))))
#define MCIWndDestroy(hwnd) MCIWndSM(hwnd, WM_CLOSE, cast(WPARAM, 0), cast(LPARAM, 0))
#define MCIWndSetZoom(hwnd, iZoom) MCIWndSM(hwnd, MCIWNDM_SETZOOM, cast(WPARAM, 0), cast(LPARAM, cast(UINT, (iZoom))))
#define MCIWndGetZoom(hwnd) cast(UINT, MCIWndSM(hwnd, MCIWNDM_GETZOOM, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndSetVolume(hwnd, iVol) cast(LONG, MCIWndSM(hwnd, MCIWNDM_SETVOLUME, cast(WPARAM, 0), cast(LPARAM, cast(UINT, (iVol)))))
#define MCIWndGetVolume(hwnd) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETVOLUME, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndSetSpeed(hwnd, iSpeed) cast(LONG, MCIWndSM(hwnd, MCIWNDM_SETSPEED, cast(WPARAM, 0), cast(LPARAM, cast(UINT, (iSpeed)))))
#define MCIWndGetSpeed(hwnd) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETSPEED, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndSetTimeFormat(hwnd, lp) cast(LONG, MCIWndSM(hwnd, MCIWNDM_SETTIMEFORMAT, cast(WPARAM, 0), cast(LPARAM, cast(LPTSTR, (lp)))))
#define MCIWndGetTimeFormat(hwnd, lp, len) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETTIMEFORMAT, cast(WPARAM, cast(UINT, (len))), cast(LPARAM, cast(LPTSTR, (lp)))))
#define MCIWndValidateMedia(hwnd) MCIWndSM(hwnd, MCIWNDM_VALIDATEMEDIA, cast(WPARAM, 0), cast(LPARAM, 0))
#define MCIWndSetRepeat(hwnd, f) MCIWndSM(hwnd, MCIWNDM_SETREPEAT, cast(WPARAM, 0), cast(LPARAM, cast(WINBOOL, (f))))
#define MCIWndGetRepeat(hwnd) cast(WINBOOL, MCIWndSM(hwnd, MCIWNDM_GETREPEAT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndUseFrames(hwnd) MCIWndSetTimeFormat(hwnd, __TEXT("frames"))
#define MCIWndUseTime(hwnd) MCIWndSetTimeFormat(hwnd, __TEXT("ms"))
#define MCIWndSetActiveTimer(hwnd, active) MCIWndSM(hwnd, MCIWNDM_SETACTIVETIMER, cast(WPARAM, cast(UINT, (active))), cast(LPARAM, 0))
#define MCIWndSetInactiveTimer(hwnd, inactive) MCIWndSM(hwnd, MCIWNDM_SETINACTIVETIMER, cast(WPARAM, cast(UINT, (inactive))), cast(LPARAM, 0))
#define MCIWndSetTimers(hwnd, active, inactive) MCIWndSM(hwnd, MCIWNDM_SETTIMERS, cast(WPARAM, cast(UINT, (active))), cast(LPARAM, cast(UINT, (inactive))))
#define MCIWndGetActiveTimer(hwnd) cast(UINT, MCIWndSM(hwnd, MCIWNDM_GETACTIVETIMER, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndGetInactiveTimer(hwnd) cast(UINT, MCIWndSM(hwnd, MCIWNDM_GETINACTIVETIMER, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndRealize(hwnd, fBkgnd) cast(LONG, MCIWndSM(hwnd, MCIWNDM_REALIZE, cast(WPARAM, cast(WINBOOL, (fBkgnd))), cast(LPARAM, 0)))
#define MCIWndSendString(hwnd, sz) cast(LONG, MCIWndSM(hwnd, MCIWNDM_SENDSTRING, cast(WPARAM, 0), cast(LPARAM, cast(LPTSTR, (sz)))))
#define MCIWndReturnString(hwnd, lp, len) cast(LONG, MCIWndSM(hwnd, MCIWNDM_RETURNSTRING, cast(WPARAM, cast(UINT, (len))), cast(LPARAM, cast(LPVOID, (lp)))))
#define MCIWndGetError(hwnd, lp, len) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETERROR, cast(WPARAM, cast(UINT, (len))), cast(LPARAM, cast(LPVOID, (lp)))))
#define MCIWndGetPalette(hwnd) cast(HPALETTE, MCIWndSM(hwnd, MCIWNDM_GETPALETTE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndSetPalette(hwnd, hpal) cast(LONG, MCIWndSM(hwnd, MCIWNDM_SETPALETTE, cast(WPARAM, cast(HPALETTE, (hpal))), cast(LPARAM, 0)))
#define MCIWndGetFileName(hwnd, lp, len) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETFILENAME, cast(WPARAM, cast(UINT, (len))), cast(LPARAM, cast(LPVOID, (lp)))))
#define MCIWndGetDevice(hwnd, lp, len) cast(LONG, MCIWndSM(hwnd, MCIWNDM_GETDEVICE, cast(WPARAM, cast(UINT, (len))), cast(LPARAM, cast(LPVOID, (lp)))))
#define MCIWndGetStyles(hwnd) cast(UINT, MCIWndSM(hwnd, MCIWNDM_GETSTYLES, cast(WPARAM, 0), cast(LPARAM, 0)))
#define MCIWndChangeStyles(hwnd, mask, value) cast(LONG, MCIWndSM(hwnd, MCIWNDM_CHANGESTYLES, cast(WPARAM, cast(UINT, (mask))), cast(LPARAM, cast(LONG, (value)))))
#define MCIWndOpenInterface(hwnd, pUnk) cast(LONG, MCIWndSM(hwnd, MCIWNDM_OPENINTERFACE, cast(WPARAM, 0), cast(LPARAM, cast(LPUNKNOWN, (pUnk)))))
#define MCIWndSetOwner(hwnd, hwndP) cast(LONG, MCIWndSM(hwnd, MCIWNDM_SETOWNER, cast(WPARAM, (hwndP)), cast(LPARAM, 0)))
const MCIWNDM_GETDEVICEID = WM_USER + 100
const MCIWNDM_GETSTART = WM_USER + 103
const MCIWNDM_GETLENGTH = WM_USER + 104
const MCIWNDM_GETEND = WM_USER + 105
const MCIWNDM_EJECT = WM_USER + 107
const MCIWNDM_SETZOOM = WM_USER + 108
const MCIWNDM_GETZOOM = WM_USER + 109
const MCIWNDM_SETVOLUME = WM_USER + 110
const MCIWNDM_GETVOLUME = WM_USER + 111
const MCIWNDM_SETSPEED = WM_USER + 112
const MCIWNDM_GETSPEED = WM_USER + 113
const MCIWNDM_SETREPEAT = WM_USER + 114
const MCIWNDM_GETREPEAT = WM_USER + 115
const MCIWNDM_REALIZE = WM_USER + 118
const MCIWNDM_VALIDATEMEDIA = WM_USER + 121
const MCIWNDM_PLAYFROM = WM_USER + 122
const MCIWNDM_PLAYTO = WM_USER + 123
const MCIWNDM_GETPALETTE = WM_USER + 126
const MCIWNDM_SETPALETTE = WM_USER + 127
const MCIWNDM_SETTIMERS = WM_USER + 129
const MCIWNDM_SETACTIVETIMER = WM_USER + 130
const MCIWNDM_SETINACTIVETIMER = WM_USER + 131
const MCIWNDM_GETACTIVETIMER = WM_USER + 132
const MCIWNDM_GETINACTIVETIMER = WM_USER + 133
const MCIWNDM_CHANGESTYLES = WM_USER + 135
const MCIWNDM_GETSTYLES = WM_USER + 136
const MCIWNDM_GETALIAS = WM_USER + 137
const MCIWNDM_PLAYREVERSE = WM_USER + 139
const MCIWNDM_GET_SOURCE = WM_USER + 140
const MCIWNDM_PUT_SOURCE = WM_USER + 141
const MCIWNDM_GET_DEST = WM_USER + 142
const MCIWNDM_PUT_DEST = WM_USER + 143
const MCIWNDM_CAN_PLAY = WM_USER + 144
const MCIWNDM_CAN_WINDOW = WM_USER + 145
const MCIWNDM_CAN_RECORD = WM_USER + 146
const MCIWNDM_CAN_SAVE = WM_USER + 147
const MCIWNDM_CAN_EJECT = WM_USER + 148
const MCIWNDM_CAN_CONFIG = WM_USER + 149
const MCIWNDM_PALETTEKICK = WM_USER + 150
const MCIWNDM_OPENINTERFACE = WM_USER + 151
const MCIWNDM_SETOWNER = WM_USER + 152
const MCIWNDM_SENDSTRINGA = WM_USER + 101
const MCIWNDM_GETPOSITIONA = WM_USER + 102
const MCIWNDM_GETMODEA = WM_USER + 106
const MCIWNDM_SETTIMEFORMATA = WM_USER + 119
const MCIWNDM_GETTIMEFORMATA = WM_USER + 120
const MCIWNDM_GETFILENAMEA = WM_USER + 124
const MCIWNDM_GETDEVICEA = WM_USER + 125
const MCIWNDM_GETERRORA = WM_USER + 128
const MCIWNDM_NEWA = WM_USER + 134
const MCIWNDM_RETURNSTRINGA = WM_USER + 138
const MCIWNDM_OPENA = WM_USER + 153
const MCIWNDM_SENDSTRINGW = WM_USER + 201
const MCIWNDM_GETPOSITIONW = WM_USER + 202
const MCIWNDM_GETMODEW = WM_USER + 206
const MCIWNDM_SETTIMEFORMATW = WM_USER + 219
const MCIWNDM_GETTIMEFORMATW = WM_USER + 220
const MCIWNDM_GETFILENAMEW = WM_USER + 224
const MCIWNDM_GETDEVICEW = WM_USER + 225
const MCIWNDM_GETERRORW = WM_USER + 228
const MCIWNDM_NEWW = WM_USER + 234
const MCIWNDM_RETURNSTRINGW = WM_USER + 238
const MCIWNDM_OPENW = WM_USER + 252

private function MCIWndPlayFromTo(byval hwnd as HWND, byval lStart as long, byval lEnd as long) as LONG
	MCIWndSeek(hwnd, lStart)
	function = MCIWndPlayTo(hwnd, lEnd)
end function

#ifdef UNICODE
	const MCIWNDM_SENDSTRING = MCIWNDM_SENDSTRINGW
	const MCIWNDM_GETPOSITION = MCIWNDM_GETPOSITIONW
	const MCIWNDM_GETMODE = MCIWNDM_GETMODEW
	const MCIWNDM_SETTIMEFORMAT = MCIWNDM_SETTIMEFORMATW
	const MCIWNDM_GETTIMEFORMAT = MCIWNDM_GETTIMEFORMATW
	const MCIWNDM_GETFILENAME = MCIWNDM_GETFILENAMEW
	const MCIWNDM_GETDEVICE = MCIWNDM_GETDEVICEW
	const MCIWNDM_GETERROR = MCIWNDM_GETERRORW
	const MCIWNDM_NEW = MCIWNDM_NEWW
	const MCIWNDM_RETURNSTRING = MCIWNDM_RETURNSTRINGW
	const MCIWNDM_OPEN = MCIWNDM_OPENW
#else
	const MCIWNDM_SENDSTRING = MCIWNDM_SENDSTRINGA
	const MCIWNDM_GETPOSITION = MCIWNDM_GETPOSITIONA
	const MCIWNDM_GETMODE = MCIWNDM_GETMODEA
	const MCIWNDM_SETTIMEFORMAT = MCIWNDM_SETTIMEFORMATA
	const MCIWNDM_GETTIMEFORMAT = MCIWNDM_GETTIMEFORMATA
	const MCIWNDM_GETFILENAME = MCIWNDM_GETFILENAMEA
	const MCIWNDM_GETDEVICE = MCIWNDM_GETDEVICEA
	const MCIWNDM_GETERROR = MCIWNDM_GETERRORA
	const MCIWNDM_NEW = MCIWNDM_NEWA
	const MCIWNDM_RETURNSTRING = MCIWNDM_RETURNSTRINGA
	const MCIWNDM_OPEN = MCIWNDM_OPENA
#endif

const MCIWNDM_NOTIFYMODE = WM_USER + 200
const MCIWNDM_NOTIFYPOS = WM_USER + 201
const MCIWNDM_NOTIFYSIZE = WM_USER + 202
const MCIWNDM_NOTIFYMEDIA = WM_USER + 203
const MCIWNDM_NOTIFYERROR = WM_USER + 205
const MCIWND_START = -1
const MCIWND_END = -2

type HVIDEO__
	unused as long
end type

type HVIDEO as HVIDEO__ ptr
type LPHVIDEO as HVIDEO ptr
const DV_ERR_OK = 0
const DV_ERR_BASE = 1
const DV_ERR_NONSPECIFIC = DV_ERR_BASE
const DV_ERR_BADFORMAT = DV_ERR_BASE + 1
const DV_ERR_STILLPLAYING = DV_ERR_BASE + 2
const DV_ERR_UNPREPARED = DV_ERR_BASE + 3
const DV_ERR_SYNC = DV_ERR_BASE + 4
const DV_ERR_TOOMANYCHANNELS = DV_ERR_BASE + 5
const DV_ERR_NOTDETECTED = DV_ERR_BASE + 6
const DV_ERR_BADINSTALL = DV_ERR_BASE + 7
const DV_ERR_CREATEPALETTE = DV_ERR_BASE + 8
const DV_ERR_SIZEFIELD = DV_ERR_BASE + 9
const DV_ERR_PARAM1 = DV_ERR_BASE + 10
const DV_ERR_PARAM2 = DV_ERR_BASE + 11
const DV_ERR_CONFIG1 = DV_ERR_BASE + 12
const DV_ERR_CONFIG2 = DV_ERR_BASE + 13
const DV_ERR_FLAGS = DV_ERR_BASE + 14
const DV_ERR_13 = DV_ERR_BASE + 15
const DV_ERR_NOTSUPPORTED = DV_ERR_BASE + 16
const DV_ERR_NOMEM = DV_ERR_BASE + 17
const DV_ERR_ALLOCATED = DV_ERR_BASE + 18
const DV_ERR_BADDEVICEID = DV_ERR_BASE + 19
const DV_ERR_INVALHANDLE = DV_ERR_BASE + 20
const DV_ERR_BADERRNUM = DV_ERR_BASE + 21
const DV_ERR_NO_BUFFERS = DV_ERR_BASE + 22
const DV_ERR_MEM_CONFLICT = DV_ERR_BASE + 23
const DV_ERR_IO_CONFLICT = DV_ERR_BASE + 24
const DV_ERR_DMA_CONFLICT = DV_ERR_BASE + 25
const DV_ERR_INT_CONFLICT = DV_ERR_BASE + 26
const DV_ERR_PROTECT_ONLY = DV_ERR_BASE + 27
const DV_ERR_LASTERROR = DV_ERR_BASE + 27
const DV_ERR_USER_MSG = DV_ERR_BASE + 1000
const DV_VM_OPEN = MM_DRVM_OPEN
const DV_VM_CLOSE = MM_DRVM_CLOSE
const DV_VM_DATA = MM_DRVM_DATA
const DV_VM_ERROR = MM_DRVM_ERROR

type videohdr_tag
	lpData as LPBYTE
	dwBufferLength as DWORD
	dwBytesUsed as DWORD
	dwTimeCaptured as DWORD
	dwUser as DWORD_PTR
	dwFlags as DWORD
	dwReserved(0 to 3) as DWORD_PTR
end type

type VIDEOHDR as videohdr_tag
type PVIDEOHDR as videohdr_tag ptr
type LPVIDEOHDR as videohdr_tag ptr

const VHDR_DONE = &h00000001
const VHDR_PREPARED = &h00000002
const VHDR_INQUEUE = &h00000004
const VHDR_KEYFRAME = &h00000008
const VHDR_VALID = &h0000000F

type channel_caps_tag
	dwFlags as DWORD
	dwSrcRectXMod as DWORD
	dwSrcRectYMod as DWORD
	dwSrcRectWidthMod as DWORD
	dwSrcRectHeightMod as DWORD
	dwDstRectXMod as DWORD
	dwDstRectYMod as DWORD
	dwDstRectWidthMod as DWORD
	dwDstRectHeightMod as DWORD
end type

type CHANNEL_CAPS as channel_caps_tag
type PCHANNEL_CAPS as channel_caps_tag ptr
type LPCHANNEL_CAPS as channel_caps_tag ptr

const VCAPS_OVERLAY = &h00000001
const VCAPS_SRC_CAN_CLIP = &h00000002
const VCAPS_DST_CAN_CLIP = &h00000004
const VCAPS_CAN_SCALE = &h00000008
const VIDEO_EXTERNALIN = &h0001
const VIDEO_EXTERNALOUT = &h0002
const VIDEO_IN = &h0004
const VIDEO_OUT = &h0008
const VIDEO_DLG_QUERY = &h0010
const VIDEO_CONFIGURE_QUERY = &h8000
const VIDEO_CONFIGURE_SET = &h1000
const VIDEO_CONFIGURE_GET = &h2000
const VIDEO_CONFIGURE_QUERYSIZE = &h0001
const VIDEO_CONFIGURE_CURRENT = &h0010
const VIDEO_CONFIGURE_NOMINAL = &h0020
const VIDEO_CONFIGURE_MIN = &h0040
const VIDEO_CONFIGURE_MAX = &h0080
const DVM_USER = &h4000
const DVM_CONFIGURE_START = &h1000
const DVM_CONFIGURE_END = &h1FFF
const DVM_PALETTE = DVM_CONFIGURE_START + 1
const DVM_FORMAT = DVM_CONFIGURE_START + 2
const DVM_PALETTERGB555 = DVM_CONFIGURE_START + 3
const DVM_SRC_RECT = DVM_CONFIGURE_START + 4
const DVM_DST_RECT = DVM_CONFIGURE_START + 5
#define AVICapSM(hwnd, m, w, l) iif(IsWindow(hwnd), SendMessage(hwnd, m, w, l), 0)
const WM_CAP_START = WM_USER
const WM_CAP_UNICODE_START = WM_USER + 100
const WM_CAP_GET_CAPSTREAMPTR = WM_CAP_START + 1
const WM_CAP_SET_CALLBACK_ERRORW = WM_CAP_UNICODE_START + 2
const WM_CAP_SET_CALLBACK_STATUSW = WM_CAP_UNICODE_START + 3
const WM_CAP_SET_CALLBACK_ERRORA = WM_CAP_START + 2
const WM_CAP_SET_CALLBACK_STATUSA = WM_CAP_START + 3

#ifdef UNICODE
	const WM_CAP_SET_CALLBACK_ERROR = WM_CAP_SET_CALLBACK_ERRORW
	const WM_CAP_SET_CALLBACK_STATUS = WM_CAP_SET_CALLBACK_STATUSW
#else
	const WM_CAP_SET_CALLBACK_ERROR = WM_CAP_SET_CALLBACK_ERRORA
	const WM_CAP_SET_CALLBACK_STATUS = WM_CAP_SET_CALLBACK_STATUSA
#endif

const WM_CAP_SET_CALLBACK_YIELD = WM_CAP_START + 4
const WM_CAP_SET_CALLBACK_FRAME = WM_CAP_START + 5
const WM_CAP_SET_CALLBACK_VIDEOSTREAM = WM_CAP_START + 6
const WM_CAP_SET_CALLBACK_WAVESTREAM = WM_CAP_START + 7
const WM_CAP_GET_USER_DATA = WM_CAP_START + 8
const WM_CAP_SET_USER_DATA = WM_CAP_START + 9
const WM_CAP_DRIVER_CONNECT = WM_CAP_START + 10
const WM_CAP_DRIVER_DISCONNECT = WM_CAP_START + 11
const WM_CAP_DRIVER_GET_NAMEA = WM_CAP_START + 12
const WM_CAP_DRIVER_GET_VERSIONA = WM_CAP_START + 13
const WM_CAP_DRIVER_GET_NAMEW = WM_CAP_UNICODE_START + 12
const WM_CAP_DRIVER_GET_VERSIONW = WM_CAP_UNICODE_START + 13

#ifdef UNICODE
	const WM_CAP_DRIVER_GET_NAME = WM_CAP_DRIVER_GET_NAMEW
	const WM_CAP_DRIVER_GET_VERSION = WM_CAP_DRIVER_GET_VERSIONW
#else
	const WM_CAP_DRIVER_GET_NAME = WM_CAP_DRIVER_GET_NAMEA
	const WM_CAP_DRIVER_GET_VERSION = WM_CAP_DRIVER_GET_VERSIONA
#endif

const WM_CAP_DRIVER_GET_CAPS = WM_CAP_START + 14
const WM_CAP_FILE_SET_CAPTURE_FILEA = WM_CAP_START + 20
const WM_CAP_FILE_GET_CAPTURE_FILEA = WM_CAP_START + 21
const WM_CAP_FILE_SAVEASA = WM_CAP_START + 23
const WM_CAP_FILE_SAVEDIBA = WM_CAP_START + 25
const WM_CAP_FILE_SET_CAPTURE_FILEW = WM_CAP_UNICODE_START + 20
const WM_CAP_FILE_GET_CAPTURE_FILEW = WM_CAP_UNICODE_START + 21
const WM_CAP_FILE_SAVEASW = WM_CAP_UNICODE_START + 23
const WM_CAP_FILE_SAVEDIBW = WM_CAP_UNICODE_START + 25

#ifdef UNICODE
	const WM_CAP_FILE_SET_CAPTURE_FILE = WM_CAP_FILE_SET_CAPTURE_FILEW
	const WM_CAP_FILE_GET_CAPTURE_FILE = WM_CAP_FILE_GET_CAPTURE_FILEW
	const WM_CAP_FILE_SAVEAS = WM_CAP_FILE_SAVEASW
	const WM_CAP_FILE_SAVEDIB = WM_CAP_FILE_SAVEDIBW
#else
	const WM_CAP_FILE_SET_CAPTURE_FILE = WM_CAP_FILE_SET_CAPTURE_FILEA
	const WM_CAP_FILE_GET_CAPTURE_FILE = WM_CAP_FILE_GET_CAPTURE_FILEA
	const WM_CAP_FILE_SAVEAS = WM_CAP_FILE_SAVEASA
	const WM_CAP_FILE_SAVEDIB = WM_CAP_FILE_SAVEDIBA
#endif

const WM_CAP_FILE_ALLOCATE = WM_CAP_START + 22
const WM_CAP_FILE_SET_INFOCHUNK = WM_CAP_START + 24
const WM_CAP_EDIT_COPY = WM_CAP_START + 30
const WM_CAP_SET_AUDIOFORMAT = WM_CAP_START + 35
const WM_CAP_GET_AUDIOFORMAT = WM_CAP_START + 36
const WM_CAP_DLG_VIDEOFORMAT = WM_CAP_START + 41
const WM_CAP_DLG_VIDEOSOURCE = WM_CAP_START + 42
const WM_CAP_DLG_VIDEODISPLAY = WM_CAP_START + 43
const WM_CAP_GET_VIDEOFORMAT = WM_CAP_START + 44
const WM_CAP_SET_VIDEOFORMAT = WM_CAP_START + 45
const WM_CAP_DLG_VIDEOCOMPRESSION = WM_CAP_START + 46
const WM_CAP_SET_PREVIEW = WM_CAP_START + 50
const WM_CAP_SET_OVERLAY = WM_CAP_START + 51
const WM_CAP_SET_PREVIEWRATE = WM_CAP_START + 52
const WM_CAP_SET_SCALE = WM_CAP_START + 53
const WM_CAP_GET_STATUS = WM_CAP_START + 54
const WM_CAP_SET_SCROLL = WM_CAP_START + 55
const WM_CAP_GRAB_FRAME = WM_CAP_START + 60
const WM_CAP_GRAB_FRAME_NOSTOP = WM_CAP_START + 61
const WM_CAP_SEQUENCE = WM_CAP_START + 62
const WM_CAP_SEQUENCE_NOFILE = WM_CAP_START + 63
const WM_CAP_SET_SEQUENCE_SETUP = WM_CAP_START + 64
const WM_CAP_GET_SEQUENCE_SETUP = WM_CAP_START + 65
const WM_CAP_SET_MCI_DEVICEA = WM_CAP_START + 66
const WM_CAP_GET_MCI_DEVICEA = WM_CAP_START + 67
const WM_CAP_SET_MCI_DEVICEW = WM_CAP_UNICODE_START + 66
const WM_CAP_GET_MCI_DEVICEW = WM_CAP_UNICODE_START + 67

#ifdef UNICODE
	const WM_CAP_SET_MCI_DEVICE = WM_CAP_SET_MCI_DEVICEW
	const WM_CAP_GET_MCI_DEVICE = WM_CAP_GET_MCI_DEVICEW
#else
	const WM_CAP_SET_MCI_DEVICE = WM_CAP_SET_MCI_DEVICEA
	const WM_CAP_GET_MCI_DEVICE = WM_CAP_GET_MCI_DEVICEA
#endif

const WM_CAP_STOP = WM_CAP_START + 68
const WM_CAP_ABORT = WM_CAP_START + 69
const WM_CAP_SINGLE_FRAME_OPEN = WM_CAP_START + 70
const WM_CAP_SINGLE_FRAME_CLOSE = WM_CAP_START + 71
const WM_CAP_SINGLE_FRAME = WM_CAP_START + 72
const WM_CAP_PAL_OPENA = WM_CAP_START + 80
const WM_CAP_PAL_SAVEA = WM_CAP_START + 81
const WM_CAP_PAL_OPENW = WM_CAP_UNICODE_START + 80
const WM_CAP_PAL_SAVEW = WM_CAP_UNICODE_START + 81

#ifdef UNICODE
	const WM_CAP_PAL_OPEN = WM_CAP_PAL_OPENW
	const WM_CAP_PAL_SAVE = WM_CAP_PAL_SAVEW
#else
	const WM_CAP_PAL_OPEN = WM_CAP_PAL_OPENA
	const WM_CAP_PAL_SAVE = WM_CAP_PAL_SAVEA
#endif

const WM_CAP_PAL_PASTE = WM_CAP_START + 82
const WM_CAP_PAL_AUTOCREATE = WM_CAP_START + 83
const WM_CAP_PAL_MANUALCREATE = WM_CAP_START + 84
const WM_CAP_SET_CALLBACK_CAPCONTROL = WM_CAP_START + 85
const WM_CAP_UNICODE_END = WM_CAP_PAL_SAVEW
const WM_CAP_END = WM_CAP_UNICODE_END
#define capSetCallbackOnError(hwnd, fpProc) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_CALLBACK_ERROR, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, (fpProc)))))
#define capSetCallbackOnStatus(hwnd, fpProc) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_CALLBACK_STATUS, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, (fpProc)))))
#define capSetCallbackOnYield(hwnd, fpProc) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_CALLBACK_YIELD, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, (fpProc)))))
#define capSetCallbackOnFrame(hwnd, fpProc) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_CALLBACK_FRAME, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, (fpProc)))))
#define capSetCallbackOnVideoStream(hwnd, fpProc) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_CALLBACK_VIDEOSTREAM, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, (fpProc)))))
#define capSetCallbackOnWaveStream(hwnd, fpProc) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_CALLBACK_WAVESTREAM, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, (fpProc)))))
#define capSetCallbackOnCapControl(hwnd, fpProc) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_CALLBACK_CAPCONTROL, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, (fpProc)))))
#define capSetUserData(hwnd, lUser) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_USER_DATA, cast(WPARAM, 0), cast(LPARAM, lUser)))
#define capGetUserData(hwnd) AVICapSM(hwnd, WM_CAP_GET_USER_DATA, cast(WPARAM, 0), cast(LPARAM, 0))
#define capDriverConnect(hwnd, i) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_DRIVER_CONNECT, cast(WPARAM, (i)), cast(LPARAM, 0)))
#define capDriverDisconnect(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_DRIVER_DISCONNECT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capDriverGetName(hwnd, szName, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_DRIVER_GET_NAME, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szName))))))
#define capDriverGetVersion(hwnd, szVer, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_DRIVER_GET_VERSION, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szVer))))))
#define capDriverGetCaps(hwnd, s, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_DRIVER_GET_CAPS, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPCAPDRIVERCAPS, (s))))))
#define capFileSetCaptureFile(hwnd, szName) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_FILE_SET_CAPTURE_FILE, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szName))))))
#define capFileGetCaptureFile(hwnd, szName, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_FILE_GET_CAPTURE_FILE, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szName))))))
#define capFileAlloc(hwnd, dwSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_FILE_ALLOCATE, cast(WPARAM, 0), cast(LPARAM, cast(DWORD, (dwSize)))))
#define capFileSaveAs(hwnd, szName) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_FILE_SAVEAS, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szName))))))
#define capFileSetInfoChunk(hwnd, lpInfoChunk) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_FILE_SET_INFOCHUNK, cast(WPARAM, 0), cast(LPARAM, cast(LPCAPINFOCHUNK, (lpInfoChunk)))))
#define capFileSaveDIB(hwnd, szName) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_FILE_SAVEDIB, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szName))))))
#define capEditCopy(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_EDIT_COPY, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capSetAudioFormat(hwnd, s, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_AUDIOFORMAT, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPWAVEFORMATEX, (s))))))
#define capGetAudioFormat(hwnd, s, wSize) cast(DWORD, AVICapSM(hwnd, WM_CAP_GET_AUDIOFORMAT, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPWAVEFORMATEX, (s))))))
#define capGetAudioFormatSize(hwnd) cast(DWORD, AVICapSM(hwnd, WM_CAP_GET_AUDIOFORMAT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capDlgVideoFormat(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_DLG_VIDEOFORMAT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capDlgVideoSource(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_DLG_VIDEOSOURCE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capDlgVideoDisplay(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_DLG_VIDEODISPLAY, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capDlgVideoCompression(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_DLG_VIDEOCOMPRESSION, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capGetVideoFormat(hwnd, s, wSize) cast(DWORD, AVICapSM(hwnd, WM_CAP_GET_VIDEOFORMAT, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, (s)))))
#define capGetVideoFormatSize(hwnd) cast(DWORD, AVICapSM(hwnd, WM_CAP_GET_VIDEOFORMAT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capSetVideoFormat(hwnd, s, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_VIDEOFORMAT, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, (s)))))
#define capPreview(hwnd, f) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_PREVIEW, cast(WPARAM, cast(WINBOOL, (f))), cast(LPARAM, 0)))
#define capPreviewRate(hwnd, wMS) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_PREVIEWRATE, cast(WPARAM, (wMS)), cast(LPARAM, 0)))
#define capOverlay(hwnd, f) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_OVERLAY, cast(WPARAM, cast(WINBOOL, (f))), cast(LPARAM, 0)))
#define capPreviewScale(hwnd, f) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_SCALE, cast(WPARAM, cast(WINBOOL, f)), cast(LPARAM, 0)))
#define capGetStatus(hwnd, s, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_GET_STATUS, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPCAPSTATUS, (s))))))
#define capSetScrollPos(hwnd, lpP) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_SCROLL, cast(WPARAM, 0), cast(LPARAM, cast(LPPOINT, (lpP)))))
#define capGrabFrame(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_GRAB_FRAME, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capGrabFrameNoStop(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_GRAB_FRAME_NOSTOP, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capCaptureSequence(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SEQUENCE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capCaptureSequenceNoFile(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SEQUENCE_NOFILE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capCaptureStop(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_STOP, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capCaptureAbort(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_ABORT, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capCaptureSingleFrameOpen(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SINGLE_FRAME_OPEN, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capCaptureSingleFrameClose(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SINGLE_FRAME_CLOSE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capCaptureSingleFrame(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SINGLE_FRAME, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capCaptureGetSetup(hwnd, s, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_GET_SEQUENCE_SETUP, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPCAPTUREPARMS, (s))))))
#define capCaptureSetSetup(hwnd, s, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_SEQUENCE_SETUP, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPCAPTUREPARMS, (s))))))
#define capSetMCIDeviceName(hwnd, szName) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_SET_MCI_DEVICE, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szName))))))
#define capGetMCIDeviceName(hwnd, szName, wSize) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_GET_MCI_DEVICE, cast(WPARAM, (wSize)), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szName))))))
#define capPaletteOpen(hwnd, szName) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_PAL_OPEN, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szName))))))
#define capPaletteSave(hwnd, szName) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_PAL_SAVE, cast(WPARAM, 0), cast(LPARAM, cast(LPVOID, cast(LPTSTR, (szName))))))
#define capPalettePaste(hwnd) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_PAL_PASTE, cast(WPARAM, 0), cast(LPARAM, 0)))
#define capPaletteAuto(hwnd, iFrames, iColors) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_PAL_AUTOCREATE, cast(WPARAM, (iFrames)), cast(LPARAM, cast(DWORD, (iColors)))))
#define capPaletteManual(hwnd, fGrab, iColors) cast(WINBOOL, AVICapSM(hwnd, WM_CAP_PAL_MANUALCREATE, cast(WPARAM, (fGrab)), cast(LPARAM, cast(DWORD, (iColors)))))

type tagCapDriverCaps
	wDeviceIndex as UINT
	fHasOverlay as WINBOOL
	fHasDlgVideoSource as WINBOOL
	fHasDlgVideoFormat as WINBOOL
	fHasDlgVideoDisplay as WINBOOL
	fCaptureInitialized as WINBOOL
	fDriverSuppliesPalettes as WINBOOL
	hVideoIn as HANDLE
	hVideoOut as HANDLE
	hVideoExtIn as HANDLE
	hVideoExtOut as HANDLE
end type

type CAPDRIVERCAPS as tagCapDriverCaps
type PCAPDRIVERCAPS as tagCapDriverCaps ptr
type LPCAPDRIVERCAPS as tagCapDriverCaps ptr

type tagCapStatus
	uiImageWidth as UINT
	uiImageHeight as UINT
	fLiveWindow as WINBOOL
	fOverlayWindow as WINBOOL
	fScale as WINBOOL
	ptScroll as POINT
	fUsingDefaultPalette as WINBOOL
	fAudioHardware as WINBOOL
	fCapFileExists as WINBOOL
	dwCurrentVideoFrame as DWORD
	dwCurrentVideoFramesDropped as DWORD
	dwCurrentWaveSamples as DWORD
	dwCurrentTimeElapsedMS as DWORD
	hPalCurrent as HPALETTE
	fCapturingNow as WINBOOL
	dwReturn as DWORD
	wNumVideoAllocated as UINT
	wNumAudioAllocated as UINT
end type

type CAPSTATUS as tagCapStatus
type PCAPSTATUS as tagCapStatus ptr
type LPCAPSTATUS as tagCapStatus ptr

type tagCaptureParms
	dwRequestMicroSecPerFrame as DWORD
	fMakeUserHitOKToCapture as WINBOOL
	wPercentDropForError as UINT
	fYield as WINBOOL
	dwIndexSize as DWORD
	wChunkGranularity as UINT
	fUsingDOSMemory as WINBOOL
	wNumVideoRequested as UINT
	fCaptureAudio as WINBOOL
	wNumAudioRequested as UINT
	vKeyAbort as UINT
	fAbortLeftMouse as WINBOOL
	fAbortRightMouse as WINBOOL
	fLimitEnabled as WINBOOL
	wTimeLimit as UINT
	fMCIControl as WINBOOL
	fStepMCIDevice as WINBOOL
	dwMCIStartTime as DWORD
	dwMCIStopTime as DWORD
	fStepCaptureAt2x as WINBOOL
	wStepCaptureAverageFrames as UINT
	dwAudioBufferSize as DWORD
	fDisableWriteCache as WINBOOL
	AVStreamMaster as UINT
end type

type CAPTUREPARMS as tagCaptureParms
type PCAPTUREPARMS as tagCaptureParms ptr
type LPCAPTUREPARMS as tagCaptureParms ptr
const AVSTREAMMASTER_AUDIO = 0
const AVSTREAMMASTER_NONE = 1

type tagCapInfoChunk
	fccInfoID as FOURCC
	lpData as LPVOID
	cbData as LONG
end type

type CAPINFOCHUNK as tagCapInfoChunk
type PCAPINFOCHUNK as tagCapInfoChunk ptr
type LPCAPINFOCHUNK as tagCapInfoChunk ptr
type CAPYIELDCALLBACK as function(byval hWnd as HWND) as LRESULT
type CAPSTATUSCALLBACKW as function(byval hWnd as HWND, byval nID as long, byval lpsz as LPCWSTR) as LRESULT
type CAPERRORCALLBACKW as function(byval hWnd as HWND, byval nID as long, byval lpsz as LPCWSTR) as LRESULT
type CAPSTATUSCALLBACKA as function(byval hWnd as HWND, byval nID as long, byval lpsz as LPCSTR) as LRESULT
type CAPERRORCALLBACKA as function(byval hWnd as HWND, byval nID as long, byval lpsz as LPCSTR) as LRESULT

#ifdef UNICODE
	type CAPSTATUSCALLBACK as CAPSTATUSCALLBACKW
	type CAPERRORCALLBACK as CAPERRORCALLBACKW
#else
	type CAPSTATUSCALLBACK as CAPSTATUSCALLBACKA
	type CAPERRORCALLBACK as CAPERRORCALLBACKA
#endif

type CAPVIDEOCALLBACK as function(byval hWnd as HWND, byval lpVHdr as LPVIDEOHDR) as LRESULT
type CAPWAVECALLBACK as function(byval hWnd as HWND, byval lpWHdr as LPWAVEHDR) as LRESULT
type CAPCONTROLCALLBACK as function(byval hWnd as HWND, byval nState as long) as LRESULT
const CONTROLCALLBACK_PREROLL = 1
const CONTROLCALLBACK_CAPTURING = 2

declare function capCreateCaptureWindowA(byval lpszWindowName as LPCSTR, byval dwStyle as DWORD, byval x as long, byval y as long, byval nWidth as long, byval nHeight as long, byval hwndParent as HWND, byval nID as long) as HWND
declare function capGetDriverDescriptionA(byval wDriverIndex as UINT, byval lpszName as LPSTR, byval cbName as long, byval lpszVer as LPSTR, byval cbVer as long) as WINBOOL
declare function capCreateCaptureWindowW(byval lpszWindowName as LPCWSTR, byval dwStyle as DWORD, byval x as long, byval y as long, byval nWidth as long, byval nHeight as long, byval hwndParent as HWND, byval nID as long) as HWND
declare function capGetDriverDescriptionW(byval wDriverIndex as UINT, byval lpszName as LPWSTR, byval cbName as long, byval lpszVer as LPWSTR, byval cbVer as long) as WINBOOL

#ifdef UNICODE
	declare function capCreateCaptureWindow alias "capCreateCaptureWindowW"(byval lpszWindowName as LPCWSTR, byval dwStyle as DWORD, byval x as long, byval y as long, byval nWidth as long, byval nHeight as long, byval hwndParent as HWND, byval nID as long) as HWND
	declare function capGetDriverDescription alias "capGetDriverDescriptionW"(byval wDriverIndex as UINT, byval lpszName as LPWSTR, byval cbName as long, byval lpszVer as LPWSTR, byval cbVer as long) as WINBOOL
#else
	declare function capCreateCaptureWindow alias "capCreateCaptureWindowA"(byval lpszWindowName as LPCSTR, byval dwStyle as DWORD, byval x as long, byval y as long, byval nWidth as long, byval nHeight as long, byval hwndParent as HWND, byval nID as long) as HWND
	declare function capGetDriverDescription alias "capGetDriverDescriptionA"(byval wDriverIndex as UINT, byval lpszName as LPSTR, byval cbName as long, byval lpszVer as LPSTR, byval cbVer as long) as WINBOOL
#endif

#define infotypeDIGITIZATION_TIME mmioFOURCC(asc("I"), asc("D"), asc("I"), asc("T"))
#define infotypeSMPTE_TIME mmioFOURCC(asc("I"), asc("S"), asc("M"), asc("P"))
const IDS_CAP_BEGIN = 300
const IDS_CAP_END = 301
const IDS_CAP_INFO = 401
const IDS_CAP_OUTOFMEM = 402
const IDS_CAP_FILEEXISTS = 403
const IDS_CAP_ERRORPALOPEN = 404
const IDS_CAP_ERRORPALSAVE = 405
const IDS_CAP_ERRORDIBSAVE = 406
const IDS_CAP_DEFAVIEXT = 407
const IDS_CAP_DEFPALEXT = 408
const IDS_CAP_CANTOPEN = 409
const IDS_CAP_SEQ_MSGSTART = 410
const IDS_CAP_SEQ_MSGSTOP = 411
const IDS_CAP_VIDEDITERR = 412
const IDS_CAP_READONLYFILE = 413
const IDS_CAP_WRITEERROR = 414
const IDS_CAP_NODISKSPACE = 415
const IDS_CAP_SETFILESIZE = 416
const IDS_CAP_SAVEASPERCENT = 417
const IDS_CAP_DRIVER_ERROR = 418
const IDS_CAP_WAVE_OPEN_ERROR = 419
const IDS_CAP_WAVE_ALLOC_ERROR = 420
const IDS_CAP_WAVE_PREPARE_ERROR = 421
const IDS_CAP_WAVE_ADD_ERROR = 422
const IDS_CAP_WAVE_SIZE_ERROR = 423
const IDS_CAP_VIDEO_OPEN_ERROR = 424
const IDS_CAP_VIDEO_ALLOC_ERROR = 425
const IDS_CAP_VIDEO_PREPARE_ERROR = 426
const IDS_CAP_VIDEO_ADD_ERROR = 427
const IDS_CAP_VIDEO_SIZE_ERROR = 428
const IDS_CAP_FILE_OPEN_ERROR = 429
const IDS_CAP_FILE_WRITE_ERROR = 430
const IDS_CAP_RECORDING_ERROR = 431
const IDS_CAP_RECORDING_ERROR2 = 432
const IDS_CAP_AVI_INIT_ERROR = 433
const IDS_CAP_NO_FRAME_CAP_ERROR = 434
const IDS_CAP_NO_PALETTE_WARN = 435
const IDS_CAP_MCI_CONTROL_ERROR = 436
const IDS_CAP_MCI_CANT_STEP_ERROR = 437
const IDS_CAP_NO_AUDIO_CAP_ERROR = 438
const IDS_CAP_AVI_DRAWDIB_ERROR = 439
const IDS_CAP_COMPRESSOR_ERROR = 440
const IDS_CAP_AUDIO_DROP_ERROR = 441
const IDS_CAP_AUDIO_DROP_COMPERROR = 442
const IDS_CAP_STAT_LIVE_MODE = 500
const IDS_CAP_STAT_OVERLAY_MODE = 501
const IDS_CAP_STAT_CAP_INIT = 502
const IDS_CAP_STAT_CAP_FINI = 503
const IDS_CAP_STAT_PALETTE_BUILD = 504
const IDS_CAP_STAT_OPTPAL_BUILD = 505
const IDS_CAP_STAT_I_FRAMES = 506
const IDS_CAP_STAT_L_FRAMES = 507
const IDS_CAP_STAT_CAP_L_FRAMES = 508
const IDS_CAP_STAT_CAP_AUDIO = 509
const IDS_CAP_STAT_VIDEOCURRENT = 510
const IDS_CAP_STAT_VIDEOAUDIO = 511
const IDS_CAP_STAT_VIDEOONLY = 512
const IDS_CAP_STAT_FRAMESDROPPED = 513

declare function GetOpenFileNamePreviewA(byval lpofn as LPOPENFILENAMEA) as WINBOOL
declare function GetSaveFileNamePreviewA(byval lpofn as LPOPENFILENAMEA) as WINBOOL
declare function GetOpenFileNamePreviewW(byval lpofn as LPOPENFILENAMEW) as WINBOOL
declare function GetSaveFileNamePreviewW(byval lpofn as LPOPENFILENAMEW) as WINBOOL

#ifdef UNICODE
	declare function GetOpenFileNamePreview alias "GetOpenFileNamePreviewW"(byval lpofn as LPOPENFILENAMEW) as WINBOOL
	declare function GetSaveFileNamePreview alias "GetSaveFileNamePreviewW"(byval lpofn as LPOPENFILENAMEW) as WINBOOL
#else
	declare function GetOpenFileNamePreview alias "GetOpenFileNamePreviewA"(byval lpofn as LPOPENFILENAMEA) as WINBOOL
	declare function GetSaveFileNamePreview alias "GetSaveFileNamePreviewA"(byval lpofn as LPOPENFILENAMEA) as WINBOOL
#endif

end extern
