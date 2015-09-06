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

#inclib "winmm"

#include once "_mingw_unicode.bi"

extern "Windows"

#define _INC_MMSYSTEM
const MAXPNAMELEN = 32
const MAXERRORLENGTH = 256
const MAX_JOYSTICKOEMVXDNAME = 260
type MMVERSION as UINT
type MMRESULT as UINT
#define _MMRESULT_
#define DEFINED_LPUINT
type LPUINT as UINT ptr

type mmtime_tag_u_smpte field = 1
	hour as UBYTE
	min as UBYTE
	sec as UBYTE
	frame as UBYTE
	fps as UBYTE
	dummy as UBYTE
	pad(0 to 1) as UBYTE
end type

type mmtime_tag_u_midi field = 1
	songptrpos as DWORD
end type

union mmtime_tag_u field = 1
	ms as DWORD
	sample as DWORD
	cb as DWORD
	ticks as DWORD
	smpte as mmtime_tag_u_smpte
	midi as mmtime_tag_u_midi
end union

type mmtime_tag field = 1
	wType as UINT
	u as mmtime_tag_u
end type

type MMTIME as mmtime_tag
type PMMTIME as mmtime_tag ptr
type NPMMTIME as mmtime_tag ptr
type LPMMTIME as mmtime_tag ptr

const TIME_MS = &h0001
const TIME_SAMPLES = &h0002
const TIME_BYTES = &h0004
const TIME_SMPTE = &h0008
const TIME_MIDI = &h0010
const TIME_TICKS = &h0020
#define MAKEFOURCC(ch0, ch1, ch2, ch3) (((cast(DWORD, cast(UBYTE, (ch0))) or (cast(DWORD, cast(UBYTE, (ch1))) shl 8)) or (cast(DWORD, cast(UBYTE, (ch2))) shl 16)) or (cast(DWORD, cast(UBYTE, (ch3))) shl 24))
const MM_JOY1MOVE = &h3A0
const MM_JOY2MOVE = &h3A1
const MM_JOY1ZMOVE = &h3A2
const MM_JOY2ZMOVE = &h3A3
const MM_JOY1BUTTONDOWN = &h3B5
const MM_JOY2BUTTONDOWN = &h3B6
const MM_JOY1BUTTONUP = &h3B7
const MM_JOY2BUTTONUP = &h3B8
const MM_MCINOTIFY = &h3B9
const MM_WOM_OPEN = &h3BB
const MM_WOM_CLOSE = &h3BC
const MM_WOM_DONE = &h3BD
const MM_WIM_OPEN = &h3BE
const MM_WIM_CLOSE = &h3BF
const MM_WIM_DATA = &h3C0
const MM_MIM_OPEN = &h3C1
const MM_MIM_CLOSE = &h3C2
const MM_MIM_DATA = &h3C3
const MM_MIM_LONGDATA = &h3C4
const MM_MIM_ERROR = &h3C5
const MM_MIM_LONGERROR = &h3C6
const MM_MOM_OPEN = &h3C7
const MM_MOM_CLOSE = &h3C8
const MM_MOM_DONE = &h3C9
const MM_DRVM_OPEN = &h3D0
const MM_DRVM_CLOSE = &h3D1
const MM_DRVM_DATA = &h3D2
const MM_DRVM_ERROR = &h3D3
const MM_STREAM_OPEN = &h3D4
const MM_STREAM_CLOSE = &h3D5
const MM_STREAM_DONE = &h3D6
const MM_STREAM_ERROR = &h3D7
const MM_MOM_POSITIONCB = &h3CA
const MM_MCISIGNAL = &h3CB
const MM_MIM_MOREDATA = &h3CC
const MM_MIXM_LINE_CHANGE = &h3D0
const MM_MIXM_CONTROL_CHANGE = &h3D1
const MMSYSERR_BASE = 0
const WAVERR_BASE = 32
const MIDIERR_BASE = 64
const TIMERR_BASE = 96
const JOYERR_BASE = 160
const MCIERR_BASE = 256
const MIXERR_BASE = 1024
const MCI_STRING_OFFSET = 512
const MCI_VD_OFFSET = 1024
const MCI_CD_OFFSET = 1088
const MCI_WAVE_OFFSET = 1152
const MCI_SEQ_OFFSET = 1216
const MMSYSERR_NOERROR = 0
const MMSYSERR_ERROR = MMSYSERR_BASE + 1
const MMSYSERR_BADDEVICEID = MMSYSERR_BASE + 2
const MMSYSERR_NOTENABLED = MMSYSERR_BASE + 3
const MMSYSERR_ALLOCATED = MMSYSERR_BASE + 4
const MMSYSERR_INVALHANDLE = MMSYSERR_BASE + 5
const MMSYSERR_NODRIVER = MMSYSERR_BASE + 6
const MMSYSERR_NOMEM = MMSYSERR_BASE + 7
const MMSYSERR_NOTSUPPORTED = MMSYSERR_BASE + 8
const MMSYSERR_BADERRNUM = MMSYSERR_BASE + 9
const MMSYSERR_INVALFLAG = MMSYSERR_BASE + 10
const MMSYSERR_INVALPARAM = MMSYSERR_BASE + 11
const MMSYSERR_HANDLEBUSY = MMSYSERR_BASE + 12
const MMSYSERR_INVALIDALIAS = MMSYSERR_BASE + 13
const MMSYSERR_BADDB = MMSYSERR_BASE + 14
const MMSYSERR_KEYNOTFOUND = MMSYSERR_BASE + 15
const MMSYSERR_READERROR = MMSYSERR_BASE + 16
const MMSYSERR_WRITEERROR = MMSYSERR_BASE + 17
const MMSYSERR_DELETEERROR = MMSYSERR_BASE + 18
const MMSYSERR_VALNOTFOUND = MMSYSERR_BASE + 19
const MMSYSERR_NODRIVERCB = MMSYSERR_BASE + 20
const MMSYSERR_MOREDATA = MMSYSERR_BASE + 21
const MMSYSERR_LASTERROR = MMSYSERR_BASE + 21

type HDRVR__ field = 1
	unused as long
end type

type HDRVR as HDRVR__ ptr

type DRVCONFIGINFOEX field = 1
	dwDCISize as DWORD
	lpszDCISectionName as LPCWSTR
	lpszDCIAliasName as LPCWSTR
	dnDevNode as DWORD
end type

type PDRVCONFIGINFOEX as DRVCONFIGINFOEX ptr
type NPDRVCONFIGINFOEX as DRVCONFIGINFOEX ptr
type LPDRVCONFIGINFOEX as DRVCONFIGINFOEX ptr

const DRV_LOAD = &h0001
const DRV_ENABLE = &h0002
const DRV_OPEN = &h0003
const DRV_CLOSE = &h0004
const DRV_DISABLE = &h0005
const DRV_FREE = &h0006
const DRV_CONFIGURE = &h0007
const DRV_QUERYCONFIGURE = &h0008
const DRV_INSTALL = &h0009
const DRV_REMOVE = &h000A
const DRV_EXITSESSION = &h000B
const DRV_POWER = &h000F
const DRV_RESERVED = &h0800
const DRV_USER = &h4000

type tagDRVCONFIGINFO field = 1
	dwDCISize as DWORD
	lpszDCISectionName as LPCWSTR
	lpszDCIAliasName as LPCWSTR
end type

type DRVCONFIGINFO as tagDRVCONFIGINFO
type PDRVCONFIGINFO as tagDRVCONFIGINFO ptr
type NPDRVCONFIGINFO as tagDRVCONFIGINFO ptr
type LPDRVCONFIGINFO as tagDRVCONFIGINFO ptr

const DRVCNF_CANCEL = &h0000
const DRVCNF_OK = &h0001
const DRVCNF_RESTART = &h0002
type DRIVERPROC as function(byval as DWORD_PTR, byval as HDRVR, byval as UINT, byval as LPARAM, byval as LPARAM) as LRESULT

declare function CloseDriver(byval hDriver as HDRVR, byval lParam1 as LPARAM, byval lParam2 as LPARAM) as LRESULT
declare function OpenDriver(byval szDriverName as LPCWSTR, byval szSectionName as LPCWSTR, byval lParam2 as LPARAM) as HDRVR
declare function SendDriverMessage(byval hDriver as HDRVR, byval message as UINT, byval lParam1 as LPARAM, byval lParam2 as LPARAM) as LRESULT
declare function DrvGetModuleHandle(byval hDriver as HDRVR) as HMODULE
declare function GetDriverModuleHandle(byval hDriver as HDRVR) as HMODULE
declare function DefDriverProc(byval dwDriverIdentifier as DWORD_PTR, byval hdrvr as HDRVR, byval uMsg as UINT, byval lParam1 as LPARAM, byval lParam2 as LPARAM) as LRESULT

const DRV_CANCEL = DRVCNF_CANCEL
const DRV_OK = DRVCNF_OK
const DRV_RESTART = DRVCNF_RESTART
const DRV_MCI_FIRST = DRV_RESERVED
const DRV_MCI_LAST = DRV_RESERVED + &hFFF
const CALLBACK_TYPEMASK = &h00070000
const CALLBACK_NULL = &h00000000
const CALLBACK_WINDOW = &h00010000
const CALLBACK_TASK = &h00020000
const CALLBACK_FUNCTION = &h00030000
const CALLBACK_THREAD = CALLBACK_TASK
const CALLBACK_EVENT = &h00050000
type LPDRVCALLBACK as sub(byval hdrvr as HDRVR, byval uMsg as UINT, byval dwUser as DWORD_PTR, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR)
type PDRVCALLBACK as sub(byval hdrvr as HDRVR, byval uMsg as UINT, byval dwUser as DWORD_PTR, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR)

#ifdef UNICODE
	declare sub OutputDebugStr alias "OutputDebugStringW"(byval lpOutputString as LPCWSTR)
#else
	declare sub OutputDebugStr alias "OutputDebugStringA"(byval lpOutputString as LPCSTR)
#endif

declare function sndPlaySoundA(byval pszSound as LPCSTR, byval fuSound as UINT) as WINBOOL
declare function sndPlaySoundW(byval pszSound as LPCWSTR, byval fuSound as UINT) as WINBOOL

#ifdef UNICODE
	declare function sndPlaySound alias "sndPlaySoundW"(byval pszSound as LPCWSTR, byval fuSound as UINT) as WINBOOL
#else
	declare function sndPlaySound alias "sndPlaySoundA"(byval pszSound as LPCSTR, byval fuSound as UINT) as WINBOOL
#endif

const SND_SYNC = &h0000
const SND_ASYNC = &h0001
const SND_NODEFAULT = &h0002
const SND_MEMORY = &h0004
const SND_LOOP = &h0008
const SND_NOSTOP = &h0010
const SND_NOWAIT = &h00002000
const SND_ALIAS = &h00010000
const SND_ALIAS_ID = &h00110000
const SND_FILENAME = &h00020000
const SND_RESOURCE = &h00040004
const SND_PURGE = &h0040
const SND_APPLICATION = &h0080
const SND_ALIAS_START = 0
#define sndAlias(c0, c1) (SND_ALIAS_START + (cast(DWORD, cast(UBYTE, (c0))) or (cast(DWORD, cast(UBYTE, (c1))) shl 8)))
#define SND_ALIAS_SYSTEMASTERISK sndAlias(asc("S"), asc("*"))
#define SND_ALIAS_SYSTEMQUESTION sndAlias(asc("S"), asc("?"))
#define SND_ALIAS_SYSTEMHAND sndAlias(asc("S"), asc("H"))
#define SND_ALIAS_SYSTEMEXIT sndAlias(asc("S"), asc("E"))
#define SND_ALIAS_SYSTEMSTART sndAlias(asc("S"), asc("S"))
#define SND_ALIAS_SYSTEMWELCOME sndAlias(asc("S"), asc("W"))
#define SND_ALIAS_SYSTEMEXCLAMATION sndAlias(asc("S"), asc("!"))
#define SND_ALIAS_SYSTEMDEFAULT sndAlias(asc("S"), asc("D"))
declare function PlaySoundA(byval pszSound as LPCSTR, byval hmod as HMODULE, byval fdwSound as DWORD) as WINBOOL
declare function PlaySoundW(byval pszSound as LPCWSTR, byval hmod as HMODULE, byval fdwSound as DWORD) as WINBOOL

#ifdef UNICODE
	declare function PlaySound alias "PlaySoundW"(byval pszSound as LPCWSTR, byval hmod as HMODULE, byval fdwSound as DWORD) as WINBOOL
#else
	declare function PlaySound alias "PlaySoundA"(byval pszSound as LPCSTR, byval hmod as HMODULE, byval fdwSound as DWORD) as WINBOOL
#endif

const WAVERR_BADFORMAT = WAVERR_BASE + 0
const WAVERR_STILLPLAYING = WAVERR_BASE + 1
const WAVERR_UNPREPARED = WAVERR_BASE + 2
const WAVERR_SYNC = WAVERR_BASE + 3
const WAVERR_LASTERROR = WAVERR_BASE + 3

type HWAVE__ field = 1
	unused as long
end type

type HWAVE as HWAVE__ ptr

type HWAVEIN__ field = 1
	unused as long
end type

type HWAVEIN as HWAVEIN__ ptr

type HWAVEOUT__ field = 1
	unused as long
end type

type HWAVEOUT as HWAVEOUT__ ptr
type LPHWAVEIN as HWAVEIN ptr
type LPHWAVEOUT as HWAVEOUT ptr
type LPWAVECALLBACK as sub(byval hdrvr as HDRVR, byval uMsg as UINT, byval dwUser as DWORD_PTR, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR)

const WOM_OPEN = MM_WOM_OPEN
const WOM_CLOSE = MM_WOM_CLOSE
const WOM_DONE = MM_WOM_DONE
const WIM_OPEN = MM_WIM_OPEN
const WIM_CLOSE = MM_WIM_CLOSE
const WIM_DATA = MM_WIM_DATA
const WAVE_MAPPER = cast(UINT, -1)
const WAVE_FORMAT_QUERY = &h0001
const WAVE_ALLOWSYNC = &h0002
const WAVE_MAPPED = &h0004
const WAVE_FORMAT_DIRECT = &h0008
const WAVE_FORMAT_DIRECT_QUERY = WAVE_FORMAT_QUERY or WAVE_FORMAT_DIRECT

type wavehdr_tag field = 1
	lpData as LPSTR
	dwBufferLength as DWORD
	dwBytesRecorded as DWORD
	dwUser as DWORD_PTR
	dwFlags as DWORD
	dwLoops as DWORD
	lpNext as wavehdr_tag ptr
	reserved as DWORD_PTR
end type

type WAVEHDR as wavehdr_tag
type PWAVEHDR as wavehdr_tag ptr
type NPWAVEHDR as wavehdr_tag ptr
type LPWAVEHDR as wavehdr_tag ptr

const WHDR_DONE = &h00000001
const WHDR_PREPARED = &h00000002
const WHDR_BEGINLOOP = &h00000004
const WHDR_ENDLOOP = &h00000008
const WHDR_INQUEUE = &h00000010

type tagWAVEOUTCAPSA field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	dwFormats as DWORD
	wChannels as WORD
	wReserved1 as WORD
	dwSupport as DWORD
end type

type WAVEOUTCAPSA as tagWAVEOUTCAPSA
type PWAVEOUTCAPSA as tagWAVEOUTCAPSA ptr
type NPWAVEOUTCAPSA as tagWAVEOUTCAPSA ptr
type LPWAVEOUTCAPSA as tagWAVEOUTCAPSA ptr

type tagWAVEOUTCAPSW field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	dwFormats as DWORD
	wChannels as WORD
	wReserved1 as WORD
	dwSupport as DWORD
end type

type WAVEOUTCAPSW as tagWAVEOUTCAPSW
type PWAVEOUTCAPSW as tagWAVEOUTCAPSW ptr
type NPWAVEOUTCAPSW as tagWAVEOUTCAPSW ptr
type LPWAVEOUTCAPSW as tagWAVEOUTCAPSW ptr

#ifdef UNICODE
	type WAVEOUTCAPS as WAVEOUTCAPSW
	type PWAVEOUTCAPS as PWAVEOUTCAPSW
	type NPWAVEOUTCAPS as NPWAVEOUTCAPSW
	type LPWAVEOUTCAPS as LPWAVEOUTCAPSW
#else
	type WAVEOUTCAPS as WAVEOUTCAPSA
	type PWAVEOUTCAPS as PWAVEOUTCAPSA
	type NPWAVEOUTCAPS as NPWAVEOUTCAPSA
	type LPWAVEOUTCAPS as LPWAVEOUTCAPSA
#endif

type tagWAVEOUTCAPS2A field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	dwFormats as DWORD
	wChannels as WORD
	wReserved1 as WORD
	dwSupport as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type WAVEOUTCAPS2A as tagWAVEOUTCAPS2A
type PWAVEOUTCAPS2A as tagWAVEOUTCAPS2A ptr
type NPWAVEOUTCAPS2A as tagWAVEOUTCAPS2A ptr
type LPWAVEOUTCAPS2A as tagWAVEOUTCAPS2A ptr

type tagWAVEOUTCAPS2W field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	dwFormats as DWORD
	wChannels as WORD
	wReserved1 as WORD
	dwSupport as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type WAVEOUTCAPS2W as tagWAVEOUTCAPS2W
type PWAVEOUTCAPS2W as tagWAVEOUTCAPS2W ptr
type NPWAVEOUTCAPS2W as tagWAVEOUTCAPS2W ptr
type LPWAVEOUTCAPS2W as tagWAVEOUTCAPS2W ptr

#ifdef UNICODE
	type WAVEOUTCAPS2 as WAVEOUTCAPS2W
	type PWAVEOUTCAPS2 as PWAVEOUTCAPS2W
	type NPWAVEOUTCAPS2 as NPWAVEOUTCAPS2W
	type LPWAVEOUTCAPS2 as LPWAVEOUTCAPS2W
#else
	type WAVEOUTCAPS2 as WAVEOUTCAPS2A
	type PWAVEOUTCAPS2 as PWAVEOUTCAPS2A
	type NPWAVEOUTCAPS2 as NPWAVEOUTCAPS2A
	type LPWAVEOUTCAPS2 as LPWAVEOUTCAPS2A
#endif

const WAVECAPS_PITCH = &h0001
const WAVECAPS_PLAYBACKRATE = &h0002
const WAVECAPS_VOLUME = &h0004
const WAVECAPS_LRVOLUME = &h0008
const WAVECAPS_SYNC = &h0010
const WAVECAPS_SAMPLEACCURATE = &h0020

type tagWAVEINCAPSA field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	dwFormats as DWORD
	wChannels as WORD
	wReserved1 as WORD
end type

type WAVEINCAPSA as tagWAVEINCAPSA
type PWAVEINCAPSA as tagWAVEINCAPSA ptr
type NPWAVEINCAPSA as tagWAVEINCAPSA ptr
type LPWAVEINCAPSA as tagWAVEINCAPSA ptr

type tagWAVEINCAPSW field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	dwFormats as DWORD
	wChannels as WORD
	wReserved1 as WORD
end type

type WAVEINCAPSW as tagWAVEINCAPSW
type PWAVEINCAPSW as tagWAVEINCAPSW ptr
type NPWAVEINCAPSW as tagWAVEINCAPSW ptr
type LPWAVEINCAPSW as tagWAVEINCAPSW ptr

#ifdef UNICODE
	type WAVEINCAPS as WAVEINCAPSW
	type PWAVEINCAPS as PWAVEINCAPSW
	type NPWAVEINCAPS as NPWAVEINCAPSW
	type LPWAVEINCAPS as LPWAVEINCAPSW
#else
	type WAVEINCAPS as WAVEINCAPSA
	type PWAVEINCAPS as PWAVEINCAPSA
	type NPWAVEINCAPS as NPWAVEINCAPSA
	type LPWAVEINCAPS as LPWAVEINCAPSA
#endif

type tagWAVEINCAPS2A field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	dwFormats as DWORD
	wChannels as WORD
	wReserved1 as WORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type WAVEINCAPS2A as tagWAVEINCAPS2A
type PWAVEINCAPS2A as tagWAVEINCAPS2A ptr
type NPWAVEINCAPS2A as tagWAVEINCAPS2A ptr
type LPWAVEINCAPS2A as tagWAVEINCAPS2A ptr

type tagWAVEINCAPS2W field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	dwFormats as DWORD
	wChannels as WORD
	wReserved1 as WORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type WAVEINCAPS2W as tagWAVEINCAPS2W
type PWAVEINCAPS2W as tagWAVEINCAPS2W ptr
type NPWAVEINCAPS2W as tagWAVEINCAPS2W ptr
type LPWAVEINCAPS2W as tagWAVEINCAPS2W ptr

