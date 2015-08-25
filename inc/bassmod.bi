'' FreeBASIC binding for bassmod20
''
'' based on the C header files:
''   BASSMOD 2.0 C/C++ header file, copyright (c) 1999-2004 Ian Luck.
''   Please report bugs/suggestions/etc... to bassmod@un4seen.com
''
''   See the BASSMOD.CHM/PDF file for more complete documentation 
''
''   The BASSMOD library is free for non-money making use... if you are
''   not charging for the software, then you can use BASS in it for free.
''   A mention in the credits would be nice though!
''
''   This software is provided "as is", without warranty of ANY KIND,
''   either expressed or implied, including but not limited to the implied
''   warranties of merchantability and/or fitness for a particular purpose.
''   The author shall NOT be held liable for ANY damage to you, your
''   computer, or to anyone or anything else, that may result from its use,
''   or misuse. Basically, you use it at YOUR OWN RISK.
''
''   Usage of BASSMOD indicates that you agree to the above conditions.
''
''   You may freely distribute the BASSMOD package as long as NO FEE is
''   charged and all the files remain INTACT AND UNMODIFIED.
''
''   All trademarks and other registered names contained in the BASSMOD
''   package are the property of their respective owners.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "bassmod"

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	#include once "crt/long.bi"
	'' The following symbols have been renamed:
	''     constant TRUE => CTRUE
#elseif defined(__FB_WIN32__)
	#include once "win/wtypes.bi"
#endif

#ifdef __FB_WIN32__
	extern "Windows-MS"
#else
	extern "C"
#endif

#define BASSMOD_H

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	type WORD as ushort
	type DWORD as culong
	type BOOL as long

	#ifndef CTRUE
		const CTRUE = 1
	#endif
	#ifndef TRUE
		const TRUE = 1
	#endif
	#ifndef FALSE
		const FALSE = 0
	#endif
	#define MAKELONG(a, b) cast(DWORD, ((a) and &hffff) or ((b) shl 16))
#endif

type HSYNC as DWORD
const BASS_OK = 0
const BASS_ERROR_MEM = 1
const BASS_ERROR_FILEOPEN = 2
const BASS_ERROR_DRIVER = 3
const BASS_ERROR_HANDLE = 5
const BASS_ERROR_FORMAT = 6
const BASS_ERROR_POSITION = 7
const BASS_ERROR_INIT = 8
const BASS_ERROR_ALREADY = 14
const BASS_ERROR_ILLTYPE = 19
const BASS_ERROR_ILLPARAM = 20
const BASS_ERROR_DEVICE = 23
const BASS_ERROR_NOPLAY = 24
const BASS_ERROR_NOMUSIC = 28
const BASS_ERROR_NOSYNC = 30
const BASS_ERROR_NOTAVAIL = 37
const BASS_ERROR_DECODE = 38
const BASS_ERROR_FILEFORM = 41
const BASS_ERROR_UNKNOWN = -1
const BASS_DEVICE_8BITS = 1
const BASS_DEVICE_MONO = 2
const BASS_DEVICE_NOSYNC = 16
const BASS_MUSIC_RAMP = 1
const BASS_MUSIC_RAMPS = 2
const BASS_MUSIC_LOOP = 4
const BASS_MUSIC_FT2MOD = 16
const BASS_MUSIC_PT1MOD = 32
const BASS_MUSIC_POSRESET = 256
const BASS_MUSIC_SURROUND = 512
const BASS_MUSIC_SURROUND2 = 1024
const BASS_MUSIC_STOPBACK = 2048
const BASS_MUSIC_CALCLEN = 8192
const BASS_MUSIC_NONINTER = 16384
const BASS_MUSIC_NOSAMPLE = &h400000
const BASS_UNICODE = &h80000000
const BASS_SYNC_MUSICPOS = 0
const BASS_SYNC_POS = 0
const BASS_SYNC_MUSICINST = 1
const BASS_SYNC_END = 2
const BASS_SYNC_MUSICFX = 3
const BASS_SYNC_ONETIME = &h80000000
const BASS_ACTIVE_STOPPED = 0
const BASS_ACTIVE_PLAYING = 1
const BASS_ACTIVE_PAUSED = 3

declare function BASSMOD_GetVersion() as DWORD
declare function BASSMOD_ErrorGetCode() as DWORD
declare function BASSMOD_GetDeviceDescription(byval devnum as long) as zstring ptr
declare function BASSMOD_Init(byval device as long, byval freq as DWORD, byval flags as DWORD) as BOOL
declare sub BASSMOD_Free()
declare function BASSMOD_GetCPU() as single
declare function BASSMOD_SetVolume(byval volume as DWORD) as BOOL
declare function BASSMOD_GetVolume() as long
declare function BASSMOD_MusicLoad(byval mem as BOOL, byval file as zstring ptr, byval offset as DWORD, byval length as DWORD, byval flags as DWORD) as BOOL
declare sub BASSMOD_MusicFree()
declare function BASSMOD_MusicGetName() as zstring ptr
declare function BASSMOD_MusicGetLength(byval playlen as BOOL) as DWORD
declare function BASSMOD_MusicPlay() as BOOL
declare function BASSMOD_MusicPlayEx(byval pos as DWORD, byval flags as long, byval reset as BOOL) as BOOL
declare function BASSMOD_MusicDecode(byval buffer as any ptr, byval length as DWORD) as DWORD
declare function BASSMOD_MusicSetAmplify(byval amp as DWORD) as BOOL
declare function BASSMOD_MusicSetPanSep(byval pan as DWORD) as BOOL
declare function BASSMOD_MusicSetPositionScaler(byval scale as DWORD) as BOOL
declare function BASSMOD_MusicSetVolume(byval chanins as DWORD, byval volume as DWORD) as BOOL
declare function BASSMOD_MusicGetVolume(byval chanins as DWORD) as DWORD
declare function BASSMOD_MusicIsActive() as DWORD
declare function BASSMOD_MusicStop() as BOOL
declare function BASSMOD_MusicPause() as BOOL
declare function BASSMOD_MusicSetPosition(byval pos as DWORD) as BOOL
declare function BASSMOD_MusicGetPosition() as DWORD
declare function BASSMOD_MusicSetSync(byval type as DWORD, byval param as DWORD, byval proc as sub(byval handle as HSYNC, byval data as DWORD, byval user as DWORD), byval user as DWORD) as HSYNC
declare function BASSMOD_MusicRemoveSync(byval sync as HSYNC) as BOOL

end extern