#ifdef UNICODE
	type WAVEINCAPS2 as WAVEINCAPS2W
	type PWAVEINCAPS2 as PWAVEINCAPS2W
	type NPWAVEINCAPS2 as NPWAVEINCAPS2W
	type LPWAVEINCAPS2 as LPWAVEINCAPS2W
#else
	type WAVEINCAPS2 as WAVEINCAPS2A
	type PWAVEINCAPS2 as PWAVEINCAPS2A
	type NPWAVEINCAPS2 as NPWAVEINCAPS2A
	type LPWAVEINCAPS2 as LPWAVEINCAPS2A
#endif

const WAVE_INVALIDFORMAT = &h00000000
const WAVE_FORMAT_1M08 = &h00000001
const WAVE_FORMAT_1S08 = &h00000002
const WAVE_FORMAT_1M16 = &h00000004
const WAVE_FORMAT_1S16 = &h00000008
const WAVE_FORMAT_2M08 = &h00000010
const WAVE_FORMAT_2S08 = &h00000020
const WAVE_FORMAT_2M16 = &h00000040
const WAVE_FORMAT_2S16 = &h00000080
const WAVE_FORMAT_4M08 = &h00000100
const WAVE_FORMAT_4S08 = &h00000200
const WAVE_FORMAT_4M16 = &h00000400
const WAVE_FORMAT_4S16 = &h00000800
const WAVE_FORMAT_44M08 = &h00000100
const WAVE_FORMAT_44S08 = &h00000200
const WAVE_FORMAT_44M16 = &h00000400
const WAVE_FORMAT_44S16 = &h00000800
const WAVE_FORMAT_48M08 = &h00001000
const WAVE_FORMAT_48S08 = &h00002000
const WAVE_FORMAT_48M16 = &h00004000
const WAVE_FORMAT_48S16 = &h00008000
const WAVE_FORMAT_96M08 = &h00010000
const WAVE_FORMAT_96S08 = &h00020000
const WAVE_FORMAT_96M16 = &h00040000
const WAVE_FORMAT_96S16 = &h00080000

type waveformat_tag field = 1
	wFormatTag as WORD
	nChannels as WORD
	nSamplesPerSec as DWORD
	nAvgBytesPerSec as DWORD
	nBlockAlign as WORD
end type

type WAVEFORMAT as waveformat_tag
type PWAVEFORMAT as waveformat_tag ptr
type NPWAVEFORMAT as waveformat_tag ptr
type LPWAVEFORMAT as waveformat_tag ptr
const WAVE_FORMAT_PCM = 1

type pcmwaveformat_tag field = 1
	wf as WAVEFORMAT
	wBitsPerSample as WORD
end type

type PCMWAVEFORMAT as pcmwaveformat_tag
type PPCMWAVEFORMAT as pcmwaveformat_tag ptr
type NPPCMWAVEFORMAT as pcmwaveformat_tag ptr
type LPPCMWAVEFORMAT as pcmwaveformat_tag ptr
#define _WAVEFORMATEX_

type tWAVEFORMATEX field = 1
	wFormatTag as WORD
	nChannels as WORD
	nSamplesPerSec as DWORD
	nAvgBytesPerSec as DWORD
	nBlockAlign as WORD
	wBitsPerSample as WORD
	cbSize as WORD
end type

type WAVEFORMATEX as tWAVEFORMATEX
type PWAVEFORMATEX as tWAVEFORMATEX ptr
type NPWAVEFORMATEX as tWAVEFORMATEX ptr
type LPWAVEFORMATEX as tWAVEFORMATEX ptr
type LPCWAVEFORMATEX as const WAVEFORMATEX ptr

declare function waveOutGetNumDevs() as UINT
declare function waveOutGetDevCapsA(byval uDeviceID as UINT_PTR, byval pwoc as LPWAVEOUTCAPSA, byval cbwoc as UINT) as MMRESULT
declare function waveOutGetDevCapsW(byval uDeviceID as UINT_PTR, byval pwoc as LPWAVEOUTCAPSW, byval cbwoc as UINT) as MMRESULT

#ifdef UNICODE
	declare function waveOutGetDevCaps alias "waveOutGetDevCapsW"(byval uDeviceID as UINT_PTR, byval pwoc as LPWAVEOUTCAPSW, byval cbwoc as UINT) as MMRESULT
#else
	declare function waveOutGetDevCaps alias "waveOutGetDevCapsA"(byval uDeviceID as UINT_PTR, byval pwoc as LPWAVEOUTCAPSA, byval cbwoc as UINT) as MMRESULT
#endif

declare function waveOutGetVolume(byval hwo as HWAVEOUT, byval pdwVolume as LPDWORD) as MMRESULT
declare function waveOutSetVolume(byval hwo as HWAVEOUT, byval dwVolume as DWORD) as MMRESULT
declare function waveOutGetErrorTextA(byval mmrError as MMRESULT, byval pszText as LPSTR, byval cchText as UINT) as MMRESULT
declare function waveOutGetErrorTextW(byval mmrError as MMRESULT, byval pszText as LPWSTR, byval cchText as UINT) as MMRESULT

#ifdef UNICODE
	declare function waveOutGetErrorText alias "waveOutGetErrorTextW"(byval mmrError as MMRESULT, byval pszText as LPWSTR, byval cchText as UINT) as MMRESULT
#else
	declare function waveOutGetErrorText alias "waveOutGetErrorTextA"(byval mmrError as MMRESULT, byval pszText as LPSTR, byval cchText as UINT) as MMRESULT
#endif

declare function waveOutOpen(byval phwo as LPHWAVEOUT, byval uDeviceID as UINT, byval pwfx as LPCWAVEFORMATEX, byval dwCallback as DWORD_PTR, byval dwInstance as DWORD_PTR, byval fdwOpen as DWORD) as MMRESULT
declare function waveOutClose(byval hwo as HWAVEOUT) as MMRESULT
declare function waveOutPrepareHeader(byval hwo as HWAVEOUT, byval pwh as LPWAVEHDR, byval cbwh as UINT) as MMRESULT
declare function waveOutUnprepareHeader(byval hwo as HWAVEOUT, byval pwh as LPWAVEHDR, byval cbwh as UINT) as MMRESULT
declare function waveOutWrite(byval hwo as HWAVEOUT, byval pwh as LPWAVEHDR, byval cbwh as UINT) as MMRESULT
declare function waveOutPause(byval hwo as HWAVEOUT) as MMRESULT
declare function waveOutRestart(byval hwo as HWAVEOUT) as MMRESULT
declare function waveOutReset(byval hwo as HWAVEOUT) as MMRESULT
declare function waveOutBreakLoop(byval hwo as HWAVEOUT) as MMRESULT
declare function waveOutGetPosition(byval hwo as HWAVEOUT, byval pmmt as LPMMTIME, byval cbmmt as UINT) as MMRESULT
declare function waveOutGetPitch(byval hwo as HWAVEOUT, byval pdwPitch as LPDWORD) as MMRESULT
declare function waveOutSetPitch(byval hwo as HWAVEOUT, byval dwPitch as DWORD) as MMRESULT
declare function waveOutGetPlaybackRate(byval hwo as HWAVEOUT, byval pdwRate as LPDWORD) as MMRESULT
declare function waveOutSetPlaybackRate(byval hwo as HWAVEOUT, byval dwRate as DWORD) as MMRESULT
declare function waveOutGetID(byval hwo as HWAVEOUT, byval puDeviceID as LPUINT) as MMRESULT
declare function waveOutMessage(byval hwo as HWAVEOUT, byval uMsg as UINT, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR) as MMRESULT
declare function waveInGetNumDevs() as UINT
declare function waveInGetDevCapsA(byval uDeviceID as UINT_PTR, byval pwic as LPWAVEINCAPSA, byval cbwic as UINT) as MMRESULT
declare function waveInGetDevCapsW(byval uDeviceID as UINT_PTR, byval pwic as LPWAVEINCAPSW, byval cbwic as UINT) as MMRESULT

#ifdef UNICODE
	declare function waveInGetDevCaps alias "waveInGetDevCapsW"(byval uDeviceID as UINT_PTR, byval pwic as LPWAVEINCAPSW, byval cbwic as UINT) as MMRESULT
#else
	declare function waveInGetDevCaps alias "waveInGetDevCapsA"(byval uDeviceID as UINT_PTR, byval pwic as LPWAVEINCAPSA, byval cbwic as UINT) as MMRESULT
#endif

declare function waveInGetErrorTextA(byval mmrError as MMRESULT, byval pszText as LPSTR, byval cchText as UINT) as MMRESULT
declare function waveInGetErrorTextW(byval mmrError as MMRESULT, byval pszText as LPWSTR, byval cchText as UINT) as MMRESULT

#ifdef UNICODE
	declare function waveInGetErrorText alias "waveInGetErrorTextW"(byval mmrError as MMRESULT, byval pszText as LPWSTR, byval cchText as UINT) as MMRESULT
#else
	declare function waveInGetErrorText alias "waveInGetErrorTextA"(byval mmrError as MMRESULT, byval pszText as LPSTR, byval cchText as UINT) as MMRESULT
#endif

declare function waveInOpen(byval phwi as LPHWAVEIN, byval uDeviceID as UINT, byval pwfx as LPCWAVEFORMATEX, byval dwCallback as DWORD_PTR, byval dwInstance as DWORD_PTR, byval fdwOpen as DWORD) as MMRESULT
declare function waveInClose(byval hwi as HWAVEIN) as MMRESULT
declare function waveInPrepareHeader(byval hwi as HWAVEIN, byval pwh as LPWAVEHDR, byval cbwh as UINT) as MMRESULT
declare function waveInUnprepareHeader(byval hwi as HWAVEIN, byval pwh as LPWAVEHDR, byval cbwh as UINT) as MMRESULT
declare function waveInAddBuffer(byval hwi as HWAVEIN, byval pwh as LPWAVEHDR, byval cbwh as UINT) as MMRESULT
declare function waveInStart(byval hwi as HWAVEIN) as MMRESULT
declare function waveInStop(byval hwi as HWAVEIN) as MMRESULT
declare function waveInReset(byval hwi as HWAVEIN) as MMRESULT
declare function waveInGetPosition(byval hwi as HWAVEIN, byval pmmt as LPMMTIME, byval cbmmt as UINT) as MMRESULT
declare function waveInGetID(byval hwi as HWAVEIN, byval puDeviceID as LPUINT) as MMRESULT
declare function waveInMessage(byval hwi as HWAVEIN, byval uMsg as UINT, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR) as MMRESULT

const MIDIERR_UNPREPARED = MIDIERR_BASE + 0
const MIDIERR_STILLPLAYING = MIDIERR_BASE + 1
const MIDIERR_NOMAP = MIDIERR_BASE + 2
const MIDIERR_NOTREADY = MIDIERR_BASE + 3
const MIDIERR_NODEVICE = MIDIERR_BASE + 4
const MIDIERR_INVALIDSETUP = MIDIERR_BASE + 5
const MIDIERR_BADOPENMODE = MIDIERR_BASE + 6
const MIDIERR_DONT_CONTINUE = MIDIERR_BASE + 7
const MIDIERR_LASTERROR = MIDIERR_BASE + 7

type HMIDI__ field = 1
	unused as long
end type

type HMIDI as HMIDI__ ptr

type HMIDIIN__ field = 1
	unused as long
end type

type HMIDIIN as HMIDIIN__ ptr

type HMIDIOUT__ field = 1
	unused as long
end type

type HMIDIOUT as HMIDIOUT__ ptr

type HMIDISTRM__ field = 1
	unused as long
end type

type HMIDISTRM as HMIDISTRM__ ptr
type LPHMIDI as HMIDI ptr
type LPHMIDIIN as HMIDIIN ptr
type LPHMIDIOUT as HMIDIOUT ptr
type LPHMIDISTRM as HMIDISTRM ptr
type LPMIDICALLBACK as sub(byval hdrvr as HDRVR, byval uMsg as UINT, byval dwUser as DWORD_PTR, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR)
const MIDIPATCHSIZE = 128
type LPPATCHARRAY as WORD ptr
type LPKEYARRAY as WORD ptr

const MIM_OPEN = MM_MIM_OPEN
const MIM_CLOSE = MM_MIM_CLOSE
const MIM_DATA = MM_MIM_DATA
const MIM_LONGDATA = MM_MIM_LONGDATA
const MIM_ERROR = MM_MIM_ERROR
const MIM_LONGERROR = MM_MIM_LONGERROR
const MOM_OPEN = MM_MOM_OPEN
const MOM_CLOSE = MM_MOM_CLOSE
const MOM_DONE = MM_MOM_DONE
const MIM_MOREDATA = MM_MIM_MOREDATA
const MOM_POSITIONCB = MM_MOM_POSITIONCB
const MIDIMAPPER = cast(UINT, -1)
const MIDI_MAPPER = cast(UINT, -1)
const MIDI_IO_STATUS = &h00000020
const MIDI_CACHE_ALL = 1
const MIDI_CACHE_BESTFIT = 2
const MIDI_CACHE_QUERY = 3
const MIDI_UNCACHE = 4

type tagMIDIOUTCAPSA field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	wTechnology as WORD
	wVoices as WORD
	wNotes as WORD
	wChannelMask as WORD
	dwSupport as DWORD
end type

type MIDIOUTCAPSA as tagMIDIOUTCAPSA
type PMIDIOUTCAPSA as tagMIDIOUTCAPSA ptr
type NPMIDIOUTCAPSA as tagMIDIOUTCAPSA ptr
type LPMIDIOUTCAPSA as tagMIDIOUTCAPSA ptr

type tagMIDIOUTCAPSW field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	wTechnology as WORD
	wVoices as WORD
	wNotes as WORD
	wChannelMask as WORD
	dwSupport as DWORD
end type

type MIDIOUTCAPSW as tagMIDIOUTCAPSW
type PMIDIOUTCAPSW as tagMIDIOUTCAPSW ptr
type NPMIDIOUTCAPSW as tagMIDIOUTCAPSW ptr
type LPMIDIOUTCAPSW as tagMIDIOUTCAPSW ptr

#ifdef UNICODE
	type MIDIOUTCAPS as MIDIOUTCAPSW
	type PMIDIOUTCAPS as PMIDIOUTCAPSW
	type NPMIDIOUTCAPS as NPMIDIOUTCAPSW
	type LPMIDIOUTCAPS as LPMIDIOUTCAPSW
#else
	type MIDIOUTCAPS as MIDIOUTCAPSA
	type PMIDIOUTCAPS as PMIDIOUTCAPSA
	type NPMIDIOUTCAPS as NPMIDIOUTCAPSA
	type LPMIDIOUTCAPS as LPMIDIOUTCAPSA
#endif

type tagMIDIOUTCAPS2A field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	wTechnology as WORD
	wVoices as WORD
	wNotes as WORD
	wChannelMask as WORD
	dwSupport as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type MIDIOUTCAPS2A as tagMIDIOUTCAPS2A
type PMIDIOUTCAPS2A as tagMIDIOUTCAPS2A ptr
type NPMIDIOUTCAPS2A as tagMIDIOUTCAPS2A ptr
type LPMIDIOUTCAPS2A as tagMIDIOUTCAPS2A ptr

type tagMIDIOUTCAPS2W field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	wTechnology as WORD
	wVoices as WORD
	wNotes as WORD
	wChannelMask as WORD
	dwSupport as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type MIDIOUTCAPS2W as tagMIDIOUTCAPS2W
type PMIDIOUTCAPS2W as tagMIDIOUTCAPS2W ptr
type NPMIDIOUTCAPS2W as tagMIDIOUTCAPS2W ptr
type LPMIDIOUTCAPS2W as tagMIDIOUTCAPS2W ptr

#ifdef UNICODE
	type MIDIOUTCAPS2 as MIDIOUTCAPS2W
	type PMIDIOUTCAPS2 as PMIDIOUTCAPS2W
	type NPMIDIOUTCAPS2 as NPMIDIOUTCAPS2W
	type LPMIDIOUTCAPS2 as LPMIDIOUTCAPS2W
#else
	type MIDIOUTCAPS2 as MIDIOUTCAPS2A
	type PMIDIOUTCAPS2 as PMIDIOUTCAPS2A
	type NPMIDIOUTCAPS2 as NPMIDIOUTCAPS2A
	type LPMIDIOUTCAPS2 as LPMIDIOUTCAPS2A
#endif

const MOD_MIDIPORT = 1
const MOD_SYNTH = 2
const MOD_SQSYNTH = 3
const MOD_FMSYNTH = 4
const MOD_MAPPER = 5
const MOD_WAVETABLE = 6
const MOD_SWSYNTH = 7
const MIDICAPS_VOLUME = &h0001
const MIDICAPS_LRVOLUME = &h0002
const MIDICAPS_CACHE = &h0004
const MIDICAPS_STREAM = &h0008

type tagMIDIINCAPSA field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	dwSupport as DWORD
end type

type MIDIINCAPSA as tagMIDIINCAPSA
type PMIDIINCAPSA as tagMIDIINCAPSA ptr
type NPMIDIINCAPSA as tagMIDIINCAPSA ptr
type LPMIDIINCAPSA as tagMIDIINCAPSA ptr

type tagMIDIINCAPSW field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	dwSupport as DWORD
end type

type MIDIINCAPSW as tagMIDIINCAPSW
type PMIDIINCAPSW as tagMIDIINCAPSW ptr
type NPMIDIINCAPSW as tagMIDIINCAPSW ptr
type LPMIDIINCAPSW as tagMIDIINCAPSW ptr

#ifdef UNICODE
	type MIDIINCAPS as MIDIINCAPSW
	type PMIDIINCAPS as PMIDIINCAPSW
	type NPMIDIINCAPS as NPMIDIINCAPSW
	type LPMIDIINCAPS as LPMIDIINCAPSW
#else
	type MIDIINCAPS as MIDIINCAPSA
	type PMIDIINCAPS as PMIDIINCAPSA
	type NPMIDIINCAPS as NPMIDIINCAPSA
	type LPMIDIINCAPS as LPMIDIINCAPSA
#endif

type tagMIDIINCAPS2A field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	dwSupport as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type MIDIINCAPS2A as tagMIDIINCAPS2A
type PMIDIINCAPS2A as tagMIDIINCAPS2A ptr
type NPMIDIINCAPS2A as tagMIDIINCAPS2A ptr
type LPMIDIINCAPS2A as tagMIDIINCAPS2A ptr

type tagMIDIINCAPS2W field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	dwSupport as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type MIDIINCAPS2W as tagMIDIINCAPS2W
type PMIDIINCAPS2W as tagMIDIINCAPS2W ptr
type NPMIDIINCAPS2W as tagMIDIINCAPS2W ptr
type LPMIDIINCAPS2W as tagMIDIINCAPS2W ptr

#ifdef UNICODE
	type MIDIINCAPS2 as MIDIINCAPS2W
	type PMIDIINCAPS2 as PMIDIINCAPS2W
	type NPMIDIINCAPS2 as NPMIDIINCAPS2W
	type LPMIDIINCAPS2 as LPMIDIINCAPS2W
#else
	type MIDIINCAPS2 as MIDIINCAPS2A
	type PMIDIINCAPS2 as PMIDIINCAPS2A
	type NPMIDIINCAPS2 as NPMIDIINCAPS2A
	type LPMIDIINCAPS2 as LPMIDIINCAPS2A
#endif

type midihdr_tag field = 1
	lpData as LPSTR
	dwBufferLength as DWORD
	dwBytesRecorded as DWORD
	dwUser as DWORD_PTR
	dwFlags as DWORD
	lpNext as midihdr_tag ptr
	reserved as DWORD_PTR
	dwOffset as DWORD
	dwReserved(0 to 7) as DWORD_PTR
end type

type MIDIHDR as midihdr_tag
type PMIDIHDR as midihdr_tag ptr
type NPMIDIHDR as midihdr_tag ptr
type LPMIDIHDR as midihdr_tag ptr

type midievent_tag field = 1
	dwDeltaTime as DWORD
	dwStreamID as DWORD
	dwEvent as DWORD
	dwParms(0 to 0) as DWORD
end type

type MIDIEVENT as midievent_tag

type midistrmbuffver_tag field = 1
	dwVersion as DWORD
	dwMid as DWORD
	dwOEMVersion as DWORD
end type

type MIDISTRMBUFFVER as midistrmbuffver_tag
const MHDR_DONE = &h00000001
const MHDR_PREPARED = &h00000002
const MHDR_INQUEUE = &h00000004
const MHDR_ISSTRM = &h00000008
const MEVT_F_SHORT = &h00000000
const MEVT_F_LONG = &h80000000
const MEVT_F_CALLBACK = &h40000000
#define MEVT_EVENTTYPE(x) cast(UBYTE, ((x) shr 24) and &hFF)
#define MEVT_EVENTPARM(x) cast(DWORD, (x) and &h00FFFFFF)
const MEVT_SHORTMSG = cast(UBYTE, &h00)
const MEVT_TEMPO = cast(UBYTE, &h01)
const MEVT_NOP = cast(UBYTE, &h02)
const MEVT_LONGMSG = cast(UBYTE, &h80)
const MEVT_COMMENT = cast(UBYTE, &h82)
const MEVT_VERSION = cast(UBYTE, &h84)
const MIDISTRM_ERROR = -2
const MIDIPROP_SET = &h80000000
const MIDIPROP_GET = &h40000000
const MIDIPROP_TIMEDIV = &h00000001
const MIDIPROP_TEMPO = &h00000002

type midiproptimediv_tag field = 1
	cbStruct as DWORD
	dwTimeDiv as DWORD
end type

type MIDIPROPTIMEDIV as midiproptimediv_tag
type LPMIDIPROPTIMEDIV as midiproptimediv_tag ptr

type midiproptempo_tag field = 1
	cbStruct as DWORD
	dwTempo as DWORD
end type

type MIDIPROPTEMPO as midiproptempo_tag
type LPMIDIPROPTEMPO as midiproptempo_tag ptr
declare function midiOutGetNumDevs() as UINT
declare function midiStreamOpen(byval phms as LPHMIDISTRM, byval puDeviceID as LPUINT, byval cMidi as DWORD, byval dwCallback as DWORD_PTR, byval dwInstance as DWORD_PTR, byval fdwOpen as DWORD) as MMRESULT
declare function midiStreamClose(byval hms as HMIDISTRM) as MMRESULT
declare function midiStreamProperty(byval hms as HMIDISTRM, byval lppropdata as LPBYTE, byval dwProperty as DWORD) as MMRESULT
declare function midiStreamPosition(byval hms as HMIDISTRM, byval lpmmt as LPMMTIME, byval cbmmt as UINT) as MMRESULT
declare function midiStreamOut(byval hms as HMIDISTRM, byval pmh as LPMIDIHDR, byval cbmh as UINT) as MMRESULT
declare function midiStreamPause(byval hms as HMIDISTRM) as MMRESULT
declare function midiStreamRestart(byval hms as HMIDISTRM) as MMRESULT
declare function midiStreamStop(byval hms as HMIDISTRM) as MMRESULT
declare function midiConnect(byval hmi as HMIDI, byval hmo as HMIDIOUT, byval pReserved as LPVOID) as MMRESULT
declare function midiDisconnect(byval hmi as HMIDI, byval hmo as HMIDIOUT, byval pReserved as LPVOID) as MMRESULT
declare function midiOutGetDevCapsA(byval uDeviceID as UINT_PTR, byval pmoc as LPMIDIOUTCAPSA, byval cbmoc as UINT) as MMRESULT
declare function midiOutGetDevCapsW(byval uDeviceID as UINT_PTR, byval pmoc as LPMIDIOUTCAPSW, byval cbmoc as UINT) as MMRESULT

#ifdef UNICODE
	declare function midiOutGetDevCaps alias "midiOutGetDevCapsW"(byval uDeviceID as UINT_PTR, byval pmoc as LPMIDIOUTCAPSW, byval cbmoc as UINT) as MMRESULT
#else
	declare function midiOutGetDevCaps alias "midiOutGetDevCapsA"(byval uDeviceID as UINT_PTR, byval pmoc as LPMIDIOUTCAPSA, byval cbmoc as UINT) as MMRESULT
#endif

declare function midiOutGetVolume(byval hmo as HMIDIOUT, byval pdwVolume as LPDWORD) as MMRESULT
declare function midiOutSetVolume(byval hmo as HMIDIOUT, byval dwVolume as DWORD) as MMRESULT
declare function midiOutGetErrorTextA(byval mmrError as MMRESULT, byval pszText as LPSTR, byval cchText as UINT) as MMRESULT
declare function midiOutGetErrorTextW(byval mmrError as MMRESULT, byval pszText as LPWSTR, byval cchText as UINT) as MMRESULT

#ifdef UNICODE
	declare function midiOutGetErrorText alias "midiOutGetErrorTextW"(byval mmrError as MMRESULT, byval pszText as LPWSTR, byval cchText as UINT) as MMRESULT
#else
	declare function midiOutGetErrorText alias "midiOutGetErrorTextA"(byval mmrError as MMRESULT, byval pszText as LPSTR, byval cchText as UINT) as MMRESULT
#endif

declare function midiOutOpen(byval phmo as LPHMIDIOUT, byval uDeviceID as UINT, byval dwCallback as DWORD_PTR, byval dwInstance as DWORD_PTR, byval fdwOpen as DWORD) as MMRESULT
declare function midiOutClose(byval hmo as HMIDIOUT) as MMRESULT
declare function midiOutPrepareHeader(byval hmo as HMIDIOUT, byval pmh as LPMIDIHDR, byval cbmh as UINT) as MMRESULT
declare function midiOutUnprepareHeader(byval hmo as HMIDIOUT, byval pmh as LPMIDIHDR, byval cbmh as UINT) as MMRESULT
declare function midiOutShortMsg(byval hmo as HMIDIOUT, byval dwMsg as DWORD) as MMRESULT
declare function midiOutLongMsg(byval hmo as HMIDIOUT, byval pmh as LPMIDIHDR, byval cbmh as UINT) as MMRESULT
declare function midiOutReset(byval hmo as HMIDIOUT) as MMRESULT
declare function midiOutCachePatches(byval hmo as HMIDIOUT, byval uBank as UINT, byval pwpa as LPWORD, byval fuCache as UINT) as MMRESULT
declare function midiOutCacheDrumPatches(byval hmo as HMIDIOUT, byval uPatch as UINT, byval pwkya as LPWORD, byval fuCache as UINT) as MMRESULT
declare function midiOutGetID(byval hmo as HMIDIOUT, byval puDeviceID as LPUINT) as MMRESULT
declare function midiOutMessage(byval hmo as HMIDIOUT, byval uMsg as UINT, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR) as MMRESULT
declare function midiInGetNumDevs() as UINT
declare function midiInGetDevCapsA(byval uDeviceID as UINT_PTR, byval pmic as LPMIDIINCAPSA, byval cbmic as UINT) as MMRESULT
declare function midiInGetDevCapsW(byval uDeviceID as UINT_PTR, byval pmic as LPMIDIINCAPSW, byval cbmic as UINT) as MMRESULT

#ifdef UNICODE
	declare function midiInGetDevCaps alias "midiInGetDevCapsW"(byval uDeviceID as UINT_PTR, byval pmic as LPMIDIINCAPSW, byval cbmic as UINT) as MMRESULT
#else
	declare function midiInGetDevCaps alias "midiInGetDevCapsA"(byval uDeviceID as UINT_PTR, byval pmic as LPMIDIINCAPSA, byval cbmic as UINT) as MMRESULT
#endif

declare function midiInGetErrorTextA(byval mmrError as MMRESULT, byval pszText as LPSTR, byval cchText as UINT) as MMRESULT
declare function midiInGetErrorTextW(byval mmrError as MMRESULT, byval pszText as LPWSTR, byval cchText as UINT) as MMRESULT

#ifdef UNICODE
	declare function midiInGetErrorText alias "midiInGetErrorTextW"(byval mmrError as MMRESULT, byval pszText as LPWSTR, byval cchText as UINT) as MMRESULT
#else
	declare function midiInGetErrorText alias "midiInGetErrorTextA"(byval mmrError as MMRESULT, byval pszText as LPSTR, byval cchText as UINT) as MMRESULT
#endif

declare function midiInOpen(byval phmi as LPHMIDIIN, byval uDeviceID as UINT, byval dwCallback as DWORD_PTR, byval dwInstance as DWORD_PTR, byval fdwOpen as DWORD) as MMRESULT
declare function midiInClose(byval hmi as HMIDIIN) as MMRESULT
declare function midiInPrepareHeader(byval hmi as HMIDIIN, byval pmh as LPMIDIHDR, byval cbmh as UINT) as MMRESULT
declare function midiInUnprepareHeader(byval hmi as HMIDIIN, byval pmh as LPMIDIHDR, byval cbmh as UINT) as MMRESULT
declare function midiInAddBuffer(byval hmi as HMIDIIN, byval pmh as LPMIDIHDR, byval cbmh as UINT) as MMRESULT
declare function midiInStart(byval hmi as HMIDIIN) as MMRESULT
declare function midiInStop(byval hmi as HMIDIIN) as MMRESULT
declare function midiInReset(byval hmi as HMIDIIN) as MMRESULT
declare function midiInGetID(byval hmi as HMIDIIN, byval puDeviceID as LPUINT) as MMRESULT
declare function midiInMessage(byval hmi as HMIDIIN, byval uMsg as UINT, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR) as MMRESULT
const AUX_MAPPER = cast(UINT, -1)

type tagAUXCAPSA field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	wTechnology as WORD
	wReserved1 as WORD
	dwSupport as DWORD
end type

type AUXCAPSA as tagAUXCAPSA
type PAUXCAPSA as tagAUXCAPSA ptr
type NPAUXCAPSA as tagAUXCAPSA ptr
type LPAUXCAPSA as tagAUXCAPSA ptr

type tagAUXCAPSW field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	wTechnology as WORD
	wReserved1 as WORD
	dwSupport as DWORD
end type

type AUXCAPSW as tagAUXCAPSW
type PAUXCAPSW as tagAUXCAPSW ptr
type NPAUXCAPSW as tagAUXCAPSW ptr
type LPAUXCAPSW as tagAUXCAPSW ptr

#ifdef UNICODE
	type AUXCAPS as AUXCAPSW
	type PAUXCAPS as PAUXCAPSW
	type NPAUXCAPS as NPAUXCAPSW
	type LPAUXCAPS as LPAUXCAPSW
#else
	type AUXCAPS as AUXCAPSA
	type PAUXCAPS as PAUXCAPSA
	type NPAUXCAPS as NPAUXCAPSA
	type LPAUXCAPS as LPAUXCAPSA
#endif

type tagAUXCAPS2A field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	wTechnology as WORD
	wReserved1 as WORD
	dwSupport as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type AUXCAPS2A as tagAUXCAPS2A
type PAUXCAPS2A as tagAUXCAPS2A ptr
type NPAUXCAPS2A as tagAUXCAPS2A ptr
type LPAUXCAPS2A as tagAUXCAPS2A ptr

type tagAUXCAPS2W field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	wTechnology as WORD
	wReserved1 as WORD
	dwSupport as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type AUXCAPS2W as tagAUXCAPS2W
type PAUXCAPS2W as tagAUXCAPS2W ptr
type NPAUXCAPS2W as tagAUXCAPS2W ptr
type LPAUXCAPS2W as tagAUXCAPS2W ptr

#ifdef UNICODE
	type AUXCAPS2 as AUXCAPS2W
	type PAUXCAPS2 as PAUXCAPS2W
	type NPAUXCAPS2 as NPAUXCAPS2W
	type LPAUXCAPS2 as LPAUXCAPS2W
#else
	type AUXCAPS2 as AUXCAPS2A
	type PAUXCAPS2 as PAUXCAPS2A
	type NPAUXCAPS2 as NPAUXCAPS2A
	type LPAUXCAPS2 as LPAUXCAPS2A
#endif

const AUXCAPS_CDAUDIO = 1
const AUXCAPS_AUXIN = 2
const AUXCAPS_VOLUME = &h0001
const AUXCAPS_LRVOLUME = &h0002

declare function auxGetNumDevs() as UINT
declare function auxGetDevCapsA(byval uDeviceID as UINT_PTR, byval pac as LPAUXCAPSA, byval cbac as UINT) as MMRESULT
declare function auxGetDevCapsW(byval uDeviceID as UINT_PTR, byval pac as LPAUXCAPSW, byval cbac as UINT) as MMRESULT

#ifdef UNICODE
	declare function auxGetDevCaps alias "auxGetDevCapsW"(byval uDeviceID as UINT_PTR, byval pac as LPAUXCAPSW, byval cbac as UINT) as MMRESULT
#else
	declare function auxGetDevCaps alias "auxGetDevCapsA"(byval uDeviceID as UINT_PTR, byval pac as LPAUXCAPSA, byval cbac as UINT) as MMRESULT
#endif

declare function auxSetVolume(byval uDeviceID as UINT, byval dwVolume as DWORD) as MMRESULT
declare function auxGetVolume(byval uDeviceID as UINT, byval pdwVolume as LPDWORD) as MMRESULT
declare function auxOutMessage(byval uDeviceID as UINT, byval uMsg as UINT, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR) as MMRESULT

type HMIXEROBJ__ field = 1
	unused as long
end type

type HMIXEROBJ as HMIXEROBJ__ ptr
type LPHMIXEROBJ as HMIXEROBJ ptr

type HMIXER__ field = 1
	unused as long
end type

type HMIXER as HMIXER__ ptr
type LPHMIXER as HMIXER ptr
const MIXER_SHORT_NAME_CHARS = 16
const MIXER_LONG_NAME_CHARS = 64
const MIXERR_INVALLINE = MIXERR_BASE + 0
const MIXERR_INVALCONTROL = MIXERR_BASE + 1
const MIXERR_INVALVALUE = MIXERR_BASE + 2
const MIXERR_LASTERROR = MIXERR_BASE + 2
const MIXER_OBJECTF_HANDLE = &h80000000
const MIXER_OBJECTF_MIXER = &h00000000
const MIXER_OBJECTF_HMIXER = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_MIXER
const MIXER_OBJECTF_WAVEOUT = &h10000000
const MIXER_OBJECTF_HWAVEOUT = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_WAVEOUT
const MIXER_OBJECTF_WAVEIN = &h20000000
const MIXER_OBJECTF_HWAVEIN = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_WAVEIN
const MIXER_OBJECTF_MIDIOUT = &h30000000
const MIXER_OBJECTF_HMIDIOUT = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_MIDIOUT
const MIXER_OBJECTF_MIDIIN = &h40000000
const MIXER_OBJECTF_HMIDIIN = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_MIDIIN
const MIXER_OBJECTF_AUX = &h50000000
declare function mixerGetNumDevs() as UINT

type tagMIXERCAPSA field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	fdwSupport as DWORD
	cDestinations as DWORD
end type

type MIXERCAPSA as tagMIXERCAPSA
type PMIXERCAPSA as tagMIXERCAPSA ptr
type LPMIXERCAPSA as tagMIXERCAPSA ptr

type tagMIXERCAPSW field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	fdwSupport as DWORD
	cDestinations as DWORD
end type

type MIXERCAPSW as tagMIXERCAPSW
type PMIXERCAPSW as tagMIXERCAPSW ptr
type LPMIXERCAPSW as tagMIXERCAPSW ptr

#ifdef UNICODE
	type MIXERCAPS as MIXERCAPSW
	type PMIXERCAPS as PMIXERCAPSW
	type LPMIXERCAPS as LPMIXERCAPSW
#else
	type MIXERCAPS as MIXERCAPSA
	type PMIXERCAPS as PMIXERCAPSA
	type LPMIXERCAPS as LPMIXERCAPSA
#endif

type tagMIXERCAPS2A field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
	fdwSupport as DWORD
	cDestinations as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type MIXERCAPS2A as tagMIXERCAPS2A
type PMIXERCAPS2A as tagMIXERCAPS2A ptr
type LPMIXERCAPS2A as tagMIXERCAPS2A ptr

type tagMIXERCAPS2W field = 1
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
	fdwSupport as DWORD
	cDestinations as DWORD
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type MIXERCAPS2W as tagMIXERCAPS2W
type PMIXERCAPS2W as tagMIXERCAPS2W ptr
type LPMIXERCAPS2W as tagMIXERCAPS2W ptr

#ifdef UNICODE
	type MIXERCAPS2 as MIXERCAPS2W
	type PMIXERCAPS2 as PMIXERCAPS2W
	type LPMIXERCAPS2 as LPMIXERCAPS2W
#else
	type MIXERCAPS2 as MIXERCAPS2A
	type PMIXERCAPS2 as PMIXERCAPS2A
	type LPMIXERCAPS2 as LPMIXERCAPS2A
#endif

declare function mixerGetDevCapsA(byval uMxId as UINT_PTR, byval pmxcaps as LPMIXERCAPSA, byval cbmxcaps as UINT) as MMRESULT
declare function mixerGetDevCapsW(byval uMxId as UINT_PTR, byval pmxcaps as LPMIXERCAPSW, byval cbmxcaps as UINT) as MMRESULT

#ifdef UNICODE
	declare function mixerGetDevCaps alias "mixerGetDevCapsW"(byval uMxId as UINT_PTR, byval pmxcaps as LPMIXERCAPSW, byval cbmxcaps as UINT) as MMRESULT
#else
	declare function mixerGetDevCaps alias "mixerGetDevCapsA"(byval uMxId as UINT_PTR, byval pmxcaps as LPMIXERCAPSA, byval cbmxcaps as UINT) as MMRESULT
#endif

declare function mixerOpen(byval phmx as LPHMIXER, byval uMxId as UINT, byval dwCallback as DWORD_PTR, byval dwInstance as DWORD_PTR, byval fdwOpen as DWORD) as MMRESULT
declare function mixerClose(byval hmx as HMIXER) as MMRESULT
declare function mixerMessage(byval hmx as HMIXER, byval uMsg as UINT, byval dwParam1 as DWORD_PTR, byval dwParam2 as DWORD_PTR) as DWORD

type tagMIXERLINEA_Target field = 1
	dwType as DWORD
	dwDeviceID as DWORD
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as zstring * 32
end type

type tagMIXERLINEA field = 1
	cbStruct as DWORD
	dwDestination as DWORD
	dwSource as DWORD
	dwLineID as DWORD
	fdwLine as DWORD
	dwUser as DWORD_PTR
	dwComponentType as DWORD
	cChannels as DWORD
	cConnections as DWORD
	cControls as DWORD
	szShortName as zstring * 16
	szName as zstring * 64
	Target as tagMIXERLINEA_Target
end type

type MIXERLINEA as tagMIXERLINEA
type PMIXERLINEA as tagMIXERLINEA ptr
type LPMIXERLINEA as tagMIXERLINEA ptr

type tagMIXERLINEW_Target field = 1
	dwType as DWORD
	dwDeviceID as DWORD
	wMid as WORD
	wPid as WORD
	vDriverVersion as MMVERSION
	szPname as wstring * 32
end type

type tagMIXERLINEW field = 1
	cbStruct as DWORD
	dwDestination as DWORD
	dwSource as DWORD
	dwLineID as DWORD
	fdwLine as DWORD
	dwUser as DWORD_PTR
	dwComponentType as DWORD
	cChannels as DWORD
	cConnections as DWORD
	cControls as DWORD
	szShortName as wstring * 16
	szName as wstring * 64
	Target as tagMIXERLINEW_Target
end type

type MIXERLINEW as tagMIXERLINEW
type PMIXERLINEW as tagMIXERLINEW ptr
type LPMIXERLINEW as tagMIXERLINEW ptr

#ifdef UNICODE
	type MIXERLINE as MIXERLINEW
	type PMIXERLINE as PMIXERLINEW
	type LPMIXERLINE as LPMIXERLINEW
#else
	type MIXERLINE as MIXERLINEA
	type PMIXERLINE as PMIXERLINEA
	type LPMIXERLINE as LPMIXERLINEA
#endif

const MIXERLINE_LINEF_ACTIVE = &h00000001
const MIXERLINE_LINEF_DISCONNECTED = &h00008000
const MIXERLINE_LINEF_SOURCE = &h80000000
const MIXERLINE_COMPONENTTYPE_DST_FIRST = &h0
const MIXERLINE_COMPONENTTYPE_DST_UNDEFINED = MIXERLINE_COMPONENTTYPE_DST_FIRST + 0
const MIXERLINE_COMPONENTTYPE_DST_DIGITAL = MIXERLINE_COMPONENTTYPE_DST_FIRST + 1
const MIXERLINE_COMPONENTTYPE_DST_LINE = MIXERLINE_COMPONENTTYPE_DST_FIRST + 2
const MIXERLINE_COMPONENTTYPE_DST_MONITOR = MIXERLINE_COMPONENTTYPE_DST_FIRST + 3
const MIXERLINE_COMPONENTTYPE_DST_SPEAKERS = MIXERLINE_COMPONENTTYPE_DST_FIRST + 4
const MIXERLINE_COMPONENTTYPE_DST_HEADPHONES = MIXERLINE_COMPONENTTYPE_DST_FIRST + 5
const MIXERLINE_COMPONENTTYPE_DST_TELEPHONE = MIXERLINE_COMPONENTTYPE_DST_FIRST + 6
const MIXERLINE_COMPONENTTYPE_DST_WAVEIN = MIXERLINE_COMPONENTTYPE_DST_FIRST + 7
const MIXERLINE_COMPONENTTYPE_DST_VOICEIN = MIXERLINE_COMPONENTTYPE_DST_FIRST + 8
const MIXERLINE_COMPONENTTYPE_DST_LAST = MIXERLINE_COMPONENTTYPE_DST_FIRST + 8
const MIXERLINE_COMPONENTTYPE_SRC_FIRST = &h00001000
const MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 0
const MIXERLINE_COMPONENTTYPE_SRC_DIGITAL = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 1
const MIXERLINE_COMPONENTTYPE_SRC_LINE = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 2
const MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 3
const MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 4
const MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 5
const MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 6
const MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 7
const MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 8
const MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 9
const MIXERLINE_COMPONENTTYPE_SRC_ANALOG = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 10
const MIXERLINE_COMPONENTTYPE_SRC_LAST = MIXERLINE_COMPONENTTYPE_SRC_FIRST + 10
const MIXERLINE_TARGETTYPE_UNDEFINED = 0
const MIXERLINE_TARGETTYPE_WAVEOUT = 1
const MIXERLINE_TARGETTYPE_WAVEIN = 2
const MIXERLINE_TARGETTYPE_MIDIOUT = 3
const MIXERLINE_TARGETTYPE_MIDIIN = 4
const MIXERLINE_TARGETTYPE_AUX = 5
declare function mixerGetLineInfoA(byval hmxobj as HMIXEROBJ, byval pmxl as LPMIXERLINEA, byval fdwInfo as DWORD) as MMRESULT
declare function mixerGetLineInfoW(byval hmxobj as HMIXEROBJ, byval pmxl as LPMIXERLINEW, byval fdwInfo as DWORD) as MMRESULT

#ifdef UNICODE
	declare function mixerGetLineInfo alias "mixerGetLineInfoW"(byval hmxobj as HMIXEROBJ, byval pmxl as LPMIXERLINEW, byval fdwInfo as DWORD) as MMRESULT
#else
	declare function mixerGetLineInfo alias "mixerGetLineInfoA"(byval hmxobj as HMIXEROBJ, byval pmxl as LPMIXERLINEA, byval fdwInfo as DWORD) as MMRESULT
#endif

const MIXER_GETLINEINFOF_DESTINATION = &h00000000
const MIXER_GETLINEINFOF_SOURCE = &h00000001
const MIXER_GETLINEINFOF_LINEID = &h00000002
const MIXER_GETLINEINFOF_COMPONENTTYPE = &h00000003
const MIXER_GETLINEINFOF_TARGETTYPE = &h00000004
const MIXER_GETLINEINFOF_QUERYMASK = &h0000000F
declare function mixerGetID(byval hmxobj as HMIXEROBJ, byval puMxId as UINT ptr, byval fdwId as DWORD) as MMRESULT

union tagMIXERCONTROLA_Bounds field = 1
	type field = 1
		lMinimum as LONG
		lMaximum as LONG
	end type

	type field = 1
		dwMinimum as DWORD
		dwMaximum as DWORD
	end type

	dwReserved(0 to 5) as DWORD
end union

union tagMIXERCONTROLA_Metrics field = 1
	cSteps as DWORD
	cbCustomData as DWORD
	dwReserved(0 to 5) as DWORD
end union

type tagMIXERCONTROLA field = 1
	cbStruct as DWORD
	dwControlID as DWORD
	dwControlType as DWORD
	fdwControl as DWORD
	cMultipleItems as DWORD
	szShortName as zstring * 16
	szName as zstring * 64
	Bounds as tagMIXERCONTROLA_Bounds
	Metrics as tagMIXERCONTROLA_Metrics
end type

type MIXERCONTROLA as tagMIXERCONTROLA
type PMIXERCONTROLA as tagMIXERCONTROLA ptr
type LPMIXERCONTROLA as tagMIXERCONTROLA ptr

union tagMIXERCONTROLW_Bounds field = 1
	type field = 1
		lMinimum as LONG
		lMaximum as LONG
	end type

	type field = 1
		dwMinimum as DWORD
		dwMaximum as DWORD
	end type

	dwReserved(0 to 5) as DWORD
end union

union tagMIXERCONTROLW_Metrics field = 1
	cSteps as DWORD
	cbCustomData as DWORD
	dwReserved(0 to 5) as DWORD
end union

type tagMIXERCONTROLW field = 1
	cbStruct as DWORD
	dwControlID as DWORD
	dwControlType as DWORD
	fdwControl as DWORD
	cMultipleItems as DWORD
	szShortName as wstring * 16
	szName as wstring * 64
	Bounds as tagMIXERCONTROLW_Bounds
	Metrics as tagMIXERCONTROLW_Metrics
end type

type MIXERCONTROLW as tagMIXERCONTROLW
type PMIXERCONTROLW as tagMIXERCONTROLW ptr
type LPMIXERCONTROLW as tagMIXERCONTROLW ptr

#ifdef UNICODE
	type MIXERCONTROL as MIXERCONTROLW
	type PMIXERCONTROL as PMIXERCONTROLW
	type LPMIXERCONTROL as LPMIXERCONTROLW
#else
	type MIXERCONTROL as MIXERCONTROLA
	type PMIXERCONTROL as PMIXERCONTROLA
	type LPMIXERCONTROL as LPMIXERCONTROLA
#endif

const MIXERCONTROL_CONTROLF_UNIFORM = &h00000001
const MIXERCONTROL_CONTROLF_MULTIPLE = &h00000002
const MIXERCONTROL_CONTROLF_DISABLED = &h80000000
const MIXERCONTROL_CT_CLASS_MASK = &hF0000000
const MIXERCONTROL_CT_CLASS_CUSTOM = &h00000000
const MIXERCONTROL_CT_CLASS_METER = &h10000000
const MIXERCONTROL_CT_CLASS_SWITCH = &h20000000
const MIXERCONTROL_CT_CLASS_NUMBER = &h30000000
const MIXERCONTROL_CT_CLASS_SLIDER = &h40000000
const MIXERCONTROL_CT_CLASS_FADER = &h50000000
const MIXERCONTROL_CT_CLASS_TIME = &h60000000
const MIXERCONTROL_CT_CLASS_LIST = &h70000000
const MIXERCONTROL_CT_SUBCLASS_MASK = &h0F000000
const MIXERCONTROL_CT_SC_SWITCH_BOOLEAN = &h00000000
const MIXERCONTROL_CT_SC_SWITCH_BUTTON = &h01000000
const MIXERCONTROL_CT_SC_METER_POLLED = &h00000000
const MIXERCONTROL_CT_SC_TIME_MICROSECS = &h00000000
const MIXERCONTROL_CT_SC_TIME_MILLISECS = &h01000000
const MIXERCONTROL_CT_SC_LIST_SINGLE = &h00000000
const MIXERCONTROL_CT_SC_LIST_MULTIPLE = &h01000000
const MIXERCONTROL_CT_UNITS_MASK = &h00FF0000
const MIXERCONTROL_CT_UNITS_CUSTOM = &h00000000
const MIXERCONTROL_CT_UNITS_BOOLEAN = &h00010000
const MIXERCONTROL_CT_UNITS_SIGNED = &h00020000
const MIXERCONTROL_CT_UNITS_UNSIGNED = &h00030000
const MIXERCONTROL_CT_UNITS_DECIBELS = &h00040000
const MIXERCONTROL_CT_UNITS_PERCENT = &h00050000
const MIXERCONTROL_CONTROLTYPE_CUSTOM = MIXERCONTROL_CT_CLASS_CUSTOM or MIXERCONTROL_CT_UNITS_CUSTOM
const MIXERCONTROL_CONTROLTYPE_BOOLEANMETER = (MIXERCONTROL_CT_CLASS_METER or MIXERCONTROL_CT_SC_METER_POLLED) or MIXERCONTROL_CT_UNITS_BOOLEAN
const MIXERCONTROL_CONTROLTYPE_SIGNEDMETER = (MIXERCONTROL_CT_CLASS_METER or MIXERCONTROL_CT_SC_METER_POLLED) or MIXERCONTROL_CT_UNITS_SIGNED
const MIXERCONTROL_CONTROLTYPE_PEAKMETER = MIXERCONTROL_CONTROLTYPE_SIGNEDMETER + 1
const MIXERCONTROL_CONTROLTYPE_UNSIGNEDMETER = (MIXERCONTROL_CT_CLASS_METER or MIXERCONTROL_CT_SC_METER_POLLED) or MIXERCONTROL_CT_UNITS_UNSIGNED
const MIXERCONTROL_CONTROLTYPE_BOOLEAN = (MIXERCONTROL_CT_CLASS_SWITCH or MIXERCONTROL_CT_SC_SWITCH_BOOLEAN) or MIXERCONTROL_CT_UNITS_BOOLEAN
const MIXERCONTROL_CONTROLTYPE_ONOFF = MIXERCONTROL_CONTROLTYPE_BOOLEAN + 1
const MIXERCONTROL_CONTROLTYPE_MUTE = MIXERCONTROL_CONTROLTYPE_BOOLEAN + 2
const MIXERCONTROL_CONTROLTYPE_MONO = MIXERCONTROL_CONTROLTYPE_BOOLEAN + 3
const MIXERCONTROL_CONTROLTYPE_LOUDNESS = MIXERCONTROL_CONTROLTYPE_BOOLEAN + 4
const MIXERCONTROL_CONTROLTYPE_STEREOENH = MIXERCONTROL_CONTROLTYPE_BOOLEAN + 5
const MIXERCONTROL_CONTROLTYPE_BASS_BOOST = MIXERCONTROL_CONTROLTYPE_BOOLEAN + &h00002277
const MIXERCONTROL_CONTROLTYPE_BUTTON = (MIXERCONTROL_CT_CLASS_SWITCH or MIXERCONTROL_CT_SC_SWITCH_BUTTON) or MIXERCONTROL_CT_UNITS_BOOLEAN
const MIXERCONTROL_CONTROLTYPE_DECIBELS = MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_DECIBELS
const MIXERCONTROL_CONTROLTYPE_SIGNED = MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_SIGNED
const MIXERCONTROL_CONTROLTYPE_UNSIGNED = MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_UNSIGNED
const MIXERCONTROL_CONTROLTYPE_PERCENT = MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_PERCENT
const MIXERCONTROL_CONTROLTYPE_SLIDER = MIXERCONTROL_CT_CLASS_SLIDER or MIXERCONTROL_CT_UNITS_SIGNED
const MIXERCONTROL_CONTROLTYPE_PAN = MIXERCONTROL_CONTROLTYPE_SLIDER + 1
const MIXERCONTROL_CONTROLTYPE_QSOUNDPAN = MIXERCONTROL_CONTROLTYPE_SLIDER + 2
const MIXERCONTROL_CONTROLTYPE_FADER = MIXERCONTROL_CT_CLASS_FADER or MIXERCONTROL_CT_UNITS_UNSIGNED
const MIXERCONTROL_CONTROLTYPE_VOLUME = MIXERCONTROL_CONTROLTYPE_FADER + 1
const MIXERCONTROL_CONTROLTYPE_BASS = MIXERCONTROL_CONTROLTYPE_FADER + 2
const MIXERCONTROL_CONTROLTYPE_TREBLE = MIXERCONTROL_CONTROLTYPE_FADER + 3
const MIXERCONTROL_CONTROLTYPE_EQUALIZER = MIXERCONTROL_CONTROLTYPE_FADER + 4
const MIXERCONTROL_CONTROLTYPE_SINGLESELECT = (MIXERCONTROL_CT_CLASS_LIST or MIXERCONTROL_CT_SC_LIST_SINGLE) or MIXERCONTROL_CT_UNITS_BOOLEAN
const MIXERCONTROL_CONTROLTYPE_MUX = MIXERCONTROL_CONTROLTYPE_SINGLESELECT + 1
const MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT = (MIXERCONTROL_CT_CLASS_LIST or MIXERCONTROL_CT_SC_LIST_MULTIPLE) or MIXERCONTROL_CT_UNITS_BOOLEAN
const MIXERCONTROL_CONTROLTYPE_MIXER = MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT + 1
const MIXERCONTROL_CONTROLTYPE_MICROTIME = (MIXERCONTROL_CT_CLASS_TIME or MIXERCONTROL_CT_SC_TIME_MICROSECS) or MIXERCONTROL_CT_UNITS_UNSIGNED
const MIXERCONTROL_CONTROLTYPE_MILLITIME = (MIXERCONTROL_CT_CLASS_TIME or MIXERCONTROL_CT_SC_TIME_MILLISECS) or MIXERCONTROL_CT_UNITS_UNSIGNED

type tagMIXERLINECONTROLSA field = 1
	cbStruct as DWORD
	dwLineID as DWORD

	union field = 1
		dwControlID as DWORD
		dwControlType as DWORD
	end union

	cControls as DWORD
	cbmxctrl as DWORD
	pamxctrl as LPMIXERCONTROLA
end type

type MIXERLINECONTROLSA as tagMIXERLINECONTROLSA
type PMIXERLINECONTROLSA as tagMIXERLINECONTROLSA ptr
type LPMIXERLINECONTROLSA as tagMIXERLINECONTROLSA ptr

type tagMIXERLINECONTROLSW field = 1
	cbStruct as DWORD
	dwLineID as DWORD

	union field = 1
		dwControlID as DWORD
		dwControlType as DWORD
	end union

	cControls as DWORD
	cbmxctrl as DWORD
	pamxctrl as LPMIXERCONTROLW
end type

type MIXERLINECONTROLSW as tagMIXERLINECONTROLSW
type PMIXERLINECONTROLSW as tagMIXERLINECONTROLSW ptr
type LPMIXERLINECONTROLSW as tagMIXERLINECONTROLSW ptr

#ifdef UNICODE
	type MIXERLINECONTROLS as MIXERLINECONTROLSW
	type PMIXERLINECONTROLS as PMIXERLINECONTROLSW
	type LPMIXERLINECONTROLS as LPMIXERLINECONTROLSW
#else
	type MIXERLINECONTROLS as MIXERLINECONTROLSA
	type PMIXERLINECONTROLS as PMIXERLINECONTROLSA
	type LPMIXERLINECONTROLS as LPMIXERLINECONTROLSA
#endif

declare function mixerGetLineControlsA(byval hmxobj as HMIXEROBJ, byval pmxlc as LPMIXERLINECONTROLSA, byval fdwControls as DWORD) as MMRESULT
declare function mixerGetLineControlsW(byval hmxobj as HMIXEROBJ, byval pmxlc as LPMIXERLINECONTROLSW, byval fdwControls as DWORD) as MMRESULT

#ifdef UNICODE
	declare function mixerGetLineControls alias "mixerGetLineControlsW"(byval hmxobj as HMIXEROBJ, byval pmxlc as LPMIXERLINECONTROLSW, byval fdwControls as DWORD) as MMRESULT
#else
	declare function mixerGetLineControls alias "mixerGetLineControlsA"(byval hmxobj as HMIXEROBJ, byval pmxlc as LPMIXERLINECONTROLSA, byval fdwControls as DWORD) as MMRESULT
#endif

const MIXER_GETLINECONTROLSF_ALL = &h00000000
const MIXER_GETLINECONTROLSF_ONEBYID = &h00000001
const MIXER_GETLINECONTROLSF_ONEBYTYPE = &h00000002
const MIXER_GETLINECONTROLSF_QUERYMASK = &h0000000F

type tMIXERCONTROLDETAILS field = 1
	cbStruct as DWORD
	dwControlID as DWORD
	cChannels as DWORD

	union field = 1
		hwndOwner as HWND
		cMultipleItems as DWORD
	end union

	cbDetails as DWORD
	paDetails as LPVOID
end type

type MIXERCONTROLDETAILS as tMIXERCONTROLDETAILS
type PMIXERCONTROLDETAILS as tMIXERCONTROLDETAILS ptr
type LPMIXERCONTROLDETAILS as tMIXERCONTROLDETAILS ptr

type tagMIXERCONTROLDETAILS_LISTTEXTA field = 1
	dwParam1 as DWORD
	dwParam2 as DWORD
	szName as zstring * 64
end type

type MIXERCONTROLDETAILS_LISTTEXTA as tagMIXERCONTROLDETAILS_LISTTEXTA
type PMIXERCONTROLDETAILS_LISTTEXTA as tagMIXERCONTROLDETAILS_LISTTEXTA ptr
type LPMIXERCONTROLDETAILS_LISTTEXTA as tagMIXERCONTROLDETAILS_LISTTEXTA ptr

type tagMIXERCONTROLDETAILS_LISTTEXTW field = 1
	dwParam1 as DWORD
	dwParam2 as DWORD
	szName as wstring * 64
end type

type MIXERCONTROLDETAILS_LISTTEXTW as tagMIXERCONTROLDETAILS_LISTTEXTW
type PMIXERCONTROLDETAILS_LISTTEXTW as tagMIXERCONTROLDETAILS_LISTTEXTW ptr
type LPMIXERCONTROLDETAILS_LISTTEXTW as tagMIXERCONTROLDETAILS_LISTTEXTW ptr

#ifdef UNICODE
	type MIXERCONTROLDETAILS_LISTTEXT as MIXERCONTROLDETAILS_LISTTEXTW
	type PMIXERCONTROLDETAILS_LISTTEXT as PMIXERCONTROLDETAILS_LISTTEXTW
	type LPMIXERCONTROLDETAILS_LISTTEXT as LPMIXERCONTROLDETAILS_LISTTEXTW
#else
	type MIXERCONTROLDETAILS_LISTTEXT as MIXERCONTROLDETAILS_LISTTEXTA
	type PMIXERCONTROLDETAILS_LISTTEXT as PMIXERCONTROLDETAILS_LISTTEXTA
	type LPMIXERCONTROLDETAILS_LISTTEXT as LPMIXERCONTROLDETAILS_LISTTEXTA
#endif

type tMIXERCONTROLDETAILS_BOOLEAN field = 1
	fValue as LONG
end type

type MIXERCONTROLDETAILS_BOOLEAN as tMIXERCONTROLDETAILS_BOOLEAN
type PMIXERCONTROLDETAILS_BOOLEAN as tMIXERCONTROLDETAILS_BOOLEAN ptr
type LPMIXERCONTROLDETAILS_BOOLEAN as tMIXERCONTROLDETAILS_BOOLEAN ptr

type tMIXERCONTROLDETAILS_SIGNED field = 1
	lValue as LONG
end type

type MIXERCONTROLDETAILS_SIGNED as tMIXERCONTROLDETAILS_SIGNED
type PMIXERCONTROLDETAILS_SIGNED as tMIXERCONTROLDETAILS_SIGNED ptr
type LPMIXERCONTROLDETAILS_SIGNED as tMIXERCONTROLDETAILS_SIGNED ptr

type tMIXERCONTROLDETAILS_UNSIGNED field = 1
	dwValue as DWORD
end type

type MIXERCONTROLDETAILS_UNSIGNED as tMIXERCONTROLDETAILS_UNSIGNED
type PMIXERCONTROLDETAILS_UNSIGNED as tMIXERCONTROLDETAILS_UNSIGNED ptr
type LPMIXERCONTROLDETAILS_UNSIGNED as tMIXERCONTROLDETAILS_UNSIGNED ptr
declare function mixerGetControlDetailsA(byval hmxobj as HMIXEROBJ, byval pmxcd as LPMIXERCONTROLDETAILS, byval fdwDetails as DWORD) as MMRESULT
declare function mixerGetControlDetailsW(byval hmxobj as HMIXEROBJ, byval pmxcd as LPMIXERCONTROLDETAILS, byval fdwDetails as DWORD) as MMRESULT

#ifdef UNICODE
	declare function mixerGetControlDetails alias "mixerGetControlDetailsW"(byval hmxobj as HMIXEROBJ, byval pmxcd as LPMIXERCONTROLDETAILS, byval fdwDetails as DWORD) as MMRESULT
#else
	declare function mixerGetControlDetails alias "mixerGetControlDetailsA"(byval hmxobj as HMIXEROBJ, byval pmxcd as LPMIXERCONTROLDETAILS, byval fdwDetails as DWORD) as MMRESULT
#endif

const MIXER_GETCONTROLDETAILSF_VALUE = &h00000000
const MIXER_GETCONTROLDETAILSF_LISTTEXT = &h00000001
const MIXER_GETCONTROLDETAILSF_QUERYMASK = &h0000000F
declare function mixerSetControlDetails(byval hmxobj as HMIXEROBJ, byval pmxcd as LPMIXERCONTROLDETAILS, byval fdwDetails as DWORD) as MMRESULT
const MIXER_SETCONTROLDETAILSF_VALUE = &h00000000
const MIXER_SETCONTROLDETAILSF_CUSTOM = &h00000001
const MIXER_SETCONTROLDETAILSF_QUERYMASK = &h0000000F
const TIMERR_NOERROR = 0
const TIMERR_NOCANDO = TIMERR_BASE + 1
const TIMERR_STRUCT = TIMERR_BASE + 33
type LPTIMECALLBACK as sub(byval uTimerID as UINT, byval uMsg as UINT, byval dwUser as DWORD_PTR, byval dw1 as DWORD_PTR, byval dw2 as DWORD_PTR)
const TIME_ONESHOT = &h0000
const TIME_PERIODIC = &h0001
const TIME_CALLBACK_FUNCTION = &h0000
const TIME_CALLBACK_EVENT_SET = &h0010
const TIME_CALLBACK_EVENT_PULSE = &h0020
const TIME_KILL_SYNCHRONOUS = &h0100

type timecaps_tag field = 1
	wPeriodMin as UINT
	wPeriodMax as UINT
end type

type TIMECAPS as timecaps_tag
type PTIMECAPS as timecaps_tag ptr
type NPTIMECAPS as timecaps_tag ptr
type LPTIMECAPS as timecaps_tag ptr

declare function timeGetSystemTime(byval pmmt as LPMMTIME, byval cbmmt as UINT) as MMRESULT
declare function timeGetTime() as DWORD
declare function timeSetEvent(byval uDelay as UINT, byval uResolution as UINT, byval fptc as LPTIMECALLBACK, byval dwUser as DWORD_PTR, byval fuEvent as UINT) as MMRESULT
declare function timeKillEvent(byval uTimerID as UINT) as MMRESULT
declare function timeGetDevCaps(byval ptc as LPTIMECAPS, byval cbtc as UINT) as MMRESULT
declare function timeBeginPeriod(byval uPeriod as UINT) as MMRESULT
declare function timeEndPeriod(byval uPeriod as UINT) as MMRESULT

const JOYERR_NOERROR = 0
const JOYERR_PARMS = JOYERR_BASE + 5
const JOYERR_NOCANDO = JOYERR_BASE + 6
const JOYERR_UNPLUGGED = JOYERR_BASE + 7
const JOY_BUTTON1 = &h0001
const JOY_BUTTON2 = &h0002
const JOY_BUTTON3 = &h0004
const JOY_BUTTON4 = &h0008
const JOY_BUTTON1CHG = &h0100
const JOY_BUTTON2CHG = &h0200
const JOY_BUTTON3CHG = &h0400
const JOY_BUTTON4CHG = &h0800
const JOY_BUTTON5 = &h00000010
const JOY_BUTTON6 = &h00000020
const JOY_BUTTON7 = &h00000040
const JOY_BUTTON8 = &h00000080
const JOY_BUTTON9 = &h00000100
const JOY_BUTTON10 = &h00000200
const JOY_BUTTON11 = &h00000400
const JOY_BUTTON12 = &h00000800
const JOY_BUTTON13 = &h00001000
const JOY_BUTTON14 = &h00002000
const JOY_BUTTON15 = &h00004000
const JOY_BUTTON16 = &h00008000
const JOY_BUTTON17 = &h00010000
const JOY_BUTTON18 = &h00020000
const JOY_BUTTON19 = &h00040000
const JOY_BUTTON20 = &h00080000
const JOY_BUTTON21 = &h00100000
const JOY_BUTTON22 = &h00200000
const JOY_BUTTON23 = &h00400000
const JOY_BUTTON24 = &h00800000
const JOY_BUTTON25 = &h01000000
const JOY_BUTTON26 = &h02000000
const JOY_BUTTON27 = &h04000000
const JOY_BUTTON28 = &h08000000
const JOY_BUTTON29 = &h10000000
const JOY_BUTTON30 = &h20000000
const JOY_BUTTON31 = &h40000000
const JOY_BUTTON32 = &h80000000
const JOY_POVCENTERED = cast(WORD, -1)
const JOY_POVFORWARD = 0
const JOY_POVRIGHT = 9000
const JOY_POVBACKWARD = 18000
const JOY_POVLEFT = 27000
const JOY_RETURNX = &h00000001
const JOY_RETURNY = &h00000002
const JOY_RETURNZ = &h00000004
const JOY_RETURNR = &h00000008
const JOY_RETURNU = &h00000010
const JOY_RETURNV = &h00000020
const JOY_RETURNPOV = &h00000040
const JOY_RETURNBUTTONS = &h00000080
const JOY_RETURNRAWDATA = &h00000100
const JOY_RETURNPOVCTS = &h00000200
const JOY_RETURNCENTERED = &h00000400
const JOY_USEDEADZONE = &h00000800
const JOY_RETURNALL = ((((((JOY_RETURNX or JOY_RETURNY) or JOY_RETURNZ) or JOY_RETURNR) or JOY_RETURNU) or JOY_RETURNV) or JOY_RETURNPOV) or JOY_RETURNBUTTONS
const JOY_CAL_READALWAYS = &h00010000
const JOY_CAL_READXYONLY = &h00020000
const JOY_CAL_READ3 = &h00040000
const JOY_CAL_READ4 = &h00080000
const JOY_CAL_READXONLY = &h00100000
const JOY_CAL_READYONLY = &h00200000
const JOY_CAL_READ5 = &h00400000
const JOY_CAL_READ6 = &h00800000
const JOY_CAL_READZONLY = &h01000000
const JOY_CAL_READRONLY = &h02000000
const JOY_CAL_READUONLY = &h04000000
const JOY_CAL_READVONLY = &h08000000
const JOYSTICKID1 = 0
const JOYSTICKID2 = 1
const JOYCAPS_HASZ = &h0001
const JOYCAPS_HASR = &h0002
const JOYCAPS_HASU = &h0004
const JOYCAPS_HASV = &h0008
const JOYCAPS_HASPOV = &h0010
const JOYCAPS_POV4DIR = &h0020
const JOYCAPS_POVCTS = &h0040

type tagJOYCAPSA field = 1
	wMid as WORD
	wPid as WORD
	szPname as zstring * 32
	wXmin as UINT
	wXmax as UINT
	wYmin as UINT
	wYmax as UINT
	wZmin as UINT
	wZmax as UINT
	wNumButtons as UINT
	wPeriodMin as UINT
	wPeriodMax as UINT
	wRmin as UINT
	wRmax as UINT
	wUmin as UINT
	wUmax as UINT
	wVmin as UINT
	wVmax as UINT
	wCaps as UINT
	wMaxAxes as UINT
	wNumAxes as UINT
	wMaxButtons as UINT
	szRegKey as zstring * 32
	szOEMVxD as zstring * 260
end type

type JOYCAPSA as tagJOYCAPSA
type PJOYCAPSA as tagJOYCAPSA ptr
type NPJOYCAPSA as tagJOYCAPSA ptr
type LPJOYCAPSA as tagJOYCAPSA ptr

type tagJOYCAPSW field = 1
	wMid as WORD
	wPid as WORD
	szPname as wstring * 32
	wXmin as UINT
	wXmax as UINT
	wYmin as UINT
	wYmax as UINT
	wZmin as UINT
	wZmax as UINT
	wNumButtons as UINT
	wPeriodMin as UINT
	wPeriodMax as UINT
	wRmin as UINT
	wRmax as UINT
	wUmin as UINT
	wUmax as UINT
	wVmin as UINT
	wVmax as UINT
	wCaps as UINT
	wMaxAxes as UINT
	wNumAxes as UINT
	wMaxButtons as UINT
	szRegKey as wstring * 32
	szOEMVxD as wstring * 260
end type

type JOYCAPSW as tagJOYCAPSW
type PJOYCAPSW as tagJOYCAPSW ptr
type NPJOYCAPSW as tagJOYCAPSW ptr
type LPJOYCAPSW as tagJOYCAPSW ptr

#ifdef UNICODE
	type JOYCAPS as JOYCAPSW
	type PJOYCAPS as PJOYCAPSW
	type NPJOYCAPS as NPJOYCAPSW
	type LPJOYCAPS as LPJOYCAPSW
#else
	type JOYCAPS as JOYCAPSA
	type PJOYCAPS as PJOYCAPSA
	type NPJOYCAPS as NPJOYCAPSA
	type LPJOYCAPS as LPJOYCAPSA
#endif

type tagJOYCAPS2A field = 1
	wMid as WORD
	wPid as WORD
	szPname as zstring * 32
	wXmin as UINT
	wXmax as UINT
	wYmin as UINT
	wYmax as UINT
	wZmin as UINT
	wZmax as UINT
	wNumButtons as UINT
	wPeriodMin as UINT
	wPeriodMax as UINT
	wRmin as UINT
	wRmax as UINT
	wUmin as UINT
	wUmax as UINT
	wVmin as UINT
	wVmax as UINT
	wCaps as UINT
	wMaxAxes as UINT
	wNumAxes as UINT
	wMaxButtons as UINT
	szRegKey as zstring * 32
	szOEMVxD as zstring * 260
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type JOYCAPS2A as tagJOYCAPS2A
type PJOYCAPS2A as tagJOYCAPS2A ptr
type NPJOYCAPS2A as tagJOYCAPS2A ptr
type LPJOYCAPS2A as tagJOYCAPS2A ptr

type tagJOYCAPS2W field = 1
	wMid as WORD
	wPid as WORD
	szPname as wstring * 32
	wXmin as UINT
	wXmax as UINT
	wYmin as UINT
	wYmax as UINT
	wZmin as UINT
	wZmax as UINT
	wNumButtons as UINT
	wPeriodMin as UINT
	wPeriodMax as UINT
	wRmin as UINT
	wRmax as UINT
	wUmin as UINT
	wUmax as UINT
	wVmin as UINT
	wVmax as UINT
	wCaps as UINT
	wMaxAxes as UINT
	wNumAxes as UINT
	wMaxButtons as UINT
	szRegKey as wstring * 32
	szOEMVxD as wstring * 260
	ManufacturerGuid as GUID
	ProductGuid as GUID
	NameGuid as GUID
end type

type JOYCAPS2W as tagJOYCAPS2W
type PJOYCAPS2W as tagJOYCAPS2W ptr
type NPJOYCAPS2W as tagJOYCAPS2W ptr
type LPJOYCAPS2W as tagJOYCAPS2W ptr

#ifdef UNICODE
	type JOYCAPS2 as JOYCAPS2W
	type PJOYCAPS2 as PJOYCAPS2W
	type NPJOYCAPS2 as NPJOYCAPS2W
	type LPJOYCAPS2 as LPJOYCAPS2W
#else
	type JOYCAPS2 as JOYCAPS2A
	type PJOYCAPS2 as PJOYCAPS2A
	type NPJOYCAPS2 as NPJOYCAPS2A
	type LPJOYCAPS2 as LPJOYCAPS2A
#endif

type joyinfo_tag field = 1
	wXpos as UINT
	wYpos as UINT
	wZpos as UINT
	wButtons as UINT
end type

type JOYINFO as joyinfo_tag
type PJOYINFO as joyinfo_tag ptr
type NPJOYINFO as joyinfo_tag ptr
type LPJOYINFO as joyinfo_tag ptr

type joyinfoex_tag field = 1
	dwSize as DWORD
	dwFlags as DWORD
	dwXpos as DWORD
	dwYpos as DWORD
	dwZpos as DWORD
	dwRpos as DWORD
	dwUpos as DWORD
	dwVpos as DWORD
	dwButtons as DWORD
	dwButtonNumber as DWORD
	dwPOV as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type JOYINFOEX as joyinfoex_tag
type PJOYINFOEX as joyinfoex_tag ptr
type NPJOYINFOEX as joyinfoex_tag ptr
type LPJOYINFOEX as joyinfoex_tag ptr

declare function joyGetNumDevs() as UINT
declare function joyGetDevCapsA(byval uJoyID as UINT_PTR, byval pjc as LPJOYCAPSA, byval cbjc as UINT) as MMRESULT
declare function joyGetDevCapsW(byval uJoyID as UINT_PTR, byval pjc as LPJOYCAPSW, byval cbjc as UINT) as MMRESULT

#ifdef UNICODE
	declare function joyGetDevCaps alias "joyGetDevCapsW"(byval uJoyID as UINT_PTR, byval pjc as LPJOYCAPSW, byval cbjc as UINT) as MMRESULT
#else
	declare function joyGetDevCaps alias "joyGetDevCapsA"(byval uJoyID as UINT_PTR, byval pjc as LPJOYCAPSA, byval cbjc as UINT) as MMRESULT
#endif

declare function joyGetPos(byval uJoyID as UINT, byval pji as LPJOYINFO) as MMRESULT
declare function joyGetPosEx(byval uJoyID as UINT, byval pji as LPJOYINFOEX) as MMRESULT
declare function joyGetThreshold(byval uJoyID as UINT, byval puThreshold as LPUINT) as MMRESULT
declare function joyReleaseCapture(byval uJoyID as UINT) as MMRESULT
declare function joySetCapture(byval hwnd as HWND, byval uJoyID as UINT, byval uPeriod as UINT, byval fChanged as WINBOOL) as MMRESULT
declare function joySetThreshold(byval uJoyID as UINT, byval uThreshold as UINT) as MMRESULT

const MMIOERR_BASE = 256
const MMIOERR_FILENOTFOUND = MMIOERR_BASE + 1
const MMIOERR_OUTOFMEMORY = MMIOERR_BASE + 2
const MMIOERR_CANNOTOPEN = MMIOERR_BASE + 3
const MMIOERR_CANNOTCLOSE = MMIOERR_BASE + 4
const MMIOERR_CANNOTREAD = MMIOERR_BASE + 5
const MMIOERR_CANNOTWRITE = MMIOERR_BASE + 6
const MMIOERR_CANNOTSEEK = MMIOERR_BASE + 7
const MMIOERR_CANNOTEXPAND = MMIOERR_BASE + 8
const MMIOERR_CHUNKNOTFOUND = MMIOERR_BASE + 9
const MMIOERR_UNBUFFERED = MMIOERR_BASE + 10
const MMIOERR_PATHNOTFOUND = MMIOERR_BASE + 11
const MMIOERR_ACCESSDENIED = MMIOERR_BASE + 12
const MMIOERR_SHARINGVIOLATION = MMIOERR_BASE + 13
const MMIOERR_NETWORKERROR = MMIOERR_BASE + 14
const MMIOERR_TOOMANYOPENFILES = MMIOERR_BASE + 15
const MMIOERR_INVALIDFILE = MMIOERR_BASE + 16
#define CFSEPCHAR asc("+")
type FOURCC as DWORD
type HPSTR as zstring ptr

type HMMIO__ field = 1
	unused as long
end type

type HMMIO as HMMIO__ ptr
type LPMMIOPROC as function(byval lpmmioinfo as LPSTR, byval uMsg as UINT, byval lParam1 as LPARAM, byval lParam2 as LPARAM) as LRESULT

type _MMIOINFO field = 1
	dwFlags as DWORD
	fccIOProc as FOURCC
	pIOProc as LPMMIOPROC
	wErrorRet as UINT
	htask as HTASK
	cchBuffer as LONG
	pchBuffer as HPSTR
	pchNext as HPSTR
	pchEndRead as HPSTR
	pchEndWrite as HPSTR
	lBufOffset as LONG
	lDiskOffset as LONG
	adwInfo(0 to 2) as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
	hmmio as HMMIO
end type

type MMIOINFO as _MMIOINFO
type PMMIOINFO as _MMIOINFO ptr
type NPMMIOINFO as _MMIOINFO ptr
type LPMMIOINFO as _MMIOINFO ptr
type LPCMMIOINFO as const MMIOINFO ptr

type _MMCKINFO field = 1
	ckid as FOURCC
	cksize as DWORD
	fccType as FOURCC
	dwDataOffset as DWORD
	dwFlags as DWORD
end type

type MMCKINFO as _MMCKINFO
type PMMCKINFO as _MMCKINFO ptr
type NPMMCKINFO as _MMCKINFO ptr
type LPMMCKINFO as _MMCKINFO ptr
type LPCMMCKINFO as const MMCKINFO ptr

const MMIO_RWMODE = &h00000003
const MMIO_SHAREMODE = &h00000070
const MMIO_CREATE = &h00001000
const MMIO_PARSE = &h00000100
const MMIO_DELETE = &h00000200
const MMIO_EXIST = &h00004000
const MMIO_ALLOCBUF = &h00010000
const MMIO_GETTEMP = &h00020000
const MMIO_DIRTY = &h10000000
const MMIO_READ = &h00000000
const MMIO_WRITE = &h00000001
const MMIO_READWRITE = &h00000002
const MMIO_COMPAT = &h00000000
const MMIO_EXCLUSIVE = &h00000010
const MMIO_DENYWRITE = &h00000020
const MMIO_DENYREAD = &h00000030
const MMIO_DENYNONE = &h00000040
const MMIO_FHOPEN = &h0010
const MMIO_EMPTYBUF = &h0010
const MMIO_TOUPPER = &h0010
const MMIO_INSTALLPROC = &h00010000
const MMIO_GLOBALPROC = &h10000000
const MMIO_REMOVEPROC = &h00020000
const MMIO_UNICODEPROC = &h01000000
const MMIO_FINDPROC = &h00040000
const MMIO_FINDCHUNK = &h0010
const MMIO_FINDRIFF = &h0020
const MMIO_FINDLIST = &h0040
const MMIO_CREATERIFF = &h0020
const MMIO_CREATELIST = &h0040
const MMIOM_READ = MMIO_READ
const MMIOM_WRITE = MMIO_WRITE
const MMIOM_SEEK = 2
const MMIOM_OPEN = 3
const MMIOM_CLOSE = 4
const MMIOM_WRITEFLUSH = 5
const MMIOM_RENAME = 6
const MMIOM_USER = &h8000
#define FOURCC_RIFF mmioFOURCC(asc("R"), asc("I"), asc("F"), asc("F"))
#define FOURCC_LIST mmioFOURCC(asc("L"), asc("I"), asc("S"), asc("T"))
#define FOURCC_DOS mmioFOURCC(asc("D"), asc("O"), asc("S"), asc(" "))
#define FOURCC_MEM mmioFOURCC(asc("M"), asc("E"), asc("M"), asc(" "))
const MMIO_DEFAULTBUFFER = 8192
#define mmioFOURCC(ch0, ch1, ch2, ch3) MAKEFOURCC(ch0, ch1, ch2, ch3)
declare function mmioStringToFOURCCA(byval sz as LPCSTR, byval uFlags as UINT) as FOURCC
declare function mmioStringToFOURCCW(byval sz as LPCWSTR, byval uFlags as UINT) as FOURCC

#ifdef UNICODE
	declare function mmioStringToFOURCC alias "mmioStringToFOURCCW"(byval sz as LPCWSTR, byval uFlags as UINT) as FOURCC
#else
	declare function mmioStringToFOURCC alias "mmioStringToFOURCCA"(byval sz as LPCSTR, byval uFlags as UINT) as FOURCC
#endif

declare function mmioInstallIOProcA(byval fccIOProc as FOURCC, byval pIOProc as LPMMIOPROC, byval dwFlags as DWORD) as LPMMIOPROC
declare function mmioInstallIOProcW(byval fccIOProc as FOURCC, byval pIOProc as LPMMIOPROC, byval dwFlags as DWORD) as LPMMIOPROC

#ifdef UNICODE
	declare function mmioInstallIOProc alias "mmioInstallIOProcW"(byval fccIOProc as FOURCC, byval pIOProc as LPMMIOPROC, byval dwFlags as DWORD) as LPMMIOPROC
#else
	declare function mmioInstallIOProc alias "mmioInstallIOProcA"(byval fccIOProc as FOURCC, byval pIOProc as LPMMIOPROC, byval dwFlags as DWORD) as LPMMIOPROC
#endif

declare function mmioOpenA(byval pszFileName as LPSTR, byval pmmioinfo as LPMMIOINFO, byval fdwOpen as DWORD) as HMMIO
declare function mmioOpenW(byval pszFileName as LPWSTR, byval pmmioinfo as LPMMIOINFO, byval fdwOpen as DWORD) as HMMIO

#ifdef UNICODE
	declare function mmioOpen alias "mmioOpenW"(byval pszFileName as LPWSTR, byval pmmioinfo as LPMMIOINFO, byval fdwOpen as DWORD) as HMMIO
#else
	declare function mmioOpen alias "mmioOpenA"(byval pszFileName as LPSTR, byval pmmioinfo as LPMMIOINFO, byval fdwOpen as DWORD) as HMMIO
#endif

declare function mmioRenameA(byval pszFileName as LPCSTR, byval pszNewFileName as LPCSTR, byval pmmioinfo as LPCMMIOINFO, byval fdwRename as DWORD) as MMRESULT
declare function mmioRenameW(byval pszFileName as LPCWSTR, byval pszNewFileName as LPCWSTR, byval pmmioinfo as LPCMMIOINFO, byval fdwRename as DWORD) as MMRESULT

#ifdef UNICODE
	declare function mmioRename alias "mmioRenameW"(byval pszFileName as LPCWSTR, byval pszNewFileName as LPCWSTR, byval pmmioinfo as LPCMMIOINFO, byval fdwRename as DWORD) as MMRESULT
#else
	declare function mmioRename alias "mmioRenameA"(byval pszFileName as LPCSTR, byval pszNewFileName as LPCSTR, byval pmmioinfo as LPCMMIOINFO, byval fdwRename as DWORD) as MMRESULT
#endif

declare function mmioClose(byval hmmio as HMMIO, byval fuClose as UINT) as MMRESULT
declare function mmioRead(byval hmmio as HMMIO, byval pch as HPSTR, byval cch as LONG) as LONG
declare function mmioWrite(byval hmmio as HMMIO, byval pch as const zstring ptr, byval cch as LONG) as LONG
declare function mmioSeek(byval hmmio as HMMIO, byval lOffset as LONG, byval iOrigin as long) as LONG
declare function mmioGetInfo(byval hmmio as HMMIO, byval pmmioinfo as LPMMIOINFO, byval fuInfo as UINT) as MMRESULT
declare function mmioSetInfo(byval hmmio as HMMIO, byval pmmioinfo as LPCMMIOINFO, byval fuInfo as UINT) as MMRESULT
declare function mmioSetBuffer(byval hmmio as HMMIO, byval pchBuffer as LPSTR, byval cchBuffer as LONG, byval fuBuffer as UINT) as MMRESULT
declare function mmioFlush(byval hmmio as HMMIO, byval fuFlush as UINT) as MMRESULT
declare function mmioAdvance(byval hmmio as HMMIO, byval pmmioinfo as LPMMIOINFO, byval fuAdvance as UINT) as MMRESULT
declare function mmioSendMessage(byval hmmio as HMMIO, byval uMsg as UINT, byval lParam1 as LPARAM, byval lParam2 as LPARAM) as LRESULT
declare function mmioDescend(byval hmmio as HMMIO, byval pmmcki as LPMMCKINFO, byval pmmckiParent as const MMCKINFO ptr, byval fuDescend as UINT) as MMRESULT
declare function mmioAscend(byval hmmio as HMMIO, byval pmmcki as LPMMCKINFO, byval fuAscend as UINT) as MMRESULT
declare function mmioCreateChunk(byval hmmio as HMMIO, byval pmmcki as LPMMCKINFO, byval fuCreate as UINT) as MMRESULT
#define _MCIERROR_
type MCIERROR as DWORD
#define _MCIDEVICEID_
type MCIDEVICEID as UINT
type YIELDPROC as function(byval mciId as MCIDEVICEID, byval dwYieldData as DWORD) as UINT
declare function mciSendCommandA(byval mciId as MCIDEVICEID, byval uMsg as UINT, byval dwParam1 as DWORD_PTR, byval dwParam2 as DWORD_PTR) as MCIERROR
declare function mciSendCommandW(byval mciId as MCIDEVICEID, byval uMsg as UINT, byval dwParam1 as DWORD_PTR, byval dwParam2 as DWORD_PTR) as MCIERROR

#ifdef UNICODE
	declare function mciSendCommand alias "mciSendCommandW"(byval mciId as MCIDEVICEID, byval uMsg as UINT, byval dwParam1 as DWORD_PTR, byval dwParam2 as DWORD_PTR) as MCIERROR
#else
	declare function mciSendCommand alias "mciSendCommandA"(byval mciId as MCIDEVICEID, byval uMsg as UINT, byval dwParam1 as DWORD_PTR, byval dwParam2 as DWORD_PTR) as MCIERROR
#endif

declare function mciSendStringA(byval lpstrCommand as LPCSTR, byval lpstrReturnString as LPSTR, byval uReturnLength as UINT, byval hwndCallback as HWND) as MCIERROR
declare function mciSendStringW(byval lpstrCommand as LPCWSTR, byval lpstrReturnString as LPWSTR, byval uReturnLength as UINT, byval hwndCallback as HWND) as MCIERROR

#ifdef UNICODE
	declare function mciSendString alias "mciSendStringW"(byval lpstrCommand as LPCWSTR, byval lpstrReturnString as LPWSTR, byval uReturnLength as UINT, byval hwndCallback as HWND) as MCIERROR
#else
	declare function mciSendString alias "mciSendStringA"(byval lpstrCommand as LPCSTR, byval lpstrReturnString as LPSTR, byval uReturnLength as UINT, byval hwndCallback as HWND) as MCIERROR
#endif

declare function mciGetDeviceIDA(byval pszDevice as LPCSTR) as MCIDEVICEID
declare function mciGetDeviceIDW(byval pszDevice as LPCWSTR) as MCIDEVICEID

#ifdef UNICODE
	declare function mciGetDeviceID alias "mciGetDeviceIDW"(byval pszDevice as LPCWSTR) as MCIDEVICEID
#else
	declare function mciGetDeviceID alias "mciGetDeviceIDA"(byval pszDevice as LPCSTR) as MCIDEVICEID
#endif

declare function mciGetDeviceIDFromElementIDA(byval dwElementID as DWORD, byval lpstrType as LPCSTR) as MCIDEVICEID
declare function mciGetDeviceIDFromElementIDW(byval dwElementID as DWORD, byval lpstrType as LPCWSTR) as MCIDEVICEID

#ifdef UNICODE
	declare function mciGetDeviceIDFromElementID alias "mciGetDeviceIDFromElementIDW"(byval dwElementID as DWORD, byval lpstrType as LPCWSTR) as MCIDEVICEID
#else
	declare function mciGetDeviceIDFromElementID alias "mciGetDeviceIDFromElementIDA"(byval dwElementID as DWORD, byval lpstrType as LPCSTR) as MCIDEVICEID
#endif

declare function mciGetErrorStringA(byval mcierr as MCIERROR, byval pszText as LPSTR, byval cchText as UINT) as WINBOOL
declare function mciGetErrorStringW(byval mcierr as MCIERROR, byval pszText as LPWSTR, byval cchText as UINT) as WINBOOL

#ifdef UNICODE
	declare function mciGetErrorString alias "mciGetErrorStringW"(byval mcierr as MCIERROR, byval pszText as LPWSTR, byval cchText as UINT) as WINBOOL
#else
	declare function mciGetErrorString alias "mciGetErrorStringA"(byval mcierr as MCIERROR, byval pszText as LPSTR, byval cchText as UINT) as WINBOOL
#endif

declare function mciSetYieldProc(byval mciId as MCIDEVICEID, byval fpYieldProc as YIELDPROC, byval dwYieldData as DWORD) as WINBOOL
declare function mciGetCreatorTask(byval mciId as MCIDEVICEID) as HTASK
declare function mciGetYieldProc(byval mciId as MCIDEVICEID, byval pdwYieldData as LPDWORD) as YIELDPROC

const MCIERR_INVALID_DEVICE_ID = MCIERR_BASE + 1
const MCIERR_UNRECOGNIZED_KEYWORD = MCIERR_BASE + 3
const MCIERR_UNRECOGNIZED_COMMAND = MCIERR_BASE + 5
const MCIERR_HARDWARE = MCIERR_BASE + 6
const MCIERR_INVALID_DEVICE_NAME = MCIERR_BASE + 7
const MCIERR_OUT_OF_MEMORY = MCIERR_BASE + 8
const MCIERR_DEVICE_OPEN = MCIERR_BASE + 9
const MCIERR_CANNOT_LOAD_DRIVER = MCIERR_BASE + 10
const MCIERR_MISSING_COMMAND_STRING = MCIERR_BASE + 11
const MCIERR_PARAM_OVERFLOW = MCIERR_BASE + 12
const MCIERR_MISSING_STRING_ARGUMENT = MCIERR_BASE + 13
const MCIERR_BAD_INTEGER = MCIERR_BASE + 14
const MCIERR_PARSER_INTERNAL = MCIERR_BASE + 15
const MCIERR_DRIVER_INTERNAL = MCIERR_BASE + 16
const MCIERR_MISSING_PARAMETER = MCIERR_BASE + 17
const MCIERR_UNSUPPORTED_FUNCTION = MCIERR_BASE + 18
const MCIERR_FILE_NOT_FOUND = MCIERR_BASE + 19
const MCIERR_DEVICE_NOT_READY = MCIERR_BASE + 20
const MCIERR_INTERNAL = MCIERR_BASE + 21
const MCIERR_DRIVER = MCIERR_BASE + 22
const MCIERR_CANNOT_USE_ALL = MCIERR_BASE + 23
const MCIERR_MULTIPLE = MCIERR_BASE + 24
const MCIERR_EXTENSION_NOT_FOUND = MCIERR_BASE + 25
const MCIERR_OUTOFRANGE = MCIERR_BASE + 26
const MCIERR_FLAGS_NOT_COMPATIBLE = MCIERR_BASE + 28
const MCIERR_FILE_NOT_SAVED = MCIERR_BASE + 30
const MCIERR_DEVICE_TYPE_REQUIRED = MCIERR_BASE + 31
const MCIERR_DEVICE_LOCKED = MCIERR_BASE + 32
const MCIERR_DUPLICATE_ALIAS = MCIERR_BASE + 33
const MCIERR_BAD_CONSTANT = MCIERR_BASE + 34
const MCIERR_MUST_USE_SHAREABLE = MCIERR_BASE + 35
const MCIERR_MISSING_DEVICE_NAME = MCIERR_BASE + 36
const MCIERR_BAD_TIME_FORMAT = MCIERR_BASE + 37
const MCIERR_NO_CLOSING_QUOTE = MCIERR_BASE + 38
const MCIERR_DUPLICATE_FLAGS = MCIERR_BASE + 39
const MCIERR_INVALID_FILE = MCIERR_BASE + 40
const MCIERR_NULL_PARAMETER_BLOCK = MCIERR_BASE + 41
const MCIERR_UNNAMED_RESOURCE = MCIERR_BASE + 42
const MCIERR_NEW_REQUIRES_ALIAS = MCIERR_BASE + 43
const MCIERR_NOTIFY_ON_AUTO_OPEN = MCIERR_BASE + 44
const MCIERR_NO_ELEMENT_ALLOWED = MCIERR_BASE + 45
const MCIERR_NONAPPLICABLE_FUNCTION = MCIERR_BASE + 46
const MCIERR_ILLEGAL_FOR_AUTO_OPEN = MCIERR_BASE + 47
const MCIERR_FILENAME_REQUIRED = MCIERR_BASE + 48
const MCIERR_EXTRA_CHARACTERS = MCIERR_BASE + 49
const MCIERR_DEVICE_NOT_INSTALLED = MCIERR_BASE + 50
const MCIERR_GET_CD = MCIERR_BASE + 51
const MCIERR_SET_CD = MCIERR_BASE + 52
const MCIERR_SET_DRIVE = MCIERR_BASE + 53
const MCIERR_DEVICE_LENGTH = MCIERR_BASE + 54
const MCIERR_DEVICE_ORD_LENGTH = MCIERR_BASE + 55
const MCIERR_NO_INTEGER = MCIERR_BASE + 56
const MCIERR_WAVE_OUTPUTSINUSE = MCIERR_BASE + 64
const MCIERR_WAVE_SETOUTPUTINUSE = MCIERR_BASE + 65
const MCIERR_WAVE_INPUTSINUSE = MCIERR_BASE + 66
const MCIERR_WAVE_SETINPUTINUSE = MCIERR_BASE + 67
const MCIERR_WAVE_OUTPUTUNSPECIFIED = MCIERR_BASE + 68
const MCIERR_WAVE_INPUTUNSPECIFIED = MCIERR_BASE + 69
const MCIERR_WAVE_OUTPUTSUNSUITABLE = MCIERR_BASE + 70
const MCIERR_WAVE_SETOUTPUTUNSUITABLE = MCIERR_BASE + 71
const MCIERR_WAVE_INPUTSUNSUITABLE = MCIERR_BASE + 72
const MCIERR_WAVE_SETINPUTUNSUITABLE = MCIERR_BASE + 73
const MCIERR_SEQ_DIV_INCOMPATIBLE = MCIERR_BASE + 80
const MCIERR_SEQ_PORT_INUSE = MCIERR_BASE + 81
const MCIERR_SEQ_PORT_NONEXISTENT = MCIERR_BASE + 82
const MCIERR_SEQ_PORT_MAPNODEVICE = MCIERR_BASE + 83
const MCIERR_SEQ_PORT_MISCERROR = MCIERR_BASE + 84
const MCIERR_SEQ_TIMER = MCIERR_BASE + 85
const MCIERR_SEQ_PORTUNSPECIFIED = MCIERR_BASE + 86
const MCIERR_SEQ_NOMIDIPRESENT = MCIERR_BASE + 87
const MCIERR_NO_WINDOW = MCIERR_BASE + 90
const MCIERR_CREATEWINDOW = MCIERR_BASE + 91
const MCIERR_FILE_READ = MCIERR_BASE + 92
const MCIERR_FILE_WRITE = MCIERR_BASE + 93
const MCIERR_NO_IDENTITY = MCIERR_BASE + 94
const MCIERR_CUSTOM_DRIVER_BASE = MCIERR_BASE + 256
const MCI_FIRST = DRV_MCI_FIRST
const MCI_OPEN = &h0803
const MCI_CLOSE = &h0804
const MCI_ESCAPE = &h0805
const MCI_PLAY = &h0806
const MCI_SEEK = &h0807
const MCI_STOP = &h0808
const MCI_PAUSE = &h0809
const MCI_INFO = &h080A
const MCI_GETDEVCAPS = &h080B
const MCI_SPIN = &h080C
const MCI_SET = &h080D
const MCI_STEP = &h080E
const MCI_RECORD = &h080F
const MCI_SYSINFO = &h0810
const MCI_BREAK = &h0811
const MCI_SAVE = &h0813
const MCI_STATUS = &h0814
const MCI_CUE = &h0830
const MCI_REALIZE = &h0840
const MCI_WINDOW = &h0841
const MCI_PUT = &h0842
const MCI_WHERE = &h0843
const MCI_FREEZE = &h0844
const MCI_UNFREEZE = &h0845
const MCI_LOAD = &h0850
const MCI_CUT = &h0851
const MCI_COPY = &h0852
const MCI_PASTE = &h0853
const MCI_UPDATE = &h0854
const MCI_RESUME = &h0855
const MCI_DELETE = &h0856
const MCI_USER_MESSAGES = DRV_MCI_FIRST + &h400
const MCI_LAST = &h0FFF
const MCI_ALL_DEVICE_ID = cast(MCIDEVICEID, -1)
const MCI_DEVTYPE_VCR = 513
const MCI_DEVTYPE_VIDEODISC = 514
const MCI_DEVTYPE_OVERLAY = 515
const MCI_DEVTYPE_CD_AUDIO = 516
const MCI_DEVTYPE_DAT = 517
const MCI_DEVTYPE_SCANNER = 518
const MCI_DEVTYPE_ANIMATION = 519
const MCI_DEVTYPE_DIGITAL_VIDEO = 520
const MCI_DEVTYPE_OTHER = 521
const MCI_DEVTYPE_WAVEFORM_AUDIO = 522
const MCI_DEVTYPE_SEQUENCER = 523
const MCI_DEVTYPE_FIRST = MCI_DEVTYPE_VCR
const MCI_DEVTYPE_LAST = MCI_DEVTYPE_SEQUENCER
const MCI_DEVTYPE_FIRST_USER = &h1000
const MCI_MODE_NOT_READY = MCI_STRING_OFFSET + 12
const MCI_MODE_STOP = MCI_STRING_OFFSET + 13
const MCI_MODE_PLAY = MCI_STRING_OFFSET + 14
const MCI_MODE_RECORD = MCI_STRING_OFFSET + 15
const MCI_MODE_SEEK = MCI_STRING_OFFSET + 16
const MCI_MODE_PAUSE = MCI_STRING_OFFSET + 17
const MCI_MODE_OPEN = MCI_STRING_OFFSET + 18
const MCI_FORMAT_MILLISECONDS = 0
const MCI_FORMAT_HMS = 1
const MCI_FORMAT_MSF = 2
const MCI_FORMAT_FRAMES = 3
const MCI_FORMAT_SMPTE_24 = 4
const MCI_FORMAT_SMPTE_25 = 5
const MCI_FORMAT_SMPTE_30 = 6
const MCI_FORMAT_SMPTE_30DROP = 7
const MCI_FORMAT_BYTES = 8
const MCI_FORMAT_SAMPLES = 9
const MCI_FORMAT_TMSF = 10
#define MCI_MSF_MINUTE(msf) cast(UBYTE, (msf))
#define MCI_MSF_SECOND(msf) cast(UBYTE, cast(WORD, (msf)) shr 8)
#define MCI_MSF_FRAME(msf) cast(UBYTE, (msf) shr 16)
#define MCI_MAKE_MSF(m, s, f) cast(DWORD, (cast(UBYTE, (m)) or (cast(WORD, (s)) shl 8)) or (cast(DWORD, cast(UBYTE, (f))) shl 16))
#define MCI_TMSF_TRACK(tmsf) cast(UBYTE, (tmsf))
#define MCI_TMSF_MINUTE(tmsf) cast(UBYTE, cast(WORD, (tmsf)) shr 8)
#define MCI_TMSF_SECOND(tmsf) cast(UBYTE, (tmsf) shr 16)
#define MCI_TMSF_FRAME(tmsf) cast(UBYTE, (tmsf) shr 24)
#define MCI_MAKE_TMSF(t, m, s, f) cast(DWORD, (cast(UBYTE, (t)) or (cast(WORD, (m)) shl 8)) or ((cast(DWORD, cast(UBYTE, (s))) or (cast(WORD, (f)) shl 8)) shl 16))
#define MCI_HMS_HOUR(hms) cast(UBYTE, (hms))
#define MCI_HMS_MINUTE(hms) cast(UBYTE, cast(WORD, (hms)) shr 8)
#define MCI_HMS_SECOND(hms) cast(UBYTE, (hms) shr 16)
#define MCI_MAKE_HMS(h, m, s) cast(DWORD, (cast(UBYTE, (h)) or (cast(WORD, (m)) shl 8)) or (cast(DWORD, cast(UBYTE, (s))) shl 16))
const MCI_NOTIFY_SUCCESSFUL = &h0001
const MCI_NOTIFY_SUPERSEDED = &h0002
const MCI_NOTIFY_ABORTED = &h0004
const MCI_NOTIFY_FAILURE = &h0008
const MCI_NOTIFY = &h00000001
const MCI_WAIT = &h00000002
const MCI_FROM = &h00000004
const MCI_TO = &h00000008
const MCI_TRACK = &h00000010
const MCI_OPEN_SHAREABLE = &h00000100
const MCI_OPEN_ELEMENT = &h00000200
const MCI_OPEN_ALIAS = &h00000400
const MCI_OPEN_ELEMENT_ID = &h00000800
const MCI_OPEN_TYPE_ID = &h00001000
const MCI_OPEN_TYPE = &h00002000
const MCI_SEEK_TO_START = &h00000100
const MCI_SEEK_TO_END = &h00000200
const MCI_STATUS_ITEM = &h00000100
const MCI_STATUS_START = &h00000200
const MCI_STATUS_LENGTH = &h00000001
const MCI_STATUS_POSITION = &h00000002
const MCI_STATUS_NUMBER_OF_TRACKS = &h00000003
const MCI_STATUS_MODE = &h00000004
const MCI_STATUS_MEDIA_PRESENT = &h00000005
const MCI_STATUS_TIME_FORMAT = &h00000006
const MCI_STATUS_READY = &h00000007
const MCI_STATUS_CURRENT_TRACK = &h00000008
const MCI_INFO_PRODUCT = &h00000100
const MCI_INFO_FILE = &h00000200
const MCI_INFO_MEDIA_UPC = &h00000400
const MCI_INFO_MEDIA_IDENTITY = &h00000800
const MCI_INFO_NAME = &h00001000
const MCI_INFO_COPYRIGHT = &h00002000
const MCI_GETDEVCAPS_ITEM = &h00000100
const MCI_GETDEVCAPS_CAN_RECORD = &h00000001
const MCI_GETDEVCAPS_HAS_AUDIO = &h00000002
const MCI_GETDEVCAPS_HAS_VIDEO = &h00000003
const MCI_GETDEVCAPS_DEVICE_TYPE = &h00000004
const MCI_GETDEVCAPS_USES_FILES = &h00000005
const MCI_GETDEVCAPS_COMPOUND_DEVICE = &h00000006
const MCI_GETDEVCAPS_CAN_EJECT = &h00000007
const MCI_GETDEVCAPS_CAN_PLAY = &h00000008
const MCI_GETDEVCAPS_CAN_SAVE = &h00000009
const MCI_SYSINFO_QUANTITY = &h00000100
const MCI_SYSINFO_OPEN = &h00000200
const MCI_SYSINFO_NAME = &h00000400
const MCI_SYSINFO_INSTALLNAME = &h00000800
const MCI_SET_DOOR_OPEN = &h00000100
const MCI_SET_DOOR_CLOSED = &h00000200
const MCI_SET_TIME_FORMAT = &h00000400
const MCI_SET_AUDIO = &h00000800
const MCI_SET_VIDEO = &h00001000
const MCI_SET_ON = &h00002000
const MCI_SET_OFF = &h00004000
const MCI_SET_AUDIO_ALL = &h00000000
const MCI_SET_AUDIO_LEFT = &h00000001
const MCI_SET_AUDIO_RIGHT = &h00000002
const MCI_BREAK_KEY = &h00000100
const MCI_BREAK_HWND = &h00000200
const MCI_BREAK_OFF = &h00000400
const MCI_RECORD_INSERT = &h00000100
const MCI_RECORD_OVERWRITE = &h00000200
const MCI_SAVE_FILE = &h00000100
const MCI_LOAD_FILE = &h00000100

type tagMCI_GENERIC_PARMS field = 1
	dwCallback as DWORD_PTR
end type

type MCI_GENERIC_PARMS as tagMCI_GENERIC_PARMS
type PMCI_GENERIC_PARMS as tagMCI_GENERIC_PARMS ptr
type LPMCI_GENERIC_PARMS as tagMCI_GENERIC_PARMS ptr

type tagMCI_OPEN_PARMSA field = 1
	dwCallback as DWORD_PTR
	wDeviceID as MCIDEVICEID
	lpstrDeviceType as LPCSTR
	lpstrElementName as LPCSTR
	lpstrAlias as LPCSTR
end type

type MCI_OPEN_PARMSA as tagMCI_OPEN_PARMSA
type PMCI_OPEN_PARMSA as tagMCI_OPEN_PARMSA ptr
type LPMCI_OPEN_PARMSA as tagMCI_OPEN_PARMSA ptr

type tagMCI_OPEN_PARMSW field = 1
	dwCallback as DWORD_PTR
	wDeviceID as MCIDEVICEID
	lpstrDeviceType as LPCWSTR
	lpstrElementName as LPCWSTR
	lpstrAlias as LPCWSTR
end type

type MCI_OPEN_PARMSW as tagMCI_OPEN_PARMSW
type PMCI_OPEN_PARMSW as tagMCI_OPEN_PARMSW ptr
type LPMCI_OPEN_PARMSW as tagMCI_OPEN_PARMSW ptr

#ifdef UNICODE
	type MCI_OPEN_PARMS as MCI_OPEN_PARMSW
	type PMCI_OPEN_PARMS as PMCI_OPEN_PARMSW
	type LPMCI_OPEN_PARMS as LPMCI_OPEN_PARMSW
#else
	type MCI_OPEN_PARMS as MCI_OPEN_PARMSA
	type PMCI_OPEN_PARMS as PMCI_OPEN_PARMSA
	type LPMCI_OPEN_PARMS as LPMCI_OPEN_PARMSA
#endif

type tagMCI_PLAY_PARMS field = 1
	dwCallback as DWORD_PTR
	dwFrom as DWORD
	dwTo as DWORD
end type

type MCI_PLAY_PARMS as tagMCI_PLAY_PARMS
type PMCI_PLAY_PARMS as tagMCI_PLAY_PARMS ptr
type LPMCI_PLAY_PARMS as tagMCI_PLAY_PARMS ptr

type tagMCI_SEEK_PARMS field = 1
	dwCallback as DWORD_PTR
	dwTo as DWORD
end type

type MCI_SEEK_PARMS as tagMCI_SEEK_PARMS
type PMCI_SEEK_PARMS as tagMCI_SEEK_PARMS ptr
type LPMCI_SEEK_PARMS as tagMCI_SEEK_PARMS ptr

type tagMCI_STATUS_PARMS field = 1
	dwCallback as DWORD_PTR
	dwReturn as DWORD_PTR
	dwItem as DWORD
	dwTrack as DWORD
end type

type MCI_STATUS_PARMS as tagMCI_STATUS_PARMS
type PMCI_STATUS_PARMS as tagMCI_STATUS_PARMS ptr
type LPMCI_STATUS_PARMS as tagMCI_STATUS_PARMS ptr

type tagMCI_INFO_PARMSA field = 1
	dwCallback as DWORD_PTR
	lpstrReturn as LPSTR
	dwRetSize as DWORD
end type

type MCI_INFO_PARMSA as tagMCI_INFO_PARMSA
type LPMCI_INFO_PARMSA as tagMCI_INFO_PARMSA ptr

type tagMCI_INFO_PARMSW field = 1
	dwCallback as DWORD_PTR
	lpstrReturn as LPWSTR
	dwRetSize as DWORD
end type

type MCI_INFO_PARMSW as tagMCI_INFO_PARMSW
type LPMCI_INFO_PARMSW as tagMCI_INFO_PARMSW ptr

#ifdef UNICODE
	type MCI_INFO_PARMS as MCI_INFO_PARMSW
	type LPMCI_INFO_PARMS as LPMCI_INFO_PARMSW
#else
	type MCI_INFO_PARMS as MCI_INFO_PARMSA
	type LPMCI_INFO_PARMS as LPMCI_INFO_PARMSA
#endif

type tagMCI_GETDEVCAPS_PARMS field = 1
	dwCallback as DWORD_PTR
	dwReturn as DWORD
	dwItem as DWORD
end type

type MCI_GETDEVCAPS_PARMS as tagMCI_GETDEVCAPS_PARMS
type PMCI_GETDEVCAPS_PARMS as tagMCI_GETDEVCAPS_PARMS ptr
type LPMCI_GETDEVCAPS_PARMS as tagMCI_GETDEVCAPS_PARMS ptr

type tagMCI_SYSINFO_PARMSA field = 1
	dwCallback as DWORD_PTR
	lpstrReturn as LPSTR
	dwRetSize as DWORD
	dwNumber as DWORD
	wDeviceType as UINT
end type

type MCI_SYSINFO_PARMSA as tagMCI_SYSINFO_PARMSA
type PMCI_SYSINFO_PARMSA as tagMCI_SYSINFO_PARMSA ptr
type LPMCI_SYSINFO_PARMSA as tagMCI_SYSINFO_PARMSA ptr

type tagMCI_SYSINFO_PARMSW field = 1
	dwCallback as DWORD_PTR
	lpstrReturn as LPWSTR
	dwRetSize as DWORD
	dwNumber as DWORD
	wDeviceType as UINT
end type

type MCI_SYSINFO_PARMSW as tagMCI_SYSINFO_PARMSW
type PMCI_SYSINFO_PARMSW as tagMCI_SYSINFO_PARMSW ptr
type LPMCI_SYSINFO_PARMSW as tagMCI_SYSINFO_PARMSW ptr

#ifdef UNICODE
	type MCI_SYSINFO_PARMS as MCI_SYSINFO_PARMSW
	type PMCI_SYSINFO_PARMS as PMCI_SYSINFO_PARMSW
	type LPMCI_SYSINFO_PARMS as LPMCI_SYSINFO_PARMSW
#else
	type MCI_SYSINFO_PARMS as MCI_SYSINFO_PARMSA
	type PMCI_SYSINFO_PARMS as PMCI_SYSINFO_PARMSA
	type LPMCI_SYSINFO_PARMS as LPMCI_SYSINFO_PARMSA
#endif

type tagMCI_SET_PARMS field = 1
	dwCallback as DWORD_PTR
	dwTimeFormat as DWORD
	dwAudio as DWORD
end type

type MCI_SET_PARMS as tagMCI_SET_PARMS
type PMCI_SET_PARMS as tagMCI_SET_PARMS ptr
type LPMCI_SET_PARMS as tagMCI_SET_PARMS ptr

type tagMCI_BREAK_PARMS field = 1
	dwCallback as DWORD_PTR
	nVirtKey as long
	hwndBreak as HWND
end type

type MCI_BREAK_PARMS as tagMCI_BREAK_PARMS
type PMCI_BREAK_PARMS as tagMCI_BREAK_PARMS ptr
type LPMCI_BREAK_PARMS as tagMCI_BREAK_PARMS ptr

type tagMCI_SAVE_PARMSA field = 1
	dwCallback as DWORD_PTR
	lpfilename as LPCSTR
end type

type MCI_SAVE_PARMSA as tagMCI_SAVE_PARMSA
type PMCI_SAVE_PARMSA as tagMCI_SAVE_PARMSA ptr
type LPMCI_SAVE_PARMSA as tagMCI_SAVE_PARMSA ptr

type tagMCI_SAVE_PARMSW field = 1
	dwCallback as DWORD_PTR
	lpfilename as LPCWSTR
end type

type MCI_SAVE_PARMSW as tagMCI_SAVE_PARMSW
type PMCI_SAVE_PARMSW as tagMCI_SAVE_PARMSW ptr
type LPMCI_SAVE_PARMSW as tagMCI_SAVE_PARMSW ptr

#ifdef UNICODE
	type MCI_SAVE_PARMS as MCI_SAVE_PARMSW
	type PMCI_SAVE_PARMS as PMCI_SAVE_PARMSW
	type LPMCI_SAVE_PARMS as LPMCI_SAVE_PARMSW
#else
	type MCI_SAVE_PARMS as MCI_SAVE_PARMSA
	type PMCI_SAVE_PARMS as PMCI_SAVE_PARMSA
	type LPMCI_SAVE_PARMS as LPMCI_SAVE_PARMSA
#endif

type tagMCI_LOAD_PARMSA field = 1
	dwCallback as DWORD_PTR
	lpfilename as LPCSTR
end type

type MCI_LOAD_PARMSA as tagMCI_LOAD_PARMSA
type PMCI_LOAD_PARMSA as tagMCI_LOAD_PARMSA ptr
type LPMCI_LOAD_PARMSA as tagMCI_LOAD_PARMSA ptr

type tagMCI_LOAD_PARMSW field = 1
	dwCallback as DWORD_PTR
	lpfilename as LPCWSTR
end type

type MCI_LOAD_PARMSW as tagMCI_LOAD_PARMSW
type PMCI_LOAD_PARMSW as tagMCI_LOAD_PARMSW ptr
type LPMCI_LOAD_PARMSW as tagMCI_LOAD_PARMSW ptr

#ifdef UNICODE
	type MCI_LOAD_PARMS as MCI_LOAD_PARMSW
	type PMCI_LOAD_PARMS as PMCI_LOAD_PARMSW
	type LPMCI_LOAD_PARMS as LPMCI_LOAD_PARMSW
#else
	type MCI_LOAD_PARMS as MCI_LOAD_PARMSA
	type PMCI_LOAD_PARMS as PMCI_LOAD_PARMSA
	type LPMCI_LOAD_PARMS as LPMCI_LOAD_PARMSA
#endif

type tagMCI_RECORD_PARMS field = 1
	dwCallback as DWORD_PTR
	dwFrom as DWORD
	dwTo as DWORD
end type

type MCI_RECORD_PARMS as tagMCI_RECORD_PARMS
type LPMCI_RECORD_PARMS as tagMCI_RECORD_PARMS ptr
const MCI_VD_MODE_PARK = MCI_VD_OFFSET + 1
const MCI_VD_MEDIA_CLV = MCI_VD_OFFSET + 2
const MCI_VD_MEDIA_CAV = MCI_VD_OFFSET + 3
const MCI_VD_MEDIA_OTHER = MCI_VD_OFFSET + 4
const MCI_VD_FORMAT_TRACK = &h4001
const MCI_VD_PLAY_REVERSE = &h00010000
const MCI_VD_PLAY_FAST = &h00020000
const MCI_VD_PLAY_SPEED = &h00040000
const MCI_VD_PLAY_SCAN = &h00080000
const MCI_VD_PLAY_SLOW = &h00100000
const MCI_VD_SEEK_REVERSE = &h00010000
const MCI_VD_STATUS_SPEED = &h00004002
const MCI_VD_STATUS_FORWARD = &h00004003
const MCI_VD_STATUS_MEDIA_TYPE = &h00004004
const MCI_VD_STATUS_SIDE = &h00004005
const MCI_VD_STATUS_DISC_SIZE = &h00004006
const MCI_VD_GETDEVCAPS_CLV = &h00010000
const MCI_VD_GETDEVCAPS_CAV = &h00020000
const MCI_VD_SPIN_UP = &h00010000
const MCI_VD_SPIN_DOWN = &h00020000
const MCI_VD_GETDEVCAPS_CAN_REVERSE = &h00004002
const MCI_VD_GETDEVCAPS_FAST_RATE = &h00004003
const MCI_VD_GETDEVCAPS_SLOW_RATE = &h00004004
const MCI_VD_GETDEVCAPS_NORMAL_RATE = &h00004005
const MCI_VD_STEP_FRAMES = &h00010000
const MCI_VD_STEP_REVERSE = &h00020000
const MCI_VD_ESCAPE_STRING = &h00000100

type tagMCI_VD_PLAY_PARMS field = 1
	dwCallback as DWORD_PTR
	dwFrom as DWORD
	dwTo as DWORD
	dwSpeed as DWORD
end type

type MCI_VD_PLAY_PARMS as tagMCI_VD_PLAY_PARMS
type PMCI_VD_PLAY_PARMS as tagMCI_VD_PLAY_PARMS ptr
type LPMCI_VD_PLAY_PARMS as tagMCI_VD_PLAY_PARMS ptr

type tagMCI_VD_STEP_PARMS field = 1
	dwCallback as DWORD_PTR
	dwFrames as DWORD
end type

type MCI_VD_STEP_PARMS as tagMCI_VD_STEP_PARMS
type PMCI_VD_STEP_PARMS as tagMCI_VD_STEP_PARMS ptr
type LPMCI_VD_STEP_PARMS as tagMCI_VD_STEP_PARMS ptr

type tagMCI_VD_ESCAPE_PARMSA field = 1
	dwCallback as DWORD_PTR
	lpstrCommand as LPCSTR
end type

type MCI_VD_ESCAPE_PARMSA as tagMCI_VD_ESCAPE_PARMSA
type PMCI_VD_ESCAPE_PARMSA as tagMCI_VD_ESCAPE_PARMSA ptr
type LPMCI_VD_ESCAPE_PARMSA as tagMCI_VD_ESCAPE_PARMSA ptr

type tagMCI_VD_ESCAPE_PARMSW field = 1
	dwCallback as DWORD_PTR
	lpstrCommand as LPCWSTR
end type

type MCI_VD_ESCAPE_PARMSW as tagMCI_VD_ESCAPE_PARMSW
type PMCI_VD_ESCAPE_PARMSW as tagMCI_VD_ESCAPE_PARMSW ptr
type LPMCI_VD_ESCAPE_PARMSW as tagMCI_VD_ESCAPE_PARMSW ptr

#ifdef UNICODE
	type MCI_VD_ESCAPE_PARMS as MCI_VD_ESCAPE_PARMSW
	type PMCI_VD_ESCAPE_PARMS as PMCI_VD_ESCAPE_PARMSW
	type LPMCI_VD_ESCAPE_PARMS as LPMCI_VD_ESCAPE_PARMSW
#else
	type MCI_VD_ESCAPE_PARMS as MCI_VD_ESCAPE_PARMSA
	type PMCI_VD_ESCAPE_PARMS as PMCI_VD_ESCAPE_PARMSA
	type LPMCI_VD_ESCAPE_PARMS as LPMCI_VD_ESCAPE_PARMSA
#endif

const MCI_CDA_STATUS_TYPE_TRACK = &h00004001
const MCI_CDA_TRACK_AUDIO = MCI_CD_OFFSET + 0
const MCI_CDA_TRACK_OTHER = MCI_CD_OFFSET + 1
const MCI_WAVE_PCM = MCI_WAVE_OFFSET + 0
const MCI_WAVE_MAPPER = MCI_WAVE_OFFSET + 1
const MCI_WAVE_OPEN_BUFFER = &h00010000
const MCI_WAVE_SET_FORMATTAG = &h00010000
const MCI_WAVE_SET_CHANNELS = &h00020000
const MCI_WAVE_SET_SAMPLESPERSEC = &h00040000
const MCI_WAVE_SET_AVGBYTESPERSEC = &h00080000
const MCI_WAVE_SET_BLOCKALIGN = &h00100000
const MCI_WAVE_SET_BITSPERSAMPLE = &h00200000
const MCI_WAVE_INPUT = &h00400000
const MCI_WAVE_OUTPUT = &h00800000
const MCI_WAVE_STATUS_FORMATTAG = &h00004001
const MCI_WAVE_STATUS_CHANNELS = &h00004002
const MCI_WAVE_STATUS_SAMPLESPERSEC = &h00004003
const MCI_WAVE_STATUS_AVGBYTESPERSEC = &h00004004
const MCI_WAVE_STATUS_BLOCKALIGN = &h00004005
const MCI_WAVE_STATUS_BITSPERSAMPLE = &h00004006
const MCI_WAVE_STATUS_LEVEL = &h00004007
const MCI_WAVE_SET_ANYINPUT = &h04000000
const MCI_WAVE_SET_ANYOUTPUT = &h08000000
const MCI_WAVE_GETDEVCAPS_INPUTS = &h00004001
const MCI_WAVE_GETDEVCAPS_OUTPUTS = &h00004002

type tagMCI_WAVE_OPEN_PARMSA field = 1
	dwCallback as DWORD_PTR
	wDeviceID as MCIDEVICEID
	lpstrDeviceType as LPCSTR
	lpstrElementName as LPCSTR
	lpstrAlias as LPCSTR
	dwBufferSeconds as DWORD
end type

type MCI_WAVE_OPEN_PARMSA as tagMCI_WAVE_OPEN_PARMSA
type PMCI_WAVE_OPEN_PARMSA as tagMCI_WAVE_OPEN_PARMSA ptr
type LPMCI_WAVE_OPEN_PARMSA as tagMCI_WAVE_OPEN_PARMSA ptr

type tagMCI_WAVE_OPEN_PARMSW field = 1
	dwCallback as DWORD_PTR
	wDeviceID as MCIDEVICEID
	lpstrDeviceType as LPCWSTR
	lpstrElementName as LPCWSTR
	lpstrAlias as LPCWSTR
	dwBufferSeconds as DWORD
end type

type MCI_WAVE_OPEN_PARMSW as tagMCI_WAVE_OPEN_PARMSW
type PMCI_WAVE_OPEN_PARMSW as tagMCI_WAVE_OPEN_PARMSW ptr
type LPMCI_WAVE_OPEN_PARMSW as tagMCI_WAVE_OPEN_PARMSW ptr

#ifdef UNICODE
	type MCI_WAVE_OPEN_PARMS as MCI_WAVE_OPEN_PARMSW
	type PMCI_WAVE_OPEN_PARMS as PMCI_WAVE_OPEN_PARMSW
	type LPMCI_WAVE_OPEN_PARMS as LPMCI_WAVE_OPEN_PARMSW
#else
	type MCI_WAVE_OPEN_PARMS as MCI_WAVE_OPEN_PARMSA
	type PMCI_WAVE_OPEN_PARMS as PMCI_WAVE_OPEN_PARMSA
	type LPMCI_WAVE_OPEN_PARMS as LPMCI_WAVE_OPEN_PARMSA
#endif

type tagMCI_WAVE_DELETE_PARMS field = 1
	dwCallback as DWORD_PTR
	dwFrom as DWORD
	dwTo as DWORD
end type

type MCI_WAVE_DELETE_PARMS as tagMCI_WAVE_DELETE_PARMS
type PMCI_WAVE_DELETE_PARMS as tagMCI_WAVE_DELETE_PARMS ptr
type LPMCI_WAVE_DELETE_PARMS as tagMCI_WAVE_DELETE_PARMS ptr

type tagMCI_WAVE_SET_PARMS field = 1
	dwCallback as DWORD_PTR
	dwTimeFormat as DWORD
	dwAudio as DWORD
	wInput as UINT
	wOutput as UINT
	wFormatTag as WORD
	wReserved2 as WORD
	nChannels as WORD
	wReserved3 as WORD
	nSamplesPerSec as DWORD
	nAvgBytesPerSec as DWORD
	nBlockAlign as WORD
	wReserved4 as WORD
	wBitsPerSample as WORD
	wReserved5 as WORD
end type

type MCI_WAVE_SET_PARMS as tagMCI_WAVE_SET_PARMS
type PMCI_WAVE_SET_PARMS as tagMCI_WAVE_SET_PARMS ptr
type LPMCI_WAVE_SET_PARMS as tagMCI_WAVE_SET_PARMS ptr

const MCI_SEQ_DIV_PPQN = 0 + MCI_SEQ_OFFSET
const MCI_SEQ_DIV_SMPTE_24 = 1 + MCI_SEQ_OFFSET
const MCI_SEQ_DIV_SMPTE_25 = 2 + MCI_SEQ_OFFSET
const MCI_SEQ_DIV_SMPTE_30DROP = 3 + MCI_SEQ_OFFSET
const MCI_SEQ_DIV_SMPTE_30 = 4 + MCI_SEQ_OFFSET
const MCI_SEQ_FORMAT_SONGPTR = &h4001
const MCI_SEQ_FILE = &h4002
const MCI_SEQ_MIDI = &h4003
const MCI_SEQ_SMPTE = &h4004
const MCI_SEQ_NONE = 65533
const MCI_SEQ_MAPPER = 65535
const MCI_SEQ_STATUS_TEMPO = &h00004002
const MCI_SEQ_STATUS_PORT = &h00004003
const MCI_SEQ_STATUS_SLAVE = &h00004007
const MCI_SEQ_STATUS_MASTER = &h00004008
const MCI_SEQ_STATUS_OFFSET = &h00004009
const MCI_SEQ_STATUS_DIVTYPE = &h0000400A
const MCI_SEQ_STATUS_NAME = &h0000400B
const MCI_SEQ_STATUS_COPYRIGHT = &h0000400C
const MCI_SEQ_SET_TEMPO = &h00010000
const MCI_SEQ_SET_PORT = &h00020000
const MCI_SEQ_SET_SLAVE = &h00040000
const MCI_SEQ_SET_MASTER = &h00080000
const MCI_SEQ_SET_OFFSET = &h01000000

type tagMCI_SEQ_SET_PARMS field = 1
	dwCallback as DWORD_PTR
	dwTimeFormat as DWORD
	dwAudio as DWORD
	dwTempo as DWORD
	dwPort as DWORD
	dwSlave as DWORD
	dwMaster as DWORD
	dwOffset as DWORD
end type

type MCI_SEQ_SET_PARMS as tagMCI_SEQ_SET_PARMS
type PMCI_SEQ_SET_PARMS as tagMCI_SEQ_SET_PARMS ptr
type LPMCI_SEQ_SET_PARMS as tagMCI_SEQ_SET_PARMS ptr

const MCI_ANIM_OPEN_WS = &h00010000
const MCI_ANIM_OPEN_PARENT = &h00020000
const MCI_ANIM_OPEN_NOSTATIC = &h00040000
const MCI_ANIM_PLAY_SPEED = &h00010000
const MCI_ANIM_PLAY_REVERSE = &h00020000
const MCI_ANIM_PLAY_FAST = &h00040000
const MCI_ANIM_PLAY_SLOW = &h00080000
const MCI_ANIM_PLAY_SCAN = &h00100000
const MCI_ANIM_STEP_REVERSE = &h00010000
const MCI_ANIM_STEP_FRAMES = &h00020000
const MCI_ANIM_STATUS_SPEED = &h00004001
const MCI_ANIM_STATUS_FORWARD = &h00004002
const MCI_ANIM_STATUS_HWND = &h00004003
const MCI_ANIM_STATUS_HPAL = &h00004004
const MCI_ANIM_STATUS_STRETCH = &h00004005
const MCI_ANIM_INFO_TEXT = &h00010000
const MCI_ANIM_GETDEVCAPS_CAN_REVERSE = &h00004001
const MCI_ANIM_GETDEVCAPS_FAST_RATE = &h00004002
const MCI_ANIM_GETDEVCAPS_SLOW_RATE = &h00004003
const MCI_ANIM_GETDEVCAPS_NORMAL_RATE = &h00004004
const MCI_ANIM_GETDEVCAPS_PALETTES = &h00004006
const MCI_ANIM_GETDEVCAPS_CAN_STRETCH = &h00004007
const MCI_ANIM_GETDEVCAPS_MAX_WINDOWS = &h00004008
const MCI_ANIM_REALIZE_NORM = &h00010000
const MCI_ANIM_REALIZE_BKGD = &h00020000
const MCI_ANIM_WINDOW_HWND = &h00010000
const MCI_ANIM_WINDOW_STATE = &h00040000
const MCI_ANIM_WINDOW_TEXT = &h00080000
const MCI_ANIM_WINDOW_ENABLE_STRETCH = &h00100000
const MCI_ANIM_WINDOW_DISABLE_STRETCH = &h00200000
const MCI_ANIM_WINDOW_DEFAULT = &h00000000
const MCI_ANIM_RECT = &h00010000
const MCI_ANIM_PUT_SOURCE = &h00020000
const MCI_ANIM_PUT_DESTINATION = &h00040000
const MCI_ANIM_WHERE_SOURCE = &h00020000
const MCI_ANIM_WHERE_DESTINATION = &h00040000
const MCI_ANIM_UPDATE_HDC = &h00020000

type tagMCI_ANIM_OPEN_PARMSA field = 1
	dwCallback as DWORD_PTR
	wDeviceID as MCIDEVICEID
	lpstrDeviceType as LPCSTR
	lpstrElementName as LPCSTR
	lpstrAlias as LPCSTR
	dwStyle as DWORD
	hWndParent as HWND
end type

type MCI_ANIM_OPEN_PARMSA as tagMCI_ANIM_OPEN_PARMSA
type PMCI_ANIM_OPEN_PARMSA as tagMCI_ANIM_OPEN_PARMSA ptr
type LPMCI_ANIM_OPEN_PARMSA as tagMCI_ANIM_OPEN_PARMSA ptr

type tagMCI_ANIM_OPEN_PARMSW field = 1
	dwCallback as DWORD_PTR
	wDeviceID as MCIDEVICEID
	lpstrDeviceType as LPCWSTR
	lpstrElementName as LPCWSTR
	lpstrAlias as LPCWSTR
	dwStyle as DWORD
	hWndParent as HWND
end type

type MCI_ANIM_OPEN_PARMSW as tagMCI_ANIM_OPEN_PARMSW
type PMCI_ANIM_OPEN_PARMSW as tagMCI_ANIM_OPEN_PARMSW ptr
type LPMCI_ANIM_OPEN_PARMSW as tagMCI_ANIM_OPEN_PARMSW ptr

#ifdef UNICODE
	type MCI_ANIM_OPEN_PARMS as MCI_ANIM_OPEN_PARMSW
	type PMCI_ANIM_OPEN_PARMS as PMCI_ANIM_OPEN_PARMSW
	type LPMCI_ANIM_OPEN_PARMS as LPMCI_ANIM_OPEN_PARMSW
#else
	type MCI_ANIM_OPEN_PARMS as MCI_ANIM_OPEN_PARMSA
	type PMCI_ANIM_OPEN_PARMS as PMCI_ANIM_OPEN_PARMSA
	type LPMCI_ANIM_OPEN_PARMS as LPMCI_ANIM_OPEN_PARMSA
#endif

type tagMCI_ANIM_PLAY_PARMS field = 1
	dwCallback as DWORD_PTR
	dwFrom as DWORD
	dwTo as DWORD
	dwSpeed as DWORD
end type

type MCI_ANIM_PLAY_PARMS as tagMCI_ANIM_PLAY_PARMS
type PMCI_ANIM_PLAY_PARMS as tagMCI_ANIM_PLAY_PARMS ptr
type LPMCI_ANIM_PLAY_PARMS as tagMCI_ANIM_PLAY_PARMS ptr

type tagMCI_ANIM_STEP_PARMS field = 1
	dwCallback as DWORD_PTR
	dwFrames as DWORD
end type

type MCI_ANIM_STEP_PARMS as tagMCI_ANIM_STEP_PARMS
type PMCI_ANIM_STEP_PARMS as tagMCI_ANIM_STEP_PARMS ptr
type LPMCI_ANIM_STEP_PARMS as tagMCI_ANIM_STEP_PARMS ptr

type tagMCI_ANIM_WINDOW_PARMSA field = 1
	dwCallback as DWORD_PTR
	hWnd as HWND
	nCmdShow as UINT
	lpstrText as LPCSTR
end type

type MCI_ANIM_WINDOW_PARMSA as tagMCI_ANIM_WINDOW_PARMSA
type PMCI_ANIM_WINDOW_PARMSA as tagMCI_ANIM_WINDOW_PARMSA ptr
type LPMCI_ANIM_WINDOW_PARMSA as tagMCI_ANIM_WINDOW_PARMSA ptr

type tagMCI_ANIM_WINDOW_PARMSW field = 1
	dwCallback as DWORD_PTR
	hWnd as HWND
	nCmdShow as UINT
	lpstrText as LPCWSTR
end type

type MCI_ANIM_WINDOW_PARMSW as tagMCI_ANIM_WINDOW_PARMSW
type PMCI_ANIM_WINDOW_PARMSW as tagMCI_ANIM_WINDOW_PARMSW ptr
type LPMCI_ANIM_WINDOW_PARMSW as tagMCI_ANIM_WINDOW_PARMSW ptr

#ifdef UNICODE
	type MCI_ANIM_WINDOW_PARMS as MCI_ANIM_WINDOW_PARMSW
	type PMCI_ANIM_WINDOW_PARMS as PMCI_ANIM_WINDOW_PARMSW
	type LPMCI_ANIM_WINDOW_PARMS as LPMCI_ANIM_WINDOW_PARMSW
#else
	type MCI_ANIM_WINDOW_PARMS as MCI_ANIM_WINDOW_PARMSA
	type PMCI_ANIM_WINDOW_PARMS as PMCI_ANIM_WINDOW_PARMSA
	type LPMCI_ANIM_WINDOW_PARMS as LPMCI_ANIM_WINDOW_PARMSA
#endif

type tagMCI_ANIM_RECT_PARMS field = 1
	dwCallback as DWORD_PTR
	rc as RECT
end type

type MCI_ANIM_RECT_PARMS as tagMCI_ANIM_RECT_PARMS
type PMCI_ANIM_RECT_PARMS as MCI_ANIM_RECT_PARMS ptr
type LPMCI_ANIM_RECT_PARMS as MCI_ANIM_RECT_PARMS ptr

type tagMCI_ANIM_UPDATE_PARMS field = 1
	dwCallback as DWORD_PTR
	rc as RECT
	hDC as HDC
end type

type MCI_ANIM_UPDATE_PARMS as tagMCI_ANIM_UPDATE_PARMS
type PMCI_ANIM_UPDATE_PARMS as tagMCI_ANIM_UPDATE_PARMS ptr
type LPMCI_ANIM_UPDATE_PARMS as tagMCI_ANIM_UPDATE_PARMS ptr

const MCI_OVLY_OPEN_WS = &h00010000
const MCI_OVLY_OPEN_PARENT = &h00020000
const MCI_OVLY_STATUS_HWND = &h00004001
const MCI_OVLY_STATUS_STRETCH = &h00004002
const MCI_OVLY_INFO_TEXT = &h00010000
const MCI_OVLY_GETDEVCAPS_CAN_STRETCH = &h00004001
const MCI_OVLY_GETDEVCAPS_CAN_FREEZE = &h00004002
const MCI_OVLY_GETDEVCAPS_MAX_WINDOWS = &h00004003
const MCI_OVLY_WINDOW_HWND = &h00010000
const MCI_OVLY_WINDOW_STATE = &h00040000
const MCI_OVLY_WINDOW_TEXT = &h00080000
const MCI_OVLY_WINDOW_ENABLE_STRETCH = &h00100000
const MCI_OVLY_WINDOW_DISABLE_STRETCH = &h00200000
const MCI_OVLY_WINDOW_DEFAULT = &h00000000
const MCI_OVLY_RECT = &h00010000
const MCI_OVLY_PUT_SOURCE = &h00020000
const MCI_OVLY_PUT_DESTINATION = &h00040000
const MCI_OVLY_PUT_FRAME = &h00080000
const MCI_OVLY_PUT_VIDEO = &h00100000
const MCI_OVLY_WHERE_SOURCE = &h00020000
const MCI_OVLY_WHERE_DESTINATION = &h00040000
const MCI_OVLY_WHERE_FRAME = &h00080000
const MCI_OVLY_WHERE_VIDEO = &h00100000

type tagMCI_OVLY_OPEN_PARMSA field = 1
	dwCallback as DWORD_PTR
	wDeviceID as MCIDEVICEID
	lpstrDeviceType as LPCSTR
	lpstrElementName as LPCSTR
	lpstrAlias as LPCSTR
	dwStyle as DWORD
	hWndParent as HWND
end type

type MCI_OVLY_OPEN_PARMSA as tagMCI_OVLY_OPEN_PARMSA
type PMCI_OVLY_OPEN_PARMSA as tagMCI_OVLY_OPEN_PARMSA ptr
type LPMCI_OVLY_OPEN_PARMSA as tagMCI_OVLY_OPEN_PARMSA ptr

type tagMCI_OVLY_OPEN_PARMSW field = 1
	dwCallback as DWORD_PTR
	wDeviceID as MCIDEVICEID
	lpstrDeviceType as LPCWSTR
	lpstrElementName as LPCWSTR
	lpstrAlias as LPCWSTR
	dwStyle as DWORD
	hWndParent as HWND
end type

type MCI_OVLY_OPEN_PARMSW as tagMCI_OVLY_OPEN_PARMSW
type PMCI_OVLY_OPEN_PARMSW as tagMCI_OVLY_OPEN_PARMSW ptr
type LPMCI_OVLY_OPEN_PARMSW as tagMCI_OVLY_OPEN_PARMSW ptr

#ifdef UNICODE
	type MCI_OVLY_OPEN_PARMS as MCI_OVLY_OPEN_PARMSW
	type PMCI_OVLY_OPEN_PARMS as PMCI_OVLY_OPEN_PARMSW
	type LPMCI_OVLY_OPEN_PARMS as LPMCI_OVLY_OPEN_PARMSW
#else
	type MCI_OVLY_OPEN_PARMS as MCI_OVLY_OPEN_PARMSA
	type PMCI_OVLY_OPEN_PARMS as PMCI_OVLY_OPEN_PARMSA
	type LPMCI_OVLY_OPEN_PARMS as LPMCI_OVLY_OPEN_PARMSA
#endif

type tagMCI_OVLY_WINDOW_PARMSA field = 1
	dwCallback as DWORD_PTR
	hWnd as HWND
	nCmdShow as UINT
	lpstrText as LPCSTR
end type

type MCI_OVLY_WINDOW_PARMSA as tagMCI_OVLY_WINDOW_PARMSA
type PMCI_OVLY_WINDOW_PARMSA as tagMCI_OVLY_WINDOW_PARMSA ptr
type LPMCI_OVLY_WINDOW_PARMSA as tagMCI_OVLY_WINDOW_PARMSA ptr

type tagMCI_OVLY_WINDOW_PARMSW field = 1
	dwCallback as DWORD_PTR
	hWnd as HWND
	nCmdShow as UINT
	lpstrText as LPCWSTR
end type

type MCI_OVLY_WINDOW_PARMSW as tagMCI_OVLY_WINDOW_PARMSW
type PMCI_OVLY_WINDOW_PARMSW as tagMCI_OVLY_WINDOW_PARMSW ptr
type LPMCI_OVLY_WINDOW_PARMSW as tagMCI_OVLY_WINDOW_PARMSW ptr

#ifdef UNICODE
	type MCI_OVLY_WINDOW_PARMS as MCI_OVLY_WINDOW_PARMSW
	type PMCI_OVLY_WINDOW_PARMS as PMCI_OVLY_WINDOW_PARMSW
	type LPMCI_OVLY_WINDOW_PARMS as LPMCI_OVLY_WINDOW_PARMSW
#else
	type MCI_OVLY_WINDOW_PARMS as MCI_OVLY_WINDOW_PARMSA
	type PMCI_OVLY_WINDOW_PARMS as PMCI_OVLY_WINDOW_PARMSA
	type LPMCI_OVLY_WINDOW_PARMS as LPMCI_OVLY_WINDOW_PARMSA
#endif

type tagMCI_OVLY_RECT_PARMS field = 1
	dwCallback as DWORD_PTR
	rc as RECT
end type

type MCI_OVLY_RECT_PARMS as tagMCI_OVLY_RECT_PARMS
type PMCI_OVLY_RECT_PARMS as tagMCI_OVLY_RECT_PARMS ptr
type LPMCI_OVLY_RECT_PARMS as tagMCI_OVLY_RECT_PARMS ptr

type tagMCI_OVLY_SAVE_PARMSA field = 1
	dwCallback as DWORD_PTR
	lpfilename as LPCSTR
	rc as RECT
end type

type MCI_OVLY_SAVE_PARMSA as tagMCI_OVLY_SAVE_PARMSA
type PMCI_OVLY_SAVE_PARMSA as tagMCI_OVLY_SAVE_PARMSA ptr
type LPMCI_OVLY_SAVE_PARMSA as tagMCI_OVLY_SAVE_PARMSA ptr

type tagMCI_OVLY_SAVE_PARMSW field = 1
	dwCallback as DWORD_PTR
	lpfilename as LPCWSTR
	rc as RECT
end type

type MCI_OVLY_SAVE_PARMSW as tagMCI_OVLY_SAVE_PARMSW
type PMCI_OVLY_SAVE_PARMSW as tagMCI_OVLY_SAVE_PARMSW ptr
type LPMCI_OVLY_SAVE_PARMSW as tagMCI_OVLY_SAVE_PARMSW ptr

#ifdef UNICODE
	type MCI_OVLY_SAVE_PARMS as MCI_OVLY_SAVE_PARMSW
	type PMCI_OVLY_SAVE_PARMS as PMCI_OVLY_SAVE_PARMSW
	type LPMCI_OVLY_SAVE_PARMS as LPMCI_OVLY_SAVE_PARMSW
#else
	type MCI_OVLY_SAVE_PARMS as MCI_OVLY_SAVE_PARMSA
	type PMCI_OVLY_SAVE_PARMS as PMCI_OVLY_SAVE_PARMSA
	type LPMCI_OVLY_SAVE_PARMS as LPMCI_OVLY_SAVE_PARMSA
#endif

type tagMCI_OVLY_LOAD_PARMSA field = 1
	dwCallback as DWORD_PTR
	lpfilename as LPCSTR
	rc as RECT
end type

type MCI_OVLY_LOAD_PARMSA as tagMCI_OVLY_LOAD_PARMSA
type PMCI_OVLY_LOAD_PARMSA as tagMCI_OVLY_LOAD_PARMSA ptr
type LPMCI_OVLY_LOAD_PARMSA as tagMCI_OVLY_LOAD_PARMSA ptr

type tagMCI_OVLY_LOAD_PARMSW field = 1
	dwCallback as DWORD_PTR
	lpfilename as LPCWSTR
	rc as RECT
end type

type MCI_OVLY_LOAD_PARMSW as tagMCI_OVLY_LOAD_PARMSW
type PMCI_OVLY_LOAD_PARMSW as tagMCI_OVLY_LOAD_PARMSW ptr
type LPMCI_OVLY_LOAD_PARMSW as tagMCI_OVLY_LOAD_PARMSW ptr

#ifdef UNICODE
	type MCI_OVLY_LOAD_PARMS as MCI_OVLY_LOAD_PARMSW
	type PMCI_OVLY_LOAD_PARMS as PMCI_OVLY_LOAD_PARMSW
	type LPMCI_OVLY_LOAD_PARMS as LPMCI_OVLY_LOAD_PARMSW
#else
	type MCI_OVLY_LOAD_PARMS as MCI_OVLY_LOAD_PARMSA
	type PMCI_OVLY_LOAD_PARMS as PMCI_OVLY_LOAD_PARMSA
	type LPMCI_OVLY_LOAD_PARMS as LPMCI_OVLY_LOAD_PARMSA
#endif

const NEWTRANSPARENT = 3
const QUERYROPSUPPORT = 40
const SELECTDIB = 41
#define DIBINDEX(n) MAKELONG((n), &h10FF)

end extern
